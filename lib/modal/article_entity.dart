class ArticleEntity {
	double rankIndex;
	bool original;
	int likeCount;
	String originalUrl;
	String screenshot;
	bool hot;
	String title;
	String type;
	String content;
	List<ArticleTag> tags;
	String createdAt;
	dynamic eventInfo;
	dynamic summaryInfo;
	int commentsCount;
	String lastCommentTime;
	bool viewerHasLiked;
	String id;
	ArticleCategory category;
	num hotIndex;
	ArticleUser user;
	String updatedAt;

	ArticleEntity({this.rankIndex, this.original, this.likeCount, this.originalUrl, this.screenshot, this.hot, this.title, this.type, this.content, this.tags, this.createdAt, this.eventInfo, this.summaryInfo, this.commentsCount, this.lastCommentTime, this.viewerHasLiked, this.id, this.category, this.hotIndex, this.user, this.updatedAt});

	ArticleEntity.fromJson(Map<String, dynamic> json) {
		rankIndex = json['rankIndex'];
		original = json['original'];
		likeCount = json['likeCount'];
		originalUrl = json['originalUrl'];
		screenshot = json['screenshot'];
		hot = json['hot'];
		title = json['title'];
		type = json['type'];
		content = json['content'];
		if (json['tags'] != null) {
			tags = new List<ArticleTag>();(json['tags'] as List).forEach((v) { tags.add(new ArticleTag.fromJson(v)); });
		}
		createdAt = json['createdAt'];
		eventInfo = json['eventInfo'];
		summaryInfo = json['summaryInfo'];
		commentsCount = json['commentsCount'];
		lastCommentTime = json['lastCommentTime'];
		viewerHasLiked = json['viewerHasLiked'];
		id = json['id'];
		category = json['category'] != null ? new ArticleCategory.fromJson(json['category']) : null;
		hotIndex = json['hotIndex'];
		user = json['user'] != null ? new ArticleUser.fromJson(json['user']) : null;
		updatedAt = json['updatedAt'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['rankIndex'] = this.rankIndex;
		data['original'] = this.original;
		data['likeCount'] = this.likeCount;
		data['originalUrl'] = this.originalUrl;
		data['screenshot'] = this.screenshot;
		data['hot'] = this.hot;
		data['title'] = this.title;
		data['type'] = this.type;
		data['content'] = this.content;
		if (this.tags != null) {
      data['tags'] =  this.tags.map((v) => v.toJson()).toList();
    }
		data['createdAt'] = this.createdAt;
		data['eventInfo'] = this.eventInfo;
		data['summaryInfo'] = this.summaryInfo;
		data['commentsCount'] = this.commentsCount;
		data['lastCommentTime'] = this.lastCommentTime;
		data['viewerHasLiked'] = this.viewerHasLiked;
		data['id'] = this.id;
		if (this.category != null) {
      data['category'] = this.category.toJson();
    }
		data['hotIndex'] = this.hotIndex;
		if (this.user != null) {
      data['user'] = this.user.toJson();
    }
		data['updatedAt'] = this.updatedAt;
		return data;
	}
}

class ArticleTag {
	String id;
	String title;

	ArticleTag({this.id, this.title});

	ArticleTag.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		title = json['title'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['title'] = this.title;
		return data;
	}
}

class ArticleCategory {
	String name;
	String id;

	ArticleCategory({this.name, this.id});

	ArticleCategory.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		id = json['id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = this.name;
		data['id'] = this.id;
		return data;
	}
}

class ArticleUser {
	dynamic avatarHd;
	String role;
	String id;
	String avatarLarge;
	String username;

	ArticleUser({this.avatarHd, this.role, this.id, this.avatarLarge, this.username});

	ArticleUser.fromJson(Map<String, dynamic> json) {
		avatarHd = json['avatarHd'];
		role = json['role'];
		id = json['id'];
		avatarLarge = json['avatarLarge'];
		username = json['username'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['avatarHd'] = this.avatarHd;
		data['role'] = this.role;
		data['id'] = this.id;
		data['avatarLarge'] = this.avatarLarge;
		data['username'] = this.username;
		return data;
	}
}
