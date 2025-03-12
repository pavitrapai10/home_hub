class HomeStore {
  String searchQuery = '';
  String selectedQuickSearch = "All";
  int selectedCategoryIndex = 0;
  int selectedTab = 0;
  String selectedCategory = ""; 

  List<String> banners = [
    'assets/images/banner.jpg',
    'assets/images/banner1.jpg',
    'assets/images/banner2.jpg',
  ];

  List<String> categories = [
    'Choose Category',  
    'Cleaning', 
    'Painting', 
    'Plumbing', 
    'Electrician', 
    'Carpentry'
  ];

  List<String> subcategories = [
    'Home Cleaning', 'Office Cleaning', 'Wall Painting', 'Pipe Fixing'
  ];

  List<String> subCategoriesRandom = [
    "Plumbing", "Electrical", "Cleaning", "Painting"
  ];

  List<String> providers = [
    'John Doe - 20% Off', 'Mike’s Services - 10% Off', 'Elite Plumbers - 15% Off'
  ];

  List<String> quickSearchOptions = [
    'All', 'Cleaning', 'Painting', 'Plumbing', 'Electrician'
  ];

  String selectedFilter = "All"; 

  void setFilter(String filter) {
    selectedFilter = filter;
  }

  void updateSearchQuery(String query) {
    searchQuery = query;
  }

  void updateQuickSearch(String option) {
    selectedQuickSearch = option;
  }

  void selectCategory(int index) {
    selectedCategoryIndex = index;
  }

  void setSelectedCategory(String category) {
    selectedCategory = category;
  }

  void changeTab(int index) {
    selectedTab = index;
  }
}
