import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChessBoard extends StatefulWidget {
  const ChessBoard({super.key});

  @override
  State<ChessBoard> createState() => _ChessBoardState();
}

class _ChessBoardState extends State<ChessBoard> {
  // 8x8 board: each cell holds either null or a Map describing the piece
  // Example: {"icon": FontAwesomeIcons.chessPawn, "color": Colors.black}
  List<List<Map<String, dynamic>?>> board = List.generate(
    8,
    (_) => List.filled(8, null),
  );

  @override
  void initState() {
    super.initState();
    _setupBoard();
  }

  void _setupBoard() {
    board[0] = [
      {"icon": FontAwesomeIcons.chessRook, "color": Colors.black},
      {"icon": FontAwesomeIcons.chessKnight, "color": Colors.black},
      {"icon": FontAwesomeIcons.chessBishop, "color": Colors.black},
      {"icon": FontAwesomeIcons.chessQueen, "color": Colors.black},
      {"icon": FontAwesomeIcons.chessKing, "color": Colors.black},
      {"icon": FontAwesomeIcons.chessBishop, "color": Colors.black},
      {"icon": FontAwesomeIcons.chessKnight, "color": Colors.black},
      {"icon": FontAwesomeIcons.chessRook, "color": Colors.black},
    ];

    board[1] = List.generate(
      8,
      (_) => {"icon": FontAwesomeIcons.chessPawn, "color": Colors.black},
    );

    board[6] = List.generate(
      8,
      (_) => {"icon": FontAwesomeIcons.chessPawn, "color": Colors.white},
    );

    board[7] = [
      {"icon": FontAwesomeIcons.chessRook, "color": Colors.white},
      {"icon": FontAwesomeIcons.chessKnight, "color": Colors.white},
      {"icon": FontAwesomeIcons.chessBishop, "color": Colors.white},
      {"icon": FontAwesomeIcons.chessQueen, "color": Colors.white},
      {"icon": FontAwesomeIcons.chessKing, "color": Colors.white},
      {"icon": FontAwesomeIcons.chessBishop, "color": Colors.white},
      {"icon": FontAwesomeIcons.chessKnight, "color": Colors.white},
      {"icon": FontAwesomeIcons.chessRook, "color": Colors.white},
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chess Drag & Drop")),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: AspectRatio(
            aspectRatio: 1,
            child: GridView.builder(
              itemCount: 64,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 8,
              ),
              itemBuilder: (context, index) {
                int row = index ~/ 8;
                int col = index % 8;

                bool isWhite = (row + col) % 2 == 0;
                Color squareColor = isWhite
                    ? Colors.grey[300]!
                    : const Color(0xFF028006);

                var piece = board[row][col];

                return DragTarget<Map<String, dynamic>>(
                  onAccept: (data) {
                    setState(() {
                      // Move piece
                      board[row][col] = data;
                      board[data['fromRow']][data['fromCol']] = null;
                    });
                  },
                  builder: (context, candidateData, rejectedData) {
                    return Container(
                      decoration: BoxDecoration(
                        color: squareColor,
                        border: Border.all(color: Colors.black),
                      ),
                      child: piece != null
                          ? Draggable<Map<String, dynamic>>(
                              data: {
                                "icon": piece["icon"],
                                "color": piece["color"],
                                "fromRow": row,
                                "fromCol": col,
                              },
                              feedback: Icon(
                                piece["icon"],
                                size: 50,
                                color: piece["color"],
                              ),
                              childWhenDragging: const SizedBox.shrink(),
                              child: Icon(
                                piece["icon"],
                                size: 40,
                                color: piece["color"],
                              ),
                            )
                          : null,
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
