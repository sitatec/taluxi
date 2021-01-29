import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:network_communication/network_communication.dart';
import 'package:real_time_location/real_time_location.dart';
import 'package:taluxi_common/taluxi_common.dart';

class CallStateManager {
  final VoIPProvider _voIPPrivider;
  final AudioPlayer _makingCallAudioPlayer;
  final AudioPlayer _hangUpAudioPlayer;
  final _callStateStreamController = StreamController<CallState>();
  List<Map<String, Coordinates>> _callRecipients;
  var currentRecipientIndex = 0;
  String _currenUserId;
  var _speakerIsOn = false;
  var _microphoneIsOn = true;

  CallStateManager({
    VoIPProvider voIPProvider,
    @required List<Map<String, dynamic>> callRecipients,
    @required String currenUserId,
  })  : _voIPPrivider = voIPProvider ?? VoIPProvider.instance,
        _callRecipients = callRecipients,
        _makingCallAudioPlayer = AudioPlayer(),
        _hangUpAudioPlayer = AudioPlayer();

  Stream<CallState> get callState => _callStateStreamController.stream;
  Stream<VoIPConnectionState> get connectionState =>
      _voIPPrivider.connectionStateStream;

  Future<void> initialize() async {
    try {
      await _voIPPrivider.initialize();
      await _makingCallAudioPlayer.initialize(
        fileName: 'assets/audio/make_call.mp3',
        loop: true,
      );
      await callNextRecipient();
      await _hangUpAudioPlayer.initialize(fileName: 'assets/audio/hang_up.mp3');
    } catch (e) {}
  }

  Future<void> callNextRecipient() async {
    if (++currentRecipientIndex >= _callRecipients.length) {
      _callStateStreamController.add(AllRecipientHaveBeenCalled());
    }
    await _voIPPrivider.makeCall(
      callId: _currenUserId,
      recipientId: _callRecipients[currentRecipientIndex].keys.first,
      onCallSuccess: _onCallSuccess,
      onCallAccepted: _onCallAccepted,
      onCallFailed: _onCallFailed,
      onCallRejected: _onCallRejected,
      onCallLeft: _onCallLeft,
    );
  }

  Future<void> _onCallSuccess() async {
    _callStateStreamController.add(CallSuccess());
    await _makingCallAudioPlayer.play();
  }

  Future<void> _onCallAccepted() async => await _makingCallAudioPlayer.stop();

  void _onCallFailed(CallFailureReason reason) {
    if (reason == CallFailureReason.timedOut) {
      _callStateStreamController.add(NoResponse());
    } else
      _callStateStreamController.add(CallFailed());
  }

  void _onCallRejected() => _callStateStreamController.add(CallRejected());

  Future<void> _onCallLeft(CallLeaveReason reason) async {
    _hangUpAudioPlayer.play();
    await Future.delayed(Duration(seconds: 2)); // Wait the end of hang up sound
    if (reason == CallLeaveReason.hangUp) {
      _callStateStreamController.add(CallLeft());
    } else
      _callStateStreamController
          .add(CallLeft(reason: 'La connexion du conducteur a été perdu'));
  }

  void toggleSpeaker() {
    _speakerIsOn
        ? _voIPPrivider.disableSpeaker()
        : _voIPPrivider.enableSpeaker();
    _speakerIsOn = !_speakerIsOn;
  }

  void toggleMicrophone() {
    _microphoneIsOn
        ? _voIPPrivider.disableMicrophone()
        : _voIPPrivider.enableMicrophone();
    _microphoneIsOn = !_microphoneIsOn;
  }

  // void setNewCallRecipients(List<Map<String, dynamic>> callRecipients) {
  //   _callRecipients = callRecipients;
  //   _currentRecipientIndex = 0;
  // }

  Future<void> dispose() async {
    await _voIPPrivider.destroy();
    await _makingCallAudioPlayer.dispose();
    await _hangUpAudioPlayer.dispose();
  }
}

class CallState {}

class AllRecipientHaveBeenCalled extends CallState {}

class CallSuccess extends CallState {}

// class CallAccepted extends CallState {}

class NoResponse extends CallState {}

class CallFailed extends CallState {
  final String reason;
  CallFailed({this.reason = "Nous n'avons pas pu joindre le conducteur."});
}

class CallLeft extends CallState {
  final String reason;
  CallLeft({this.reason = "Le conducteur a raccroché"});
}

class CallRejected extends CallState {}
