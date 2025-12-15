import 'package:file_picker/file_picker.dart';
import 'package:just_audio/just_audio.dart';
import 'package:get/get.dart';
import 'dart:io';

class PlayerController extends GetxController {
  final AudioPlayer player = AudioPlayer();

  var isPlaying = false.obs;
  var progress = 0.0.obs;
  var totalDuration = 1.0.obs;
  var currentFileName = "No song selected".obs; // for UI

  @override
  void onInit() {
    super.onInit();

    player.playerStateStream.listen((state) {
      isPlaying.value = state.playing;
    });

    player.durationStream.listen((d) {
      if (d != null) totalDuration.value = d.inSeconds.toDouble();
    });

    player.positionStream.listen((p) {
      progress.value = p.inSeconds.toDouble();
    });
  }

  // Pick a local audio file
  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );
    if (result != null && result.files.single.path != null) {
      String path = result.files.single.path!;
      await player.setFilePath(path);
      currentFileName.value = File(path).uri.pathSegments.last; // show only file name
      play();
    }
  }

  void play() => player.play();
  void pause() => player.pause();
  void toggle() => isPlaying.value ? pause() : play();
  void seek(double seconds) => player.seek(Duration(seconds: seconds.toInt()));
}
