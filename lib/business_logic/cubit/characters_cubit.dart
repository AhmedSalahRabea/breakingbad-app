import 'package:bloc/bloc.dart';
import '../../data/models/characters.dart';
import '../../data/models/quotes.dart';
import '../../data/repository/characters_repository.dart';
import 'package:meta/meta.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  //this var/object to be can access to function getAllCharacters()
  final CharactersRepository charactersRepository;
  //to store the returned list from the function in it
  List<Character> characters = [];
  List<Quote> quotes = [];
  //the constructor
  CharactersCubit(this.charactersRepository) : super(CharactersInitial());
  //this function will take the data from Repository class
  //for this reason we will not use async and await
  List<Character> getAllCharacters() {
    charactersRepository.getAllCharacters().then((characters) {
      emit(CharactersLoaded(characters));
      this.characters = characters;
    });
    return characters;
  }

  void getQuotes(String charName) {
    charactersRepository.getCharacterQuotes(charName).then((quotes) {
      emit(QuotesLoaded(quotes));
    });
  }
}
