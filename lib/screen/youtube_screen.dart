import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
class YoutubeScreen extends StatefulWidget {
  const YoutubeScreen({super.key});

  @override
  State<YoutubeScreen> createState() => _YoutubeScreenState();
}

class _YoutubeScreenState extends State<YoutubeScreen> {
  TextEditingController controller = TextEditingController();

  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: "iLnmTe5Q2Qw",
    flags: YoutubePlayerFlags(
      autoPlay: false,
      mute: true,
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Youtube")),
      body: Column(
        children: [
          TextField(
              controller: controller,
              onSubmitted: (value){
                controller.text = YoutubePlayer.convertUrlToId(value).toString();
                print(controller.text);
              },
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.type_specimen_outlined),
                hintText: "Link youtube"
              ),
            ),
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,

            // videoProgressIndicatorColor: Colors.amber,
            // progressColors: ProgressColors(
            //   playedColor: Colors.amber,
            //   handleColor: Colors.amberAccent,
            // ),
            progressColors: ProgressBarColors(handleColor: Colors.amber,),

            // onReady () {
            //   _controller.addListener(listener);
            //   },
          ),
        ],
      ),
    );
  }
}
