import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

class PhotoPage extends StatefulWidget {
  final File imageFile;

  const PhotoPage({super.key, required this.imageFile});

  @override
  State<PhotoPage> createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  late img.Image originalImage; // الصورة الأصلية
  img.Image? currentImage; // الصورة التي يتم تعديلها

  // قائمة الفلاتر الجاهزة
  final List<ImageFilter> filters = [
    ImageFilter('Grayscale', imageFilter: ImageFilter.grayscale),
    ImageFilter('Threshold', imageFilter: ImageFilter.threshold),
    ImageFilter('Sharpen', imageFilter: ImageFilter.sharpen),
    ImageFilter('Blur', imageFilter: ImageFilter.blur),
  ];

  @override
  void initState() {
    super.initState();
    _loadImage(); // تحميل الصورة الأصلية عند بداية الصفحة
  }

  // تحميل الصورة الأصلية من الملف
  Future<void> _loadImage() async {
    final bytes = await widget.imageFile.readAsBytes();
    originalImage = img.decodeImage(bytes)!; // حفظ الصورة الأصلية
    setState(() {
      currentImage = originalImage; // تعيين الصورة المعروضة إلى الصورة الأصلية
    });
  }

  // تطبيق الفلتر على الصورة الأصلية في كل مرة
  void _applyFilter(ImageFilter filter) {
    setState(() {
      // إعادة تحميل الصورة الأصلية عند كل تطبيق للفلتر
      currentImage = filter.imageFilter(originalImage.clone()); // استخدام النسخة الأصلية لكل فلتر
    });
  }

  // إعادة الصورة الأصلية
  void _resetImage() {
    setState(() {
      currentImage = originalImage; // إعادة تعيين الصورة إلى الأصلية
    });
  }

  // حفظ الصورة المعروضة
  Future<void> _saveImage() async {
    if (currentImage != null) {
      // تحويل الصورة المعدلة إلى بايتات
      final imgBytes = Uint8List.fromList(img.encodeJpg(currentImage!));

      // الحصول على المسار في الجهاز
      final directory = await getApplicationDocumentsDirectory();
      final path = '${directory.path}/modified_image.jpg';

      // حفظ الصورة في الملف
      final file = File(path);
      await file.writeAsBytes(imgBytes);

      // عرض رسالة تأكيد للمستخدم
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image saved at $path')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final displayedImage = currentImage != null
        ? Image.memory(Uint8List.fromList(img.encodeJpg(currentImage!)))
        : Image.file(widget.imageFile);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        title: const Text(
          "Edit Image",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          // أيقونة حفظ الصورة
          IconButton(
            icon: const Icon(Icons.save_alt, color: Colors.black),
            onPressed: _saveImage, // تنفيذ حفظ الصورة
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // عرض الصورة
          Expanded(
            flex: 3,
            child: displayedImage, // عرض الصورة المعدلة أو الأصلية
          ),
          // قائمة الفلاتر أسفل الصورة
          Container(
            height: 120, // ارتفاع الـ Container
            color: Colors.grey[200],
            child: ListView.builder(
              scrollDirection: Axis.horizontal, // التمرير أفقيًا
              reverse: true, // التمرير من اليمين لليسار
              itemCount: filters.length + 1, // إضافة عنصر واحد للزر
              itemBuilder: (context, index) {
                if (index == filters.length) {
                  // زر "إعادة الصورة الأصلية"
                  return GestureDetector(
                    onTap: _resetImage, // إعادة الصورة الأصلية عند الضغط
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white,
                            child: const Icon(
                              Icons.refresh, // رمز إعادة التعيين
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Reset',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                final filter = filters[index];
                return GestureDetector(
                  onTap: () => _applyFilter(filter), // تطبيق الفلتر عند الضغط
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white,
                          child: Text(
                            filter.name[0],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          filter.name,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// فئة الفلتر التي تحتوي على الاسم وفلتر الصورة
class ImageFilter {
  final String name;
  final img.Image Function(img.Image) imageFilter;

  ImageFilter(this.name, {required this.imageFilter});

  // الفلاتر الجاهزة
  static img.Image grayscale(img.Image image) {
    return img.grayscale(image); // تحويل الصورة إلى تدرج الرمادي
  }

  // تطبيق threshold يدويًا
  static img.Image threshold(img.Image image) {
    for (int y = 0; y < image.height; y++) {
      for (int x = 0; x < image.width; x++) {
        int pixel = image.getPixel(x, y);
        int gray = img.getRed(pixel); // استخدم اللون الأحمر لتحديد اللون الرمادي
        int threshold = 128;
        int newPixel = (gray > threshold) ? img.getColor(255, 255, 255) : img.getColor(0, 0, 0);
        image.setPixel(x, y, newPixel);
      }
    }
    return image;
  }

  // تطبيق sharpen يدويًا باستخدام Kernel
// تطبيق sharpen يدويًا باستخدام Kernel
static img.Image sharpen(img.Image image) {
  // بناء مصفوفة kernel لتحسين الحدة
  List<List<int>> kernel = [
    [-1, -1, -1],
    [-1,  9, -1],
    [-1, -1, -1],
  ];

  // تطبيق kernel يدويًا على كل قناة لون
  img.Image output = img.Image(image.width, image.height);

  for (int y = 1; y < image.height - 1; y++) {
    for (int x = 1; x < image.width - 1; x++) {
      int redValue = 0;
      int greenValue = 0;
      int blueValue = 0;

      // التكرار عبر kernel
      for (int ky = 0; ky < 3; ky++) {
        for (int kx = 0; kx < 3; kx++) {
          int pixel = image.getPixel(x + kx - 1, y + ky - 1);

          // استخراج القيم الحمراء والخضراء والزرقاء للبكسل
          int red = img.getRed(pixel);
          int green = img.getGreen(pixel);
          int blue = img.getBlue(pixel);

          redValue += red * kernel[ky][kx];
          greenValue += green * kernel[ky][kx];
          blueValue += blue * kernel[ky][kx];
        }
      }

      // تطبيق النتيجة على الألوان الثلاثة (الأحمر، الأخضر، الأزرق)
      redValue = redValue.clamp(0, 255);
      greenValue = greenValue.clamp(0, 255);
      blueValue = blueValue.clamp(0, 255);

      // تحديد لون البكسل الجديد بعد تطبيق الـ kernel
      output.setPixel(x, y, img.getColor(redValue, greenValue, blueValue));
    }
  }

  return output;
}


  // تطبيق blur باستخدام GaussianBlur
  static img.Image blur(img.Image image) {
    return img.gaussianBlur(image, 5); // تطبيق blur
  }

  // تطبيق التصفية عبر kernel
  static img.Image applyKernel(img.Image image, List<List<int>> kernel) {
    img.Image output = img.Image(image.width, image.height);

    for (int y = 1; y < image.height - 1; y++) {
      for (int x = 1; x < image.width - 1; x++) {
        int pixelValue = 0;

        for (int ky = 0; ky < 3; ky++) {
          for (int kx = 0; kx < 3; kx++) {
            int pixel = image.getPixel(x + kx - 1, y + ky - 1);
            int gray = img.getRed(pixel);
            pixelValue += gray * kernel[ky][kx];
          }
        }

        // تطبيق النتيجة على البكسل
        int newPixel = img.getColor(pixelValue, pixelValue, pixelValue);
        output.setPixel(x, y, newPixel);
      }
    }

    return output;
  }

  static final List<ImageFilter> presetFiltersList = [
    ImageFilter('Grayscale', imageFilter: grayscale),
    ImageFilter('Threshold', imageFilter: threshold),
    ImageFilter('Sharpen', imageFilter: sharpen),
    ImageFilter('Blur', imageFilter: blur),
  ];
}





























