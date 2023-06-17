---
title: Android - HTTP
layout: default
icon: android.png
---
# HTTP
## Acquisition de données depuis Internet par l'utilisation de requêtes HTTP
### Déclarer la permission ds le manifest
```xml
<uses-permission android:name="android.permission.INTERNET" />
```

### Téléchargement
```java
try {
    URL url = new URL(urlString);
    HttpURLConnection connection = (HttpURLConnection) url.openConnection();
    InputStream stream = connection.getInputStream();
}
catch (Exception ex) {     // Exception management to handle any error that can occur during http request
    throw new RuntimeException(ex);
}
```