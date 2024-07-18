import 'package:flutter/material.dart';
import 'package:shoppers/pages/category_products.dart';
import 'package:shoppers/pages/product_detail.dart';
import 'package:shoppers/services/shared_pref.dart';
import 'package:shoppers/widget/support_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List categories = [
    "images/headphone_icon.png",
    "images/laptop.png",
    "images/watch.png",
    "images/TV.png",
    "images/phone.png",
    "images/cable.png",
  ];

  List categoriesName = [
    "HeadPhones",
    "Laptops",
    "Watch",
    "Tvs",
    "phones",
    "cables",
  ];

  String? name, image;
  getSharedPref() async {
    name = await SharedPreferenceHelper().getUserName();
    image = await SharedPreferenceHelper().getUserImage();

    setState(() {});
  }

  ontheLoad() async {
    await getSharedPref();
    setState(() {});
  }

  @override
  void initState() {
    ontheLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: name == null
          ? Center(child: CircularProgressIndicator())
          : Container(
              margin: EdgeInsets.only(top: 40, left: 20, right: 20),
              child: Column(
                children: [
                  //APP BAR WIDGET
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Hi, ' + name! + "!",
                              style: AppWidget.boldTextfieldStyle()),
                          Text('Good morning',
                              style: AppWidget.lightTextfieldStyle()),
                        ],
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(image!,
                            width: 60, height: 60, fit: BoxFit.cover),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  //SEARCH INPUT BOX
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      autocorrect: true,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search Electronics",
                        hintStyle: AppWidget.lightTextfieldStyle(),
                        prefixIcon: Icon(Icons.search, color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  Expanded(
                    child: ListView(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("categories",
                                style: AppWidget.semiboldTextfieldStyle()),
                            Text(
                              "see all",
                              style: TextStyle(
                                color: Color(0xfffd6f3e),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        //CATEGORIES LIST WIDGET
                        Row(
                          children: [
                            Container(
                              height: 110,
                              margin: EdgeInsets.only(right: 20),
                              padding: EdgeInsets.only(
                                  right: 20, left: 20, top: 20, bottom: 10),
                              decoration: BoxDecoration(
                                color: Color(0xfffd6f3e),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  'All',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 120,
                                child: ListView.builder(
                                    itemCount: categories.length,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return CategoryTile(
                                        image: categories[index],
                                        name: categoriesName[index],
                                      );
                                    }),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        //ALL ELECTRONICS LIST VIEW WIDGET HEADER
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("All Electronics",
                                style: AppWidget.semiboldTextfieldStyle()),
                            Text(
                              "see all",
                              style: TextStyle(
                                color: Color(0xfffd6f3e),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        //ALL ELECTRONICS LIST VIEW WIDGET
                        Container(
                          height: 220,
                          child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: [
                              //FIRST ELECTRONIC
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Material(
                                  elevation: 2,
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          'images/headphone2.png',
                                          height: 130,
                                          width: 130,
                                          fit: BoxFit.cover,
                                        ),
                                        Text("headPhone",
                                            style: AppWidget
                                                .semiboldTextfieldStyle()),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          width: 100,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "\$100",
                                                style: TextStyle(
                                                  color: Color(0xfffd6f3e),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  color: Color(0xfffd6f3e),
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                                child: Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              //SECOND ELECTRONIC
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Material(
                                  elevation: 2,
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          'images/watch2.png',
                                          height: 130,
                                          width: 130,
                                          fit: BoxFit.cover,
                                        ),
                                        Text("Apple Watch",
                                            style: AppWidget
                                                .semiboldTextfieldStyle()),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          width: 100,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "\$300",
                                                style: TextStyle(
                                                  color: Color(0xfffd6f3e),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  color: Color(0xfffd6f3e),
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                                child: Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              //THIRD ELECTRONIC
                              Padding(
                                padding: const EdgeInsets.only(right: 0),
                                child: Material(
                                  elevation: 2,
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          'images/laptop2.png',
                                          height: 130,
                                          width: 130,
                                          fit: BoxFit.cover,
                                        ),
                                        Text("Hp Laptop",
                                            style: AppWidget
                                                .semiboldTextfieldStyle()),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          width: 100,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "\$1000",
                                                style: TextStyle(
                                                  color: Color(0xfffd6f3e),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  color: Color(0xfffd6f3e),
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                                child: Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  String image, name;
  CategoryTile({required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryProducts(category: name),
            ));
      },
      child: Container(
        height: 90,
        width: 90,
        margin: EdgeInsets.only(right: 20),
        padding: EdgeInsets.only(right: 20, left: 20, top: 20, bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              image,
              height: 50,
              fit: BoxFit.cover,
            ),
            Icon(Icons.arrow_forward)
          ],
        ),
      ),
    );
  }
}
