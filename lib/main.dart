import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models.dart';

void main() {
  runApp(MainApp());
}

Future<Iterable<Meal>> getMeals() async {
  final url = Uri.parse('https://meals.api.hsapp.kr/today?code=8140077');
  final resp = await get(url);
  if (resp.statusCode != 200) {
    throw StateError('Cannot fetch meals!');
  }
  final json = jsonDecode(utf8.decode(resp.bodyBytes));
  return (json as List).map((e) => Meal.fromJson(e));
}

class MainApp extends StatelessWidget {
  final meals = getMeals();

  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: buildTheme(context),
      home: Scaffold(
        body: SafeArea(
          child: Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: FutureBuilder(
                future: meals,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(child: Text('데이터를 가져올 수 없습니다.'));
                  } else if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    final data = snapshot.data!;
                    return buildLayout(context, data);
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  ThemeData buildTheme(BuildContext context) {
    const seed = Colors.indigo;
    final scheme = MediaQuery.of(context).platformBrightness == Brightness.light
        ? ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.light)
        : ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.dark);
    return ThemeData(
      colorScheme: scheme,
      textTheme: TextTheme(
        titleSmall: GoogleFonts.ibmPlexSansKr(
          fontSize: 32,
          fontWeight: FontWeight.w600,
        ),
        bodyMedium: GoogleFonts.ibmPlexSansKr(
          fontSize: 18,
        ),
      ),
    );
  }

  Widget buildLayout(BuildContext context, Iterable<Meal> meals) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const trigger = 500;
        final isWide = constraints.maxWidth > trigger;
        final items = meals.map((e) => buildCard(context, e));
        if (isWide) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                spacing: 10,
                children: [...items],
              ),
            ),
          );
        } else {
          return ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 400),
            child: Swiper(
              loop: false,
              itemCount: items.length,
              itemBuilder: (context, index) => items.elementAt(index),
              viewportFraction: 0.85,
              scale: 0.9,
            ),
          );
        }
      },
    );
  }

  Widget buildCard(BuildContext context, Meal meal) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300, maxHeight: 400),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          width: 5,
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.grey.shade100
              : Colors.grey.shade900,
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: Theme.of(context).brightness == Brightness.light
              ? [Colors.white, Colors.grey.shade100]
              : [Colors.grey.shade900, Colors.black],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                switch (meal.time) {
                  MealTime.breakfast => '조식',
                  MealTime.lunch => '중식',
                  MealTime.dinner => '석식',
                },
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(width: 8),
              Icon(
                switch (meal.time) {
                  MealTime.breakfast => Icons.wb_twilight,
                  MealTime.lunch => Icons.light_mode,
                  MealTime.dinner => Icons.dark_mode,
                },
                size: 36,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...meal.dishes.map(
                (dish) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    dish.name,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
