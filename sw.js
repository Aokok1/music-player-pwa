const CACHE_NAME = 'musicplayer-v1';

self.addEventListener('install', (e) => {
  self.skipWaiting();
});

self.addEventListener('activate', (e) => {
  e.waitUntil(clients.claim());
});

// Network-first strategy for API, cache music files
self.addEventListener('fetch', (e) => {
  const url = new URL(e.request.url);
  
  // Cache audio files forever
  if (url.pathname.endsWith('.mp3') || url.pathname.endsWith('.m4a')) {
    e.respondWith(cacheFirst(e.request));
    return;
  }
  
  // Network first for API
  if (url.hostname.includes('jamendo.com')) {
    e.respondWith(networkFirst(e.request));
    return;
  }
  
  // Default: network first
  e.respondWith(networkFirst(e.request));
});

async function cacheFirst(request) {
  const cache = await caches.open(CACHE_NAME);
  const cached = await cache.match(request);
  if (cached) return cached;
  
  try {
    const response = await fetch(request);
    if (response.ok) {
      cache.put(request, response.clone());
    }
    return response;
  } catch (e) {
    return new Response('', { status: 408 });
  }
}

async function networkFirst(request) {
  try {
    const response = await fetch(request);
    if (response.ok) {
      const cache = await caches.open(CACHE_NAME);
      cache.put(request, response.clone());
    }
    return response;
  } catch (e) {
    const cached = await caches.open(CACHE_NAME).then(c => c.match(request));
    return cached || new Response('', { status: 408 });
  }
}
