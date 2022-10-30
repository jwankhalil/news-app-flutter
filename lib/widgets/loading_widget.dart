// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:card_swiper/card_swiper.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:news_app/constants/vars.dart';
import 'package:news_app/services/utils.dart';
import 'package:news_app/widgets/vertical_spacing.dart';
import 'package:shimmer/shimmer.dart';

class LoadingWidget extends StatefulWidget {
  LoadingWidget({required this.newsType});
  NewsType newsType;
  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  BorderRadius borderRadius = BorderRadius.circular(18);
  late Color baseShimmerColor, highLightShimmerColor, widgetShimmerColor;

  @override
  void didChangeDependencies() {
    var utils = Utils(context: context);
    baseShimmerColor = utils.baseShimmerColor;
    highLightShimmerColor = utils.highLightShimmerColor;
    widgetShimmerColor = utils.widgetShimmerColor;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context: context).getScrrenSize;
    return widget.newsType == NewsType.topTrending
        ? Swiper(
            autoplayDelay: 8000,
            autoplay: true,
            itemWidth: size.width * 0.9,
            layout: SwiperLayout.STACK,
            viewportFraction: 0.9,
            itemCount: 5,
            itemBuilder: (context, index) {
              return TopTrendingLoadingWidget(
                  baseShimmerColor: baseShimmerColor,
                  highLightShimmerColor: highLightShimmerColor,
                  size: size,
                  widgetShimmerColor: widgetShimmerColor,
                  borderRadius: borderRadius);
            },
          )
        : Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 50,
                itemBuilder: (context, index) {
                  return ArticleShimmerEffect(
                    context,
                    size,
                  );
                }),
          );
    ;
  }

  Padding ArticleShimmerEffect(BuildContext context, Size size) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).cardColor,
        child: Stack(
          children: [
            Container(
              height: 60,
              width: 60,
              color: Theme.of(context).colorScheme.secondary,
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                height: 60,
                width: 60,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              color: Theme.of(context).cardColor,
              child: Shimmer.fromColors(
                baseColor: baseShimmerColor,
                highlightColor: highLightShimmerColor,
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        height: size.height * 0.12,
                        width: size.height * 0.12,
                        color: widgetShimmerColor,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: size.height * 0.06,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: borderRadius,
                                color: widgetShimmerColor),
                          ),
                          VerticalSpacing(5),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              height: size.height * 0.025,
                              width: size.width * 0.4,
                              decoration: BoxDecoration(
                                  borderRadius: borderRadius,
                                  color: widgetShimmerColor),
                            ),
                          ),
                          Row(
                            children: [
                              ClipOval(
                                child: Container(
                                  height: 25,
                                  width: 25,
                                  color: widgetShimmerColor,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              FittedBox(
                                child: Container(
                                  height: size.height * 0.025,
                                  width: size.width * 0.4,
                                  decoration: BoxDecoration(
                                      borderRadius: borderRadius,
                                      color: widgetShimmerColor),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TopTrendingLoadingWidget extends StatelessWidget {
  const TopTrendingLoadingWidget({
    Key? key,
    required this.baseShimmerColor,
    required this.highLightShimmerColor,
    required this.size,
    required this.widgetShimmerColor,
    required this.borderRadius,
  }) : super(key: key);

  final Color baseShimmerColor;
  final Color highLightShimmerColor;
  final Size size;
  final Color widgetShimmerColor;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Shimmer.fromColors(
          baseColor: baseShimmerColor,
          highlightColor: highLightShimmerColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Container(
                  height: size.height * 0.33,
                  width: double.infinity,
                  color: widgetShimmerColor,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Container(
                  width: double.infinity,
                  height: size.height * 0.06,
                  decoration: BoxDecoration(
                    color: widgetShimmerColor,
                    borderRadius: borderRadius,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Container(
                    height: size.height * 0.025,
                    width: size.width * 0.4,
                    decoration: BoxDecoration(
                      color: widgetShimmerColor,
                      borderRadius: borderRadius,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
