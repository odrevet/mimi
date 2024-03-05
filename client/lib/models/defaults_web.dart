int getDefaultPort() {
  return int.parse(web.window.location.port);
}

String getDefaultAddress() {
  String url = web.window.location.href;
  return Uri.parse(url).host;
}