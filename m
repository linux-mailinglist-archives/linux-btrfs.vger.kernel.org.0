Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF0DD8A19
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2019 09:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbfJPHpd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Oct 2019 03:45:33 -0400
Received: from m9a0002g.houston.softwaregrp.com ([15.124.64.67]:51218 "EHLO
        m9a0002g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726796AbfJPHpc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Oct 2019 03:45:32 -0400
Received: FROM m9a0002g.houston.softwaregrp.com (15.121.0.191) BY m9a0002g.houston.softwaregrp.com WITH ESMTP;
 Wed, 16 Oct 2019 07:44:53 +0000
Received: from M9W0068.microfocus.com (2002:f79:bf::f79:bf) by
 M9W0068.microfocus.com (2002:f79:bf::f79:bf) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Wed, 16 Oct 2019 07:45:00 +0000
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (15.124.72.14) by
 M9W0068.microfocus.com (15.121.0.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Wed, 16 Oct 2019 07:45:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+Pk4m+AXQzVrmS+Aw3cAoaqR1/3U5SlqmU9PeKIEzYnmc5ByKI4lRojC11pLlAOAClWrLnJ8L16DPXaBq0UFi01yQQXIKrG0wsLOi2IQMIsJc6ULQ+/ZPzA2+xDwH86gfLKo9jf+Ur56IqDYLbZTpdr1PCseMdW0D823BcbH78/J6nfXrq5hAvNa+7GHRrwBq+j89oGVw4LUwOc0G5kM5NM60a+nh48HZm1zi3qkKFGLfgZFK/ykmNtFrnqLmD61TSpzP+W9w92fGcDiVPc84HNYQjhm+kPhzU8nt6qhl1gBMgXQezxF/K7q8MVdnvaVKadZ6FomqmnTSsbdUpfhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nM7rQdQai84VdZpdJ+0h+qY16VrNzTCXXaeuxwK442A=;
 b=UAIh5+r1Y9h7iM4725vhexeWyGqwxxIBQa92w/zPQAysehw6Q8a47CKUwEXwovN9HGz9jLzyY9979EzsBXtNFA7aLunjVAt/zhHyUR+OOJNJ6R2adewC31WE9RP8AYaoFhqoxTLxMH0CvobVC1ZgzheJmfScSvgyZyQFpUuGMWalvx3iwo9OquAhK+5c5HpHLk6OauMpOKs324y6ppfmQM8/vP1ceDVby1VNVHMVSDNEX9F0PzPaWkDUS+S2S68mzOCwdU82un8QTnBV5QTgzeLgThfKGkfBeAr/2MCg//V9Iys+GpF4fWsf58ej6DATFmAysuMYtheiFSWdAHth0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3172.namprd18.prod.outlook.com (10.255.137.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Wed, 16 Oct 2019 07:44:58 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::5c5:8dae:70ef:a254]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::5c5:8dae:70ef:a254%4]) with mapi id 15.20.2347.023; Wed, 16 Oct 2019
 07:44:58 +0000
From:   Qu WenRuo <wqu@suse.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-trace-devel@vger.kernel.org" 
        <linux-trace-devel@vger.kernel.org>
Subject: Re: [PATCH] tools/lib/traceevent, perf tools: Handle %pU format
 correctly
Thread-Topic: [PATCH] tools/lib/traceevent, perf tools: Handle %pU format
 correctly
Thread-Index: AQHVg/TqbcP6YEJxEECD7cLsDm4xiKdc40KA
Date:   Wed, 16 Oct 2019 07:44:58 +0000
Message-ID: <a92e20ff-a21c-f4f7-e741-8c38cdaec09c@suse.com>
References: <20191016063920.20791-1-wqu@suse.com>
 <fb568719-d0da-fcad-0069-2717fc0ff376@suse.com>
In-Reply-To: <fb568719-d0da-fcad-0069-2717fc0ff376@suse.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: TY2PR06CA0044.apcprd06.prod.outlook.com
 (2603:1096:404:2e::32) To BY5PR18MB3266.namprd18.prod.outlook.com
 (2603:10b6:a03:1a1::15)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [13.231.109.76]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 57f5107c-5dc6-480f-05c1-08d7520cbe3c
x-ms-traffictypediagnostic: BY5PR18MB3172:
x-ld-processed: 856b813c-16e5-49a5-85ec-6f081e13b527,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR18MB3172D440FA1881813C7C694FD6920@BY5PR18MB3172.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0192E812EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(189003)(199004)(66556008)(64756008)(66066001)(76176011)(81166006)(66476007)(52116002)(8936002)(186003)(81156014)(6436002)(229853002)(66446008)(6512007)(6486002)(8676002)(31686004)(66946007)(102836004)(99286004)(26005)(25786009)(386003)(6246003)(6506007)(450100002)(5660300002)(486006)(476003)(2616005)(446003)(11346002)(305945005)(14454004)(478600001)(71190400001)(3846002)(7736002)(31696002)(6116002)(36756003)(2201001)(14444005)(86362001)(71200400001)(2501003)(2906002)(110136005)(316002)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3172;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fJ3BRjla0W93GLKrdxHTl7j6q08/NIPN33SchGUnDekdMwAxV15fRrjCR0u+B1X78UufNqPGeJm9HEKdnqpfLCZebUC2j3NLp+09W83UkqYYwolmHBEx0wE0qx1SyGgIBV/HYYQcNfKw8IfuRnn/YqpLZqaT6QLSAOgKzK7ZglELvonGbhOG936wQPgtIPtEZ0KGy1Efa5A24ojLoQpTo2CotJl0rtbHrr/O7fe9Im3WARoqBXnKwY738jDfykyL7jjDBrZy8sfKLZ/5Ao+vZxD4jB/jaMVYNo/DcLCzER/OhdeHFAYxGnHH+YNrdYCAxckIkw4ourhbz4rkfH2OIUslmbkQsClqD9rb5q8pDnFMaa+bx3eY32oSK8BFqq8kNPtUuxFe9y1U8knVuPTb1f6mAmpPountRJHMqcK7hl8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2DAB18D0EFCA3C43A3DC0650CB3255D2@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 57f5107c-5dc6-480f-05c1-08d7520cbe3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2019 07:44:58.4682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 07v2xi27eokGVkCCkjqgMDmZv/DuhPZAFnrxN4M9wkeUDzOIi7HC20Qz4s/SKmkw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3172
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQoNCk9uIDIwMTkvMTAvMTYg5LiL5Y2IMzozOSwgTmlrb2xheSBCb3Jpc292IHdyb3RlOg0KPiAN
Cj4gDQo+IE9uIDE2LjEwLjE5INCzLiA5OjM5INGHLiwgUXUgV2VucnVvIHdyb3RlOg0KPj4gW0JV
R10NCj4+IEZvciBidHJmcyByZWxhdGVkIGV2ZW50cywgdGhlcmUgaXMgYSBmaWVsZCBmb3IgZnNp
ZCwgYnV0IHBlcmYgbmV2ZXINCj4+IHBhcnNlIGl0IGNvcnJlY3RseS4NCj4+DQo+PiAgIyBwZXJm
IHRyYWNlIC1lIGJ0cmZTOnFncm91cF9tZXRhX2NvbnZlcnQgeGZzX2lvIC1mIC1jICJwd3JpdGUg
MCA0ayIgXA0KPj4gICAgL21udC9idHJmcy9maWxlMQ0KPj4gICAgICAwLjAwMCB4ZnNfaW8vNzc5
MTUgYnRyZnM6cWdyb3VwX21ldGFfcmVzZXJ2ZToobmlsKVU6IHJlZnJvb3Q9NShGU19UUkVFKSB0
eXBlPTB4MCBkaWZmPTINCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgXl5eXl5eIE5vdCBhIGNvcnJlY3QgVVVJRA0KPj4gICAgICAuLi4NCj4+DQo+
PiBbQ0FVU0VdDQo+PiBUaGUgcHJldHR5X3ByaW50KCkgZnVuY3Rpb24gZG9lc24ndCBoYW5kbGUg
dGhlICVwVSBmb3JtYXQgY29ycmVjdGx5Lg0KPj4gSW4gZmFjdCBpdCBkb2Vzbid0IGhhbmRsZSAl
cFUgYXMgdXVpZCBhdCBhbGwuDQo+Pg0KPj4gW0ZJWF0NCj4+IEFkZCBhIG5ldyBmdW5jdGlvbm8s
IHByaW50X3V1aWRfYXJnKCksIHRvIGhhbmRsZSAlcFUgY29ycmVjdGx5Lg0KPj4NCj4+IE5vdyBw
ZXJmIHRyYWNlIGNhbiBhdCBsZWFzdCBwcmludCBmc2lkIGNvcnJlY3RseToNCj4+ICAgICAgMC4w
MDAgeGZzX2lvLzc5NjE5IGJ0cmZzOnFncm91cF9tZXRhX3Jlc2VydmU6MjNhZDE1MTEtZGQ4My00
N2Q0LWE3OWMtZTk2NjI1YTE1YTZlIHJlZnJvb3Q9NShGU19UUkVFKSB0eXBlPTB4MCBkaWZmPTIN
Cj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBRdSBXZW5ydW8gPHdxdUBzdXNlLmNvbT4NCj4+IC0tLQ0K
Pj4gUGxlYXNlIG5vdGUgaW4gYWJvdmUgY2FzZSwgdGhlIEB0eXBlIGFuZCBAZGlmZiBhcmUgbm90
IHByb3Blcmx5IHNob3dlZC4NCj4+IFRoYXQncyBhbm90aGVyIHByb2JsZW0sIHdpbGwgYmUgYWRk
cmVzc2VkIGluIGxhdGVyIHBhdGNoZXMuDQo+PiAtLS0NCj4+ICB0b29scy9saWIvdHJhY2VldmVu
dC9ldmVudC1wYXJzZS5jIHwgMzggKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+PiAg
MSBmaWxlIGNoYW5nZWQsIDM4IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvdG9v
bHMvbGliL3RyYWNlZXZlbnQvZXZlbnQtcGFyc2UuYyBiL3Rvb2xzL2xpYi90cmFjZWV2ZW50L2V2
ZW50LXBhcnNlLmMNCj4+IGluZGV4IGQ5NDg0NzU1ODVjZS4uNGY3MzBlZDUyN2IwIDEwMDY0NA0K
Pj4gLS0tIGEvdG9vbHMvbGliL3RyYWNlZXZlbnQvZXZlbnQtcGFyc2UuYw0KPj4gKysrIGIvdG9v
bHMvbGliL3RyYWNlZXZlbnQvZXZlbnQtcGFyc2UuYw0KPj4gQEAgLTE4LDYgKzE4LDcgQEANCj4+
ICAjaW5jbHVkZSA8ZXJybm8uaD4NCj4+ICAjaW5jbHVkZSA8c3RkaW50Lmg+DQo+PiAgI2luY2x1
ZGUgPGxpbWl0cy5oPg0KPj4gKyNpbmNsdWRlIDxsaW51eC91dWlkLmg+DQo+PiAgI2luY2x1ZGUg
PGxpbnV4L3RpbWU2NC5oPg0KPj4gIA0KPj4gICNpbmNsdWRlIDxuZXRpbmV0L2luLmg+DQo+PiBA
QCAtNDUwOCw2ICs0NTA5LDMzIEBAIGdldF9icHJpbnRfZm9ybWF0KHZvaWQgKmRhdGEsIGludCBz
aXplIF9fbWF5YmVfdW51c2VkLA0KPj4gIAlyZXR1cm4gZm9ybWF0Ow0KPj4gIH0NCj4+ICANCj4+
ICtzdGF0aWMgdm9pZCBwcmludF91dWlkX2FyZyhzdHJ1Y3QgdHJhY2Vfc2VxICpzLCB2b2lkICpk
YXRhLCBpbnQgc2l6ZSwNCj4+ICsJCQkgICBzdHJ1Y3QgdGVwX2V2ZW50ICpldmVudCwgc3RydWN0
IHRlcF9wcmludF9hcmcgKmFyZykNCj4+ICt7DQo+PiArCWNvbnN0IGNoYXIgKmZtdDsNCj4+ICsJ
dW5zaWduZWQgY2hhciAqYnVmOw0KPj4gKw0KPj4gKwlmbXQgPSAiJTAyeCUwMnglMDJ4JTAyeC0l
MDJ4JTAyeC0lMDJ4JTAyeC0lMDJ4JTAyeC0lMDJ4JTAyeCUwMnglMDJ4JTAyeCUwMngiOw0KPj4g
KwlpZiAoYXJnLT50eXBlICE9IFRFUF9QUklOVF9GSUVMRCkgew0KPj4gKwkJdHJhY2Vfc2VxX3By
aW50ZihzLCAiQVJHIFRZUEUgTk9UIEZJRUxJRCBidXQgJWQiLCBhcmctPnR5cGUpOw0KPj4gKwkJ
cmV0dXJuOw0KPj4gKwl9DQo+PiArDQo+PiArCWlmICghYXJnLT5maWVsZC5maWVsZCkgew0KPj4g
KwkJYXJnLT5maWVsZC5maWVsZCA9IHRlcF9maW5kX2FueV9maWVsZChldmVudCwgYXJnLT5maWVs
ZC5uYW1lKTsNCj4+ICsJCWlmICghYXJnLT5maWVsZC5maWVsZCkgew0KPj4gKwkJCWRvX3dhcm5p
bmcoIiVzOiBmaWVsZCAlcyBub3QgZm91bmQiLA0KPj4gKwkJCQkgICBfX2Z1bmNfXywgYXJnLT5m
aWVsZC5uYW1lKTsNCj4+ICsJCQlyZXR1cm47DQo+PiArCQl9DQo+PiArCX0NCj4+ICsJYnVmID0g
ZGF0YSArIGFyZy0+ZmllbGQuZmllbGQtPm9mZnNldDsNCj4+ICsNCj4+ICsJdHJhY2Vfc2VxX3By
aW50ZihzLCBmbXQsIGJ1ZlswXSwgYnVmWzFdLCBidWZbMl0sIGJ1ZlszXSwgYnVmWzRdLCBidWZb
NV0sDQo+PiArCQkgICAgICAgICBidWZbNl0sIGJ1Zls3XSwgYnVmWzhdLCBidWZbOV0sIGJ1Zlsx
MF0sIGJ1ZlsxMV0sIGJ1ZlsxMl0sDQo+PiArCQkJIGJ1ZlsxM10sIGJ1ZlsxNF0sIGJ1ZlsxNV0p
Ow0KPj4gK30NCj4+ICsNCj4+ICBzdGF0aWMgdm9pZCBwcmludF9tYWNfYXJnKHN0cnVjdCB0cmFj
ZV9zZXEgKnMsIGludCBtYWMsIHZvaWQgKmRhdGEsIGludCBzaXplLA0KPj4gIAkJCSAgc3RydWN0
IHRlcF9ldmVudCAqZXZlbnQsIHN0cnVjdCB0ZXBfcHJpbnRfYXJnICphcmcpDQo+PiAgew0KPj4g
QEAgLTUwNzQsNiArNTEwMiwxNiBAQCBzdGF0aWMgdm9pZCBwcmV0dHlfcHJpbnQoc3RydWN0IHRy
YWNlX3NlcSAqcywgdm9pZCAqZGF0YSwgaW50IHNpemUsIHN0cnVjdCB0ZXBfZQ0KPj4gIAkJCQkJ
CWFyZyA9IGFyZy0+bmV4dDsNCj4+ICAJCQkJCQlicmVhazsNCj4+ICAJCQkJCX0NCj4+ICsJCQkJ
fSBlbHNlIGlmICgqcHRyID09ICdVJykgew0KPj4gKwkJCQkJLyogVGhvc2UgZmluZXR1bmluZ3Mg
YXJlIGlnbm9yZWQgZm9yIG5vdyAqLw0KPiANCj4gSSB0aGluayB0aGlzIGNvbW1lbnQgaXMgY3J5
cHRpYy4gV2hhdCBkbyB5b3UgbWVhbiBieSAiZmluZXR1bmluZ3MiPw0KDQpPaCwgdGhlIG9yaWdp
bmFsIHBsYW5uZWQgY2hlY2sgaXM6DQppZiAocHRyWzFdID09ICdiJyB8fCBwdHJbMV0gPT0gJ0In
IHx8DQogICAgcHRyWzFdID09ICdsJyB8fCBwdHJbMV0gPT0gJ0wnKQ0KDQpUaG9zZSBvcHRpb25z
IGFyZSBmaW5ldHVuZXMgZm9yIGVuZGlhbiBhbmQgdXBwZXIvbG93ZXIgY2hhcmFjdGVycy4NCg0K
SG93ZXZlciBJIGp1c3QgY2hvb3NlIHRvIGJlIGxhenkgYW5kIHVzZSBpc2FscGhhKCkgdG8gY2hl
Y2sgdGhlbSBpbiBvbmUNCmxpbmUuDQpJIHdpbGwgY2hhbmdlIHRoZSBjb21tZW50IHRvIG1ha2Ug
aXQgbW9yZSBjbGVhci4NCg0KVGhhbmtzLA0KUXUNCj4gDQo+PiArCQkJCQlpZiAoaXNhbHBoYShw
dHJbMV0pKQ0KPj4gKwkJCQkJCXB0ciArPSAyOw0KPj4gKwkJCQkJZWxzZQ0KPj4gKwkJCQkJCXB0
cisrOw0KPj4gKw0KPj4gKwkJCQkJcHJpbnRfdXVpZF9hcmcocywgZGF0YSwgc2l6ZSwgZXZlbnQs
IGFyZyk7DQo+PiArCQkJCQlhcmcgPSBhcmctPm5leHQ7DQo+PiArCQkJCQlicmVhazsNCj4+ICAJ
CQkJfQ0KPj4gIA0KPj4gIAkJCQkvKiBmYWxsIHRocm91Z2ggKi8NCj4+DQo=
