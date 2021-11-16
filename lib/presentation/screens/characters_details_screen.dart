import 'dart:math';

import '../../business_logic/cubit/characters_cubit.dart';
import '../../constants/mycolors.dart';
import '../../data/models/characters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Character character;

  const CharacterDetailsScreen({Key? key, required this.character})
      : super(key: key);
  //const CharacterDetailsScreen({Key? key,required this.character}) : super(key: key);
  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColor.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        //centerTitle: true,
        title: Text(
          character.nickName,
          style: TextStyle(
            color: MyColor.myWhite,
          ),
          //textAlign: TextAlign.start,
        ),
        background: Hero(
            tag: character.charId,
            child: Image.network(
              character.image,
              fit: BoxFit.cover,
            )),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: MyColor.myWhite,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              fontSize: 16,
              color: MyColor.myWhite,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      color: MyColor.myYellow,
      height: 30,
      endIndent: endIndent,
      thickness: 2,
    );
  }

  Widget checkIfQoutesAreLoaded(CharactersState state) {
    if (state is QuotesLoaded) {
      return displayRandomQuoteOrEmptySpace(state);
    } else {
      return showProgressIndicator();
    }
  }

  Widget displayRandomQuoteOrEmptySpace(state) {
    var quotes = (state).quotes;
    if (quotes.length != 0) {
      int randomQouteIndex = Random().nextInt(quotes.length - 1);
      return Center(
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            color: MyColor.myWhite,
            shadows: [
              Shadow(
                blurRadius: 7.0,
                color: MyColor.myYellow,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              FlickerAnimatedText(quotes[randomQouteIndex].quote),
            ],
            onTap: () {
              print("Tap Event");
            },
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget showProgressIndicator() {
    return Center(
      child: CircularProgressIndicator(
        color: MyColor.myYellow,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharactersCubit>(context).getQuotes(character.name);
    return Scaffold(
      backgroundColor: MyColor.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      characterInfo('job : ', character.jobs.join(' / ')),
                      buildDivider(315),
                      characterInfo(
                          'appeard in : ', character.categoryForTwoSeries),
                      buildDivider(250),
                      characterInfo('seasons : ',
                          character.appearanceOfSeasons.join(' / ')),
                      buildDivider(280),
                      characterInfo('status : ', character.statusIfDeadOrAlive),
                      buildDivider(300),
                      if (character.betterCallSaulAppearance.isNotEmpty)
                        characterInfo('Better Call Saul Seasons : ',
                            character.betterCallSaulAppearance.join(' / ')),
                      if (character.betterCallSaulAppearance.isNotEmpty)
                        buildDivider(150),
                      characterInfo('Actros / Actress : ', character.actorName),
                      buildDivider(235),
                      SizedBox(
                        height: 20,
                      ),
                      BlocBuilder<CharactersCubit, CharactersState>(
                          builder: (context, state) {
                        return checkIfQoutesAreLoaded(state);
                      }),
                    ],
                  ),
                ),
                SizedBox(
                  height: 420,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
