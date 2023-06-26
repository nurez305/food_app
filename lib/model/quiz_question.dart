class QuizQuestion {
  QuizQuestion(this.text, this.answer);
  final String text;
  final List<String> answer;
  
  List<String> getShuffleList() {
    final shuffled = List.of(answer);
    shuffled.shuffle();
    return shuffled;
  }
}
