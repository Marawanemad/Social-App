import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/Screens/AppScreens/Feeds/FeedsWidgets.dart';
import 'package:socialapp/Screens/Home.dart/Cubit/Cubit.dart';
import 'package:socialapp/Screens/Home.dart/Cubit/States.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (BuildContext context, SocialState state) {},
      builder: (BuildContext context, SocialState state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          body: ConditionalBuilder(
            condition: cubit.postList.length > 0 ||
                state is SocialGetPostsSuccessState,
            builder: (BuildContext context) => RefreshIndicator(
              // to make refresh
              onRefresh: () {
                cubit.getPosts();
                return Future(() => null);
              },
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Stack_Card(
                        ImageURL:
                            "https://img.freepik.com/free-photo/joyful-curly-haired-girl-points-thumb-right-shows-copy-space-area-giggles-positively-wears-denim-jacket-isolated-purple-wall-demonstrates-nice-advert-against-purple-wall_273609-42305.jpg?t=st=1707953101~exp=1707953701~hmac=8ba725f26c21fb33a99c0b272105cf8be79dc5d8c65f769c3c78a99856c29b98",
                        height: MediaQuery.of(context).size.width * 0.5,
                        StackText: "Communicate with friends"),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => posts(
                          model: cubit.postList[index],
                          context: context,
                          index: index),
                      itemCount: cubit.postList.length,
                    )
                  ],
                ),
              ),
            ),
            fallback: (BuildContext context) =>
                Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
