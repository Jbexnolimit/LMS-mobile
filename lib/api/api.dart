
class Api {
   static const String api = "http://192.168.254.110/LMS";
  //static const String api = "http://localhost/LMS";
  static const String login_API = "$api/user_login.php";
  static const String signup_API = "$api/user_register.php";
  static const String activityfolder_API = "$api/activity_folder.php";
  static const String userdata_API = "$api/user_data.php";
  static const String activities_API = "$api/activities.php";
  static const String getComments_API = "$api/get_comments.php";
  static const String postComment_API = "$api/post_comment.php";
  static const String getUser = "$api/get_username.php";
  static const String getUserType = "$api/get_usertype.php";
   static const String getCourses = "$api/loadcourses.php";
   static const String getFacilitatorCourses = "$api/loadcourses_facilitator.php";
   static const String addFolderActivity = "$api/add_activityfolder.php";
  static const String uploadActivity = "$api/activity_upload.php";
  static const String postActivity = "$api/post_activity.php";
   static const String addCourse = "$api/add_course.php";
}