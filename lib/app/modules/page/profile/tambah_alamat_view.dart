import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tes/app/modules/page/profile/controllers/profile_controller.dart'; // Import your new page




class TambahAlamatView extends StatelessWidget {
  final ProfileController controller = Get.find();
  final TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Alamat'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _addressController,
              decoration: const InputDecoration(
                hintText: "Masukkan alamat baru",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              controller.addAddress(_addressController.text);
              _addressController.clear();
            },
            child: const Text('Tambah Alamat'),
          ),
          Expanded(
            child: Obx(() => ListView.builder(
                  itemCount: controller.addresses.length,
                  itemBuilder: (context, index) {
                    final address = controller.addresses[index];
                    return ListTile(
                      title: Text(address.address),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              _addressController.text = address.address;
                              _showEditDialog(context, address.id);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              controller.deleteAddress(address.id);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                )),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk menampilkan dialog edit alamat
  void _showEditDialog(BuildContext context, String addressId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Alamat"),
          content: TextField(
            controller: _addressController,
            decoration: InputDecoration(hintText: "Edit alamat"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                controller.updateAddress(addressId, _addressController.text);
                _addressController.clear();
                Get.back();
              },
              child: Text("Update"),
            ),
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }
}
