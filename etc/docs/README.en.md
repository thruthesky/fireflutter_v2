# FireFlutter


- [FireFlutter](#fireflutter)
  - [Terms](#terms)
  - [Building as a core developer](#building-as-a-core-developer)
  - [How to use](#how-to-use)
  - [Coding convention](#coding-convention)
    - [Documenations](#documenations)
      - [Mermaid](#mermaid)
    - [Model and Service class](#model-and-service-class)
    - [Data listing](#data-listing)
  - [Documentation](#documentation)
  - [Test](#test)
    - [Unit test](#unit-test)
    - [Widget test](#widget-test)
    - [House test](#house-test)
  - [Translation](#translation)
  - [Friend](#friend)
    - [Friend Logic](#friend-logic)


## Terms

- `easy packages` is used to call the packages related with `FireFlutter` like `easyuser`, `easychat`, `easy_forum`, etc.


## Building as a core developer

- Create your own example app with `example/lib/main.[feature].dart`. Don't touch others app.



## How to use

Usually, you will need to add these packages blow into `pubspec.ymal` to develop an app (or another package).

```
easy_helpers: latest
easy_locale: latest
easy_storage: latest
easy_user: latest
```

These packages are compatible among `easy packages`. You can simply add only one package to `pubspec.yaml` like `easychat` to add the chat function to your app.





## Coding convention


### Documenations

#### Mermaid

- Starting must be `START(xxxx)`
- End must be `END(())`
- End with options should be `BUTTONS>Many options]`. For instance, after create a post, the app will show post deatil screen where the user can choose many options. And the process is finished when the post is created, then use this.
- Process must be `WORK[xxxx]`
- Create, Save, Update, Delete, or anything that need Database work must be `SAVE[(CREATE|UPDATE|DELETE)]`
- Subroutines, or the next screen, dialog should be displayed with `NEXT_SCREEN[[List screen xxx]]`.


### Model and Service class

Model class does
- serialization/deserialization
- basic crud of the model data
- helper functions of the entity itself. Not other entities of the same model.
- encapsulating the refs.

Service class does
- something that are related with the model(entity) or the service can handle for the whole function(feacher).
- showing screens
- search & listing data
- initialization, listening, etc.


### Data listing

Use `FirestoreQueryBuilder` or `FirebaseDatabaseQueryBuilder`. Use query builder all the time.



## Documentation

There is no english version of documents. So, write all the document in the source code. The comment int source code will turn into dartdoc when it is deployed into pub.dev.


## Test


### Unit test

Do the unit test as Flutter does.

### Widget test


Do the widget test as Flutter does.


### House test


This is a special test for house only. This is because it's not easy to test while connection with Firebase.



## Translation

- initialize

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  TranslationService.instance.setDeviceLocale();
  runApp(const MyApp());
}
```

- t
```dart
Translation.instance.setLocale('ko');
'name'.t // 결과: 이름
```


- tr

```dart
final translationTexts = {
    'apple': {
        'en': {
            'zero': '{name} has no apple.',
            'one': '{name} has one apple.',
            'many': '{name} has {n} apples.',
        }
    }
};
```

Exmaple

```dart
TranslationService.instance.set(
  key: 'apple',
  locale: 'en',
  value: {
    'zero': '{name} has no apple.',
    'one': '{name} has one apple.',
    'many': '{name} has {n} apples.',
  },
);

int n = 0;
expect('apple'.tr(args: {'name': 'J'}, form: n), 'J has no apple.');
n = 1;
expect('apple'.tr(args: {'name': 'J'}, form: n), 'J has one apple.');
n = 3;
expect('apple'.tr(args: {'name': 'J', 'n': n}, form: n), 'J has 3 apples.');
```


## Friend


### Friend Logic


- All friend relation data is saved in the documents right under `friends` documents.
- The id of the document is the uid of the user.
- Each document has `sent`, `received`, `mutal`, `rejected` fields and each field is an array of uid string.
- If A request to B, then the firestore structure will be
```json
/friends
  /A { sent: [B] }
  /B { received: [A] }
```


- If B accepts A's request, the database will be like below
  - If A accepts B, then B should be removed from `sent` or `receieved` fields and move to `mutual` field.
```json
/friends
  /A { mutual: [B] }
  /B { mutual: [A] }
```


- If C request to D, and D rejected,
```json
/friends
  /C {sent: [D]},
  /D {rejected: [C]},
```

- If C request to A, and A rejected
```json
  /A {mutual: [B], rejected: [C]}
  /C {sent: [A, D]}
```


- If D request to A, and A accepts
```json
  /A {mtual: [B, D], rejected: [C]}
  /D {mutual: [A], rejected: [C]}
```


