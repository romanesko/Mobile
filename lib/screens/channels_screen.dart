import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twake_mobile/config/dimensions_config.dart';
import 'package:twake_mobile/providers/channels_provider.dart';
import 'package:twake_mobile/providers/profile_provider.dart';
import 'package:twake_mobile/services/twake_api.dart';
import 'package:twake_mobile/widgets/channel/channels_block.dart';
import 'package:twake_mobile/widgets/channel/direct_messages_block.dart';
import 'package:twake_mobile/widgets/channel/starred_channels_block.dart';
import 'package:twake_mobile/widgets/common/image_avatar.dart';
import 'package:twake_mobile/widgets/drawer/twake_drawer.dart';

class ChannelsScreen extends StatelessWidget {
  static const String route = '/channels';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    print('DEBUG: building channels screen');
    final workspace = Provider.of<ProfileProvider>(context).selectedWorkspace;
    final api = Provider.of<TwakeApi>(context, listen: false);
    final channels = Provider.of<ChannelsProvider>(context, listen: false);
    channels.loadChannels(api, workspace.id);
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: TwakeDrawer(),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            },
            icon: Icon(
              Icons.menu,
              size: DimensionsConfig.textMultiplier * 4,
            ),
          ),
          toolbarHeight:
              DimensionsConfig.heightMultiplier * kToolbarHeight * 0.15,
          actions: [
            PopupMenuButton<String>(
              icon: Icon(
                Icons.more_vert,
                size: DimensionsConfig.textMultiplier * 4,
              ),
              onSelected: (choice) {},
              itemBuilder: (BuildContext context) {
                return {'Option 1', 'Option 2'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Row(
                      children: [
                        Icon(Icons.star_outline),
                        SizedBox(width: DimensionsConfig.widthMultiplier * 2),
                        Text(choice),
                      ],
                    ),
                  );
                }).toList();
              },
            ),
          ],
          shadowColor: Colors.grey[300],
          title: Row(
            children: [
              ImageAvatar(workspace.logo),
              SizedBox(width: DimensionsConfig.widthMultiplier * 2),
              Text(workspace.name,
                  style: Theme.of(context).textTheme.headline6),
            ],
          ),
        ),
        body: Consumer<ChannelsProvider>(
          builder: (ctx, channels, _) {
            final items = channels.items;
            return channels.loaded
                ? SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: DimensionsConfig.widthMultiplier * 3,
                        vertical: DimensionsConfig.heightMultiplier * 3,
                      ),
                      child: Column(
                        children: [
                          StarredChannelsBlock([]),
                          Divider(
                              height: DimensionsConfig.heightMultiplier * 5),
                          ChannelsBlock(items),
                          Divider(
                              height: DimensionsConfig.heightMultiplier * 5),
                          DirectMessagesBlock([]),
                        ],
                      ),
                    ),
                  )
                : Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
