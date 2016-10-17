---
layout: post
title: "SOAP API calls from Google apps script"
categories: [Google apps script]
tags: []
---
SOAP and WSDL components are deprecated in google apps script. So you have to use plain XML.
There is the SOAP 1.1 example code writen in google apps script.

    function testSOAP() {
        var method = 'GetWeather';
        var params = {
            CityName: 'SanFrancisco',
            CountryName: 'USA'
        };
    
        var envelopeNS = XmlService.getNamespace('SOAP', 'http://schemas.xmlsoap.org/soap/envelope/');
        var envelope = XmlService.createElement('Envelope', envelopeNS);
        var body = XmlService.createElement('Body', envelopeNS);
        envelope.addContent(body);
        var action = XmlService.createElement(method);
        body.addContent(action);
    
        //Now XML is
        //<SOAP:Envelope xmlns:SOAP="http://schemas.xmlsoap.org/soap/envelope/">
        //  <SOAP:Body>
        //    <GetWeather />
        //  </SOAP:Body>
        //</SOAP:Envelope>
    
        //Set params
        for (var key in params) {
            var paramElement = XmlService.createElement(key);
            if (typeof params[key] == 'object') {
                for (var innerKey in params[key]) {
                    paramElement.addContent(XmlService.createElement(innerKey).setText(params[key][innerKey]));
                }
            } else {
                paramElement.setText(params[key])
            }
            action.addContent(paramElement);
        }
    
        //Now XML is
        //<SOAP:Envelope xmlns:SOAP="http://schemas.xmlsoap.org/soap/envelope/">
        //  <SOAP:Body>
        //    <GetWeather>
        //      <CityName>SanFrancisco</CityName>
        //      <CountryName>USA</CountryName>
        //    </GetWeather>
        //  </SOAP:Body>
        //</SOAP:Envelope>
    
        //Create element
        var document = XmlService.createDocument(envelope);
        var xml = XmlService.getPrettyFormat().format(document);
    
        //Request options
        var options = {
            "method": "post",
            "payload": xml,
            "contentType": "text/xml; charset=utf-8",
            "headers": {
                "SOAPAction": "http://www.webserviceX.NET/" + method,
            }    
        };
    
        //Get response
        var responseXml = UrlFetchApp.fetch("http://some/url/api", options).getContentText();
        Logger.log(responseXml);
        var responseDoc = XmlService.parse(responseXml);
        var responseBody = responseDoc.getRootElement().getChild('Body', envelopeNS).getChild(method + 'Response', envelopeNS);
    
        //Parse response 
        var result = {};
        var children = responseBody.getChildren();
        for (var i = 0; i < children.length; i++) {
            var child = children[i];
            var name = child.getName();
            var value = child.getValue();
            result[name] = value;
        }
        return result;
    }

It is actual at least for google drive spreadsheets and docs.