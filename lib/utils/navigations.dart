import 'package:flutter/material.dart';

Future<void> navigationPush(BuildContext context, Widget destination,
    {String? name}) {
  return Navigator.push(
    context,
    MaterialPageRoute<void>(builder: (_) => destination),
  );
}

Future<void> navigationPushReplaceActual(
    BuildContext context, Widget destination,
    {String? name}) {
  return Navigator.pushReplacement(
    context,
    MaterialPageRoute<void>(builder: (_) => destination),
  );
}

void pop<T>(BuildContext context, {T? result}) {
  return Navigator.pop<T>(context, result);
}

Future<void> navigationPushReplaceAll(BuildContext context, Widget destination,
    {String? name}) {
  return Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute<void>(builder: (_) => destination),
    (Route<dynamic> route) => false,
  );
}
