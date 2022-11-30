import 'dart:math';

import 'package:flutter/material.dart';
import 'package:game_2048/constants.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    ),
  );
}

class Box extends StatelessWidget {
  final int value;
  const Box({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height:
          (screenWidth - 30 - (screenWidth * .02 * GameController.gameSize)) /
              GameController.gameSize,
      width:
          (screenWidth - 30 - (screenWidth * .02 * GameController.gameSize)) /
              GameController.gameSize,
      color: colors[value],
      child: Center(
        child: Text(
          '${value == 0 ? '' : value}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: GameController.gameSize > 4 && value >= 128 ? 20 : 35,
            color: value <= GameController.gameHero * 2
                ? const Color(0xFF776e65)
                : white,
          ),
        ),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Center(
              child: Text(
                'Welcome to\n2520',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Column(
              children: [
                Column(
                  children: [
                    const Text(
                      'Game Hero',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios,
                          ),
                          onPressed: () {
                            setState(() {
                              if (GameController.gameHero > 2) {
                                GameController.gameHero--;
                              }
                            });
                          },
                        ),
                        Text(
                          '${GameController.gameHero}',
                          style: const TextStyle(
                            fontSize: 45.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                          ),
                          onPressed: () {
                            setState(() {
                              if (GameController.gameHero < 10) {
                                GameController.gameHero++;
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    const Text(
                      'Game Size',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios,
                          ),
                          onPressed: () {
                            setState(() {
                              if (GameController.gameSize > 3) {
                                GameController.gameSize--;
                              }
                            });
                          },
                        ),
                        Text(
                          '${GameController.gameSize} x ${GameController.gameSize}',
                          style: const TextStyle(
                            fontSize: 45.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                          ),
                          onPressed: () {
                            setState(() {
                              if (GameController.gameSize < 6) {
                                GameController.gameSize++;
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Game2520()));
              },
              child: Container(
                height: 60.0,
                width: 60.0,
                padding: const EdgeInsets.all(8.0),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 234, 131, 41),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.play_arrow,
                    size: 45,
                    color: white,
                  ),
                ),
              ),
            ),
            const Text('Enjoy 2520 Game')
          ],
        ),
      ),
    );
  }
}

class Game2520 extends StatefulWidget {
  const Game2520({Key? key}) : super(key: key);

  @override
  State<Game2520> createState() => _Game2520State();
}

class _Game2520State extends State<Game2520> {
  GameController gameController = GameController();
  String swipeDirection = '';
  static const double minMainDisplacement = 50;
  static const double maxCrossRatio = 0.75;
  static const double minVelocity = 300;

  DragStartDetails? panStartDetails;
  DragUpdateDetails? panUpdateDetails;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const FittedBox(
                    child: Text(
                      '2520',
                      style: TextStyle(
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 65.0,
                            padding: const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 3.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFFbbada0),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Column(
                              children: [
                                const Text(
                                  'SCORE',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                  ),
                                ),
                                Text(
                                  '${gameController.score}',
                                  style: const TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 3.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFFbbada0),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Column(
                              children: [
                                const Text(
                                  'HIGH SCORE',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                  ),
                                ),
                                Text(
                                  '${GameController.highScore}',
                                  style: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            gameController.initGame();
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 5.0),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 234, 131, 41),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.replay,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Stack(
                children: [
                  GestureDetector(
                    onTapDown: (_) => panUpdateDetails =
                        null, // This prevents two fingers quick taps from being detected as a swipe
                    behavior: HitTestBehavior
                        .opaque, // This allows swipe above other clickable widgets
                    onPanStart: (startDetails) =>
                        panStartDetails = startDetails,
                    onPanUpdate: (updateDetails) =>
                        panUpdateDetails = updateDetails,
                    onPanEnd: (endDetails) {
                      if (panStartDetails == null || panUpdateDetails == null) {
                        return;
                      }

                      double dx = panUpdateDetails!.globalPosition.dx -
                          panStartDetails!.globalPosition.dx;
                      double dy = panUpdateDetails!.globalPosition.dy -
                          panStartDetails!.globalPosition.dy;

                      int panDurationMiliseconds =
                          panUpdateDetails!.sourceTimeStamp!.inMilliseconds -
                              panStartDetails!.sourceTimeStamp!.inMilliseconds;

                      double mainDis, crossDis, mainVel;
                      bool isHorizontalMainAxis = dx.abs() > dy.abs();

                      if (isHorizontalMainAxis) {
                        mainDis = dx.abs();
                        crossDis = dy.abs();
                      } else {
                        mainDis = dy.abs();
                        crossDis = dx.abs();
                      }

                      mainVel = 1000 * mainDis / panDurationMiliseconds;

                      // if (mainDis < minMainDisplacement) return;
                      // if (crossDis > maxCrossRatio * mainDis) return;
                      // if (mainVel < minVelocity) return;

                      if (mainDis < minMainDisplacement) {
                        debugPrint(
                            "SWIPE DEBUG | Displacement too short. Real: $mainDis - Min: $minMainDisplacement");
                        return;
                      }
                      if (crossDis > maxCrossRatio * mainDis) {
                        debugPrint(
                            "SWIPE DEBUG | Cross axis displacemnt bigger than limit. Real: $crossDis - Limit: ${mainDis * maxCrossRatio}");
                        return;
                      }
                      if (mainVel < minVelocity) {
                        debugPrint(
                            "SWIPE DEBUG | Swipe velocity too slow. Real: $mainVel - Min: $minVelocity");
                        return;
                      }

                      // dy < 0 => UP -- dx > 0 => RIGHT
                      if (isHorizontalMainAxis) {
                        if (dx > 0) {
                          setState(() {
                            gameController.play(Direction.right);
                          });
                        } else {
                          setState(() {
                            gameController.play(Direction.left);
                          });
                        }
                      } else {
                        if (dy < 0) {
                          setState(() {
                            gameController.play(Direction.top);
                          });
                        } else {
                          setState(() {
                            gameController.play(Direction.bottom);
                          });
                        }
                      }
                    },
                    child: Center(
                      child: Container(
                        margin: const EdgeInsets.all(7.0),
                        height: screenWidth - 30,
                        width: screenWidth,
                        decoration: BoxDecoration(
                          color: const Color(0xFFbbada0),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(
                            GameController.gameSize,
                            (i) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List.generate(
                                GameController.gameSize,
                                (j) => Box(
                                  value: gameController.game[i][j],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (gameController.winGame())
                    Container(
                      margin: const EdgeInsets.all(7),
                      height: screenWidth - 30,
                      width: screenWidth - 30,
                      color: const Color(0x88eee4da),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Center(
                            child: Text(
                              'CONGRATS!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 50.0,
                                color: Colors.black45,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    // gameController.reachGoal = false;
                                  });
                                },
                                child: const Text(
                                  'Continue',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20.0),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    gameController.initGame();
                                  });
                                },
                                child: const Text(
                                  'Replay',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  if (!gameController.start && gameController.checkEndGame())
                    Container(
                      margin: const EdgeInsets.all(7),
                      height: screenWidth - 30,
                      width: screenWidth - 30,
                      color: const Color(0x88eee4da),
                      child: const Center(
                        child: Text(
                          'Game Over!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 80.0,
                            color: Colors.black45,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

class GameController {
  late bool start, reachGoal;
  static int gameSize = 4, gameHero = 2;
  late int score;
  static int highScore = 0;
  late List<List<int>> game;
  late List<List<int>> gameCopy;

  GameController() {
    initGame();
  }

  void initGame() {
    start = true;
    reachGoal = false;
    game = [];
    int i = 0, j;
    while (i < gameSize) {
      j = 0;
      game.add([]);
      while (j < gameSize) {
        game[i].add(0);
        j++;
      }
      i++;
    }
    int k = 0;
    int max = Random().nextInt(gameSize) + 2;

    bool isFour;
    while (k < max) {
      i = Random().nextInt(gameSize);
      j = Random().nextInt(gameSize);
      isFour = Random().nextInt(8) == 0;
      game[i][j] = isFour ? gameHero * 2 : gameHero;
      k++;
    }
    score = 0;
  }

  winGame() {
    if (game.any((line) => line.any((val) => val == 2520)) && !reachGoal) {
      reachGoal = true;
      return true;
    }
    return false;
  }

  void addItem() {
    Random x = Random();
    bool isFour = x.nextInt(4) == 0;

    int i = x.nextInt(gameSize);
    int j = x.nextInt(gameSize);
    while (game[i][j] != 0) {
      i = x.nextInt(gameSize);
      j = x.nextInt(gameSize);
    }
    game[i][j] = isFour ? gameHero * 2 : gameHero;
  }

  int play(Direction direction) {
    start = false;
    // reachGoal = false;
    gameCopy = List.generate(
        gameSize, (i) => List.generate(gameSize, (j) => game[i][j]));
    if (direction == Direction.left) {
      for (var line in game) {
        line.removeWhere((element) => element == 0);
        int i = 0;
        while (i < line.length - 1) {
          if (line[i] == line[i + 1]) {
            line[i] *= 2;
            score += line[i];
            line[i + 1] = 0;
            i += 2;
          } else {
            i++;
          }
        }
        line.removeWhere((element) => element == 0);
        while (line.length < gameSize) {
          line.add(0);
        }
      }
    }
    if (direction == Direction.right) {
      for (var line in game) {
        line.removeWhere((element) => element == 0);
        int i = line.length - 1;
        while (i > 0) {
          if (line[i] == line[i - 1]) {
            line[i] *= 2;
            score += line[i];
            line[i - 1] = 0;
            i -= 2;
          } else {
            i--;
          }
        }
        line.removeWhere((element) => element == 0);
        while (line.length < gameSize) {
          line.insert(0, 0);
        }
      }
    }
    if (direction == Direction.top) {
      int k = 0;
      while (k < gameSize) {
        List<int> line = [];
        int l = 0;
        while (l < gameSize) {
          line.add(game[l][k]);
          l++;
        }
        line.removeWhere((element) => element == 0);
        int i = 0;
        while (i < line.length - 1) {
          if (line[i] == line[i + 1]) {
            line[i] *= 2;
            score += line[i];
            line[i + 1] = 0;
            i += 2;
          } else {
            i++;
          }
        }
        line.removeWhere((element) => element == 0);
        while (line.length < gameSize) {
          line.add(0);
        }
        l = 0;
        while (l < gameSize) {
          game[l][k] = line[l];
          l++;
        }
        k++;
      }
    }
    if (direction == Direction.bottom) {
      int k = 0;
      while (k < gameSize) {
        List<int> line = [];
        int l = 0;
        while (l < gameSize) {
          line.add(game[l][k]);
          l++;
        }
        line.removeWhere((element) => element == 0);
        int i = line.length - 1;
        while (i > 0) {
          if (line[i] == line[i - 1]) {
            line[i] *= 2;
            score += line[i];
            line[i - 1] = 0;
            i -= 2;
          } else {
            i--;
          }
        }
        line.removeWhere((element) => element == 0);
        while (line.length < gameSize) {
          line.insert(0, 0);
        }
        l = 0;
        while (l < gameSize) {
          game[l][k] = line[l];
          l++;
        }
        k++;
      }
    }
    if (didChange()) {
      if (score >= highScore) {
        highScore = score;
      }
      addItem();
    }
    // winGame();
    return score;
  }

  bool checkEndGame() {
    if (game.every((line) => line.every((val) => val != 0))) {
      List<List<int>> gameEndCopy = List.generate(
          gameSize, (i) => List.generate(gameSize, (j) => game[i][j]));
      int scoreCopy = score;
      for (var direction in Direction.values) {
        play(direction);
        if (score > scoreCopy) {
          score = scoreCopy;
          game = List.generate(gameSize,
              (i) => List.generate(gameSize, (j) => gameEndCopy[i][j]));
          return false;
        }
      }
      return true;
    }
    return false;
  }

  bool didChange() {
    int i = 0, j;
    while (i < gameSize) {
      j = 0;
      while (j < gameSize) {
        if (game[i][j] != gameCopy[i][j]) {
          return true;
        }
        j++;
      }
      i++;
    }
    return false;
  }
}

enum Direction { right, top, left, bottom }

Map<int, Color> colors = {
  GameController.gameHero * 0: white,
  GameController.gameHero * 1: const Color(0xFFeee4da),
  GameController.gameHero * 2: const Color(0xFFede0c8),
  GameController.gameHero * 3: const Color(0xFFf2b179),
  GameController.gameHero * 4: const Color(0xFFf59563),
  GameController.gameHero * 5: const Color(0xFFf67c5f),
  GameController.gameHero * 6: const Color(0xFFf65e3b),
  GameController.gameHero * 7: const Color(0xFFedcf72),
  GameController.gameHero * 8: const Color(0xFFe7d26b),
  GameController.gameHero * 9: const Color(0xFFe7ce5a),
  GameController.gameHero * 10: const Color(0xFFe7d050),
  GameController.gameHero * 11: const Color(0xFFe5cb42),
  GameController.gameHero * 12: const Color(0xFFfa0841),
  GameController.gameHero * 13: const Color(0xFFfb0028),
  GameController.gameHero * 14: const Color(0xFFfb0027),
  GameController.gameHero * 15: const Color(0xFFf50027),
  GameController.gameHero * 16: const Color(0xFFf90027),
  GameController.gameHero * 17: const Color(0xFFfb0028),
};
