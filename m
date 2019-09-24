Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BED21BC557
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 11:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504431AbfIXJ6u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Sep 2019 05:58:50 -0400
Received: from m4a0041g.houston.softwaregrp.com ([15.124.2.87]:55728 "EHLO
        m4a0041g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2504402AbfIXJ6t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 05:58:49 -0400
Received: FROM m4a0041g.houston.softwaregrp.com (15.120.17.146) BY m4a0041g.houston.softwaregrp.com WITH ESMTP
 FOR linux-btrfs@vger.kernel.org;
 Tue, 24 Sep 2019 09:56:54 +0000
Received: from M9W0067.microfocus.com (2002:f79:be::f79:be) by
 M4W0334.microfocus.com (2002:f78:1192::f78:1192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Tue, 24 Sep 2019 09:19:57 +0000
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (15.124.72.12) by
 M9W0067.microfocus.com (15.121.0.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Tue, 24 Sep 2019 09:19:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibEoJZSmT+Xp09I4YWr1TmzvI+kvj6OqJ/C/I4pPxRT5X+hSkkoGbTK5bzbEmXyDgVZDFqLs4dbHNOq06K2IU/eIkTWL81L8+Xfyjk3YcZq4gZ51CR7J9GIo/If3ISHwwNulDq8f0duqbfQiOUaE3XBYseaBjdP2M76Gftp1XcdPDNgBEKY0kkq160jvAewgKerVs8YlLCWC/7TWna+5X+OrSx3obbFcsy4OsIwZe1BoQbM23fWQobUen3Y2T6SZuUTKVhBktv7PwX4psxnLkdeHp1mkFORHFsn8XHDMY07k+nU72Bmoji677MWZXRWl07IjoJvZHt2AJfBEgqoiUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqFCiUZHRNaeVNuaCXFB9kClvlXvW3dnJXFxjvXfHLk=;
 b=V5HjMmGGE/aK9ZSdCG7hbs2xqmvNT0FNo6dRp3uMbCioS+enxUVjo4nbEt8KG5HXIk82tP2MhAXuK9xpGnd8+aBRfSCszB4QNEMaZxYWgDaKsLhvPnnomNRc+oXP41lsZsWY/cY2E3y4PzpCl3hgVUALE5Cv7fSnMPaFkpioqC/rEYA1uSWd04GOjy493aj/Hsw696jg3dlSQYdQsPjh6kZyb1F5/27GEi3Sg3zp8vjlrns8Wlxm/0Y1c3Mdsnr/vZOGK6ICM3yWJU1cR+kHeHEZqv0HU0KqYLVrlG6zKw3/+qo5y4qxHZEbY85q9RC3JR2HSrKxaHk2NjHWPKpAWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3218.namprd18.prod.outlook.com (10.255.137.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.19; Tue, 24 Sep 2019 09:19:55 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::3993:1f66:bd4:83cc]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::3993:1f66:bd4:83cc%5]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 09:19:55 +0000
From:   Qu WenRuo <wqu@suse.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 1/6] btrfs-progs: check: Export btrfs_type_to_imode
Thread-Topic: [PATCH v3 1/6] btrfs-progs: check: Export btrfs_type_to_imode
Thread-Index: AQHVcrP4OMjtwOUYMES2NZyGcLTcFKc6jQEA
Date:   Tue, 24 Sep 2019 09:19:55 +0000
Message-ID: <3d3cfcfb-d55b-a0fa-c182-a52c138c6b65@suse.com>
References: <20190912031135.79696-1-wqu@suse.com>
 <20190912031135.79696-2-wqu@suse.com>
 <8bce1985-0bd7-2476-8276-530ab08a00d6@suse.com>
In-Reply-To: <8bce1985-0bd7-2476-8276-530ab08a00d6@suse.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: TYAPR01CA0099.jpnprd01.prod.outlook.com
 (2603:1096:404:2a::15) To BY5PR18MB3266.namprd18.prod.outlook.com
 (2603:10b6:a03:1a1::15)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [13.231.109.76]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 338f3112-556c-479b-898c-08d740d05d0a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BY5PR18MB3218;
x-ms-traffictypediagnostic: BY5PR18MB3218:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR18MB32180D8D978864F1D9B3AAF9D6840@BY5PR18MB3218.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(39860400002)(376002)(346002)(366004)(136003)(189003)(199004)(36756003)(26005)(6436002)(14454004)(6506007)(446003)(99286004)(3846002)(76176011)(25786009)(386003)(52116002)(229853002)(478600001)(486006)(476003)(8936002)(2616005)(6486002)(102836004)(81166006)(81156014)(8676002)(11346002)(186003)(5660300002)(31686004)(2906002)(31696002)(110136005)(66476007)(66446008)(66556008)(316002)(6246003)(64756008)(2501003)(66946007)(305945005)(7736002)(256004)(86362001)(6512007)(71190400001)(71200400001)(6116002)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3218;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mJoj9mgfqm9hynjbmqpblSjqoIVgANU/qfEgVX7x1bB9XSvDJO4Ei0wxon4zVIh7wzhjnYal7sRln4jI08fYwAgcMgqLE46NgJav8RdhJEoFcKFtDjDtd9lYtSds17sJuOjx+q2yZpE/mVK9+qExMNAY9zelnABL5jNjjIIj30HLhKUD6qRwGUv5nlsk14xqeoWMWSpXD1n/1m1qsaqL5nzDXqd0HUKIpyIUCH0L/ZqrZ7/xvVLkET9dMwAU3jX9pUpV1tD1I4bvvXU0aAWljoa4nZKzR2/3MYziWEwK5irGODYQghRiGbhDydvkDxk3W0dAF0AMjL6U0HiohSuSxpDL1PAZ4kXaWCYWAODwaDzfUcNmZax3Lt8jo4i7Pfiizj7m9pKXvt6XiWGHeNxsSkP3vzi3Ohl7y+iR/7AqXRg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D40B6CFB4BAEB54A8AA0DFCF8EEEBE3C@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 338f3112-556c-479b-898c-08d740d05d0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 09:19:55.6630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mDE46CKWAivV2Oz3PLy2fiOetttTS7Vh++ZTJspU4nUP1xXSIjMR9eckAytoIKej
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3218
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQoNCk9uIDIwMTkvOS8yNCDkuIvljYg0OjQxLCBOaWtvbGF5IEJvcmlzb3Ygd3JvdGU6DQo+IA0K
PiANCj4gT24gMTIuMDkuMTkg0LMuIDY6MTEg0YcuLCBRdSBXZW5ydW8gd3JvdGU6DQo+PiBUaGlz
IGZ1bmN0aW9uIHdpbGwgYmUgbGF0ZXIgdXNlZCBieSBjb21tb24gbW9kZSBjb2RlLCBzbyBleHBv
cnQgaXQuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogUXUgV2VucnVvIDx3cXVAc3VzZS5jb20+DQo+
IA0KPiBSZXZpZXdlZC1ieTogTmlrb2xheSBCb3Jpc292IDxuYm9yaXNvdkBzdXNlLmNvbT4gYnV0
IHNlZSBvbmUgbml0IGJlbG93Lg0KPiANCj4+IC0tLQ0KPj4gIGNoZWNrL21haW4uYyAgICAgICAg
fCAxNSAtLS0tLS0tLS0tLS0tLS0NCj4+ICBjaGVjay9tb2RlLWNvbW1vbi5oIHwgMTUgKysrKysr
KysrKysrKysrDQo+PiAgMiBmaWxlcyBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCAxNSBkZWxl
dGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvY2hlY2svbWFpbi5jIGIvY2hlY2svbWFpbi5j
DQo+PiBpbmRleCAyZTE2YjRlNmYwNWIuLjkwMjI3OTc0MDU4OSAxMDA2NDQNCj4+IC0tLSBhL2No
ZWNrL21haW4uYw0KPj4gKysrIGIvY2hlY2svbWFpbi5jDQo+PiBAQCAtMjQ0OCwyMSArMjQ0OCw2
IEBAIG91dDoNCj4+ICAJcmV0dXJuIHJldDsNCj4+ICB9DQo+PiAgDQo+PiAtc3RhdGljIHUzMiBi
dHJmc190eXBlX3RvX2ltb2RlKHU4IHR5cGUpDQo+PiAtew0KPj4gLQlzdGF0aWMgdTMyIGltb2Rl
X2J5X2J0cmZzX3R5cGVbXSA9IHsNCj4+IC0JCVtCVFJGU19GVF9SRUdfRklMRV0JPSBTX0lGUkVH
LA0KPj4gLQkJW0JUUkZTX0ZUX0RJUl0JCT0gU19JRkRJUiwNCj4+IC0JCVtCVFJGU19GVF9DSFJE
RVZdCT0gU19JRkNIUiwNCj4+IC0JCVtCVFJGU19GVF9CTEtERVZdCT0gU19JRkJMSywNCj4+IC0J
CVtCVFJGU19GVF9GSUZPXQkJPSBTX0lGSUZPLA0KPj4gLQkJW0JUUkZTX0ZUX1NPQ0tdCQk9IFNf
SUZTT0NLLA0KPj4gLQkJW0JUUkZTX0ZUX1NZTUxJTktdCT0gU19JRkxOSywNCj4+IC0JfTsNCj4+
IC0NCj4+IC0JcmV0dXJuIGltb2RlX2J5X2J0cmZzX3R5cGVbKHR5cGUpXTsNCj4+IC19DQo+PiAt
DQo+PiAgc3RhdGljIGludCByZXBhaXJfaW5vZGVfbm9faXRlbShzdHJ1Y3QgYnRyZnNfdHJhbnNf
aGFuZGxlICp0cmFucywNCj4+ICAJCQkJc3RydWN0IGJ0cmZzX3Jvb3QgKnJvb3QsDQo+PiAgCQkJ
CXN0cnVjdCBidHJmc19wYXRoICpwYXRoLA0KPj4gZGlmZiAtLWdpdCBhL2NoZWNrL21vZGUtY29t
bW9uLmggYi9jaGVjay9tb2RlLWNvbW1vbi5oDQo+PiBpbmRleCAxNjFiODRhOGRlYjAuLjZjOGQ2
ZDc1NzhhNiAxMDA2NDQNCj4+IC0tLSBhL2NoZWNrL21vZGUtY29tbW9uLmgNCj4+ICsrKyBiL2No
ZWNrL21vZGUtY29tbW9uLmgNCj4+IEBAIC0xNTYsNCArMTU2LDE5IEBAIHN0YXRpYyBpbmxpbmUg
Ym9vbCBpc192YWxpZF9pbW9kZSh1MzIgaW1vZGUpDQo+PiAgfQ0KPj4gIA0KPj4gIGludCByZWNv
d19leHRlbnRfYnVmZmVyKHN0cnVjdCBidHJmc19yb290ICpyb290LCBzdHJ1Y3QgZXh0ZW50X2J1
ZmZlciAqZWIpOw0KPj4gKw0KPj4gK3N0YXRpYyBpbmxpbmUgdTMyIGJ0cmZzX3R5cGVfdG9faW1v
ZGUodTggdHlwZSkNCj4+ICt7DQo+PiArCXN0YXRpYyB1MzIgaW1vZGVfYnlfYnRyZnNfdHlwZVtd
ID0gew0KPj4gKwkJW0JUUkZTX0ZUX1JFR19GSUxFXQk9IFNfSUZSRUcsDQo+PiArCQlbQlRSRlNf
RlRfRElSXQkJPSBTX0lGRElSLA0KPj4gKwkJW0JUUkZTX0ZUX0NIUkRFVl0JPSBTX0lGQ0hSLA0K
Pj4gKwkJW0JUUkZTX0ZUX0JMS0RFVl0JPSBTX0lGQkxLLA0KPj4gKwkJW0JUUkZTX0ZUX0ZJRk9d
CQk9IFNfSUZJRk8sDQo+PiArCQlbQlRSRlNfRlRfU09DS10JCT0gU19JRlNPQ0ssDQo+PiArCQlb
QlRSRlNfRlRfU1lNTElOS10JPSBTX0lGTE5LLA0KPj4gKwl9Ow0KPiANCj4gbml0OiBJZiB0aGUg
YXJyYXkgaXMgZGVmaW5lZCBpbiBhIGZ1bmN0aW9uIGluIGEgaGVhZGVyIHRoaXMgbWVhbnMgaXQN
Cj4gd2lsbCBiZSBjb3BpZWQgdG8gZXZlcnkgb2JqZWN0IGZpbGUgdGhpcyBoZWFkZXIgaXMgaW5j
bHVkZWQgc28gaXQgd2lsbA0KPiByZXN1bHQgaW4gYSBtaW5vciBibG9hdCBvZiBzaXplLiBJdCBt
aWdodCBiZXR0ZXIgdG8gaGF2ZSBpdCBkZWZpbmVkIGluDQo+IGNoZWNrL21haW4uYyBhbmQgaGF2
ZSBpdCBkZWNsYXJlZCBleHRlcm4gaW4gbW9kZS1jb21tb24uaA0KDQpJJ20gd29uZGVyaW5nIHdo
YXQgaGFwcGVucyBpbiB0aGUgZmluYWwgYmluYXJ5Lg0KDQpJSVJDIHRoZXJlIHNob3VsZCBiZSBv
bmx5IG9uZSBjb3B5IG9mIHRoZSBzdGF0aWMgY29uc3QgYXJyYXkgaW4gLmRhdGENCnNlZ21lbnQu
DQoNClNvIHRoYXQgc2hvdWxkIGJlIG1vc3RseSBPSyBJIGd1ZXNzPw0KDQpUaGFua3MsDQpRdQ0K
DQo+IA0KPj4gKw0KPj4gKwlyZXR1cm4gaW1vZGVfYnlfYnRyZnNfdHlwZVsodHlwZSldOw0KPj4g
K30NCj4+ICAjZW5kaWYNCj4+DQo=
