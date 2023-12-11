import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_app/Feature/presentation/screens/posts_screen.dart';
import 'Feature/presentation/bloc/add_update_delete_post_bloc/add_update_delete_post_bloc.dart';
import 'Feature/presentation/bloc/posts_bloc/post_bloc.dart';
import 'bloc_observe.dart';
import 'injection_container.dart' as di;

void main() async {
    Bloc.observer = MyBlocObserver();

  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.sl<PostBloc>()..add(GetPostsEvent())),
        BlocProvider(create: (context) => di.sl<AddUpdateDeletePostBloc>()),
      ],
     
      child: MaterialApp(
        title: 'Post App',
      debugShowCheckedModeBanner: false,
        
        home: PostsScreen(),
      ),
    );
  }
}

