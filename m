Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48FA8100F83
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2019 00:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfKRXsi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Nov 2019 18:48:38 -0500
Received: from m9a0001g.houston.softwaregrp.com ([15.124.64.66]:50109 "EHLO
        m9a0001g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726809AbfKRXsi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Nov 2019 18:48:38 -0500
Received: FROM m9a0001g.houston.softwaregrp.com (15.121.0.191) BY m9a0001g.houston.softwaregrp.com WITH ESMTP;
 Mon, 18 Nov 2019 23:47:59 +0000
Received: from M9W0067.microfocus.com (2002:f79:be::f79:be) by
 M9W0068.microfocus.com (2002:f79:bf::f79:bf) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 18 Nov 2019 23:47:44 +0000
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (15.124.72.12) by
 M9W0067.microfocus.com (15.121.0.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Mon, 18 Nov 2019 23:47:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8cy8UdW8ObQt8ezY2iUt/g0xKFUP+CWrvoaODIeXwl1zS27FNuX3OtBljc256X5BX/EaShxL/XM/CYJ1GB76Tyl1LJlmb9HL3Fn3e8vhCz2zYUdWUBLQ4qlvkj8mmYxqMhaNT+KP5VGATEyrZ97AHgvVYd5dRYfmOpjnQxKwxUYIr9XWeKa/MbrGopW5dpf0XgoLGahN9ZbQqoPA4tFU6lZ0Nrhb1LzmaARxQmViF0+nJDvGegHQkdAzDFrUJp1Z2D7MalJuSNjhAjPAcWtOg0P8n6R25yzqmqSEy1IHncZr61fWjnhhvoBrPLyY6Y1HEypnCGgToP1UTPZSbgeVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/O295+T/fyT9br4/QxfMps0XjFcvE9aUOBOkVAyuWhc=;
 b=N8YVE3wevTGWsHwLEP8jK42x3GDFSzw865tDMlJ2sUn4q5OtCinmzwxzZEr5uemCl7DHVUtjtfmbRA7g4ZnFsFRZf9qI2RBv/HWSutyIDnqcFLSmVTwNmvZA+J7WwiHORGa75o1Oi3A9iPcHaONkEvGoBeuU080JVqBnI5ITJ2POE5Zp01WXmh3oWYCXsBRGLXQ4H9C2kiSZaNrlZ6uWq+4r0cONXqXrPrBd7xDVOHLq7lOR+WL4sZN5pU06g7jVF9EwxiETNPgtAn+hesdfGYu+9rSNAHPr9qT5RqIo9Z+K8wz5FdecaDs8QklAFAtMDkiddYiHRorqu9+qednf5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3108.namprd18.prod.outlook.com (10.255.138.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Mon, 18 Nov 2019 23:47:42 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::1842:7869:d7de:a07b]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::1842:7869:d7de:a07b%3]) with mapi id 15.20.2451.031; Mon, 18 Nov 2019
 23:47:41 +0000
From:   Qu WenRuo <wqu@suse.com>
To:     Omar Sandoval <osandov@osandov.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/4] btrfs-progs: Compiling warning fixes for devel branch
Thread-Topic: [PATCH 0/4] btrfs-progs: Compiling warning fixes for devel
 branch
Thread-Index: AQHVnj3dp2tSHI4CskqqTIBN7JoF+6eRmJgA
Date:   Mon, 18 Nov 2019 23:47:41 +0000
Message-ID: <a4509699-27c0-d70a-fe6f-033e20d8219e@suse.com>
References: <20191118063052.56970-1-wqu@suse.com>
 <20191118182742.GA215993@vader>
In-Reply-To: <20191118182742.GA215993@vader>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: TYAPR01CA0204.jpnprd01.prod.outlook.com
 (2603:1096:404:29::24) To BY5PR18MB3266.namprd18.prod.outlook.com
 (2603:10b6:a03:1a1::15)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [13.231.109.76]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f098ca50-5254-4fd3-5545-08d76c81b392
x-ms-traffictypediagnostic: BY5PR18MB3108:
x-microsoft-antispam-prvs: <BY5PR18MB3108A095601FE0B40E5B27A8D64D0@BY5PR18MB3108.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0225B0D5BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(189003)(199004)(66446008)(66556008)(66476007)(14454004)(86362001)(71200400001)(256004)(14444005)(71190400001)(64756008)(5660300002)(229853002)(66066001)(478600001)(31696002)(81156014)(486006)(305945005)(8676002)(2616005)(8936002)(81166006)(11346002)(446003)(26005)(99286004)(6506007)(25786009)(31686004)(186003)(316002)(3846002)(6116002)(102836004)(6916009)(7736002)(476003)(4326008)(6436002)(76176011)(6246003)(36756003)(66946007)(2906002)(52116002)(6486002)(6512007)(386003);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3108;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IdAqJYjvm/PpiOiRi0x2YHu3cH0y3RzZNu6xeCPt5homM9bgql2tuLuN1O3YcNEcIu56MQuSj6mOWLimk7OGZsUs4EX1govNfx80cRCiJtJu4EOnku7XzqiH+VWzvyste21tYv3OtVh3QRYQEnK5Kq6Ku9Ww1jU87/5K/oAhFHqe3bDrHRAZuyk/Y6kBdL9YYRfB11mP4/n6gWr9/gA6mY59rbdZ53nWGPQ1vsPnHpD0K0SbiFWQt5/QLV9piGhhbc3PC+iKDIhR9DBt4/UY5MXuoDdYQG4nEF0P2qzND+H5AV0d7JlC1LYuZI3ac7EKLxsnrflqBOTMa9pH8eOFDCEsgcpVu4YzIWHaWbjHVKZ9uYiuXVO5VXxlowUMUudu4AG3OqxORh+i7Ab059q9xOn+jWOAnxjwunQ9TpH0Cmd1DwwbfFVyLC271E6MqEc6
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <71F35F9C3DA861419AC7074C400787AB@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f098ca50-5254-4fd3-5545-08d76c81b392
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2019 23:47:41.7895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 008Wk2tky6q+vC/b61Sliz4hmCuZMKM8NHeIUuiQgMuW0uipisx0v+GgVfCmjwkz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3108
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQoNCk9uIDIwMTkvMTEvMTkg5LiK5Y2IMjoyNywgT21hciBTYW5kb3ZhbCB3cm90ZToNCj4gT24g
TW9uLCBOb3YgMTgsIDIwMTkgYXQgMDI6MzA6NDhQTSArMDgwMCwgUXUgV2VucnVvIHdyb3RlOg0K
Pj4gV2UgaGF2ZSBzZXZlcmFsIGNvbXBpbGluZyBlcnJvcnMsIGluIGRldmVsIGJyYW5jaC4NCj4+
IE9uZSBsb29rcyBsaWtlIGEgZmFsc2UgYWxlcnQgZnJvbSBjb21waWxlciwgdGhlIGZpcnN0IHBh
dGNoIHdpbGwNCj4+IHdvcmthcm91bmQgaXQuDQo+Pg0KPj4gMyB3YXJuaW5nIGZyb20gbGliYnRy
ZnN1dGlscyBhcmUgZHVlIHRvIHB5dGhvbjMuOCBjaGFuZ2VzLg0KPj4gSGFuZGxlIGl0IHByb3Bl
cmx5IGJ5IHVzaW5nIGRlc2lnbmF0ZWQgaW5pdGlhbGl6YXRpb24sIHdoaWNoIGFsc28gc2F2ZXMN
Cj4+IHVzIHF1aXRlIHNvbWUgbGluZXMuDQo+Pg0KPj4gUXUgV2VucnVvICg0KToNCj4+ICAgYnRy
ZnMtcHJvZ3M6IGNoZWNrL2xvd21lbTogRml4IGEgZmFsc2UgYWxlcnQgb24gdW5pbml0aWFsaXpl
ZCB2YWx1ZQ0KPj4gICBidHJmcy1wcm9nczogbGliYnRyZnN1dGlsOiBDb252ZXJ0IHRvIGRlc2ln
bmF0ZWQgaW5pdGlhbGl6YXRpb24gZm9yDQo+PiAgICAgQnRyZnNVdGlsRXJyb3JfdHlwZQ0KPj4g
ICBidHJmcy1wcm9nczogbGliYnRyZnN1dGlsOiBDb252ZXJ0IHRvIGRlc2lnbmF0ZWQgaW5pdGlh
bGl6YXRpb24gZm9yDQo+PiAgICAgUWdyb3VwSW5oZXJpdF90eXBlDQo+PiAgIGJ0cmZzLXByb2dz
OiBsaWJidHJmc3V0aWw6IENvbnZlcnQgdG8gZGVzaWduYXRlZCBpbml0aWFsaXphdGlvbiBmb3IN
Cj4+ICAgICBTdWJ2b2x1bWVJdGVyYXRvcl90eXBlDQo+Pg0KPj4gIGNoZWNrL21vZGUtY29tbW9u
LmMgICAgICAgICAgICAgfCAgMiArLQ0KPj4gIGxpYmJ0cmZzdXRpbC9weXRob24vZXJyb3IuYyAg
ICAgfCA0OSArKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+ICBsaWJidHJmc3V0
aWwvcHl0aG9uL3Fncm91cC5jICAgIHwgNDMgKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0N
Cj4+ICBsaWJidHJmc3V0aWwvcHl0aG9uL3N1YnZvbHVtZS5jIHwgNDQgKysrKysrLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0NCj4+ICA0IGZpbGVzIGNoYW5nZWQsIDMwIGluc2VydGlvbnMoKyksIDEw
OCBkZWxldGlvbnMoLSkNCj4gDQo+IFRoYW5rcyBmb3IgZml4aW5nIHRoZSBsaWJidHJmc3V0aWwg
cGFydHMuIEZvciBzb21lIHJlYXNvbiwgdGhlDQo+IGNvbnZlbnRpb24gZm9yIFB5dGhvbiBDIGV4
dGVuc2lvbnMgaXMgdG8gbm90IHVzZSBkZXNpZ25hdGVkDQo+IGluaXRpYWxpemVycywgYnV0IGFm
dGVyIHRoaXMgYnJlYWthZ2UgaXQncyBkZWZpbml0ZWx5IHNhZmVyIHRvIHVzZSB0aGVtLg0KPiAN
Cj4gSSBndWVzcyBEYXZlIGFscmVhZHkgbWVyZ2VkIHRoZXNlLCBidXQgRldJVywNCj4gDQo+IFJl
dmlld2VkLWJ5OiBPbWFyIFNhbmRvdmFsIDxvc2FuZG92QGZiLmNvbT4NCj4gDQpBIHNtYWxsIHF1
ZXN0aW9uIGluc3BpcmVkIGJ5IHRoaXMgYnVnLCBidXQgbm90IHNwZWNpZmljIHRvIGJ0cmZzLg0K
DQpEb2VzIHRoaXMgbWVhbiBlYWNoIGJpZyBweXRob24gdXBncmFkZSBtYWtlcyBhbGwgYy1iaW5k
aW5nIGJpbmFyeQ0KaW5jb21wYXRpYmxlPyBPciB0aGlzIGlzIGp1c3QgYSBoaWNjdXAgZm9yIHRo
aXMgcHl0aG9uMy44IHJlbGVhc2U/DQoNCklmIGl0J3MgdGhlIGZvcm1lciBjYXNlLCB0aGF0IGRv
ZXNuJ3QgbG9vayBjb3JyZWN0IHRvIG1lLi4uDQoNClRoYW5rcywNClF1DQo=
