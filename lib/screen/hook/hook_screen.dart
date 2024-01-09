import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

extension CompactMap<T> on Iterable<T?> {
  Iterable<T> compactMap<E>([
    E? Function(T?)? transform,
  ]) =>
      map(transform ?? (e) => e).where((e) => e != null).cast();
}

const url = 'https://bit.ly/3qYOtDm';
// "https://picsum.photos/640/425";

class HookScreen extends HookWidget {
  const HookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final dateTime = useStream(getTime());
    final controller = useTextEditingController();
    final text = useState('');

    final image = useMemoized(() => (NetworkAssetBundle(Uri.parse(url))
        .load(url)
        .then((data) => data.buffer.asUint8List())
        .then((data) => Image.memory(data))));
    final future = useFuture(image);

    useEffect(() {
      controller.addListener(() {
        text.value = controller.text;
      });
      return null;
    }, [controller]);

    return Scaffold(
      appBar: AppBar(title: const Text('Hook')), // dateTime.data
      body: Column(
        children: [
          TextField(
            controller: controller,
          ),
          Text("you type ${text.value}"),
          // image.hasData ? image.data! : null,
          future.data,
        ].compactMap().toList(),
      ),
    );
  }
}

Stream<String> getTime() => Stream.periodic(
    const Duration(seconds: 1), (_) => DateTime.now().toIso8601String());
