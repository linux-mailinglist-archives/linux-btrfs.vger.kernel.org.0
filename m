Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17B36EC170
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2019 11:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730012AbfKAK6j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Nov 2019 06:58:39 -0400
Received: from m4a0039g.houston.softwaregrp.com ([15.124.2.85]:37593 "EHLO
        m4a0039g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729937AbfKAK6i (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 1 Nov 2019 06:58:38 -0400
Received: FROM m4a0039g.houston.softwaregrp.com (15.120.17.147) BY m4a0039g.houston.softwaregrp.com WITH ESMTP;
 Fri,  1 Nov 2019 10:57:33 +0000
Received: from M4W0335.microfocus.com (2002:f78:1193::f78:1193) by
 M4W0335.microfocus.com (2002:f78:1193::f78:1193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Fri, 1 Nov 2019 10:57:14 +0000
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (15.124.8.11) by
 M4W0335.microfocus.com (15.120.17.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Fri, 1 Nov 2019 10:57:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itrmVspjKh8Xvsa44yg1dcOlh/j5aj5iIl3bH/7ZLBX0kzub4Lg4FpBNmeWxNHc+2oTZLNcKOOxBwmSa5vBG9uK9aMsFWMMwMcecXse5qjDnpup8ENWz9yVwAXh7XnNsbkjHzlXFvXB16x0VYjEKIaBFu/QRnK5sPZqltJOYLEWTPWBkUu98yQvbXbqu2C7ungzCcmpW7VEf1zHHXWHyoGbU4ot4kyjw9FK6BKiq695UYidBTzIRt1EG1Q9Dt2PpEcdTXjnH7bbQsvyCXCL4WSJ/fl21VMCUUfrx31iI3KCGWOEYHmcmxgPAAOq+4ZYTz+TmZC90oYKGfp57D0PCNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cV+75bQY2lUdynHVrGnfqloCcMOSP8y6immZXk8t6aw=;
 b=IPV6e24ZEPTFSoKVXh3NAHJ2LpDYusHAY2gSWORAak4Vf6qq7kvJehOMomo3cqqTfEXrfUt23gIy6iwjmedoQhO9AJY8HvNbPkm4Ut3hRF7cLuEbs4D9+m94cjjW2FLXh/T2PeOMASGlk7dI567otwIVqaejvprJpTLM7c6nHQqDOtUr8xPuR0Cq3SPYkQEWwlQJsddGwjdvZNoNzvF00jBF7JxMrjEvbU1PQ3bUoXheuY2dw3L1dFiPjLl5ssLQg6zH5bl2OzNr/sVEvy0ep72PRRr1QlfEaVNjex+SnrBaU6Wpl8QkzleyWkrrXnuVsMIf1MSV7XsVtDoNuZ+UrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3410.namprd18.prod.outlook.com (10.255.137.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.18; Fri, 1 Nov 2019 10:56:37 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::5c5:8dae:70ef:a254]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::5c5:8dae:70ef:a254%4]) with mapi id 15.20.2387.028; Fri, 1 Nov 2019
 10:56:37 +0000
From:   Qu WenRuo <wqu@suse.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Christian Pernegger <pernegger@gmail.com>
Subject: Re: [PATCH] btrfs-progs: rescue-zero-log: Modify super block directly
Thread-Topic: [PATCH] btrfs-progs: rescue-zero-log: Modify super block
 directly
Thread-Index: AQHVkKJtT0qVuXECvE+HfAyAHIlssad2JL4A
Date:   Fri, 1 Nov 2019 10:56:36 +0000
Message-ID: <65d30567-a0cb-4430-43ba-94e5fe597f8e@suse.com>
References: <20191026101127.36851-1-wqu@suse.com>
 <20191101105216.GJ3001@twin.jikos.cz>
In-Reply-To: <20191101105216.GJ3001@twin.jikos.cz>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: TYCPR01CA0054.jpnprd01.prod.outlook.com
 (2603:1096:405:2::18) To BY5PR18MB3266.namprd18.prod.outlook.com
 (2603:10b6:a03:1a1::15)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [13.231.109.76]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e63914e4-fc78-4120-adfc-08d75eba2a75
x-ms-traffictypediagnostic: BY5PR18MB3410:
x-microsoft-antispam-prvs: <BY5PR18MB341003951C5B685735B774BED6620@BY5PR18MB3410.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(346002)(39860400002)(376002)(396003)(189003)(199004)(2906002)(7736002)(25786009)(256004)(14444005)(71200400001)(81166006)(316002)(6116002)(8676002)(81156014)(71190400001)(31686004)(110136005)(36756003)(3846002)(64756008)(66946007)(14454004)(66446008)(66556008)(66476007)(8936002)(478600001)(476003)(52116002)(6246003)(486006)(76176011)(6486002)(2501003)(229853002)(6512007)(2616005)(102836004)(5660300002)(186003)(6436002)(386003)(6506007)(31696002)(305945005)(99286004)(11346002)(66066001)(86362001)(446003)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3410;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BP56trd9VdEaxcRGa0KYfdFzuWFOXth0Lf4v9tmZ2/GsFIgGYdIxvyr+y4M3GS4UII64k2LI78u0i30lrTqDXwhfhH/WHaLrazBZenFmowvtFtAFLj27uSEy09paTFwCbJh0W/ZChXJYvg7OZCwfz6+KjHmgdXgSDykSPnWUTxNSxhSwcVE96sujuyfepU09sHLpYwfMswHhfdqDmZRBLeOnB7vhDWGezzmBof7cI8wYQ6afQURoOxLSagVqo+EwfOF8XAqmQd9yvIXuwPXwjzpgkVygGNgGYRbU1n9gAYJMprFUBCLUrv5KUKMLHiAASkq5Jgai+Lftxuio4gok+PxLFQiJbOmYtTBEsyL62bWsS5O/6EV6gfD4mt9gFmatmXoeuBlmjhMxoKqUt6Bzv/HO0F/e7ivP7uklPcMeAcvOhgF4S/FKP4o0l3rcCcvj
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <87294C199334D947A75D9D00241DFB13@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e63914e4-fc78-4120-adfc-08d75eba2a75
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 10:56:36.9135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mi7W9Y9B+4Fi8CSNtUgr7iFP3Th7WjVg7WvtdNarLmhYLuVt6HMgO+KMNjo04Bg7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3410
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQoNCk9uIDIwMTkvMTEvMSDkuIvljYg2OjUyLCBEYXZpZCBTdGVyYmEgd3JvdGU6DQo+IE9uIFNh
dCwgT2N0IDI2LCAyMDE5IGF0IDA2OjExOjI3UE0gKzA4MDAsIFF1IFdlbnJ1byB3cm90ZToNCj4+
ICsJLyoNCj4+ICsJICogTG9nIHRyZWUgb25seSBleGlzdHMgaW4gdGhlIHByaW1hcnkgc3VwZXIg
YmxvY2ssIHNvIFNCUkVBRF9ERUZBVUxUDQo+PiArCSAqIGlzIGVub3VnaC4NCj4gDQo+IEZvciBy
ZWFkIGl0IHNob3VsZCBiZSBlbm91Z2ggdG8gcmVhZCB0aGUgZGVmYXVsdCBvbmUsIGJ1dCBkbyB5
b3UgbWVhbg0KPiB0aGF0IDFzdCBhbmQgMm5kIGNvcHkgZG9uJ3QgaGF2ZSB0aGUgbG9nX3Jvb3Qg
dmFsdWVzIHNldD8gVGhleSdyZQ0KPiB3cml0dGVuIGZyb20gdGhlIHNhbWUgYnVmZmVyIHNvIEkn
ZCBleHBlY3QgdGhlIGNvbnRlbnRzIHRvIGJlIHRoZSBzYW1lLg0KDQpMb2cgdHJlZSB1cGRhdGUg
b25seSBoYXBwZW5zIGZvciBwcmltYXJ5IHNiLg0KDQpUaGUga2VybmVsIGNvZGUgaGFzIHRoaXM6
DQoNCmJ0cmZzX3N5bmNfbG9nKCkNCnwtIHJldCA9IHdyaXRlX2FsbF9zdXBlcnMoZnNfaW5mbywg
MSkNCiAgIHwtIHdyaXRlX2Rldl9zdXBlcnMobWF4X21pcnJvcnMpOyAjIG1heF9taXJyb3JzID09
IDENCiAgICAgIHwtIGZvciAoaSA9IDA7IGkgPCBtYXhfbWlycm9yczsgaSsrKQ0KDQo+IA0KPj4g
KwlyZXQgPSBidHJmc19yZWFkX2Rldl9zdXBlcihmZCwgc2IsIEJUUkZTX1NVUEVSX0lORk9fT0ZG
U0VULA0KPj4gKwkJCQkgICBTQlJFQURfREVGQVVMVCk7DQo+PiArCWlmIChyZXQgPCAwKSB7DQo+
PiArCQllcnJubyA9IC1yZXQ7DQo+PiArCQllcnJvcigiZmFpbGVkIHRvIHJlYWQgc3VwZXIgYmxv
Y2sgb24gJyVzJzogJW0iLCBkZXZuYW1lKTsNCj4+ICsJCWdvdG8gY2xvc2VfZmQ7DQo+PiAgCX0N
Cj4+ICANCj4+IC0Jc2IgPSByb290LT5mc19pbmZvLT5zdXBlcl9jb3B5Ow0KPj4gIAlwcmludGYo
IkNsZWFyaW5nIGxvZyBvbiAlcywgcHJldmlvdXMgbG9nX3Jvb3QgJWxsdSwgbGV2ZWwgJXVcbiIs
DQo+PiAgCQkJZGV2bmFtZSwNCj4+ICAJCQkodW5zaWduZWQgbG9uZyBsb25nKWJ0cmZzX3N1cGVy
X2xvZ19yb290KHNiKSwNCj4+ICAJCQkodW5zaWduZWQpYnRyZnNfc3VwZXJfbG9nX3Jvb3RfbGV2
ZWwoc2IpKTsNCj4+IC0JdHJhbnMgPSBidHJmc19zdGFydF90cmFuc2FjdGlvbihyb290LCAxKTsN
Cj4+IC0JQlVHX09OKElTX0VSUih0cmFucykpOw0KPj4gIAlidHJmc19zZXRfc3VwZXJfbG9nX3Jv
b3Qoc2IsIDApOw0KPj4gIAlidHJmc19zZXRfc3VwZXJfbG9nX3Jvb3RfbGV2ZWwoc2IsIDApOw0K
Pj4gLQlidHJmc19jb21taXRfdHJhbnNhY3Rpb24odHJhbnMsIHJvb3QpOw0KPj4gLQljbG9zZV9j
dHJlZShyb290KTsNCj4+ICsJYnRyZnNfY3N1bV9kYXRhKGJ0cmZzX3N1cGVyX2NzdW1fdHlwZShz
YiksICh1OCAqKXNiICsgQlRSRlNfQ1NVTV9TSVpFLA0KPj4gKwkJCXJlc3VsdCwgQlRSRlNfU1VQ
RVJfSU5GT19TSVpFIC0gQlRSRlNfQ1NVTV9TSVpFKTsNCj4+ICsJbWVtY3B5KCZzYi0+Y3N1bVsw
XSwgcmVzdWx0LCBCVFJGU19DU1VNX1NJWkUpOw0KPj4gKwlyZXQgPSBwd3JpdGU2NChmZCwgc2Is
IEJUUkZTX1NVUEVSX0lORk9fU0laRSwgQlRSRlNfU1VQRVJfSU5GT19PRkZTRVQpOw0KPiANCj4g
U28gdGhpcyBvbmx5IHdyaXRlcyBvbiB0aGUgb25lIGRldmljZSB0aGF0J3MgcGFzc2VkIHRvIHRo
ZSBjb21tYW5kLg0KPiBQcmV2aW91c2x5IGl0IHdvdWxkIHVwZGF0ZSBzdXBlcmJsb2NrcyBvbiBh
bGwgZGV2aWNlcy4NCg0KT2gsIHlvdSBnb3QgbWUuDQoNClRoYXQncyBpbmRlZWQgdGhlIGNhc2Uu
IEkgZ3Vlc3Mgd2UgbmVlZCB0byBkbyB0aGUgc2FtZSBza2lwX2JnIGJlaGF2aW9yDQpqdXN0IGxp
a2Uga2VybmVsIHRvIGhhbmRsZSBtdWx0aXBsZSBkZXZpY2VzLg0KDQpUaGFua3MsDQpRdQ0K
