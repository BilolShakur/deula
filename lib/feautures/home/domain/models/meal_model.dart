class MealData {
  final int? id;
  final String title;
  final double calories;
  final double? protein;
  final double? fat;
  final double? sugar;

  MealData({
    this.id,
    required this.title,
    required this.calories,
    this.protein,
    this.fat,
    this.sugar,
  });

  factory MealData.fromMap(Map<String, dynamic> map) {
    return MealData(
      id: map['id'],
      title: map['title'],
      calories: map['calories'],
      protein: map['protein'],
      fat: map['fat'],
      sugar: map['sugar'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'calories': calories,
      'protein': protein ?? 0,
      'fat': fat ?? 0,
      'sugar': sugar ?? 0,
    };
  }
}
