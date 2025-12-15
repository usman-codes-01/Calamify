import 'package:just_audio/just_audio.dart';

class AudioService {
  final AudioPlayer player = AudioPlayer();

  Future<void> play(String url) async {
    await player.setUrl(url);
    player.play();
  }

  void pause() => player.pause();
  void resume() => player.play();
  void stop() => player.stop();

  Stream<Duration> get positionStream => player.positionStream;
  Stream<PlayerState> get stateStream => player.playerStateStream;

  Future<void> seek(double seconds) async {
    await player.seek(Duration(seconds: seconds.toInt()));
  }
}
