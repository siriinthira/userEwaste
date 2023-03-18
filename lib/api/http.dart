import "dart:convert";

import "package:get/get_connect/http/src/request/request.dart";
import "package:http/http.dart" as http;

class RequestResult {
  bool? ok;
  dynamic data;
  RequestResult(this.ok, this.data);
}

const PROTOCOL = "http";
const DOMAIN = "192.168.1.5";

Future<RequestResult> http_get(String route, [dynamic data]) async {
  var dataStr = jsonEncode(data);
  var url = "$PROTOCOL://$DOMAIN/$route?data=$dataStr";
  var result = await http.get(url as Uri);
  return RequestResult(true, jsonDecode(result.body));
}

Future<RequestResult> http_post(String route, [dynamic data]) async {
  var dataStr = jsonEncode(data);
  var url = "$PROTOCOL://$DOMAIN/$route?data=$dataStr";
  var result = await http.get(url as Uri);
  return RequestResult(true, jsonDecode(result.body));
}
