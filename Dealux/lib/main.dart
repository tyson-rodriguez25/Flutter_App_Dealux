import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

const String appName = 'Dealux';

/// This is the main application widget.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = appName;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Georgia',
      ),
      home: BaseWidget(),
    );
  }
}

const List<Tab> tabs = <Tab>[
  Tab(text: 'My Stores'),
  Tab(text: 'Stores Near Me'),
  Tab(text: 'All Stores'),
];

class Store {
  String storeName;
  double distance;
  String address;
  String hours;
  String phoneNumber;
  bool isFavorite;

  Store(this.storeName, this.distance, this.address, this.hours,
      this.phoneNumber, this.isFavorite);
}

class Deal {
  String item;
  String deal;
  String limit;

  Deal(this.item, this.deal, this.limit);
}

List<Store> stores = <Store>[
  Store("Smith's", 1.9, "350 Freedom Blvd. Provo, UT 84601", "6AM - 11PM",
      "(801) 377-9050", false),
  Store("Wal-Mart", 4.7, "1355 Sandhill Rd, Orem, UT 84058", "6AM - 11PM",
      "(801) 221-0600", false),
  Store("Target", 1.5, "1290 N State St, Provo, UT 84604", "8AM - 10PM",
      "(385) 447-5020", false),
  Store("Macey's", 2.0, "1400 N State St, Provo, UT 84601", "6AM - 11PM",
      "(801) 356-3216", false),
  Store("Sprouts", 3.3, "1375 S State St, Orem, UT 84097", "7AM - 10PM",
      "(801) 434-1501", false),
  Store("Costco", 3.7, "648 E 800 S, Orem, UT 84097", "10AM - 8PM",
      "(801) 851-5003", false),
  Store("Food World", 1787.0, "613 Central Dr. East Dublin, GA 31027",
      "10AM - 8PM", "(919) 680-4282", false),
  Store("Albertsons", 70.9, "740 N Main St, Tooele, UT 84074", "8AM - 8PM",
      "(435) 882-8990", false),
  Store(
      "Dan's Food Market",
      40.8,
      "2029 E 7000 S, Cottonwood Heights, UT 84121",
      "6AM - 11PM",
      "(801) 943-7601",
      false),
  Store("Fresh Market", 2.5, "560 W Center St, Provo, UT 84601", "6AM - 11PM",
      "(801) 374-1558", false),
  Store(
      "Reser's Fine Foods",
      825.1,
      "6999 NE Century Blvd, Hillsboro, OR 97124",
      "7AM - 8PM",
      "(503) 466-6431",
      false),
];

List<Deal> deals = <Deal>[
  Deal("Campbell Chicken Noodle Soup", "2 for 1", "Limit 8 per customer"),
  Deal("Red, Orange, or Yellow Bell Peppers", "\$0.99", ""),
  Deal("T-Bone or New York Strip Steaks", "\$7.97/lb",
      "Bone-In, Super Value Pack"),
  Deal("Arm & Hammer Liquid Laundry Detergent or Brawny Paper Towels",
      "Buy 1 Get 1 Free", ""),
];

/// This is the stateless widget that the main application instantiates.
class BaseWidget extends StatelessWidget {
  const BaseWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      // The Builder widget is used to have a different BuildContext to access
      // closest DefaultTabController.
      child: Builder(builder: (BuildContext context) {
        final TabController tabController = DefaultTabController.of(context)!;
        tabController.addListener(() {
          if (!tabController.indexIsChanging) {
            // Your code goes here.
            // To get index of current tab use tabController.index
          }
        });
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(appName, style: TextStyle(fontSize: 24)),
            bottom: const TabBar(
              tabs: tabs,
            ),
          ),
          body: TabBarView(children: [
            MyStores(),
            StoresNearMe(),
            AllStores(),
          ]),
        );
      }),
    );
  }
}

class MyStores extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyStoresState();
  }
}

class MyStoresState extends State<MyStores> {
  @override
  Widget build(BuildContext context) {
    stores.sort((a, b) {
      return a.storeName.toLowerCase().compareTo(b.storeName.toLowerCase());
    });
    List<Store> faveStores = stores.where((i) => i.isFavorite).toList();

    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            for (var store in faveStores)
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StoreDetails(store))),
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 10,
                    child: ListTile(
                      title: Text(store.storeName),
                      subtitle: Text("(" + store.distance.toString() + " mi)"),
                      trailing: IconButton(
                        icon: Icon(Icons.star,
                            color:
                                store.isFavorite ? Colors.yellow : Colors.grey,
                            size: 30),
                        onPressed: () {
                          setState(() {
                            store.isFavorite = !store.isFavorite;
                          });
                        },
                      ),
                    )),
              ),
          ],
        ),
      ),
    );
  }
}

class StoresNearMe extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new StoresNearMeState();
  }
}

class StoresNearMeState extends State<StoresNearMe> {
  @override
  Widget build(BuildContext context) {
    stores.sort((a, b) {
      return a.distance.compareTo(b.distance);
    });
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            for (var store in stores)
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StoreDetails(store))),
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 10,
                    child: ListTile(
                      title: Text(store.storeName),
                      subtitle: Text("(" + store.distance.toString() + " mi)"),
                      trailing: IconButton(
                        icon: Icon(Icons.star,
                            color:
                                store.isFavorite ? Colors.yellow : Colors.grey,
                            size: 30),
                        onPressed: () {
                          setState(() {
                            store.isFavorite = !store.isFavorite;
                          });
                        },
                      ),
                    )),
              ),
          ],
        ),
      ),
    );
  }
}

class AllStores extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new AllStoresState();
  }
}

class AllStoresState extends State<AllStores> {
  @override
  Widget build(BuildContext context) {
    stores.sort((a, b) {
      return a.storeName.toLowerCase().compareTo(b.storeName.toLowerCase());
    });
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            for (var store in stores)
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StoreDetails(store))),
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 10,
                    child: ListTile(
                      title: Text(store.storeName),
                      subtitle: Text("(" + store.distance.toString() + " mi)"),
                      trailing: IconButton(
                        icon: Icon(Icons.star,
                            color:
                                store.isFavorite ? Colors.yellow : Colors.grey,
                            size: 30),
                        onPressed: () {
                          setState(() {
                            store.isFavorite = !store.isFavorite;
                          });
                        },
                      ),
                    )),
              ),
          ],
        ),
      ),
    );
  }
}

const List<Tab> storeInfoTabs = <Tab>[
  Tab(text: 'Deals'),
  Tab(text: 'Store Information'),
];

class StoreDetails extends StatelessWidget {
  final Store store;

  StoreDetails(this.store);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: storeInfoTabs.length,
      // The Builder widget is used to have a different BuildContext to access
      // closest DefaultTabController.
      child: Builder(builder: (BuildContext context) {
        final TabController tabController = DefaultTabController.of(context)!;
        tabController.addListener(() {
          if (!tabController.indexIsChanging) {
            // Your code goes here.
            // To get index of current tab use tabController.index
          }
        });
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            centerTitle: true,
            title: const Text(appName, style: TextStyle(fontSize: 24)),
            flexibleSpace: Center(
                child: Container(
                    padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
                    child: Text(store.storeName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        )))),
            bottom: const TabBar(
              tabs: storeInfoTabs,
            ),
          ),
          body: TabBarView(children: [
            StoreDeals(store),
            StoreInfo(store),
          ]),
        );
      }),
    );
  }
}

class StoreDeals extends StatelessWidget {
  final Store store;

  StoreDeals(this.store);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            for (var deal in deals)
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StoreDetails(store))),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 10,
                  child: ListTile(
                    title: Text(deal.item, style: TextStyle(fontSize: 20)),
                    subtitle: Text(deal.limit, style: TextStyle(fontSize: 12)),
                    trailing: Text(deal.deal, style: TextStyle(fontSize: 18)),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class StoreInfo extends StatelessWidget {
  final Store store;

  StoreInfo(this.store);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10.0),
        child: RichText(
          text: TextSpan(
            style: TextStyle(color: Colors.black),
            children: <TextSpan>[
              TextSpan(text: "Address:\n", style: TextStyle(fontSize: 32)),
              TextSpan(text: store.address, style: TextStyle(fontSize: 28)),
              TextSpan(text: "\n\n"),
              TextSpan(text: "Hours:\n", style: TextStyle(fontSize: 32)),
              TextSpan(text: store.hours, style: TextStyle(fontSize: 28)),
              TextSpan(text: "\n\n"),
              TextSpan(text: "Phone:\n", style: TextStyle(fontSize: 32)),
              TextSpan(text: store.phoneNumber, style: TextStyle(fontSize: 28)),
            ],
          ),
        ));
  }
}
