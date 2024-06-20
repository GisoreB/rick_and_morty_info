import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagination_view/pagination_view.dart';

import '../../../../core/types/vital_status.dart';
import '../../domain/entities/character.dart';
import '../bloc/home_bloc.dart';
import 'status_empty.dart';
import 'status_error.dart';

class CharactersList extends StatelessWidget {
  const CharactersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) => PaginationView<Character>(
        itemBuilder: (context, character, index) => ListTile(
          leading: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(character.image),
          ),
          title: Text(character.name),
          subtitle: Text(character.species),
          trailing: character.vitalStatus.when(
            alive: () => Icon(Icons.tag_faces),
            dead: () => Icon(Icons.sentiment_very_dissatisfied),
            unknown: () => Icon(Icons.help_outline),
          ),
        ),
        pageFetch: context.read<HomeBloc>().getCharactersInPage,
        onEmpty: StatusEmpty(),
        onError: (exception) => StatusError(exception: exception),
      ),
    );
  }
}