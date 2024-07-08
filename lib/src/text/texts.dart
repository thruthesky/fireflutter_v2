import 'package:fireflutter/fireflutter.dart';

class T {
  T._();

  static Json version = {
    'en': 'Ver: #version',
    'ko': '버전: #version',
  };

  static Json yes = {
    'en': 'Yes',
    'ko': '예',
    'vi': 'Có',
    'th': 'ใช่',
    'lo': 'ແມ່ນແລ້ວ'
  };

  static Json no = {
    'en': 'No',
    'ko': '아니요',
    'vi': 'Không',
    'th': 'ไม่ใช่',
    'lo': 'ບໍ່'
  };

  static Json ok = {
    'en': 'OK',
    'ko': '확인',
    'vi': 'Ổn',
    'th': 'ตกลง',
    'lo': 'ຕົວຢ່າງ'
  };

  static Json error = {
    'en': 'Error',
    'ko': '오류',
    'vi': 'Lỗi',
    'th': 'เกิดข้อผิดพลาด',
    'lo': 'ຜິດພາດ'
  };

  static Json save = {
    'en': 'Save',
    'ko': '저장',
    'vi': 'Lưu',
    'th': 'บันทึก',
    'lo': 'ບັນທຶກ'
  };

  static Json pleaseFillInTheDetails = {
    'en': 'Reminder: Please fill in the details',
    'ko': '알림: 내용을 입력하세요', // original
  };

  static Json contentIsTooShort = {
    'en': 'The content is too short. Must be at least 30 characters.',
    'ko': '내용이 너무 짧습니다. 30자 이상이어야 합니다.',
  };

  static Json cameraAccessDeniedTitle = {
    'en': 'Camera Access Denied',
    'ko': '카메라 액세스가 거부되었습니다',
  };

  static Json cameraAccessDeniedContent = {
    'en': 'Please allow the app to access your camera.',
    'ko': '앱이 카메라에 액세스할 수 있도록 허용해 주세요.',
  };

  static Json galleryAccessDeniedTitle = {
    'en': 'Gallery Access Denied',
    'ko': '갤러리 접근이 거부되었습니다',
  };

  static Json galleryAccessDeniedContent = {
    'en': 'Please allow the app to access your photo gallery.',
    'ko': '앱이 사진 갤러리에 액세스할 수 있도록 허용해 주세요.',
  };

  static Json doYouWanToCancel = {
    'en': 'Do you want to cancel?',
    'ko': '취소하시겠습니까?'
  };

  static Json stateMessage = {
    'en': 'State Message',
    'ko': '상태 메시지',
    'vi': 'Tin nhắn trạng thái',
    'th': 'ข้อความสถานะ',
    'lo': 'ຂໍ້ຄວາມສະຖານະ',
  };

  static Json saved = {
    'en': 'Saved.',
    'ko': '저장되었습니다.',
    'vi': 'Đã lưu',
    'th': 'บันทึกสำเร็จ',
    'lo': 'ບັນທຶກແລ້ວ'
  };

  static Json name = {
    'en': 'Name',
    'ko': '이름',
    'vi': 'Tên',
    'th': 'ชื่อ',
    'lo': 'ຊື່',
  };

  static Json cancel = {
    'en': 'Cancel',
    'ko': '취소',
    'vi': 'Hủy bỏ',
    'th': 'ยกเลิก',
    'lo': 'ຍົກເລີກ',
  };

  static Json close = {
    'en': 'Close',
    'ko': '닫기',
    'vi': 'Đóng',
    'th': 'ปิด',
    'lo': 'ປິດ'
  };

  static Json createPost = {
    'en': 'Create post',
    'ko': '글 작성',
  };

  static Json editPost = {
    'en': 'Edit post',
    'ko': '글 수정',
  };

  static Json like = {
    'en': 'Like',
    'ko': '좋아요',
  };

  static Json chat = {
    'en': 'Chat',
    'ko': '채팅',
  };

  static Json groupChat = {
    'en': 'Group',
    'ko': '그룹 채팅',
  };

  static Json noChatRoomName = {
    'en': 'No chat room name',
    'ko': '채팅방 이름 없음',
  };

  static Json edit = {
    'en': 'Edit',
    'ko': '수정',
  };

  static Json delete = {
    'en': 'Delete',
    'ko': '삭제',
  };

  static Json share = {
    'en': 'Share',
    'ko': '공유',
  };

  static Json reply = {
    'en': 'Reply',
    'ko': '답글',
  };

  static Json bookmark = {
    'en': 'Favorite',
    'ko': '북마크',
  };

  static Json unbookmark = {
    'en': 'Unfavorite',
    'ko': '북마크 해제',
  };

  static Json bookmarkMessage = {
    'en': 'Favorite sucess',
    'ko': '북마크 완료',
  };

  static Json unbookmarkMessage = {
    'en': 'Unfavorite sucess',
    'ko': '북마크 해제 완료',
  };

  static Json block = {
    'en': 'Block',
    'ko': '차단',
    'vi': 'Chặn',
    'th': 'บล็อก',
    'lo': 'ປິດບໍ່ໃຫ້ຕົນໄປ',
  };

  static Json unblock = {
    'en': 'Unblock',
    'ko': '차단 해제',
    'vi': 'Bỏ chặn',
    'th': 'ยกเลิกการบล็อก',
    'lo': 'ປິດຕົນໄປ',
  };

  static Json report = {
    'en': 'Report',
    'ko': '신고',
    'vi': 'Báo cáo',
    'th': 'รายงาน',
    'lo': 'ລາຍງານ'
  };

  static Json noReport = {
    'en': 'No report',
    'ko': '신고 없음',
    'vi': 'Không báo cáo',
    'th': 'ไม่มีรายงาน',
    'lo': 'ບໍ່ພາດລາຍງານ'
  };

  static Json deleteReport = {
    'en': 'Delete report',
    'ko': '신고 삭제',
    'vi': 'Xóa báo cáo',
    'th': 'ลบรายงาน',
    'lo': 'ລາຍງານ'
  };

  static Json doYouWantToDeleteReport = {
    'en': 'Do you want to delete the report?',
    'ko': '신고를 삭제하시겠습니까?',
  };

  static Json reportReceived = {
    'en': 'Report has been received.',
    'ko': '신고가 접수되었습니다.',
  };

  static Json writeComment = {
    'en': 'Write a comment',
    'ko': '코멘트 작성',
  };

  static Json posts = {
    'en': 'Posts',
    'ko': '글',
  };

  static Json comments = {
    'en': 'Comments',
    'ko': '댓글',
  };

  static Json inputCommentHint = {
    'en': 'Please enter your comment',
    'ko': '댓글을 입력하세요',
  };

  /// Meetup translations
  static Json meetupCreate = {
    'en': 'Create meetup',
    'ko': '모임 만들기',
  };

  static Json meetupUpdate = {
    'en': 'Edit meetup',
    'ko': '모임 수정하기',
  };

  static Json meetupName = {
    'en': 'Meetup name',
    'ko': '모임 이름',
  };
  static Json meetupNameDescription = {
    'en': 'Please write the name of the meetup.',
    'ko': '모임 이름을 적어주세요.',
  };
  static Json meetupPhotoDescription = {
    'en':
        'Please upload a photo of the meetup. Photo Width: 800, Photo Height: 500',
    'ko': '  모임 사진을 업로드 해 주세요. 사진 너비: 800, 사진 높이: 500',
  };
  static Json meetupDescriptionLabel = {
    'en': 'Meetup description',
    'ko': '모임 설명',
  };
  static Json meetupDescriptionInputDescription = {
    'en': 'Please write a description of the meetup.',
    'ko': '모임 설명을 적어주세요.',
  };
  static Json meetupUpdateMessage = {
    'en': 'The meetup has been modified.',
    'ko': '모임이 수정되었습니다.',
  };

  static Json qna = {
    'en': 'Q&A',
    'ko': '질문',
  };

  static Json discussion = {
    'en': 'Discussion',
    'ko': '토론',
  };

  static Json buyandsell = {
    'en': 'Buy&Sell',
    'ko': '장터',
  };

  static Json job = {
    'en': 'Job',
    'ko': '직업',
  };

  static Json news = {
    'en': 'News',
    'ko': '뉴스',
  };

  static Json category = {
    'en': 'Category',
    'ko': '카테고리',
  };

  static Json post = {
    'en': 'Post',
    'ko': '글',
  };

  static Json comment = {
    'en': 'Comment',
    'ko': '댓글',
  };

  static Json forumType = {
    'en': 'Forum type',
    'ko': '게시판 종류',
  };

  static Json searchByCategories = {
    'en': 'Search by categories',
    'ko': '카테고리로 검색',
  };

  static Json searchByGroup = {
    'en': 'Search by group',
    'ko': '그룹으로 검색',
  };

  static Json searchByField = {
    'en': 'Search by field',
    'ko': '필드로 검색',
  };

  static Json searchByForumType = {
    'en': 'Search by forum type',
    'ko': '게시판 종류로 검색',
  };

  static Json reset = {
    'en': 'Reset',
    'ko': '초기화',
  };

  static Json age = {
    'en': 'Age',
    'ko': '나이',
  };

  static Json info = {
    'en': 'Info',
    'ko': '정보',
  };
  static Json event = {
    'en': 'Event',
    'ko': '일정',
  };

  static Json forum = {
    'en': 'Forum',
    'ko': '게시판',
  };

  static Json menu = {
    'en': 'Menu',
    'ko': '메뉴',
  };

  static Json friend = {
    'en': 'Friend',
    'ko': '친구',
  };

  static Json friends = {
    'en': 'Friends',
    'ko': '친구',
  };

  static Json gallery = {
    'en': 'Gallery',
    'ko': '사진첩',
  };

  static Json host = {
    'en': 'Host',
    'ko': '운영자',
  };

  static Json field = {
    'en': 'Field',
    'ko': '필드',
  };

  static Json group = {
    'en': 'Group',
    'ko': '그룹',
  };

  static Json members = {
    'en': 'Members',
    'ko': '회원 수',
  };

  static Json blockedMembers = {
    'en': 'Blocked Members',
    'ko': '차단된 회원 수',
  };

  static Json membersList = {
    'en': 'Members list',
    'ko': '회원 수',
  };

  static Json noOfPeople = {
    'en': 'people',
    'ko': '명',
  };

  static Json profileUpdate = {
    'en': 'Profile update',
    'ko': '프로필 수정',
    'vi': 'Cập nhật hồ sơ',
    'th': 'อัปเดตโปรไฟล์',
    'lo': 'ອັບເດດຂໍ້ມູນຜູ້ໃຊ້',
  };

  static Json backgroundUpdate = {
    'en': 'Background update',
    'ko': '배경 수정',
  };

  static Json contact = {
    'en': 'Contact',
    'ko': '문의하기',
  };

  static Json recentPhotos = {
    'en': 'Recent Photos',
    'ko': '최근 사진들',
  };

  static Json noRecentPhotos = {
    'en': 'There are no recent photos',
    'ko': '최근 사진이 없습니다',
  };

  static Json recentPosts = {
    'en': 'Recent Posts',
    'ko': '최근글',
  };

  static Json noRecentPosts = {
    'en': 'There are no recent posts',
    'ko': '최근 글이 없습니다.',
  };

  static Json meetupInfo = {
    'en': 'Meetup information',
    'ko': '모임 정보',
  };

  static Json reminder = {
    'en': 'Reminder',
    'ko': '알림',
  };

  static Json inputReminder = {
    'en': 'Input reminder',
    'ko': '입력 알림',
  };

  static Json createMeetupEvent = {
    'en': 'Create event',
    'ko': '일정 생성',
  };

  static Json createMeetupPost = {
    'en': 'Add Post',
    'ko': '글 쓰기',
  };

  static Json addPhoto = {
    'en': 'Add photo',
    'ko': '사진',
  };

  static Json meetupAdminSetting = {
    'en': 'Admin setting',
    'ko': '관리자 설정',
  };

  static Json editMeetupInformation = {
    'en': 'Edit meetup info',
    'ko': '모임 정보 수정',
  };

  static Json leaveMeetup = {
    'en': 'Leave meetup',
    'ko': '모임 탈퇴',
  };

  static Json joinMeetup = {
    'en': 'Join meetup',
    'ko': '모임 가입',
  };

  static Json noticeManage = {
    'en': 'Update notice',
    'ko': '게시판 관리',
  };

  static Json closeMeetup = {
    'en': 'Close meetup',
    'ko': '모임 폐쇄',
  };

  static Json noEvent = {
    'en': 'There are no events',
    'ko': '일정이 없습니다.',
  };

  static Json meetupChatBlocked = {
    'en': 'Blocked members cannot chat.',
    'ko': '차단된 회원은 채팅을 할 수 없습니다.',
  };

  static Json joinMeetupToChat = {
    'en': 'You must join the group\nto view the chat room.',
    'ko': '모임에 가입하셔야\n채팅방을 볼 수 있습니다.',
  };

  static Json noNoticeYet = {
    'en': 'There are no notices yet.',
    'ko': '글을 등록 해 주세요.',
  };

  static Json meetupViewNoticeBlocked = {
    'en': 'Blocked members cannot view the forum.',
    'ko': '차단된 회원은 게시판을 볼 수 없습니다.',
  };

  static Json joinMeetupToViewNotice = {
    'en': 'You must join the group\nto view the announcement.',
    'ko': '모임에 가입하셔야\n게시판을 볼 수 있습니다.',
  };

  static Json noUploadPhotoYet = {
    'en': 'Theres no uploaded photo yet.',
    'ko': '사진을 등록 해 주세요.',
  };

  static Json meetupViewGalleryBlocked = {
    'en': 'Blocked members cannot view the gallery.',
    'ko': '차단된 회원은 사진첩을 볼 수 없습니다.',
  };

  static Json joinMeetupToViewGallery = {
    'en': 'You must join the group\nto view the gallery.',
    'ko': '모임에 가입하셔야\n사진첩을 볼 수 있습니다.',
  };

  static Json login = {
    'en': 'Login',
    'ko': '로그인',
    'vi': 'Đăng nhập',
    'th': 'เข้าสู่ระบบ',
    'lo': 'ເຂົ້າສູ່ລະບົບ',
  };

  static Json logout = {
    'en': 'Logout',
    'ko': '로그아웃',
    'vi': 'Đăng xuất',
    'th': 'ออกจากระบบ',
    'lo': 'ອອກຈາກລະບົບ',
  };

  static Json loginFirstToUseMeetup = {
    'en': 'To use the meetup function, you must first log in.',
    'ko': '모임 기능을 이용하기 위해서는 로그인을 먼저 하셔야합니다.',
  };

  static Json unjoin = {
    'en': 'Unjoin',
    'ko': '탈퇴하기',
  };

  static Json join = {
    'en': 'Join',
    'ko': '가입하기',
  };

  static Json somethingWentWrong = {
    'en': 'Something went wrong!',
    'ko': '오류가 발생했습니다.',
  };

  static Json deleteMeetup = {
    'en': 'Delete meetup',
    'ko': '모임 삭제',
  };

  static Json deleteMeetupMessage = {
    'en': 'Are you sure you want to delete this meetup?',
    'ko': '정말 모임을 삭제하시겠습니까?',
  };

  static Json createMeetupSchedule = {
    'en': 'Create meetup schedule',
    'ko': '만남 일정 만들기',
  };

  static Json editMeetupSchedule = {
    'en': 'Edit meetup schedule',
    'ko': '만남 일정 수정하기',
  };

  static Json meetupScheduleTitle = {
    'en': 'Meetup schedule title',
    'ko': '오프라인 일정 제목',
  };

  static Json meetupScheduleTitleDescription = {
    'en': 'Please enter the title of the meetup schedule.',
    'ko': '오프라인 만남의 제목을 적어주세요.',
  };

  static Json meetupCreateSchedule = {
    'en': 'Create a schedule',
    'ko': '일정 만들기',
  };

  static Json meetupScheduleDateAndTime = {
    'en': 'Meetup schedule date and time',
    'ko': '만남 일정 날짜와 시간',
  };

  static Json selectDate = {
    'en': 'Select date',
    'ko': '날짜 선택',
  };

  static Json selectTime = {
    'en': 'Select time',
    'ko': '시간 선택',
  };

  static Json meetupSchedulePhoto = {
    'en': 'Meetup schedule photo',
    'ko': '만남 일정 사진',
  };

  static Json meetupScheduleName = {
    'en': 'Meetup schedule name',
    'ko': '만남 일정 이름',
  };

  static Json meetupScheduleNameNote = {
    'en': 'Please enter the name of the meetup schedule.',
    'ko': '오프라인 만남에 대한 이름을 적어주세요.',
  };

  static Json meetupSchedulePhotoNote = {
    'en': 'Please upload a photo. Photo size: 500x500',
    'ko': '모임 사진을 업로드 해 주세요. 사진 크기: 500x500',
  };

  static Json meetupScheduleDescription = {
    'en': 'Meetup schedule description',
    'ko': '만남 일정 설명',
  };

  static Json meetupScheduleDescriptionNote = {
    'en': 'Please enter the description of the meetup schedule.',
    'ko': '만남 설명을 적어주세요.',
  };

  static Json meetupScheduleDateOrTimeMissing = {
    'en': 'Please select a meeting date and time.',
    'ko': '모임 날짜와 시간을 선택해주세요.',
  };

  static Json meetupScheduleUpdated = {
    'en': 'Meetup schedule updated',
    'ko': '만남 일정이 수정되었습니다.',
  };

  static Json editSchedule = {
    'en': 'Edit schedule',
    'ko': '일정 수정하기',
  };

  static Json meetupDateAndTime = {
    'en': 'Meetup date and time',
    'ko': '모임 날짜 & 시간',
  };

  static Json meetupEventApplyAttendBlocked = {
    'en': 'Attend blocked',
    'ko': '참석 차단',
  };

  static Json meetupEventApplyAttendBlockedMessage = {
    'en': 'Blocked members cannot apply to attend.',
    'ko': '차단된 회원은 참석 신청을 할 수 없습니다.',
  };

  static Json meetupMembershipRequired = {
    'en': 'Meetup membership required.',
    'ko': '클럽 가입 필요',
  };

  static Json meetupMembershipRequiredMessage = {
    'en': 'Please join the meetup first.',
    'ko': '모임에 먼저 가입을 해 주세요.',
  };

  static Json meetupCancelledAttendance = {
    'en': 'Attendance cancelled.',
    'ko': '참석을 취소했습니다.',
  };

  static Json meetupCancelAttendance = {
    'en': 'Cancel attendance',
    'ko': '참석 취소하기',
  };

  static Json meetupCancelAttendanceMessage = {
    'en': 'Meetup membership required.',
    'ko': '클럽 가입 필요',
  };

  static Json joinFirstThenApplyToAttend = {
    'en': 'Please join the meetup first and then apply to attend.',
    'ko': '모임에 먼저 가입을 하신 다음, 참석 신청을 주세요.',
  };

  static Json applyToAttendConfirmed = {
    'en': 'Apply to attend confirmed',
    'ko': '참석 신청했습니다.',
  };

  static Json applyToAttend = {
    'en': 'Apply to attend',
    'ko': '참석 신청하기',
  };

  static Json listOfAttendees = {
    'en': 'List of Applicants to Attend',
    'ko': '참석 신청자 목록',
  };

  static Json noApplicantsYet = {
    'en': 'There are no applicants to attend, yet.',
    'ko': '참석 신청자가 없습니다.',
  };

  static Json meetupAdminSettings = {
    'en': 'Meetup admin settings',
    'ko': '모임 관리자 설정',
  };

  static Json recommend = {
    'en': 'Recommend',
    'ko': '추천',
  };

  static Json all = {
    'en': 'All',
    'ko': '전체',
  };

  static Json title = {
    'en': 'Title',
    'ko': '제목',
  };

  static Json content = {
    'en': 'Content',
    'ko': '내용',
  };

  static Json community = {
    'en': 'Community',
    'ko': '커뮤니티',
  };

  static Json noResultFound = {
    'en': 'No result found.',
    'ko': '검색 결과가 없습니다.',
  };

  static Json meetup = {
    'en': 'Meetup',
    'ko': '모임',
  };

  static Json recommendWithCount = {
    'en': 'Recommend #count',
    'ko': '추천 #count',
  };

  static Json inputRecommendHint = {
    'en':
        'Input number only. Higher number will shown first. 0 will remove the recommendation.',
    'ko': '숫자만 입력하세요. 높은 숫자가 먼저 표시됩니다. 0은 권장 사항을 제거합니다.',
  };

  static Json recommendRemove = {
    'en': 'Remove recommendation',
    'ko': '추천 삭제',
  };

  static Json recommendRemoveMessage = {
    'en': 'Are you sure you want to remove this from recommendations list?',
    'ko': '추천 목록에서 이 항목을 삭제하시겠습니까?',
  };

  static Json meetupBlockUser = {
    'en': 'Block user',
    'ko': '사용자 차단하기',
  };

  static Json meetupBlockConfirmMessage = {
    'en': 'Are you sure you want to block this user?',
    'ko': '이 사용자를 차단하시겠습니까?',
  };

  static Json meetupUnblockUser = {
    'en': 'Unblock user',
    'ko': '사용자 차단 해제하기',
  };

  static Json meetupUnblockConfirmMessage = {
    'en': 'Are you sure you want to unblock this user?',
    'ko': '이 사용자를 차단 해제하시겠습니까?',
  };

  /// EO meetups translations

  // Chat Input
  static Json loginIsRequiredToUseThisFeature = {
    'en': 'Login is required to use this feature.',
    'ko': '이 기능을 사용하려면 로그인이 필요합니다.',
  };

  /// Block
  static Json cannotBlockYourself = {
    'en': 'You cannot block yourself.',
    'ko': '자신을 차단할 수 없습니다.',
  };

  static Json blocked = {
    'en': 'Blocked',
    'ko': '차단됨',
  };

  static Json blockedMessage = {
    'en': 'You have blocked this user.',
    'ko': '이 사용자를 차단하셨습니다.',
  };

  static Json blockedTitleMessage = {
    'en': 'Blocked this user',
    'ko': '이 사용자를 차단하셨습니다.',
  };

  static Json blockedContentMessage = {
    'en':
        'The contents of this user is hidden because you have blocked this user.',
    'ko': '이 사용자의 내용은 차단된 상태입니다.',
  };

  static Json blockedChatMessage = {
    'en': 'You have blocked this user. Chat message is hidden.',
    'ko': '이 사용자를 차단하셨습니다. 채팅 메시지는 숨겨집니다.',
  };

  static Json blockedUserMessage = {
    'en': 'You have blocked this user.',
    'ko': '이 사용자를 차단하셨습니다.',
  };

  static Json unblocked = {
    'en': 'Unblocked',
    'ko': '차단 해제됨',
  };

  static Json unblockedMessage = {
    'en': 'You have unblocked this user.',
    'ko': '이 사용자를 차단 해제하셨습니다.',
  };

  static Json disabledOnSendMessage = {
    'en': 'You cannot send a message because your account is disabled.',
    'ko': '메시지를 보낼 수 없습니다. 계정이 비활성화 상태입니다.'
  };

  static Json forumSearch = {
    'en': 'Forum Search',
    'ko': '검색',
  };

  static Json searchFilter = {
    'en': 'Search Filter',
    'ko': '검색 필터',
  };

  static Json searchKeywordHint = {
    'en': 'Please enter keyword',
    'ko': '검색어를 입력하세요',
  };

  static Json postDeletedOrNotFound = {
    'en': 'Post is deleted or not found',
    'ko': '게시글이 삭제되었거나 존재하지 않습니다.',
  };

  /// EO Block
  /// Report
  static const Json reportInputTitle = {
    'en': 'Report',
    'ko': '신고',
  };
  static const Json reportInputMessage = {
    "en": 'Please enter the reason for the report.',
    'ko': '신고 사유를 입력해 주세요.',
    'lo': 'ກະລຸນາໃສ່ເຫດຜົນຂອງບົດລາຍງານ.',
    'th': 'กรุณากรอกเหตุผลในการรายงาน',
    'vi': 'Vui lòng nhập lý do báo cáo.',
  };
  static const Json reportInputHint = {
    'en': 'Reason',
    'ko': '사유',
    'vi': 'Lý do',
    'th': 'เหตุผล',
    'lo': 'ເຫດ​ຜົນ',
  };

  // Chats

  static const Json newChat = {
    'en': 'New chat',
    'ko': '새로운 채팅',
  };

  static const Json noPermission = {
    'en': 'No permission.',
    'ko': '권한이 없습니다.',
  };

  static const Json noPermissionModifyChatRoom = {
    'en': 'You do not have permission to modify the chat room.',
    'ko': '채팅방을 수정할 권한이 없습니다',
  };

  static const Json chatRoomSettings = {
    'en': 'Chat Room Settings',
    'ko': '채팅방 설정',
  };

  static const Json chatRoomName = {
    'en': 'Chat Room Name',
    'ko': '채팅방 이름',
  };

  static const Json chatRoomDescription = {
    'en': 'Chat Room Description',
    'ko': '채팅방 설명',
  };

  static const Json uploadChatRoomIcon = {
    'en': 'Upload Chat Room Icon',
    'ko': '채팅방 아이콘 업로드',
  };

  static const Json verifiedMembersOnly = {
    'en': 'Verified members only',
    'ko': '인증 회원 전용',
  };

  static const Json invitation = {
    'en': 'Invitation',
    'ko': '초대',
  };

  static const Json search = {
    'en': 'Search',
    'ko': '검색',
  };

  static Json noMembers = {
    'en': 'No members!',
    'ko': '회원이 없습니다.',
  };

  static Json master = {
    'en': 'Master',
    'ko': '관리자',
  };

  static Json cannotJoinChatRoomError = {
    'en': 'Error. Cannot join the chat room.',
    'ko': '채팅방에 참여할 수 없습니다.',
  };

  static const Json notVerifiedMessage = {
    'en': 'You have not verified yourself.',
    'ko': '인증되지 않았습니다.',
    'vi': 'Bạn chưa tự mình xác minh.',
    'th': 'คุณยังไม่ได้ตรวจสอบด้วยตัวเอง',
    'lo': 'ທ່ານຍັງບໍ່ໄດ້ກວດສອບມັນເອງ.',
  };

  static const Json setting = {
    'en': 'Setting',
    'ko': '설정',
    'vi': 'cài đặt',
    'th': 'การตั้งค่า',
    'lo': 'ການຕັ້ງຄ່າ',
  };

  static const Json chatMessageDelete = {
    'en': 'Delete',
    'ko': '삭제',
  };

  static const Json openChat = {
    'en': 'Open Chat',
    'ko': '채팅방 열기',
  };

  static const Json anyoneCanJoinChat = {
    'en': 'Anyone can join.',
    'ko': '모든 회원이 채팅방에 참여할 수 있습니다.',
  };

  static const Json onlyVerifiedMembersCanJoinChat = {
    'en': 'Must be verified to join.',
    'ko': '인증 회원만 참여할 수 있습니다.',
  };

  static const Json passwordToJoin = {
    'en': 'Password to Join',
    'ko': '채팅방에 참여하기 위한 비밀번호',
  };

  static const Json leaveEmptyPasswordIfNotRequired = {
    'en': 'Empty means no password.',
    'ko': '비밀번호를 입력하지 않아도 됩니다.',
  };

  static const Json pleaseEnterChatRoomNameAndDescription = {
    'en': 'Please enter chat room name and description.',
    'ko': '채팅방 이름과 설명을 입력해주세요.',
  };

  static const Json pleaseEnterMessage = {
    'en': 'Please enter message.',
    'ko': '메시지를 입력해주세요.',
    'lo': 'ກະລຸນາໃສ່ຂໍ້ຄວາມ.',
    'th': 'กรุณากรอกข้อความ',
    'vi': 'Vui lòng nhập tin nhắn.',
  };

  static const Json blockedUsers = {
    'en': 'Blocked Users',
    'ko': '차단된 사용자',
  };

  static const Json chatEmptyBlockedUserList = {
    'en': 'No blocked users.',
    'ko': '차단된 사용자가 없습니다.',
  };

  /// DefaultUploadSelectionBottomSheet
  ///
  static const Json photoUpload = {
    'en': 'Upload a photo',
    'ko': '사진 업로드',
    'vi': 'Tải ảnh lên',
    'th': 'อัพโหลดรูปภาพ',
    'lo': 'ອັບໂຫຼດຮູບ',
  };

  static const Json selectPhotoFromGallery = {
    'en': 'Select photo from gallery',
    'ko': '갤러리에서 사진 선택',
    'lo': 'ເລືອກຮູບຈາກຄັງຮູບ',
    'th': 'เลือกภาพจากแกลเลอรี่',
    'vi': 'Chọn ảnh từ thư viện',
  };

  static const Json takePhotoWithCamera = {
    'en': 'Take photo with camera',
    'ko': '카메라로 사진 촬영',
    'vi': 'Chọn ảnh từ máy ảnh',
    'th': 'เลือกภาพจากกล้อง',
    'lo': 'ເລືອກຮູບຈາກກ້ອງຖ່າຍຮູບ',
  };

  static const Json chatRoomNoMessageYet = {
    'en': 'There is no message, yet.',
    'ko': '메시지가 없습니다.',
    'vi': 'Vẫn chưa có tin nhắn nào.',
    'th': 'ยังไม่มีข้อความเลย',
    'lo': 'ບໍ່ມີຂໍ້ຄວາມ, ທັນ.',
  };
  static const Json thereIsNoChatRoomInChatRoomListView = {
    'en': 'There is no chat room.',
    'ko': '채팅방이 없습니다.',
  };

  static const Json chatBlockedUsersList = {
    'en': 'Blocked Users',
    'ko': '차단된 사용자',
  };

  static const Json chatMessageDeleted = {
    'en': 'This message is deleted.',
    'ko': '이 메시지는 삭제되었습니다.',
  };
  static const Json chatMessageListPermissionDenied = {
    'en': 'Permission denied.',
    'ko': '권한이 없습니다.',
  };
  static const Json chatSendMessageBlockedUser = {
    'en': 'You are blocked.',
    'ko': '차단된 사용자입니다.',
  };
  static const Json chatMessageListViewBlockedUser = {
    'en': 'You are blocked from this chat.',
    'ko': '채팅방에 차단된 사용자입니다.',
  };
  static const Json readMore = {
    'en': 'Read More',
    'ko': '더보기',
  };
  static const Json viewProfile = {
    'en': 'View Profile',
    'ko': '프로필 보기',
  };
  static const Json deleteMessage = {
    'en': 'Delete Message',
    'ko': '메시지 삭제',
  };
  static const Json deleteMessageConfirmation = {
    'en':
        "Are you sure you want to delete this message? This action cannot be undone.",
    'ko': '메시지를 삭제하시겠습니까? 이 행동은 취소할 수 없습니다.',
  };
  static const Json blockUser = {
    'en': 'Block User',
    'ko': '사용자 차단',
  };
  static const Json unblockUser = {
    'en': 'Unblock User',
    'ko': '사용자 차단 해제',
  };
  static const Json blockUserChatConfirmation = {
    'en': "Are you sure you want to block this user from the chat room?",
    'ko': '채팅방에 차단하시겠습니까? 이 행동은 취소할 수 없습니다.',
  };
  static const Json unblockUserChatConfirmation = {
    'en':
        "Are you sure you want to unblock this user from the chat room? This person may see all the messages in the chat room.",
    'ko': '채팅방에 차단해제하시겠습니까? 이 행동은 취소할 수 없습니다.',
  };

  static const Json create = {
    "en": "Create",
    'ko': '생성',
  };

  static const Json leave = {
    'en': 'Leave',
    'ko': '나가기',
  };

  static const Json copy = {
    'en': 'Copy',
    'ko': '복사',
  };

  static const Json messageWasCopiedToClipboard = {
    'en': "Message was copied to clipboard.",
    'ko': '메시지가 클립보드에 복사되었습니다.',
  };

  // Chat-Setting

  static Json onlyVerifiedMembersCanSendUrl = {
    'en': 'Only verified members can send URL.',
    'ko': '인증 회원 전용 URL 입력',
  };

  static Json membersNeedToBeVerifiedToSendMessage = {
    'en': 'Members need to be verified to send URL to the chat room',
    'ko': '본인 인증 한 회원만 URL 링크를 입력 할 수 있습니다.',
  };

  static Json photoUploadOnlyForVerified = {
    'en': 'Only verified members can upload photos.',
    'ko': '인증 회원 전용 사진 등록'
  };

  static Json membersNeedToBeVerifiedToUploadPhoto = {
    'en': 'Members need to be verified to upload photos to the chat room',
    'ko': '본인 인증 한 회원만 사진을 등록 할 수 있습니다.',
  };

  static Json cannotEnterChatRoomWithoutVerification = {
    'en':
        'You cannot enter the chat room because you have not verified your identity.',
    'ko': '본인 인증을 하지 않아 채팅방에 입장할 수 없습니다.',
  };

  static Json chatRoomIsForVerifiedUsersOnly = {
    'en': 'Chat room is for verified users only.',
    'ko': '인증 회원 전용 채팅방입니다.',
  };

  static Json chatRoomMaleOnlyChatRoom = {
    'en': 'Only male can enter this chat room',
    'ko': '남성만 채팅방에 입장할 수 있습니다.',
  };

  static Json chatRoomFemaleOnlyChatRoom = {
    'en': 'Only female can enter this chat room',
    'ko': '여성만 채팅방에 입장할 수 있습니다.',
  };

  static Json chatRoomYourGenderIsNotAllowed = {
    'en': 'Your gender is not allowed.',
    'ko': '성별이 일치하지 않습니다.',
  };

  static Json enterPassword = {
    'en': 'Please enter a password.',
    'ko': '비밀번호를 입력해 주세요.',
  };

  // Chat-Setting

  static Json pushNotifications = {'en': "Push Notifications", 'ko': "알림"};

  static Json pushNotificationsOnComment = {
    'en': "Push Notifications on Comment",
    'ko': "댓글에 알림"
  };

  static Json pushNotificationsOnCommentEnable = {
    'en': "Enable push notifications on comment",
    'ko': "댓글 푸시 알림 활성화"
  };

  static Json pushNotificationsOnCommentDisable = {
    'en': "Disable push notifications on comment",
    'ko': "댓글 푸시 알림 비활성화"
  };

  /// Basic

  static const Json inputName = {
    'en': 'Please enter your name.',
    'ko': '이름을 입력해주세요.',
    'vi': 'Xin hãy nhập tên của bạn.',
    'th': 'กรุณากรอกชื่อของคุณ.',
    'lo': 'ກະລຸນາໃສ່ຊື່ຂອງທ່ານ.',
  };

  static const Json nameInputDescription = {
    'en': 'Please enter your name.',
    'ko': '이름을 입력해주세요.',
    'vi': 'Xin hãy nhập tên của bạn.',
    'th': 'กรุณากรอกชื่อของคุณ.',
    'lo': 'ກະລຸນາໃສ່ຊື່ຂອງທ່ານ.'
  };

  static const Json email = {
    'en': 'Email',
    'ko': '이메일',
    'vi': 'E-mail',
    'th': 'อีเมล',
    'lo': 'ອີເມວ',
  };

  static const Json inputEmail = {
    'en': 'Please enter your email.',
    'ko': '이메일을 입력해주세요.',
  };

  static const Json password = {
    'en': 'Password',
    'ko': '비밀번호',
    'lo': 'ລະຫັດຜ່ານ',
    'th': 'รหัสผ่าน',
    'vi': 'Mật khẩu',
  };

  static const Json inputPassword = {
    'en': 'Please enter your password.',
    'ko': '비밀번호를 입력해주세요.',
  };

  static const Json next = {
    'en': 'Next',
    'ko': '다음',
    'vi': 'Kế tiếp',
    'th': 'ต่อไป',
    'lo': 'ຕໍ່ໄປ',
  };

  static const Json prev = {
    'en': 'Prev',
    'ko': '이전',
    'lo': 'ກ່ອນໜ້າ',
    'th': 'ก่อนหน้า',
    'vi': 'Trước đó',
  };

  static const Json back = {
    'en': 'Back',
    'ko': '뒤로',
  };

  static const Json likes = {
    'en': 'Likes',
    'ko': '좋아요',
  };

  static const Json thereAreNoBookmarksInTheList = {
    'en': 'There are no bookmarks in the list.',
    'ko': '북마크가 없습니다.',
  };

// Friends
  static const Json myReceivedFriendRequests = {
    'en': 'My Received Requests',
    'ko': '내가 받은 친구 요청',
  };

  static const Json mySentFriendRequests = {
    'en': 'My Sent Requests',
    'ko': '내가 보낸 친구 요청',
  };

  static const Json respondFriendRequests = {
    'en': 'Respond Friend Requests',
    'ko': '친구 요청 응답',
  };

  static const Json youAreFriendsAlready = {
    'en': 'You are friends already.',
    'ko': '이미 친구입니다.',
  };

  static const Json youHaveRequestedAlready = {
    'en': 'You have requested already.',
    'ko': '이미 친구 요청을 보냈습니다.',
  };

  static const Json youHaveSentAFriendRequest = {
    'en': 'You have sent a friend request.',
    'ko': '친구 요청을 보냈습니다.',
  };

  static const Json youHaveAcceptedAFriendRequest = {
    'en': 'You have accepted a friend request.',
    'ko': '친구 요청을 수락했습니다.',
  };

  static const Json youHaveRejectedAFriendRequest = {
    'en': 'You have rejected a friend request.',
    'ko': '친구 요청을 거절했습니다.',
  };

  static const Json youHaveCancelledAFriendRequest = {
    'en': 'You have cancelled a friend request.',
    'ko': '친구 요청을 취소했습니다.',
  };

  static const Json alreadyRejected = {
    'en': 'Already Rejected',
    'ko': '이미 거절했습니다.',
  };

  static const Json alreadyAccepted = {
    'en': 'Already Accepted',
    'ko': '이미 수락했습니다.',
  };

  static const Json alreadyRequested = {
    'en': 'Already Requested',
    'ko': '이미 요청했습니다.',
  };

  static const Json alreadyRequestedCancelRequestInsteadConfirmMessage = {
    'en':
        "You have already requested this user. Do you want to cancel the request instead?",
    'ko': "이 사용자의 요청을 이미 보냈습니다. 그 요청을 대신 취소하시겠습니까?",
  };

  static const Json requested = {
    'en': 'Requested',
    'ko': '요청',
  };

  static const Json alreadyRejectedAcceptRequestInsteadConfirmMessage = {
    'en':
        "You have already rejected this user. Do you want to accept the request instead?",
    'ko': "이 사용자의 요청을 이미 거절했습니다. 그 요청을 대신 수락하시겠습니까?",
  };

  static const Json friendRequest = {
    'en': 'Friend Request',
    'ko': '친구 요청',
  };

  static const Json respondRequest = {
    'en': 'Respond Request',
    'ko': '친구 요청 응답',
  };

  static const Json youCantAddYourselfAsFriend = {
    'en': 'You can\'t add yourself as friend.',
    'ko': '자신을 친구로 추가할 수 없습니다.',
  };

  static const Json accept = {
    'en': 'Accept',
    'ko': '수락',
  };

  static const Json reject = {
    'en': 'Reject',
    'ko': '거절',
  };

  static const Json noReceivedRequestYet = {
    'en': 'No received request yet.',
    'ko': '받은 요청이 없습니다.',
  };

  static const Json noSentRequestYet = {
    'en': 'No sent request yet.',
    'ko': '보낸 요청이 없습니다.',
  };

  static const Json noFriendYet = {
    'en': 'No friend yet.',
    'ko': '친구가 없습니다.',
  };

  static const Json thisUserWantsToAddYouAsFriend = {
    'en': 'This user wants to add you as a friend.',
    'ko': '이 사용자는 당신을 친구로 추가하고 싶습니다.',
  };

  // ----> Friends

  // static const String inputTitle = 'Input title';
  static const Json inputTitle = {
    'en': 'Input title',
    'ko': '제목을 입력해주세요.',
  };

  // static const String inputContent = 'Input content';
  static const Json inputContent = {
    'en': 'Input content',
    'ko': '내용을 입력해주세요.',
  };

  static const Json inputContentHere = {
    'en': 'Input content Here...',
    'ko': '내용을 입력해주세요.',
  };

  // User Settings

  static const Json getNotifiedWhenSomeoneCommentOnYourPost = {
    'en': "Get notified when other user comments/replies on your post/comment",
    'ko': ""
  };

  /// Label, texts, buttons,
  static const String dismiss = 'dismiss';

  /// EO Block

  ///////////////////////////////////////////////////////////////////

  // static const String stateMessageInProfileUpdate = 'STATE MESSAGE';
  static const Json stateMessageInProfileUpdate = {
    'en': 'STATE MESSAGE',
    'ko': '상태 메시지',
  };

  // static const String hintInputStateMessage = 'Please input your state message';
  static const Json hintInputStateMessage = {
    'en': 'Please input your state message',
    'ko': '상태 메시지를 입력해주세요.',
  };

  // static const String stateMessageDescription = 'State Message Description';
  static const Json stateMessageDescription = {
    'en': 'State Message Description',
    'ko': '상태 메시지 설명',
    'vi': 'Mô tả thông báo trạng thái',
    'th': 'คำอธิบายข้อความสถานะ',
    'lo': 'ລາຍລະອຽດຂໍ້ຄວາມຂອງລັດ',
  };

  // static const String blockConfirmTitle = 'Block this user?';
  static const Json blockConfirmTitle = {
    'en': 'Block this user?',
    'ko': '사용자를 차단할까요?',
    'vi': 'Chặn người dùng này?',
    'th': 'บล็อกผู้ใช้นี้?',
    'lo': 'ປິດຜູ້ໃຊ້ນີ້?',
  };

  // static const String blockConfirmMessage =
  //     'Do you want to block this user?\nYou will not be able to see the contents of this user.';
  static const Json blockConfirmMessage = {
    'en':
        'Do you want to block this user?\nYou will not be able to see the contents of this user.',
    'ko': '사용자를 차단할까요?\n사용자의 내용을 볼 수 없습니다.',
    'vi':
        'Bạn có muốn chặn người dùng này?\nBạn sẽ không thể xem nội dung của người dùng này nữa.',
    'th':
        'คุณต้องการบล็อกผู้ใช้นี้หรือไม่?\nคุณจะไม่สามารถดูเนื้อหาของผู้ใช้นี้ได้',
    'lo': 'ທ່ານຕ້ອງການປິດຜູ້ໃຊ້ນີ້ບໍ?',
  };

  // static const String unblockConfirmTitle = 'Unblock this user?';
  static const Json unblockConfirmTitle = {
    'en': 'Unblock this user?',
    'ko': '사용자를 차단해제할까요?',
    'vi': 'Hủy chặn người dùng này?',
    'th': 'ยกเลิกการบล็อกผู้ใช้นี้',
    'lo': 'ປິດຜູ້ໃຊ້ນີ້?',
  };

  // static const String unblockConfirmMessage =
  //     'If you unblock this user, you will be able to see the contents of this user.';
  static const Json unblockConfirmMessage = {
    'en':
        'If you unblock this user, you will be able to see the contents of this user.',
    'ko': '사용자를 차단해제할까요?\n사용자의 내용을 볼 수 없습니다.',
    'vi': 'Bạn sẽ có thể xem nội dung của người dùng này lại.',
    'th': 'คุณจะสามารถดูเนื้อหาของผู้ใช้นี้อีกครั้ง',
    'lo': 'ທ່ານຈະສາມາດເບິ່ງເນື້ອຫາຂອງຜູ້ໃຊ້ນີ້ອີກຄັ້ງ.',
  };

  // static const String writeYourMessage = 'Write your message';
  static const Json writeYourMessage = {
    'en': 'Write your message',
    'ko': '메시지를 입력해주세요.',
  };

  // static const String visitedYourProfileTitle = 'Your profile was visited.';
  static const Json visitedYourProfileTitle = {
    'en': 'Your profile was visited.',
    'ko': '사용자의 프로필을 방문했습니다.',
    'lo': 'ໂປຣໄຟລ໌ຂອງທ່ານຖືກເຂົ້າເບິ່ງແລ້ວ.',
    'vi': 'Hồ sơ của bạn đã được truy cập.',
    'th': 'โปรไฟล์ของคุณถูกเยี่ยมชม',
  };

  // static const String visitedYourProfileBody = '#name visited your profile';
  static const Json visitedYourProfileBody = {
    'en': '#name visited your profile',
    'ko': '#name 사용자의 프로필을 방문했습니다.',
    'th': '#name เยี่ยมชมโปรไฟล์ของคุณ',
    'vi': '#name đã truy cập hồ sơ của bạn',
    'lo': '#name ໄດ້ໄປຢ້ຽມຢາມໂປຣໄຟລ໌ຂອງທ່ານ',
  };

  /// User and Profile
  static const String recentLoginRequiredForResign =
      'recentLoginRequiredForResign';

  // static const String backgroundImage = 'Background Image';
  static const Json backgroundImage = {
    'en': 'Background Image',
    'ko': '배경 이미지',
    'vi': 'Hình nền',
    'th': 'ภาพพื้นหลัง',
    'lo': 'ພາບພື້ນຫຼັງ',
  };

  // static const String profilePhoto = 'Profile Photo';
  static const Json profilePhoto = {
    'en': 'Profile Photo',
    'ko': '프로필 사진',
    'vi': 'Ảnh hồ sơ',
    'th': 'รูปประจำตัว',
    'lo': 'ຮູບໂປຣໄຟລ໌',
  };

  // static const String takePhotoClosely = 'Take a photo closely';
  static const Json takePhotoClosely = {
    'en': 'Take a photo closely',
    'ko': '사진을 찍어주세요.',
    'vi': 'Chụp ảnh',
    'th': 'ถ่ายรูป',
    'lo': 'ຖ່າຍ​ຮູບ',
  };

  // static const String birthdateLabel = 'Birthdate';
  static const Json birthdateLabel = {
    'en': 'Birthdate',
    'ko': '생년월일',
    'th': 'วันที่เกิด',
    'vi': 'Ngày sinh',
    'lo': 'ວັນເດືອນປີເກີດ',
  };

  // static const String birthdateSelectDescription = 'birthdateSelectDescription';
  static const Json birthdateSelectDescription = {
    'en': 'birthdateSelectDescription',
    'ko': '생년월일을 선택해주세요.',
  };

  // static const String birthdateTapToSelect = 'Tap to select';
  static const Json birthdateTapToSelect = {
    'en': 'Tap to select',
    'ko': '선택하기',
  };

  // static const String birthdate = 'birthdate';
  static const Json birthdate = {
    'en': 'birthdate',
    'ko': '생년월일',
  };

  // static const String selectBirthDate = 'Select Birth';
  static const Json selectBirthDate = {
    'en': 'Select Birth',
    'ko': '생년월일 선택',
    'vi': 'Chọn ngày sinh',
    'th': 'เลือกวันเกิด',
    'lo': 'ເລືອກວັນເກີດ',
  };

  // static const String yearInBirthdatePicker = 'Year';
  static const Json yearInBirthdatePicker = {
    'en': 'Year',
    'ko': '년',
    'vi': 'Năm',
    'th': 'ปี',
    'lo': 'ປີ',
  };

  // static const String monthInBirthdatePicker = 'Month';
  static const Json monthInBirthdatePicker = {
    'en': 'Month',
    'ko': '월',
    'vi': 'Tháng',
    'th': 'เดือน',
    'lo': 'ເດືອນ',
  };

  // static const String dayInBirthdatePicker = 'Day';
  static const Json dayInBirthdatePicker = {
    'en': 'Day',
    'ko': '일',
    'vi': 'Ngày',
    'th': 'วัน',
    'lo': 'ມື້',
  };

  // static const String descriptionInBirthdatePicker =
  //     'Please select your birthdate.';
  static const Json descriptionInBirthdatePicker = {
    'en': 'Please select your birthdate.',
    'ko': '생년월일을 선택해주세요.',
    'vi': 'Vui lòng chọn ngày sinh của bạn',
    'th': 'โปรดเลือกวันเกิดของคุณ',
    'lo': 'ກະລຸນາເລືອກວັນເກີດຂອງທ່ານ',
  };

  // profile update labels and error messages
  // static const String gender = 'Gender';
  static const Json gender = {
    'en': 'Gender',
    'ko': '성별',
    'th': 'เพศ',
    'vi': 'giới tính',
    'lo': 'ເພດ',
  };

  static const Json profile = {
    'en': 'Profile',
    'ko': '프로필',
    'th': 'โปรไฟล์',
    'vi': 'Hồ sơ',
    'lo': 'ໂປຣໄຟລ໌',
  };

  static const Json selectBirthdate = {
    'en': 'Select Birthdate',
    'ko': '생년월일 선택'
  };

  static const Json phoneNumberCannotBeEdited = {
    'en': 'Phone number cannot be edited.',
    'ko': '전화번호를 수정할 수 없습니다.',
  };

  static const Json noPhoneNumber = {
    'en': 'No phone number',
    'ko': '전화번호 없음',
  };

  // day like in date picker
  static const Json day = {
    'en': 'Day',
    'ko': '일',
    'vi': 'Ngày',
    'th': 'วัน',
    'lo': 'ມື້'
  };

  static const Json month = {
    'en': 'Month',
    'ko': '월',
    'vi': 'Tháng',
    'th': 'เดือน',
    'lo': 'ເດືອນ'
  };

  static const Json year = {
    'en': 'Year',
    'ko': '년',
    'vi': 'Năm',
    'th': 'ปี',
    'lo': 'ປີ'
  };

  static const Json pleaseSelectYourBirthDate = {
    'en': 'Please select your birthdate.',
    'ko': '생년월일을 선택해주세요',
  };

  static const Json pleaseInputYourEmail = {
    'en': 'Please input your email.',
    'ko': '이메일을 입력해주세요.',
  };

  static const Json accountIsAlreadyVerified = {
    'en': 'Account is already verified.',
    'ko': '이미 인증된 계정입니다.',
  };

  static const Json unableToUpdateBecauseAccountIsAlreadyVerified = {
    'en':
        "Unable to update account because account is already verified. Please contact admin for assistance if needed.",
    'ko': '계정이 이미 확인되어 업데이트할 수 없습니다. 도움이 필요하시면 관리자에게 문의해 주세요.',
  };

  static const Json any = {
    'en': 'Any',
    'ko': '상관없음',
  };

  // static const String genderInProfileUpdate = 'GENDER';
  static const Json genderInProfileUpdate = {
    'en': 'GENDER',
    'ko': '성별',
    'th': 'เพศ',
    'vi': 'giới tính',
    'lo': 'ເພດ',
  };

  // static const String male = 'Male';
  static const Json male = {
    'en': 'Male',
    'ko': '남자',
    'th': 'ชาย',
    'vi': 'Nam giới',
    'lo': 'ຜູ້​ຊາຍ',
  };

  // static const String female = 'Female';
  static const Json female = {
    'en': 'Female',
    'ko': '여자',
    'lo': 'ເພດຍິງ',
    'vi': 'Nữ giới',
    'th': 'หญิง',
  };

  static const Json noUserFound = {
    'en': 'No user found',
    'ko': '사용자를 찾을 수 없습니다.',
  };

  // static const String nationality = 'Nationality';
  static const Json nationality = {
    'en': 'Nationality',
    'ko': '국적',
    'th': 'ສັນຊາດ',
    'vi': 'Quốc tịch',
    'lo': 'Quốc tịch',
  };

  // static const String region = 'Region';
  static const Json region = {
    'en': 'Region',
    'ko': '지역',
    'th': 'ภูมิภาค',
    'vi': 'vùng đất',
    'lo': 'ພາກພື້ນ',
  };

  // static const String pleaseInputBirthday = 'Please input your birthday';
  static const Json pleaseInputBirthday = {
    'en': 'Please input your birthday',
    'ko': '생년월일을 입력해주세요.',
  };

  // static const String pleaseSelectGender = 'Please select your gender';
  static const Json pleaseSelectGender = {
    'en': 'Please select your gender',
    'ko': '성별을 선택해주세요.',
  };

  // static const String addYourPhoto = 'Add your photo. (Minimum 2, Maximum 4)';
  static const Json addYourPhoto = {
    'en': 'Add your photo. (Minimum 2, Maximum 4)',
    'ko': '사진을 추가해주세요. (최소 2, 최대 4)',
  };

  // static const String pleaseSelectNationality =
  //     'Please select your nationality';
  static const Json pleaseSelectNationality = {
    'en': 'Please select your nationality',
    'ko': '국적을 선택해주세요.',
  };

  // static const String pleaseSelectRegion = 'Please select your region';
  static const Json pleaseSelectRegion = {
    'en': 'Please select your region',
    'ko': '지역을 선택해주세요.',
  };

  // static const String pleaseInputOccupation = 'Please input your occupation';
  static const Json pleaseInputOccupation = {
    'en': 'Please input your occupation',
    'ko': '직업을 입력해주세요.',
  };

  // static const String pleaseAddMorePhotos =
  //     'Please add more photos (minimum 2 of photos and maximum 2 of photos)';
  static const Json pleaseAddMorePhotos = {
    'en':
        'Please add more photos (minimum 2 of photos and maximum 2 of photos)',
    'ko': '사진을 추가해주세요. (최소 2개의 사진, 최대 2개의 사진)',
    'lo': 'ກະລຸນາເພີ່ມຮູບເພີ່ມເຕີມ (ຢ່າງໜ້ອຍ 2 ຮູບ ແລະສູງສຸດ 2 ຮູບ)',
    'vi': 'Vui lòng thêm nhiều ảnh hơn (tối thiểu 2 ảnh và tối đa 2 ảnh)',
    'th': 'โปรดเพิ่มรูปภาพเพิ่มเติม (รูปภาพขั้นต่ำ 2 รูป และรูปภาพสูงสุด 2 รูป)'
  };

  // static const String pleaseInputStateMessage =
  //     'Please input your state/introduction message';
  static const Json pleaseInputStateMessage = {
    'en': 'Please input your state/introduction message',
    'ko': '상태메세지를 입력해주세요.',
  };

  /// Forum Post Comment
  // static const String deletePostConfirmTitle = 'Delete this post?';
  static const Json deletePostConfirmTitle = {
    'en': 'Delete this post?',
    'ko': '이 글을 삭제하시겠습니까?',
  };

  // static const String deletePostConfirmMessage =
  //     'Are you sure you want to delete post?\nYou will not be able to recover this post.';
  static const Json deletePostConfirmMessage = {
    'en':
        'Are you sure you want to delete post?\nYou will not be able to recover this post.',
    'ko': '이 글을 삭제하시겠습니까?\n이 글은 복구할 수 없습니다.',
  };

  // static const String deleteCommentConfirmTitle = 'Delete this comment?';
  static const Json deleteCommentConfirmTitle = {
    'en': 'Delete this comment?',
    'ko': '이 글을 삭제하시겠습니까?',
  };

  // static const String deleteCommentConfirmMessage =
  //     'Are you sure you want to delete comment?';
  static const Json deleteCommentConfirmMessage = {
    'en': 'Are you sure you want to delete comment?',
    'ko': '이 글을 삭제하시겠습니까?',
  };

  // static const String notYourComment = 'This is not your comment.';
  static const Json notYourComment = {
    'en': 'This is not your comment.',
    'ko': '이 글은 당신이 작성한 글이 아닙니다.',
  };

  // static const String occupation = 'occupation';
  static const Json occupation = {
    'en': 'occupation',
    'ko': '직업',
    'th': 'ອາຊີບ',
    'vi': 'nghề nghiệp',
    'lo': 'ອາຊີບ',
  };

  static const String occupationInputDescription = 'occupationInputDescription';
  // static const String hintInputOccupation = 'Please input your occupation';
  static const Json hintInputOccupation = {
    'en': 'Please input your occupation',
    'ko': '직업을 입력해주세요.',
  };

  // static const String postEmptyList = 'No post found.';
  static const Json postEmptyList = {
    'en': 'No post found.',
    'ko': '글이 없습니다.',
  };

  // static const String commentEmptyList = 'No comments';
  static const Json commentEmptyList = {
    'en': 'No comments',
    'ko': '댓글이 없습니다.',
  };

  // static const String postCreate = 'Create';

  static const Json postCreate = {
    'en': 'Create',
    'ko': '글쓰기',
  };
  // static const String postUpdate = 'Update';
  static const Json postUpdate = {
    'en': 'Update',
    'ko': '글수정',
  };

  static const Json howAreYouFeelingToday = {
    'en': 'How are you feeling today?',
    'ko': '오늘 어떠셨나요?',
  };

  /// Meetup

  // static const String meetupEmptyList = 'No meetup found.';
  static const Json meetupEmptyList = {
    'en': 'No meetup found.',
    'ko': '모임이 없습니다.',
  };

  /// Phone sign in
  // static const String phoneNumber = 'Phone Number';
  static const Json phoneNumber = {
    'en': 'Phone Number',
    'ko': '전화번호',
    'lo': 'ເບີ​ໂທລະ​ສັບ',
    'vi': 'Số điện thoại',
    'th': 'หมายเลขโทรศัพท์',
  };
  // static const String phoneSignInHeaderTitle =
  //     'Please enter your phone number and tap "Get Verification Code" button.';
  static const Json phoneSignInHeaderTitle = {
    'en':
        'Please enter your phone number and tap "Get Verification Code" button.',
    'ko': '전화번호를 입력하고 "인증 코드 받기" 버튼을 눌러주세요.',
    'th': 'กรุณากรอกหมายเลขโทรศัพท์ของคุณแล้วแตะปุ่ม "รับรหัสยืนยัน"',
    'vi': 'Vui lòng nhập số điện thoại của bạn và nhấn nút "Nhận mã xác minh".',
    'lo': 'ກະລຸນາໃສ່ເບີໂທລະສັບຂອງທ່ານແລະແຕະປຸ່ມ "ຮັບລະຫັດຢືນຢັນ".',
  };

  static const Json signInFailed = {
    'en': 'Sign in failed.',
    'ko': '로그인에 실패했습니다.',
  };

  // static const String phoneNumberInputHint = 'Enter your phone number.';
  static const Json phoneNumberInputHint = {
    'en': 'Enter your phone number.',
    'ko': '전화번호를 입력해주세요.',
    'vi': 'Nhập số điện thoại của bạn.',
    'th': 'ใส่หมายเลขโทรศัพท์ของคุณ',
    'lo': 'ກະລຸນາໃສ່ເບີໂທລະສັບຂອງທ່ານ',
  };

  // static const String phoneNumberInputDescription =
  //     'Input phone number. e.g 010 1234 5678 or 0917 1234 5678';
  static const Json phoneNumberInputDescription = {
    'en': 'Input phone number. e.g 010 1234 5678 or 0917 1234 5678',
    'ko': '전화번호를 입력해주세요. e.g 010 1234 5678 or 0917 1234 5678',
    'vi': 'Nhập số điện thoại. Ví dụ: 010 1234 5678 hoặc 0917 1234 5678',
    'th': 'ใส่หมายเลขโทรศัพท์ เช่น 010 1234 5678 หรือ 0917 1234 5678',
    'lo': 'ໃສ່ເບີໂທລະສັບ. ຕົວຢ່າງ: 010 1234 5678 ຫຼື 0917 1234 5678',
  };

  // static const String phoneSignInTimeoutTryAgain = 'Timeout. Please try again.';
  static const Json phoneSignInTimeoutTryAgain = {
    'en': 'Timeout. Please try again.',
    'ko': '시간 초과. 다시 시도해주세요.',
    'vi': 'Quá thời gian. Vui lòng thử lại.',
    'th': 'หมดเวลา โปรดลองอีกครั้ง',
    'lo': 'ເວລາສົ່ງບີດ. ກະລຸນາລອງອີກ',
  };

  // static const String phoneSignInGetVerificationCode = 'Get Verification Code';
  static const Json phoneSignInGetVerificationCode = {
    'en': 'Get Verification Code',
    'ko': '인증 코드 받기',
    'vi': 'Nhận Mã Xác Minh',
    'th': 'รับรหัสยืนยัน',
    'lo': 'ຮັບລະຫັດຢຶນ',
  };
  // static const String phoneSignInInputSmsCode =
  //     'Input Verification Code and press submit button';
  static const Json phoneSignInInputSmsCode = {
    'en': 'Input Verification Code and press submit button',
    'ko': '인증 코드를 입력하고 제출 버튼을 눌러주세요.',
    'vi': 'Nhập Mã Xác Minh và nhấn nút gửi.',
    'th': 'ใส่รหัสยืนยันและกดปุ่มส่ง',
    'lo': 'ພິມລະຫັດຢຶນແລະກົດປຸ່ມສົ່ງ',
  };
  // static const String phoneSignInRetry = 'Retry';
  static const Json phoneSignInRetry = {
    'en': 'Retry',
    'ko': '다시 시도',
    'vi': 'Thử lại',
    'th': 'ลองอีกครั้ง',
    'lo': 'ລອງອີກ',
  };

  // static const String phoneSignInVerifySmsCode = 'Verification Code';
  static const Json phoneSignInVerifySmsCode = {
    'en': 'Verification Code',
    'ko': '인증 코드',
    'vi': 'Xác Minh Mã',
    'th': 'ยืนยันรหัส',
    'lo': 'ຢຶນລະຫັດຢຶນ',
  };

  // static const String invalidSmsCodeMessage = 'Invalid SMS code';
  static const Json invalidSmsCodeMessage = {
    'en': 'Invalid SMS code',
    'ko': '잘못된 SMS 코드',
  };

  /// Korean Sigungu Selector
  // static const String selectProvince = "Select Province";
  static const Json selectProvince = {
    'en': 'Select Province',
    'ko': '시도 선택',
    'vi': 'Chọn Tỉnh/Thành phố',
    'th': 'เลือกจังหวัด',
    'lo': 'ເລືອກແຂວງ',
  };

  // static const String selectRegion = 'Select Region';
  static const Json selectRegion = {
    'en': 'Select Region',
    'ko': '시군구 선택',
    'vi': 'Chọn Khu vực',
    'th': 'เลือกภูมิภาค',
    'lo': 'ເລືອກເຂດ'
  };
  // static const String noSelectTedRegion = 'No selected province';
  static const Json noSelectTedRegion = {
    'en': 'No selected province',
    'ko': '시도를 선택해주세요.',
    'vi': 'Không có tỉnh/thành phố được chọn',
    'th': 'ไม่ได้เลือกจังหวัด',
    'lo': 'ບໍ່ມີແຂວງທີ່ເລືອກ',
  };

  // BlockScreen
  // static const String noBlockUser = 'No blocked users';
  static const Json noBlockUser = {
    'en': 'No blocked users',
    'ko': '차단된 사용자가 없습니다.',
    'vi': 'Không có người dùng bị chặn',
    'th': 'ไม่มีผู้ใช้ที่ถูกบล็อก',
    'lo': 'ບໍ່ມີຜູ້ໃຊ້ທີ່ໄດ້ຖືກປິດ'
  };
  // static const String youCanBlockUserFromTheirProfilePage =
  //     'You can block users from their profile page';
  static const Json youCanBlockUserFromTheirProfilePage = {
    'en': 'You can block users from their profile page',
    'ko': '차단할 수 있는 사용자의 프로필 페이지에서 차단할 수 있습니다.',
    'vi': 'Bạn có thể chặn người dùng từ trang hồ sơ của họ',
    'th': 'คุณสามารถบล็อกผู้ใช้จากหน้าโปรไฟล์ของพวกเขา',
    'lo': 'ທ່ານສາມາດປິດຜູ້ໃຊ້ຈາກຫົວຂໍ້ບັນຊີຂອງເຂົ້າ',
  };

  // SettingScreen
  // static const String pushNotificationsOnProfileView =
  //     'Push Notifications on Profile View';
  static const Json pushNotificationsOnProfileView = {
    'en': 'Push Notifications on Profile View',
    'ko': '프로필 페이지에서 알림을 받을 수 있습니다.',
    'vi': 'Thông báo đẩy khi xem hồ sơ',
    'th': 'การแจ้งเตือนผลัดจากการดูโปรไฟล์',
    'lo': 'การแจ้งเตือนผลัดเมื่อดูโปรไฟล์',
  };
  // static const String getNotifiedWhenSomeoneViewYourProfile =
  //     'Get notified when someone views your profile';
  static const Json getNotifiedWhenSomeoneViewYourProfile = {
    'en': 'Get notified when someone views your profile',
    'ko': '차단할 수 있는 사용자의 프로필 페이지에서 차단할 수 있습니다.',
    'vi': 'Nhận thông báo khi có người xem hồ sơ của bạn',
    'th': 'รับการแจ้งเตือนเมื่อมีคนดูโปรไฟล์ของคุณ',
    'lo': 'รับการแจ้งเตือนเมื่อมีคนดูโปรไฟล์ของคุณ',
  };
  // static const String chooseYourLanguage = 'Choose your language';
  static const Json chooseYourLanguage = {
    'en': 'Choose your language',
    'ko': '언어를 선택해주세요.',
    'vi': 'Chọn ngôn ngữ của bạn',
    'th': 'เลือกภาษาของคุณ',
    'lo': 'ເລືອກພາສາຂອງທ່ານ',
  };

  /// Used in DefaultLoginFirstScreen
  // static const String loginRequredTitle = 'Login Required';
  static const Json loginRequredTitle = {
    'en': 'Login Required',
    'ko': '로그인이 필요합니다.',
  };

  // static const String loginRequredMessage = 'Please login to continue.';
  static const Json loginRequredMessage = {
    'en': 'Please login to continue.',
    'ko': '로그인을 해주세요.',
  };

  // static const String askToLoginMessage =
  //     'Login is required to continue. Do you want to login?';
  static const Json askToLoginMessage = {
    'en': 'Login is required to continue. Do you want to login?',
    'ko': '로그인이 필요합니다. 로그인 하시겠습니까?',
  };

  // Club Translation
  // static const String clubCreate = '모임 만들기';
  // static const String clubUpdate = '모임 수정하기';
  // static const String clubName = '모임 이름';
  // static const String clubNameDescription = '모임 이름을 적어주세요.';
  // static const String clubPhotoDescription =
  // '  모임 사진을 업로드 해 주세요. 사진 너비: 800, 사진 높이: 500';

  // static const String clubDescriptionLabel = '모임 설명';
  // static const String clubDescriptionInputDescription = "모임 설명을 적어주세요.";
  // static const String clubUpdateMessage = '모임이 수정되었습니다.';

  // static const String userNotFoundTitleOnShowPublicProfileScreen = '사용자 정보 오류';
  static const Json userNotFoundTitleOnShowPublicProfileScreen = {
    'en': 'User Information Error',
    'ko': '사용자 정보 오류',
    'vi': 'Lỗi Thông Tin Người Dùng',
    'th': 'ข้อผิดพลาดในข้อมูลผู้ใช้',
    'lo': 'ຂໍ້ມູນຜູ້ໃຊ້ຜິດພາດ',
  };

  // static const String userNotFoundMessageOnShowPublicProfileScreen =
  //     '사용자의 정보가 올바르지 않습니다. 탈퇴한 사용자이거나 정보가 없습니다.';
  static const Json userNotFoundMessageOnShowPublicProfileScreen = {
    'en':
        'User information is not valid. The user has either deleted or there is no information',
    'ko': '사용자의 정보가 올바르지 않습니다. 탈퇴한 사용자이거나 정보가 없습니다.',
    'vi': 'Người dùng đã từ chức hoặc không có thông tin người dùng khả dụng',
    'th': 'ผู้ใช้ได้ลาออกหรือไม่มีข้อมูลผู้ใช้ที่ใช้ได้',
    'lo': 'ຜູ້ໃຊ້ໄດ້ລາອອກຫຼືບໍ່ມີຂໍ້ມູນຜູ້ໃຊ້ທີ່ມີຢູ່ໃນ',
  };

  // static const String userNotFoundTitleOnSingleChat = '사용자 정보 오류';
  static const Json userNotFoundTitleOnSingleChat = {
    'en': 'User Information Error',
    'ko': '사용자 정보 오류',
  };

  // static const String userNotFoundMessageOnSingleChat =
  //     '사용자의 정보가 올바르지 않습니다. 탈퇴한 사용자이거나 정보가 없습니다.';
  static const Json userNotFoundMessageOnSingleChat = {
    'en':
        'User information is not valid. The user has either deleted or there is no information',
    'ko': '사용자의 정보가 올바르지 않습니다. 탈퇴한 사용자이거나 정보가 없습니다.',
  };

  static const Json confirmSendTestMessageToAllUsers = {
    'en': 'Send Test Message to all users',
    'ko': '모든 사용자에게 테스트 메시지 보내기',
  };

  static const Json confirmSendTestMessageToAllUsersMessage = {
    'en':
        'Warning!!! Are you sure you want to send a test message to all users?',
    'ko': '경고!!! 모든 사용자에게 테스트 메시지를 보내시겠습니까?',
  };

  static const Json confirmMirrorUserDataToFirestore = {
    'en': 'Mirror User data to firestore',
    'ko': 'Firestore에 사용자 데이터를 복사합니다.',
  };

  static const Json confirmMirrorUserDataToFirestoreMessage = {
    'en': 'Warning!!! Are you sure you want to mirror user data to firestore?',
    'ko': '경고!!! Firestore에 사용자 데이터를 복사하시겠습니까?',
  };

  static const Json request = {
    'en': 'Request',
    'ko': '요구',
  };
  static const Json rejected = {
    'en': 'Rejected',
    'ko': '거부됨',
  };
  static const Json accepted = {
    'en': 'Accepted',
    'ko': '수락됨',
  };

  static const Json noReportsFound = {
    'en': 'No report found',
    'ko': '보고서를 찾을 수 없습니다.',
  };

  static const Json adminDashboard = {
    'en': 'Admin Dashboard',
    'ko': '관리 대시 보드'
  };

  static const Json fullUserList = {
    'en': 'Full User List',
    'ko': '전체 사용자 목록',
  };

  static const Json reportList = {
    'en': 'Report List',
    'ko': '신고목록',
  };

  static const Json sendPushMessageToAllUser = {
    'en': 'Send push message to all users',
    'ko': '모든 사용자에게 푸시 메시지 보내기',
  };

  static const Json mirrorUserDataToFiresotre = {
    'en': 'Mirror User Data to Firestore',
    'ko': ' Firestore에 사용자 데이터 미러링',
  };

  static const Json manageMeetup = {
    'en': 'Manage Meetup',
    'ko': '모임 관리',
  };

  static const Json loadingPost = {
    'en': 'Loading post...',
    'ko': '포스트 로딩중...',
  };

  static const Json otherUserNotVerified = {
    'en': 'The user has not yet been verified.',
    'ko': '사용자가 아직 확인되지 않았습니다.',
  };

  static const Json userAuthentication = {
    'en': 'User Authentication',
    'ko': '사용자 인증',
  };

  static const Json userHasBeenAuthenticated = {
    'en': 'User has been authenticated.',
    'ko': '인증이 완료된 사용자입니다.',
  };

  static const Json authenticateUser = {
    'en': 'Not authenticated. Do you want to switch to authenticated user?',
    'ko': '인증되지 않았습니다. 인증된 사용자로 전환 하시겠습니까?',
  };

  static const Json complete = {
    'en': 'Complete',
    'ko': '완료',
  };

  static const Json removed = {
    'en': 'Removed',
    'ko': '해제',
  };

  static const Json success = {
    'en': 'Success',
    'ko': '완료되었습니다.',
  };

  static const Json confirmBlockThisUser = {
    'en': 'Do you want to block this user?',
    'ko': '이 사용자를 차단하시겠습니까?',
  };

  static const Json confirmUnblockThisUser = {
    'en': 'Blocked. Do you want to unblock this user?',
    'ko': '막힌. 이 사용자의 차단을 해제하시겠습니까?',
  };

  static const Json adminSetting = {
    'en': 'Admin Setting',
    'ko': '관리자 설정',
  };

  static const Json confirmRemoveAdminPrevilege = {
    'en': 'Do you want to remove administrator privileges?',
    'ko': '관리자 권한을 제거하시겠습니까?',
  };

  static const Json confirmSetAdminPrevilege = {
    'en': 'Do you want to set administrator privileges?',
    'ko': '관리자 권한을 설정하시겠습니까?',
  };

  static const Json adminSetupMessage = {
    'en':
        'Administrator settings must be set directly in the /admins path of RTDB. Please refer to the administrator settings document.',
    'ko': '관리자 설정은 RTDB 의 /admins 경로에서 직접 설정해야 합니다. 관리자 설정 문서를 참고하세요',
  };
}
