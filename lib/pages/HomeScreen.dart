import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pk/models/Pokemon.dart';
import 'package:pk/pages/DetailsScreen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PokemonRepository _pokemonRepository = PokemonRepository();
  @override
  Widget build(BuildContext context) {
    var tam = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Stack(
        children: [_Imagenpokeball(), _TextoTitulo(), _Contenido(tam)],
      ),
    );
  }

  Widget _ImagenFondo() {
    return Positioned(
      child: Image.asset(
        'images/pokeball.gif',
        fit: BoxFit.fitWidth,
        width: 490,
      ),
    );
  }

  Widget _Imagenpokeball() {
    return Positioned(
      top: -20,
      right: -30,
      child: Image.asset(
        'images/iconp.png',
        fit: BoxFit.fitWidth,
        width: 200,
      ),
    );
  }

  Widget _TextoTitulo() {
    return Positioned(
        top: 50,
        right: 220,
        child: Text(
          "Pokédex",
          style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0)
                  .withOpacity(0.7), // Agrega una coma aquí
              fontWeight: FontWeight.bold,
              fontSize: 35),
        ));
  }

  Widget _Contenido(var tam) {
    return FutureBuilder<List<Pokemon>>(
      key: UniqueKey(),
      future: _pokemonRepository.loadPokemonData(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Error al cargar los datos'),
          );
        } else if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final pokemonList = snapshot.data!;
          return Positioned(
            top: 90,
            bottom: 0,
            width: tam,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.4,
              ),
              itemCount: pokemonList.length,
              //itemCount: 30,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final pokemon = pokemonList[index];

                // Define una función para obtener el color de fondo del tipo de Pokémon
                Color? getBackgroundColor(String type) {
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
                    "POISON": Color.fromARGB(172, 66, 0, 104),
                    "FLYING": Color.fromARGB(255, 173, 188, 255),
                  };

                  // Verifica si el tipo está en el mapa, de lo contrario, usa un color predeterminado
                  return tipoColorMap.containsKey(type)
                      ? tipoColorMap[pokemon.type1]
                      : Colors.white;
                }

                // Obtiene el color de fondo del tipo del Pokémon
                final backgroundColor = getBackgroundColor(pokemon.type1);

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 5,
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DetailsScreen(
                              pokemon: pokemon,
                              backgroundColor: backgroundColor),
                        ),
                      );
                    },
                    child: SafeArea(
                      child: Container(
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: -10,
                              right: -10,
                              child: Image.asset(
                                'images/poke.png',
                                height: 120,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                            // Reemplaza las líneas a continuación con tus widgets personalizados
                            _pokemon(pokemon.sprite),
                            _TextoPoke(pokemon.name),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }

  Widget _pokemon(String pokemonNombre) {
    return Positioned(
      bottom: 2,
      right: 11,
      child: CachedNetworkImage(
        imageUrl: pokemonNombre,
        height: 90,
        fit: BoxFit.fitHeight,
        placeholder: ((context, url) => Center(
              child: CircularProgressIndicator(),
            )),
      ),
    );
  }

  Widget _TextoPoke(String name) {
    return Positioned(
        top: 16,
        left: 15,
        child: Text(
          name,
          style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255)
                  .withOpacity(0.9), // Agrega una coma aquí
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ));
  }

  Widget _PrimerTipoPoke() {
    return Positioned(
      top: 50,
      left: 15,
      child: Container(
        width: 50, // Cambia el ancho del Container
        height: 20, // Cambia la altura del Container
        child: Padding(
          padding: const EdgeInsets.all(5), // Ajusta el espaciado interno
          child: Text(
            'Steel',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10, // Cambia el tamaño del texto
              shadows: [
                BoxShadow(color: Colors.blueGrey, offset: Offset(0, 2))
              ],
            ),
          ),
        ),
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.all(Radius.circular(10)), // Reduce el radio
          color: Color.fromARGB(255, 177, 177, 177).withOpacity(0.9),
        ),
      ),
    );
  }

  Widget _SegundoTipoPoke() {
    return Positioned(
      top: 70,
      left: 15,
      child: Container(
        width: 50, // Cambia el ancho del Container
        height: 20, // Cambia la altura del Container
        child: Padding(
          padding: const EdgeInsets.all(5), // Ajusta el espaciado interno
          child: Text(
            'Fairy',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10, // Cambia el tamaño del texto
              shadows: [
                BoxShadow(color: Colors.blueGrey, offset: Offset(0, 2))
              ],
            ),
          ),
        ),
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.all(Radius.circular(15)), // Reduce el radio
          color: Color.fromARGB(255, 255, 0, 170).withOpacity(0.8),
        ),
      ),
    );
  }
}
