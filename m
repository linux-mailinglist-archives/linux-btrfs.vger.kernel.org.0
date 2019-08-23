Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2840B9AB91
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2019 11:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388313AbfHWJn2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Aug 2019 05:43:28 -0400
Received: from mail-eopbgr1360042.outbound.protection.outlook.com ([40.107.136.42]:47040
        "EHLO AUS01-ME1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387777AbfHWJn1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Aug 2019 05:43:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnJRrEW2TZqhYxFYxOZNwjRV5DMUSrf+eAHmGvEuj2M45aZESqvIxk2+rlG5brQK3+XK5q4lMlTqJtU6NzEuFYNFA5oSU7tpGbt8e92vwIhPp5id096JjNMGBYfXxoKNFN8eflStrcuSWhS2uxXOKwzZxvx6XtGX8HIMXnChiBb9twkUVG8eh4aPjGRUcq8QBOxJt7T3dmJGQ+BVUV+yG4p9CFbzFQpZk6GKQwpF2Oi1iSB0XRBiDe31NKq/fzCXu9jbv0JteiijEsDdQKBQj8L4dWc8ZmiedJZTbQSWzEmT+RrJwZCUKNI+aGgLDofBKkaHc4r+LwxI8ORz6YIoVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qfu4LFeUlqz3rLpg2ipROH2hktHorw+cA9ZVxlD1qN8=;
 b=cJO78twrvKT24x0PZSirnovsZXMJsnH8Ic6vztYds0o/f9yIAoZv0qHTA10mM7omF0xnFYpLXjrw9RfLM3FOkZK+7YxweAAtYh89/KCPsDKMKnRrkGdoa0+/PPli9zrX2JLa7GV+ohYkSXOF1VcJ6UHWUFZy9WIxYaigIL8jlqEpoqy++F7PsPFD4UhKTP09SsqVnM280s5t7nZE4SwQBAU1FBZ+Cj9N3zYLNM3CzeqZHR6EW9zD5/cQEaad9M4+UFCS9flFsSVdUz5E6dZCISZXzJ0fHAnH8PkLyw34BgPHJ11gU/LqGz41c+FXAFM4GavCeOQa8Y0bcBA7O32ThA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=pauljones.id.au; dmarc=pass action=none
 header.from=pauljones.id.au; dkim=pass header.d=pauljones.id.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oakvillepondscapes.onmicrosoft.com;
 s=selector2-oakvillepondscapes-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qfu4LFeUlqz3rLpg2ipROH2hktHorw+cA9ZVxlD1qN8=;
 b=CbbHWNpPiceBFz6qHlpGARSD7MviHIz/lNVt8TsyM1AN4XClm5tn7/TypAuhonkHlca1rWTpmWkNO4vzcJ2VhTXVAxNWLqPGrb8ZLWFMKWW9Ay4aqFqh6rBTh5ST1G4f2HRXDl5QWqMes4tB1nx9ViTtiAHcRJyn7btoYap0Vy8=
Received: from SYCPR01MB5086.ausprd01.prod.outlook.com (20.178.187.213) by
 SYCPR01MB3917.ausprd01.prod.outlook.com (20.177.142.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Fri, 23 Aug 2019 09:43:22 +0000
Received: from SYCPR01MB5086.ausprd01.prod.outlook.com
 ([fe80::a4a3:7933:106d:97cd]) by SYCPR01MB5086.ausprd01.prod.outlook.com
 ([fe80::a4a3:7933:106d:97cd%6]) with mapi id 15.20.2178.020; Fri, 23 Aug 2019
 09:43:22 +0000
From:   Paul Jones <paul@pauljones.id.au>
To:     Paul Jones <paul@pauljones.id.au>,
        Peter Becker <floyd.net@gmail.com>,
        =?utf-8?B?SG9sZ2VyIEhvZmZzdMOkdHRl?= 
        <holger@applied-asynchrony.com>
CC:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: RE: [PATCH v2 0/4] Support xxhash64 checksums
Thread-Topic: [PATCH v2 0/4] Support xxhash64 checksums
Thread-Index: AQHVWN5sZym6CkEPx0WNaunvpntJ1acHGJSAgAA1gYCAASHToIAADGHw
Date:   Fri, 23 Aug 2019 09:43:22 +0000
Message-ID: <SYCPR01MB5086BAB60D850EBC8FE046E49EA40@SYCPR01MB5086.ausprd01.prod.outlook.com>
References: <20190822114029.11225-1-jthumshirn@suse.de>
 <ed9e2eaa-7637-9752-94bb-fd415ab2b798@applied-asynchrony.com>
 <CAEtw4r01JMFqszs0bBeeU3OXLqbT5+cU+4ZP282J3cvYzALgZg@mail.gmail.com>
 <SYCPR01MB5086F030FA4FD295783638B99EA40@SYCPR01MB5086.ausprd01.prod.outlook.com>
In-Reply-To: <SYCPR01MB5086F030FA4FD295783638B99EA40@SYCPR01MB5086.ausprd01.prod.outlook.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=paul@pauljones.id.au; 
x-originating-ip: [203.213.69.224]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f3fdf94-b863-4a49-a186-08d727ae568b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:SYCPR01MB3917;
x-ms-traffictypediagnostic: SYCPR01MB3917:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SYCPR01MB39170B004BD29339CF9EF5759EA40@SYCPR01MB3917.ausprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-forefront-prvs: 0138CD935C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39830400003)(396003)(366004)(136003)(346002)(199004)(189003)(13464003)(4326008)(110136005)(86362001)(76176011)(7696005)(99286004)(53936002)(81156014)(8936002)(6246003)(316002)(2940100002)(256004)(25786009)(8676002)(478600001)(33656002)(71200400001)(71190400001)(81166006)(6306002)(6116002)(55016002)(6436002)(9686003)(3846002)(229853002)(2906002)(476003)(102836004)(53546011)(486006)(26005)(186003)(14454004)(5660300002)(66066001)(74316002)(6506007)(66446008)(52536014)(305945005)(7736002)(11346002)(66476007)(446003)(76116006)(66556008)(64756008)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:SYCPR01MB3917;H:SYCPR01MB5086.ausprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: pauljones.id.au does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hUF3zunGklLzxfhAsRYLsijteVWq054c6LdMPSLYv8LW3UgIy7l+XI+RcXVHPUqERUcCU7BsN+NJtofPmLSv4ONw7+e7k5UU+bPqq2j9AptN5qT3bT8VK1vkI/GpYeHhPmzsrLFu41wXGJHEJI3U2gDpS5Sdr8gQfiht1H2GeRnXMeEG1Wv7q8n94E8KtxV5iDe+RxF7nrTgcBkRyEqNEvn5jgE3xwdjL9lasjTg8pNz16pqsc1/r8SXh+VNGwQd3681RrLVO55CHE1bmRfMo7yuLXQy2GF6zQdLOmEGIr/MC7jgGndmDir/mwX78bFPdu//4Jd3ziK+TaGfzX84Ae/RzfgdW7lNm1IfHEMrJVc7olW7aXVDUQti8FwXTfuGImMesFzlyDVgkiBtBbeEWiuMzOQ4bFar/LaUqNVa6B4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: pauljones.id.au
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f3fdf94-b863-4a49-a186-08d727ae568b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2019 09:43:22.5059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8f216723-e13f-4cce-b84c-58d8f16a0082
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SUZMEfTrzLYAlo8e2L8P6N8pZF835tchQuSEf3dco0YAM/SlcCjIuBvgolL+Pb9HttN6u0ZEOU1ELf8bZAKPTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYCPR01MB3917
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGludXgtYnRyZnMtb3du
ZXJAdmdlci5rZXJuZWwub3JnIDxsaW51eC1idHJmcy0NCj4gb3duZXJAdmdlci5rZXJuZWwub3Jn
PiBPbiBCZWhhbGYgT2YgUGF1bCBKb25lcw0KPiBTZW50OiBGcmlkYXksIDIzIEF1Z3VzdCAyMDE5
IDc6MzkgUE0NCj4gVG86IFBldGVyIEJlY2tlciA8ZmxveWQubmV0QGdtYWlsLmNvbT47IEhvbGdl
ciBIb2Zmc3TDpHR0ZQ0KPiA8aG9sZ2VyQGFwcGxpZWQtYXN5bmNocm9ueS5jb20+DQo+IENjOiBM
aW51eCBCVFJGUyBNYWlsaW5nbGlzdCA8bGludXgtYnRyZnNAdmdlci5rZXJuZWwub3JnPg0KPiBT
dWJqZWN0OiBSRTogW1BBVENIIHYyIDAvNF0gU3VwcG9ydCB4eGhhc2g2NCBjaGVja3N1bXMNCj4g
DQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBsaW51eC1idHJmcy1v
d25lckB2Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LWJ0cmZzLQ0KPiA+IG93bmVyQHZnZXIua2VybmVs
Lm9yZz4gT24gQmVoYWxmIE9mIFBldGVyIEJlY2tlcg0KPiA+IFNlbnQ6IEZyaWRheSwgMjMgQXVn
dXN0IDIwMTkgMTo0MCBBTQ0KPiA+IFRvOiBIb2xnZXIgSG9mZnN0w6R0dGUgPGhvbGdlckBhcHBs
aWVkLWFzeW5jaHJvbnkuY29tPg0KPiA+IENjOiBMaW51eCBCVFJGUyBNYWlsaW5nbGlzdCA8bGlu
dXgtYnRyZnNAdmdlci5rZXJuZWwub3JnPg0KPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMC80
XSBTdXBwb3J0IHh4aGFzaDY0IGNoZWNrc3Vtcw0KPiA+DQo+ID4gQW0gRG8uLCAyMi4gQXVnLiAy
MDE5IHVtIDE2OjQxIFVociBzY2hyaWViIEhvbGdlciBIb2Zmc3TDpHR0ZQ0KPiA+IDxob2xnZXJA
YXBwbGllZC1hc3luY2hyb255LmNvbT46DQo+ID4gPiBidXQgaG93IGRvZXMgYnRyZnMgYmVuZWZp
dCBmcm9tIHRoaXMgY29tcGFyZWQgdG8gdXNpbmcgY3JjMzItaW50ZWw/DQo+ID4NCj4gPiBBcyBp
IGtub3csIGNyYzMyYyAgaXMgYXMgZmFyIGFzIH4zeCBmYXN0ZXIgdGhhbiB4eGhhc2guIEJ1dCB4
eEhhc2ggd2FzDQo+ID4gY3JlYXRlZCB3aXRoIGEgZGlmZmVyZW5kIGRlc2lnbiBnb2FsLg0KPiA+
IElmIHlvdSB1c2luZyBhIGNwdSB3aXRob3V0IGhhcmR3YXJlIGNyYzMyIHN1cHBvcnQsIHh4SGFz
aCBwcm92aWRlcyB5b3UNCj4gPiBhIG1heGltdW0gcG9ydGFiaWxpdHkgYW5kIHNwZWVkLiBMb29r
IGF0IGFybSwgbWlwcywgcG93ZXIsIGV0Yy4gb3Igb2xkDQo+ID4gaW50ZWwgY3B1cyBsaWtlIENv
cmUgMiBEdW8uDQo+IA0KPiBJJ3ZlIGdvdCBhIG1vZGlmaWVkIHZlcnNpb24gb2Ygc21oYXNoZXIN
Cj4gKGh0dHBzOi8vZ2l0aHViLmNvbS9QZWVKYXkvc21oYXNoZXIpIHRoYXQgdGVzdHMgc3BlZWQg
YW5kIGNyeXB0b2dyYXBoaWNzDQo+IG9mIHZhcmlvdXMgaGFzaGluZyBmdW5jdGlvbnMuDQoNCkkg
Zm9yZ290IHRvIGFkZCB4eGhhc2gzMg0KIA0KQ3JjMzIgU29mdHdhcmUgLSAgMzc5LjkxIE1pQi9z
ZWMNCkNyYzMyIEhhcmR3YXJlIC0gNzMzOC42MCBNaUIvc2VjDQpYWGhhc2g2NCBTb2Z0d2FyZSAt
IDEyMDk0LjQwIE1pQi9zZWMNClhYaGFzaDMyIFNvZnR3YXJlIC0gNjA2MC4xMSBNaUIvc2VjDQoN
ClRlc3RpbmcgZG9uZSBvbiBhIDFzdCBHZW4gUnl6ZW4uIEltcHJlc3NpdmUgbnVtYmVycyBmcm9t
IFhYaGFzaDY0Lg0KIA0KIA0KUGF1bC4NCg==
