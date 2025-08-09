import 'package:get/get.dart';
import 'package:openim_enterprise_chat/src/pages/mine/usdt_do/usdt_do_binding.dart';
import 'package:openim_enterprise_chat/src/pages/mine/usdt_do/usdt_do_view.dart';

import '../pages/add_friend/accept_friend_request/accept_friend_request_binding.dart';
import '../pages/add_friend/accept_friend_request/accept_friend_request_view.dart';
import '../pages/add_friend/add_friend_binding.dart';
import '../pages/add_friend/add_friend_view.dart';
import '../pages/add_friend/search/search_binding.dart';
import '../pages/add_friend/search/search_view.dart';
import '../pages/add_friend/send_friend_request/send_friend_request_binding.dart';
import '../pages/add_friend/send_friend_request/send_friend_request_view.dart';
import '../pages/call/call_records/call_records_binding.dart';
import '../pages/call/call_records/call_records_view.dart';
import '../pages/chat/chat_binding.dart';
import '../pages/chat/chat_setup/chat_setup_binding.dart';
import '../pages/chat/chat_setup/chat_setup_view.dart';
import '../pages/chat/chat_setup/create_group/create_group_binding.dart';
import '../pages/chat/chat_setup/create_group/create_group_view.dart';
import '../pages/chat/chat_setup/emoji_manage/emoji_manage_binding.dart';
import '../pages/chat/chat_setup/emoji_manage/emoji_manage_view.dart';
import '../pages/chat/chat_setup/font_size/font_size_binding.dart';
import '../pages/chat/chat_setup/font_size/font_size_view.dart';
import '../pages/chat/chat_setup/search_history_message/file/file_binding.dart';
import '../pages/chat/chat_setup/search_history_message/file/file_view.dart';
import '../pages/chat/chat_setup/search_history_message/picture/picture_binding.dart';
import '../pages/chat/chat_setup/search_history_message/picture/picture_view.dart';
import '../pages/chat/chat_setup/search_history_message/search_history_message_binding.dart';
import '../pages/chat/chat_setup/search_history_message/search_history_message_view.dart';
import '../pages/chat/chat_view.dart';
import '../pages/chat/group_setup/announcement_setup/announcement_setup_binding.dart';
import '../pages/chat/group_setup/announcement_setup/announcement_setup_view.dart';
import '../pages/chat/group_setup/group_member_manager/group_member_manager_binding.dart';
import '../pages/chat/group_setup/group_member_manager/group_member_manager_view.dart';
import '../pages/chat/group_setup/group_member_manager/member_list/member_list_binding.dart';
import '../pages/chat/group_setup/group_member_manager/member_list/member_list_view.dart';
import '../pages/chat/group_setup/group_member_manager/search_member/search_member_binding.dart';
import '../pages/chat/group_setup/group_member_manager/search_member/search_member_view.dart';
import '../pages/chat/group_setup/group_setup_binding.dart';
import '../pages/chat/group_setup/group_setup_view.dart';
import '../pages/chat/group_setup/id/id_binding.dart';
import '../pages/chat/group_setup/id/id_view.dart';
import '../pages/chat/group_setup/message_read/message_read_binding.dart';
import '../pages/chat/group_setup/message_read/message_read_view.dart';
import '../pages/chat/group_setup/my_group_nickname/my_group_nickname_binding.dart';
import '../pages/chat/group_setup/my_group_nickname/my_group_nickname_view.dart';
import '../pages/chat/group_setup/name_setup/name_setup_binding.dart';
import '../pages/chat/group_setup/name_setup/name_setup_view.dart';
import '../pages/chat/group_setup/qrcode/qrcode_binding.dart';
import '../pages/chat/group_setup/qrcode/qrcode_view.dart';
import '../pages/chat/group_setup/set_member_mute/set_member_mute_binding.dart';
import '../pages/chat/group_setup/set_member_mute/set_member_mute_view.dart';
import '../pages/contacts/add/add_binding.dart';
import '../pages/contacts/add/add_view.dart';
import '../pages/contacts/all_users/all_user_binding.dart';
import '../pages/contacts/all_users/all_user_view.dart';
import '../pages/contacts/apply_enter_group/apply_enter_group_binding.dart';
import '../pages/contacts/apply_enter_group/apply_enter_group_view.dart';
import '../pages/contacts/friend_info/friend_info_binding.dart';
import '../pages/contacts/friend_info/friend_info_view.dart';
import '../pages/contacts/friend_info/id_code/id_code_binding.dart';
import '../pages/contacts/friend_info/id_code/id_code_view.dart';
import '../pages/contacts/friend_info/remark/remark_binding.dart';
import '../pages/contacts/friend_info/remark/remark_view.dart';
import '../pages/contacts/friend_list/friend_list_binding.dart';
import '../pages/contacts/friend_list/friend_list_view.dart';
import '../pages/contacts/friend_list/search_friend/search_friend_binding.dart';
import '../pages/contacts/friend_list/search_friend/search_friend_view.dart';
import '../pages/contacts/group_application/group_application_binding.dart';
import '../pages/contacts/group_application/group_application_view.dart';
import '../pages/contacts/group_application/handle_application/handle_application_binding.dart';
import '../pages/contacts/group_application/handle_application/handle_application_view.dart';
import '../pages/contacts/group_list/group_list_binding.dart';
import '../pages/contacts/group_list/group_list_view.dart';
import '../pages/contacts/group_list/search_group/search_group_binding.dart';
import '../pages/contacts/group_list/search_group/search_group_view.dart';
import '../pages/contacts/join_group/join_group_binding.dart';
import '../pages/contacts/join_group/join_group_view.dart';
import '../pages/contacts/new_friend/new_friend_binding.dart';
import '../pages/contacts/new_friend/new_friend_view.dart';
import '../pages/contacts/search_add_group/search_add_group_binding.dart';
import '../pages/contacts/search_add_group/search_add_group_view.dart';
import '../pages/contacts/tag_group/new/new_tag_group_binding.dart';
import '../pages/contacts/tag_group/new/new_tag_group_view.dart';
import '../pages/contacts/tag_group/tag_group_binding.dart';
import '../pages/contacts/tag_group/tag_group_view.dart';
import '../pages/forget_password/forget_password_binding.dart';
import '../pages/forget_password/forget_password_view.dart';
import '../pages/home/home_binding.dart';
import '../pages/home/home_view.dart';
import '../pages/login/login_binding.dart';
import '../pages/login/login_view.dart';
import '../pages/mine/about_us/about_us_binding.dart';
import '../pages/mine/about_us/about_us_view.dart';
import '../pages/mine/account_setup/account_setup_binding.dart';
import '../pages/mine/account_setup/account_setup_view.dart';
import '../pages/mine/add_my_method/add_my_method_binding.dart';
import '../pages/mine/add_my_method/add_my_method_view.dart';
import '../pages/mine/blacklist/blacklist_binding.dart';
import '../pages/mine/blacklist/blacklist_view.dart';
import '../pages/mine/my_id/my_id_binding.dart';
import '../pages/mine/my_id/my_id_view.dart';
import '../pages/mine/my_info/my_info_binding.dart';
import '../pages/mine/my_info/my_info_view.dart';
import '../pages/mine/my_qrcode/my_qrcode_binding.dart';
import '../pages/mine/my_qrcode/my_qrcode_view.dart';
import '../pages/mine/my_addr/my_addr_binding.dart';
import '../pages/mine/my_addr/my_addr_view.dart';
import '../pages/mine/my_poster/my_posters_binding.dart';
import '../pages/mine/my_poster/my_posters_view.dart';
import '../pages/mine/my_posttg/my_posttg_binding.dart';
import '../pages/mine/my_posttg/my_posttg_view.dart';
import '../pages/mine/setup_language/setup_language_binding.dart';
import '../pages/mine/setup_language/setup_language_view.dart';
import '../pages/mine/setup_username/setup_name_binding.dart';
import '../pages/mine/setup_username/setup_name_view.dart';
//import '../pages/notification/oa_notification/oa_notification_binding.dart';
//import '../pages/notification/oa_notification/oa_notification_view.dart';
import '../pages/organization/organization_binding.dart';
import '../pages/organization/organization_view.dart';
import '../pages/register/register_binding.dart';
import '../pages/register/register_view.dart';
import '../pages/register/setupinfo/setupinfo_binding.dart';
import '../pages/register/setupinfo/setupinfo_view.dart';
import '../pages/register/setuppwd/setuppwd_binding.dart';
import '../pages/register/setuppwd/setuppwd_view.dart';
import '../pages/register/verifyphone/verifyphone_binding.dart';
import '../pages/register/verifyphone/verifyphone_view.dart';
import '../pages/register/verifyphoneo/verifyphone_binding.dart';
import '../pages/register/verifyphoneo/verifyphone_view.dart';
import '../pages/select_contacts/group_member/group_member_binding.dart';
import '../pages/select_contacts/group_member/group_member_view.dart';
import '../pages/select_contacts/select_contacts_binding.dart';
import '../pages/select_contacts/select_contacts_view.dart';
import '../pages/splash/splash_binding.dart';
import '../pages/splash/splash_view.dart';
import '../pages/mine/usdt_addr/setup_usdtaddr_binding.dart';
import '../pages/mine/usdt_addr/setup_usdtaddr_view.dart';
import '../pages/mine/usdt_do/usdt_do_binding.dart';
import '../pages/mine/usdt_do/usdt_do_view.dart';
import '../pages/mine/about_us/copyright/copy_right_binding.dart';
import '../pages/mine/about_us/copyright/copy_right_view.dart';
import '../pages/register/invitecode/invitecode_binding.dart';
import '../pages/register/invitecode/invitecode_view.dart';
import '../pages/workbench/envelope/envelope_binding.dart';
import '../pages/workbench/envelope/envelope_view.dart';

part 'app_routes.dart';

class AppPages {
  static final routes = <GetPage>[
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.REGISTER,
      page: () => RegisterPage(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: AppRoutes.REGISTER_VERIFY_PHONE,
      page: () => VerifyPhonePage(),
      binding: VerifyPhoneBinding(),
    ),
    GetPage(
      name: AppRoutes.REGISTER_VERIFY_PHONEO,
      page: () => VerifyPhoneoPage(),
      binding: VerifyPhoneoBinding(),
    ),
    GetPage(
      name: AppRoutes.SETUP_PWD,
      page: () => SetupPwdPage(),
      binding: SetupPwdBinding(),
    ),
    GetPage(
      name: AppRoutes.REGISTER_SETUP_SELF_INFO,
      page: () => SetupSelfInfoPage(),
      binding: SetupSelfInfoBinding(),
    ),
    GetPage(
      name: AppRoutes.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    // GetPage(
    //   name: AppRoutes.CONVERSATION,
    //   page: () => ConversationPage(),
    //   binding: ConversationBinding(),
    // ),
    GetPage(
      name: AppRoutes.CHAT,
      page: () => ChatPage(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: AppRoutes.CHAT_SETUP,
      page: () => ChatSetupPage(),
      binding: ChatSetupBinding(),
    ),
    GetPage(
      name: AppRoutes.SELECT_CONTACTS_BY_GROUP,
      page: () => SelectByGroupMemberPage(),
      binding: SelectByGroupMemberBinding(),
    ),
    GetPage(
      name: AppRoutes.SELECT_CONTACTS,
      page: () => SelectContactsPage(),
      binding: SelectContactsBinding(),
    ),
    GetPage(
      name: AppRoutes.ADD_CONTACTS,
      page: () => AddContactsPage(),
      binding: AddContactsBinding(),
    ),
    GetPage(
      name: AppRoutes.NEW_FRIEND_APPLICATION,
      page: () => NewFriendPage(),
      binding: NewFriendBinding(),
    ),
    GetPage(
      name: AppRoutes.FRIEND_LIST,
      page: () => MyFriendListPage(),
      binding: MyFriendListBinding(),
    ),
    GetPage(
      name: AppRoutes.FRIEND_INFO,
      page: () => FriendInfoPage(),
      binding: FriendInfoBinding(),
    ),
    GetPage(
      name: AppRoutes.FRIEND_ID_CODE,
      page: () => FriendIdCodePage(),
      binding: FriendIdCodeBinding(),
    ),
    GetPage(
      name: AppRoutes.FRIEND_REMARK,
      page: () => FriendRemarkPage(),
      binding: FriendRemarkBinding(),
    ),
    GetPage(
      name: AppRoutes.ADD_FRIEND,
      page: () => AddFriendPage(),
      binding: AddFriendBinding(),
    ),
    GetPage(
      name: AppRoutes.ADD_FRIEND_BY_SEARCH,
      page: () => AddFriendBySearchPage(),
      binding: AddFriendBySearchBinding(),
    ),
    GetPage(
      name: AppRoutes.SEND_FRIEND_REQUEST,
      page: () => SendFriendRequestPage(),
      binding: SendFriendRequestBinding(),
    ),
    GetPage(
      name: AppRoutes.ACCEPT_FRIEND_REQUEST,
      page: () => AcceptFriendRequestPage(),
      binding: AcceptFriendRequestBinding(),
    ),
    GetPage(
      name: AppRoutes.MY_QRCODE,
      page: () => MyQrcodePage(),
      binding: MyQrcodeBinding(),
    ),
    GetPage(
      name: AppRoutes.MY_INFO,
      page: () => MyInfoPage(),
      binding: MyInfoBinding(),
    ),
    GetPage(
      name: AppRoutes.SETUP_USER_NAME,
      page: () => SetupUserNamePage(),
      binding: SetupUserNameBinding(),
    ),
    GetPage(
      name: AppRoutes.MY_ID,
      page: () => MyIDPage(),
      binding: MyIDBinding(),
    ),
    // GetPage(
    //   name: AppRoutes.CALL,
    //   page: () => CallPage(),
    //   binding: CallBinding(),
    // ),
    GetPage(
      name: AppRoutes.CREATE_GROUP_IN_CHAT_SETUP,
      page: () => CreateGroupInChatSetupPage(),
      binding: CreateGroupInChatSetupBinding(),
    ),
    GetPage(
      name: AppRoutes.GROUP_SETUP,
      page: () => GroupSetupPage(),
      binding: GroupSetupBinding(),
    ),
    GetPage(
      name: AppRoutes.GROUP_NAME_SETUP,
      page: () => GroupNameSetupPage(),
      binding: GroupNameSetupBinding(),
    ),
    GetPage(
      name: AppRoutes.GROUP_ANNOUNCEMENT_SETUP,
      page: () => GroupAnnouncementSetupPage(),
      binding: GroupAnnouncementSetupBinding(),
    ),
    GetPage(
      name: AppRoutes.GROUP_QRCODE,
      page: () => GroupQrcodePage(),
      binding: GroupQrcodeBinding(),
    ),
    GetPage(
      name: AppRoutes.GROUP_ID,
      page: () => GroupIDPage(),
      binding: GroupIDBinding(),
    ),
    GetPage(
      name: AppRoutes.MY_GROUP_NICKNAME,
      page: () => MyGroupNicknamePage(),
      binding: MyGroupNicknameBinding(),
    ),
    GetPage(
      name: AppRoutes.GROUP_MEMBER_MANAGER,
      page: () => GroupMemberManagerPage(),
      binding: GroupMemberManagerBinding(),
    ),
    GetPage(
      name: AppRoutes.GROUP_MEMBER_LIST,
      page: () => GroupMemberListPage(),
      binding: GroupMemberListBinding(),
    ),
    GetPage(
      name: AppRoutes.GROUP_LIST,
      page: () => GroupListPage(),
      binding: GroupListBinding(),
    ),
    GetPage(
      name: AppRoutes.JOIN_GROUP,
      page: () => JoinGroupPage(),
      binding: JoinGroupBinding(),
    ),
    GetPage(
      name: AppRoutes.ACCOUNT_SETUP,
      page: () => AccountSetupPage(),
      binding: AccountSetupBinding(),
    ),
    GetPage(
      name: AppRoutes.ADD_MY_METHOD,
      page: () => AddMyMethodPage(),
      binding: AddMyMethodBinding(),
    ),
    GetPage(
      name: AppRoutes.BLACKLIST,
      page: () => BlacklistPage(),
      binding: BlacklistBinding(),
    ),
    GetPage(
      name: AppRoutes.ABOUT_US,
      page: () => AboutUsPage(),
      binding: AboutUsBinding(),
    ),
    GetPage(
      name: AppRoutes.SEARCH_FRIEND,
      page: () => SearchFriendPage(),
      binding: SearchFriendBinding(),
    ),
    GetPage(
      name: AppRoutes.SEARCH_GROUP,
      page: () => SearchGroupPage(),
      binding: SearchGroupBinding(),
    ),
    GetPage(
      name: AppRoutes.SEARCH_MEMBER,
      page: () => SearchMemberPage(),
      binding: SearchMemberBinding(),
    ),
    GetPage(
      name: AppRoutes.CALL_RECORDS,
      page: () => CallRecordsPage(),
      binding: CallRecordsBinding(),
    ),
    GetPage(
      name: AppRoutes.LANGUAGE_SETUP,
      page: () => SetupLanguagePage(),
      binding: SetupLanguageBinding(),
    ),
    GetPage(
      name: AppRoutes.SEARCH_ADD_GROUP,
      page: () => SearchAddGroupPage(),
      binding: SearchAddGroupBinding(),
    ),
    GetPage(
      name: AppRoutes.APPLY_ENTER_GROUP,
      page: () => ApplyEnterGroupPage(),
      binding: ApplyEnterGroupBinding(),
    ),
    GetPage(
      name: AppRoutes.GROUP_APPLICATION,
      page: () => GroupApplicationPage(),
      binding: GroupApplicationBinding(),
    ),
    GetPage(
      name: AppRoutes.HANDLE_GROUP_APPLICATION,
      page: () => HandleGroupApplicationPage(),
      binding: HandleGroupApplicationBinding(),
    ),
    GetPage(
      name: AppRoutes.ORGANIZATION,
      page: () => OrganizationPage(),
      binding: OrganizationBinding(),
    ),
    GetPage(
      name: AppRoutes.FORGET_PASSWORD,
      page: () => ForgetPasswordPage(),
      binding: ForgetPasswordBinding(),
    ),
    GetPage(
      name: AppRoutes.EMOJI_MANAGE,
      page: () => EmojiManagePage(),
      binding: EmojiManageBinding(),
    ),
    GetPage(
      name: AppRoutes.FONT_SIZE,
      page: () => FontSizePage(),
      binding: FontSizeBinding(),
    ),
    GetPage(
      name: AppRoutes.TAG,
      page: () => TagGroupPage(),
      binding: TagGroupBinding(),
    ),
    GetPage(
      name: AppRoutes.TAG_NEW,
      page: () => NewTagGroupPage(),
      binding: NewTagGroupBinding(),
    ),
    GetPage(
      name: AppRoutes.ALL_USERS,
      page: () => AllUsersPage(),
      binding: AllUsersBinding(),
    ),
    GetPage(
      name: AppRoutes.GROUP_HAVE_READ,
      page: () => GroupMessageReadPage(),
      binding: GroupMessageReadBinding(),
    ),
    GetPage(
      name: AppRoutes.SEARCH_HISTORY_MESSAGE,
      page: () => SearchHistoryMessagePage(),
      binding: SearchHistoryMessageBinding(),
    ),
    GetPage(
      name: AppRoutes.SEARCH_FILE,
      page: () => SearchFilePage(),
      binding: SearchFileBinding(),
    ),
    GetPage(
      name: AppRoutes.SEARCH_PICTURE,
      page: () => SearchPicturePage(),
      binding: SearchPictureBinding(),
    ),
    GetPage(
      name: AppRoutes.SET_MEMBER_MUTE,
      page: () => SetMemberMutePage(),
      binding: SetMemberMuteBinding(),
    ),
    GetPage(
      name: AppRoutes.MY_COPY,
      page: () => CopyRightPage(),
      binding: CopyRightBinding(),
    ),
    GetPage(
      name: AppRoutes.MY_USDTADDR,
      page: () => SetupUsdtAddrPage(),
      binding: SetupUsdtAddrBinding(),
    ),
    GetPage(
      name: AppRoutes.MY_USDTDO,
      page: () => SetUsdtdoPage(),
      binding: SetUsdtdoBinding(),
    ),
    GetPage(
      name: AppRoutes.INVITECODE,
      page: () => InvitecodePage(),
      binding: InvitecodeBinding(),
    ),
    GetPage(
      name: AppRoutes.ENVELOPE_OPEN,
      page: () => EnvelopePage(),
      binding: EnvelopeBinding(),
    ),
    GetPage(
      name: AppRoutes.MY_ADDR,
      page: () => MyAddrPage(),
      binding: MyAddrBinding(),
    ),
    GetPage(
      name: AppRoutes.MY_POSTER,
      page: () => MypostersPage(),
      binding: MypostersBinding(),
    ),
    GetPage(
      name: AppRoutes.MY_POSTTG,
      page: () => MyposttgPage(),
      binding: MyposttgBinding(),
    ),
  ];
}
