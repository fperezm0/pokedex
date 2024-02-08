import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class Pokemon {
  final int id;
  final String name;
  final String type1;
  final String type2;
  final String ability1;
  final String ability2;
  final String ability3;
  final int hp;
  final int attack;
  final int defense;
  final int spAtk;
  final int spDef;
  final int speed;
  final String sprite;

  Pokemon({
    required this.id,
    required this.name,
    required this.type1,
    required this.type2,
    required this.ability1,
    required this.ability2,
    required this.ability3,
    required this.hp,
    required this.attack,
    required this.defense,
    required this.spAtk,
    required this.spDef,
    required this.speed,
    required this.sprite,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      name: json['Name'],
      type1: json['Type1'],
      type2: json['Type2'],
      ability1: json['Ability1'],
      ability2: json['Ability2'],
      ability3: json['Ability3'],
      hp: json['HP'],
      attack: json['Attack'],
      defense: json['Defense'],
      spAtk: json['SpAtk'],
      spDef: json['SpDef'],
      speed: json['Speed'],
      sprite: json['Sprite'],
    );
  }
}

class PokemonRepository {
  Future<List<Pokemon>> loadPokemonData() async {
    final String jsonString = await rootBundle.loadString('json/pokemon.json');
    final List<dynamic> jsonList = json.decode(jsonString);

    return jsonList.map((json) => Pokemon.fromJson(json)).toList();
  }
}
