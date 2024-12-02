// import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_task/models/user.dart';

class ProfileService {
  Future<String> uploadImage(XFile image, UserModel? user) async {
    // try {
    //   final storageRef =
    //       FirebaseStorage.instance.ref().child('uploads/${user?.email}.jpg');
    //
    //   // Upload the file
    //   final uploadTask = storageRef.putFile(File(image.path));
    //
    //   // Wait for the upload to complete
    //   final snapshot = await uploadTask.whenComplete(() {});
    //
    //   // Get the file's download URL
    //   final downloadURL = await snapshot.ref.getDownloadURL();
    //
    //   log('downloadedURL: $downloadURL');
    //   return downloadURL;
    // } catch (error) {
    //   rethrow;
    // }
    return '';
  }
}
