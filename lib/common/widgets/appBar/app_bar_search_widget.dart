import 'package:alumni_hub_ft_uh/common/utils/custom_dialog.dart';
import 'package:alumni_hub_ft_uh/common/widgets/button/button_widget.dart';
import 'package:alumni_hub_ft_uh/constants/colors.dart';
import 'package:alumni_hub_ft_uh/features/user/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:alumni_hub_ft_uh/features/search/search_screen.dart';
import 'package:alumni_hub_ft_uh/common/widgets/appBar/app_bar_menu_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Import ProfileScreen

class AppBarSearchWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const AppBarSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final userSession = context.read<UserBloc>().getUserSession();

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.black),
        onPressed: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return const AppBarMenuWidget();
              },
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(-1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.easeInOut;

                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);

                return SlideTransition(position: offsetAnimation, child: child);
              },
            ),
          );
        },
      ),
      title: Container(
        height: 35,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1.0),
          borderRadius: BorderRadius.circular(40.0),
        ),
        child: Row(
          children: [
            const Icon(Icons.search, color: Colors.black),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchScreen()),
                  );
                },
                child: AbsorbPointer(
                  child: TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.black54),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 8.0),
                    ),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: CircleAvatar(
            backgroundImage: userSession?.user?.avatar != null
                ? NetworkImage(userSession?.user?.avatar ?? '')
                : Image.asset('assets/logos/ikatek_unhas.webp').image,
          ),
          onPressed: () {
            if (userSession?.user?.alumni != null) {
              Navigator.pushNamed(context, '/profile');
            } else {
              CustomDialog.showCustomDialog(
                context,
                title: 'Klaim Data Alumni',
                content: Text(
                  'Untuk mendapatkan akses full, isi kelengkapan data alumni',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                actions: [
                  Expanded(
                    child: ButtonWidget(
                      label: 'Nanti',
                      color: AppColors.secondaryColor,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ButtonWidget(
                      label: 'Klaim Data',
                      onPressed: () {
                        Navigator.of(context).pushNamed('/claim_alumni_data');
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
