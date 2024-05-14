import 'dart:ui';

class GestureInteractionService{

  GestureInteractionService._();

  static final GestureInteractionService _instance = GestureInteractionService._();

  factory GestureInteractionService(){
    return _instance;
  }

  bool ignorePointer = false;

  int currentIndex = 0;

  int? _tapDownTime;
  int? _tapUpTime;

  Offset? _tapDownOffset;
  Offset? _tapUpOffset;

  void setTapDownTime(int time){
    _tapDownTime = time;
  }

  void setTapUpTime(int time){
    _tapUpTime = time;
  }

  void setTapDownOffset(Offset offset){
    _tapDownOffset = offset;
  }

  void setTapUpOffset(Offset offset){
    _tapUpOffset = offset;
  }

  bool isTap(){
    if(_tapDownTime == null || _tapUpTime == null || _tapDownOffset == null || _tapUpOffset == null || ignorePointer){
      return false;
    }

    if((_tapUpTime! - _tapDownTime!).abs() > 500){
      return false;
    }

    if((_tapUpOffset!.dy - _tapDownOffset!.dy).abs() < 5 && (_tapUpOffset!.dx - _tapDownOffset!.dx).abs() < 5){
      return true;
    }
    else{
      return false;
    }
  }

  bool isLeftTap(double screenWidth){
    if((_tapUpOffset?.dx ?? 0) < (screenWidth * 0.35)){
      return true;
    }
    return false;
  }

  void clearData(){
    ignorePointer = false;
    _tapDownTime = null;
    _tapDownOffset = null;
    _tapUpTime = null;
    _tapUpOffset = null;
  }

}