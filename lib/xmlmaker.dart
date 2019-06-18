import 'package:xml/xml.dart' as xml;

import "tags.dart";

class XmlMaker {
  static String soapenv = "http://schemas.xmlsoap.org/soap/envelope/";
  static String tem = "http://tempuri.org/";

  static String checkIfMailExists(String email) {
    var builder = new xml.XmlBuilder();
    builder.element(Tags.soapEnvelope, nest: () {
      builder.attribute("xmlns:soapenv", soapenv);
      builder.attribute("xmlns:tem", tem);
      builder.element(Tags.soapHeader, isSelfClosing: true);
      builder.element(Tags.soapBody, nest: () {
        builder.element(Tags.tem("WCFCheckIfEMailExists"), nest: () {
          builder.element(Tags.tem("strEMail"), nest: () {
            builder.text(email);
          });
        });
      });
    });

    return builder.build().toString();
  }
}

/*
* var builder = new xml.XmlBuilder();
builder.processing('xml', 'version="1.0"');
builder.element('bookshelf', nest: () {
  builder.element('book', nest: () {
    builder.element('title', nest: () {
      builder.attribute('lang', 'english');
      builder.text('Growing a Language');
    });
    builder.element('price', nest: 29.99);
  });
  builder.element('book', nest: () {
    builder.element('title', nest: () {
      builder.attribute('lang', 'english');
      builder.text('Learning XML');
    });
    builder.element('price', nest: 39.95);
  });
  builder.element('price', nest: 132.00);
});
var bookshelfXml = builder.build();
*
*
*
* <bookshelf>
      <book>
        <title lang="english">Growing a Language</title>
        <price>29.99</price>
      </book>
      <book>
        <title lang="english">Learning XML</title>
        <price>39.95</price>
      </book>
      <price>132.00</price>
    </bookshelf>''';
*
*
*
* */
