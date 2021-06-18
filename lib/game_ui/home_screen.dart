import 'package:flutter/material.dart';
import 'package:k_tic_tac_toe/game_ui/components/game_button.dart';
import 'package:k_tic_tac_toe/game_ui/game_screen.dart';
import 'package:k_tic_tac_toe/gradient/background_gradient.dart';
import 'package:k_tic_tac_toe/utils/constants.dart';

enum ScreenType {
  player,
  gameType,
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScreenType screenType = ScreenType.player;
  GamePlayerType playerType = GamePlayerType.onePlayer;
  GameBoardType gameBoardType = GameBoardType.threeByThree;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (screenType == ScreenType.gameType) {
          setState(() {
            screenType = ScreenType.player;
          });
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: Stack(
          children: [
            BackgroundGradient(),
            AnimatedSwitcher(
              duration: Duration(milliseconds: 400),
              child: _buildChild(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChild() {
    switch (screenType) {
      case ScreenType.player:
        return _buildPlayerScreen();
      case ScreenType.gameType:
        return _buildGameTypeScreen();
    }
  }

  Widget _buildPlayerScreen() {
    return Center(
      key: Key('screen-one'),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text(
                'K',
                style: TextStyle(color: Colors.white, fontSize: 48.0, fontWeight: FontWeight.bold),
              ),
              Text(
                'Tic Tac Toe',
                style: TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.w300),
              ),
            ],
          ),
          Column(
            children: [
              Opacity(
                opacity: 0,
                child: GameButton(
                  text: '',
                  onTap: () {},
                ),
              ),
              GameButton(
                text: '单人游戏',
                onTap: () {
                  setState(
                    () {
                      playerType = GamePlayerType.onePlayer;
                      screenType = ScreenType.gameType;
                    },
                  );
                },
              ),
              GameButton(
                text: '双人游戏',
                onTap: () {
                  setState(
                    () {
                      playerType = GamePlayerType.twoPlayer;
                      screenType = ScreenType.gameType;
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGameTypeScreen() {
    return Center(
      key: Key('screen-two'),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    'K',
                    style: TextStyle(color: Colors.white, fontSize: 48.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Tic Tac Toe',
                    style: TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.w300),
                  ),
                ],
              ),
              Column(
                children: [
                  GameButton(
                    text: '3x3',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GameScreen(
                            gameBoardType: GameBoardType.threeByThree,
                            gamePlayerType: playerType,
                          ),
                        ),
                      );
                    },
                  ),
                  GameButton(
                    text: '5x5',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GameScreen(
                            gameBoardType: GameBoardType.fiveByFive,
                            gamePlayerType: playerType,
                          ),
                        ),
                      );
                    },
                  ),
                  GameButton(
                    text: '7x7',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GameScreen(
                            gameBoardType: GameBoardType.sevenBySeven,
                            gamePlayerType: playerType,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_outlined,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    screenType = ScreenType.player;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
