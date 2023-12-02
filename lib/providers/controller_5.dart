import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:WordSeeker/constants/answer_stages.dart';
import 'package:WordSeeker/constants/words_4.dart';
import 'package:WordSeeker/constants/words_5.dart';
import 'package:WordSeeker/constants/words_6.dart';
import 'package:WordSeeker/models/tile_model.dart';
import 'package:WordSeeker/utils/calculate_chart_stats.dart';

import '../utils/calculate_stats.dart';
import '../data/keys_map.dart';

class Controller_5 extends ChangeNotifier {
  bool checkLine = false,
      backOrEnterTapped = false,
      gameWon = false,
      gameCompleted = false,
      notEnoughLetters = false,
      notValidWord = false;
  String correctWord = "";
  int currentTile = 0, currentRow = 0;
  List<TileModel> tilesEntered = [];

  final Set<String> validWords4 = words_4.toSet();
  final Set<String> validWords5 = words_5.toSet();
  final Set<String> validWords6 = words_6.toSet(); // Use set for faster word lookup
  bool validateWord4({required String enteredWord}) => validWords4.contains(enteredWord);
  bool validateWord5({required String enteredWord}) => validWords5.contains(enteredWord);
  bool validateWord6({required String enteredWord}) => validWords6.contains(enteredWord);


  void resetGame() {
    checkLine = false;
    backOrEnterTapped = false;
    gameWon = false;
    gameCompleted = false;
    notEnoughLetters = false;
    correctWord = "";
    currentTile = 0;
    currentRow = 0;
    tilesEntered = [];

    for (final key in keysMap.keys) {
      keysMap[key] = AnswerStage.notAnswered;
    }

    notifyListeners();
  }
  setCorrectWord({required String word}) => correctWord = word;

  setKeyTapped5({required String value}) {
     
    if (value == 'ENTER') {
      backOrEnterTapped = true;
      if (currentTile == 5 * (currentRow + 1)) {
        checkWord5();
      } else {
        notEnoughLetters = true;
      }
    } else if (value == 'BACK') {
      backOrEnterTapped = true;
      notEnoughLetters = false;
      if (currentTile > 5 * (currentRow + 1) - 5) {
        currentTile--;
        tilesEntered.removeLast();
      }
    } else {
      backOrEnterTapped = false;
      notEnoughLetters = false;
      if (currentTile < 5 * (currentRow + 1)) {
        tilesEntered.add(
            TileModel(letter: value, answerStage: AnswerStage.notAnswered));
        currentTile++;
      }
    }
    notifyListeners();
  }
  setKeyTapped4({required String value}) {
    if (value == 'ENTER') {
      backOrEnterTapped = true;
      if (currentTile == 4 * (currentRow + 1)) {
        checkWord4();
      } else {
        notEnoughLetters = true;
      }
    } else if (value == 'BACK') {
      backOrEnterTapped = true;
      notEnoughLetters = false;
      if (currentTile > 4 * (currentRow + 1) - 4) {
        currentTile--;
        tilesEntered.removeLast();
      }
    } else {
      backOrEnterTapped = false;
      notEnoughLetters = false;
      if (currentTile < 4 * (currentRow + 1)) {
        tilesEntered.add(
            TileModel(letter: value, answerStage: AnswerStage.notAnswered));
        currentTile++;
      }
    }
    notifyListeners();
  }
  setKeyTapped6({required String value}) {
    if (value == 'ENTER') {
      backOrEnterTapped = true;
      if (currentTile == 6 * (currentRow + 1)) {
        checkWord6();
      } else {
        notEnoughLetters = true;
      }
    } else if (value == 'BACK') {
      backOrEnterTapped = true;
      notEnoughLetters = false;
      if (currentTile > 6 * (currentRow + 1) - 6) {
        currentTile--;
        tilesEntered.removeLast();
      }
    } else {
      backOrEnterTapped = false;
      notEnoughLetters = false;
      if (currentTile < 6 * (currentRow + 1)) {
        tilesEntered.add(
            TileModel(letter: value, answerStage: AnswerStage.notAnswered));
        currentTile++;
      }
    }
    notifyListeners();
  }


  checkWord5() {
    List<String> guessed = [], remainingCorrect = [];
    String guessedWord = "";

    for (int i = currentRow * 5; i < (currentRow * 5) + 5; i++) {
      guessed.add(tilesEntered[i].letter);
    }

    guessedWord = guessed.join();
    remainingCorrect = correctWord.characters.toList();

    if (!validateWord5(enteredWord: guessedWord)) {
      // Display an error message or notification to the user that the word is not valid
      notValidWord = true; // Or use a separate flag for invalid word
      notifyListeners();
      return;
    }

    if (guessedWord == correctWord) {

      for (int i = currentRow * 5; i < (currentRow * 5) + 5; i++) {
        tilesEntered[i].answerStage = AnswerStage.correct;
        keysMap.update(tilesEntered[i].letter, (value) => AnswerStage.correct);
        gameWon = true;
        gameCompleted = true;
      }
    } else {
      for (int i = 0; i < 5; i++) {
        if (guessedWord[i] == correctWord[i]) {
          remainingCorrect.remove(guessedWord[i]);
          tilesEntered[i + (currentRow * 5)].answerStage = AnswerStage.correct;
          keysMap.update(guessedWord[i], (value) => AnswerStage.correct);
        }
      }

      for (int i = 0; i < remainingCorrect.length; i++) {
        for (int j = 0; j < 5; j++) {
          if (remainingCorrect[i] ==
              tilesEntered[j + (currentRow * 5)].letter) {
            if (tilesEntered[j + (currentRow * 5)].answerStage !=
                AnswerStage.correct) {
              tilesEntered[j + (currentRow * 5)].answerStage =
                  AnswerStage.contains;
            }

            final resultKey = keysMap.entries.where((element) =>
                element.key == tilesEntered[j + (currentRow * 5)].letter);

            if (resultKey.single.value != AnswerStage.correct) {
              keysMap.update(
                  resultKey.single.key, (value) => AnswerStage.contains);
            }
          }
        }
      }
      for (int i = currentRow * 5; i < (currentRow * 5) + 5; i++) {
        if (tilesEntered[i].answerStage == AnswerStage.notAnswered) {
          tilesEntered[i].answerStage = AnswerStage.incorrect;

          final results = keysMap.entries
              .where((element) => element.key == tilesEntered[i].letter);
          if (results.single.value == AnswerStage.notAnswered) {
            keysMap.update(
                tilesEntered[i].letter, (value) => AnswerStage.incorrect);
          }
        }
      }
    }
    checkLine = true;
    currentRow++;

    if (currentRow == 6) {
      gameCompleted = true;
    }

    if (gameCompleted) {
      calculateStats(gameWon: gameWon);
      if (gameWon) {
        setChartStats(currentRow: currentRow);
      }
    }

    notifyListeners();
  }
  checkWord4() {
    List<String> guessed = [], remainingCorrect = [];
    String guessedWord = "";

    for (int i = currentRow * 4; i < (currentRow * 4) + 4; i++) {
      guessed.add(tilesEntered[i].letter);
    }

    guessedWord = guessed.join();
    remainingCorrect = correctWord.characters.toList();

    if (!validateWord4(enteredWord: guessedWord)) {
      // Display an error message or notification to the user that the word is not valid
      notValidWord = true; // Or use a separate flag for invalid word
      notifyListeners();
      return;
    }

    if (guessedWord == correctWord) {
      for (int i = currentRow * 4; i < (currentRow * 4) + 4; i++) {
        tilesEntered[i].answerStage = AnswerStage.correct;
        keysMap.update(tilesEntered[i].letter, (value) => AnswerStage.correct);
        gameWon = true;
        gameCompleted = true;
      }
    } else {
      for (int i = 0; i < 4; i++) {
        if (guessedWord[i] == correctWord[i]) {
          remainingCorrect.remove(guessedWord[i]);
          tilesEntered[i + (currentRow * 4)].answerStage = AnswerStage.correct;
          keysMap.update(guessedWord[i], (value) => AnswerStage.correct);
        }
      }

      for (int i = 0; i < remainingCorrect.length; i++) {
        for (int j = 0; j < 4; j++) {
          if (remainingCorrect[i] ==
              tilesEntered[j + (currentRow * 4)].letter) {
            if (tilesEntered[j + (currentRow * 4)].answerStage !=
                AnswerStage.correct) {
              tilesEntered[j + (currentRow * 4)].answerStage =
                  AnswerStage.contains;
            }

            final resultKey = keysMap.entries.where((element) =>
                element.key == tilesEntered[j + (currentRow * 4)].letter);

            if (resultKey.single.value != AnswerStage.correct) {
              keysMap.update(
                  resultKey.single.key, (value) => AnswerStage.contains);
            }
          }
        }
      }
      for (int i = currentRow * 4; i < (currentRow * 4) + 4; i++) {
        if (tilesEntered[i].answerStage == AnswerStage.notAnswered) {
          tilesEntered[i].answerStage = AnswerStage.incorrect;

          final results = keysMap.entries
              .where((element) => element.key == tilesEntered[i].letter);
          if (results.single.value == AnswerStage.notAnswered) {
            keysMap.update(
                tilesEntered[i].letter, (value) => AnswerStage.incorrect);
          }
        }
      }
    }
    checkLine = true;
    currentRow++;

    if (currentRow == 6) {
      gameCompleted = true;
    }

    if (gameCompleted) {
      calculateStats(gameWon: gameWon);
      if (gameWon) {
        setChartStats(currentRow: currentRow);
      }
    }

    notifyListeners();
  }
  checkWord6() {
    List<String> guessed = [], remainingCorrect = [];
    String guessedWord = "";

    for (int i = currentRow * 6; i < (currentRow * 6) + 6; i++) {
      guessed.add(tilesEntered[i].letter);
    }

    guessedWord = guessed.join();
    remainingCorrect = correctWord.characters.toList();

  if (!validateWord6(enteredWord: guessedWord)) {
    // Display an error message or notification to the user that the word is not valid
    notValidWord = true; // Or use a separate flag for invalid word
    notifyListeners();
    return;
  }

    if (guessedWord == correctWord) {
      for (int i = currentRow * 6; i < (currentRow * 6) + 6; i++) {
        tilesEntered[i].answerStage = AnswerStage.correct;
        keysMap.update(tilesEntered[i].letter, (value) => AnswerStage.correct);
        gameWon = true;
        gameCompleted = true;
      }
    } else {
      for (int i = 0; i < 6; i++) {
        if (guessedWord[i] == correctWord[i]) {
          remainingCorrect.remove(guessedWord[i]);
          tilesEntered[i + (currentRow * 6)].answerStage = AnswerStage.correct;
          keysMap.update(guessedWord[i], (value) => AnswerStage.correct);
        }
      }

      for (int i = 0; i < remainingCorrect.length; i++) {
        for (int j = 0; j < 6; j++) {
          if (remainingCorrect[i] ==
              tilesEntered[j + (currentRow * 6)].letter) {
            if (tilesEntered[j + (currentRow * 6)].answerStage !=
                AnswerStage.correct) {
              tilesEntered[j + (currentRow * 6)].answerStage =
                  AnswerStage.contains;
            }

            final resultKey = keysMap.entries.where((element) =>
                element.key == tilesEntered[j + (currentRow * 6)].letter);

            if (resultKey.single.value != AnswerStage.correct) {
              keysMap.update(
                  resultKey.single.key, (value) => AnswerStage.contains);
            }
          }
        }
      }
      for (int i = currentRow * 6; i < (currentRow * 6) + 6; i++) {
        if (tilesEntered[i].answerStage == AnswerStage.notAnswered) {
          tilesEntered[i].answerStage = AnswerStage.incorrect;

          final results = keysMap.entries
              .where((element) => element.key == tilesEntered[i].letter);
          if (results.single.value == AnswerStage.notAnswered) {
            keysMap.update(
                tilesEntered[i].letter, (value) => AnswerStage.incorrect);
          }
        }
      }
    }
    checkLine = true;
    currentRow++;

    if (currentRow == 6) {
      gameCompleted = true;
    }

    if (gameCompleted) {
      calculateStats(gameWon: gameWon);
      if (gameWon) {
        setChartStats(currentRow: currentRow);
      }
    }

    notifyListeners();
  }
}
