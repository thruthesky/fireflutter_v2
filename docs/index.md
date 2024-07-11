# 파이어 플러터 이해

FireFlutter 는 아름답고 막강한 기능의 앱을 간단하고 쉽게 만들 수 있게 해 주는 플러터+파이어베이스 프레임워크입니다.

**할일: 2024년 7월 현재, 거대한 FireFlutter 를 각 기능별로 패키지를 세분화 하고 있습니다. easy_packages 를 참고해 주세요.**


## 개요

- 누구나 참여할 수 있습니다.
- 라이센스는 MIT 이며, 누구든지 어떤 목적으로든 사용 할 수 있습니다.
- 지원하는 플랫폼은 ANDROID, IOS, MACOS, LINUX, WEB, WINDOWS 입니다.
- 백엔드는 파이어베이스 함수를 사용합니다. 가능한 많은 것을 플러터에서 하되, 벡엔드가 꼭 필요하면 파이어베이스 내에서 모든 처리를 하기 위해서 파이어베이스 함수를 사용합니다.
- FireFlutter 버전 0.4.0 에서는 모든 기능을 다 포함했었던 (거대했었던) FireFlutter 패키지를 기능별로 여러 패키지로 나누어 재 활용을 편하게 했으며, 메인 데이터베이스를 Firestore 로 변경하였습니다.

### 짧은 설명

어떤 앱이든 공통적으로 들어가는 기능들이 있습니다. 본 프로젝트는 그러한 기능들을 개별 패키지로 만들고 pub.dev 에 배포하여 누구든지 자신의 앱에 쉽게 추가하여 개발 할 수 있도록 하는 것입니다.

요점은 각 기능별 패키지들이 독립적으로 완전히 분리되어 필요한 패키지 하나만 쓸 수 있도록 하는 것입니다. 예를 들어, 여러분들이 개발하는 앱에 채팅 패키지만 추가하고 싶다면 easychat 패키지만 추가해서 쉽게 채팅 기능을 만드는 것입니다.

채팅 기능 패키지 분만아니라, 회원 관리, 게시판, 친구 관리, 소셜 기능 등 여러가지 패키지들이 있습니다. 또한 얼마든지 원하는 패키지를 추가 할 수 있습니다.

## 참여

- 누구든지 참여 가능하며, 오픈 소스로 개발합니다.
  - Fork 한 다음 PR 하시면 됩니다.

- 세미나를 통해서 배우며 같이 할 수 있습니다.
  - GIT, 문서화 등의 기본적인 것 부터 시작하며
  - Unit Test, Widget Test 가 익숙하지 않다면 배울 수 있는 좋은 기회가 될 것입니다.

- 개발에 참여하고 싶으신 분들은 [플러터 만능앱 단톡방](https://open.kakao.com/o/gNs8gvid) 으로 접속하시면 됩니다.


## 프로젝트 구성 팁

- 프로젝트가 어떻게 설계 또는 구성 되는지를 간략하게 설명하여 참여를 유도하기 위해 알려드립니다.

- 각 패키지 개발자는
  - 테스트 코드(Unit Test, Widget Test)를 제공해야 하며,
  - 문서화를 잘 해야하며
  - 스타일 가이드에 맞게 코딩을 해야 합니다.
  - 또한 아름다운 UI/UX 디자인을 하셔야 합니다. 물론 세미나를 통해서 어떻게 아름다운 UI/UX 를 만들 수 있는지 서로 연구하고 배울 것입니다.


- Firebase SDK 버전은 BoM 2.2.0 으로 통일합니다. 만약, 이와 관련하여 depencies 충돌이 발생하면 dependency override 로 해결합니다.

- Firestore 를 전적으로 사용하지만, 보조적으로 Realtime Database 를 쓸 수 있습니다. 예를 들어, 비용이 너무 증가 할 것 같다면 Realtime Database 만으로도 작업을 할 수 있습니다.

- Firebase 로 가능한 것은 Firebase 로 합니다. 외부 서비스(3rd party service)를 사용하기 전에 반드시 상의를 한 번 해 보시기 바랍니다.

### 데이터베이스 구조

[데이터베이스 구조](./database.md) 문서를 참고해 주세요.

## 설치

- Dependencies 를 설치할 때, version 충돌이 발생하면, dependencies override 로 해결 하도록 합니다.

- easy package 를 개발(또는 수정)하면서 여러분의 앱을 같이 개발 하고 싶다면 아래와 같이 pubspec.yaml 을 구성해 보세요.
```yaml
dependencies:
  easy_helpers:
  easy_locale:
  easy_storage:
  easyuser:
dependency_overrides:
  easy_helpers:
    path: ./packages/easy_helpers
  easy_locale:
    path: ./packages/easy_locale
  easy_storage:
    path: ./packages/easy_storage
  easyuser:
    path: ./packages/easyuser
```

- 또는 팀원들과 같이 작업을 한다면, `git subtree` 형식도 추천해 드립니다.



## 주요 Easy Package 목록

참고로 아래의 패키지들은 독립적이며 완전히 개별적인 패키지들이며 필요한 것만 골라서 여러분의 앱에 추가하여 사용하시면 됩니다. 물론 서로 같이 쓰면 더욱 좋은 효과를 낼 수 있습니다.


### 스토리지

사진 등을 업로드하기 위한 패키지로 easy user, easy chat, easy forum 등에서 사용하는 기본 패키지입니다.
여러분의 앱에서는 여러분들이 원하는 데로 코딩해서 하면 됩니다. 굳이 easy stroage 패키지를 사용 할 필요가 없습니다. 물론 사용을 해도 됩니다.

[스토리지 패키지 - easy stroage](https://pub.dev/packages/easy_storage)를 참고하세요.



### 사용자

사용자 기능 패키지를 통해서 전반적인 사용 기능 및 UI/UX를 이용 할 수 있습니다. 물론 본 패키지를 사용하지 않고 직접 회원 관리 등을 하시면 됩니다.

[사용자 패키지 - easy user](https://pub.dev/packages/easyuser)를 참고하세요.



### 친구

- 친구를 맺고 서로 대화하는 기능입니다.

[친구 패키지 - easy friend](https://pub.dev/packages/easy_friend)를 참고하세요.



### 채팅

- 채팅방의 모든 기능이 다 들어가 있는 패키지

[채팅 패키지 - easy chat](https://pub.dev/packages/easychat)를 참고하세요.



### 게시판


### 일감 관리 시스템

일감 관리 시스템은 회사 업무, 학교 업무 등 기타 여러가지 상황에서 해야 할 일들을 관리하는 시스템입니다. 간단하게는 `TODO` 기능을 가지는 앱이라고 생각 할 수 있으며 보다 넓게는 업무 관리 시스템이라고 할 수 있습니다.


[일감 관리 시스템 패키지 - easy task](https://pub.dev/packages/easy_task)를 참고하세요.





## 그 외 Easy Package 와 같이 쓰면 좋은 잡다한 패키지


FireFlutter 와 직접적으로 연관되는 패키지는 아니지만 FireFlutter 가 내부적으로 사용하는 패키지들입니다.



- easy_helpers - FireFlutter 에 필요한, 각종 공유 함수나 Extension 등을 담고 있습니다. 이 패키지는 앱에서 쓸 필요는 없습니다. 물론 써도 됩니다.


- easy_locale - 다국어 번역 패키지. pub.dev 에 많은 다국어 번역 패키지가 있지만, 보다 간단하 easy_locale 패키지를 사용합니다. 여러분들의 앱에서 이 패키지를 쓸 필요는 없습니다. 물론 써도 됩니다.



- date_picker_v2 for date picker. It's very simple UI/UX. I made it because I don't like the Android and iOS UI.
- social_design_system - A beautiful UI/UX theme library.
- phone_sign_in - For phone sign in. It's good for review and testing.

- memory_cache - 각종 임시 값들을 메모리에 캐시하기 위해서 사용합니다.
- rxdart: ^0.27.7
- cached_network_image: ^3.3.1 참고로, cached_network_image: ^3.3.1 과 rxdart: ^0.27.7 버전과 맞아야 한다. 그렇지 않아면 종속성 에러가 발생한다.

