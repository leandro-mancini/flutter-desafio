import 'package:flutter/material.dart';
import 'package:flutter_characters/src/pages/search/search_controller.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_shared/flutter_shared.dart';

class SearchPage extends StatefulWidget {
  final String searchText;

  const SearchPage({Key? key, required this.searchText}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchController = SearchController();
  final searchValueController = TextEditingController();

  @override
  void dispose() {
    searchValueController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    searchValueController.text = widget.searchText;
    searchController.getFilteredCharacters(widget.searchText);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(
        title: 'Busca',
        centerTitle: true,
        searchHintText: 'Buscar personagens',
        searchController: searchValueController,
        textInputAction: TextInputAction.search,
        onSubmitted: (value) => searchController.getFilteredCharacters(value),
        onPressedLeadingIcon: () => Modular.to.pop(),
      ),
      body: SafeArea(
        child: buildList(),
      ),
    );
  }

  Widget buildList() {
    return Observer(
      builder: (_) {
        if (searchController.characters.isEmpty && searchController.hasCharacters) {
          return const FeedbackPageWidget(
            illustration: Assets.ilSearch,
            message: 'Desculpe, não conseguimos \n encontrar o personagem',
          );
        }

        return SkeletonListWidget(
          itemCount: 10,
          isLoading: !searchController.hasCharacters,
          child: ListView.builder(
            itemCount: searchController.characters.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(searchController.characters[index].image),
                  backgroundColor: Colors.grey[300]
                ),
                title: Text(searchController.characters[index].name),
                subtitle: Text(searchController.characters[index].species),
                onTap: () => Modular.to.pushNamed('/character/${searchController.characters[index].id}'),
              );
            },
          ),
        );
      },
    );
  }
}