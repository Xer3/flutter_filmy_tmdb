import 'dart:convert';
import 'package:http/http.dart' as http;

class Movie {
  final int id;
  final String title;
  final String overview;
  final String posterPath;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'] ?? '',
    );
  }
}

Future<List<Movie>> fetchPopularMovies() async {
  const String apiKey = '08700e82be3aeda4c60cbff85cc9284d';
  final response = await http.get(
    Uri.parse(
      'https://api.themoviedb.org/3/movie/popular?api_key=$apiKey&language=pl-PL&page=1',
    ),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final List results = data['results'];
    return results.map((json) => Movie.fromJson(json)).toList();
  } else {
    throw Exception('Nie udało się pobrać filmów');
  }
}
