Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3746D8F6D
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2019 13:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733215AbfJPL3o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Oct 2019 07:29:44 -0400
Received: from m4a0041g.houston.softwaregrp.com ([15.124.2.87]:49697 "EHLO
        m4a0041g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728372AbfJPL3n (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Oct 2019 07:29:43 -0400
Received: FROM m4a0041g.houston.softwaregrp.com (15.120.17.147) BY m4a0041g.houston.softwaregrp.com WITH ESMTP;
 Wed, 16 Oct 2019 11:28:44 +0000
Received: from M9W0068.microfocus.com (2002:f79:bf::f79:bf) by
 M4W0335.microfocus.com (2002:f78:1193::f78:1193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Wed, 16 Oct 2019 11:19:55 +0000
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (15.124.72.14) by
 M9W0068.microfocus.com (15.121.0.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Wed, 16 Oct 2019 11:19:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4p5hQmMVgF51JPMU9gOz8b08SL3TU5DuD1N7EjdYqt914rxUTKmJiCSwi80F2vI5EyEZbiMnVxbSMJn0sZYqOUGA1YPN1QPBzdz8cVjgBqiZ8nHEXxu8Y1s5W33i2J9tkfFY83yXV6u9/uYeUd+8STvzL2RbLGgONI6zYSYN3b5jQoLacbZPgU4yxx8H1toTBHBhWUVApBgkFBXLnipY7cyqxKGf8mR5Ay6jAD77DweySAcXT5PLlMLs/Wj5adOSJIFA3aXGESyiH8bh6iHEwixa+iNCHQnD51qxpZXt7UNiVBTiqmOmD0fw8/nz28xTl8g9Zi0mGxfFIXYmmm5HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9yVH5rMXjaR524AKF1XnKt+0aks3+88uGofnN0DRq4w=;
 b=d6Ft5j2wgu21iOeeT5NkKYyvNwcEiYLF39LZSqDoq4/3eSbKMUtZi1YgFgGnD+x0Ri7jbjgv2XYj5mPTaXRCxovdOjodD95EFJcStizoQwQSTpMkwarIjISKWRzipjOamB05/QS6emoTKbV53+PkCuZ48lsqX3bt6CJ5D93bVr1hpbTHk29cjGGcqTXXgaJxRdnAxANGkzRBV8Kjl+1SUa/sCiJ4H+h4PhUVJcc5rp2N0pWkqPUHURiFTXjpr03RqwyY6f2Z8fReQVcjOjyHCXFbwnD7+9RyBJ0FT/0rEUTqUobKOXGMKl9hXW2Z8qefXHGmAJNdk3y9WO9LoXtQVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3219.namprd18.prod.outlook.com (10.255.137.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Wed, 16 Oct 2019 11:19:54 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::5c5:8dae:70ef:a254]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::5c5:8dae:70ef:a254%4]) with mapi id 15.20.2347.023; Wed, 16 Oct 2019
 11:19:54 +0000
From:   Qu WenRuo <wqu@suse.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 0/7] btrfs-progs: Support for BG_TREE feature
Thread-Topic: [PATCH v2 0/7] btrfs-progs: Support for BG_TREE feature
Thread-Index: AQHVgqLZuZDEAN9fMkK3jrWbqYgTiKda2vDrgAJF/YCAAAEGAA==
Date:   Wed, 16 Oct 2019 11:19:54 +0000
Message-ID: <7c625485-1e2b-77f5-26ac-9386175e2621@suse.com>
References: <20191008044936.157873-1-wqu@suse.com>
 <20191014151723.GP2751@twin.jikos.cz>
 <1d23e48d-8908-5e1c-0c56-7b6ccaef5d27@gmx.com>
 <20191016111605.GB2751@twin.jikos.cz>
In-Reply-To: <20191016111605.GB2751@twin.jikos.cz>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: TYCPR01CA0083.jpnprd01.prod.outlook.com
 (2603:1096:405:3::23) To BY5PR18MB3266.namprd18.prod.outlook.com
 (2603:10b6:a03:1a1::15)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [13.231.109.76]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae17e125-c9cf-4194-b97b-08d7522ac4b7
x-ms-traffictypediagnostic: BY5PR18MB3219:
x-microsoft-antispam-prvs: <BY5PR18MB3219779E8C64E36D61508B73D6920@BY5PR18MB3219.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0192E812EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(199004)(189003)(25786009)(6506007)(99286004)(71190400001)(8936002)(81166006)(81156014)(8676002)(186003)(31686004)(76176011)(52116002)(102836004)(71200400001)(14454004)(66066001)(2501003)(386003)(110136005)(5660300002)(26005)(86362001)(316002)(31696002)(478600001)(11346002)(486006)(7736002)(476003)(6116002)(2906002)(3846002)(256004)(14444005)(6436002)(2616005)(446003)(305945005)(36756003)(66476007)(66446008)(64756008)(66556008)(66946007)(6486002)(6246003)(6512007)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3219;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v9Rg3S5NcW47kQeqXkUyIqBb+tzhRC9lvKdiEVcWbuBFQ30PyXFwoFSbITMWQrcLtZeyugbsPg0HbIHKa/wX1T1Tnk8MjnBJDgMrFiP40lihLPRM8os41h8G2bnsBIgGaTjbyg8hnj0q7h/faXe/sXkwrHvjGaGbHAwDlUVNG0v87j03EWxS3hbliTp/etuYtWJM/Fz38Wnts5Bx1bPaw8yWntSD7QjNhrzuxih0U9UBImhGjqM8BhWlGQ2zu7/lR3+fyjYDEp2xqEONGdjsMQXo07Mnk0bYRCJUeyFqKBYOHHMcCFOEI9avmxrI8Jmy3yUO4gLs2XYhB4KIz6WSBwgjhX9XMfy/LBJg1KnwDCjxIiodhAdqXQMn73v6P2uXKJys0n1kq1txQopDI3oXCsskyqIeJZC0YNdKYCcP9zU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0876FEAACC015E4981BF495099FC5AEF@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ae17e125-c9cf-4194-b97b-08d7522ac4b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2019 11:19:54.0542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9gD+oyA0GTlgdOtyTi88dCIlVbnrdDlu7J3vmgHTrUta3Azn/U2fUcxzHtATr2w2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3219
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQoNCk9uIDIwMTkvMTAvMTYg5LiL5Y2INzoxNiwgRGF2aWQgU3RlcmJhIHdyb3RlOg0KPiBPbiBU
dWUsIE9jdCAxNSwgMjAxOSBhdCAwODozMjozMEFNICswODAwLCBRdSBXZW5ydW8gd3JvdGU6DQo+
Pj4gSGF2ZSB3ZSBzZXR0bGVkIHRoZSBhcmd1bWVudCB3aGV0aGVyIHRvIHVzZSBhIG5ldyB0cmVl
IG9yIGtleSB0cmlja3MgZm9yDQo+Pj4gdGhlIGJsb2Nncm91cCBkYXRhPyBJIHRoaW5rIHdlIGhh
dmUgbm90IGFuZCB3aWxsIHJlYWQgdGhlIHByZXZpb3VzDQo+Pj4gZGlzY3Vzc2lvbnMuIEZvciBh
IGZlYXR1cmUgbGlrZSB0aGlzIEkgd2FudCB0byBiZSBzdXJlIHdlIHVuZGVyc3RhbmQgYWxsDQo+
Pj4gdGhlIHByb3MgYW5kIGNvbnMuDQo+Pj4NCj4+IFllcCwgd2UgaGF2ZW4ndCBzZXR0bGVkIG9u
IHRoZSB3aGV0aGVyIGNyZWF0aW5nIGEgbmV3IHRyZWUsIG9yDQo+PiByZS1vcmdhbml6ZSB0aGUg
a2V5cy4NCj4+DQo+PiBCdXQgYXMgbXkgbGFzdCBkaXNjdXNzaW9uIHNhaWQsIEkgc2VlIG5vIG9i
dmlvdXMgcHJvIHVzaW5nIHRoZSBleGlzdGluZw0KPj4gZXh0ZW50IHRyZWUgdG8gaG9sZCB0aGUg
bmV3IGJsb2NrIGdyb3VwIGl0ZW0ga2V5cywgZXZlbiB3ZSBjYW4gcGFjayB0aGVtDQo+PiBhbGwg
dG9nZXRoZXIuDQo+IA0KPiBGb3IgbWUgdGhlIG9idmlvdXMgcHJvIGlzIG1pbmltdW0gY2hhbmdl
IHRvIGV4aXN0aW5nIHNldCBvZiB0cmVlcy4NCg0KVGhhdCdzIGludGVyZXN0aW5nLg0KDQpBbmQg
aW5kZWVkLCBzaW5jZSB3ZSdyZSBkZWFsaW5nIG9uZSBsZXNzIHRyZWUsIHRoZXJlIGlzIG5vIGNo
YW5jZSB0bw0KY2F1c2UgdGhlIGJ1ZyBtZW50aW9uZWQgYnkgSm9zZWYuDQo+IA0KPj4gQW5kIGZv
ciBiYWNrdXAgcm9vdHMsIGluZGVlZCBJIGZvcmdvdCB0byBhZGQgdGhpcyBmZWF0dXJlLg0KPj4g
QnV0IHRvIG1lIHRoYXQncyBhIG1pbm9yIHBvaW50LCBub3QgYSBzaG93IHN0b3BwZXIuDQo+Pg0K
Pj4gVGhlIG1vc3QgaW1wb3J0YW50IGFzcGVjdCB0byBtZSBpcywgdG8gYWxsb3cgcmVhbCB3b3Js
ZCB1c2VyIG9mIHN1cGVyDQo+PiBsYXJnZSBmcyB0byB0cnkgdGhpcyBmZWF0dXJlLCB0byBwcm92
ZSB0aGUgdXNlZnVsbmVzcyBvZiB0aGlzIGRlc2lnbiwNCj4+IG90aGVyIHRoYW4gbXkgb24tcGFw
ZXIgYW5hbHlzZS4NCj4+DQo+PiBUaGF0J3Mgd2h5IEknbSBwdXNoaW5nIHRoZSBwYXRjaHNldCwg
ZXZlbiBpdCBtYXkgbm90IHBhc3MgYW55IHJldmlldy4NCj4+IEkganVzdCB3YW50IHRvIGhvbGQg
YSB1cC10by1kYXRlIGJyYW5jaCBzbyB0aGF0IHdoZW4gc29tZSBvbmUgbmVlZHMsIGl0DQo+PiBj
YW4gZ3JhYiBhbmQgdHJ5IHRoZW0gdGhlbXNlbHZlcy4NCj4gDQo+IE9rIHRoYXQncyBmaW5lIGFu
ZCBJIGNhbiBhZGQgdGhlIGJyYW5jaCB0byBmb3ItbmV4dCBmb3IgZWFzZSBvZiB0ZXN0aW5nLg0K
PiBJJ20gd29ya2luZyBvbiBhIHByb3RvdHlwZSB0aGF0IGRvZXMgaXQgdGhlIGJnIGl0ZW0ga2V5
IHdheSwgaXQgY29tcGlsZXMNCj4gYW5kIGNyZWF0ZXMgYWxtb3N0IGNvcnJlY3QgZmlsZXN5c3Rl
bSwgc28gSSBoYXZlIHRvIGZpeCBpdCBiZWZvcmUNCj4gcG9zdGluZy4gVGhlIHBhdGNoZXMgYXJl
IG9uIHRvcCBvZiB5b3VyIGJnLXRyZWUgZmVhdHVyZSBzbyB3ZSBjb3VsZCBoYXZlDQo+IGJvdGgg
aW4gdGhlIHNhbWUga2VybmVsIGZvciB0ZXN0aW5nLg0KDQpUaGF0J3MgZ3JlYXQhDQoNCkFzIGxv
bmcgYXMgd2UncmUgcHVzaGluZyBhIHNvbHV0aW9uIHRvIHRoZSBtb3VudCB0aW1lIHByb2JsZW0s
IEkgY2FuJ3QNCmJlIG1vcmUgaGFwcGllciENCg0KVGhlbiBJIGd1ZXNzIG5vIG1hdHRlciB3aGlj
aCB2ZXJzaW9uIGdldCBtZXJnZWQgdG8gdXBzdHJlYW0sIHRoZQ0KcGF0Y2hzZXQgaXMgYWxyZWFk
eSBtZWFuaW5nZnVsLg0KDQpUaGFua3MsDQpRdQ0K
