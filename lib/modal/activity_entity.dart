class ActivityEntity {
	String urlPic;
	String urlTitle;
	bool isLiked;
	int likedCount;
	String content;
	List<String> pictures;
	String url;
	int commentCount;
	String uid;
	String createdAt;
	String topicId;
	bool isTopicRecommend;
	ActivityTopic topic;
	ActivityUser user;
	bool folded;
	String objectId;
	String updatedAt;

	ActivityEntity({this.urlPic, this.urlTitle, this.isLiked, this.likedCount, this.content, this.pictures, this.url, this.commentCount, this.uid, this.createdAt, this.topicId, this.isTopicRecommend, this.topic, this.user, this.folded, this.objectId, this.updatedAt});

	ActivityEntity.fromJson(Map<String, dynamic> json) {
		urlPic = json['urlPic'];
		urlTitle = json['urlTitle'];
		isLiked = json['isLiked'];
		likedCount = json['likedCount'];
		content = json['content'];
		pictures = json['pictures']?.cast<String>();
		url = json['url'];
		commentCount = json['commentCount'];
		uid = json['uid'];
		createdAt = json['createdAt'];
		topicId = json['topicId'];
		isTopicRecommend = json['isTopicRecommend'];
		topic = json['topic'] != null ? new ActivityTopic.fromJson(json['topic']) : null;
		user = json['user'] != null ? new ActivityUser.fromJson(json['user']) : null;
		folded = json['folded'];
		objectId = json['objectId'];
		updatedAt = json['updatedAt'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['urlPic'] = this.urlPic;
		data['urlTitle'] = this.urlTitle;
		data['isLiked'] = this.isLiked;
		data['likedCount'] = this.likedCount;
		data['content'] = this.content;
		data['pictures'] = this.pictures;
		data['url'] = this.url;
		data['commentCount'] = this.commentCount;
		data['uid'] = this.uid;
		data['createdAt'] = this.createdAt;
		data['topicId'] = this.topicId;
		data['isTopicRecommend'] = this.isTopicRecommend;
		if (this.topic != null) {
      data['topic'] = this.topic.toJson();
    }
		if (this.user != null) {
      data['user'] = this.user.toJson();
    }
		data['folded'] = this.folded;
		data['objectId'] = this.objectId;
		data['updatedAt'] = this.updatedAt;
		return data;
	}
}

class ActivityTopic {
	int msgsCount;
	String createdAt;
	String latestMsgCreatedAt;
	String icon;
	String description;
	int attendersCount;
	int followersCount;
	String title;
	int hotIndex;
	String objectId;
	String updatedAt;

	ActivityTopic({this.msgsCount, this.createdAt, this.latestMsgCreatedAt, this.icon, this.description, this.attendersCount, this.followersCount, this.title, this.hotIndex, this.objectId, this.updatedAt});

	ActivityTopic.fromJson(Map<String, dynamic> json) {
		msgsCount = json['msgsCount'];
		createdAt = json['createdAt'];
		latestMsgCreatedAt = json['latestMsgCreatedAt'];
		icon = json['icon'];
		description = json['description'];
		attendersCount = json['attendersCount'];
		followersCount = json['followersCount'];
		title = json['title'];
		hotIndex = json['hotIndex'];
		objectId = json['objectId'];
		updatedAt = json['updatedAt'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['msgsCount'] = this.msgsCount;
		data['createdAt'] = this.createdAt;
		data['latestMsgCreatedAt'] = this.latestMsgCreatedAt;
		data['icon'] = this.icon;
		data['description'] = this.description;
		data['attendersCount'] = this.attendersCount;
		data['followersCount'] = this.followersCount;
		data['title'] = this.title;
		data['hotIndex'] = this.hotIndex;
		data['objectId'] = this.objectId;
		data['updatedAt'] = this.updatedAt;
		return data;
	}
}

class ActivityUser {
	String role;
	int level;
	String jobTitle;
	String company;
	String avatarLarge;
	int followersCount;
	int followeesCount;
	bool currentUserFollowed;
	String objectId;
	String username;

	ActivityUser({this.role, this.level, this.jobTitle, this.company, this.avatarLarge, this.followersCount, this.followeesCount, this.currentUserFollowed, this.objectId, this.username});

	ActivityUser.fromJson(Map<String, dynamic> json) {
		role = json['role'];
		level = json['level'];
		jobTitle = json['jobTitle'];
		company = json['company'];
		avatarLarge = json['avatarLarge'];
		followersCount = json['followersCount'];
		followeesCount = json['followeesCount'];
		currentUserFollowed = json['currentUserFollowed'];
		objectId = json['objectId'];
		username = json['username'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['role'] = this.role;
		data['level'] = this.level;
		data['jobTitle'] = this.jobTitle;
		data['company'] = this.company;
		data['avatarLarge'] = this.avatarLarge;
		data['followersCount'] = this.followersCount;
		data['followeesCount'] = this.followeesCount;
		data['currentUserFollowed'] = this.currentUserFollowed;
		data['objectId'] = this.objectId;
		data['username'] = this.username;
		return data;
	}
}
