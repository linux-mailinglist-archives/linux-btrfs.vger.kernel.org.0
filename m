Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3B3283D8A
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Aug 2019 00:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfHFWsZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Aug 2019 18:48:25 -0400
Received: from m9a0001g.houston.softwaregrp.com ([15.124.64.66]:39669 "EHLO
        m9a0001g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726044AbfHFWsZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 6 Aug 2019 18:48:25 -0400
Received: FROM m9a0001g.houston.softwaregrp.com (15.121.0.190) BY m9a0001g.houston.softwaregrp.com WITH ESMTP
 FOR linux-btrfs@vger.kernel.org;
 Tue,  6 Aug 2019 22:48:14 +0000
Received: from M4W0335.microfocus.com (2002:f78:1193::f78:1193) by
 M9W0067.microfocus.com (2002:f79:be::f79:be) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Tue, 6 Aug 2019 22:47:53 +0000
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (15.124.8.13) by
 M4W0335.microfocus.com (15.120.17.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Tue, 6 Aug 2019 22:47:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ro/M3XW/YsFrM8qtmpkmTZxQwAYkGyFPJsXXdZhnMIRVHR8UXEZIgl/bji7lEy35abJpZIyVQxPo+JmuUfFUqKB44rNaZv4eGThdzJy44PIHJK2EfVD9ziGDwpkH1DbF8dkrZEn8Nn/YHH6WVT5OPnUNPKZvlMALEpZL9TEEHgoATk0FHXshMgvGZHjfWPZR4eWigipK2UjjwcfGHUp3RVBC3At4QvQVip2/DPD7sOmbEOIysCfVlcP5ozsOuzCg1z0EvYNByy+1RHEUFh+TwSexY2hhPS6evmu1xLSsohzmd6DfWlRK/kB8YNNbadx/aRNJRFXKIU3Aih80xL468w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xu46FZDgXOr+zeGGpfXdyMRgqm9qz3KplBt36OypqKA=;
 b=AQxN7jC+Lir2pR2TPzG8pdhjG5o/5lmJomBv8XCrUamjNx0p4LjWHVS+K0BHK/7UDDrWc49FR5I1E/2klPVJaS5Add4lD1U//CFtFXi+UPJQUlzRP57spaY/yNFzQlRda7f29fSA9Qu8mErOiXHcka/O/IreEcmlwYRw2g8g8I1Q6b2CxBnMbribJ89gz6rUm6sCv/mI37pzaRRnx+7b09Te7v6EXgrlLEMCdvucb8oZ4GAYsvUEbt4b33G2upbXV4J28Wzwzxtkqs2vloAE0VmyYHWe1c+3GkZa+hVCTDo/jvsQxGaKfgChBoJ8jjMElLEmNIYdjCD9grRQxMSjDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3363.namprd18.prod.outlook.com (10.255.139.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.14; Tue, 6 Aug 2019 22:47:52 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::e94d:d625:c907:d8a0]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::e94d:d625:c907:d8a0%4]) with mapi id 15.20.2157.011; Tue, 6 Aug 2019
 22:47:52 +0000
From:   WenRuo Qu <wqu@suse.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: transaction: Commit transaction more frequently
 for BPF
Thread-Topic: [PATCH] btrfs: transaction: Commit transaction more frequently
 for BPF
Thread-Index: AQHVTGrzEtc3c1UWiUyycIcN1ab4i6buuQ2A
Date:   Tue, 6 Aug 2019 22:47:51 +0000
Message-ID: <7a1d90b0-968f-33b4-79ff-4cb155e93ef4@suse.com>
References: <20190806082201.22683-1-wqu@suse.com>
 <94e81fef-1dff-28e7-0d2d-a366ccdbe8c8@suse.com>
In-Reply-To: <94e81fef-1dff-28e7-0d2d-a366ccdbe8c8@suse.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: TYCPR01CA0113.jpnprd01.prod.outlook.com
 (2603:1096:405:4::29) To BY5PR18MB3266.namprd18.prod.outlook.com
 (2603:10b6:a03:1a1::15)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [54.250.245.166]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dad25be1-278d-4c5f-5dd7-08d71ac01cd2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BY5PR18MB3363;
x-ms-traffictypediagnostic: BY5PR18MB3363:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR18MB33631A412DB43561BDC56A19D6D50@BY5PR18MB3363.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0121F24F22
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(376002)(396003)(346002)(39860400002)(136003)(199004)(189003)(66446008)(7736002)(64756008)(186003)(6506007)(52116002)(305945005)(76176011)(31686004)(14454004)(55236004)(102836004)(478600001)(36756003)(99286004)(386003)(66556008)(446003)(486006)(316002)(11346002)(476003)(2906002)(110136005)(2616005)(256004)(26005)(66946007)(14444005)(66476007)(8936002)(3846002)(2501003)(8676002)(6116002)(5660300002)(53936002)(229853002)(86362001)(71200400001)(71190400001)(6246003)(81166006)(81156014)(68736007)(31696002)(6512007)(25786009)(6436002)(6486002)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3363;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: weYSN8VzpDs+jj1PDK+vMKdQILRlNWflZaoSVEcyqiLbEivY8giGSX4QkFkQ/U+isZ91kTEztHMLwyapBTDgoIQHvjL9UJzChYSFW1UfJvkRUCH109fdTRFvP3hCLTp/Tps63ZCpx4tJAOpl82CgZVnjLgAwQVLtdcZRGG8mM5bcLKaMlwSsEkdS8hVJwv2d60UZNTdUaGUnlp7Zprr2Sqd/LXh/2dqI3LyciK7hULBPcFITeJS/NJ7QXpzGUcznPbc1Qs6Yu6s62g2e6BJnAiLRJy32eNiyFkc1X/od2TypQw22TWhpAAkqZYm6vZPD9dglb/sq7wGl178NiPCMCZiOZxMwD32TswSolg81laQMmAoQjP8yxbiL6JGSzRFRf4waasZrvF59Nzyx9AcsX7fmcBGlF6lfCiAcIB47H0g=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D6C740B3F79114CB9C5D062E01EC2F4@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: dad25be1-278d-4c5f-5dd7-08d71ac01cd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2019 22:47:51.7845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8QV9Gj/zhX0UmrqD1v8UBaCvAW32xO/fIU8r+EiCYHOrWP0T9owc9wNJJqulB4gT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3363
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQoNCk9uIDIwMTkvOC82IOS4i+WNiDExOjIzLCBOaWtvbGF5IEJvcmlzb3Ygd3JvdGU6DQo+IA0K
PiANCj4gT24gNi4wOC4xOSDQsy4gMTE6MjIg0YcuLCBRdSBXZW5ydW8gd3JvdGU6DQo+PiBCdHJm
cyBoYXMgYnRyZnNfZW5kX3RyYW5zYWN0aW9uX3Rocm90dGxlKCkgd2hpY2ggY291bGQgdHJ5IHRv
IGNvbW1pdA0KPj4gdHJhbnNhY3Rpb24gd2hlbiBuZWVkZWQuDQo+Pg0KPj4gSG93ZXZlciB1bmRl
ciBtb3N0IGNhc2VzIGJ0cmZzX2VuZF90cmFuc2FjdGlvbl90aHJvdHRsZSgpIHdvbid0IHJlYWxs
eQ0KPj4gY29tbWl0IHRyYW5zYWN0aW9uLCBkdWUgdG8gdGhlIGhhcmQgdGltaW5nIHJlcXVpcmVt
ZW50Lg0KPj4NCj4+IE5vdyBpbnRyb2R1Y2UgYSBuZXcgZXJyb3IgaW5qZWN0aW9uIHBvaW50LCBi
dHJmc19uZWVkX3RyYW5zX3ByZXNzdXJlKCksDQo+PiB0byBhbGxvdyBidHJmc19zaG91bGRfZW5k
X3RyYW5zYWN0aW9uKCkgdG8gcmV0dXJuIDEgYW5kDQo+PiBidHJmc19lbmRfdHJhbnNhY3Rpb25f
dGhyb3R0bGUoKSB0byBmYWxsYmFjayB0bw0KPj4gYnRyZnNfY29tbWl0X3RyYW5zYWN0aW9uKCku
DQo+Pg0KPj4gV2l0aCBzdWNoIG1vcmUgYWdncmVzc2l2ZSB0cmFuc2FjdGlvbiBjb21taXQsIHdl
IGNhbiBkaWcgZGVlcGVyIGludG8NCj4+IGNhc2VzIGxpa2Ugc25hcHNob3QgZHJvcC4NCj4+IE5v
dyBlYWNoIHJlZmVyZW5jZSBkcm9wIG9mIGJ0cmZzX2Ryb3Bfc25hcHNob3QoKSB3aWxsIGxlYWQg
dG8gYQ0KPj4gdHJhbnNhY3Rpb24gY29tbWl0LCBhbGxvd2luZyBkbS1sb2d3cml0ZXMgdG8gY2F0
Y2ggbW9yZSBkZXRhaWxzLCBvdGhlcg0KPj4gdGhhbiBvbmUgYmlnIHRyYW5zYWN0aW9uIGRyb3Bw
aW5nIGV2ZXJ5dGhpbmcuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogUXUgV2VucnVvIDx3cXVAc3Vz
ZS5jb20+DQo+PiAtLS0NCj4+ICBmcy9idHJmcy90cmFuc2FjdGlvbi5jIHwgMTEgKysrKysrKysr
KysNCj4+ICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1n
aXQgYS9mcy9idHJmcy90cmFuc2FjdGlvbi5jIGIvZnMvYnRyZnMvdHJhbnNhY3Rpb24uYw0KPj4g
aW5kZXggMjQ4ZDUzNWJiMTRkLi4yZTc1ODk1NzEyNmUgMTAwNjQ0DQo+PiAtLS0gYS9mcy9idHJm
cy90cmFuc2FjdGlvbi5jDQo+PiArKysgYi9mcy9idHJmcy90cmFuc2FjdGlvbi5jDQo+PiBAQCAt
MTAsNiArMTAsNyBAQA0KPj4gICNpbmNsdWRlIDxsaW51eC9wYWdlbWFwLmg+DQo+PiAgI2luY2x1
ZGUgPGxpbnV4L2Jsa2Rldi5oPg0KPj4gICNpbmNsdWRlIDxsaW51eC91dWlkLmg+DQo+PiArI2lu
Y2x1ZGUgPGxpbnV4L2Vycm9yLWluamVjdGlvbi5oPg0KPj4gICNpbmNsdWRlICJjdHJlZS5oIg0K
Pj4gICNpbmNsdWRlICJkaXNrLWlvLmgiDQo+PiAgI2luY2x1ZGUgInRyYW5zYWN0aW9uLmgiDQo+
PiBAQCAtNzgxLDEwICs3ODIsMTggQEAgdm9pZCBidHJmc190aHJvdHRsZShzdHJ1Y3QgYnRyZnNf
ZnNfaW5mbyAqZnNfaW5mbykNCj4+ICAJd2FpdF9jdXJyZW50X3RyYW5zKGZzX2luZm8pOw0KPj4g
IH0NCj4+ICANCj4+ICtzdGF0aWMgbm9pbmxpbmUgYm9vbCBidHJmc19uZWVkX3RyYW5zX3ByZXNz
dXJlKHN0cnVjdCBidHJmc190cmFuc19oYW5kbGUgKnRyYW5zKQ0KPj4gK3sNCj4+ICsJcmV0dXJu
IGZhbHNlOw0KPj4gK30NCj4+ICtBTExPV19FUlJPUl9JTkpFQ1RJT04oYnRyZnNfbmVlZF90cmFu
c19wcmVzc3VyZSwgVFJVRSk7DQo+PiArDQo+PiAgc3RhdGljIGludCBzaG91bGRfZW5kX3RyYW5z
YWN0aW9uKHN0cnVjdCBidHJmc190cmFuc19oYW5kbGUgKnRyYW5zKQ0KPj4gIHsNCj4+ICAJc3Ry
dWN0IGJ0cmZzX2ZzX2luZm8gKmZzX2luZm8gPSB0cmFucy0+ZnNfaW5mbzsNCj4+ICANCj4+ICsJ
aWYgKGJ0cmZzX25lZWRfdHJhbnNfcHJlc3N1cmUodHJhbnMpKQ0KPj4gKwkJcmV0dXJuIDE7DQo+
PiAgCWlmIChidHJmc19jaGVja19zcGFjZV9mb3JfZGVsYXllZF9yZWZzKGZzX2luZm8pKQ0KPj4g
IAkJcmV0dXJuIDE7DQo+PiAgDQo+PiBAQCAtODQ1LDYgKzg1NCw4IEBAIHN0YXRpYyBpbnQgX19i
dHJmc19lbmRfdHJhbnNhY3Rpb24oc3RydWN0IGJ0cmZzX3RyYW5zX2hhbmRsZSAqdHJhbnMsDQo+
PiAgDQo+PiAgCWJ0cmZzX3RyYW5zX3JlbGVhc2VfY2h1bmtfbWV0YWRhdGEodHJhbnMpOw0KPj4g
IA0KPj4gKwlpZiAodGhyb3R0bGUgJiYgYnRyZnNfbmVlZF90cmFuc19wcmVzc3VyZSh0cmFucykp
DQo+PiArCQlyZXR1cm4gYnRyZnNfY29tbWl0X3RyYW5zYWN0aW9uKHRyYW5zKTsNCj4gDQo+IEkn
ZCByYXRoZXIgaGF2ZSB0aGlzIGdhdGVkIGJlaGluZCBDT05GSUdfQlRSRlNfREVCVUcuDQoNClRo
ZW4gd2UgbmVlZCBib3RoIENPTkZJR19CVFJGU19ERUJVRyBhbmQgQ09ORklHX0JQRl9LUFJPQkVf
T1ZFUlJJREUgdG8NCmVuYWJsZSB0aGlzIGZlYXR1cmUuDQoNCkFuZCBmb3IgQ09ORklHX0JUUkZT
X0RFQlVHIG5vdCBlbmFibGVkIGNhc2UsIHRoYXQgZnVuY3Rpb24gd291bGQgbm90IGJlDQp1c2Vk
IGF0IGFsbCAoaWYgeW91IGFsc28gZ2F0ZSB0aGUgb25lIGluIHNob3VsZF9lbmRfdHJhbnNhY3Rp
b24oKSkuDQoNCk5vdCBzdXJlIGlmIGV4dHJhIGhhc3NsZSBpcyByZWFsbHkgd29ydGh5IGZvciBz
dWNoIGEgc2ltcGxlIGRlYnVnIGZlYXR1cmUuDQoNClRoYW5rcywNClF1DQo+IA0KPiANCj4+ICAJ
aWYgKGxvY2sgJiYgUkVBRF9PTkNFKGN1cl90cmFucy0+c3RhdGUpID09IFRSQU5TX1NUQVRFX0JM
T0NLRUQpIHsNCj4+ICAJCWlmICh0aHJvdHRsZSkNCj4+ICAJCQlyZXR1cm4gYnRyZnNfY29tbWl0
X3RyYW5zYWN0aW9uKHRyYW5zKTsNCj4+DQo=
