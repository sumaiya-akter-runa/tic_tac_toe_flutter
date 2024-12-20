import 'package:flutter/material.dart';

class TicTacToe extends StatefulWidget {
  const TicTacToe({super.key});

  @override
  State<TicTacToe> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  // Border state to keep track of moves
  final List<String> board = List.filled(9, "");
  // Current player(x or o)
  String currentPlayer = "X";
  // Variable to store the winner
  String winner = "";
  // Flag to indicate a tie
  bool isTie = false;

  // Function to handle a player's move
  void player(int index) {
    if (winner != '' || board[index] != "") {
      return; // If the game is already won or the cell is not empty, do nothing
    }
    setState(() {
      board[index] = currentPlayer; // Set the current cell to the current player's symbol
      currentPlayer = currentPlayer == "X" ? "O" : "X"; // Switch to the other player
      checkForWinner();
    });
  }

  // Function to check for a winner or a tie
  void checkForWinner() {
    List<List<int>> lines = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];
    // Check each winning combination
    for (List<int> line in lines) {
      String player1 = board[line[0]];
      String player2 = board[line[1]];
      String player3 = board[line[2]];
      if (player1 == "" || player2 == "" || player3 == "") {
        continue; // If any cell in the combination is empty, skip this combination
      }
      if (player1 == player2 && player2 == player3) {
        setState(() {
          winner = player1; // If all cells in the combination are the same, set the winner
        });
        return;
      }
    }
    // Check for a tie
    if (!board.contains("")) {
      setState(() {
        isTie = true; // If no cells are empty and there's no winner, it's a tie
      });
    }
  }

  // Function to reset the game state and play a new game
  void resetGame() {
    setState(() {
      board.fillRange(0, 9, ''); // Clear the board
      currentPlayer = 'X';
      winner = ''; // Clear the winner
      isTie = false; // Clear the tie flag
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Displaying the players
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: currentPlayer == "X"
                          ? Colors.amber
                          : Colors.transparent,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 3,
                      ),
                    ],
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 55,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "BOT 1",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "X",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: size.width * 0.08),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: currentPlayer == "O"
                          ? Colors.amber
                          : Colors.transparent,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 3,
                      ),
                    ],
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 55,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "BOT 2",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "O",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.02),

            // Display the winner message
            if (winner != "")
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    winner,
                    style: const TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    " WON!",
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

            // Display tie message
            if (isTie)
              const Text(
                "It's a Tie!",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),

            // Game board
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: GridView.builder(
                  itemCount: 9,
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        player(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            board[index],
                            style: const TextStyle(
                              fontSize: 50,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Reset button
            if (winner != "" || isTie)
              ElevatedButton(
                onPressed: resetGame,
                child: const Text("Play Again"),
              ),
          ],
        ),
      ),
    );
  }
}
