import 'package:flutter/material.dart';
import 'api.dart';
import 'movie_details.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) onThemeChanged;
  final String category;

  const HomeScreen({
    required this.isDarkMode,
    required this.onThemeChanged,
    required this.category,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isGrid = false;
  List<Movie> allMovies = [];
  List<Movie> filteredMovies = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  void _loadMovies() async {
    final movies = await fetchMoviesByCategory(widget.category);
    setState(() {
      allMovies = movies;
      filteredMovies = movies;
    });
  }

  void _filterMovies(String query) {
    setState(() {
      searchQuery = query;
      filteredMovies =
          allMovies
              .where(
                (movie) =>
                    movie.title.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading:
            Navigator.canPop(context)
                ? IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                )
                : null,
        title: Text('Filmy'),
        actions: [
          IconButton(
            icon: Icon(isGrid ? Icons.list : Icons.grid_view),
            onPressed: () {
              setState(() {
                isGrid = !isGrid;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => SettingsScreen(
                        isDarkMode: widget.isDarkMode,
                        onThemeChanged: widget.onThemeChanged,
                      ),
                ),
              );
            },
          ),
        ],
      ),
      body:
          allMovies.isEmpty
              ? Center(child: CircularProgressIndicator())
              : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Szukaj filmu...',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onChanged: _filterMovies,
                    ),
                  ),
                  Expanded(
                    child:
                        isGrid
                            ? GridView.builder(
                              padding: EdgeInsets.all(10),
                              itemCount: filteredMovies.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 0.6,
                                  ),
                              itemBuilder: (context, index) {
                                final movie = filteredMovies[index];
                                return _buildMovieCard(movie);
                              },
                            )
                            : ListView.builder(
                              itemCount: filteredMovies.length,
                              itemBuilder: (context, index) {
                                final movie = filteredMovies[index];
                                return _buildMovieTile(movie);
                              },
                            ),
                  ),
                ],
              ),
    );
  }

  Widget _buildMovieTile(Movie movie) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => MovieDetailsPage(movie: movie)),
        );
      },
      leading: Hero(
        tag: movie.title,
        child: FadeInImage.assetNetwork(
          placeholder: 'assets/images/photo_placeholder.png',
          image: 'https://image.tmdb.org/t/p/w92${movie.posterPath}',
          fit: BoxFit.cover,
          imageErrorBuilder:
              (_, __, ___) => Image.asset(
                'assets/images/photo_placeholder.png',
                fit: BoxFit.cover,
              ),
        ),
      ),
      title: Text(movie.title),
      subtitle: Text(
        movie.overview,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildMovieCard(Movie movie) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => MovieDetailsPage(movie: movie)),
        );
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Hero(
                tag: movie.title,
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/photo_placeholder.png',
                  image: 'https://image.tmdb.org/t/p/w342${movie.posterPath}',
                  fit: BoxFit.cover,
                  imageErrorBuilder:
                      (_, __, ___) => Image.asset(
                        'assets/images/photo_placeholder.png',
                        fit: BoxFit.cover,
                      ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                movie.title,
                style: TextStyle(fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
