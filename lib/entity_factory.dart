import 'package:juejin_app/modal/book_entity.dart';
import 'package:juejin_app/modal/activity_entity.dart';
import 'package:juejin_app/modal/article_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "BookEntity") {
      return BookEntity.fromJson(json) as T;
    } else if (T.toString() == "ActivityEntity") {
      return ActivityEntity.fromJson(json) as T;
    } else if (T.toString() == "ArticleEntity") {
      return ArticleEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}