extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }

  String toPokemonIndex() {
    if (this.length < 4) {
      String indexFormat = "#000";
      print("#toPokemonIndex");
      print("#1 this $this");
      print("#2 this length ${this.length}");
      print("#3 $indexFormat");
      print("#4 ${indexFormat.length}");
      return indexFormat.replaceRange(
          indexFormat.length - this.length, indexFormat.length, this);
    } else
      return "#$this";
  }
}
