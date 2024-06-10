import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:mapfeature_project/models/music.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:spotify/spotify.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import 'widgets/art_work_image.dart';

class MusicPlayer extends StatefulWidget {
  final Music song; // Update parameter name to 'song'

  const MusicPlayer({Key? key, required this.song}) : super(key: key);

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  final player = AudioPlayer();

  int currentSongIndex = 0;

  List<Music> playlist = [
    Music(trackId: '7MXVkk9YMctZqd1Srtv4MB'), // Add more songs here
    Music(trackId: '3WOiSsqfXPZAtGTr2PFj6S'),
    Music(trackId: '11dFghVXANMlKmJXsNCbNl'),
    Music(trackId: '2vknxlulbj1JApedTlmrZv'),
    Music(trackId: '6GkrhEQYOpCurp8gJWz91H'),
    Music(trackId: '4HXRJ3Bz49FEDeEOfdtUJO'),
    Music(trackId: '5LtHZB7vU02HtNoOzNcVhc'), // Add more songs here
    Music(trackId: '5rCq30EbJ3DfZPKybGZj8F'),
    Music(trackId: '7qLXBcYW78is9LygQBziAU'),
    Music(trackId: '0ECT1q8mtxBE7cCRIeCXO2'),
    Music(trackId: '1ZuHXbFUhAb3SHOn4TzQbW'),
    Music(trackId: '00TO3hVgOAgfKrRjrKEZxx'),
  ];

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  Music? currentSong; // Add a variable to hold the currently selected song
  bool isLoading = false; // Add a loading state variable

  @override
  void initState() {
    currentSong = widget.song;
    loadSong(currentSong!);
    super.initState();
  }

  void loadSong(Music music) async {
    setState(() {
      isLoading = true; // Set loading state to true
    });
    final credentials = SpotifyApiCredentials(
        'e9eb2816d1944d4d82a595c4d0380b17', '405cb15f21a0431ca584f94a8de45e47');
    final spotify = SpotifyApi(credentials);
    spotify.tracks.get(music.trackId).then((track) async {
      String? tempSongName = track.name;
      if (tempSongName != null) {
        music.songName = tempSongName;
        music.artistName = track.artists?.first.name ?? "";
        String? image = track.album?.images?.first.url;
        if (image != null) {
          music.songImage = image;
          final tempSongColor = await getImagePalette(NetworkImage(image));
          if (tempSongColor != null) {
            music.songColor = tempSongColor;
          }
        }
        music.artistImage = track.artists?.first.images?.first.url;
        final yt = YoutubeExplode();
        final video =
            (await yt.search.search("$tempSongName ${music.artistName ?? ""}"))
                .first;
        final videoId = video.id.value;
        music.duration = video.duration;
        setState(() {
          isLoading =
              false; // Set loading state to false when song information is loaded
        });
        var manifest = await yt.videos.streamsClient.getManifest(videoId);
        var audioUrl = manifest.audioOnly.last.url;
        player.play(UrlSource(audioUrl.toString()));
      }
    });
  }

  Future<Color?> getImagePalette(ImageProvider imageProvider) async {
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(imageProvider);
    return paletteGenerator.dominantColor?.color;
  }

  void switchSong(int index) {
    if (index >= 0 && index < playlist.length) {
      currentSong = playlist[index]; // Update the current song
      player.stop();
      loadSong(currentSong!); // Load the newly selected song
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
        backgroundColor: currentSong!.songColor,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Expanded(
                flex: 2,
                child: isLoading
                    ? const Center(
                        child:
                            CircularProgressIndicator()) // Show loading indicator if loading
                    : Center(
                        child: ArtWorkImage(image: currentSong!.songImage)),
              ),
              Expanded(
                child: Column(
                  children: [
                    // Display song information when not loading
                    if (!isLoading)
                      Column(
                        children: [
                          Text(
                            currentSong!.songName ?? '',
                            style: textTheme.titleLarge
                                ?.copyWith(color: Colors.white),
                          ),
                          Text(
                            currentSong!.artistName ?? '-',
                            style: textTheme.titleMedium
                                ?.copyWith(color: Colors.white60),
                          ),
                        ],
                      ),
                    // Add ProgressBar and other UI elements as needed
                    StreamBuilder(
                        stream: player.onPositionChanged,
                        builder: (context, data) {
                          return ProgressBar(
                            progress: data.data ?? const Duration(seconds: 0),
                            total: playlist[currentSongIndex].duration ??
                                const Duration(minutes: 4),
                            bufferedBarColor: Colors.white38,
                            baseBarColor: Colors.white10,
                            thumbColor: Colors.white,
                            timeLabelTextStyle:
                                const TextStyle(color: Colors.white),
                            progressBarColor: Colors.white,
                            onSeek: (duration) {
                              player.seek(duration);
                            },
                          );
                        }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                            switchSong(currentSongIndex - 1);
                          },
                          icon: const Icon(Icons.skip_previous,
                              color: Colors.white, size: 36),
                        ),
                        IconButton(
                          onPressed: () {
                            if (player.state == PlayerState.playing) {
                              player.pause();
                            } else {
                              player.resume();
                            }
                            setState(() {});
                          },
                          icon: Icon(
                            player.state == PlayerState.playing
                                ? Icons.pause
                                : Icons.play_circle,
                            color: Colors.white,
                            size: 60,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            switchSong(currentSongIndex + 1);
                          },
                          icon: const Icon(Icons.skip_next,
                              color: Colors.white, size: 36),
                        ),
                      ], //Childre
                    ), //Row
                  ],
                ),
              ),
            ],
          ),
        )));
  }
}
