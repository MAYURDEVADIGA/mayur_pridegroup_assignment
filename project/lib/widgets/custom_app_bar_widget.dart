import 'package:flutter/material.dart';
import 'package:mayur_pridegroup_assignment/widgets/white_text_widget.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      title: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                WhiteText(
                  title: '!',
                  fontStyle: FontStyle.italic,
                ),
                WhiteText(title: 'Symbol'),
              ],
            ),
          ),
          Flexible(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  WhiteText(title: 'Bid'),
                  SizedBox(
                    width: 100,
                  ),
                  WhiteText(title: 'Ask'),
                ],
              )),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
