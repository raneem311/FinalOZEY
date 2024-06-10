// music_list.dart

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mapfeature_project/models/music.dart';
import 'package:mapfeature_project/views/music_player.dart';

class MyHomePage extends StatelessWidget {
  final List<Music> playlist;

  const MyHomePage({Key? key, required this.playlist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 254, 255, 255),
        centerTitle: true,
        title: const Text(
          'Music Playlist',
          style: TextStyle(
            fontFamily: 'Nunito Sans',
            fontWeight: FontWeight.w900,
            color: Color.fromARGB(255, 68, 65, 65),
            fontSize: 25,
          ),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: ListView.builder(
        itemCount: playlist.length,
        itemBuilder: (context, index) {
          String songName = '';
          String artistName = '';

          // Set specific song names based on index
          if (index == 0) {
            songName = 'Dandelion - Instrumental';
            artistName = 'Muriel Anderson';
          } else if (index == 1) {
            songName = 'AI Petteway';
            artistName = 'Seven Swans';
          } else if (index == 2) {
            songName = 'Mind’s Eye';
            artistName = 'Ananta';
          } else if (index == 3) {
            songName = 'Bright Eyes,';
            artistName = 'Intrinsic Flow';
          } else if (index == 4) {
            songName = 'Morganite';
            artistName = 'Rangitoto';
          } else if (index == 5) {
            songName = 'Blooming';
            artistName = 'AtomFlow';
          } else if (index == 6) {
            songName = 'Cliffside';
            artistName = 'Aurora Beach';
          } else if (index == 7) {
            songName = 'Rise';
            artistName = 'Lunar Skybox';
          } else if (index == 8) {
            songName = 'Night Sky';
            artistName = 'Retrosoft';
          } else if (index == 9) {
            songName = 'Mandala';
            artistName = 'Lhokanda';
          } else if (index == 10) {
            songName = 'Seven Swans';
            artistName = 'Al Petteway';
          } else if (index == 11) {
            songName = 'Mental Health Matters';
            artistName = 'Calm Guitar Music';
          } else if (index == 12) {
            songName = 'Ups and Downs';
            artistName = 'Martin Klem';
          } else if (index == 13) {
            songName = 'Blossoming Tree';
            artistName = 'Wanderer\'s Trove';
          } else if (index == 14) {
            songName = 'Mornings';
            artistName = 'Sebastian Winskog';
          } else if (index == 15) {
            songName = 'Moraira Coast';
            artistName = 'Let It Bloom';
          } else if (index == 16) {
            songName = 'Shapes of Brightness';
            artistName = 'Tales of Vibrations';
          } else if (index == 17) {
            songName = 'I Love You Lord';
            artistName = 'Piano Praises';
          } else if (index == 18) {
            songName = 'Author Of Salvation';
            artistName = 'Piano Praises';
          } else if (index == 19) {
            songName = 'Goldilocks';
            artistName = 'Dreaming Fairy';
          } else if (index == 20) {
            songName = 'Dandelion';
            artistName = 'Elias Bergman';
          } else if (index == 21) {
            songName = 'The Kiss';
            artistName = 'Jacques Blacque';
          } else if (index == 22) {
            songName = 'Rêverie';
            artistName = 'Geert Veneklaas';
          } else if (index == 23) {
            songName = 'Hope';
            artistName = 'Geert Veneklaas';
          } else if (index == 24) {
            songName = 'Locus';
            artistName = 'Sacha Hoedemaker';
          } else if (index == 25) {
            songName = 'Oak Island';
            artistName = 'Emma Jackson';
          } else if (index == 26) {
            songName = 'A Brand New Day';
            artistName = 'Manuel Zito';
          } else if (index == 27) {
            songName = 'House of Cards';
            artistName = 'Daan Duijf';
          } else if (index == 28) {
            songName = 'My Little Spring';
            artistName = 'Leonard Lehmann';
          } else if (index == 29) {
            songName = 'Glance';
            artistName = 'Rasmus H Thomsen';
          } else if (index == 30) {
            songName = 'Shine';
            artistName = 'Rasmus H Thomsen';
          } else if (index == 31) {
            songName = 'Diaphanous';
            artistName = 'Arden Brooks';
          } else if (index == 32) {
            songName = 'Wish';
            artistName = 'Domi Nova';
          } else if (index == 33) {
            songName = 'Shelter Of My Mind';
            artistName = 'Domi Nova';
          } else if (index == 34) {
            songName = 'To Be Loved';
            artistName = 'Day Blue';
          } else if (index == 35) {
            songName = 'Lumenary';
            artistName = 'MettaForm';
          } else if (index == 36) {
            songName = 'Saraband';
            artistName = 'Phillip Lester';
          } else if (index == 37) {
            songName = 'Estudio No. 1';
            artistName = 'William Wilson';
          } else if (index == 38) {
            songName = 'Saraband';
            artistName = 'Phillip Lester';
          } else if (index == 39) {
            songName = 'Forest Creek Tune';
            artistName = 'Lhokanda';
          } else if (index == 40) {
            songName = 'Di Himl';
            artistName = 'Beymer';
          } else if (index == 41) {
            songName = 'Blumen';
            artistName = 'Beymer';
          } else if (index == 42) {
            songName = 'Rebuild';
            artistName = 'Toni Fairbanks';
          } else if (index == 43) {
            songName = 'Lighthouse';
            artistName = 'Time Sphere';
          } else if (index == 44) {
            songName = 'Floating Away';
            artistName = 'Time Sphere';
          } else if (index == 45) {
            songName = 'Calming Waves';
            artistName = 'turquoise waters';
          } else if (index == 46) {
            songName = 'Sacral Chakra Balancer';
            artistName = 'Healing Solfeggio Frequencies';
          } else if (index == 47) {
            songName = 'On Plateau';
            artistName = 'MusicoterapiaTeam';
          } else if (index == 48) {
            songName = 'Estudiar y Meditar - Remastered';
            artistName = 'MusicoterapiaTeam';
          } else if (index == 49) {
            songName = 'Trust Me';
            artistName = 'MusicoterapiaTeam';
          } else if (index == 50) {
            songName = 'Bien-être';
            artistName = 'Yzalune';
          } else if (index == 51) {
            songName = 'Floating Peace';
            artistName = 'MusicoterapiaTeam';
          } else if (index == 52) {
            songName = 'Ethereal Serenade';
            artistName = 'MusicoterapiaTeam';
          } else if (index == 53) {
            songName = 'Geshe';
            artistName = 'Jordan Henderson';
          } else if (index == 54) {
            songName = 'Bardo';
            artistName = 'Jordan Henderson';
          } else if (index == 55) {
            songName = 'Dulce Serenidad';
            artistName = ' Yzalune';
          } else if (index == 56) {
            songName = 'Rêve';
            artistName = ' Yzalune';
          } else if (index == 57) {
            songName = 'Renewal';
            artistName = 'MusicoterapiaTeam';
          } else if (index == 58) {
            songName = 'Estudiar y Meditar - Remastered';
            artistName = 'MusicoterapiaTeam';
          } else if (index == 59) {
            songName = 'Sìth';
            artistName = 'Jordan Henderson';
          } else if (index == 60) {
            songName = 'Geshe';
            artistName = 'Jordan Henderson';
          } else if (index == 61) {
            songName = 'Alaya';
            artistName = 'Jordan Henderson';
          } else if (index == 62) {
            songName = 'Trust Me';
            artistName = 'MusicoterapiaTeam';
          } else if (index == 63) {
            songName = 'Bien-être';
            artistName = 'Yzalune';
          } else if (index == 64) {
            songName = 'Starboy';
            artistName = 'The Weeknd';
          } else if (index == 65) {
            songName = 'YAZMEELY';
            artistName = 'Muhab';
          } else if (index == 66) {
            songName = 'Cut To The Feeling';
            artistName = 'Carly Rae Jepsen';
          } else if (index == 67) {
            songName = 'سورة طه';
            artistName = 'Sherif Mostafa';
          } else if (index == 68) {
            songName = 'سورة النبأ كاملة';
            artistName = 'عبدالرحمن مسعد';
          } else if (index == 69) {
            songName = 'سورة الملك';
            artistName = 'Islam Sobhi';
          } else if (index == 70) {
            songName = 'سورة البقرة';
            artistName = 'Islam Sobhi';
          } else if (index == 71) {
            songName = 'سورة الحجر';
            artistName = 'Hazza Al Blushi';
          } else if (index == 72) {
            songName = 'Surat Al Dukhan';
            artistName = 'Hazza Al Blushi';
          } else if (index == 73) {
            songName = 'Surah Al Kafirun';
            artistName = 'Al Sheikh Abdul Baset Abdul Samad';
          } else if (index == 74) {
            songName = 'Surah Al Humazah';
            artistName = 'Al Sheikh Abdul Baset Abdul Samad';
          } else if (index == 75) {
            songName = 'Surah Al Insyirah';
            artistName = 'Salim Bahanan';
          } else if (index == 76) {
            songName = 'Surah an Naba';
            artistName = 'Salim Bahanan';
          } else if (index == 77) {
            songName = 'Surah Ad Dhuha';
            artistName = 'Salim Bahanan';
          } else if (index == 78) {
            songName = 'Surah an Nas';
            artistName = 'Salim Bahanan';
          } else if (index == 79) {
            songName = 'Surah Al Anbiya';
            artistName = 'Omar Hisham';
          } else if (index == 80) {
            songName = 'Surah Al Moamnon';
            artistName = 'Yasser EL Dossery';
          } else if (index == 81) {
            songName = 'Surah Yasin';
            artistName = 'Meshari Rashid El Afassy';
          }

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MusicPlayer(song: playlist[index]),
                ),
              );
            },
            child: Card(
              elevation: 2,
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              color: Color(0xffC4DEE4), // Set the card color with transparency
              child: ListTile(
                title: Text(
                  songName,
                  style: const TextStyle(
                      fontFamily: 'Nunito Sans',
                      color: Color.fromARGB(255, 51, 52, 53), // Color of the song name text
                      fontSize: 15,
                      fontWeight: FontWeight.w900),
                ),
                subtitle: Text(artistName,
                    style: const TextStyle(
                        fontFamily: 'Nunito Sans', fontSize: 8.5)),
              ),
            ),
          );
        },
      ),
    );
  }
}
