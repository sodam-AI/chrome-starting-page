const CACHE = 'dashboard-v73';
const PRECACHE = ['/', '/style.css', '/script.js', '/manifest.webmanifest'];

self.addEventListener('install', e => {
    e.waitUntil(
        caches.open(CACHE)
            .then(c => c.addAll(PRECACHE))
            .then(() => self.skipWaiting())
    );
});

self.addEventListener('activate', e => {
    e.waitUntil(
        caches.keys()
            .then(keys => Promise.all(keys.filter(k => k !== CACHE).map(k => caches.delete(k))))
            .then(() => self.clients.claim())
            .then(() => {
                // Notify all clients that a new version is active
                self.clients.matchAll().then(clients => {
                    clients.forEach(client => client.postMessage({ type: 'SW_UPDATED', version: CACHE }));
                });
            })
    );
});

self.addEventListener('fetch', e => {
    // Never cache API calls or server health checks
    if (e.request.url.includes('/api/')) return;
    e.respondWith(
        fetch(e.request).then(r => {
            if (r.ok) {
                const c = r.clone();
                caches.open(CACHE).then(cache => cache.put(e.request, c));
            }
            return r;
        }).catch(() => caches.match(e.request))
    );
});
