// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:training_project/cubit/home_cubit/home_cubit.dart';
import 'package:training_project/requests/home_request.dart';
import 'package:training_project/screens/screens/details.dart';

class Favorite extends StatefulWidget {
  final List<String> favoriteItems;

  const Favorite({super.key, required this.favoriteItems});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  void initState() {
    super.initState();
    Provider.of<HomeRequest>(context, listen: false).fetchPersons();
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeRequest>(context);
    final homeCubit = Provider.of<HomeCubit>(context,
        listen: false); // Get HomeCubit instance

    // Responsive width configuration
    final screenWidth = MediaQuery.of(context).size.width;
    final imageWidth =
        screenWidth * 0.3; // Adjust image width based on screen width
    final isFavoriteListEmpty = widget.favoriteItems.isEmpty;

    return Scaffold(
      backgroundColor: const Color(0xffa17181f),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Favorites',
          style: TextStyle(
            color: Color(0xff653df4),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xffa17181f),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return isFavoriteListEmpty
              ? const Center(
                  child: Text(
                    "Favorite List is Empty",
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    itemCount: widget.favoriteItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      final personId = int.parse(widget.favoriteItems[index]);
                      final person = homeProvider.persons
                          .firstWhere((person) => person.id == personId);
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Details(
                                personName: person.name,
                                personId: person.id, // Pass the person ID
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color(0xffa17181f),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color(0xff653df4).withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 2), // Shadow position
                                ),
                              ],
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    'https://image.tmdb.org/t/p/w500${person.profilePath}',
                                    width: imageWidth,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Text(
                                    person.name,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 18),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    homeCubit.removePerson(person.id
                                        .toString()); // Call removePerson on HomeCubit
                                    setState(() {
                                      widget.favoriteItems.removeAt(
                                          index); // Update the local favoriteItems list
                                    });
                                  },
                                  child: const Text(
                                    "Remove",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                                const SizedBox(
                                  width: 16,
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
        },
      ),
    );
  }
}
