import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../blocs/incom/incom_bloc.dart';
import '../../core/utilsss.dart';
import '../../core/widgets/loading_widget.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<IncomBloc, IncomState>(
        listener: (context, state) {
          if (state is IncomLoaded) {
            Future.delayed(
              const Duration(seconds: 2),
              () {
                if (context.mounted) {
                  if (onboard) {
                    context.go('/onboarding');
                  } else {
                    context.go('/home');
                  }
                }
              },
            );
          }
        },
        builder: (context, state) {
          return const LoadingIndicator();
        },
      ),
    );
  }
}
