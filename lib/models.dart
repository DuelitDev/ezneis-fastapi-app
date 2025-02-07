import 'package:equatable/equatable.dart';

class Meal extends Equatable {
  final MealTime time;
  final String date;
  final int headcount;
  final List<Dish> dishes;
  final List<Origin> origins;
  final double kcal;
  final List<Nutrient> nutrients;

  const Meal({
    required this.time,
    required this.date,
    required this.headcount,
    required this.dishes,
    required this.origins,
    required this.kcal,
    required this.nutrients,
  });

  @override
  List<Object> get props => [
        time,
        date,
        headcount,
        dishes,
        origins,
        kcal,
        nutrients,
      ];

  factory Meal.fromJson(Map<String, dynamic> json) {
    final time = switch (json['time']) {
      1 => MealTime.breakfast,
      2 => MealTime.lunch,
      3 => MealTime.dinner,
      _ => throw const FormatException('Format exception! Cannot parse data!'),
    };
    final dishes = json['dishes'] as List;
    final origins = json['origins'] as List;
    final nutrients = json['nutrients'] as List;
    return Meal(
      time: time,
      date: json['date'],
      headcount: json['headcount'],
      dishes: dishes.map((e) => Dish.fromJson(e)).toList(),
      origins: origins.map((e) => Origin.fromJson(e)).toList(),
      kcal: json['kcal'].toDouble(),
      nutrients: nutrients.map((e) => Nutrient.fromJson(e)).toList(),
    );
  }
}

enum MealTime {
  breakfast,
  lunch,
  dinner,
}

class Dish extends Equatable {
  final String name;
  final List<int> allergies;

  const Dish({required this.name, required this.allergies});

  @override
  List<Object> get props => [name, allergies];

  factory Dish.fromJson(Map<String, dynamic> json) {
    return Dish(
      name: json['name'],
      allergies: List<int>.from(json['allergies']),
    );
  }
}

class Nutrient extends Equatable {
  final String name;
  final String unit;
  final double value;

  const Nutrient({required this.name, required this.unit, required this.value});

  @override
  List<Object> get props => [name, unit, value];

  factory Nutrient.fromJson(Map<String, dynamic> json) {
    return Nutrient(
      name: json['name'],
      unit: json['unit'],
      value: json['value'].toDouble(),
    );
  }
}

class Origin extends Equatable {
  final String name;
  final String origin;

  const Origin({required this.name, required this.origin});

  @override
  List<Object> get props => [name, origin];

  factory Origin.fromJson(Map<String, dynamic> json) {
    return Origin(
      name: json['name'],
      origin: json['origin'],
    );
  }
}
