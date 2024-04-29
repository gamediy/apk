import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoCock extends StatefulWidget {
  //https://nico-android-apk.oss-cn-beijing.aliyuncs.com/landscape.mp4

  @override
  _ChewieVideoWidget1State createState() => _ChewieVideoWidget1State();
}

class _ChewieVideoWidget1State extends State<VideoCock> {
  late VideoPlayerController _controller;
  var isPlay = false;
  var isSuccess = false;

  Duration? latestPosition;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://live.cloudflaregateway.com/live/playlist.m3u8') // HLS streams are often served with .m3u8 extension
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized.
        setState(() {
          _controller.pause();
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return video();
  }

  Widget video() {
    return Stack(
      children: [
        Positioned(
            child: AspectRatio(
                aspectRatio: 16.0 / 9.0,
                child: VideoPlayer(_controller))),
        Positioned(
            top: 0,
            right: 0,
            left: 0,

            child: Container(
          height: 20,
          color: Colors.red,
        )),
        if (!isSuccess)
          Positioned.fill(
            child: Container(
              color: Colors.transparent, // Make the overlay transparent
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.purpleAccent,
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.all(16),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isPlay = !isPlay;
                        if (isPlay) {
                          isSuccess = false;
                          _controller.initialize().then((value) {
                            setState(() {
                              print("is success");
                              isSuccess = true;
                            });

                            _controller.play();
                          });
                        } else {
                          _controller.pause();
                        }
                      });
                    },
                    child: getStatus(),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget getStatus() {
    if (isPlay) {
      if (!isSuccess) {
        return CircularProgressIndicator();
      }
      return Icon(
        Icons.pause,
        size: 50,
        color: Colors.white,
      );
    }

    return Icon(
      Icons.play_arrow,
      size: 50,
      color: Colors.white,
    );
  }
}
