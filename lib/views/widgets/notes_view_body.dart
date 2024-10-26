import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/cubits/notes%20cubit/notes_cubit.dart';
import 'package:notes_app/views/widgets/custom_app_bar.dart';
import 'package:notes_app/views/widgets/custom_notes_list_view.dart';
import 'package:notes_app/views/widgets/custom_text_field.dart';

class NotesViewBody extends StatefulWidget {
  const NotesViewBody({super.key});

  @override
  State<NotesViewBody> createState() => _NotesViewBodyState();
}

class _NotesViewBodyState extends State<NotesViewBody> {
  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<NotesCubit>(context).fetchAllNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 50,
          ),
          const CustomAppBar(
            title: 'My Notes',
            icon: CupertinoIcons.settings,
          ),
          const SizedBox(
            height: 15,
          ),
          CustomTextField(
            text: 'Search',
          ),
          const SizedBox(
            height: 10,
          ),
          const Expanded(child: CustomNotesListView()),
        ],
      ),
    );
  }
}
