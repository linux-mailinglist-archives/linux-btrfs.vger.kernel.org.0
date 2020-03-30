Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B208C19742D
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Mar 2020 08:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbgC3GA3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Mar 2020 02:00:29 -0400
Received: from mail-eopbgr1370052.outbound.protection.outlook.com ([40.107.137.52]:43520
        "EHLO AUS01-SY3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728569AbgC3GA3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Mar 2020 02:00:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z50KXaU6RHUCIh4q/VVsUAAknZVYPysEonZb9vrA3rzaqKvJ3WbUk9Ylvb9C/hi5IdCuvaFAYn4WSViliRwP1bVcRjxUVKqWqNcE1SSlQNxWTPXl1ks8u8vgzpTy85JP8Vy1oj0EcnJmwrW0NIO4ZECcO2Sfw+0rBTtAhqs4pU0BXq4kISkdrELGeqNv2gn7xMAmsWQQB8gxPUv8BjRFbC7VztOJccEAUeIdDJaDcvqv3VdZZ0HKqX/NyQTfP2KFaR1g28MOiPw5Ic2oICVTBgNov3zGINksAVlWio+wY1O8HUjC5GWbzcFOreiieqj5dDS7/DQQZs4jDLIcZhtxGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Zy3KUAtF58OpAQLfAFLXmjQou1lXIOiszAL5VwVY+0=;
 b=YRAOeMAxPz9fq/5TRvNmuFH8KZ56ta+9jfwpssbBNhGYIgAfOJq8RxJs5IS59hXpfFEmsmiBns8oGOFHd4jEUXRCWEb4UihRTWZHSzSUvuueyS1GYWkWjKtMhoGErXpo8VThGWUgemAyZH5r4DAra9v/x08pzzQv2K09eeTt9Y+p8wO1MaC6zzngzAYTxlDscHMQ/GAyuwS0d/nOr4MpKpM8B5gXE3X6/rsnpFEY7EV2tCldNdaT5DOuqoXgE6J5sa6nkgrquzRPpoef0FnyQ38HJu7vTR93nvKucbQzCEAi4JWXTnQiGGQkLfzKEdwU5dIYtgyWr4w3l4WAXVqggQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=pauljones.id.au; dmarc=pass action=none
 header.from=pauljones.id.au; dkim=pass header.d=pauljones.id.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oakvillepondscapes.onmicrosoft.com;
 s=selector2-oakvillepondscapes-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Zy3KUAtF58OpAQLfAFLXmjQou1lXIOiszAL5VwVY+0=;
 b=d1kLfHzdaL1j2XW3uMpv58Bv4vUtQLr5K4fo4Q+X0bGoIGydZ80FabWg+VLMaKqvA/7An7fo05fP/Hbcyfue7AyEfvz8H6S3d+kGEIhrApJe8OAakfC0DQV9g57S1apIBkxWiGjm7oBxuHAUZuernlCLRPKwAxuN1k9lX+wIFfE=
Received: from SYBPR01MB3897.ausprd01.prod.outlook.com (20.177.136.214) by
 SYBPR01MB4681.ausprd01.prod.outlook.com (20.178.191.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.19; Mon, 30 Mar 2020 06:00:23 +0000
Received: from SYBPR01MB3897.ausprd01.prod.outlook.com
 ([fe80::790e:69fb:3a25:5092]) by SYBPR01MB3897.ausprd01.prod.outlook.com
 ([fe80::790e:69fb:3a25:5092%5]) with mapi id 15.20.2835.026; Mon, 30 Mar 2020
 06:00:23 +0000
From:   Paul Jones <paul@pauljones.id.au>
To:     Andrei Borzenkov <arvidjaar@gmail.com>,
        Victor Hooi <victorhooi@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: RE: Using Intel Optane to accelerate a BTRFS array? (equivalent of
 ZLOG/SIL for ZFS?)
Thread-Topic: Using Intel Optane to accelerate a BTRFS array? (equivalent of
 ZLOG/SIL for ZFS?)
Thread-Index: AQHWBhmyde6vd4eElE+hAbAB5ePfGqhgoOOAgAABvhA=
Date:   Mon, 30 Mar 2020 06:00:23 +0000
Message-ID: <SYBPR01MB38978D6654705941C50AF95E9ECB0@SYBPR01MB3897.ausprd01.prod.outlook.com>
References: <CAMnnoULAX9Oc+O3gRbVow54H2p_aAENr8daAtyLR_0wi8Tx7xg@mail.gmail.com>
 <a9b73920-65d5-b973-8578-9659717434b5@gmail.com>
In-Reply-To: <a9b73920-65d5-b973-8578-9659717434b5@gmail.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=paul@pauljones.id.au; 
x-originating-ip: [203.219.29.178]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aaa48f42-9bce-4e1f-440f-08d7d46fa2e6
x-ms-traffictypediagnostic: SYBPR01MB4681:
x-microsoft-antispam-prvs: <SYBPR01MB468110114DEA7898E54D866C9ECB0@SYBPR01MB4681.ausprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0358535363
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SYBPR01MB3897.ausprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(366004)(376002)(39830400003)(346002)(396003)(136003)(508600001)(86362001)(9686003)(66476007)(64756008)(66446008)(66556008)(76116006)(66946007)(55016002)(26005)(2906002)(33656002)(186003)(71200400001)(52536014)(5660300002)(6506007)(53546011)(7696005)(966005)(110136005)(316002)(81166006)(81156014)(8936002)(8676002);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: pauljones.id.au does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3PNAI0VAgYrrlyBxr5ZMMW/nvTtsBiloqah0oSanulamlLKKZewvddD4BhA7dCRlKI8Bouh7koElM32YDZu8mg7fcgmzz2sIqCm3xrL5v2PoZfWtXkwiqJ11kFuztBTwJk0KHTJynyjRNGK+ytkaF+IEYBLHD+2U6VDtVzzqju2v9VCaTM2J4ggVewP4NXQ3GWHKel+w+JJr0JZLUDh8GIg47Vrz4r/yJ3lBBXfLipcGIfekzqy+Ni7CdQXQzGK9zXV2Cb17RdKCX8VoVdpMAbUQBG5FXuM2G+TfCwRjAmhLSzrjg2FECzKfctpAB272Wr3Z5py0q8IhLsl/OKeaAkZhjUMIGC4X88PvmobSPkq4GiQ7xLUk1EuUlnQVPof/An+zM7b78P/te/fBRF8sM2oOY6rTbSmDcRaFjlsqKaBnVBS6oOWCcVWScqIhzqyAMwMCyvxyiCs2pRCpFTWAVQWghHa/1WCmToWBjbPN+AFQKiv+cXpu4+sw2GkdZl8Vt1Z806rhOQ4F3nXwIp6Z3g==
x-ms-exchange-antispam-messagedata: X1kCV7KeuGFbu6Az0ja61Tl4lzgEVhgU0GECTnrBxpIkDM4V7oGXB/KVh5MgX6XICc+HI0Gx6Pe7mI4t9ZMure3qaIvE0itXgPh+iusZMZLqWExoVDqXw2HxZmX3qqvW/FNmll5wxP8LzrmqaPfZkA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: pauljones.id.au
X-MS-Exchange-CrossTenant-Network-Message-Id: aaa48f42-9bce-4e1f-440f-08d7d46fa2e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2020 06:00:23.4493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8f216723-e13f-4cce-b84c-58d8f16a0082
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZF2nAXP/+hj9MOgxdgRUl8g5rHgxL7heBWHuiXzU14J+snjlaaCgyLnYZe3gCSSX5T8ZDAjpLX/R+4+34BBbeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYBPR01MB4681
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1idHJmcy1vd25lckB2
Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LWJ0cmZzLQ0KPiBvd25lckB2Z2VyLmtlcm5lbC5vcmc+IE9u
IEJlaGFsZiBPZiBBbmRyZWkgQm9yemVua292DQo+IFNlbnQ6IE1vbmRheSwgMzAgTWFyY2ggMjAy
MCA0OjQ2IFBNDQo+IFRvOiBWaWN0b3IgSG9vaSA8dmljdG9yaG9vaUBnbWFpbC5jb20+OyBsaW51
eC1idHJmcyA8bGludXgtDQo+IGJ0cmZzQHZnZXIua2VybmVsLm9yZz4NCj4gU3ViamVjdDogUmU6
IFVzaW5nIEludGVsIE9wdGFuZSB0byBhY2NlbGVyYXRlIGEgQlRSRlMgYXJyYXk/IChlcXVpdmFs
ZW50IG9mDQo+IFpMT0cvU0lMIGZvciBaRlM/KQ0KPiANCj4gMzAuMDMuMjAyMCAwMTozMCwgVmlj
dG9yIEhvb2kg0L/QuNGI0LXRgjoNCj4gPiBIaSwNCj4gPg0KPiA+IEkgaGF2ZSBhIHNtYWxsIDEy
LWJheSBTdXBlck1pY3JvIHNlcnZlciBJJ20gdXNpbmcgYXMgYSBsb2NhbCBOQVMsIHdpdGgNCj4g
PiBGcmVlTkFTL1pGUy4NCj4gPg0KPiA+IEVhY2ggZHJpdmUgaXMgYSAxMlRCIEhERC4NCj4gPg0K
PiA+IEknbSBpbiB0aGUgcHJvY2VzcyBvZiBtb3ZpbmcgaXQgdG8gTGludXggLSBhbmQgSSB0aG91
Z2h0IHRoaXMgbWlnaHQgYmUNCj4gPiBhIGdvb2QgY2hhbmNlIHRvIHRyeSBvdXQgQlRSRlMgYWdh
aW4gPSkuDQo+ID4NCj4gPiAoSSdkIHByZXZpb3VzbHkgdHJpZWQgQlRSRlMgbWFueSB5ZWFycyBh
IGdvLCBhbmQgaGl0IHNvbWUgaXNzdWVzIC0NCj4gPiBpdCdzIHBvc3NpYmxlIHRoaXMgbWF5IGhh
dmUgYmVlbiBtYWRlIHdvcnNlIGJ5IG15IGluZXhwZXJpZW5jZSB3aXRoDQo+ID4gQlRSRlMgYXQg
dGhlIHRpbWUgLSBlLmcuDQo+ID4gaHR0cHM6Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMvbGludXgt
YnRyZnMvbXNnMDQyNDAuaHRtbCkNCj4gPg0KPiA+IEFueWhvdyAtIGN1cnJlbnRseSB0aGUgc2Vy
dmVyIGhhcyBhIDc1MEdCIEludGVsIE9wdGFuZSBkcml2ZSwgdGhhdA0KPiA+IHdlJ3JlIHVzaW5n
IGFzIGEgWkxPRy9TSUwgZHJpdmU6DQo+ID4NCj4gDQo+IERvIHlvdSBtZWFuIFpJTC9TTE9HPyBa
SUwgPT0gWkZTIEludGVudCBMb2csIFNMT0cgPT0gU1NEIExvZy4NCj4gDQo+ID4gaHR0cHM6Ly93
d3cuaXhzeXN0ZW1zLmNvbS9jb21tdW5pdHkvdGhyZWFkcy9ob3ctYmVzdC10by11c2UtOTYwZ2It
DQo+IG9wdGENCj4gPiBuZS1pbi1mcmVlbmFzLWJ1aWxkLjc1Nzk4LyNwb3N0LTUyNzI2NA0KPiA+
DQo+ID4gTXkgcXVlc3Rpb24gaXMgLSB3aGF0J3MgdGhlIGVxdWl2YWxlbnQgaW4gQlRSRlMtbGFu
ZD8NCj4gPg0KPiANCj4gTm90IG9uIGJ0cmZzIGxldmVsLiBJIGd1ZXNzIHVzaW5nIGJjYWNoZSBv
biB0b3Agb2YgYnRyZnMgbWF5IGFjaGlldmUgc29tZQ0KPiBzaW1pbGFyIGVmZmVjdHMuDQo+IA0K
PiA+IE9yIHdoYXQgaXMgdGhlIGJlc3Qgd2F5IHRvIHVzZSBhbiB1bHRyYS1mYXN0IEludGVsIE9w
dGFuZSBkcml2ZSB0bw0KPiA+IGFjY2VsZXJhdGUgcmVhZHMvd3JpdGVzIG9uIGEgQlRSRlMgYXJy
YXk/DQo+ID4NCj4gDQo+IA0KPiBaSUwgaXMgKndyaXRlKiBpbnRlbnQgbG9nLCBpdCBkb2VzIG5v
dCBkaXJlY3RseSBhY2NlbGVyYXRlcyByZWFkcy4gWkZTIHN1cHBvcnRzDQo+IFNTRCBhcyBzZWNv
bmQtbGV2ZWwgcmVhZCBjYWNoZSwgYnV0IGFzIGZhciBhcyBJIHJlbWVtYmVyIGl0IGlzIHBoeXNp
Y2FsbHkNCj4gc2VwYXJhdGUgZnJvbSBaSUwuDQoNCkkgaGF2ZSB1c2VkIGNhY2hpbmcgd2l0aCBs
dm0gdW5kZXIgYnRyZnMuIEl0J3MgYSBwYWluIHRvIHNldHVwIGNvcnJlY3RseSBmb3IgYSBidHJm
cyByYWlkMSBzZXR1cCAobmVlZCBzZXBhcmF0ZSB2b2x1bWUgZ3JvdXBzIHdpdGggc2VwYXJhdGUg
bG9naWNhbCB2b2x1bWVzIHRvIGVuc3VyZSBpdCdzIGltcG9zc2libGUgdG8gaGF2ZSB0d28gcmFp
ZDEgc3RyaXBlcyBvbiB0aGUgc2FtZSBwaHlzaWNhbCBkaXNrIHdpdGhvdXQgbm90aWNpbmcgaXQp
IGJ1dCBpdCBkaWQgd29yayBxdWl0ZSB3ZWxsIGFuZCBJIG5ldmVyIGhhZCBhbnkgc3RyYW5nZSBw
cm9ibGVtcyB3aXRoIGl0Lg0KDQpQYXVsLg0K
