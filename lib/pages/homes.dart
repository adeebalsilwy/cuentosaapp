import 'package:cuentosaapp/pages/screen/view_c_stor.dart';
import 'package:flutter/material.dart';
import 'db/prodb.dart';

class HomeInter extends StatelessWidget {
  final database_st db = database_st();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200.0,
              backgroundColor: Colors.purple,
              floating: true,
              pinned: false,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  'مرحبا',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                background: Image.asset(
                  'asst/app/p4.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            FutureBuilder<List<Category>>(
              future: db.cateview(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                List<Category> categories = snapshot.data!;
                return SliverPadding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 40),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.0,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return InkWell(
                          onTap: () async {
                            List<Stors> stories = await db
                                .getStoriesByCategory(categories[index].id);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CStor(
                                  category: categories[index],
                                  stories: stories,
                                ),
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(15),
                                      topLeft: Radius.circular(15),
                                    ),
                                    image: DecorationImage(
                                      image: AssetImage(categories[index].img),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 50.0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10.0),
                                      bottomRight: Radius.circular(10.0),
                                    ),
                                    color: Colors.purple,
                                  ),
                                  child: Center(
                                    child: Text(
                                      categories[index].name,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      childCount: categories.length,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
