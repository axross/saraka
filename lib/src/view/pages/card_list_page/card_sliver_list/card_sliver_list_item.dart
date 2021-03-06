import 'package:flutter/material.dart' hide Card;
import 'package:saraka/constants.dart';
import '../../../../entities/card.dart';
import './proficiency_description.dart';
import './proficiency_line_chart.dart';
import './menu_icon_button.dart';
import './next_review_date_description.dart';
import './synthesize_icon_button.dart';

class CardSliverListItem extends StatelessWidget {
  CardSliverListItem({
    Key key,
    @required this.card,
    this.showDetail = true,
  })  : assert(card != null),
        super(key: key);

  final Card card;

  final bool showDetail;

  Widget build(BuildContext context) => Material(
        shape:
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(24)),
        elevation: 16,
        shadowColor: SarakaColor.lightBlack.withOpacity(0.1),
        color: Color(0xffffffff),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.only(right: 64, bottom: 24),
                child: ProficiencyLineChart(),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 16,
                          left: 16,
                          right: 8,
                        ),
                        child: Text(
                          card.text,
                          overflow: TextOverflow.ellipsis,
                          style: SarakaTextStyle.heading,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 4, right: 4),
                      child: MenuIconButton(),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(
                    top: 8,
                    bottom: 8,
                    left: 8,
                    right: 24,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SynthesizeIconButton(text: card.text),
                    ]..addAll(showDetail
                        ? [
                            Expanded(child: Container()),
                            SizedBox(
                              width: 96,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: NextReviewDateDescription(
                                  nextReviewScheduledAt:
                                      card.nextReviewScheduledAt,
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            SizedBox(
                              width: 80,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: ProficiencyDescription(
                                    proficiency: card.proficiency),
                              ),
                            ),
                          ]
                        : []),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
