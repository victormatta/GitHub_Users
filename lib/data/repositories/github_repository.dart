import 'package:dio/dio.dart';
import 'package:github_users/data/models/github_user_model.dart';

class GithubRepository {
  GithubRepository({required this.dio});

  final Dio dio;

  Future<List<GithubUserModel>> getGitHubUsers() async {
    final result = await dio.get('https://api.github.com/users');

    final List<GithubUserModel> users = [];

    if(result.statusCode == 200) {
      result.data.map((item) => users.add(GithubUserModel.fromMap(item))).toList();
    }

    return users;
  }
}