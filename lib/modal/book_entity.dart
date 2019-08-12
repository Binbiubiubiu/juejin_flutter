class BookEntity {
	String wechatImgDesc;
	dynamic isBuy;
	String img;
	BookUserdata userData;
	dynamic pv;
	List<String> section;
	String title;
	String wechatImg;
	dynamic isEditor;
	String createdAt;
	dynamic lastSectionCount;
	dynamic isDeleted;
	dynamic price;
	dynamic contentSize;
	dynamic viewCount;
	String id;
	String updatedAt;
	dynamic buyCount;
	String profile;
	BookReadlog readLog;
	dynamic isFinished;
	dynamic isPublish;
	String url;
	List<Null> tags;
	String finishedAt;
	dynamic isShow;
	String wechatSignal;
	dynamic isTop;
	String sId;
	dynamic category;
	String user;
	dynamic isHot;
	String desc;

	BookEntity({this.wechatImgDesc, this.isBuy, this.img, this.userData, this.pv, this.section, this.title, this.wechatImg, this.isEditor, this.createdAt, this.lastSectionCount, this.isDeleted, this.price, this.contentSize, this.viewCount, this.id, this.updatedAt, this.buyCount, this.profile, this.readLog, this.isFinished, this.isPublish, this.url, this.tags, this.finishedAt, this.isShow, this.wechatSignal, this.isTop, this.sId, this.category, this.user, this.isHot, this.desc});

	BookEntity.fromJson(Map<String, dynamic> json) {
		wechatImgDesc = json['wechatImgDesc'];
		isBuy = json['isBuy'];
		img = json['img'];
		userData = json['userData'] != null ? new BookUserdata.fromJson(json['userData']) : null;
		pv = json['pv'];
		section = json['section']?.cast<String>();
		title = json['title'];
		wechatImg = json['wechatImg'];
		isEditor = json['isEditor'];
		createdAt = json['createdAt'];
		lastSectionCount = json['lastSectionCount'];
		isDeleted = json['isDeleted'];
		price = json['price'];
		contentSize = json['contentSize'];
		viewCount = json['viewCount'];
		id = json['id'];
		updatedAt = json['updatedAt'];
		buyCount = json['buyCount'];
		profile = json['profile'];
		readLog = json['readLog'] != null ? new BookReadlog.fromJson(json['readLog']) : null;
		isFinished = json['isFinished'];
		isPublish = json['isPublish'];
		url = json['url'];
		if (json['tags'] != null) {
			tags = new List<Null>();
		}
		finishedAt = json['finishedAt'];
		isShow = json['isShow'];
		wechatSignal = json['wechatSignal'];
		isTop = json['isTop'];
		sId = json['_id'];
		category = json['category'];
		user = json['user'];
		isHot = json['isHot'];
		desc = json['desc'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['wechatImgDesc'] = this.wechatImgDesc;
		data['isBuy'] = this.isBuy;
		data['img'] = this.img;
		if (this.userData != null) {
      data['userData'] = this.userData.toJson();
    }
		data['pv'] = this.pv;
		data['section'] = this.section;
		data['title'] = this.title;
		data['wechatImg'] = this.wechatImg;
		data['isEditor'] = this.isEditor;
		data['createdAt'] = this.createdAt;
		data['lastSectionCount'] = this.lastSectionCount;
		data['isDeleted'] = this.isDeleted;
		data['price'] = this.price;
		data['contentSize'] = this.contentSize;
		data['viewCount'] = this.viewCount;
		data['id'] = this.id;
		data['updatedAt'] = this.updatedAt;
		data['buyCount'] = this.buyCount;
		data['profile'] = this.profile;
		if (this.readLog != null) {
      data['readLog'] = this.readLog.toJson();
    }
		data['isFinished'] = this.isFinished;
		data['isPublish'] = this.isPublish;
		data['url'] = this.url;
		if (this.tags != null) {
      data['tags'] =  [];
    }
		data['finishedAt'] = this.finishedAt;
		data['isShow'] = this.isShow;
		data['wechatSignal'] = this.wechatSignal;
		data['isTop'] = this.isTop;
		data['_id'] = this.sId;
		data['category'] = this.category;
		data['user'] = this.user;
		data['isHot'] = this.isHot;
		data['desc'] = this.desc;
		return data;
	}
}

class BookUserdata {
	String role;
	dynamic level;
	String jobTitle;
	String selfDescription;
	dynamic isAuthor;
	String uid;
	String avatarHd;
	dynamic bookletCount;
	String company;
	String avatarLarge;
	String isXiaoceAuthor;
	dynamic mobilePhoneVerified;
	String objectId;
	String username;

	BookUserdata({this.role, this.level, this.jobTitle, this.selfDescription, this.isAuthor, this.uid, this.avatarHd, this.bookletCount, this.company, this.avatarLarge, this.isXiaoceAuthor, this.mobilePhoneVerified, this.objectId, this.username});

	BookUserdata.fromJson(Map<String, dynamic> json) {
		role = json['role'];
		level = json['level'];
		jobTitle = json['jobTitle'];
		selfDescription = json['selfDescription'];
		isAuthor = json['isAuthor'];
		uid = json['uid'];
		avatarHd = json['avatarHd'];
		bookletCount = json['bookletCount'];
		company = json['company'];
		avatarLarge = json['avatarLarge'];
		isXiaoceAuthor = json['isXiaoceAuthor'];
		mobilePhoneVerified = json['mobilePhoneVerified'];
		objectId = json['objectId'];
		username = json['username'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['role'] = this.role;
		data['level'] = this.level;
		data['jobTitle'] = this.jobTitle;
		data['selfDescription'] = this.selfDescription;
		data['isAuthor'] = this.isAuthor;
		data['uid'] = this.uid;
		data['avatarHd'] = this.avatarHd;
		data['bookletCount'] = this.bookletCount;
		data['company'] = this.company;
		data['avatarLarge'] = this.avatarLarge;
		data['isXiaoceAuthor'] = this.isXiaoceAuthor;
		data['mobilePhoneVerified'] = this.mobilePhoneVerified;
		data['objectId'] = this.objectId;
		data['username'] = this.username;
		return data;
	}
}

class BookReadlog {
	String sign;
	String sectionId;

	BookReadlog({this.sign, this.sectionId});

	BookReadlog.fromJson(Map<String, dynamic> json) {
		sign = json['sign'];
		sectionId = json['sectionId'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['sign'] = this.sign;
		data['sectionId'] = this.sectionId;
		return data;
	}
}
