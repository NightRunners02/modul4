import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:tes/app/modules/page/profile/address.dart';

class ProfileController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ImagePicker _picker = ImagePicker(); // Image picker instance
  final box = GetStorage(); // Local storage instance

  var addresses = <Address>[].obs;
  var name = "Khairy Zhafran".obs;
  var photoUrl = "".obs;
  var selectedImagePath = ''.obs; // Store image path
  var isImageLoading = false.obs; // Image loading state

  var selectedVideoPath = ''.obs; // Store video path
  var isVideoPlaying = false.obs; // Video play/pause state
  VideoPlayerController? videoPlayerController;

  @override
  void onInit() {
    super.onInit();
    fetchAddresses();
    _loadStoredData(); // Load stored image/video data on initialization
  }

  @override
  void onClose() {
    videoPlayerController?.dispose();
    super.onClose();
  }

  // Fetch addresses from Firestore
  void fetchAddresses() async {
    final snapshot = await _firestore.collection('addresses').get();
    addresses.value = snapshot.docs
        .map((doc) => Address.fromJson(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  // Add new address
  Future<void> addAddress(String newAddress) async {
    final Timestamp createdAt = Timestamp.now();
    final docRef = await _firestore.collection('addresses').add({
      'address': newAddress,
      'createdAt': createdAt,
    });
    addresses.add(Address(id: docRef.id, address: newAddress, createdAt: createdAt));
  }

  // Update address
  Future<void> updateAddress(String id, String updatedAddress) async {
    await _firestore.collection('addresses').doc(id).update({'address': updatedAddress});
    addresses[addresses.indexWhere((addr) => addr.id == id)] = Address(
      id: id,
      address: updatedAddress,
      createdAt: addresses.firstWhere((addr) => addr.id == id).createdAt,
    );
  }

  // Delete address
  Future<void> deleteAddress(String id) async {
    await _firestore.collection('addresses').doc(id).delete();
    addresses.removeWhere((addr) => addr.id == id);
  }

  // Logout function
  void logout() {
    Get.offAllNamed('/login');
  }

  // Pick an image from camera or gallery
  Future<void> pickImage(ImageSource source) async {
    try {
      isImageLoading.value = true;
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        selectedImagePath.value = pickedFile.path;
        box.write('imagePath', pickedFile.path); // Save image path locally
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print('Error picking image: $e');
    } finally {
      isImageLoading.value = false;
    }
  }

  // Pick a video from camera or gallery
  Future<void> pickVideo(ImageSource source) async {
    try {
      isImageLoading.value = true;
      final XFile? pickedFile = await _picker.pickVideo(source: source);
      if (pickedFile != null) {
        selectedVideoPath.value = pickedFile.path;
        box.write('videoPath', pickedFile.path);

        // Initialize VideoPlayerController
        videoPlayerController = VideoPlayerController.file(File(pickedFile.path))
          ..initialize().then((_) {
            videoPlayerController!.play();
            isVideoPlaying.value = true;
            update();
          });
      } else {
        print('No video selected.');
      }
    } catch (e) {
      print('Error picking video: $e');
    } finally {
      isImageLoading.value = false;
    }
  }

  // Load stored image and video data
  void _loadStoredData() {
    selectedImagePath.value = box.read('imagePath') ?? '';
    selectedVideoPath.value = box.read('videoPath') ?? '';

    if (selectedVideoPath.value.isNotEmpty) {
      videoPlayerController = VideoPlayerController.file(File(selectedVideoPath.value))
        ..initialize().then((_) {
          videoPlayerController!.play();
        });
    }
  }

  // Play video
  void play() {
    videoPlayerController?.play();
    isVideoPlaying.value = true;
    update();
  }

  // Pause video
  void pause() {
    videoPlayerController?.pause();
    isVideoPlaying.value = false;
    update();
  }

  // Toggle play/pause
  void togglePlayPause() {
    if (videoPlayerController != null) {
      if (videoPlayerController!.value.isPlaying) {
        videoPlayerController!.pause();
        isVideoPlaying.value = false;
      } else {
        videoPlayerController!.play();
        isVideoPlaying.value = true;
      }
      update();
    }
  }
}
