# Functions

These functions are provided to be used anywhere in the code as needed.

## Error

To display an error, there is a widget that displays a dialog. You can use that dialog widget with `showDialog`. Or you can use `error` function.

## toast

Toast can be used to show a snackbar with a message.

```dart
toast(context: context, message: 'Hello User.');
```

Parameters:

- [required] BuildContext context
  - the build context of the current widget
- String title
  - title text of the snackbar
- [required] String message
  - message to show as text
- Icon? icon
  - Icon to add in the snackbar
- Duration duration
  - how long does the snackbar shows? [default] const Duration(seconds: 8)
- Function(Function) onTap
  - on tap function
- bool error
  - is it an error message?
- bool hideCloseButton
  - [default] false
- Color backgroundColor
- Color foregroundColor
- double runSpacing
  - spacing between the icon and the message [default] 12

## confirm

The `confirm` is a prompt that will let the user choose from yes or no.

```dart
final re = await confirm(
    context: context,
    title: 'Delete Account',
    message: 'Are you sure you want to delete your account?'
);
```

The `re` in the example will be a nullable bool. If `re` is `true` means user chooses yes. If `false` means user chooses no. If `null` means neither user chooses yes nor no.

Parameters:

- [required] BuildContext context
- [required] String title
  - title of the message
- [required] String message
  - Add the question or confirmation message here.

## input

The `input` function can be used to ask for an input from user.

```dart
final re = await input(
    context: context,
    title: 'Name',
    subtitle: 'Enter your lovely name',
    hintText: 'Last Name, First Name',
);
```

Parameters:

- [required] BuildContext context
- [required] String title
  - The title of the prompt
- String subtitle
  - The subtitle or additional info for input box
- [required] String hintText
  - hintText for the input box
- String initialValue
  - the default input value