Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF779F7B7
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2019 03:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbfH1BQb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Aug 2019 21:16:31 -0400
Received: from m9a0003g.houston.softwaregrp.com ([15.124.64.68]:60842 "EHLO
        m9a0003g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726091AbfH1BQb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Aug 2019 21:16:31 -0400
Received: FROM m9a0003g.houston.softwaregrp.com (15.121.0.190) BY m9a0003g.houston.softwaregrp.com WITH ESMTP;
 Wed, 28 Aug 2019 01:15:39 +0000
Received: from M9W0067.microfocus.com (2002:f79:be::f79:be) by
 M9W0067.microfocus.com (2002:f79:be::f79:be) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Wed, 28 Aug 2019 01:16:20 +0000
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (15.124.72.11) by
 M9W0067.microfocus.com (15.121.0.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Wed, 28 Aug 2019 01:16:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FYG8M6ahAr9zP+UoOEowEthKya/9gWfDubWvYVRa8Ufbn8DsUiDhCA9vARVFmsxcRN0Edq9sHVWO3GsBriv6imehx2FJaW+jXY1LfEVbxJdc99C3V2Pqxl88NhhVwNGNUXenvD771knlilRDyqFGc7yGDUtvlpJdsLUl4me8o6hnlJ11ZlZvHlXBsbWb2Sdx0rJ94ujTlyXlqoGAUab3ozOXHmtRSkF/KrZOtQLwfdAn90ugbjxCUk2EffOyKvXfa0jqzDE0bywLELxrehL/o/Zec78sbpn7rpyZrxEYYxW56KKnTDfqI6GCFgC0E4erIttiTj/6bF7rA5ulzle6cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1MV6lvGJE4Lg/flUSdRqlqeScEA4AiBcn411DCjZPk=;
 b=RDs695JrTn0INDYN367Xxi+ZFU1TV4xAY15wkwfM1AcRU7DD1oImwDdzSzYoQSP9Kx6QIOmc6tPEKGOkOOL3CtP3+7OLSnj+KusjFVqzvz++FPvGak9bPkvmtP1RC9ehOYdR4dVNrRe8SEjrk5W2inkElHbvnstE+iP2ABqhdLUJRdOxT59QrtbQHp1Qy3alxOLU6XgrMJ707/arNPmwYMUbnazmLDndOGmPf9JxTpY3p33qfB7k0G2DsLC+pxDcrcgQ/cmW0C/SaylyTJ4cGd8FtGc804ScY0Bt5AEQWAQ6Dhm2p5tkYq0ghnAtas3R+1yVogxBl4B7qLRJdZn/mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3378.namprd18.prod.outlook.com (10.255.139.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.20; Wed, 28 Aug 2019 01:16:18 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::e94d:d625:c907:d8a0]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::e94d:d625:c907:d8a0%4]) with mapi id 15.20.2199.021; Wed, 28 Aug 2019
 01:16:18 +0000
From:   WenRuo Qu <wqu@suse.com>
To:     Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2] btrfs: tree-checker: Fix wrong check on max devid
Thread-Topic: [PATCH v2] btrfs: tree-checker: Fix wrong check on max devid
Thread-Index: AQHVXS8ARtpBNmb/PUuJllatagp0dqcPwfkA
Date:   Wed, 28 Aug 2019 01:16:18 +0000
Message-ID: <e469e5b6-ec5c-0645-b731-2b841062e728@suse.com>
References: <20190827140511.7081-1-wqu@suse.com>
 <1c281539-89b6-e4c6-9c12-bb0b7bb9708d@oracle.com>
In-Reply-To: <1c281539-89b6-e4c6-9c12-bb0b7bb9708d@oracle.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: TY2PR01CA0009.jpnprd01.prod.outlook.com
 (2603:1096:404:a::21) To BY5PR18MB3266.namprd18.prod.outlook.com
 (2603:10b6:a03:1a1::15)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [13.231.109.76]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae0011b4-f316-487d-55b2-08d72b5553f8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BY5PR18MB3378;
x-ms-traffictypediagnostic: BY5PR18MB3378:
x-microsoft-antispam-prvs: <BY5PR18MB3378CEA604576D9409543C70D6A30@BY5PR18MB3378.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(136003)(346002)(396003)(376002)(366004)(54534003)(199004)(189003)(66946007)(14444005)(6486002)(86362001)(36756003)(5660300002)(7736002)(31686004)(6116002)(26005)(256004)(81156014)(2616005)(71190400001)(71200400001)(486006)(2906002)(102836004)(81166006)(8676002)(76176011)(31696002)(2501003)(476003)(386003)(229853002)(66066001)(53936002)(6512007)(53546011)(52116002)(99286004)(8936002)(110136005)(3846002)(6246003)(6436002)(64756008)(316002)(66556008)(66446008)(446003)(66476007)(14454004)(186003)(11346002)(478600001)(25786009)(305945005)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3378;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fi/tZhNZfTiu8J/r6vvkAbYkjc2G6yprQO+aRsDplog3sqOuz61kXuco4g2fcWHEL6pIbSiSAI410OomadgoMzw80F8cvbVjrYeiqIeNIGlKa605L5M1j19vskSxfryPVMWM6uaDNWyHjc0UVnIw7zHX4nWTimQi/kTU4h19Tqe8TF53E6dqugImBk+Y/ybb0ajtRNhiCU+LALB947ndYekwKXulpFdqO3ZhJtND2YzHLsBb5HKWXhiLmj4/8fsoId+AUj3hNiVi5zZtXqaVbZgLfjltRdn1I/IuXA7CzEbg0u/RyeiDevMbgCFO5g0zO2K7aetNg3NKrm52ZEoolzYsGCgxm39C31utNmgOzVvqU/H0gMUE2u0/8STU36NV11kjV1u0thh0ugz2LfMs7aTYy8bzQyGqFBtRIRKj7NQ=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C1DA68BBAFC60C47A8ECAA10B2FE21DB@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ae0011b4-f316-487d-55b2-08d72b5553f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 01:16:18.0590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bfPzrA2OhPIKdtwYyrscANcYdsYhA+vVlbQ9T7q3YnGV7Rba7WOjPwGnAP0MF4Lf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3378
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQoNCk9uIDIwMTkvOC8yOCDkuIrljYg3OjI2LCBBbmFuZCBKYWluIHdyb3RlOg0KPiBPbiAyNy84
LzE5IDEwOjA1IFBNLCBRdSBXZW5ydW8gd3JvdGU6DQo+PiBCdHJmcyBkb2Vzbid0IHJldXNlIGRl
dmlkLCB0aHVzIGlmIHdlIGFkZCBhbmQgZGVsZXRlIGRldmljZSBpbiBhIGxvb3AsDQo+PiB3ZSBj
YW4gaW5jcmVhc2UgZGV2aWQgdG8gaGlnaGVyIHZhbHVlLCB0cmlnZ2VyaW5nIHRyZWUgY2hlY2tl
ciB0byBnaXZlIGENCj4+IGZhbHNlIGFsZXJ0Lg0KPj4NCj4+IEZ1cnRoZXJtb3JlLCB3ZSBoYXZl
IGRldiBleHRlbnQgdmVyaWZpY2F0aW9uIGFscmVhZHkgKGFmdGVyDQo+PiB0cmVlLWNoZWNrZXIs
IGF0IG1vdW50IHRpbWUpLg0KPj4gU28gZXZlbiBpZiB1c2VyIGhhZCBiaXRmbGlwIG9uIHNvbWUg
ZGV2IGl0ZW1zLCB3ZSBjYW4gc3RpbGwgZGV0ZWN0IGl0DQo+PiBhbmQgcmVmdXNlIHRvIG1vdW50
Lg0KPj4NCj4+IFJlcG9ydGVkLWJ5OiBBbmFuZCBKYWluIDxhbmFuZC5qYWluQG9yYWNsZS5jb20+
DQo+PiBGaXhlczogYWI0YmEyZTEzMzQ2ICgiYnRyZnM6IHRyZWUtY2hlY2tlcjogVmVyaWZ5IGRl
diBpdGVtIikNCj4+IFNpZ25lZC1vZmYtYnk6IFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPg0KPj4g
LS0tDQo+PiBDaGFuZ2Vsb2c6DQo+PiB2MjoNCj4+IC0gUmVtb3ZlIGRldmlkIGNoZWNrIGNvbXBs
ZXRlbHkNCj4+IMKgwqAgQXMgd2UgYWxyZWFkeSBoYXZlIHZlcmlmeV9vbmVfZGV2X2V4dGVudCgp
Lg0KPj4gLS0tDQo+PiDCoCBmcy9idHJmcy90cmVlLWNoZWNrZXIuYyB8IDggLS0tLS0tLS0NCj4+
IMKgIDEgZmlsZSBjaGFuZ2VkLCA4IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9m
cy9idHJmcy90cmVlLWNoZWNrZXIuYyBiL2ZzL2J0cmZzL3RyZWUtY2hlY2tlci5jDQo+PiBpbmRl
eCA0M2U0ODhmNWQwNjMuLjA3NmQ1YjgwMTRmYiAxMDA2NDQNCj4+IC0tLSBhL2ZzL2J0cmZzL3Ry
ZWUtY2hlY2tlci5jDQo+PiArKysgYi9mcy9idHJmcy90cmVlLWNoZWNrZXIuYw0KPj4gQEAgLTY4
Niw5ICs2ODYsNyBAQCBzdGF0aWMgdm9pZCBkZXZfaXRlbV9lcnIoY29uc3Qgc3RydWN0DQo+PiBl
eHRlbnRfYnVmZmVyICplYiwgaW50IHNsb3QsDQo+PiDCoCBzdGF0aWMgaW50IGNoZWNrX2Rldl9p
dGVtKHN0cnVjdCBleHRlbnRfYnVmZmVyICpsZWFmLA0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHN0cnVjdCBidHJmc19rZXkgKmtleSwgaW50IHNsb3QpDQo+PiDCoCB7DQo+PiAt
wqDCoMKgIHN0cnVjdCBidHJmc19mc19pbmZvICpmc19pbmZvID0gbGVhZi0+ZnNfaW5mbzsNCj4+
IMKgwqDCoMKgwqAgc3RydWN0IGJ0cmZzX2Rldl9pdGVtICpkaXRlbTsNCj4+IC3CoMKgwqAgdTY0
IG1heF9kZXZpZCA9IG1heChCVFJGU19NQVhfREVWUyhmc19pbmZvKSwNCj4+IEJUUkZTX01BWF9E
RVZTX1NZU19DSFVOSyk7DQo+PiDCoCDCoMKgwqDCoMKgIGlmIChrZXktPm9iamVjdGlkICE9IEJU
UkZTX0RFVl9JVEVNU19PQkpFQ1RJRCkgew0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGRldl9pdGVt
X2VycihsZWFmLCBzbG90LA0KPj4gQEAgLTY5NiwxMiArNjk0LDYgQEAgc3RhdGljIGludCBjaGVj
a19kZXZfaXRlbShzdHJ1Y3QgZXh0ZW50X2J1ZmZlcg0KPj4gKmxlYWYsDQo+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAga2V5LT5vYmplY3RpZCwgQlRSRlNfREVWX0lURU1T
X09CSkVDVElEKTsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVVQ0xFQU47DQo+PiDC
oMKgwqDCoMKgIH0NCj4+IC3CoMKgwqAgaWYgKGtleS0+b2Zmc2V0ID4gbWF4X2RldmlkKSB7DQo+
PiAtwqDCoMKgwqDCoMKgwqAgZGV2X2l0ZW1fZXJyKGxlYWYsIHNsb3QsDQo+PiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgImludmFsaWQgZGV2aWQ6IGhhcz0lbGx1IGV4cGVjdD1b
MCwgJWxsdV0iLA0KPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGtleS0+b2Zm
c2V0LCBtYXhfZGV2aWQpOw0KPj4gLcKgwqDCoMKgwqDCoMKgIHJldHVybiAtRVVDTEVBTjsNCj4+
IC3CoMKgwqAgfQ0KPj4gwqDCoMKgwqDCoCBkaXRlbSA9IGJ0cmZzX2l0ZW1fcHRyKGxlYWYsIHNs
b3QsIHN0cnVjdCBidHJmc19kZXZfaXRlbSk7DQo+PiDCoMKgwqDCoMKgIGlmIChidHJmc19kZXZp
Y2VfaWQobGVhZiwgZGl0ZW0pICE9IGtleS0+b2Zmc2V0KSB7DQo+PiDCoMKgwqDCoMKgwqDCoMKg
wqAgZGV2X2l0ZW1fZXJyKGxlYWYsIHNsb3QsDQo+Pg0KPiANCj4gwqAgVGhvdWdoIGFiNGJhMmUx
MzM0NiBkaWRuJ3QgYWRkIEJUUkZTX01BWF9ERVZTX1NZU19DSFVOSywNCj4gwqAgQlRSRlNfTUFY
X0RFVlNfU1lTX0NIVU5LIGlzIHVudXNlZCBub3csIGNhbiBiZSBkZWxldGVkLg0KDQpOb3BlLCB0
aGV5IGFyZSBzdGlsbCB1c2VkIHRvIGRldGVybWluZSBpZiB3ZSdyZSBhdCB0aGUgbWF4IGRldmlj
ZSBsaW1pdC4NCg0KU28gdGhleSBhcmUgc3RpbGwgbmVlZGVkLg0KDQpUaGFua3MsDQpRdQ0KPiAN
Cj4gwqAgVGhlIHJlcHJvZHVjZXIgc2NyaXB0IGFuZCBsb2dzIHNob3VsZCByYXRoZXIgYmUgaW4g
dGhpcyBjaGFuZ2UgbG9nLg0KPiANCj4gVGhhbmtzLCBBbmFuZA0KPiANCg==
