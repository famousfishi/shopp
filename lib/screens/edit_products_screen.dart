import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopp/providers/product.dart';
import 'package:shopp/providers/products.dart';

// ignore_for_file: use_key_in_widget_constructors

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var product =
      Product(id: '', title: '', description: '', price: 0.0, imageUrl: '');

  // ignore: prefer_final_fields
  Map<String, String> _initValues = {
    "title": '',
    'description': '',
    'imageUrl': '',
    'price': ''
  };

  bool _isInit = true;
  bool _isLoading = false;

  @override
  void initState() {
    // initState is called before state loads dependencies // hence no context is available
    // you get an error if you use context in initstate
    _imageFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    //didChangeDependencies called a few moments after the state loads its dependencies and context is available
    // you can use context here
    if (_isInit) {
      final productId = ModalRoute.of(context)?.settings.arguments;
      if (productId != null) {
        product = Provider.of<Products>(context, listen: false)
            .findById(productId.toString());

        _initValues = {
          'title': product.title,
          'description': product.description,
          // 'imageUrl': product.imageUrl,
          'imageUrl': '',
          'price': product.price.toString()
        };
        _imageUrlController.text = product.imageUrl;
      } else if (productId == null) {
        //set the initivalues to empty
        _initValues = {
          "title": '',
          'description': '',
          'imageUrl': '',
          'price': ''
        };
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    //always good to dispose you focus node  and text editing controllers  after done with them on the user inputs
    _imageFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageFocusNode.hasFocus) {
      setState(() {});
    }
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    //save every form field
    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    //for edit/update
    if (product.id.isNotEmpty) {
      Provider.of<Products>(context, listen: false)
          .updateProduct(product.id, product);
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();

      //for save
    } else if (!product.id.isNotEmpty) {
      try {
        await Provider.of<Products>(context, listen: false).addProduct(product);
      } catch (error) {
        await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('An error occured'),
                content: const Text('Something went wrong'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'))
                ],
              );
            });
      } finally {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: [
          IconButton(onPressed: _saveForm, icon: const Icon(Icons.save))
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                  key: _form,
                  // autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue: _initValues['title'],
                          decoration: const InputDecoration(labelText: 'Title'),
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_priceFocusNode);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter a value";
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            product = Product(
                                id: product.id,
                                isFavourite: product.isFavourite,
                                title: newValue.toString(),
                                description: product.description,
                                price: product.price,
                                imageUrl: product.imageUrl);
                          },
                        ),
                        TextFormField(
                          initialValue: _initValues['price'],
                          decoration: const InputDecoration(labelText: 'Price'),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          focusNode: _priceFocusNode,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_descriptionFocusNode);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter a price value";
                            }
                            if (double.tryParse(value) == null) {
                              return "Please enter a valid number";
                            }
                            if (double.parse(value) <= 0) {
                              return "Please enter a number greater than 0";
                            }

                            return null;
                          },
                          onSaved: (newValue) {
                            product = Product(
                                id: product.id,
                                isFavourite: product.isFavourite,
                                title: product.title,
                                description: product.description,
                                price: double.parse(newValue.toString()),
                                imageUrl: product.imageUrl);
                          },
                        ),
                        TextFormField(
                          initialValue: _initValues['description'],

                          decoration:
                              const InputDecoration(labelText: 'Description'),
                          // textInputAction: TextInputAction.next,
                          maxLines: 3,
                          focusNode: _descriptionFocusNode,

                          keyboardType: TextInputType.multiline,
                          // onFieldSubmitted: (_) {
                          //   FocusScope.of(context).requestFocus(_priceFocusNode);
                          // },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter a description";
                            }

                            if (value.length < 10) {
                              return "Please enter description with length above 10 characters";
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            product = Product(
                                id: product.id,
                                title: product.title,
                                isFavourite: product.isFavourite,
                                description: newValue.toString(),
                                price: product.price,
                                imageUrl: product.imageUrl);
                          },
                        ),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.grey)),
                              margin: const EdgeInsets.only(top: 8, right: 10),
                              child: _imageUrlController.text.isEmpty
                                  ? const Text('Enter a URL for an image')
                                  : FittedBox(
                                      child: Image.network(
                                        _imageUrlController.text,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                            ),
                            Expanded(
                              flex: 1,
                              child: TextFormField(
                                // initialValue: _initValues['imageUrl'],
                                decoration: const InputDecoration(
                                    labelText: 'Image URL'),
                                keyboardType: TextInputType.url,
                                textInputAction: TextInputAction.done,
                                controller: _imageUrlController,
                                focusNode: _imageFocusNode,
                                onFieldSubmitted: (_) {
                                  _saveForm();
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please enter an image url";
                                  }

                                  if (!value.startsWith('https') ||
                                      !value.startsWith('http')) {
                                    return "Wrong Image URL format";
                                  }
                                  return null;
                                },
                                onSaved: (newValue) {
                                  product = Product(
                                      id: product.id,
                                      isFavourite: product.isFavourite,
                                      title: product.title,
                                      description: product.description,
                                      price: product.price,
                                      imageUrl: newValue.toString());
                                },
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )),
            ),
    );
  }
}
