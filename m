Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B519B108812
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2019 06:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725535AbfKYFAa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Nov 2019 00:00:30 -0500
Received: from m4a0040g.houston.softwaregrp.com ([15.124.2.86]:56565 "EHLO
        m4a0040g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725385AbfKYFA3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Nov 2019 00:00:29 -0500
Received: FROM m4a0040g.houston.softwaregrp.com (15.120.17.147) BY m4a0040g.houston.softwaregrp.com WITH ESMTP;
 Mon, 25 Nov 2019 04:58:34 +0000
Received: from M4W0335.microfocus.com (2002:f78:1193::f78:1193) by
 M4W0335.microfocus.com (2002:f78:1193::f78:1193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 25 Nov 2019 04:59:59 +0000
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (15.124.8.11) by
 M4W0335.microfocus.com (15.120.17.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Mon, 25 Nov 2019 04:59:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7NrhYXCcyEsK0fg6fXRSolaEiImaFzRe5kRQNQ9s9OfIbROz/6l+Zyy8wab7O7vnwXnA3sQ5R2206jggHO3SjGwsb4H7EuwFGYslUG1ehUEVgeMbr5FSTcIUh9g7BwLsEmqUilsKqNN0aYsfRCRGZJ1QIbZb2RvbQJuocT47PVtuzdTzDql5o1qSBJH4wLywrYafUhLAWv2dgMJ6njO3tx5Q/df2d9zTLiKQ+JdmKA94Yl94nrz9GA0Nh2Yn7CopwQ17NbBOlARxd6ti+1qhgcFuH9fey3RiDGuWFRKuArm86d9WGz0hQdu3UYmro3B1Q1ml+pD7zWGG1famtQgdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pF9EBx/+7nSRRidiHxuH6L9g9gT0YsSA1uLm0+i/USI=;
 b=b5+8ZZUMl13kwaaAkzHVemLTRLOy+esaP3+bnM6x5Zwsf/7HrP8DPs0JlQBo+Z/9QwuGIJYf3vIaPJqpJQCjLXG1xZrkUBV3FPJAXoobsEnX+eQt2RBxnrh9e2ra0tMGlxBhnSNhhPQpZw611zT8lbRvyf/Q1Dmq5pD1csBjyHJ+qE2DM7JnO41A4ZXcZ1wMA6VNv9wG0ZRDtT7l05gFRZpwB64bmfqLMLekFV3qmlvkw5/e2BgygpX33dQnsFS0vLTWRs2PevZNfb2Vpmi9Wqxrn+y+h03CoO0tleb2o1yRlZK26O1YOMYhm7fXZky5nZLdvESmcGaCzoJa8MAOhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3409.namprd18.prod.outlook.com (10.255.139.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Mon, 25 Nov 2019 04:59:58 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::1842:7869:d7de:a07b]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::1842:7869:d7de:a07b%3]) with mapi id 15.20.2474.023; Mon, 25 Nov 2019
 04:59:58 +0000
From:   Qu WenRuo <wqu@suse.com>
To:     Eryu Guan <guaneryu@gmail.com>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] fstests: common: Keep $seqres.dmesg in $RESULT_DIR
Thread-Topic: [PATCH] fstests: common: Keep $seqres.dmesg in $RESULT_DIR
Thread-Index: AQHVouKhQTA9YnQYlkiwVHpFnR38LqebVJQA
Date:   Mon, 25 Nov 2019 04:59:58 +0000
Message-ID: <b9a5bca6-5aaa-81c7-1e87-91646c55f955@suse.com>
References: <20191113065938.34720-1-wqu@suse.com>
 <20191124161538.GG8664@desktop>
In-Reply-To: <20191124161538.GG8664@desktop>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR01CA0041.prod.exchangelabs.com (2603:10b6:a03:94::18)
 To BY5PR18MB3266.namprd18.prod.outlook.com (2603:10b6:a03:1a1::15)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [149.28.201.231]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5daa42f3-6b07-44b6-b666-08d7716451c4
x-ms-traffictypediagnostic: BY5PR18MB3409:
x-microsoft-antispam-prvs: <BY5PR18MB34094A972A6561C9FD7D7421D64A0@BY5PR18MB3409.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0232B30BBC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(199004)(189003)(81166006)(8676002)(81156014)(8936002)(5660300002)(2906002)(66446008)(64756008)(66556008)(66476007)(66946007)(7736002)(305945005)(99286004)(1411001)(66066001)(316002)(6116002)(3846002)(446003)(256004)(14444005)(102836004)(76176011)(386003)(52116002)(6246003)(71190400001)(71200400001)(6512007)(11346002)(54906003)(6916009)(6436002)(229853002)(2616005)(6486002)(31686004)(31696002)(86362001)(14454004)(186003)(26005)(6506007)(4326008)(478600001)(36756003)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3409;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B1LnGRiomlHNoOxvC4wyEQhz4MqhuFs5EQk5zReXMNP0QEolwNaxOxkTnBw/i9tw5blL3627HtSOwXcDR+0OfpE9hE87y3mOMpHuA75Y30R4JtHBOtjMbehbBDsrS8/yON7rCWwdh+pRGlfMZSfXrGuQLRkSXXMKtLUpIXSoiYIeoks503HRA+BqKNLwFjnhkNqWkWREJOe91lFVz5mcUhvaaForLtjod0dAPBywkbOBcbUAd0D+TkWe9SL1/0Mya1s/kr26S2eOT8GDRhgFHmISCFv2CLtSN06bPk+HHyWoRSZgW6OwydlbXUvQX+FcKoV5FzYDqPfMFE7o2U40vmAFbe8SNMpYY/ZfV0yg534nAFZd1ZIWEX4ymEmo2z50iXzzyczJplGCgiqzToFF9O4xKGxT+g5lGcXq5CSqD9QMY2zXv6jkb7mwZhtU+XtI
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C9F59AB25AABC48BA58F2E22AF533E6@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5daa42f3-6b07-44b6-b666-08d7716451c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2019 04:59:58.2926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d27W5WzcpeEjOEZVOoaJMamEF4NIuEue+G6cCpE4ehYsxthpWGVF0FPhuH0KrHVt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3409
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQoNCk9uIDIwMTkvMTEvMjUg5LiK5Y2IMTI6MTUsIEVyeXUgR3VhbiB3cm90ZToNCj4gT24gV2Vk
LCBOb3YgMTMsIDIwMTkgYXQgMDI6NTk6MzhQTSArMDgwMCwgUXUgV2VucnVvIHdyb3RlOg0KPj4g
Q3VycmVudGx5IGZzdGVzdHMgd2lsbCByZW1vdmUgJHNlcXJlcy5kbWVzZyBpZiBub3RoaW5nIHdy
b25nIGhhcHBlbmVkLg0KPj4gSXQgc2F2ZXMgc29tZSBzcGFjZSwgYnV0IHNvbWV0aW1lcyBpdCBt
YXkgbm90IHByb3ZpZGUgZ29vZCBlbm91Z2gNCj4+IGhpc3RvcnkgZm9yIGRldmVsb3BlcnMgdG8g
Y2hlY2suDQo+PiBFLmcuIHNvbWUgdW5leHBlY3RlZCBkbWVzZyBmcm9tIGZzLCBidXQgbm90IHNl
cmlvdXMgZW5vdWdoIHRvIGJlIGNhdWdodA0KPj4gYnkgY3VycmVudCBmaWx0ZXIuDQo+Pg0KPj4g
U28gaW5zdGVhZCBvZiBkZWxldGluZyB0aGUgb3JkaW5hcnkgJHNlcXJlcy5kbWVzZywganVzdCBr
ZWVwIHRoZW0sIHNvDQo+PiB3ZSBjYW4gYXJjaGl2ZSB0aGVtIGZvciBsYXRlciByZXZpZXcuDQo+
Pg0KPj4gU2lnbmVkLW9mZi1ieTogUXUgV2VucnVvIDx3cXVAc3VzZS5jb20+DQo+IA0KPiBUaGlz
IGxvb2tzIGZpbmUgdG8gbWUsIGJ1dCBpdCBjYXVzZXMgbW9yZSBkaXNrIHNwYWNlIGNvbnN1bXB0
aW9uIGFuZCBtYXkNCj4gZWF0IGFsbCByb290ZnMgc3BhY2UgcXVpY2tseSBhbmQgdW5leHBlY3Rl
ZGx5Lg0KPiANCj4gSSBzdWdnZXN0IHdlIGFkZCBhbiBvcHRpb24gdG8gY29udHJvbCB0aGUgYmVo
YXZpb3IsIGFuZCBkZWZhdWx0IGJlaGF2aW9yDQo+IGlzIHRvIGRlbGV0ZSB0aGUgZG1lc2cgZmls
ZS4NCg0KU3VyZSwgSSdsbCBhZGQgYW4gb3B0aW9uIHRvIGNoYW5nZSB0aGUgYmVoYXZpb3IgaW4g
bmV4dCB2ZXJzaW9uLg0KDQpUaGFua3MsDQpRdQ0KDQo+IA0KPiBUaGFua3MsDQo+IEVyeXUNCj4g
DQo+PiAtLS0NCj4+ICBjb21tb24vcmMgfCA0ICstLS0NCj4+ICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDMgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2NvbW1vbi9y
YyBiL2NvbW1vbi9yYw0KPj4gaW5kZXggYjk4OGU5MTIuLjU5YTMzOWE2IDEwMDY0NA0KPj4gLS0t
IGEvY29tbW9uL3JjDQo+PiArKysgYi9jb21tb24vcmMNCj4+IEBAIC0zNjI1LDEwICszNjI1LDgg
QEAgX2NoZWNrX2RtZXNnKCkNCj4+ICAJaWYgWyAkPyAtZXEgMCBdOyB0aGVuDQo+PiAgCQlfZHVt
cF9lcnIgIl9jaGVja19kbWVzZzogc29tZXRoaW5nIGZvdW5kIGluIGRtZXNnIChzZWUgJHNlcXJl
cy5kbWVzZykiDQo+PiAgCQlyZXR1cm4gMQ0KPj4gLQllbHNlDQo+PiAtCQlybSAtZiAkc2VxcmVz
LmRtZXNnDQo+PiAtCQlyZXR1cm4gMA0KPj4gIAlmaQ0KPj4gKwlyZXR1cm4gMA0KPj4gIH0NCj4+
ICANCj4+ICAjIGNhcHR1cmUgdGhlIGttZW1sZWFrIHJlcG9ydA0KPj4gLS0gDQo+PiAyLjIzLjAN
Cj4+DQo=
