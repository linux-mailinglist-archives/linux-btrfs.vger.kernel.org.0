Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49A061341F8
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2020 13:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgAHMl5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jan 2020 07:41:57 -0500
Received: from m4a0073g.houston.softwaregrp.com ([15.124.2.131]:47867 "EHLO
        m4a0073g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726199AbgAHMl5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 Jan 2020 07:41:57 -0500
Received: FROM m4a0073g.houston.softwaregrp.com (15.120.17.146) BY m4a0073g.houston.softwaregrp.com WITH ESMTP;
 Wed,  8 Jan 2020 12:39:36 +0000
Received: from M9W0067.microfocus.com (2002:f79:be::f79:be) by
 M4W0334.microfocus.com (2002:f78:1192::f78:1192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Wed, 8 Jan 2020 12:36:24 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (15.124.72.10) by
 M9W0067.microfocus.com (15.121.0.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Wed, 8 Jan 2020 12:36:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n1mEY3oUowOup73VKKAcoSPYiCQWJ722YlVFWvY1qzE8M5CEXZoOasXWLxLb5+OBYIbf4UMfVm8JEUutmT2PyI4jFyWNZm+sijDp5AxaJJvgJsSBkKp4e9darbH6YdskXI26hu4dojrkxmG4MhLd+4dxUxqEdkPbpzKr8Cw/IOC7pGOC9PeY9sjZ/gsofM3NC9cY7npBTGUBRH+gQo2mm5n//UK6V1p7G/37ShHuexLSOhr2mvWWd4U4mmamMYb8OrnJUCsu+8b7V0wcjuodoeeRRaVuqMCUDzO4cd9beyIJNHhi+nnKJ/4IuXtDtLYGsUE1Gfr/kY3053vNOguXGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEOzcl6XoD/zckg6wyjnVJ4GYYHN8flFGS1LWiindcU=;
 b=SRbV2pzgv1zZ8bc7TCBrfCi8AFbr37txAaLW4Qt9DMSGNQKb4S2uq4ZYaKV5cb+sUy/8Rj1CSfDb0V0nSr1aRPBgDPSb2ww0Cm6n7JzOQGoS2x+kaTMgmA9IzEkhM9ZWydUGesAHKWEfa+FTII1YBMHXn9RSD6Mx0cyVLb0jQYp8VBfHpMH9G3CF1ZEUgonVrgiUXAvostmDq9IDdMZM4smiPSGfxzd62ub1iKo+J1A8A3GiSiXnT8NoSGkQ+DAboRcTqKvCFjvfxPXCclACaupVOrNqccB6MJMGGxodNQ5ASKgnrRcWlAnLU1FKj24cGqRz3yzbxlKKUs0DREnFLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3217.namprd18.prod.outlook.com (10.255.138.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Wed, 8 Jan 2020 12:36:21 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::d948:61b9:971a:facd]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::d948:61b9:971a:facd%7]) with mapi id 15.20.2623.008; Wed, 8 Jan 2020
 12:36:21 +0000
Received: from [0.0.0.0] (149.28.201.231) by BYAPR07CA0031.namprd07.prod.outlook.com (2603:10b6:a02:bc::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9 via Frontend Transport; Wed, 8 Jan 2020 12:36:19 +0000
From:   Qu WenRuo <wqu@suse.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        David Sterba <DSterba@suse.com>
Subject: Re: [PATCH v2] btrfs: relocation: Fix KASAN reports caused by
 extended reloc tree lifespan
Thread-Topic: [PATCH v2] btrfs: relocation: Fix KASAN reports caused by
 extended reloc tree lifespan
Thread-Index: AQHVxh8iya/WShe6f0uyJi0EGl5jrKfgtDEA
Date:   Wed, 8 Jan 2020 12:36:20 +0000
Message-ID: <b75dc3bc-b8b6-4f28-d9d0-f2e2a4e46a1e@suse.com>
References: <20200108051200.8909-1-wqu@suse.com>
 <5cfff64e-0843-12ae-1ffc-37016552073d@suse.com>
In-Reply-To: <5cfff64e-0843-12ae-1ffc-37016552073d@suse.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0031.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::44) To BY5PR18MB3266.namprd18.prod.outlook.com
 (2603:10b6:a03:1a1::15)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [149.28.201.231]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a37afd46-7961-4f3b-95f1-08d794375d57
x-ms-traffictypediagnostic: BY5PR18MB3217:
x-ld-processed: 856b813c-16e5-49a5-85ec-6f081e13b527,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR18MB3217646F8999F5778613D9CCD63E0@BY5PR18MB3217.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1201;
x-forefront-prvs: 02760F0D1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(189003)(199004)(110136005)(6486002)(16576012)(71200400001)(107886003)(316002)(31686004)(478600001)(186003)(16526019)(6666004)(6706004)(54906003)(31696002)(2906002)(4326008)(36756003)(2616005)(64756008)(66556008)(81156014)(81166006)(66476007)(66446008)(956004)(86362001)(52116002)(8936002)(8676002)(66946007)(26005)(5660300002)(78286006);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3217;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: msflQS4YRk+OYVrOegEHwtsRm33Hqr2W5EksjjdbSRsdQrtD6/I+bfnAJgvvaa1fFcek8uA7vcHHSqH/0uHnF736tPzlMB0aqYUYsbNgYLm1z0CHjP+66Y/3jx3rkdH2Jem3o+duwrzIZP0LzZJyyPAFcZpSmMaZI9vS9xyKKy4nDOFtOgbp7bBrum9DCtKMFQf3O/GiEqVuzC+c9v1cmZZMnECT/+jRLhGbbmuJuNONKSDU2rJ6VjpPOofuTHfVZL+89fA2w/YZCJKua78aucp+HB1iCvzJAur47VP3sWP0EPQu0VM+SSxmim1EVGiNRwn3mrc22nQo8nzOi0ojh5X2gdry7WmqTybIMzFFp0ZkWEFEU0hykSS4qa7ySE7ekmhrNmntu/TyckU2mr3cGNOTVCL6bxGaFygHjG7exr4cjhNBEBkiCvX5aJ9tFZLnRd5HbxVzYIKavhmRi4jAMnsb8rr7RbEM1XuYLy3iRACctEXMzH3Hom4Vdo2pyFmB
Content-Type: text/plain; charset="utf-8"
Content-ID: <A8F28CA5F60F7448B97873D020FA707D@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a37afd46-7961-4f3b-95f1-08d794375d57
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2020 12:36:20.9525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gv6XMfZYE1RzRTQ0VNIqN/4qxt3v98HuDpeer+6uJ/sgJkWh+DUOS07PA4Y6KI0J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3217
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQoNCk9uIDIwMjAvMS84IOS4i+WNiDg6MjgsIE5pa29sYXkgQm9yaXNvdiB3cm90ZToNCj4gDQo+
IA0KPiBPbiA4LjAxLjIwINCzLiA3OjEyINGHLiwgUXUgV2VucnVvIHdyb3RlOg0KPj4gW0JVR10N
Cj4+IFRoZXJlIGFyZSBzZXZlcmFsIGRpZmZlcmVudCBLQVNBTiByZXBvcnRzIGZvciBiYWxhbmNl
ICsgc25hcHNob3QNCj4+IHdvcmtsb2Fkcy4NCj4+IEludm9sdmVkIGNhbGwgcGF0aHMgaW5jbHVk
ZToNCj4+DQo+PiAgICBzaG91bGRfaWdub3JlX3Jvb3QrMHg1NC8weGIwIFtidHJmc10NCj4+ICAg
IGJ1aWxkX2JhY2tyZWZfdHJlZSsweDExYWYvMHgyMjgwIFtidHJmc10NCj4+ICAgIHJlbG9jYXRl
X3RyZWVfYmxvY2tzKzB4MzkxLzB4YjgwIFtidHJmc10NCj4+ICAgIHJlbG9jYXRlX2Jsb2NrX2dy
b3VwKzB4M2U1LzB4YTAwIFtidHJmc10NCj4+ICAgIGJ0cmZzX3JlbG9jYXRlX2Jsb2NrX2dyb3Vw
KzB4MjQwLzB4NGQwIFtidHJmc10NCj4+ICAgIGJ0cmZzX3JlbG9jYXRlX2NodW5rKzB4NTMvMHhm
MCBbYnRyZnNdDQo+PiAgICBidHJmc19iYWxhbmNlKzB4YzkxLzB4MTg0MCBbYnRyZnNdDQo+PiAg
ICBidHJmc19pb2N0bF9iYWxhbmNlKzB4NDE2LzB4NGUwIFtidHJmc10NCj4+ICAgIGJ0cmZzX2lv
Y3RsKzB4OGFmLzB4M2U2MCBbYnRyZnNdDQo+PiAgICBkb192ZnNfaW9jdGwrMHg4MzEvMHhiMTAN
Cj4+ICAgIGtzeXNfaW9jdGwrMHg2Ny8weDkwDQo+PiAgICBfX3g2NF9zeXNfaW9jdGwrMHg0My8w
eDUwDQo+PiAgICBkb19zeXNjYWxsXzY0KzB4NzkvMHhlMA0KPj4gICAgZW50cnlfU1lTQ0FMTF82
NF9hZnRlcl9od2ZyYW1lKzB4NDkvMHhiZQ0KPj4NCj4+ICAgIGNyZWF0ZV9yZWxvY19yb290KzB4
OWYvMHg0NjAgW2J0cmZzXQ0KPj4gICAgYnRyZnNfcmVsb2NfcG9zdF9zbmFwc2hvdCsweGZmLzB4
NmMwIFtidHJmc10NCj4+ICAgIGNyZWF0ZV9wZW5kaW5nX3NuYXBzaG90KzB4YTliLzB4MTVmMCBb
YnRyZnNdDQo+PiAgICBjcmVhdGVfcGVuZGluZ19zbmFwc2hvdHMrMHgxMTEvMHgxNDAgW2J0cmZz
XQ0KPj4gICAgYnRyZnNfY29tbWl0X3RyYW5zYWN0aW9uKzB4N2E2LzB4MTM2MCBbYnRyZnNdDQo+
PiAgICBidHJmc19ta3N1YnZvbCsweDkxNS8weDk2MCBbYnRyZnNdDQo+PiAgICBidHJmc19pb2N0
bF9zbmFwX2NyZWF0ZV90cmFuc2lkKzB4MWQ1LzB4MWUwIFtidHJmc10NCj4+ICAgIGJ0cmZzX2lv
Y3RsX3NuYXBfY3JlYXRlX3YyKzB4MWQzLzB4MjcwIFtidHJmc10NCj4+ICAgIGJ0cmZzX2lvY3Rs
KzB4MjQxYi8weDNlNjAgW2J0cmZzXQ0KPj4gICAgZG9fdmZzX2lvY3RsKzB4ODMxLzB4YjEwDQo+
PiAgICBrc3lzX2lvY3RsKzB4NjcvMHg5MA0KPj4gICAgX194NjRfc3lzX2lvY3RsKzB4NDMvMHg1
MA0KPj4gICAgZG9fc3lzY2FsbF82NCsweDc5LzB4ZTANCj4+ICAgIGVudHJ5X1NZU0NBTExfNjRf
YWZ0ZXJfaHdmcmFtZSsweDQ5LzB4YmUNCj4+DQo+PiAgICBidHJmc19yZWxvY19wcmVfc25hcHNo
b3QrMHg4NS8weGMwIFtidHJmc10NCj4+ICAgIGNyZWF0ZV9wZW5kaW5nX3NuYXBzaG90KzB4MjA5
LzB4MTVmMCBbYnRyZnNdDQo+PiAgICBjcmVhdGVfcGVuZGluZ19zbmFwc2hvdHMrMHgxMTEvMHgx
NDAgW2J0cmZzXQ0KPj4gICAgYnRyZnNfY29tbWl0X3RyYW5zYWN0aW9uKzB4N2E2LzB4MTM2MCBb
YnRyZnNdDQo+PiAgICBidHJmc19ta3N1YnZvbCsweDkxNS8weDk2MCBbYnRyZnNdDQo+PiAgICBi
dHJmc19pb2N0bF9zbmFwX2NyZWF0ZV90cmFuc2lkKzB4MWQ1LzB4MWUwIFtidHJmc10NCj4+ICAg
IGJ0cmZzX2lvY3RsX3NuYXBfY3JlYXRlX3YyKzB4MWQzLzB4MjcwIFtidHJmc10NCj4+ICAgIGJ0
cmZzX2lvY3RsKzB4MjQxYi8weDNlNjAgW2J0cmZzXQ0KPj4gICAgZG9fdmZzX2lvY3RsKzB4ODMx
LzB4YjEwDQo+PiAgICBrc3lzX2lvY3RsKzB4NjcvMHg5MA0KPj4gICAgX194NjRfc3lzX2lvY3Rs
KzB4NDMvMHg1MA0KPj4gICAgZG9fc3lzY2FsbF82NCsweDc5LzB4ZTANCj4+ICAgIGVudHJ5X1NZ
U0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDQ5LzB4YmUNCj4+DQo+PiBbQ0FVU0VdDQo+PiBBbGwg
dGhlc2UgY2FsbCBzaXRlcyBhcmUgb25seSByZWx5aW5nIG9uIHJvb3QtPnJlbG9jX3Jvb3QsIHdo
aWNoIGNhbg0KPj4gdW5kZXJnbyBidHJmc19kcm9wX3NuYXBzaG90KCksIGFuZCBzaW5jZSB3ZSBk
b24ndCBoYXZlIHJlYWwgcmVmY291bnQNCj4gDQo+IHdoYXQgZG8geW91IG1lYW4gYnkgInJvb3Qt
PnJlbG9jX3Jvb3QgY2FuIHVuZGVyZ28gYnRyZnNfZHJvcF9zbmFwc2hvdCIgPw0KDQpJIG1lYW4g
c29tZSBjYWxsZXIgZ290IHJvb3QtPnJlbG9jX3Jvb3QgYW5kIHVzZSBpdCwgd2hpbGUNCnJvb3Qt
PnJlbG9jX3Jvb3Qgc29vbiBnZXQgZHJvcHBlZCBieSBidHJmc19kcm9wX3NuYXBzaG90KCkuDQoN
Cj4gDQo+PiBiYXNlZCBwcm90ZWN0aW9uIHRvIHJlbG9jIHJvb3RzLCB3ZSBjYW4gcmVhY2ggYWxy
ZWFkeSBkcm9wcGVkIHJlbG9jDQo+PiByb290LCB0cmlnZ2VyaW5nIEtBU0FOLg0KPiB3aGF0J3Mg
dGhlIHJlbGF0aW9uc2hpcCBiZXR3ZWVuIG5vdCBoYXZpbmcgYSByZWZjb3VudCBwcm90ZWN0aW9u
IGFuZA0KPiByZWFjaGluZyByZWxvYyByb290cywgcGVyaGFwcyB5b3UgY291bGQgZXhwYW5kIHRo
ZSBleHBsYW5hdGlvbj8NCg0KSWYgd2UgaGFkIGEgcHJvcGVyIHJlZmNvdW50IHByb3RlY3Rpb24s
IHdlIGNvdWxkIHdhaXQgdW50aWwgd2UncmUgdGhlDQpsYXN0IGhvbGRlciBvZiByZWxvY19yb290
IGJlZm9yZSBjYWxsaW5nIGJ0cmZzX2Ryb3Bfc25hcHNob3QoKS4NCg0KQW5kIHRvIG1lLCB0aGF0
IHNob3VsZCBiZSB0aGUgY29ycmVjdCBzb2x1dGlvbiwgd2hpbGUgdGhpcyBwYXRjaCBpcyBqdXN0
DQphIHF1aWNrIGFuZCBtYXliZSBkaXJ0eSBmaXggbW9zdGx5IGZvciBiYWNrcG9ydC4NCg0KPiAN
Cj4+DQo+PiBbRklYXQ0KPj4gVG8gYXZvaWQgc3VjaCBhY2Nlc3MgdG8gdW5zdGFibGUgcm9vdC0+
cmVsb2Nfcm9vdCwgd2Ugc2hvdWxkIGNoZWNrDQo+PiBCVFJGU19ST09UX0RFQURfUkVMT0NfVFJF
RSBiaXQgZmlyc3QuDQo+Pg0KPj4gVGhpcyBwYXRjaCBpbnRyb2R1Y2VzIGEgbmV3IHdyYXBwZXIs
IGhhdmVfcmVsb2Nfcm9vdCgpLCB0byBkbyB0aGUgcHJvcGVyDQo+PiBjaGVjayBmb3IgbW9zdCBj
YWxsZXJzIHdobyBkb24ndCBkaXN0aW5ndWlzaCBtZXJnZWQgcmVsb2MgdHJlZSBhbmQgbm8NCj4+
IHJlbG9jIHRyZWUuDQo+Pg0KPj4gVGhlIG9ubHkgZXhjZXB0aW9uIGlzIHNob3VsZF9pZ25vcmVf
cm9vdCgpLCBhcyBtZXJnZWQgcmVsb2MgdHJlZSBjYW4gYmUNCj4+IGlnbm9yZWQsIHdoaWxlIG5v
IHJlbG9jIHRyZWUgc2hvdWxkbid0Lg0KPj4NCj4+IFtDUklUSUNBTCBTRUNUSU9OIEFOQUxZU0Vd
DQo+PiBBbHRob3VnaCB0ZXN0X2JpdCgpL3NldF9iaXQoKS9jbGVhcl9iaXQoKSBkb2Vzbid0IGlt
cGx5IGEgYmFycmllciwgdGhlDQo+PiBERUFEX1JFTE9DX1RSRUUgYml0IGhhcyBleHRyYSBoZWxw
IGZyb20gdHJhbnNhY3Rpb24gYXMgYSBoaWdoZXIgbGV2ZWwNCj4+IGJhcnJpZXIsIHRoZSBsaWZl
c3BhbiBvZiByb290OjpyZWxvY19yb290IGFuZCBERUFEX1JFTE9DX1RSRUUgYml0IGFyZToNCj4+
DQo+PiAJTlVMTDogcmVsb2Nfcm9vdCBpcyBOVUxMCVBUUjogcmVsb2Nfcm9vdCBpcyBub3QgTlVM
TA0KPj4gCTA6IERFQURfUkVMT0NfUk9PVCBiaXQgbm90IHNldAlERUFEOiBERUFEX1JFTE9DX1JP
T1QgYml0IHNldA0KPj4NCj4+IAkoTlVMTCwgMCkgICAgSW5pdGlhbCBzdGF0ZQkJIF9fDQo+PiAJ
ICB8CQkJCQkgL1wgU2VjdGlvbiBBDQo+PiAgICAgICAgIGJ0cmZzX2luaXRfcmVsb2Nfcm9vdCgp
CQkJIFwvDQo+PiAJICB8CQkJCSAJIF9fDQo+PiAJKFBUUiwgMCkgICAgIHJlbG9jX3Jvb3QgaW5p
dGlhbGl6ZWQgICAgICAvXA0KPj4gICAgICAgICAgIHwJCQkJCSB8DQo+PiAJYnRyZnNfdXBkYXRl
X3JlbG9jX3Jvb3QoKQkJIHwgIFNlY3Rpb24gQg0KPj4gICAgICAgICAgIHwJCQkJCSB8DQo+PiAJ
KFBUUiwgREVBRCkgIHJlbG9jX3Jvb3QgaGFzIGJlZW4gbWVyZ2VkICBcLw0KPj4gICAgICAgICAg
IHwJCQkJCSBfXw0KPj4gCT09PSBidHJmc19jb21taXRfdHJhbnNhY3Rpb24oKSA9PT09PT09PT09
PT09PT09PT09PQ0KPj4gCSAgfAkJCQkJIC9cDQo+PiAJY2xlYW5fZGlydHlfc3Vidm9scygpCQkJ
IHwNCj4+IAkgIHwJCQkJCSB8ICBTZWN0aW9uIEMNCj4+IAkoTlVMTCwgREVBRCkgcmVsb2Nfcm9v
dCBjbGVhbnVwIHN0YXJ0cyAgIFwvDQo+PiAgICAgICAgICAgfAkJCQkJIF9fDQo+PiAJYnRyZnNf
ZHJvcF9zbmFwc2hvdCgpCQkJIC9cDQo+PiAJICB8CQkJCQkgfCAgU2VjdGlvbiBEDQo+PiAJKE5V
TEwsIDApICAgIEJhY2sgdG8gaW5pdGlhbCBzdGF0ZQkgXC8NCj4+DQo+PiBWZXJ5IGhhdmVfcmVs
b2Nfcm9vdCgpIG9yIHRlc3RfYml0KERFQURfUkVMT0NfUk9PVCkgY2FsbGVyIGhhcyBob2xkIGEN
Cj4gDQo+ICBeXiBQZXJoYXBzIHlvdSBtZWFudDogRXZlcnkgY2FsbGVyIG9mIGhhdmVfcmVsb2Nf
cm9vdCBvcg0KPiB0ZXN0X2JpdChERURfUkVMT0NfUk9PVCkgaG9sZHMgYSB0cmFuc2FjdGlvbiBo
YW5kbGUgd2hpY2ggZW5zdXJlcw0KPiBtb2RpZmljYXRpb25zIGluIHRob3NlIGZ1bmN0aW9uIGFy
ZSBsaW1pdGVkIHRvIGEgc2luZ2xlIHRyYW5zYWN0aW9uPw0KDQpZZXAsIEkgbWVhbiAqRSp2ZXJ5
Lg0KSXQgbG9va3MgSSBuZWVkIHRvIHJlcGxhY2UgdGhlIHN3aXRjaCBvZiBteSAnZScga2V5Li4u
DQoNClRoYW5rcywNClF1DQo=
