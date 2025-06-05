import 'package:ens_dart/ens_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:web3dart_plus/web3dart_plus.dart';

void main() {
  final names = [
    'chizi',
    'mike',
    'coinbase',
    'sea',
    'law',
  ];

  final addresses = [
    '0x324f9307b6d26881822c7c8692eeac39791a9756',
    '0x1a5cdcfba600e0c669795e0b65c344d5a37a4d5a',
    '0x81b287c0992b110adeb5903bf7e2d9350c80581a',
    '0x2cb86d919332d0369c66a2d5982419266f5e490f',
    '0x9c308bd202dddfca28f6cdce8e96b1e209833473',
  ];
  test('ENS Tests', () async {
    const rpcUrl = 'https://cloudflare-eth.com';

    final client = Web3Client(rpcUrl, Client());

    final ens = Ens(client: client);

    test('.getName() fetches correct name', () async {
      for (var i = 0; i < addresses.length; i++) {
        final name = await ens
            .withAddress(EthereumAddress.fromHex(addresses[i]))
            .getName();
        expect(name, '${names[i]}.eth');
      }
    });
    test('.getAddress() fetches correct address', () async {
      for (var i = 0; i < names.length; i++) {
        final addr = await ens.withName('${names[i]}.eth').getAddress();
        expect(addr.hex, addresses[i]);
      }
    });
    test('.getTextRecord() fetches TextRecord', () async {
      for (var i = 0; i < names.length; i++) {
        final record = await ens.withName('brantly').getTextRecord();
        expect(record.runtimeType, EnsTextRecord);
      }
    });
  });
}
