Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 345AB6459F
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jul 2019 13:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfGJLKx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Jul 2019 07:10:53 -0400
Received: from m4a0040g.houston.softwaregrp.com ([15.124.2.86]:45955 "EHLO
        m4a0040g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726043AbfGJLKx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Jul 2019 07:10:53 -0400
Received: FROM m4a0040g.houston.softwaregrp.com (15.120.17.147) BY m4a0040g.houston.softwaregrp.com WITH ESMTP
 FOR linux-btrfs@vger.kernel.org;
 Wed, 10 Jul 2019 11:10:23 +0000
Received: from M4W0335.microfocus.com (2002:f78:1193::f78:1193) by
 M4W0335.microfocus.com (2002:f78:1193::f78:1193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Wed, 10 Jul 2019 10:58:41 +0000
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (15.124.8.10) by
 M4W0335.microfocus.com (15.120.17.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Wed, 10 Jul 2019 10:58:41 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3379.namprd18.prod.outlook.com (10.255.136.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.21; Wed, 10 Jul 2019 10:58:40 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::45a9:4750:5868:9bbe]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::45a9:4750:5868:9bbe%5]) with mapi id 15.20.2052.020; Wed, 10 Jul 2019
 10:58:40 +0000
From:   WenRuo Qu <wqu@suse.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/5] btrfs: extent_io: Do extra check for extent buffer
 read write functions
Thread-Topic: [PATCH 1/5] btrfs: extent_io: Do extra check for extent buffer
 read write functions
Thread-Index: AQHVNww6B8OkBdNtK0igaXZiPs3BcqbDrrKA
Date:   Wed, 10 Jul 2019 10:58:40 +0000
Message-ID: <47b88874-6cef-4eb2-74d8-5a1f51efa99d@suse.com>
References: <20190710080243.15988-1-wqu@suse.com>
 <20190710080243.15988-2-wqu@suse.com>
 <0c6525ff-63f5-6342-4c6c-2e229d0e98b2@suse.com>
In-Reply-To: <0c6525ff-63f5-6342-4c6c-2e229d0e98b2@suse.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0033.apcprd03.prod.outlook.com
 (2603:1096:203:2f::21) To BY5PR18MB3266.namprd18.prod.outlook.com
 (2603:10b6:a03:1a1::15)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [240e:3a1:c40:c630::cac]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 94dd8d28-b508-4b2b-5125-08d7052590e6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BY5PR18MB3379;
x-ms-traffictypediagnostic: BY5PR18MB3379:
x-microsoft-antispam-prvs: <BY5PR18MB337963E1C2F96CA796A5D178D6F00@BY5PR18MB3379.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0094E3478A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(52314003)(189003)(199004)(386003)(6506007)(31686004)(99286004)(31696002)(2501003)(11346002)(110136005)(476003)(316002)(256004)(14444005)(86362001)(25786009)(486006)(2616005)(76176011)(53936002)(478600001)(6246003)(186003)(6512007)(5660300002)(66946007)(2906002)(66476007)(229853002)(52116002)(46003)(66556008)(64756008)(66446008)(6116002)(36756003)(6486002)(8936002)(8676002)(81166006)(81156014)(14454004)(446003)(7736002)(305945005)(71190400001)(71200400001)(102836004)(68736007)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3379;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hUQ/k02JmDCb99/9gUijHQk4/qKRkg4mga4eGQqut+6ns/IrsGEeM0+SZR6o1DGebTvHVv5LU90octFRHV4rQcK0g1+pq0MTVNGEiUSl4QhI8XfAySbWhsf/4wmhMoFE4d0mob9MJYsVs5Ae4O+G8cxHcd1dGWlz8wsBaDB+GnR1InCD6WvuVWOQFRRVCplSOfdrO2nQO+Xop8AYYlUGK9DfDpXLlgY5vmGC+++w2we4SIKHzRC5S64LOgXBdN237CVJaW6LsbgkgHi+FlKzZSvnx+XnQsmj+dk0gryTfIGuRE8yJ0NJ3rVq/ol/jQ7Pl3tqUoWrCBGiJJDn2ARwCIa3KJRCk8GavQzQfbaB/y9atO72gzNipI6zjfzJkCKfAcxXn9UVKNhmaL/u+LBC2cnyz5W1C771N4tWRKIJbJM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ABAAA88FAE7F7B41A76A054C50379D21@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 94dd8d28-b508-4b2b-5125-08d7052590e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2019 10:58:40.4593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wqu@suse.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3379
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQoNCk9uIDIwMTkvNy8xMCDkuIvljYg2OjQyLCBOaWtvbGF5IEJvcmlzb3Ygd3JvdGU6DQo+IA0K
PiANClsuLi5dDQo+PiAgDQo+PiArLyoNCj4+ICsgKiBDaGVjayBpZiB0aGUgW3N0YXJ0LCBzdGFy
dCArIGxlbikgcmFuZ2UgaXMgdmFsaWQgYmVmb3JlIHJlYWRpbmcvd3JpdGluZw0KPj4gKyAqIHRo
ZSBlYi4NCj4+ICsgKg0KPj4gKyAqIENhbGxlciBzaG91bGQgbm90IHRvdWNoIHRoZSBkc3Qvc3Jj
IG1lbW9yeSBpZiB0aGlzIGZ1bmN0aW9uIHJldHVybnMgZXJyb3IuDQo+PiArICovDQo+PiArc3Rh
dGljIGludCBjaGVja19lYl9yYW5nZShjb25zdCBzdHJ1Y3QgZXh0ZW50X2J1ZmZlciAqZWIsIHVu
c2lnbmVkIGxvbmcgc3RhcnQsDQo+PiArCQkJICB1bnNpZ25lZCBsb25nIGxlbikNCj4+ICt7DQo+
PiArCXVuc2lnbmVkIGxvbmcgZW5kOw0KPj4gKw0KPj4gKwkvKiBzdGFydCwgc3RhcnQgKyBsZW4g
c2hvdWxkIG5vdCBnbyBiZXlvbmQgZWItPmxlbiBub3Igb3ZlcmZsb3cgKi8NCj4+ICsJaWYgKHVu
bGlrZWx5KHN0YXJ0ID4gZWItPmxlbiB8fCBzdGFydCArIGxlbiA+IGViLT5sZW4gfHwNCj4gDQo+
IEkgdGhpbmsgeW91ciBjaGVjayBoZXJlIGlzIHdyb25nLCBpdCBzaG91bGQgYmUgc3RhcnQgKyBs
ZW4gPiBzdGFydCArDQo+IGViLT5sZW4uIHN0YXJ0IGlzIHRoZSBsb2dpY2FsIGFkZHJlc3MgaGVu
Y2UgaXQgY2FuIGJlIGEgbG90IGJpZ2dlciB0aGFuDQo+IHRoZSBzaXplIG9mIHRoZSBlYiB3aGlj
aCBpcyAxNmsgYnkgZGVmYXVsdC4NCg0KRGVmaW5pdGVseSBOTy4NCg0KW3N0YXJ0LCBzdGFydCAr
IGxlbikgbXVzdCBiZSBpbiB0aGUgcmFuZ2Ugb2YgWzAsIG5vZGVzaXplKS4NClNvIHRoaW5rIGFn
YWluLg0KDQo+IA0KPj4gKwkJICAgICBjaGVja19hZGRfb3ZlcmZsb3coc3RhcnQsIGxlbiwgJmVu
ZCkpKSB7DQo+PiArCQlXQVJOKElTX0VOQUJMRUQoQ09ORklHX0JUUkZTX0RFQlVHKSwgS0VSTl9F
UlINCj4+ICsiYnRyZnM6IGJhZCBlYiBydyByZXF1ZXN0LCBlYiBieXRlbnI9JWxsdSBsZW49JWx1
IHJ3IHN0YXJ0PSVsdSBsZW49JWx1XG4iLA0KPj4gKwkJICAgICBlYi0+c3RhcnQsIGViLT5sZW4s
IHN0YXJ0LCBsZW4pOw0KPj4gKwkJYnRyZnNfd2FybihlYi0+ZnNfaW5mbywNCj4+ICsiYnRyZnM6
IGJhZCBlYiBydyByZXF1ZXN0LCBlYiBieXRlbnI9JWxsdSBsZW49JWx1IHJ3IHN0YXJ0PSVsdSBs
ZW49JWx1XG4iLA0KPj4gKwkJCSAgIGViLT5zdGFydCwgZWItPmxlbiwgc3RhcnQsIGxlbik7DQo+
IA0KPiBJZiBDT05GSUdfQlRSRlNfREVCVUcgaXMgZW5hYmxlZCB0aGVuIHdlIHdpbGwgcHJpbnQg
dGhlIHdhcm5pbmcgdGV4dA0KPiB0d2ljZS4gU2ltcGx5IG1ha2UgIGl0Og0KPiANCj4gV0FSTl9P
TihJU19FTkFCTEVEKCkpIGFuZCBsZWF2ZSB0aGUgYnRyZnNfV2FybiB0byBhbHdheXMgcHJpbnQg
dGhlIHRleHQuDQoNCldBUk5fT04oKSBkb2Vzbid0IGNvbnRhaW4gYW55IHRleHQgdG8gaW5kaWNh
dGUgdGhlIHJlYXNvbiBvZiB0aGUgc3RhY2sgZHVtcC4NClRodXMgSSBzdGlsbCBwcmVmZXIgdG8g
c2hvdyBleGFjdCB0aGUgcmVhc29uIG90aGVyIHRoYW4gdGFrZXMgZGV2ZWxvcGVyDQpzZXZlcmFs
IHNlY29uZHMgdG8gY29tYmluZSB0aGUgc3RhY2sgd2l0aCB0aGUgZm9sbG93aW5nIGJ0cmZzX3dh
cm4oKQ0KbWVzc2FnZS4NCg0KQW55d2F5LCBpdCdzIG5vdCBzb21ldGhpbmcgeW91J2xsIHNlZSBl
dmVuIGluIG1vbnRocywgdGh1cyBJIGRvbid0DQpyZWFsbHkgdGhpbmsgaXQgd291bGQgY2F1c2Ug
YW55IGRpZmZlcmVuY2UuDQoNClRoYW5rcywNClF1DQo=
