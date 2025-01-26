import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const HoldemApp());
}

class HoldemApp extends StatelessWidget {
  const HoldemApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Texas Hold\'em',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HoldemGame(),
    );
  }
}

class HoldemGame extends StatefulWidget {
  const HoldemGame({super.key});

  @override
  _HoldemGameState createState() => _HoldemGameState();
}

class _HoldemGameState extends State<HoldemGame> {
  final List<String> deck = [
    '2♥', '3♥', '4♥', '5♥', '6♥', '7♥', '8♥', '9♥', '10♥', 'J♥', 'Q♥', 'K♥', 'A♥',
    '2♦', '3♦', '4♦', '5♦', '6♦', '7♦', '8♦', '9♦', '10♦', 'J♦', 'Q♦', 'K♦', 'A♦',
    '2♠', '3♠', '4♠', '5♠', '6♠', '7♠', '8♠', '9♠', '10♠', 'J♠', 'Q♠', 'K♠', 'A♠',
    '2♣', '3♣', '4♣', '5♣', '6♣', '7♣', '8♣', '9♣', '10♣', 'J♣', 'Q♣', 'K♣', 'A♣'
  ];
  List<String> playerHand = [];
  List<String> computerHand = [];
  List<String> communityCards = [];
  Random random = Random();

  @override
  void initState() {
    super.initState();
    _dealNewGame();
  }

  void _dealNewGame() {
    setState(() {
      List<String> shuffledDeck = List.from(deck)..shuffle(random);
      playerHand = shuffledDeck.sublist(0, 2);
      computerHand = shuffledDeck.sublist(2, 4);
      communityCards = shuffledDeck.sublist(4, 9);
    });
  }

  String _evaluateHands() {
    // 단순한 비교 로직으로 예시 제공 (핸드 평가 미완성)
    int playerScore = random.nextInt(100);
    int computerScore = random.nextInt(100);
    return playerScore > computerScore ? 'You Win!' : 'Computer Wins!';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Texas Hold\'em')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('♠Your Hand: ${playerHand.join(', ')}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('♣️Computer Hand: ${computerHand.join(', ')}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text('Community Cards: ${communityCards.join(', ')}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                String result = _evaluateHands();
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Game Result'),
                    content: Text(result),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _dealNewGame();
                        },
                        child: Text('New Game'),
                      )
                    ],
                  ),
                );
              },
              child: Text('Reveal Winner'),
            ),
          ],
        ),
      ),
    );
  }
}
