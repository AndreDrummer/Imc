import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imc/core/constants/app_strings.dart';
import 'package:imc/core/shared/formatters.dart';
import 'package:imc/core/models/imc_model.dart';
import 'package:flutter/material.dart';

class HistoryItem extends StatelessWidget {
  const HistoryItem({
    required this.imc,
    Key? key,
  }) : super(key: key);

  final ImcModel imc;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0.h),
                  child: Text(
                    imc.description,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16.0.sp,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0.h),
                  child: Text(
                    '${AppStrings.calculatedIMC}: ${imc.imcValue}',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                      fontSize: 14.0.sp,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(Formatters.dateDDMMYY(imc.dateTime)),
                Text(Formatters.timeHHMM(imc.dateTime)),
                Row(
                  children: List.generate(
                    imc.stars,
                    (index) => Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 16.0.h,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }
}
