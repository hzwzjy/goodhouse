class RegisterData {
    RegisterData({
        required this.userId,
        required this.userName,
        required this.userPwd,
        this.userPic,
        required this.registerTime,
        this.userDesc,
        this.userEmail,
        this.userPhone,
        this.userFollow,
        this.userFans,
        this.userCollect,
        this.userSex,
        required this.userStatus,
    });

    int userId;
    String userName;
    String userPwd;
    dynamic userPic;
    int registerTime;
    dynamic userDesc;
    dynamic userEmail;
    dynamic userPhone;
    dynamic userFollow;
    dynamic userFans;
    dynamic userCollect;
    dynamic userSex;
    int userStatus;

    factory RegisterData.fromJson(Map<String, dynamic> json) => RegisterData(
        userId: json["user_id"],
        userName: json["user_name"],
        userPwd: json["user_pwd"],
        userPic: json["user_pic"],
        registerTime: json["register_time"],
        userDesc: json["user_desc"],
        userEmail: json["user_email"],
        userPhone: json["user_phone"],
        userFollow: json["user_follow"],
        userFans: json["user_fans"],
        userCollect: json["user_collect"],
        userSex: json["user_sex"],
        userStatus: json["user_status"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_name": userName,
        "user_pwd": userPwd,
        "user_pic": userPic,
        "register_time": registerTime,
        "user_desc": userDesc,
        "user_email": userEmail,
        "user_phone": userPhone,
        "user_follow": userFollow,
        "user_fans": userFans,
        "user_collect": userCollect,
        "user_sex": userSex,
        "user_status": userStatus,
    };
}
