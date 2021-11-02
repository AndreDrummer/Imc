class ImcModel {
  String description;
  double imcValue;
  double height;
  double weight;

  ImcModel({
    required this.description,
    required this.imcValue,
    required this.height,
    required this.weight,
  });

  factory ImcModel.initial() {
    return ImcModel(
      description: '',
      imcValue: 0.0,
      weight: 0.0,
      height: 0.0,
    );
  }
}
