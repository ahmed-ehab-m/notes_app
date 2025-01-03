import 'package:Notes/constants.dart';
import 'package:Notes/cubits/notes%20cubit/notes_cubit.dart';
import 'package:Notes/helper/responsive.dart';
import 'package:Notes/models/note_model.dart';
import 'package:Notes/views/edit_note_view.dart';
import 'package:Notes/views/widgets/custom_icon.dart';
import 'package:Notes/views/widgets/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:pie_menu/pie_menu.dart';

class GridNoteItem extends StatelessWidget {
  const GridNoteItem(
      {super.key,
      required this.noteModel,
      required this.onSelectPin,
      required this.status,
      required this.showPin,
      required this.textTitle,
      required this.textSubTitle,
      required this.pieTheme});
  final NoteModel noteModel;
  final dynamic Function() onSelectPin;
  final String status;
  final bool showPin;
  final Widget textTitle;
  final Widget textSubTitle;
  final PieTheme? pieTheme;

  @override
  Widget build(BuildContext context) {
    return PieMenu(
      theme: pieTheme,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return EditNoteView(
                noteModel: noteModel,
              );
            },
          ),
        );
      },
      actions: [
        PieAction(
            tooltip: Text(status),
            onSelect: onSelectPin,
            child: noteModel.pin
                ? const Icon(HugeIcons.strokeRoundedPinOff)
                : const Icon(HugeIcons.strokeRoundedPin)),
        PieAction(
          tooltip: const Text(
            'Delete',
          ),
          onSelect: () {
            noteModel.delete();
            BlocProvider.of<NotesCubit>(context).fetchAllNotes();

            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                  CustomSnackBar().buildSnackBar(message: 'note deleted'));
          },
          child:
              const Icon(HugeIcons.strokeRoundedDelete02), // Can be any widget
        ),
      ],
      child: Stack(
        children: [
          Container(
            padding: ResponsiveSpacing.allPadding(16),
            decoration: BoxDecoration(
                color: Color(noteModel.color),
                borderRadius:
                    BorderRadius.circular(ResponsiveSpacing.value(16))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textTitle,
                Padding(
                    padding: ResponsiveSpacing.onlyPadding(left: 10, top: 10),
                    child: textSubTitle),
                SizedBox(
                  height: ResponsiveSpacing.vertical(20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      noteModel.date,
                      style: TextStyle(
                        // color: Colors.white70,
                        fontSize: ResponsiveSpacing.fontSize(12),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (showPin)
            Positioned(
              right: ResponsiveSpacing.value(45),
              bottom: ResponsiveSpacing.value(16),
              child: CustomIcon(
                icon: HugeIcons.strokeRoundedPin,
                iconColor: kPrimaryColor,
                onPressed: () {},
                iconSize: ResponsiveSpacing.value(16),
              ),
            ),
        ],
      ),
    );
  }
}
