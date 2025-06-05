import 'package:ens_dart/ens_dart.dart';
import 'package:http/http.dart';
import 'package:web3dart_plus/web3dart_plus.dart';

Future<void> main() async {
  const rpcUrl = 'https://cloudflare-eth.com';

  final client = Web3Client(rpcUrl, Client());

  final ens = Ens(client: client);

  // ENS supports reverse resolution to allow applications to display
  // ENS names in place of hexadecimal addresses.
  final name = await ens
      .withAddress('0x1a5cdcFBA600e0c669795e0B65c344D5A37a4d5A')
      .getName();

  final addr = await ens.withName('brantly.eth').getAddress();
  final content = await ens.getTextRecord();

  print('name: $name'); // name: sea.eth
  print('addr: $addr'); // addr: 0x324f9307b6d26881822c7c8692eeac39791a9756

  print(
      'content: $content'); /* EnsTextRecord {
      email: me@brantly.xyz,
      url: http://brantly.xyz/, 
      avatar: eip155:1/erc721:0xb7F7F6C52F2e2fdb1963Eab30438024864c313F6/2430, 
      description: "If anyone would come after me, let him deny himself and take up his cross daily and follow me. For whoever would save his life will lose it, but whoever loses his life for my sake will save it. For what does it profit a man if he gains the whole world and loses or forfeits himself?" - Jesus, Luke 9.23-25, 
      notice: Not for sale, 
      keywords: , 
      com.discord: brantly.eth#9803, 
      com.github: brantlymillegan, 
      com.reddit: brantlymillegan, 
      com.twitter: brantlymillegan, 
      org.telegram: brantlymillegan, 
      eth.ens.delegate: https://discuss.ens.domains/t/ens-dao-delegate-applications/815/697?u=brantlymillegan
    } */
}
