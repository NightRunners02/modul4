import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/coffe_mocha_controller.dart';

class CoffeMochaView extends GetView<CoffeMochaController> {
  const CoffeMochaView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CoffeMochaView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CoffeMochaView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
