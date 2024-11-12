import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tes/app/modules/page/profile/controllers/profile_controller.dart';
import 'package:tes/app/modules/page/profile/tambah_alamat_view.dart';

import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class ProfileView extends StatelessWidget {
  final ProfileController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Obx(() => CircleAvatar(
                        radius: 50,
                        backgroundImage: controller.selectedImagePath.value.isEmpty
                            ? NetworkImage(controller.photoUrl.value)
                            : FileImage(File(controller.selectedImagePath.value)) as ImageProvider,
                      )),
                  const SizedBox(height: 8),
                  Obx(() => Text(
                        controller.name.value,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text("Ganti Foto (Kamera)"),
              onTap: () => controller.pickImage(ImageSource.camera),
            ),
            ListTile(
              leading: Icon(Icons.photo),
              title: Text("Ganti Foto (Galeri)"),
              onTap: () => controller.pickImage(ImageSource.gallery),
            ),
            const Divider(color: Colors.grey),

            // Video section
            const SizedBox(height: 16),
            Obx(() {
              if (controller.selectedVideoPath.value.isNotEmpty) {
                return Column(
                  children: [
                    SizedBox(
                      height: 200,
                      child: AspectRatio(
                        aspectRatio: controller.videoPlayerController?.value.aspectRatio ?? 1.0,
                        child: controller.videoPlayerController != null &&
                                controller.videoPlayerController!.value.isInitialized
                            ? VideoPlayer(controller.videoPlayerController!)
                            : Center(child: CircularProgressIndicator()),
                      ),
                    ),
                    VideoProgressIndicator(
                      controller.videoPlayerController!,
                      allowScrubbing: true,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(
                            controller.isVideoPlaying.isTrue ? Icons.pause : Icons.play_arrow,
                          ),
                          onPressed: controller.togglePlayPause,
                        ),
                      ],
                    ),
                  ],
                );
              } else {
                return const Text('No video selected');
              }
            }),
            ListTile(
              leading: Icon(Icons.videocam),
              title: Text("Pilih Video (Kamera)"),
              onTap: () => controller.pickVideo(ImageSource.camera),
            ),
            ListTile(
              leading: Icon(Icons.video_library),
              title: Text("Pilih Video (Galeri)"),
              onTap: () => controller.pickVideo(ImageSource.gallery),
            ),
            const Divider(color: Colors.grey),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text("Ganti Nama"),
              onTap: () {
                // Implementasi ganti nama
              },
            ),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text("Tambah Alamat"),
              onTap: () => Get.to(() => TambahAlamatView()),
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text("Notifications"),
              onTap: () {
                // Implementasi notifikasi
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text("Cart"),
              onTap: () {
                // Implementasi keranjang
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: () {
                controller.logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
