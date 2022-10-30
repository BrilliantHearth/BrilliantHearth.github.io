'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "392e40595e4d0ace7a342b09f9d83e33",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "4e6447691c9509f7acdbf8a931a85ca1",
"assets/images/amethyst_image.jpg": "20d0afd5c6e7db820cc8332015dc944f",
"assets/images/amethyst_image_mobile.jpg": "d04230b3210d2bd29f191e6eda9679ae",
"assets/images/backgrounds/black_background.jpg": "686ae9c13e8cae054e55c05da0d72eb1",
"assets/images/backgrounds/dark_greenery_background_horz_wide.jpg": "d8a153ff6b0c802391c53fa2b3276d66",
"assets/images/backgrounds/sage_herbs_background_dark.png": "c4b0d4e1de1fe84914d2656be0b9edcf",
"assets/images/BHAppBarLogo.png": "c2417107887319b658da59bc0fb36ac0",
"assets/images/celestial_assets/celestial_sun.png": "d6cdf10831f88db1920c4d375340a4a0",
"assets/images/celestial_assets/hand_moon.png": "d00d2fa689a4846e7915665ce5b4ec90",
"assets/images/CenterLogo.png": "5c5970800f10af46f27525d990f3e285",
"assets/images/corner_splash.png": "66ec0dcd3307e08a96a4f399324e2383",
"assets/images/list_view_images/acquisitions.jpg": "e35f47ee397d35549cd9cdb072fae92a",
"assets/images/list_view_images/candles.jpg": "c8e5979e1cf5d2f4e28b99054c8f03b0",
"assets/images/list_view_images/carvings.jpg": "3a6733fcc219b78e9a0b063b151ba5cf",
"assets/images/list_view_images/crystal_points.jpg": "eabdf07748ea1e0664b6f06be7a414b8",
"assets/images/list_view_images/custom_orders.jpg": "0488261557cb770099dfda32c5061aa4",
"assets/images/list_view_images/hand_picked.jpg": "e979a9555f6dbcdaac81b6e1c2278cd2",
"assets/images/list_view_images/jewelry.jpg": "731d7210ae428da15db14673907d80cd",
"assets/images/list_view_images/spheres.jpg": "177636b0972aed137a7e5690494d15f9",
"assets/images/list_view_images/water_bottles.jpg": "7e36319373bd25300e57218053a31b0b",
"assets/images/social_media_assets/etsy_64px.png": "d86d49bcb716054ef1ad9ec426453508",
"assets/images/social_media_assets/facebook_64px.png": "bc9c05e1feec560da70124bbba418c11",
"assets/images/social_media_assets/insta_64px.png": "4335c74dfd4b360d013a2e3a70157caf",
"assets/images/social_media_assets/tiktok_64px.png": "1f9151ff135f1379ecea386d264d77fa",
"assets/NOTICES": "c1cc35a1d500a5f0e772c84d12590dbb",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"canvaskit/canvaskit.js": "62b9906717d7215a6ff4cc24efbd1b5c",
"canvaskit/canvaskit.wasm": "b179ba02b7a9f61ebc108f82c5a1ecdb",
"canvaskit/profiling/canvaskit.js": "3783918f48ef691e230156c251169480",
"canvaskit/profiling/canvaskit.wasm": "6d1b0fc1ec88c3110db88caa3393c580",
"CNAME": "0b3e1c0ce7de3c70651b6d997db45887",
"favicon.ico": "a186dd18bdda1b68fbd685152a110b57",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "ad80541da8fd632422372df8b1af4e16",
"/": "ad80541da8fd632422372df8b1af4e16",
"main.dart.js": "f55581ede3dcf62a4327ab9fa7428c5c",
"manifest.json": "e32771e3fc75e5853c8859f9872e0354",
"version.json": "4e382ddf9b25c560bacade95b920486f"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
