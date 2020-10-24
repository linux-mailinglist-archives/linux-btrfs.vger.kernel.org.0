Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE82297A85
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Oct 2020 05:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759383AbgJXD0n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Oct 2020 23:26:43 -0400
Received: from mail-eopbgr1360075.outbound.protection.outlook.com ([40.107.136.75]:46722
        "EHLO AUS01-ME1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1759168AbgJXD0n (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Oct 2020 23:26:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQOEadmdkyDtcs8GMW8BgqbpqMoncU5q/KNGRHtZ68meB+2rox07H5Ws5YIvO91p9yE7sr5wrP1VSXMEW4IM/GzO8yY0IW0E66SQLK5ZKs8Viqq8BP1/OL8p2vZNaBhBezuyEqYInb8sOqesxqB4E+Zoo36rb4DKebkgFg62sVj+14KPq9mheSYamiZu7AoeHm9w3d1lFCumowREjhPmbgRdNuHCARg+3O8H+ZuT3J/ErD27Rz3zCdmbdwbce5SOMb6t7FOXILJLCFRSSvL+bWm2sdvgEBAlT88sOUoq6bgSA0fa5PRY0FHNLezcUh8MnwUNY6xQ2VxdoEqxpCPSSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkGBdZi5m6wRzxXKlFJhmQa4GrgpkjbKRC6Hf3kVP6U=;
 b=nu9miQm2yUbRZIdfWt2QsZE6M0wuFRW/1AVFYmcQAUnzicPuxzw8YaOCg2vP9XZfUzKnENdFEgvmCARlkxeHCqj5BW1KudzinrFLven4diVMIx+LkPLGFAvLiXctQ99LQSJT1ErgM8QhBU8Gd54UPxLy1BjmfnsPcl7+qgY+iL+z4HDPRtMAL7mBmjwiHVF/gJ14MOr1KuHsqev+bEDrgeUWjiyA1JpeO7koLXoVczn9/J8brlj4MYK2kNktn9EL1iNiz2/6xofbqPmQj/6sOLWRu0qzYjroyNwv0j6gpIyzXSmimlxd+bfzedydVn93df57sOhVDdKaFP4LtBpJqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=pauljones.id.au; dmarc=pass action=none
 header.from=pauljones.id.au; dkim=pass header.d=pauljones.id.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oakvillepondscapes.onmicrosoft.com;
 s=selector2-oakvillepondscapes-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkGBdZi5m6wRzxXKlFJhmQa4GrgpkjbKRC6Hf3kVP6U=;
 b=r8SZiBr5adMs/j7EPvNX4p8bL1dWI+BH1ngBlEBSlblaqmDm/w+Ud3jm32hW4Cf8u8iVhTttxyvHJ0PaC4A4FzoHWnxhOaf417+g+DfXkTcu0nLr5APeMC1Clo+c1dEZjsB5d7CA8ojjE4d1RhG1SeveNYs9FTBKy2wnnIpsEao=
Received: from SYXPR01MB1918.ausprd01.prod.outlook.com (2603:10c6:0:2b::11) by
 SYXPR01MB0655.ausprd01.prod.outlook.com (2603:10c6:0:c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18; Sat, 24 Oct 2020 03:26:37 +0000
Received: from SYXPR01MB1918.ausprd01.prod.outlook.com
 ([fe80::c82d:72c:aa17:3bf9]) by SYXPR01MB1918.ausprd01.prod.outlook.com
 ([fe80::c82d:72c:aa17:3bf9%11]) with mapi id 15.20.3477.028; Sat, 24 Oct 2020
 03:26:37 +0000
From:   Paul Jones <paul@pauljones.id.au>
To:     "kreijack@inwind.it" <kreijack@inwind.it>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
CC:     Adam Borowski <kilobyte@angband.pl>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Michael <mclaud@roznica.com.ua>, Hugo Mills <hugo@carfax.org.uk>,
        Martin Svec <martin.svec@zoner.cz>
Subject: RE: [PATCH] btrfs: add ssd_metadata mode
Thread-Topic: [PATCH] btrfs: add ssd_metadata mode
Thread-Index: AQHWqQ1orAVs+dijZkOOeChAwp/e4qmk97eAgAAUgwCAABRFgIAAWxiAgACaGXA=
Date:   Sat, 24 Oct 2020 03:26:37 +0000
Message-ID: <SYXPR01MB1918A247417AB89140137E059E1B0@SYXPR01MB1918.ausprd01.prod.outlook.com>
References: <20201023101145.GB19860@angband.pl>
 <d7ee1c25-ceea-0471-9702-0622a5ef4453@gmx.com>
 <20201023203742.B13F.409509F4@e16-tech.com>
 <4276e368-411e-8037-9162-c4d2b906c5d2@libero.it>
In-Reply-To: <4276e368-411e-8037-9162-c4d2b906c5d2@libero.it>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: inwind.it; dkim=none (message not signed)
 header.d=none;inwind.it; dmarc=none action=none header.from=pauljones.id.au;
x-originating-ip: [123.243.10.55]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2cd5de59-76a7-423a-baf0-08d877cc9da5
x-ms-traffictypediagnostic: SYXPR01MB0655:
x-microsoft-antispam-prvs: <SYXPR01MB0655D828DEF3ED5EDD86D64E9E1B0@SYXPR01MB0655.ausprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0Eb2gHRL6FKS5FhJsODy1i6QiWD6+HWoBCOIowbW7uR3dCDMMjKGF0d78dp9zSCJQQaR3AS3yQsU5iFGaYC4Y1wfO+V+NrBSXj/Xc9a5CPF4QM8xZT+0SRoH8LqRoHv9d+w/R+FwkBgKW3xVyx8QpdX0S1QF9Wo2uDw9TwwsgsC6pHLxqEB67JBCddYNX2gcY8lkav+m9jUsi94dhxDl3J+5gRm1UlXOMM+6NXkj4u0CddZUxG/W+aaTineqMrvMAUSFEWpJFquQWYtAUnozdHx36Gw54XuyJtMUypy2xr042havDCj4/wxKZiOyfBeR75PWA16VkZlQnidLGYxWmg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SYXPR01MB1918.ausprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(39830400003)(396003)(366004)(346002)(7696005)(2906002)(86362001)(6506007)(83380400001)(5660300002)(76116006)(52536014)(55016002)(4326008)(8676002)(64756008)(33656002)(66476007)(66446008)(53546011)(66946007)(316002)(478600001)(186003)(8936002)(71200400001)(110136005)(54906003)(9686003)(26005)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Km/a0J0SnCAngFGzNi1c9k0tdzktZVkbXi1XszlX6M1NUscoopxhmveD1bsVkyW8sZr/Xd1enIyp8ySuc9Vz3uYTDbmDyAL3oGjm/2AMXFTG0bm24YnmL4iq/IZJCGkvILWsHhZ29FhEE3+9ZMieX5rWxyJ6RgTPhMyyjcZ+sNo7P2TPsnnEALe5V/zhINotfvqYTScy+9bShXxwV00zV6tc2Q360pbpnvhr3wZRWvZ3ec+/upc77qpoyM77cQhhCxA9UrA+6cqOTmiv+nqTDG3iB7mfgh73kukA/rU9VNQwOgd0UjwG3Eg2eD8DhO0asow4MLEGzDYhHczVPAtyXOnBTG8oKKSP9kCsyY7xzsUqUEK0w90z6yXSSH/TdgbgDhPAQEHdQWDy+8g6HkldAXsR2l9EfHOCrg+Giz7dTrs3LyzRpCILQ4QmXc6XCoEkz/Odo66IOJ2ou1IpKqxMZY5LGG2s+tqKTZ9p+MGZAnQlPMpE70Ll/r2RBEizOI+W2haQCM4OPfy2GyhmldZ4aYFoyZX68TDiHBWE1MVpfEIq8sJcy70BI2UfljvJkkppOmMHR3wAgN49Ib5pOy33mpbfWV/cxKj1pg5GMhd7CxEL+lViQcXybEhEYjEc7KZ3SXU+2rM0YI6lIIRUAg+2Aw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: pauljones.id.au
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYXPR01MB1918.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cd5de59-76a7-423a-baf0-08d877cc9da5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2020 03:26:37.3333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8f216723-e13f-4cce-b84c-58d8f16a0082
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NTc+QiCtwyQNwcmSYS38vkZSRINdyRlgyKYU8FVBCHr4hvHb1bOtEORAr6pC3ISDSkqqtGx0lYdvD0i9mKNGrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYXPR01MB0655
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBHb2ZmcmVkbyBCYXJvbmNlbGxp
IDxrcmVpamFja0BsaWJlcm8uaXQ+DQo+IFNlbnQ6IFNhdHVyZGF5LCAyNCBPY3RvYmVyIDIwMjAg
NTowNCBBTQ0KPiBUbzogV2FuZyBZdWd1aSA8d2FuZ3l1Z3VpQGUxNi10ZWNoLmNvbT47IFF1IFdl
bnJ1bw0KPiA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT4NCj4gQ2M6IEFkYW0gQm9yb3dza2kgPGtp
bG9ieXRlQGFuZ2JhbmQucGw+OyBsaW51eC1idHJmc0B2Z2VyLmtlcm5lbC5vcmc7DQo+IE1pY2hh
ZWwgPG1jbGF1ZEByb3puaWNhLmNvbS51YT47IEh1Z28gTWlsbHMgPGh1Z29AY2FyZmF4Lm9yZy51
az47DQo+IE1hcnRpbiBTdmVjIDxtYXJ0aW4uc3ZlY0B6b25lci5jej47IEdvZmZyZWRvIEJhcm9u
Y2VsbGkNCj4gPGtyZWlqYWNrQGlud2luZC5pdD4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gYnRy
ZnM6IGFkZCBzc2RfbWV0YWRhdGEgbW9kZQ0KPiANCj4gT24gMTAvMjMvMjAgMjozNyBQTSwgV2Fu
ZyBZdWd1aSB3cm90ZToNCj4gPiBIaSwNCj4gPg0KPiA+IENhbiB3ZSBhZGQgdGhlIGZlYXR1cmUg
b2YgJ1N0b3JhZ2UgVGllcmluZycgdG8gYnRyZnMgZm9yIHRoZXNlIHVzZSBjYXNlcz8NCj4gPg0K
PiA+IDEpIHVzZSBmYXN0ZXIgdGllciBmaXJzdGx5IGZvciBtZXRhZGF0YQ0KPiANCj4gTXkgdGVz
dHMgcmV2ZWFsZWQgdGhhdCBhIEJUUkZTIGZpbGVzeXN0ZW0gc3RhY2tlZCBvdmVyIGJjYWNoZSBo
YXMgYmV0dGVyDQo+IHBlcmZvcm1hbmNlLiBTbyBJIGFtIG5vdCBzdXJlIHRoYXQgcHV0dGluZyB0
aGUgbWV0YWRhdGEgaW4gYSBkZWRpY2F0ZWQNCj4gc3RvcmFnZSBpcyBhIGdvb2QgdGhpbmcuDQoN
ClRoZXJlIGlzIGEgYmFsYW5jZSBiZXR3ZWVuIHVsdGltYXRlIHNwZWVkIGFuZCBzaW1wbGljaXR5
LiBJIHVzZWQgdG8gdXNlIGRtLWNhY2hlIHVuZGVyIGJ0cmZzIHdoaWNoIHdvcmtlZCB2ZXJ5IHdl
bGwgYnV0IGlzIGNvbXBsaWNhdGVkIGFuZCBlcnJvciBwcm9uZSB0byBzZXR1cCwgZnJhZ2lsZSwg
YW5kIHNsb3cgdG8gcmVzdG9yZSBhZnRlciBhbiBlcnJvci4gTm93IEknbSB1c2luZyB5b3VyIHNz
ZF9tZXRhZGF0YSBwYXRjaCB3aGljaCBpcyBhbG1vc3QgYXMgZmFzdCBidXQgZmFyIG1vcmUgcm9i
dXN0IGFuZCBxdWljay9lYXN5IHRvIHJlc3RvcmUgYWZ0ZXIgZXJyb3JzLiBJdCdzIG5pZ2h0IGFu
ZCBkYXkgYmV0dGVyIGltaG8sIGVzcGVjaWFsbHkgZm9yIGEgcHJvZHVjdGlvbiBzeXN0ZW0uDQoN
ClBhdWwuDQo=
