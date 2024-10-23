// 카테고리 클래스 정의
class Category {
  final String name; // 카테고리 이름
  final List<Place> places; // 해당 카테고리의 장소 목록
  bool isOn;

  Category(this.name, this.places, {this.isOn = false}); // 생성자
}

// 장소 클래스 정의
class Place {
  final String name; // 장소 이름
  final String description; // 장소 설명
  final String imageUrl; // 장소 이미지 URL
  final String id;
  final String category;
  bool isSelected; // 선택 여부를 나타내는 플래그

  Place(this.name, this.description, this.imageUrl, this.id, this.category,
      {this.isSelected = false}); // 생성자
}
