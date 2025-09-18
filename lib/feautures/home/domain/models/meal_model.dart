class MealData {
  final int? id;
  final String title;
  final double calories;
  final double? protein;
  final double? fat;
  final double? sugar;
  final DateTime date; 

  MealData({
    this.id,
    required this.title,
    required this.calories,
    this.protein,
    this.fat,
    this.sugar,
    DateTime? date, 
  }) : date = date ?? DateTime.now(); 

  factory MealData.fromMap(Map<String, dynamic> map) {
    return MealData(
      id: map['id'],
      title: map['title'],
      calories: map['calories'],
      protein: map['protein'],
      fat: map['fat'],
      sugar: map['sugar'],
      date: DateTime.tryParse(map['date'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'calories': calories,
      'protein': protein ?? 0,
      'fat': fat ?? 0,
      'sugar': sugar ?? 0,
      'date': date.toIso8601String(), // 👈 save as string
    };
  }
}
