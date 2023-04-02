class RecipeModel{
  late String applabel;
  late String appimgUrl;
  late double appcalories;
  late String appurl;

  RecipeModel({
    this.applabel = "LABEL",
    this.appimgUrl = "IMAGE",
    this.appcalories = 0.000,
    this.appurl = "URL",
  });

  factory RecipeModel.fromMap(Map recipe){
    return RecipeModel(
        applabel: recipe["label"],
        appimgUrl: recipe["image"],
        appcalories: recipe["calories"],
        appurl: recipe["url"]
    );
  }
}