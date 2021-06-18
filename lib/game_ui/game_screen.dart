import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:k_tic_tac_toe/game/tic_tac_toe.dart';
import 'package:k_tic_tac_toe/gradient/background_gradient.dart';
import 'package:k_tic_tac_toe/r.dart';
import 'package:k_tic_tac_toe/utils/constants.dart';
import 'package:rive_loading/rive_loading.dart';

import 'components/game_board.dart';

class GameScreen extends StatefulWidget {
  final GamePlayerType gamePlayerType;
  final GameBoardType gameBoardType;

  GameScreen({
    required this.gamePlayerType,
    required this.gameBoardType,
  });

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late TicTacToe game;
  bool enablePowers = false;

  @override
  void initState() {
    game = TicTacToe(gameBoardType: widget.gameBoardType);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundGradient(
            bgOpacity: 0.1,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment:
                    widget.gamePlayerType == GamePlayerType.twoPlayer ? MainAxisAlignment.end : MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Text(
                      (widget.gamePlayerType == GamePlayerType.twoPlayer ? 'Player 2' : '机器人') +
                          '${game.gameWinner == TurnOf.player2 ? ' Wins' : ''}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GameBoard(
                  game: game,
                  gameBoardType: widget.gameBoardType,
                  gamePlayerType: widget.gamePlayerType,
                  elementColor: Colors.white.withOpacity(0.8),
                  thickness: 4.0,
                  onResult: () {
                    _showDialog();
                    setState(() {});
                  },
                  enablePowers: enablePowers,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Player 1' + '${game.gameWinner == TurnOf.player1 ? ' Wins' : ''}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          game.resetBoard();
                        });
                      },
                      style: ButtonStyle(),
                      child: Text(
                        '重置',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.cancel,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  if (widget.gamePlayerType == GamePlayerType.twoPlayer)
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            enablePowers = !enablePowers;
                          });
                        },
                        style: ButtonStyle(),
                        child: Text(
                          'Powers模式: ${enablePowers ? 'On' : 'Off'}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.0,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 160,
                child: Stack(
                  children: [
                    Container(
                      child: RiveLoading(
                        name: R.assetsRiveCheckpointUi,
                        startAnimation: 'checkpoint',
                        fit: BoxFit.cover,
                        onError: (error, stacktrace) {},
                        onSuccess: (data) {},
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(4.0)),
                      ),
                    ),
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0, end: 800),
                      duration: Duration(milliseconds: 800),
                      builder: (context, value, child) => Opacity(
                        opacity: max(0, ((value - 600) / 200)),
                        child: child,
                      ),
                      child: Center(
                        child: Text(
                          _buildDialogContent(),
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    child: Text('取消'),
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                    },
                  ),
                  TextButton(
                    child: Text('再来一次'),
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                      setState(() {
                        game.resetBoard();
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  String _buildDialogContent() {
    if (game.gameWinner == null) {
      return '平局';
    }
    if (widget.gamePlayerType == GamePlayerType.onePlayer) {
      return game.gameWinner == TurnOf.player1 ? '你胜利了！' : '失败是成功之母';
    } else {
      return game.gameWinner == TurnOf.player1 ? 'Player 1 胜利！' : 'Player 2 胜利！';
    }
  }
}
