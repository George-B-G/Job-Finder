import 'package:amit_job_finder/shared/components/constant.dart';
import 'package:flutter/material.dart';

Widget verticalSpace({
  required double value,
}) =>
    SizedBox(
      height: screenDefaultSize * value,
    );
Widget horizontalSpace({
  required double value,
}) =>
    SizedBox(
      width: screenDefaultSize * value,
    );

pushToPage({
  required BuildContext context,
  required Widget screenName,
}) =>
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screenName,
      ),
    );
pushReplacementToPage({
  required BuildContext context,
  required Widget screenName,
}) =>
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => screenName,
      ),
    );

// used to build onboarding screen
Widget buildPageViewItem({
  required String imagePath,
  required String startTitleSpan,
  required String midTitleSpan,
  required String subTitle,
  String endTitleSpan = '',
}) =>
    Column(
      children: [
        verticalSpace(value: 10),
        SizedBox(
          height: screenDefaultSize * 35,
          child: Image(
            image: AssetImage(imagePath),
          ),
        ),
        verticalSpace(value: 2),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: startTitleSpan,
                style: const TextStyle(
                  fontSize: 27,
                  color: Color(0xff2f2e41),
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextSpan(
                text: midTitleSpan,
                style: const TextStyle(
                  fontSize: 27,
                  color: Color(0xff3366FF),
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextSpan(
                text: endTitleSpan,
                style: const TextStyle(
                  fontSize: 27,
                  color: Color(0xff2f2e41),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        verticalSpace(value: 1.5),
        Text(
          subTitle,
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );

// for custom appbar
AppBar appbarWithLogo({
  String title = '',
  List<Widget>? lst,
  bool showingAction = false,
  bool isHavingButton = false,
}) =>
    AppBar(
      title: Text(title),
      actions: showingAction
          ? [
              Image(
                image: AssetImage(mainAppLogo),
                height: 25,
              ),
              horizontalSpace(value: 1),
            ]
          : (isHavingButton ? lst : []),
    );

Widget buildCustomTitle({
  required String title,
  required String subTitle,
  CrossAxisAlignment crossAxisAlignmentVal = CrossAxisAlignment.start,
  TextAlign textAlignVal = TextAlign.start,
}) =>
    Column(
      crossAxisAlignment: crossAxisAlignmentVal,
      children: [
        Text(
          title,
          textAlign: textAlignVal,
          style: const TextStyle(
            fontSize: 20,
            color: Color(0xff2f2e41),
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          subTitle,
          textAlign: textAlignVal,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );

Widget customTextField({
  required String hinttextValue,
  TextEditingController? textEditingController,
  Function? validatorFunction,
  Function? onChangeFunction,
  Function? onTapFunction,
  TextInputType? keyboardTextInputType,
  TextInputAction? keyboardTextInputAction,
  bool isObsecureText = false,
  Widget? prefixIconData,
  Widget? suffixIconData,
  BorderRadius borderRadiusValue =
      const BorderRadius.all(Radius.circular(15.0)),
  int? minFieldLines,
  maxFieldLines,
}) =>
    TextFormField(
      minLines: minFieldLines,
      maxLines: maxFieldLines,
      controller: textEditingController,
      validator: (value) => validatorFunction!(value),
      onChanged: (value) => onChangeFunction!(value),
      onTap: () => onTapFunction!(),
      keyboardType: keyboardTextInputType,
      textInputAction: keyboardTextInputAction,
      obscureText: isObsecureText,
      decoration: InputDecoration(
        hintText: hinttextValue,
        isDense: true,
        prefixIcon: prefixIconData,
        suffixIcon: suffixIconData,
        border: OutlineInputBorder(
          borderRadius: borderRadiusValue,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadiusValue,
          borderSide: const BorderSide(
            color: Color(0xff3366FF),
          ),
        ),
      ),
    );

// -----> to login or sign_up with google or facebook
Widget accessWithFacebookOrGoogle({
  required String title,
  String? image,
  IconData? iconData,
  Function? ontap,
}) =>
    Expanded(
      child: Container(
        height: 50,
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
        ),
        child: TextButton.icon(
          onPressed: () => ontap!(),
          icon: image == null
              ? Icon(
                  iconData,
                  size: 30,
                )
              : Image.asset(
                  image,
                  height: 25,
                ),
          label: Text(
            title,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
// -----> to navigate from screen to another screens
Widget fastNavigatorLink({
  required String text,
  required String buttonTitle,
  required Function onPress,
  required BuildContext context,
  MainAxisAlignment mainAxisAlignmentVal = MainAxisAlignment.center,
  TextStyle? styleVal,
  TextStyle? buttonStyleVal,
}) =>
    Row(
      mainAxisAlignment: mainAxisAlignmentVal,
      children: [
        Text(
          text,
          style: styleVal,
        ),
        InkWell(
          child: Text(
            buttonTitle,
            style: buttonStyleVal,
          ),
          onTap: () => onPress(),
        ),
      ],
    );

Widget screenSeparator({
  required String title,
  TextAlign textAlignVal = TextAlign.start,
}) =>
    Container(
      height: 35,
      width: double.infinity,
      padding: const EdgeInsets.only(top: 5.5, left: 10),
      color: Colors.grey.shade200,
      child: Text(
        title,
        textAlign: textAlignVal,
        style:
            TextStyle(fontWeight: FontWeight.w600, color: Colors.grey.shade700),
      ),
    );

Widget buildListViewSeparator({
  required int count,
  required Widget? Function(BuildContext, int) itemBuilderVal,
  Widget separatorWidget = const Divider(),
  ScrollPhysics scrollPhysics = const NeverScrollableScrollPhysics(),
  bool isReversed = false,
  Axis scrollDirectionValue = Axis.vertical,
}) =>
    ListView.separated(
      shrinkWrap: true,
      reverse: isReversed,
      physics: scrollPhysics,
      scrollDirection: scrollDirectionValue,
      separatorBuilder: (context, index) => separatorWidget,
      itemCount: count,
      itemBuilder: itemBuilderVal,
    );

// job card used in home screen
Widget jobListTile({
  required context,
  required String imageLink,
  required String jobTitle,
  required String jobSubtitle,
  required String jobPriceOrDate,
  required String jobTimeType,
  IconData trailingIcon = Icons.bookmark_outline,
  Function? onIconButtonPress,
  Function? onListTileTap,
}) =>
    Column(
      children: [
        ListTile(
          dense: true,
          title: Text(
            jobTitle,
            style: Theme.of(context).primaryTextTheme.bodyLarge,
          ),
          subtitle: Text(
            jobSubtitle,
            style: Theme.of(context).primaryTextTheme.bodyLarge,
          ),
          leading: Image.network(
            imageLink,
            width: 40,
          ),
          onTap: () => onListTileTap!(),
          trailing: IconButton(
            onPressed: () => onIconButtonPress!(),
            icon: Icon(
              trailingIcon,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Wrap(
              spacing: 5.0,
              children: List<Widget>.generate(
                1,
                (int index) {
                  return ChoiceChip(
                    padding: const EdgeInsets.all(0),
                    showCheckmark: false,
                    selectedColor: const Color(0xffD6E4FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    label: Text(
                      jobTimeType,
                      style: Theme.of(context).primaryTextTheme.labelMedium,
                    ),
                    selected: false,
                    onSelected: (bool selected) {},
                  );
                },
              ).toList(),
            ),
            Text(
              jobPriceOrDate,
              style: const TextStyle(
                textBaseline: TextBaseline.alphabetic,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ],
    );

Widget buildChoiceChip({
  required List lst,
  required context,
  required int lengthValue,
  required bool isSelected,
}) =>
    Wrap(
      spacing: 5.0,
      children: List<Widget>.generate(
        lengthValue,
        (int index) {
          return ChoiceChip(
            padding: const EdgeInsets.all(0),
            showCheckmark: false,
            selectedColor: const Color(0xffD6E4FF),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            label: Text(
              lst[index],
              style: Theme.of(context).primaryTextTheme.labelMedium,
            ),
            onSelected: (value) {},
            selected: isSelected,
          );
        },
      ).toList(),
    );
