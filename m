Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8B32A508E
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2019 10:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730005AbfIBIAi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Sep 2019 04:00:38 -0400
Received: from m9a0003g.houston.softwaregrp.com ([15.124.64.68]:46571 "EHLO
        m9a0003g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729535AbfIBIAi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Sep 2019 04:00:38 -0400
Received: FROM m9a0003g.houston.softwaregrp.com (15.121.0.191) BY m9a0003g.houston.softwaregrp.com WITH ESMTP
 FOR linux-btrfs@vger.kernel.org;
 Mon,  2 Sep 2019 07:59:40 +0000
Received: from M4W0334.microfocus.com (2002:f78:1192::f78:1192) by
 M9W0068.microfocus.com (2002:f79:bf::f79:bf) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 2 Sep 2019 08:00:16 +0000
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (15.124.8.10) by
 M4W0334.microfocus.com (15.120.17.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Mon, 2 Sep 2019 08:00:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRFuz5DFWhhFBFKAkr5DzZwTHAK+HN7PCUQbRBWIEexkkUemdHElI/3/FK1mxzVBXIne1j72GGVsjw+Ek+uYnyng9qeRRM5nORt6YVZymwkPQFHdusOas7FKTQhCwgQ5oJBVLi4yO0cNN4SRM4wUwIGaznGffpp5JnXXD30Wx5rBTuIj7FpaYWb/+vkiWbyDueAniOiI4k6veC4d76S65HZ6Z9jzEpXkyTmStHiYVrxnY0lhVWjJF0DV0ZZug/A1sNHHcFBMfdQEVXINEgXYPC+uT+6GXMZxMhDh6+KWvzkFV1gcedCYU+7XnyWgP1mN0jOGUkt1nXXFN3TV0BkqaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJG4E2dzzzpHQ54BYy/Ule6jqV/mFrBYngTLwsoiQv4=;
 b=nFQKmSSoiWW2GDKEnc1uRii6ORZp8zcfZUVSQldqh4H3oAymOy8hSjhBW1KHt/q/jg3Fl+ETb9fT5c+SC8YfYeQHb2IpYB8xEIotuct9w6fnnsMMgFM3LLFFRFiVQc9Uw0e4tb7DerTyvqtgPrRbxXn0yA1I694QlvwuzScixjiKMGj1oFzB6aLXpScbx01nYTWli7akW9CizZVsCymnzofoBaZIdW78YjAI7tFkqaf3jkPsQzqg81qiV1cXAI4sDjZxCO7W86qI/jDzv5hFmtYwzktvZOUq3lxqUkpvXtx7uSD19/tyrfdDj+Y49iG7DT2MGDf1fkMN5L2BZlkeZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3169.namprd18.prod.outlook.com (10.255.139.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.19; Mon, 2 Sep 2019 08:00:15 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::f954:9ee8:6d3c:3b3e]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::f954:9ee8:6d3c:3b3e%7]) with mapi id 15.20.2220.021; Mon, 2 Sep 2019
 08:00:15 +0000
From:   WenRuo Qu <wqu@suse.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] btrfs-progs: check/lowmem: Skip nbytes check for
 orphan inodes
Thread-Topic: [PATCH 1/2] btrfs-progs: check/lowmem: Skip nbytes check for
 orphan inodes
Thread-Index: AQHVYWOtgsiu7qFquEOTRndc3PcTkqcYBhMA
Date:   Mon, 2 Sep 2019 08:00:15 +0000
Message-ID: <b779a99d-b499-c87e-0b85-cb57838e5b53@suse.com>
References: <20190902045750.17183-1-wqu@suse.com>
 <7d6d0e6e-1c58-3c5e-fa9b-9b1178843aa5@suse.com>
In-Reply-To: <7d6d0e6e-1c58-3c5e-fa9b-9b1178843aa5@suse.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: TYAPR01CA0064.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::28) To BY5PR18MB3266.namprd18.prod.outlook.com
 (2603:10b6:a03:1a1::15)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [13.231.109.76]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 11766765-1185-489b-98e8-08d72f7b9693
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BY5PR18MB3169;
x-ms-traffictypediagnostic: BY5PR18MB3169:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR18MB3169E34900836810287F4568D6BE0@BY5PR18MB3169.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01480965DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(136003)(376002)(346002)(366004)(396003)(189003)(199004)(86362001)(6486002)(3846002)(110136005)(6246003)(6116002)(102836004)(2616005)(476003)(52116002)(305945005)(66066001)(81156014)(386003)(81166006)(6506007)(7736002)(8676002)(11346002)(5660300002)(76176011)(31696002)(229853002)(8936002)(31686004)(316002)(478600001)(64756008)(66556008)(66446008)(66476007)(71200400001)(71190400001)(446003)(25786009)(6436002)(2906002)(6306002)(14454004)(6512007)(36756003)(99286004)(26005)(14444005)(186003)(53936002)(966005)(256004)(2501003)(486006)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3169;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ax/OkkMSPhUZSF8w1mygFTw35Z/ofKj0Cc4znuIuxPdAqT9p4BJ5uK5+eNCxociF55RVJknMtH7lNsGh0rZwmY1W/seDOywIjz3kebTIEzX3xBurfyZSHYD/VffoySLGdhTUOD9RRJppAS2z+nuU/hzyGuTtJx1StetvmQN7qnqzIRW7VDf/wU4bXsLu1gSg/J+7tSIx/AvEvv/TlDoCmiteh3Dwb6DKslxE91lsivKw/mf3nzY+L7deQki8NzfRihqpN53/Ogi3RVkBRutH9JpeijyVOOwtnICIFmm19ZiOmRFEcJEVcP2D7J/tpH6DkH461sFtvD9U+cmQ1nZvR3VUgQQpfC8HruvEpQ3e9CvD1jSn5aATEOk80Q0bsU+F0zXIL2/Tlk4/ev/7sPKex7QHQ3YLwWjmFcAXziRGyuA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A15BB112AF404C4B8902B74F21FE1867@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 11766765-1185-489b-98e8-08d72f7b9693
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2019 08:00:15.1511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mRAtzzEvIODI0hKqIEK6mjFrLYV+f66AGlZXCTbKfkkN9jo7udUxsvNBXoNxlkap
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3169
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQoNCk9uIDIwMTkvOS8yIOS4i+WNiDM6NTQsIE5pa29sYXkgQm9yaXNvdiB3cm90ZToNCj4gDQo+
IA0KPiBPbiAyLjA5LjE5INCzLiA3OjU3INGHLiwgUXUgV2VucnVvIHdyb3RlOg0KPj4gRm9yIG9y
cGhhbiBpbm9kZXMsIGtlcm5lbCB3b24ndCB1cGRhdGUgaXRzIG5ieXRlcyBhbmQgc2l6ZSBzaW5j
ZSBpdCdzIGENCj4+IHdhc3RlIG9mIHRpbWUuDQo+Pg0KPj4gU28gbG93bWVtIGNoZWNrIGNhbiBy
ZXBvcnQgZmFsc2UgYWxlcnQgb24gc29tZSBvcnBoYW4gaW5vZGVzLg0KPj4NCj4+IEZpeCBpdCBi
eSBjaGVja2luZyBpZiB0aGUgaW5vZGUgaXMgYW4gb3JwaGFuIGJlZm9yZQ0KPj4gY29tcGxhaW5p
bmcvcmVwYWlyaW5nIGl0cyBuYnl0ZXMuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogUXUgV2VucnVv
IDx3cXVAc3VzZS5jb20+DQo+IA0KPiBJcyB0aGlzIHRoZSBzYW1lIGZpeCBhcyA6DQo+IGh0dHBz
Oi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTEwODY0NzEvIGZyb20gam9zZWYsIGJ1dCBm
b3IgbG93bWVtDQo+IG1vZGU/DQoNClllcC4NCg0KVGhhbmtzLA0KUXUNCj4gDQo+PiAtLS0NCj4+
ICBjaGVjay9tb2RlLWxvd21lbS5jIHwgMTQgKysrKysrKysrLS0tLS0NCj4+ICAxIGZpbGUgY2hh
bmdlZCwgOSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQg
YS9jaGVjay9tb2RlLWxvd21lbS5jIGIvY2hlY2svbW9kZS1sb3dtZW0uYw0KPj4gaW5kZXggZGE2
YjZmZDg2YWUzLi41ZjdmMTAxZGFhYjEgMTAwNjQ0DQo+PiAtLS0gYS9jaGVjay9tb2RlLWxvd21l
bS5jDQo+PiArKysgYi9jaGVjay9tb2RlLWxvd21lbS5jDQo+PiBAQCAtMjUxOSw2ICsyNTE5LDcg
QEAgc3RhdGljIGludCBjaGVja19pbm9kZV9pdGVtKHN0cnVjdCBidHJmc19yb290ICpyb290LCBz
dHJ1Y3QgYnRyZnNfcGF0aCAqcGF0aCkNCj4+ICAJCXJldHVybiBlcnI7DQo+PiAgCX0NCj4+ICAN
Cj4+ICsJaXNfb3JwaGFuID0gaGFzX29ycGhhbl9pdGVtKHJvb3QsIGlub2RlX2lkKTsNCj4+ICAJ
aWkgPSBidHJmc19pdGVtX3B0cihub2RlLCBzbG90LCBzdHJ1Y3QgYnRyZnNfaW5vZGVfaXRlbSk7
DQo+PiAgCWlzaXplID0gYnRyZnNfaW5vZGVfc2l6ZShub2RlLCBpaSk7DQo+PiAgCW5ieXRlcyA9
IGJ0cmZzX2lub2RlX25ieXRlcyhub2RlLCBpaSk7DQo+PiBAQCAtMjY3MiwxOSArMjY3MywyMiBA
QCBvdXQ6DQo+PiAgCQkicm9vdCAlbGx1IElOT0RFWyVsbHVdIG5saW5rKCVsbHUpIG5vdCBlcXVh
bCB0byBpbm9kZV9yZWZzKCVsbHUpIiwNCj4+ICAJCQkJICAgICAgcm9vdC0+b2JqZWN0aWQsIGlu
b2RlX2lkLCBubGluaywgcmVmcyk7DQo+PiAgCQkJfQ0KPj4gLQkJfSBlbHNlIGlmICghbmxpbmsp
IHsNCj4+IC0JCQlpc19vcnBoYW4gPSBoYXNfb3JwaGFuX2l0ZW0ocm9vdCwgaW5vZGVfaWQpOw0K
Pj4gLQkJCWlmICghaXNfb3JwaGFuICYmIHJlcGFpcikNCj4+ICsJCX0gZWxzZSBpZiAoIW5saW5r
ICYmICFpc19vcnBoYW4pIHsNCj4+ICsJCQlpZiAocmVwYWlyKQ0KPj4gIAkJCQlyZXQgPSByZXBh
aXJfaW5vZGVfb3JwaGFuX2l0ZW1fbG93bWVtKHJvb3QsDQo+PiAgCQkJCQkJCSAgICAgIHBhdGgs
IGlub2RlX2lkKTsNCj4+IC0JCQlpZiAoIWlzX29ycGhhbiAmJiAoIXJlcGFpciB8fCByZXQpKSB7
DQo+PiArCQkJaWYgKCFyZXBhaXIgfHwgcmV0KSB7DQo+PiAgCQkJCWVyciB8PSBPUlBIQU5fSVRF
TTsNCj4+ICAJCQkJZXJyb3IoInJvb3QgJWxsdSBJTk9ERVslbGx1XSBpcyBvcnBoYW4gaXRlbSIs
DQo+PiAgCQkJCSAgICAgIHJvb3QtPm9iamVjdGlkLCBpbm9kZV9pZCk7DQo+PiAgCQkJfQ0KPj4g
IAkJfQ0KPj4gIA0KPj4gLQkJaWYgKG5ieXRlcyAhPSBleHRlbnRfc2l6ZSkgew0KPj4gKwkJLyoN
Cj4+ICsJCSAqIEZvciBvcmhwYW4gaW5vZGUsIHVwZGF0aW5nIG5ieXRlcy9zaXplIGlzIGp1c3Qg
YSB3YXN0ZSBvZg0KPj4gKwkJICogdGltZSwgc28gc2tpcCBzdWNoIHJlcGFpciBhbmQgZG9uJ3Qg
cmVwb3J0IHRoZW0gYXMgZXJyb3IuDQo+PiArCQkgKi8NCj4+ICsJCWlmIChuYnl0ZXMgIT0gZXh0
ZW50X3NpemUgJiYgIWlzX29ycGhhbikgew0KPj4gIAkJCWlmIChyZXBhaXIpIHsNCj4+ICAJCQkJ
cmV0ID0gcmVwYWlyX2lub2RlX25ieXRlc19sb3dtZW0ocm9vdCwgcGF0aCwNCj4+ICAJCQkJCQkJ
IGlub2RlX2lkLCBleHRlbnRfc2l6ZSk7DQo+Pg0K
