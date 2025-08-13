import 'package:delivery_app/common/const/color.dart';
import 'package:flutter/material.dart';



class RestaurantCard extends StatelessWidget {
  final Widget image;
  final String name;
  final List<String> tags;
  final int ratingCount;
  final int deliveryTime;
  final int deliveryFee;
  final double rating;

  const RestaurantCard({
    super.key,
    required this.image,
    required this.name,
    required this.tags,
    required this.ratingCount,
    required this.deliveryFee,
    required this.deliveryTime,
    required this.rating
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ClipRRect(
            child: image,
            borderRadius: BorderRadius.circular(12),
          ),
          const SizedBox(height: 16,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20
                ),
              ),
              SizedBox(height: 6,),
              Text(
                tags.join(' · '),
                style: TextStyle(
                  color: Body_Text_Color,
                  fontSize: 14
                ),
              ),
              SizedBox(height: 6,),
              Row(
                children: [
                  _IconText(icon: Icons.star, label: rating.toString()),
                  renderDot(),
                  _IconText(icon: Icons.receipt, label: ratingCount.toString()),
                  renderDot(),
                  _IconText(icon: Icons.timelapse_outlined, label: '$deliveryTime 분'),
                  renderDot(),
                  _IconText(icon: Icons.timelapse_outlined, label: deliveryFee == 0? '무료' : deliveryFee.toString()),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
  Widget renderDot(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        '·',
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 12
        ),
      ),
    );
  }
}


class _IconText extends StatelessWidget {
  final IconData icon;
  final String label;


  const _IconText({
    super.key,
    required this.icon,
    required this.label
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Primary_Color,
          size: 14,
        ),
        SizedBox(width: 8,),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500
          ),
        )
      ],
    );
  }
}

