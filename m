Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50ABD6B8D4
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jul 2019 11:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbfGQJFy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Jul 2019 05:05:54 -0400
Received: from esa12.fujitsucc.c3s2.iphmx.com ([216.71.156.125]:64174 "EHLO
        esa12.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725932AbfGQJFy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Jul 2019 05:05:54 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Jul 2019 05:05:52 EDT
X-IronPort-AV: E=McAfee;i="6000,8403,9320"; a="5037846"
X-IronPort-AV: E=Sophos;i="5.64,273,1559487600"; 
   d="scan'208";a="5037846"
Received: from mail-ty1jpn01lp2054.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.54])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Jul 2019 17:58:42 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BMrGZygE7T/uFxnM3MZYmnj+iQsCXl8mFCeyrw+B7hrrAO3P8UoPhSjX90ymu7hBcOZP04S3gE4EZLamRdbHMLfocf+VvHPYOVZYfR+T52n61XunDboigT1xxDUvL3P/wxL+BZWzbu+ELDa/0pTASjk/KX9dBurLFcy8qUUHbd/XL2j0sZMXEPADSlffr5aBsjlMqfK3kJ5q5n4JVwy1LbIe8R5mC3kZ255AAOVDc3Q3tJ2YfvSS0W9raDxsUPxW477CWXvJfHcq7qrm4onKZ3gPhM2dSxDG6ezpC3oU7qLuYYJ5okGOXV46VFZOx86tTbb3ZsHmxkwXC7yWzVYXbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gx2QFVxIJkAlNjRy/KN9iLGGJtuNyXcjsDzp7RmVprU=;
 b=RTmlgDTYvv0KbmUZ5M4vmp2HJzXU92ssYWZWTK4SZjJ4KiY02D/di4h9RtK5nZFgsiNHVILDPZ+aJZca2+H8B/mb460yW9My19WSYCgB2OPiO1mQ/zMzCiLGFueRscWKDgO/BR5IpRhrUFGoRtJjd31S9ldDc5gHSG+8y8FNShM7O3tynNSfUhnGZsVTslGvf9XQcrKYQT+XiTffXoMb2l4uw0gns8f8xsbnZjjJ0DYvIs1eOnriP2h0SUZZvOqIfkjcfyU1dvpAgRyl4kbDqUOlHPih8XaSPG1HII/nrMdpGpQfZaeKT2qKr6/DLcy0DN0x+SPMI3zd6y+RuJQPGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=fujitsu.com;dmarc=pass action=none
 header.from=fujitsu.com;dkim=pass header.d=fujitsu.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gx2QFVxIJkAlNjRy/KN9iLGGJtuNyXcjsDzp7RmVprU=;
 b=QvZRuUxNqeasq2eTb4E5861lFuJf0gjMMmnaHVMQFGjGsPjsN/sinibePMYAgDyhr9bvuacy7usp83CBtEu+stGsl6cBiDMwj67phJMJ3rUbwqZkLsIXgJBFnBiViEwfE9lV3QONlUCmTKJDrrJopSTZSuly8oAKRMQyBVKhric=
Received: from TYAPR01MB3360.jpnprd01.prod.outlook.com (20.178.136.139) by
 TYAPR01MB2813.jpnprd01.prod.outlook.com (20.177.104.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.10; Wed, 17 Jul 2019 08:58:39 +0000
Received: from TYAPR01MB3360.jpnprd01.prod.outlook.com
 ([fe80::20e1:b513:392e:a434]) by TYAPR01MB3360.jpnprd01.prod.outlook.com
 ([fe80::20e1:b513:392e:a434%7]) with mapi id 15.20.2073.015; Wed, 17 Jul 2019
 08:58:39 +0000
From:   "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>
To:     'Hans van Kranenburg' <hans@knorrie.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Ulli Horlacher <framstag@rus.uni-stuttgart.de>
Subject: RE: how do I know a subvolume is a snapshot?
Thread-Topic: how do I know a subvolume is a snapshot?
Thread-Index: AQHVPC3JZtmICxXfsky3dqj1ADsOS6bOeZaAgAAI5dA=
Date:   Wed, 17 Jul 2019 08:57:31 +0000
Deferred-Delivery: Wed, 17 Jul 2019 08:58:31 +0000
Message-ID: <TYAPR01MB33604A6035BF09518027AE12E5C90@TYAPR01MB3360.jpnprd01.prod.outlook.com>
References: <20190716232456.GA26411@tik.uni-stuttgart.de>
 <f47ad813-9b91-a61e-7f4c-378594ee84ea@knorrie.org>
In-Reply-To: <f47ad813-9b91-a61e-7f4c-378594ee84ea@knorrie.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: c44e0a2da1904986abc0027056c08975
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=misono.tomohiro@fujitsu.com; 
x-originating-ip: [180.43.156.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f70b8936-13c0-45dd-b63a-08d70a94f608
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:TYAPR01MB2813;
x-ms-traffictypediagnostic: TYAPR01MB2813:
x-microsoft-antispam-prvs: <TYAPR01MB281399928F72993BE014A19DE5C90@TYAPR01MB2813.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-forefront-prvs: 01018CB5B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(199004)(13464003)(189003)(476003)(11346002)(486006)(446003)(33656002)(52536014)(86362001)(6506007)(229853002)(66066001)(76116006)(66446008)(6116002)(66476007)(6436002)(66946007)(85182001)(3846002)(5660300002)(110136005)(256004)(316002)(478600001)(71190400001)(71200400001)(53936002)(2501003)(102836004)(6666004)(64756008)(66556008)(14454004)(8936002)(55016002)(9686003)(6246003)(2906002)(25786009)(186003)(99286004)(7696005)(7736002)(76176011)(74316002)(305945005)(68736007)(53546011)(81156014)(8676002)(81166006)(26005)(777600001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:TYAPR01MB2813;H:TYAPR01MB3360.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MtXbQSkYDOdU66iOa9ojd45AAXGrqs+y1m0gHBmPDlM8F/X1OKGWkOWguM7VPhXDWhEoN+WR2bzM3bb1pghb6HGnTkJr0Twk9KUh0LIEdUITwJdUIbai1GPllpnKP6azdk1ByRT722nTY1sfZageyGKTw7yvhyezKYu75JrpQc166fBOgjmKV856H0WFnkfXCAUNNrRj6ktOauYznEPCNdYGdaZZ3+dbIdfveExRwJ4WQH9wSSqUflS005mU5KBb+KgYZP3Och5Ex8hC2ZM/E53RLTld4TcLpTWUc4F8PyCzNlDIqt6Gid49m1gdD/dCrjW8R6AXIz1BlbGHoT0NJv7s8Xxq3HBv5ribW0FdMVNrNqn0F33meoobD9mY7nG7SG5D1duVatZ+sYJSGXfdaw5J66x3X63xXpvGJcBfK7Y=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f70b8936-13c0-45dd-b63a-08d70a94f608
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2019 08:58:39.4298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: misono.tomohiro@jp.fujitsu.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2813
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1idHJmcy1vd25lckB2
Z2VyLmtlcm5lbC5vcmcgW21haWx0bzpsaW51eC1idHJmcy1vd25lckB2Z2VyLmtlcm5lbC5vcmdd
IE9uIEJlaGFsZiBPZiBIYW5zIHZhbiBLcmFuZW5idXJnDQo+IFNlbnQ6IFdlZG5lc2RheSwgSnVs
eSAxNywgMjAxOSA1OjI0IFBNDQo+IFRvOiBsaW51eC1idHJmc0B2Z2VyLmtlcm5lbC5vcmc7IFVs
bGkgSG9ybGFjaGVyIDxmcmFtc3RhZ0BydXMudW5pLXN0dXR0Z2FydC5kZT4NCj4gU3ViamVjdDog
UmU6IGhvdyBkbyBJIGtub3cgYSBzdWJ2b2x1bWUgaXMgYSBzbmFwc2hvdD8NCj4gDQo+IEhpLA0K
PiANCj4gT24gNy8xNy8xOSAxOjI0IEFNLCBVbGxpIEhvcmxhY2hlciB3cm90ZToNCj4gPg0KPiA+
IEkgdGhvdWdodCwgSSBjYW4gcmVjb2duaXplIGEgc25hcHNob3Qgd2hlbiBpdCBoYXMgYSBQYXJl
bnQgVVVJRCwgYnV0DQo+ID4gdGhpcyBpcyBub3QgdHJ1ZSBmb3Igc25hcHNob3RzIG9mIHRvcGxl
dmVsIHN1YnZvbHVtZXM6DQo+ID4NCj4gPiByb290QHRydWxsYTovIyBidHJmcyB2ZXJzaW9uDQo+
ID4gYnRyZnMtcHJvZ3MgdjQuNS4zKzIwMTYwNzI5DQo+ID4NCj4gPiByb290QHRydWxsYTovIyBi
dHJmcyBzdWJ2b2x1bWUgc2hvdyAvbW50L3RtcCAvbW50L3RtcCBpcyB0b3BsZXZlbA0KPiA+IHN1
YnZvbHVtZQ0KPiA+DQo+ID4gcm9vdEB0cnVsbGE6LyMgYnRyZnMgc3Vidm9sdW1lIHNuYXBzaG90
IC9tbnQvdG1wIC9tbnQvdG1wL3NzIENyZWF0ZSBhDQo+ID4gc25hcHNob3Qgb2YgJy9tbnQvdG1w
JyBpbiAnL21udC90bXAvc3MnDQo+ID4NCj4gPiByb290QHRydWxsYTovIyBidHJmcyBzdWJ2b2x1
bWUgY3JlYXRlIC9tbnQvdG1wL3h4IENyZWF0ZSBzdWJ2b2x1bWUNCj4gPiAnL21udC90bXAveHgn
DQo+ID4NCj4gPiByb290QHRydWxsYTovIyBidHJmcyBzdWJ2b2x1bWUgc2hvdyAvbW50L3RtcC9z
cyAvbW50L3RtcC9zcw0KPiA+ICAgICAgICAgTmFtZTogICAgICAgICAgICAgICAgICAgc3MNCj4g
PiAgICAgICAgIFVVSUQ6ICAgICAgICAgICAgICAgICAgIDc3MzJiZGRlLTA0ODUtMjA0ZS1iNDFi
LTgzMzM3NmU3OTFkYQ0KPiA+ICAgICAgICAgUGFyZW50IFVVSUQ6ICAgICAgICAgICAgLQ0KPiA+
ICAgICAgICAgUmVjZWl2ZWQgVVVJRDogICAgICAgICAgLQ0KPiA+ICAgICAgICAgQ3JlYXRpb24g
dGltZTogICAgICAgICAgMjAxOS0wNy0xNyAwMTowMjo0OCArMDIwMA0KPiA+ICAgICAgICAgU3Vi
dm9sdW1lIElEOiAgICAgICAgICAgMjcwDQo+ID4gICAgICAgICBHZW5lcmF0aW9uOiAgICAgICAg
ICAgICA2MA0KPiA+ICAgICAgICAgR2VuIGF0IGNyZWF0aW9uOiAgICAgICAgNjANCj4gPiAgICAg
ICAgIFBhcmVudCBJRDogICAgICAgICAgICAgIDUNCj4gPiAgICAgICAgIFRvcCBsZXZlbCBJRDog
ICAgICAgICAgIDUNCj4gPiAgICAgICAgIEZsYWdzOiAgICAgICAgICAgICAgICAgIC0NCj4gPiAg
ICAgICAgIFNuYXBzaG90KHMpOg0KPiA+DQo+ID4gcm9vdEB0cnVsbGE6LyMgYnRyZnMgc3Vidm9s
dW1lIHNob3cgL21udC90bXAveHggL21udC90bXAveHgNCj4gPiAgICAgICAgIE5hbWU6ICAgICAg
ICAgICAgICAgICAgIHh4DQo+ID4gICAgICAgICBVVUlEOiAgICAgICAgICAgICAgICAgICAzNDJi
MjA2NS0xNjc5LTgyNDUtYmQ3Ni04ZGE1OThjYzMzZDgNCj4gPiAgICAgICAgIFBhcmVudCBVVUlE
OiAgICAgICAgICAgIC0NCj4gPiAgICAgICAgIFJlY2VpdmVkIFVVSUQ6ICAgICAgICAgIC0NCj4g
PiAgICAgICAgIENyZWF0aW9uIHRpbWU6ICAgICAgICAgIDIwMTktMDctMTcgMDE6MDM6MDIgKzAy
MDANCj4gPiAgICAgICAgIFN1YnZvbHVtZSBJRDogICAgICAgICAgIDI3MQ0KPiA+ICAgICAgICAg
R2VuZXJhdGlvbjogICAgICAgICAgICAgNjENCj4gPiAgICAgICAgIEdlbiBhdCBjcmVhdGlvbjog
ICAgICAgIDYxDQo+ID4gICAgICAgICBQYXJlbnQgSUQ6ICAgICAgICAgICAgICA1DQo+ID4gICAg
ICAgICBUb3AgbGV2ZWwgSUQ6ICAgICAgICAgICA1DQo+ID4gICAgICAgICBGbGFnczogICAgICAg
ICAgICAgICAgICAtDQo+ID4gICAgICAgICBTbmFwc2hvdChzKToNCj4gPg0KPiA+IEhvdyBkbyBJ
IGtub3cgdGhhdCAvbW50L3RtcC9zcyBpcyBhIHNuYXBzaG90Pw0KPiA+IEkgY2Fubm90IHNlZSBh
IHNuYXBzaG90IGlkZW50aWZpZXIuDQo+ID4NCj4gDQo+IFRoZSB0ZWNobmljYWwgYW5zd2VyIGlz
Og0KPiANCj4gKiBUaGUgdXVpZCBvZiB0aGUgdG9wLWxldmVsIHN1YnZvbCAoaWQgNSkgaXMNCj4g
MDAwMDAwMDAtMDAwMC0wMDAwLTAwMDAtMDAwMDAwMDAwMDAwDQo+ICogVGhlIHBhcmVudCB1dWlk
IG9mIHlvdXIgc25hcHNob3QvY2xvbmUgaXMgYWxzbyAwMDAwLi4uIGFzIGEgcmVzdWx0Lg0KPiAq
IEZvciBpbnRlcnByZXRhdGlvbiBvZiBwYXJlbnQgdXVpZCBmaWVsZCwgdGhlcmUgaXMgbm8gZGlz
dGluY3Rpb24gYmV0d2VlbiAiaGFzIG5vIHBhcmVudCB1dWlkIiAodGhlIGZpZWxkIGlzIGVtcHR5
LA0KPiB3aGljaCB0ZWNobmljYWxseSBtZWFucyBhbGwgYml0cyBhcmUgMCkgYW5kIHRoZSBhY3R1
YWwgdmFsdWUgMDAwMC4uLg0KPiAqIFNvLi4uIHRoZSB0b29saW5nIGRpc3BsYXlzIGl0IGFzICIt
Ii4gwq9cXyjjg4QpXy/Crw0KPiANCj4gVGhlIHByYWN0aWNhbCBhbnN3ZXIgaXM6DQo+IA0KPiAq
IERvbid0IHB1dCBhbnl0aGluZyBpbiB0aGUgdG9wIGxldmVsIHN1YnZvbCB0aGF0IHdvdWxkIG1h
a2UgeW91IHdhbnQgdG8gc25hcHNob3QgaXQuDQo+IA0KPiBOb3RlOiBJbiBidHJmcyBkZXNpZ24s
IHRoZXJlIGlzIG5vIHRlY2huaWNhbCBkaWZmZXJlbmNlIGJldHdlZW4gYSBzbmFwc2hvdCBhbmQg
YSB3cml0YWJsZSBjbG9uZSAoYXMgb3Bwb3NlZCB0byBlLmcuDQo+IG5ldGFwcCBzbmFwc2hvdHMg
YW5kIGNsb25lcykuIFRoaXMgbWFrZXMgdGhlIGRlc2lnbiBsZXNzIGNvbXBsaWNhdGVkLCBidXQg
aXQgcmVzdWx0cyBpbiBhIGNvbGxlY3Rpb24gb2Yga25vd24gdXNhYmlsaXR5DQo+IGlzc3Vlcywg
bGlrZSB0aGF0IGlmIHlvdSBleHBlY3QgdGhlbSB0byBiZSBkaWZmZXJlbnQsIHRoZXkgc3RpbGwg
YXJlbid0Lg0KPiANCj4gSGFucw0KDQpIZWxsbywNCg0KRllJLCB0aGlzIHByb2JsZW0gc2hvdWxk
IGJlIGZpeGVkIGluIG1rZnMuYnRyZnMgPj0gdjQuMTYgc2luY2UgdGhlIHRvcC1sZXZlbA0Kc3Vi
dm9sdW1lIGFsc28gZ2V0cyBub24tZW1wdHkgVVVJRCBhdCBta2ZzIHRpbWUuDQoNClRoYW5rcw0K
