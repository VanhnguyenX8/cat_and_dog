class Animal {
  String title;
  String img;
  String audio;
  Animal({required this.title, required this.img, required this.audio});
}

//TODO: user builder to init class
class AnimalProfile {
  String? title;
  String? img;
  String? audio;
  AnimalProfile._builder(AnimalProfileBuilder animalProfileBuilder)
      : title = animalProfileBuilder.title!,
        img = animalProfileBuilder.img,
        audio = animalProfileBuilder.audio;
}

class AnimalProfileBuilder {
  String? title;
  String? img;
  String? audio;
  AnimalProfileBuilder setTitle(String title) {
    this.title = title;
    return this;
  }

  AnimalProfileBuilder setImg(String img) {
    this.img = img;
    return this;
  }

  AnimalProfileBuilder setAudio(String audio) {
    this.audio = audio;
    return this;
  }

  AnimalProfile builder() {
    return AnimalProfile._builder(this);
  }
}
