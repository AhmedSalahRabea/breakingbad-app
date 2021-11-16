import '../business_logic/cubit/characters_cubit.dart';
import '../data/models/characters.dart';
import '../data/repository/characters_repository.dart';
import '../data/web_services/characters_web_services.dart';
import '../presentation/screens/characters_details_screen.dart';
import '../presentation/screens/characters_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/strings.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;
  AppRouter() {
    charactersRepository = new CharactersRepository(CharactersWebServices());
    charactersCubit = new CharactersCubit(charactersRepository);
  }
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => charactersCubit,
            child: CharactersScreen(),
          ),
        );
      case characterDetailsScreen:
        final character = settings.arguments as Character;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => CharactersCubit(charactersRepository),
                  child: CharacterDetailsScreen(
                    character: character,
                  ),
                ));
    }
  }
}
