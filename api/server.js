// API local del Directorio de Negocios de Dolores Hidalgo.
// Sin dependencias: solo el módulo http de Node.   Uso: node server.js
const http = require('http');
 
let siguienteId = 6;
const negocios = [
  { id: 1, nombre: 'Nieves de la Plaza', categoria: 'Nevería', telefono: '418-100-0001', favorito: true },
  { id: 2, nombre: 'Talavera La Esperanza', categoria: 'Artesanías', telefono: '418-100-0002', favorito: false },
  { id: 3, nombre: 'Tacos Don Chema', categoria: 'Comida', telefono: '418-100-0003', favorito: false },
  { id: 4, nombre: 'Dulces Cajeta Real', categoria: 'Dulcería', telefono: '418-100-0004', favorito: true },
  { id: 5, nombre: 'Papelería El Cura', categoria: 'Papelería', telefono: '418-100-0005', favorito: false },
];
 
function responder(res, status, datos) {
  res.writeHead(status, {
    'Content-Type': 'application/json; charset=utf-8',
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET,POST,PUT,DELETE,OPTIONS',
    'Access-Control-Allow-Headers': 'Content-Type',
  });
  res.end(datos === undefined ? '' : JSON.stringify(datos));
}
 
function leerCuerpo(req) {
  return new Promise((ok, fallo) => {
    let texto = '';
    req.on('data', (t) => (texto += t));
    req.on('end', () => {
      try { ok(texto ? JSON.parse(texto) : {}); } catch (e) { fallo(e); }
    });
  });
}
 
const servidor = http.createServer(async (req, res) => {
  const url = new URL(req.url, 'http://localhost');
  const partes = url.pathname.split('/').filter(Boolean); // ['negocios', '3']
  console.log(new Date().toLocaleTimeString(), req.method, url.pathname);
 
  if (req.method === 'OPTIONS') return responder(res, 204);
  if (url.pathname === '/salud') return responder(res, 200, { ok: true });
  if (partes[0] !== 'negocios') return responder(res, 404, { error: 'Ruta no encontrada' });
 
  const id = partes[1] ? Number(partes[1]) : null;
  try {
    if (req.method === 'GET' && id === null) {
      const q = (url.searchParams.get('q') || '').toLowerCase();
      return responder(res, 200, negocios.filter((n) => n.nombre.toLowerCase().includes(q)));
    }
    if (req.method === 'GET') {
      const n = negocios.find((x) => x.id === id);
      return n ? responder(res, 200, n) : responder(res, 404, { error: 'No existe' });
    }
    if (req.method === 'POST') {
      const d = await leerCuerpo(req);
      if (!d.nombre || !d.categoria) return responder(res, 400, { error: 'nombre y categoria son obligatorios' });
      const nuevo = { id: siguienteId++, nombre: d.nombre, categoria: d.categoria, telefono: d.telefono || '', favorito: !!d.favorito };
      negocios.push(nuevo);
      return responder(res, 201, nuevo);
    }
    if (req.method === 'PUT') {
      const i = negocios.findIndex((x) => x.id === id);
      if (i < 0) return responder(res, 404, { error: 'No existe' });
      const d = await leerCuerpo(req);
      negocios[i] = { ...negocios[i], ...d, id };
      return responder(res, 200, negocios[i]);
    }
    if (req.method === 'DELETE') {
      const i = negocios.findIndex((x) => x.id === id);
      if (i < 0) return responder(res, 404, { error: 'No existe' });
      negocios.splice(i, 1);
      return responder(res, 204);
    }
    return responder(res, 405, { error: 'Método no permitido' });
  } catch (e) {
    return responder(res, 400, { error: 'JSON inválido' });
  }
});
 
const PUERTO = process.env.PORT || 3000;
// 0.0.0.0 permite que el celular (misma red Wi-Fi) llegue a tu computadora.
servidor.listen(PUERTO, '0.0.0.0', () =>
  console.log(`API lista en http://localhost:${PUERTO}/negocios`));
