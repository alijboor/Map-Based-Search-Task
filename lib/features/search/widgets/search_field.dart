import 'package:flutter/material.dart';
import 'package:map_search/core/constants/lang_keys.dart';
import 'package:map_search/features/search/providers/search_provider_screen.dart';
import 'package:provider/provider.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProviderScreen>(builder: (context, provider, child) {
      return Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: Container(
          margin: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: const BorderRadius.all(Radius.circular(18))),
          child: TextFormField(
            onChanged: provider.onSearch,
            decoration: InputDecoration(
                hintText: LangKeys.searchHint,
                border: InputBorder.none,
                prefixIcon: provider.isLoading
                    ? const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: CircularProgressIndicator(
                          color: Colors.amberAccent),
                    )
                    : const Icon(Icons.search_rounded,
                        color: Colors.amberAccent),
                suffixIcon: const Icon(Icons.map_outlined)),
          ),
        ),
      );
    });
  }
}
