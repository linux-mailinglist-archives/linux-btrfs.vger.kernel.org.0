Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B723AE717
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2019 11:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbfIJJgf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Sep 2019 05:36:35 -0400
Received: from esa7.fujitsucc.c3s2.iphmx.com ([68.232.159.87]:54762 "EHLO
        esa7.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726841AbfIJJgf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Sep 2019 05:36:35 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Sep 2019 05:36:33 EDT
IronPort-SDR: FWdy7/aP5ZPiFFqGxLXkHZ4ejM9giu0wwTQMFn9G2jo836ybxqlOIf/g7VrLr3fwmwavyvZvze
 dFhYD427n3ibMFLWnU3UrOIgRYO7TGOLRlQHiFYrRUaBn826bWQUlZeQF9F/9Ejm/AfqiGp8iG
 tZTCZEHeqDXVACoTNzAg/UwUEEA3w/hWjl2CcLG5LE943wweUhUTgJsnS3FTs6Z4TeWjTwUxve
 mRp0H3znYriubb0aGCB25DKtrWIc1+vhcmuOu7DEIzKVhr2HipkKOJU3M6eCGgvc8rN0LrkylJ
 BBQ=
X-IronPort-AV: E=McAfee;i="6000,8403,9375"; a="6096122"
X-IronPort-AV: E=Sophos;i="5.64,489,1559487600"; 
   d="scan'208";a="6096122"
Received: from mail-os2jpn01lp2052.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.52])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA384; 10 Sep 2019 18:29:24 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KlDJy30v55S168jT7rtrv+klEtdnJVXh5mzSCyvkz61/xT/2Uwhz9xcQd71O5ufnHDf4oN065UmuooC3udD52utrQV3fFeF2TZvz1xSfeWfnxihAfcHiM9Ctq0W3wHCuK4o/F4eYVFvQodeLS+VjOGUourPd4+WbM4v83+Amtn4fZF4SxMOT6ZD8Jo6j3tpKl1N3DNWcEg+27EuGDiMv2PsluNBEJrb4Gy+nHY4gxSrYS4nI0otjd87+emy2ZCr3F8qDx0Gpg8i+9td6FTlxdeweApN9Sfjf+EkJFyRxdDzLJ1qYaIJFWscbk3o5AH3SVJ0c+B9ucRK9PoGoviVKhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQ8axY9ZlPdZNHIaRCLVj8MwFnjt4M7H/bxeNqBm1yE=;
 b=GN2VahkvXcU7Rfe8hHwt/YGFb5bF2LYSBMY0cJtuHrucErOngke9Si9nfAP+cFKaV2pNtmWmFdc89FJUd8RiXfubKtH5FgJLm9OoJYg4rO+mrtpOAMbe5QjShOoQL1Nm+aglGyr2hO+61wj2zm140IXJAdpy6jlb4Pl+CC1615uQ7EABib6rc/mLgKi6l2UJk8r4ImeUTCxnPOuomaQca/7XzoB0eLX/LkwJ/YTb4/ztdBraBGzuK4RXxO8S8YiuxQPZeiAapW7/QlSU64n3inU7J2R+f1iyrOIYSiHgtbo8N933VxRt+5EeVQvRklL/NJLIR/9/mYDm/5467wwAig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQ8axY9ZlPdZNHIaRCLVj8MwFnjt4M7H/bxeNqBm1yE=;
 b=Egmz8sV1kJQUi2KW1/7FDA0dGUoQsLoDkWhhizPKCFg7r/DRyKXY4xa5m6Nah5aKxCiCakU8MwI4lZMX46kQvKh2LEvCCkuUu0JUu7YojG1aZb1XHltnvciOe+hrs7I7yTOESe5bfmcqcX58i4oZrNDVzlXD0a1P+eoCPONQqUw=
Received: from OSBPR01MB3367.jpnprd01.prod.outlook.com (20.178.98.21) by
 OSBPR01MB3959.jpnprd01.prod.outlook.com (20.178.98.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.18; Tue, 10 Sep 2019 09:29:21 +0000
Received: from OSBPR01MB3367.jpnprd01.prod.outlook.com
 ([fe80::e502:781f:2d6c:1cb2]) by OSBPR01MB3367.jpnprd01.prod.outlook.com
 ([fe80::e502:781f:2d6c:1cb2%5]) with mapi id 15.20.2241.018; Tue, 10 Sep 2019
 09:29:21 +0000
From:   "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>
To:     'Chris Murphy' <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: RE: user_subvol_rm_allowed vs rmdir_subvol
Thread-Topic: user_subvol_rm_allowed vs rmdir_subvol
Thread-Index: AQHVZm8dPJeAxRaDyUy0lCvPH+ZquackixnA
Date:   Tue, 10 Sep 2019 09:28:11 +0000
Deferred-Delivery: Tue, 10 Sep 2019 09:29:08 +0000
Message-ID: <OSBPR01MB3367B6E4521888148EB778BFE5B60@OSBPR01MB3367.jpnprd01.prod.outlook.com>
References: <CAJCQCtQueeFf=4m0Y2t3Qxzh_qT=PKwY5CPe4MmBb1wx3xyDfg@mail.gmail.com>
In-Reply-To: <CAJCQCtQueeFf=4m0Y2t3Qxzh_qT=PKwY5CPe4MmBb1wx3xyDfg@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: a05c2c501a2045d4aa5f9fd91fd2bc5c
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=misono.tomohiro@fujitsu.com; 
x-originating-ip: [180.43.156.18]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e6f030fc-47ce-4ef9-36ff-08d735d15ca7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:OSBPR01MB3959;
x-ms-traffictypediagnostic: OSBPR01MB3959:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <OSBPR01MB3959B2EDB083834415C14A4FE5B60@OSBPR01MB3959.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01565FED4C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(39860400002)(376002)(366004)(396003)(189003)(199004)(8936002)(14444005)(53936002)(9686003)(55016002)(256004)(66476007)(52536014)(6666004)(66446008)(86362001)(64756008)(85182001)(14454004)(66066001)(66946007)(7696005)(478600001)(316002)(6506007)(2906002)(25786009)(33656002)(229853002)(74316002)(8676002)(71190400001)(476003)(81166006)(102836004)(81156014)(446003)(11346002)(7116003)(5660300002)(6306002)(26005)(6246003)(186003)(6436002)(99286004)(76116006)(6116002)(7736002)(66556008)(110136005)(3846002)(71200400001)(76176011)(305945005)(486006)(966005)(777600001);DIR:OUT;SFP:1101;SCL:1;SRVR:OSBPR01MB3959;H:OSBPR01MB3367.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EWevCMDbTzNGxzpF2tkkzt2vpxnPGWz+xIiOfLsMgvvXOMZAk9ELALzsMpIQvIhFykgnNdQATmB7eV0ag6gdCMIXFPYbx2ULNYYIt7IfQ9z858gp5yNsTbXq8noTGMjOuQ1avfz5oGaDxuSpeM69WlPl5O54ISh1qATVtcwMWpqd3kWD1rBwkzUFS+Hz7wm8QKJr6LibiD18nvQiX1IVeS8G3wyeh2dlfCnhGIXLx9PNAVaUGtP5HIRHLKqUdELSgkUQIXAp0HLtSeZD3v5edB0wsnsc36aONfE20wgC63SknZsurZZi215hE14HnNnxCDkgsUmYg7xxci9RBzFs7ICF9cZvR6pXe3Z8Qqo3NL3TwKZqU6WdWAJCzOyR73piqZrBPNl8nIR4tSR/QAELDMjlk1spwRdFEfLf/GEHDsg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6f030fc-47ce-4ef9-36ff-08d735d15ca7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2019 09:29:21.4484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zvPJ3p8Rnszp1p9stY04zoezsXxpT/ZV/AL2DZh14KGvRsN7L8gl1exOCAvnjbooBFsgQY1tlzb02RhDcBbXiS2rzCKQ+Pfe0VlWC5BKIQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3959
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

SGVsbG8sDQoNCihJdCBzZWVtcyB0aGF0IHlvdSBhbHJlYWR5IGhhdmUgYW5zd2VycyBidXQgYW55
d2F5Li4uKQ0KDQo+IENhbWUgYWNyb3NzIHRoaXMgcG9kbWFuIGlzc3VlIHllc3RlcmRheQ0KPiBo
dHRwczovL2dpdGh1Yi5jb20vY29udGFpbmVycy9saWJwb2QvaXNzdWVzLzM5NjMNCj4gDQo+IA0K
PiBRdWVzdGlvbiAxOiBGb3IgdW5wcml2aWxlZ2VkIHVzZSBjYXNlLCBpcyBpdCBpbnRlbnRpb25h
bCB0aGF0IHRoZSB1c2VyIGNyZWF0ZXMgYSBzdWJ2b2x1bWUvc25hcHNob3QgdXNpbmcgJ2J0cmZz
IHN1Yg0KPiBjcmVhdGUnIGFuZCB0aGF0IHRoZSB1c2VyIGRlbGV0ZSBpdCB3aXRoICdybSAtcmYn
ID8NCg0KWWVzLiBUaGUgcHJvYmxlbSB3aXRoICJidHJmcyBzdWIgZGVsZXRlIiBpcyB0aGF0IHRo
ZSBwZXJtaXNzaW9uIGNoZWNrIGlzIG9ubHkgcGVyZm9ybWVkIHRvIHRoZSB0b3AgZGlyZWN0b3J5
KHN1YnZvbHVtZSkuDQpUZXJlZm9yZSB1bmxlc3MgdXNlcl9zdWJ2b2xfcm1fYWxsb3dlZCBtb3Vu
dCBvcHRpb24gaXMgdXNlZCwgImJ0dHJmcyBzdWIgZGVsZXRlIiBjb21tYW5kIGlzIHJlc3RyaWN0
ZWQgZm9yIHVucHJpdmlsZWdlZCB1c2VyLg0KDQo+IA0KPiBBbmQgaXMgdGhlIGNvbnNlcXVlbmNl
IG9mIHRoaXMgcGVyZm9ybWFuY2U/IEJlY2F1c2UgSSBzZWUgcm0gLXJmIG11c3QgaW5kaXZpZHVh
bGx5IHJlbW92ZSBhbGwgZmlsZXMgYW5kIGRpcnMgZnJvbSB0aGUNCj4gc3Vidm9sdW1lIGZpcnN0
LCBiZWZvcmUgcm1kaXIoKSBpcyBjYWxsZWQgdG8gcmVtb3ZlIHRoZSBzdWJ2b2x1bWUuIFdoZXJl
IGFzICdidHJmcyBzdWIgZGVsJyBjYWxscyBCVFJGU19JT0NfU05BUF9ERVNUUk9ZDQo+IGlvY3Rs
IHdoaWNoIGlzIHByZXR0eSBtdWNoIGltbWVkaWF0ZSwgd2l0aCBjbGVhbnVwIGhhcHBlbmluZyBp
biB0aGUgYmFja2dyb3VuZC4NCg0KWWVzLg0KDQo+IA0KPiANCj4gUXVlc3Rpb24gMjoNCj4gDQo+
IEFzIGl0IHJlbGF0ZXMgdG8gdGhlIHBvZG1hbiBpc3N1ZSwgd2hhdCBkbyBCdHJmcyBkZXZlbG9w
ZXJzIHJlY29tbWVuZD8NCj4gSWYga2VybmVsID4gNC4xOCwgYW5kIGlmIHVucHJpdmlsZWdlZCwg
dGhlbiB1c2UgJ3JtIC1yZicgdG8gZGVsZXRlIHN1YnZvbHVtZXM/IE90aGVyd2lzZSB1c2UgJ2J0
cmZzIHN1YiBkZWwnIHdpdGggcm9vdA0KPiBwcml2aWxlZ2U/DQoNCi0gImJ0cmZzIHN1YiBkZWxl
dGUiIGlmIG1vdW50ZWQgd2l0aCBzdWJ2b2xfcm1fYWxsb3dlZA0KLSAicm0gLXIiIGlmIG5vdCBt
b3VudGVkIHdpdGggc3Vidm9sX3JtX2FsbG93ZWQNCiANCj4gUXVlc3Rpb24gMzoNCj4gbWFuIDUg
YnRyZnMgaGFzIGEgY29uZnVzaW5nIG5vdGUgZm9yIHVzZXJfc3Vidm9sX3JtX2FsbG93ZWQgbW91
bnQgb3B0aW9uOg0KPiANCj4gICAgICAgICAgICAgICAgTm90ZQ0KPiAgICAgICAgICAgICAgICBo
aXN0b3JpY2FsbHksIGFueSB1c2VyIGNvdWxkIGNyZWF0ZSBhIHNuYXBzaG90IGV2ZW4gaWYgaGUg
d2FzIG5vdCBvd25lciBvZiB0aGUgc291cmNlIHN1YnZvbHVtZSwgdGhlDQo+IHN1YnZvbHVtZSBk
ZWxldGlvbiBoYXMgYmVlbiByZXN0cmljdGVkDQo+ICAgICAgICAgICAgICAgIGZvciB0aGF0IHJl
YXNvbi4gVGhlIHN1YnZvbHVtZSBjcmVhdGlvbiBoYXMgYmVlbiByZXN0cmljdGVkIGJ1dCB0aGlz
IG1vdW50IG9wdGlvbiBpcyBzdGlsbCByZXF1aXJlZC4NCj4gVGhpcyBpcyBhIHVzYWJpbGl0eSBp
c3N1ZS4NCj4gDQo+IDJuZCBzZW50ZW5jZSAic3Vidm9sdW1lIGNyZWF0aW9uIGhhcyBiZWVuIHJl
c3RyaWN0ZWQiICBJIGNhbid0IHBhcnNlIHRoYXQuIElzIGl0IGFuIGVycm9yLCBvciBjYW4gaXQg
YmUgd29yZGVkIGRpZmZlcmVudGx5Pw0KDQpZb3UgY2Fubm90IGNyZWF0ZSBhIHNuYXBzaG90IG9m
IGEgc3Vidm9sdW1lIHdoaWNoIGlzIG93bmVkIGJ5IG90aGVyIHVzZXIgbm93IChhcHBhcmVudGx5
IG9sZCBidHJmcyBhbGxvd2VkIHRoaXMpLg0KDQpJbiBzdW1tYXJ5LCBzdWJ2b2x1bWUgZGVsZXRp
b24gYnkgdW5wcml2aWxlZ2VkIHVzZXIgaXMgcmVzdHJpY3RlZCBieSBkZWZhdWx0IGJlY2F1c2U6
DQogMS4gYSB1c2VyIGNvdWxkIGNyZWF0ZSBhIHNuYXBzaG90IHdoaWNoIHdhcyBub3Qgb3duZWQg
YnkgdGhlIHVzZXIgaW4gb2xkIGJ0cmZzLg0KIDIuIEJUUkZTX0lPQ19TTkFQX0RFU1RST1kgaW9j
dGwgb25seSBwZXJmb3JtcyBwZXJtaXNzaW9uIGNoZWNrIHRvIHRoZSB0b3AgZGlyZWN0b3J5Lg0K
DQpJIHRoaW5rIDEgaXMgbm90IGEgcHJvYmxlbSBhbnltb3JlLCBieXQgMiBzdGlsbCByZW1haW5z
LiANCg0KVGhhbmtzLg0K
