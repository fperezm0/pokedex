import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:pk/models/Pokemon.dart';

class DetailsScreen extends StatefulWidget {
  final Pokemon pokemon;

  DetailsScreen({Key? key, required this.pokemon, Color? backgroundColor})
      : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late Pokemon auxPokemon; // Variable auxiliar

  @override
  void initState() {
    super.initState();
    auxPokemon =
        widget.pokemon; // Guarda el objeto Pokemon en la variable auxiliar
  }

  @override
  Widget build(BuildContext context) {
    var tam = MediaQuery.of(context).size.width;
    var peso = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 0, 247, 255),
        body: Stack(
          alignment: Alignment.center,
          children: [
            _Imagenpokeball(),
            Positioned(
                top: 40,
                left: 5,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 40,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )),
            Positioned(
              bottom: 0,
              child: Container(
                width: tam,
                height: peso * 0.6,
                decoration: BoxDecoration(
                    color: Color.fromARGB(211, 63, 63, 63),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
              ),
            ),
            _pokemonSonido(auxPokemon.name.toLowerCase(), auxPokemon.sprite),
            _TextoPoke(auxPokemon.name),
            _PrimerTipoPoke(auxPokemon.type1),
            _SegundoTipoPoke(auxPokemon.type2),
            _TextoNumeroPoke("#" + auxPokemon.id.toString() + ""),
            _TextoAbility(auxPokemon.ability1, auxPokemon.ability2),
            _TextoAtributo("HP", 430),
            _TextBarra(auxPokemon.hp, 455),
            _TextoAtributo("Atack", 480),
            _TextBarra(auxPokemon.attack, 505),
            _TextoAtributo("Atack SP", 535),
            _TextBarra(auxPokemon.spAtk, 550),
            _TextoAtributo("Defence", 585),
            _TextBarra(auxPokemon.defense, 605),
            _TextoAtributo("Defence Sp", 630),
            _TextBarra(auxPokemon.spDef, 655),
            _TextoAtributo("Sleep", 680),
            _TextBarra(auxPokemon.speed, 705),
            _TextoBy(),
          ],
        ));
  }

  Widget _Imagenpokeball() {
    return Positioned(
      top: 100,
      right: 10,
      child: Image.asset(
        'images/pokeballgira.gif',
        fit: BoxFit.fitWidth,
        width: 220,
      ),
    );
  }

  Widget _pokemon(String sprite) {
    return Positioned(
      child: CachedNetworkImage(
        imageUrl: sprite,
        height: 140,
        fit: BoxFit.fitWidth,
        placeholder: ((context, url) => Center(
              child: CircularProgressIndicator(),
            )),
      ),
    );
  }

  Widget _pokemonSonido(String nombrePokemon, String sprite) {
    return Positioned(
      top: 200,
      right: 90, // Ajusta la posición izquierda según tus necesidades
      child: TextButton(
        onPressed: () async {
          final player = AudioPlayer();
          await player.play(UrlSource(
            'https://play.pokemonshowdown.com/audio/cries/' +
                nombrePokemon +
                '.ogg',
          ));
        },
        child: Row(
          children: [
            _pokemon(sprite),
          ],
        ),
      ),
    );
  }

  Widget _TextoPoke(String name) {
    return Positioned(
        top: 90,
        left: 15,
        child: Text(
          name,
          style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255)
                  .withOpacity(0.9), // Agrega una coma aquí
              fontWeight: FontWeight.bold,
              fontSize: 32),
        ));
  }

  Widget _TextoAbility(String abilty, String abilty2) {
    return Positioned(
        top: 390,
        left: 15,
        child: Text(
          "Abilitys : " + abilty + "  /  " + abilty2,
          style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255)
                  .withOpacity(0.9), // Agrega una coma aquí
              fontWeight: FontWeight.bold,
              fontSize: 12),
        ));
  }

  Widget _TextoBy() {
    return Positioned(
        top: 840,
        right: 10,
        child: Text(
          "Developer by Enrique Pérez",
          style: TextStyle(
              color: Color.fromARGB(255, 110, 0, 0)
                  .withOpacity(0.9), // Agrega una coma aquí
              fontWeight: FontWeight.bold,
              fontSize: 8),
        ));
  }

  Widget _TextoNumeroPoke(String number) {
    return Positioned(
        top: 90,
        right: 8,
        child: Text(
          number,
          style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255)
                  .withOpacity(0.9), // Agrega una coma aquí
              fontWeight: FontWeight.bold,
              fontSize: 28),
        ));
  }

  Widget _TextoAtributo(String atributo, double altura) {
    return Positioned(
        top: altura,
        left: 85,
        child: Text(
          atributo,
          style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255)
                  .withOpacity(0.9), // Agrega una coma aquí
              fontSize: 18),
        ));
  }

  Widget _TextBarra(int estadistica, double nivel) {
    double valor = estadistica / 120;
    return Positioned(
      top: nivel, // Ajusta la posición vertical según tus necesidades
      left: 125,
      right: 125,
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Alinea el texto a la izquierda
        children: [
          Transform.scale(
            scale: 1.9, // Reduzca el tamaño a la mitad
            child: LinearProgressIndicator(
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
              valueColor: AlwaysStoppedAnimation<Color>(
                Color.fromARGB(255, 61, 253, 3),
              ),
              value: valor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _PrimerTipoPoke(String tipo) {
    Color backgroundColor;

    // Utiliza una estructura de mapa para asignar el color según el tipo
    final Map<String, Color> tipoColorMap = {
      "FIRE": Color.fromARGB(255, 255, 17, 0),
      "WATER": const Color.fromARGB(255, 0, 140, 255),
      "GRASS": const Color.fromARGB(255, 0, 255, 8),
      "ELECTRIC": const Color.fromARGB(255, 255, 230, 0),
      "ICE": Color.fromARGB(255, 0, 225, 255),
      "STEEL": Color.fromARGB(255, 136, 136, 136),
      "BUG": Color.fromARGB(255, 130, 145, 0),
      "DRAGON": Color.fromARGB(255, 24, 0, 129),
      "GHOST": Color.fromARGB(255, 145, 71, 194),
      "FAIRY": Color.fromARGB(255, 255, 65, 255),
      "FIGHTING": Color(0xFFA05038),
      "NORMAL": Color.fromARGB(255, 255, 142, 49),
      "PSYCHIC": Color.fromARGB(255, 255, 3, 91),
      "ROCK": Color.fromARGB(255, 122, 92, 0),
      "DARK": Color.fromARGB(255, 0, 0, 0),
      "GROUND": Color.fromARGB(255, 136, 95, 0),
      "POISON": Color.fromARGB(172, 157, 0, 248),
      "FLYING": Color.fromARGB(255, 173, 188, 255),
    };
    // Verifica si el tipo está en el mapa, de lo contrario, usa un color predeterminado
    backgroundColor = (tipoColorMap.containsKey(tipo)
        ? tipoColorMap[tipo]
        : Color.fromARGB(255, 255, 255, 255))!;

    return Positioned(
      top: 175,
      left: 15,
      child: Container(
        width: 80,
        height: 35,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            tipo,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              shadows: [
                BoxShadow(
                  color: Color.fromARGB(255, 43, 43, 43),
                  offset: Offset(0, 2),
                ),
              ],
            ),
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: backgroundColor.withOpacity(0.8),
        ),
      ),
    );
  }

  Widget _SegundoTipoPoke(tipo) {
    Color backgroundColor;

    // Utiliza una estructura de mapa para asignar el color según el tipo
    final Map<String, Color> tipoColorMap = {
      "FIRE": Color.fromARGB(255, 255, 17, 0),
      "WATER": const Color.fromARGB(255, 0, 140, 255),
      "GRASS": const Color.fromARGB(255, 0, 255, 8),
      "ELECTRIC": const Color.fromARGB(255, 255, 230, 0),
      "ICE": Color.fromARGB(255, 0, 225, 255),
      "STEEL": Color.fromARGB(255, 136, 136, 136),
      "BUG": Color.fromARGB(255, 130, 145, 0),
      "DRAGON": Color.fromARGB(255, 24, 0, 129),
      "GHOST": Color.fromARGB(255, 145, 71, 194),
      "FAIRY": Color.fromARGB(255, 255, 65, 255),
      "FIGHTING": Color(0xFFA05038),
      "NORMAL": Color.fromARGB(255, 255, 142, 49),
      "PSYCHIC": Color.fromARGB(255, 255, 3, 91),
      "ROCK": Color.fromARGB(255, 122, 92, 0),
      "DARK": Color.fromARGB(255, 0, 0, 0),
      "GROUND": Color.fromARGB(255, 136, 95, 0),
      "POISON": Color.fromARGB(172, 137, 0, 216),
      "FLYING": Color.fromARGB(255, 173, 188, 255),
    };
    backgroundColor = (tipoColorMap.containsKey(tipo)
        ? tipoColorMap[tipo]
        : Color.fromARGB(0, 255, 255, 255))!;

    return Positioned(
      top: 215,
      left: 15,
      child: Container(
        width: 80, // Cambia el ancho del Container
        height: 35, // Cambia la altura del Container
        child: Padding(
          padding: const EdgeInsets.all(5), // Ajusta el espaciado interno
          child: Text(
            tipo,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13, // Cambia el tamaño del texto
              shadows: [
                BoxShadow(
                    color: Color.fromARGB(255, 22, 22, 22),
                    offset: Offset(0, 2))
              ],
            ),
          ),
        ),
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.all(Radius.circular(15)), // Reduce el radio
          color: backgroundColor.withOpacity(0.8),
        ),
      ),
    );
  }
}
