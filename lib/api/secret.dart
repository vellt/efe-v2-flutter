//használom
const assetsBaseUrl = 'https://d31xcz200zq3ks.cloudfront.net';

//api mindegyik ezzel kezdődik
const apiBaseUrl = 'https://core-api-static.dkefe.com/api/en/level';

//könyvek
const apiBooksUrl = '$apiBaseUrl/index.json';

String getFullURLFromBookRoute(String book) => '$apiBaseUrl/$book/index.json';
