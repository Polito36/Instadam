import 'package:image_picker/image_picker.dart';

class PhotoPicker {
  Future pickPhoto() async {
    final pickPhoto =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    return pickPhoto;
  }
}
