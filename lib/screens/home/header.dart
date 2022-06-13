import 'package:flutter/material.dart';

class Header extends StatefulWidget {
  const Header({Key? key}) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  final whiteColor = Colors.white;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: Image.asset('assets/images/home_header.webp').image)),
        width: constraints.maxWidth,
        height: constraints.maxHeight,
        child: Row(
          children: [
            Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Icon(
                                Icons.menu,
                                color: whiteColor,
                                size: 32,
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Center(
                                child: Text('Your Things',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3!
                                        .copyWith(color: whiteColor)),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'Sep 5,2015',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            color: whiteColor.withOpacity(0.6)),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 3,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              stops: const [
                            0,
                            0.25,
                            0.5,
                            1
                          ],
                              colors: [
                            Colors.blue.shade900,
                            Colors.blue.shade700,
                            Colors.blue.shade500,
                            Colors.blue.shade300
                          ])),
                    )
                  ],
                )),
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2),
                    gradient: const LinearGradient(
                        colors: [Colors.black, Colors.transparent],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        stops: [0.05, 1])),
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                    Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '24',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(color: whiteColor),
                              ),
                              Text(
                                'Personal',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: whiteColor.withOpacity(0.6)),
                              )
                            ],
                          ),
                          const SizedBox(width: 5),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '15',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(color: whiteColor),
                              ),
                              Text(
                                'Business',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: whiteColor.withOpacity(0.6)),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  value: 0.6,
                                  strokeWidth: 2,
                                  backgroundColor: Colors.blue.shade900,
                                  color: Colors.blue.shade500,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                '65 % done',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: whiteColor.withOpacity(0.6)),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
