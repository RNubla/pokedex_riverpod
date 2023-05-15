class StringTransform {
  String inputString;

  StringTransform({required this.inputString});

  String capitalizeFirstWord() {
    var string = inputString.toString()[0].toUpperCase() +
        inputString.toString().substring(1).toLowerCase();

    return string;
  }
}
