// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:training_project/cubit/home_cubit/home_cubit.dart';
import 'package:training_project/models/home_model.dart';
import 'package:training_project/requests/home_request.dart';
import 'package:training_project/screens/screens/details.dart';
import 'package:training_project/screens/screens/favorite.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> favoriteItems = [];

  void toggleFavorite(String item) {
    setState(() {
      if (favoriteItems.contains(item)) {
        favoriteItems.remove(item);
      } else {
        favoriteItems.add(item);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    Provider.of<HomeRequest>(context, listen: false).fetchPersons();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth > 600
        ? 4
        : screenWidth > 400
            ? 3
            : 2;
    final imageHeight = screenWidth /
        crossAxisCount *
        0.9; // Adjust image size based on screen width

    return Scaffold(
      backgroundColor: const Color(0xffa17181f),
      appBar: AppBar(
        backgroundColor: const Color(0xffa17181f),
        title: const Text(
          "Home",
          style: TextStyle(
              color: Color(0xff653df4),
              fontSize: 28.0,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Favorite(
                        favoriteItems: favoriteItems,
                      ),
                    ));
              },
              icon: const Icon(
                Icons.favorite,
                color: Color(0xff653df4),
                size: 28.0,
              ))
        ],
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Consumer<HomeRequest>(
            builder: (context, homeProvider, child) {
              if (homeProvider.persons.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: homeProvider.persons.length,
                    itemBuilder: (context, index) {
                      Person person = homeProvider.persons[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => Details(
                                      personName: person.name,
                                      personId: person.id)));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xffa17181f),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xff653df4).withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      'https://image.tmdb.org/t/p/w500${person.profilePath}',
                                      width: MediaQuery.of(context).size.width /
                                          crossAxisCount,
                                      height: imageHeight,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    person.name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                              Positioned(
                                right: 0,
                                child: IconButton(
                                  onPressed: () =>
                                      toggleFavorite(person.id.toString()),
                                  icon: Icon(
                                    favoriteItems.contains(person.id.toString())
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: favoriteItems
                                            .contains(person.id.toString())
                                        ? Colors.red
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
