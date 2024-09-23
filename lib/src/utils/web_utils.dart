import 'dart:js' as js;

import 'package:flutter/foundation.dart';

bool isPWAInstalled() {
  return js.context.callMethod(
          'eval', ["window.matchMedia('(display-mode: standalone)').matches"])
      as bool;
}

const webVideoCacheKey = 'web-video-cache';
void cacheWebVideo(String videoUrl) {
  final cache = js.context['caches'];
  cache.callMethod('open', [webVideoCacheKey]).then((cache) {
    cache.callMethod('add', [videoUrl]);
  });
}

bool requestPersistentStorage() {
  var granted = js.context['navigator']
      .callMethod('storage')
      .callMethod('persist')
      .then((granted) {
    if (granted) {
      print('Persistent storage granted');
    } else {
      print('Persistent storage not granted');
    }
    return granted;
  });
  debugPrint('Persistent storage granted: $granted');
  return granted;
}

/// TODO
/// You need something like this in index.html
/// function initializeBackgroundFetch() {
//     self.addEventListener('backgroundfetchsuccess', (event) => {
//         const bgFetch = event.registration;
//         event.waitUntil(async function() {
//             const records = await bgFetch.matchAll();
//             const cache = await caches.open('video-cache');
//             await Promise.all(records.map(async (record) => {
//                 const response = await record.responseReady;
//                 await cache.put(record.request, response);
//             }));
//             console.log('background fetch success');//TODO
//         }());
//     });
//
//     self.addEventListener('backgroundfetchfail', (event) => {
//         console.log('backgroundfetchfail');//TODO
//     });
//
//     self.addEventListener('backgroundfetchabort', (event) => {
//         console.log('backgroundfetchabort');//TODO
//     });
// }
void startBackgroundFetch(String videoUrl, String videoId) {
  final options = js.JsObject.jsify({
    'title': 'Downloading video',
    'icons': [
      {'sizes': '192x192', 'src': 'icon.png', 'type': 'image/png'}
    ],
    'downloadTotal': 100000000, // Example size in bytes
  });

  js.context['navigator']
      .callMethod('serviceWorker')
      .callMethod('ready')
      .then((registration) {
    registration.callMethod('backgroundFetch', [
      videoId, // Unique identifier
      [videoUrl], // Array of URLs to fetch
      options
    ]);
  });
}
