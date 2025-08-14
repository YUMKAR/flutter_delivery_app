import 'package:delivery_app/common/service/auth_api.dart';
import 'package:delivery_app/restaurant/components/restaurant_card.dart';
import 'package:flutter/material.dart';


class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService auth = AuthService();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: FutureBuilder<List>(
        future: auth.paginateRestaurant(),
        builder: (context, AsyncSnapshot<List> snapshot){

          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator());
          }
          return ListView.separated(
            itemCount: snapshot.data!.length,
            itemBuilder: (_, index){
              final item = snapshot.data![index];

              return RestaurantCard(
                image: Image.network(
                  'https://gitea.yumkar.online/${item['thumbUrl']}',
                  fit: BoxFit.cover,
                ),
                name: item['name'],
                tags: List<String>.from(item['tags']),
                ratingsCount: item['ratingsCount'],
                deliveryFee: item['deliveryFee'],
                deliveryTime: item['deliveryTime'],
                ratings: item['ratings'],
              );
            },
            separatorBuilder: (_, index){
              return SizedBox(height: 16,);
            },
          );
        },
      )
    );
  }
}
