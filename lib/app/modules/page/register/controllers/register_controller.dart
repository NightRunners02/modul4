import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class RegisterController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Connectivity _connectivity = Connectivity();
  final box = GetStorage();

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Listener untuk memantau koneksi
    _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> results) {
  print("Listener koneksi aktif. Status koneksi: $results"); // Debug log

  if (results.any((result) => result != ConnectivityResult.none)) {
    print("Koneksi kembali online. Mengunggah data pending...");
    uploadPendingRegisters();
  }   
});
  }

  // Fungsi untuk register pengguna
  Future<void> register(String email, String password) async {
  try {
    isLoading.value = true;
    errorMessage.value = '';

    // Cek koneksi internet
    var connectivityResult = await _connectivity.checkConnectivity();
    print("Status koneksi: $connectivityResult"); // Debug log

    if (connectivityResult == ConnectivityResult.none) {
      print("Tidak ada koneksi. Menyimpan data secara lokal..."); // Debug log
      // Simpan data register ke penyimpanan lokal jika offline
      saveRegisterLocally(email, password);
      Get.snackbar("Saved Locally", "No internet connection. Data saved locally.");
    } else {
      print("Koneksi tersedia. Mengunggah data ke Firebase..."); // Debug log
      // Upload langsung ke Firebase jika ada koneksi
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      Get.snackbar("Success", "Account created successfully!");
    }
  } on FirebaseAuthException catch (e) {
    errorMessage.value = e.message ?? "Unknown error occurred";
    print("Error saat register: $errorMessage"); // Debug log
  } finally {
    isLoading.value = false;
  }
}

  // Simpan data register ke Get Storage
  void saveRegisterLocally(String email, String password) {
  List pendingRegisters = box.read('pending_registers') ?? [];

  // Validasi untuk mencegah duplikasi
  bool isDuplicate = pendingRegisters.any((data) => data['email'] == email);

  if (!isDuplicate) {
    pendingRegisters.add({'email': email, 'password': password});
    box.write('pending_registers', pendingRegisters);
    print("Data tersimpan lokal: $pendingRegisters"); // Debug log
  } else {
    print("Data dengan email $email sudah tersimpan sebelumnya."); // Debug log
  }
}

  // Upload data yang tersimpan secara lokal
  void uploadPendingRegisters() async {
    List pendingRegisters = box.read('pending_registers') ?? [];

    if (pendingRegisters.isNotEmpty) {
      print("Data pending untuk diunggah: $pendingRegisters"); // Debug log
      List uploadedData = [];

      for (var userData in pendingRegisters) {
        try {
          await _auth.createUserWithEmailAndPassword(
            email: userData['email'],
            password: userData['password'],
          );
          uploadedData.add(userData);
          print("Data berhasil diunggah: $userData"); // Debug log
        } catch (e) {
          print("Gagal mengunggah data: $userData. Error: $e"); // Debug log
        }
      }

      // Hapus data yang sudah berhasil diunggah
      pendingRegisters.removeWhere((data) => uploadedData.contains(data));
      box.write('pending_registers', pendingRegisters);

      if (uploadedData.isNotEmpty) {
        Get.snackbar("Upload Complete", "${uploadedData.length} pending registers have been uploaded.");
      }
      if (pendingRegisters.isNotEmpty) {
        Get.snackbar("Pending Data", "${pendingRegisters.length} registers remain pending.");
      }
    } else {
      print("Tidak ada data pending untuk diunggah."); // Debug log
    }
  }
}