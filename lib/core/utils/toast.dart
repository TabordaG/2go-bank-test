import 'package:flutter/material.dart';
import 'package:get/get.dart';

toastError({required String? message, int? seconds}) {
  Get.rawSnackbar(
    backgroundColor: Colors.red,
    message: message ?? 'Não foi possível realizar essa ação!',
    duration: Duration(seconds: seconds ?? 3),
  );
}

toastSuccess({required String message}) {
  Get.rawSnackbar(
    backgroundColor: Colors.green,
    message: message,
    duration: const Duration(seconds: 3),
  );
}
