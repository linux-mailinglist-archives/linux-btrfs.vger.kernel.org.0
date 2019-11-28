Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1FCA10C7C6
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Nov 2019 12:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfK1LLp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Nov 2019 06:11:45 -0500
Received: from m4a0041g.houston.softwaregrp.com ([15.124.2.87]:52171 "EHLO
        m4a0041g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726545AbfK1LLp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Nov 2019 06:11:45 -0500
Received: FROM m4a0041g.houston.softwaregrp.com (15.120.17.147) BY m4a0041g.houston.softwaregrp.com WITH ESMTP;
 Thu, 28 Nov 2019 11:08:59 +0000
Received: from M4W0334.microfocus.com (2002:f78:1192::f78:1192) by
 M4W0335.microfocus.com (2002:f78:1193::f78:1193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Thu, 28 Nov 2019 10:58:45 +0000
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (15.124.8.11) by
 M4W0334.microfocus.com (15.120.17.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Thu, 28 Nov 2019 10:58:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gc5ialzvif9sXWiGuz8NsOadjJ3opSwQwikMiNUB/OJ8z1A1Eclttzvnojy0+xnm3G9HKbux64WkI0xE04RVqzYemoZSnefzBIvF5QPrnd+96yWGOluIHRK5nOJpVD/zonFgox8nPG6jE+x+KiJZ60mCbab4gd4VtkX5QnEphpKAgrQvmJH7iQn9HsrwaYI/QMM06svSx3lhc6i4jrrxxMIKEdd3B1SOH//wisUFYYuRXO/NghA/lPZZ5MvvRCD9aAKlfTwjKV7FrzQj9N24FOwZcOg50AqgMh2T8A82TnIC2YG5/cd2GKvgLeVlIn3z24JuuBf2GNyuiI/Hl3rA6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sb2qYy+8OkU2awg8vjhq1Z59bjWuByGX6mjUgt33wIY=;
 b=j1nSdGE1LL27oAY8h3a8k5p+z/H8TYmgN1x+1Z1N69AzDDZi5XcnylUOYoMZrdRpv3rnZC/LtgofBpWZ/oUgISsadrFQOqNR7HcDA6YngHcNcut8GnAIZD9uJSCrtSgfXF0KhghQzyPSRL8Of1zbxEstkqjRplTEHqE6QHm3uQn1wxzhcaMv0+6NIHeNIWH79xvI8egMwA/DG16s7fz2wjmJB8d5NxzbFvAA3Q4/CieGh0iThbaj270y96GNV3woyRQ9Ifw4FSylBmAFXHlTPpVGhGpcjIm88PZ8hqb35PK0Z54+xNWKFfH5w8yfmTQVrMTBZpeQL0fso/P6c0wXOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from DM6PR18MB3274.namprd18.prod.outlook.com (10.255.173.147) by
 DM6PR18MB3337.namprd18.prod.outlook.com (10.255.172.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Thu, 28 Nov 2019 10:58:44 +0000
Received: from DM6PR18MB3274.namprd18.prod.outlook.com
 ([fe80::ac64:ba52:22b9:a6be]) by DM6PR18MB3274.namprd18.prod.outlook.com
 ([fe80::ac64:ba52:22b9:a6be%5]) with mapi id 15.20.2495.014; Thu, 28 Nov 2019
 10:58:44 +0000
From:   Qu WenRuo <wqu@suse.com>
To:     Su Yue <Damenly_Su@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: relocation: Output current relocation stage at
 btrfs_relocate_block_group()
Thread-Topic: [PATCH] btrfs: relocation: Output current relocation stage at
 btrfs_relocate_block_group()
Thread-Index: AQHVpdnqGOQW4mrQGUij+xQzs59eWqegadwA
Date:   Thu, 28 Nov 2019 10:58:44 +0000
Message-ID: <683017c9-f4c8-a6f5-ed92-d9a400e6e552@suse.com>
References: <20191128075437.10621-1-wqu@suse.com>
 <6dbfa97a-837f-7596-1813-04cbfb84167d@gmx.com>
In-Reply-To: <6dbfa97a-837f-7596-1813-04cbfb84167d@gmx.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: TY1PR01CA0186.jpnprd01.prod.outlook.com (2603:1096:403::16)
 To DM6PR18MB3274.namprd18.prod.outlook.com (2603:10b6:5:1c7::19)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [13.231.109.76]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c21fcb69-8757-44ce-7535-08d773f1efc0
x-ms-traffictypediagnostic: DM6PR18MB3337:
x-microsoft-antispam-prvs: <DM6PR18MB333779EDD220433BEA2991E9D6470@DM6PR18MB3337.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0235CBE7D0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(376002)(396003)(39860400002)(346002)(136003)(199004)(189003)(71200400001)(99286004)(256004)(6246003)(478600001)(14454004)(52116002)(76176011)(36756003)(14444005)(5660300002)(110136005)(53546011)(102836004)(11346002)(2616005)(446003)(316002)(386003)(6506007)(26005)(186003)(25786009)(2501003)(31686004)(3846002)(8676002)(2906002)(81166006)(86362001)(81156014)(31696002)(66446008)(64756008)(66556008)(66476007)(66066001)(6512007)(229853002)(305945005)(66946007)(6436002)(8936002)(7736002)(71190400001)(6116002)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR18MB3337;H:DM6PR18MB3274.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QJxQ3pinYJ4qj4+zHGtixzuCUQG5hKnT5H+5Vfvs20ewB+UdNs62d4sVwHCsnDiRkjZrul/Dr10mmibo6s78EoiYBWlOYPFypwTMy33zPUsS8a9zP03W4KiJZNX0jNpI34nd+tuvHPaRcCQll/SKtONBr4nnzifMigIC2ALtIzFk48d02cZHsCMIzIYISNLRp8EG8KWN++KAHp01RL0ujrccd0tS4v6/Q8byXPPLU72L61jiwWSPHCNazs+sGwv5vViGeEuF4X7bblALn7pP5g7IBGb2Io70BvDBGNVhsXa7IWsmuCt82Nl/9codPnwvrtjEH/MqstKB3Zl7VLmvwLSvp0HaEa7QuPSuVWu1bO+Go/wIN+JB1jAuuaW4hZVjALDO7VsyT7eLo/pnpwYEkAtKjByhhWidr4r+H7BZxqY+95VLHVUbXxI4t/nUX2bd
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6FA4EC74CEED5C4F8132BA2693606D02@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c21fcb69-8757-44ce-7535-08d773f1efc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2019 10:58:44.4163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pxyzI3WMrF4SRFRC+ukvs3g2OBAWOYqixSV+qNB5nz6plXTdInc46T4vivVYUtFV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB3337
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQoNCk9uIDIwMTkvMTEvMjgg5LiL5Y2INjo1MCwgU3UgWXVlIHdyb3RlOg0KPiANCj4gDQo+IE9u
IDIwMTkvMTEvMjggMzo1NCBQTSwgUXUgV2VucnVvIHdyb3RlOg0KPj4gVGhlcmUgYXJlIHNldmVy
YWwgcmVwb3J0cyBvZiBoYW5naW5nIHJlbG9jYXRpb24sIHBvcHVsYXRpbmcgdGhlIGRtZXNnDQo+
PiB3aXRoIHRoaW5ncyBsaWtlOg0KPj4gwqDCoCBCVFJGUyBpbmZvIChkZXZpY2UgZG0tNSk6IGZv
dW5kIDEgZXh0ZW50cw0KPj4NCj4+IFRoZSBpbnZlc3RpZ2F0aW9uIGlzIHN0aWxsIG9uIGdvaW5n
LCBidXQgd2lsbCBuZXZlciBodXJ0IHRvIG91dHB1dCBhDQo+PiBsaXR0bGUgbW9yZSBpbmZvLg0K
Pj4NCj4+IFRoaXMgcGF0Y2ggd2lsbCBhbHNvIG91dHB1dCB0aGUgY3VycmVudCByZWxvY2F0aW9u
IHN0YWdlLCBtYWtpbmcgdGhhdA0KPj4gb3V0cHV0IHNvbWV0aGluZyBsaWtlOg0KPj4NCj4+IMKg
wqAgQlRSRlMgaW5mbyAoZGV2aWNlIGRtLTUpOiBiYWxhbmNlOiBzdGFydCAtZCAtbSAtcw0KPj4g
wqDCoCBCVFJGUyBpbmZvIChkZXZpY2UgZG0tNSk6IHJlbG9jYXRpbmcgYmxvY2sgZ3JvdXAgMzA0
MDg3MDQgZmxhZ3MNCj4+IG1ldGFkYXRhfGR1cA0KPj4gwqDCoCBCVFJGUyBpbmZvIChkZXZpY2Ug
ZG0tNSk6IGZvdW5kIDIgZXh0ZW50cyBhdCBNT1ZFX0RBVEFfRVhURU5UIHN0YWdlDQo+PiDCoMKg
IEJUUkZTIGluZm8gKGRldmljZSBkbS01KTogcmVsb2NhdGluZyBibG9jayBncm91cCAyMjAyMDA5
NiBmbGFncw0KPj4gc3lzdGVtfGR1cA0KPj4gwqDCoCBCVFJGUyBpbmZvIChkZXZpY2UgZG0tNSk6
IGZvdW5kIDEgZXh0ZW50cyBhdCBNT1ZFX0RBVEFfRVhURU5UIHN0YWdlDQo+PiDCoMKgIEJUUkZT
IGluZm8gKGRldmljZSBkbS01KTogcmVsb2NhdGluZyBibG9jayBncm91cCAxMzYzMTQ4OCBmbGFn
cyBkYXRhDQo+PiDCoMKgIEJUUkZTIGluZm8gKGRldmljZSBkbS01KTogZm91bmQgMSBleHRlbnRz
IGF0IE1PVkVfREFUQV9FWFRFTlQgc3RhZ2UNCj4+IMKgwqAgQlRSRlMgaW5mbyAoZGV2aWNlIGRt
LTUpOiBmb3VuZCAxIGV4dGVudHMgYXQgVVBEQVRFX0RBVEFfUFRSUyBzdGFnZQ0KPj4gwqDCoCBC
VFJGUyBpbmZvIChkZXZpY2UgZG0tNSk6IGJhbGFuY2U6IGVuZGVkIHdpdGggc3RhdHVzOiAwDQo+
Pg0KPj4gVGhlIHN0cmluZyAiTU9WRV9EQVRBX0VYVEVOVCIgYW5kICJVUERBVEVfREFUQV9QVFJT
IiBpcyBtb3N0bHkgZnJvbSB0aGUNCj4+IG1hY3JvIE1PVkVfREFUQV9FWFRFTlRTIGFuZCBVUERB
VEVfREFUQV9QVFJTLCBidXQgdGhlICdTJyBmcm9tDQo+PiBNT1ZFX0RBVEFfRVhURU5UUyBpcyBy
ZW1vdmVkIGluIHRoZSBvdXRwdXQgc3RyaW5nIHRvIG1ha2UgdGhlIGFsaWdubWVudA0KPj4gYmV0
dGVyLg0KPj4NCj4+IFRoaXMgcGF0Y2ggd2lsbCBub3QgaW5jcmVhc2UgdGhlIG51bWJlciBvZiBs
aW5lcywgYnV0IHdpdGggZXh0cmEgaW5mbw0KPj4gZm9yIHVzIHRvIGRlYnVnIHRoZSByZXBvcnRl
ZCBwcm9ibGVtLg0KPj4gKEFsdGhvdWdoIGl0J3MgdmVyeSBsaWtlbHkgdGhlIGJ1ZyBpcyBzdGlj
a2luZyBhdCBVUERBVEVfREFUQV9QVFJTDQo+PiBzdGFnZSwgZXZlbiB3aXRob3V0IHRoZSBwYXRj
aCkNCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBRdSBXZW5ydW8gPHdxdUBzdXNlLmNvbT4NCj4+IC0t
LQ0KPj4gwqAgZnMvYnRyZnMvcmVsb2NhdGlvbi5jIHwgMTYgKysrKysrKysrKysrKystLQ0KPj4g
wqAgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+Pg0K
Pj4gZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL3JlbG9jYXRpb24uYyBiL2ZzL2J0cmZzL3JlbG9jYXRp
b24uYw0KPj4gaW5kZXggZDg5N2E4ZTVlNDMwLi44OGZkOTE4Mjg1MmQgMTAwNjQ0DQo+PiAtLS0g
YS9mcy9idHJmcy9yZWxvY2F0aW9uLmMNCj4+ICsrKyBiL2ZzL2J0cmZzL3JlbG9jYXRpb24uYw0K
Pj4gQEAgLTQyOTEsNiArNDI5MSwxNSBAQCBzdGF0aWMgdm9pZCBkZXNjcmliZV9yZWxvY2F0aW9u
KHN0cnVjdA0KPj4gYnRyZnNfZnNfaW5mbyAqZnNfaW5mbywNCj4+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBibG9ja19ncm91cC0+c3RhcnQsIGJ1Zik7DQo+PiDCoCB9DQo+Pg0KPj4gK3N0YXRp
YyBjb25zdCBjaGFyICpzdGFnZV90b19zdHJpbmcoaW50IHN0YWdlKQ0KPj4gK3sNCj4+ICvCoMKg
wqAgaWYgKHN0YWdlID09IE1PVkVfREFUQV9FWFRFTlRTKQ0KPj4gK8KgwqDCoMKgwqDCoMKgIHJl
dHVybiAiTU9WRV9EQVRBX0VYVEVOVCI7DQo+PiArwqDCoMKgIGlmIChzdGFnZSA9PSBVUERBVEVf
REFUQV9QVFJTKQ0KPj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiAiVVBEQVRFX0RBVEFfUFRSUyI7
DQo+PiArwqDCoMKgIHJldHVybiAiVU5LTk9XTiI7DQo+PiArfQ0KPj4gKw0KPj4gwqAgLyoNCj4+
IMKgwqAgKiBmdW5jdGlvbiB0byByZWxvY2F0ZSBhbGwgZXh0ZW50cyBpbiBhIGJsb2NrIGdyb3Vw
Lg0KPj4gwqDCoCAqLw0KPj4gQEAgLTQzNjUsMTIgKzQzNzQsMTUgQEAgaW50IGJ0cmZzX3JlbG9j
YXRlX2Jsb2NrX2dyb3VwKHN0cnVjdA0KPj4gYnRyZnNfZnNfaW5mbyAqZnNfaW5mbywgdTY0IGdy
b3VwX3N0YXJ0KQ0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJjLT5i
bG9ja19ncm91cC0+bGVuZ3RoKTsNCj4+DQo+PiDCoMKgwqDCoMKgIHdoaWxlICgxKSB7DQo+PiAr
wqDCoMKgwqDCoMKgwqAgaW50IGZpbmlzaGVzX3N0YWdlOw0KPj4gKw0KPiANCj4gTklUOiB0aGUg
cmM6OnN0YWdlIGlzIGFuIHVuc2lnbmVkIGludGVnZXIuDQoNCkl0IGRvZXNuJ3QgbWF0dGVyLiBy
Yzo6c3RhZ2UgaXMgb25seSBhIDhiaXQgdmFsdWUuDQoNCkJvdGggdW5zaWduZWQgaW50L2ludCBj
YW4gaGFuZGxlIGl0IHdpdGhvdXQgYW55IHByb2JsZW0uDQpBbmQgdGhlIHN0cmFnZV90b19zdHJp
bmcoKSBmdW5jdGlvbiBjYW4gaGFuZGxlIGFueSB2YWx1ZSwgc28gbm8gcHJvYmxlbQ0KYXQgYWxs
Lg0KDQpUaGFua3MsDQpRdQ0KPiANCj4gDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgbXV0ZXhfbG9j
aygmZnNfaW5mby0+Y2xlYW5lcl9tdXRleCk7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0ID0g
cmVsb2NhdGVfYmxvY2tfZ3JvdXAocmMpOw0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIG11dGV4X3Vu
bG9jaygmZnNfaW5mby0+Y2xlYW5lcl9tdXRleCk7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgaWYg
KHJldCA8IDApDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlcnIgPSByZXQ7DQo+Pg0K
Pj4gK8KgwqDCoMKgwqDCoMKgIGZpbmlzaGVzX3N0YWdlID0gcmMtPnN0YWdlOw0KPj4gwqDCoMKg
wqDCoMKgwqDCoMKgIC8qDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIFdlIG1heSBoYXZlIGdv
dHRlbiBFTk9TUEMgYWZ0ZXIgd2UgYWxyZWFkeSBkaXJ0aWVkIHNvbWUNCj4+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgICogZXh0ZW50cy7CoCBJZiB3cml0ZW91dCBoYXBwZW5zIHdoaWxlIHdlJ3JlIHJl
bG9jYXRpbmcgYQ0KPj4gQEAgLTQzOTYsOCArNDQwOCw4IEBAIGludCBidHJmc19yZWxvY2F0ZV9i
bG9ja19ncm91cChzdHJ1Y3QNCj4+IGJ0cmZzX2ZzX2luZm8gKmZzX2luZm8sIHU2NCBncm91cF9z
dGFydCkNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocmMtPmV4dGVudHNfZm91bmQgPT0gMCkN
Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOw0KPj4NCj4+IC3CoMKgwqDCoMKg
wqDCoCBidHJmc19pbmZvKGZzX2luZm8sICJmb3VuZCAlbGx1IGV4dGVudHMiLCByYy0+ZXh0ZW50
c19mb3VuZCk7DQo+PiAtDQo+PiArwqDCoMKgwqDCoMKgwqAgYnRyZnNfaW5mbyhmc19pbmZvLCAi
Zm91bmQgJWxsdSBleHRlbnRzIGF0ICVzIHN0YWdlIiwNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHJjLT5leHRlbnRzX2ZvdW5kLCBzdGFnZV90b19zdHJpbmcoZmluaXNoZXNfc3Rh
Z2UpKTsNCj4+IMKgwqDCoMKgwqAgfQ0KPj4NCj4+IMKgwqDCoMKgwqAgV0FSTl9PTihyYy0+Ymxv
Y2tfZ3JvdXAtPnBpbm5lZCA+IDApOw0KPj4NCg==
