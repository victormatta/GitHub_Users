import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:github_users/data/repositories/github_repository.dart';
import 'package:github_users/pages/home/home_controller.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final HomeController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = HomeController(
      repository: GithubRepository(
        dio: Dio(),
    ),
    );
    _controller.getGithubUsers();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("GitHub Users")),
        backgroundColor: Colors.blue.shade500,
      ),
      body: Obx(
        () {
          return _controller.isLoading.value ?
          const Center(child: CircularProgressIndicator())
          : _controller.users.isEmpty
            ? const Center(
              child: Text("None user found."),
            )
            : ListView.separated(
              separatorBuilder: (_, __) => const Divider(),
              itemCount: _controller.users.length,
              itemBuilder: (context, index) {
                final user = _controller.users[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    radius: 50,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: CircleAvatar(
                        radius: 45,
                        backgroundImage: NetworkImage(user.avatarUrl),
                      ),
                    ),
                  ),
                  title: const Text(
                    "User",
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                  subtitle: Text(
                    user.login,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {},
                );
              },
            );
        },
      ),
    );
  }
}