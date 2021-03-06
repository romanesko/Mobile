import 'package:flutter/widgets.dart';

// Size of the block used in determining multipliers
const double _BLOCK_SIZE_VERT = 100;
const double _BLOCK_SIZE_HORZ = 100;

// Multiplier for icons used in buttons
const double ICON_SIZE_MULTIPLIER = 4.5;

/// Configuration of screen dimensions, should be initialized
/// from the root of the application, when it's run.
class DimensionsConfig {
  static double _screenWidth;
  static double _screenHeight;

  // Number of blocks, of width _BLOCK_SIZE_XXX, which can fit
  // into span of available space on screen
  static double _blockWidth = 0;
  static double _blockHeight = 0;

  /// Multiplier applied to fontSize attribute of text based widgets
  static double get textMultiplier {
    if (_blockHeight != null) {
      return _blockHeight;
    } else {
      throw Exception('DimensionsConfig object must be initialized first');
    }
  }

  /// Multiplier, which can be applied to radius or width/height
  /// attribute of image containing widgets
  static double get imageSizeMultiplier {
    if (_blockWidth != null) {
      return _blockWidth;
    } else {
      throw Exception('DimensionsConfig object must be initialized first');
    }
  }

  /// Multiplier used anywhere, if there's a need to scale widget,
  /// taking height of the screen into account
  static double get heightMultiplier {
    if (_blockHeight != null) {
      return _blockHeight;
    } else {
      throw Exception('DimensionsConfig object must be initialized first');
    }
  }

  /// Multiplier used anywhere, if there's a need to scale widget,
  /// taking width of the screen into account
  static double get widthMultiplier {
    if (_blockWidth != null) {
      return _blockWidth;
    } else {
      throw Exception('DimensionsConfig object must be initialized first');
    }
  }

  /// Available screen height
  static double get maxScreenHeight {
    if (_screenHeight != null) {
      return isPortrait ? _screenHeight : _screenWidth;
    } else {
      throw Exception('DimensionsConfig object must be initialized first');
    }
  }

  /// Available screen width
  static double get maxScreenWidth {
    if (_screenWidth != null) {
      return isPortrait ? _screenWidth : _screenHeight;
    } else {
      throw Exception('DimensionsConfig object must be initialized first');
    }
  }

  static bool isPortrait = true;
  // static bool isMobilePortrait = false;

  void init(BoxConstraints constraints, Orientation orientation) {
    if (orientation == Orientation.portrait) {
      _screenWidth = constraints.maxWidth;
      _screenHeight = constraints.maxHeight;
      isPortrait = true;
    } else {
      _screenWidth = constraints.maxHeight;
      _screenHeight = constraints.maxWidth;
      isPortrait = false;
    }

    // Calculating number of blocks, in order to determine values
    // of scaling multipliers
    _blockWidth = _screenWidth / _BLOCK_SIZE_HORZ;
    _blockHeight = _screenHeight / _BLOCK_SIZE_VERT;
  }
}
