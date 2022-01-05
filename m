Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB01D484BC8
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jan 2022 01:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234468AbiAEAiW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Jan 2022 19:38:22 -0500
Received: from mail-sy4aus01on2070.outbound.protection.outlook.com ([40.107.107.70]:56142
        "EHLO AUS01-SY4-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236357AbiAEAiW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 4 Jan 2022 19:38:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8/2TZmxTfRbeoMrE8nE5bTtP74M8qCJFMiQe2w8EZlS69h37c68hVJF7gsQ9ftgYA3DvxJCxwx5IzbvyaKBHa80ukOnqjQZd2W33iS4jjJnhxcrt9XqYlb1iAj3Rfa6LRjEU5Mr3xcMSQWdZGKtu0HIKIENEnvo8BKJJixYdG9FhnxaJK2fMjuscS66Oypi5Y49xornCzZHqgQTNXnYWhiXhf02VVeL6nWCMxwas2vVlK0Lfsw8YlrD0uRRMv6Xy0dqGx23laHwpMADIx1L8bWGD6LmUbFbehECa5S563pY33Aqk4R4VvRxfvaR3E8dtoyPY7q98oSfK6DZkE3huw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72/4rki9bbyR4nBPCL+ggkGb9+qC+ZMUTJKGY7jfzuE=;
 b=PNN0vsXK4eFKXiyn/JB8C4+R3gE0IZvTMaZd2Sil6RVg7m7ItfwfArM4TPMl/bLu5oK2vSc0ohPmGNr2ZAK4e9YeOg3f2VGQSFu1+OCpvcvoElScBWxpRp5vLbkzZbC0r90Xx09E7F115ayR4xpT+EZ10jYm/2XseXccehF+kpCofmmoG+T0bF1E0U9GiqcWw2V7MPqaR8bodvGz5dTU0QXw53IRSl03KnUJPcsg9DtvBmZ3hKmiYeqgMOmRDqs+UKjnOMm5LN8cM2OCZzKmH6i1TFBIkVa2thpCaTJnYAdDbjGkHcqAK+Wwy+v77C7PG0dZ0MUFlLvx2URkdRqLmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=pauljones.id.au; dmarc=pass action=none
 header.from=pauljones.id.au; dkim=pass header.d=pauljones.id.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oakvillepondscapes.onmicrosoft.com;
 s=selector2-oakvillepondscapes-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72/4rki9bbyR4nBPCL+ggkGb9+qC+ZMUTJKGY7jfzuE=;
 b=qX+aiMO36Oj3oAgmgoLn/LInRIVdWoP/TAbomgYHPx4r4Th63iPYqRtF5cRK97mHlZfgmCxgRc0mEQYykXpL7hKMyyRVarnbmVpFQeD/Af30joDdmkZ5thbuMLlH3Fh6wl5f6gwBxImWvC+tjyK9oD//ALVt0HvGm1jltoKsFrE=
Received: from SYXPR01MB1918.ausprd01.prod.outlook.com (2603:10c6:0:2b::11) by
 SYXPR01MB1646.ausprd01.prod.outlook.com (2603:10c6:0:25::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.7; Wed, 5 Jan 2022 00:38:19 +0000
Received: from SYXPR01MB1918.ausprd01.prod.outlook.com
 ([fe80::1140:be98:7c93:495c]) by SYXPR01MB1918.ausprd01.prod.outlook.com
 ([fe80::1140:be98:7c93:495c%6]) with mapi id 15.20.4844.016; Wed, 5 Jan 2022
 00:38:19 +0000
From:   Paul Jones <paul@pauljones.id.au>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Eric Levy <contact@ericlevy.name>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: RE: "hardware-assisted zeroing"
Thread-Topic: "hardware-assisted zeroing"
Thread-Index: AQHYAJJLIVw9h/1xU0+KjDsfbyZYVqxRJdGAgAAB9ICAAAeeAIABgVSAgACnP4CAAB4YgIAAArOAgAAadBA=
Date:   Wed, 5 Jan 2022 00:38:18 +0000
Message-ID: <SYXPR01MB1918C7BCE283C34FE862387E9E4B9@SYXPR01MB1918.ausprd01.prod.outlook.com>
References: <2c80ca8507181b1e65a67bbd4dca459d24a47da2.camel@ericlevy.name>
 <b0d434dd-e76d-fdfa-baa2-bb7e00d28b01@gmx.com>
 <487b4d965a6942d6c2d1fad91e4e5a4aa29e2871.camel@ericlevy.name>
 <e3fd9851-ccf4-6f04-b376-56c6f7383de7@gmx.com>
 <faa7edb08a5cf68e8668546facbb8c60ae5a22e7.camel@ericlevy.name>
 <YdSy09eCHqU5sgez@hungrycats.org>
 <f264615001da2f24ca418fdaa4b4567b7ff4cb22.camel@ericlevy.name>
 <2193547e-d88e-9f53-6777-793b58130afd@gmx.com>
In-Reply-To: <2193547e-d88e-9f53-6777-793b58130afd@gmx.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pauljones.id.au;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 98592f94-c24b-4676-a13f-08d9cfe3ab8b
x-ms-traffictypediagnostic: SYXPR01MB1646:EE_
x-microsoft-antispam-prvs: <SYXPR01MB1646423B2B043D24CE6B098B9E4B9@SYXPR01MB1646.ausprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GK/q+VdvXqbSLDEYhSnWZEPmcj8dESbXKOjyaSr33/YkkCGvGLADnhH6EzeGZnq50Q7q4gK/oLWoccpfT2xVEC99yDbrJy9pq3W4iG7+aL2zVZ+YlyecBcBTvYc7lu0DUiRGK5Ql0IMsG4z5/5YHFPXa6eJT16IiFuZxZNWtamGe6fwh3R5fQnLyrfZ+OoxaVgDaJ71hiiBVJv1Z+o8tFJ2JJdoEJZ5I2ky5+h/q3XYjMCgVNR3Ed1MoOzAkSh95OUqxMXTW8N/ZyhTrC2miz9kWukR4S2Tok4tlCi0bUgNHjA9aNEiir3pn2DcJX0SLyjR0BSpkyRDzLcRARPFNxCxe93acWNC5ezR0KDL2YpDB6GmgS1ridbNiuSH8lytvcMKEw7MUXaitU5lXIEP4usPfsSb3EBnAQ1rVni6QeEiD4kJvX8tjHaJgCf2RzzvYJrnm5zKbrscMOSuw9+xlMUjDS2q4Q1Hzcz14IYwkBV6lhUXvIF5dHpFNVXma7kZCA0S6Fm8wr0kGnW+3qEG0fQenNDSbSVZbWuZaeV2N0sweNIaciRbPl805g5foilqbAbHP3RuKNUc3KY3Dsw74DC6sJhaOhaPWtkuiRZSLE8MBJFyPvERE74F2J73tr0tKoRUnVXIjJ3dmmUpp6NrP4BUaL2Jdbngtyu68T43BzG1HMNJMnltVgh2ZXahU6mVoJlvY4KnRPMFYHPl6WjYLkw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SYXPR01MB1918.ausprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39830400003)(366004)(136003)(396003)(376002)(316002)(66446008)(7696005)(2906002)(83380400001)(508600001)(26005)(71200400001)(9686003)(8676002)(33656002)(76116006)(66476007)(53546011)(6506007)(66556008)(64756008)(66946007)(52536014)(55016003)(8936002)(86362001)(110136005)(122000001)(38070700005)(5660300002)(186003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d1Y5MG5nR0g5bVJvcmdQcWxpOVBLQ2hUcWkyTmlCNExmUjlmL2VVUHQ0RW9n?=
 =?utf-8?B?cnFlN0FNWGFsMkZ6aGhrMmJxa3ZaWWx2NDlBcEQ1cUYwUElJeWFBL2R4Y3Ry?=
 =?utf-8?B?MGl3djFnd0Q3dFppYXZrWklmRjd6VUFZcWhaQ1BXYncwNnJNbkNpVE4vSUt6?=
 =?utf-8?B?TlI0TWl0K1lkbjdSMG5pVFZueWRjREV1OGpJR2QrSEZoaGJxZ2dHRCtqek9p?=
 =?utf-8?B?ckJnV3JrNjFmOEsvMEpod3dZbnBVeW9mNENQTm4xdWJWSW0rbFpNS1dPMWdU?=
 =?utf-8?B?a3hYZ0tTVkhtbmRRcnVhVVhuVzlMV2NER0dhYkxxdzRncHNyQ0o1c2lySVVZ?=
 =?utf-8?B?TUpXMlpPQWl3VmVkU0xSNlFiZVdqOTg2Z2JablhsbVdhY1hkQXo1eGlCNGpF?=
 =?utf-8?B?QndqWnJlWXc0Yllab2c2R2pzdUZLYkNuRjRtUnBnQlQxRFlscFhYaStjQXdD?=
 =?utf-8?B?bXI2S0IzTXErcEFUTk9Cb3haUkNHVTNVOC9OMjgvbmRzK0JNQ3YvNjFMSXhs?=
 =?utf-8?B?eFA5MmRLeEgzdWdnNFljYiswRE4waE80MHQxblFVeDFEZHNZZGJFZkRENGRo?=
 =?utf-8?B?dWhhU1hYY05yTUJZdXJDOHNMQnNaaEdHU3I2WFVWTDNlVGtHSiswOUtubnN0?=
 =?utf-8?B?NUlHRjB4enVPNENHR1VOSG5rZ1JvekhYVnZkMXl4Nm91ZVR3clhnb3JrQ0g5?=
 =?utf-8?B?ZVQ5NTF1ZGVtanRpM0wybWttc0Vid2pDc204VUpFR1pTU1AxcFFFdk5mUi9Q?=
 =?utf-8?B?bXVqcUduQnVQQjdSYjZIV3BmOVQxc1l4QkVCZDEzckU3SzdFUVVwR3lTM202?=
 =?utf-8?B?d1prYnpRM250cjV1akpkaXJBeE1IcnVUK2dMOW5jdGZZSG1lWE82UDlETzJk?=
 =?utf-8?B?cFBsaUpTcjhzbmliSVFjNEFqNElIcHlCY2pkTElqcUl1eGxrd3RVaXp2WjdO?=
 =?utf-8?B?cDRWVGpGd25aaHFXQldMdUlKb0xxRGxDRGVPTW80ZGhhNFQrRkJtWWlFK2lB?=
 =?utf-8?B?Q3N0cGo5Q3ZsR2Y5dGZGaVllMjdZRW9OVjdiUmRvYTNPemRMNVdqKzk2VFpZ?=
 =?utf-8?B?Z3poMWFCc3MxMk44b2t3dnE0OFdKRXE4MDRsMFhkbFp4M3drMWoza1FzUUJU?=
 =?utf-8?B?NHRBM3Z3TXcvZVlsQi83bFF4SUJKT3I4VzZOckFlUUVlaWx0eEtGbUROQ3Ny?=
 =?utf-8?B?UnNmNnRhZ01YaExYT2REN1BOQjYxQnFnK1hNak9oOGdBcm5YZFUzMUQ2OEtx?=
 =?utf-8?B?bVlEZXN1aXordmtwNkx2RVlUcm5CdnBrOE02eThNWm1pSGlQbWp4cUp0VHNH?=
 =?utf-8?B?aFJ4c1BhZWZRYllHY0V2TUtvMG5xNDJJSDhlOEpkcHIzZHFQTFFLWTUwajZE?=
 =?utf-8?B?QzVMOVFVZGJGblNyM1loQnhaMFE2YVFKVDFwa2ZEKytVakhHbkFra1RPdHhT?=
 =?utf-8?B?V2lZbndzUG9keHNYb0dUdCtXb3VCVlBibnFNODhNS2NGWTVxUE5ybHR0R2k1?=
 =?utf-8?B?YzB6Vks1TTNvUHRDTHhTb0U0NzJsdWI1b2NDUHFBM010eVZTKzF2TnBQRE1u?=
 =?utf-8?B?VUxDVkQrOVUzZXVRTE84eWxaU2xtYTh0YjE3Mjd6WUNKUzFmQlRpSHFYbkxL?=
 =?utf-8?B?eTBOUWt0dVRLZ2J3eUk1UDFiQ0k0V3E1dXhFSDloZFB5Wjdzd0VidmV4VzhM?=
 =?utf-8?B?djI5cGg3amNLZW1rS1ZSQzZYcEhrR3pBNllraWJXdkhFeVFqMEZ0VHlxYjFp?=
 =?utf-8?B?b3BjVS9scG1NWXZtSk01VkdHdTI1TW50M2t4MllWa2hTWWNNelR4OGhlQXRV?=
 =?utf-8?B?YlFydkdKeEhGY1l2WE9pNGpWdnI2U0ZGZkhicFhiZGx3b2F3dkE1eWdzK1JK?=
 =?utf-8?B?dEZ1SmtvNC82MldHMFVNRHk1Vkx4cXVONnAwYkZyU2lxN1BrcENSUDlBcExh?=
 =?utf-8?B?VDFUMUpoQ2VXRUZEQ0ZLWmlIVjB0ZFgzR2hUUEhITk5nTnNEVU41WVVWczJm?=
 =?utf-8?B?MGVXUElkdFBxWVA1SWxVNHNKR0lWYjlaVmhwclV5US9iN2NhR25XYjBjMy9Q?=
 =?utf-8?B?bEFidklBSnhkN1J3Qk1pbDZCZTZyQlRobklzSDhhUEJYNjJYdXVRQUdpcDh6?=
 =?utf-8?B?NjJMWVBXRlZKaGMrbksvVDdGZWxaeThnc2lIYmE4N3ErR3hEMUEyRGNnZWh0?=
 =?utf-8?Q?SlVTmDpQDpmkZ8QsUaILDOk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: pauljones.id.au
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYXPR01MB1918.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98592f94-c24b-4676-a13f-08d9cfe3ab8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2022 00:38:19.0185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8f216723-e13f-4cce-b84c-58d8f16a0082
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9ULtLr9DPeidKwmZLiPR5NkuvTsZucDnbrmZVkWBMWErgRglZe1/g6bM0nz17Y6gO/vSgaQ0+mMvT1OUMs3gKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYXPR01MB1646
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBRdSBXZW5ydW8gPHF1d2VucnVv
LmJ0cmZzQGdteC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgNSBKYW51YXJ5IDIwMjIgOTo0NyBB
TQ0KPiBUbzogRXJpYyBMZXZ5IDxjb250YWN0QGVyaWNsZXZ5Lm5hbWU+OyBsaW51eC1idHJmc0B2
Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6ICJoYXJkd2FyZS1hc3Npc3RlZCB6ZXJvaW5n
Ig0KPiANCj4gDQo+IA0KPiBPbiAyMDIyLzEvNSAwNjozNywgRXJpYyBMZXZ5IHdyb3RlOg0KPiA+
IE9uIFR1ZSwgMjAyMi0wMS0wNCBhdCAxNTo0OSAtMDUwMCwgWnlnbyBCbGF4ZWxsIHdyb3RlOg0K
PiA+DQo+ID4+IENoZWFwIFNTRCBkZXZpY2VzIHdlYXIgb3V0IGZhc3RlciB3aGVuIGlzc3VlZCBh
IGxvdCBvZiBkaXNjYXJkcyBtaXhlZA0KPiA+PiB3aXRoIHNtYWxsIHdyaXRlcywgYXMgdGhleSBs
YWNrIHRoZSBzcGVjaWFsaXplZCBoYXJkd2FyZSBhbmQgZmlybXdhcmUNCj4gPj4gbmVjZXNzYXJ5
IHRvIG1ha2UgZGlzY2FyZHMgbG93LXdlYXIgb3BlcmF0aW9ucy4gIFRoZSBzYW1lIGZsYXNoDQo+
ID4+IGNvbXBvbmVudCBpcyB1c2VkIGZvciBib3RoIEZUTCBwZXJzaXN0ZW5jZSAod2hlcmUgZGlz
Y2FyZHMgY2F1c2UNCj4gPj4gd2VhcikgYW5kIHVzZXIgZGF0YSAod2hlcmUgd3JpdGVzIGNhdXNl
IHdlYXIpLCBzbyBpbnRlcmxlYXZlZCBzaG9ydA0KPiA+PiB3cml0ZXMgYW5kIGRpc2NhcmRzIGNh
dXNlIGRvdWJsZSB0aGUgd2VhciBjb21wYXJlZCB0byB0aGUgc2FtZSBzaG9ydA0KPiA+PiB3cml0
ZXMgd2l0aG91dCBkaXNjYXJkcy4NCj4gPj4gVGhlIGZzdHJpbSBtYW4gcGFnZSBhZHZpc2VzIG5v
dCBydW5uaW5nIHRyaW0gbW9yZSB0aGFuIG9uY2UgYSB3ZWVrIHRvDQo+ID4+IGF2b2lkIHByZW1h
dHVyZWx5IGFnaW5nIFNTRHMgaW4gdGhpcyBjYXRlZ29yeSwgd2hpbGUgdGhlIGRpc2NhcmQNCj4g
Pj4gbW91bnQgb3B0aW9uIGlzIGVxdWl2YWxlbnQgdG8gcnVubmluZyBmc3RyaW0gMjAwMC0zMDAw
IHRpbWVzIGEgZGF5Lg0KPiA+DQo+ID4gSXQgc2VlbXMgbXVjaCBvZiB0aGUgZGlzY3Vzc2lvbiBy
ZWxhdGVzIHRvIHRoZSBkZXNpZ24gb2YgcGh5c2ljYWwNCj4gPiBoYXJkd2FyZS4gSSB3b3VsZCBu
ZWVkIHRvIGxlYXJuIG1vcmUgYWJvdXQgU0REIHRvIHVuZGVyc3RhbmQgd2h5IHRoZQ0KPiA+IG9w
ZXJhdGlvbnMgYXJlIHVzZWZ1bCBvbiB0aGVtLCBhcyBteSB0aG91Z2h0IGhhZCBiZWVuIHRoYXQg
dGhleSB3b3VsZA0KPiA+IGJlIGhlbHBmdWwgZm9yIHRoaW4tcHJvdmlzaW9uZWQgbG9naWNhbCB2
b2x1bWVzLCBidXQgbm90IG1lYW5pbmdmdWwgb24NCj4gPiBwaHlzaWNhbCBkZXZpY2VzLg0KPiAN
Cj4gSSdtIG5vdCBhbiBleHBlcnQgaW4gdGhpcyBhcmVhLCBidXQgSU1ITyB0aGUgdHJpbSBmb3Ig
U1NEIGlzIHRvIGF2ZXJhZ2UgdGhlDQo+IHdlYXIsIHNpbmNlIE5BTkQgdXNlZCBpbiBtb3N0IChp
ZiBub3QgYWxsKSBTU0QgaGFzIGEgd3JpdGUgbGlmZXNwYW4gbGltaXQuDQoNCkl0J3MgYWxzbyBu
ZWVkZWQgdG8ga2VlcCB0aHJvdWdocHV0IGhpZ2ggb24gbmVhciBmdWxsIGRyaXZlcywgYXMgZmxh
c2ggY2FuJ3Qgd3JpdGUgYXQgYW55d2hlcmUgbmVhciB0aGUgcmF0ZWQgc3BlZWQgb2YgdGhlIGRy
aXZlLiBJZiB0aGVyZSBpcyBub3QgZW5vdWdoIGZyZWUgYmxvY2tzIHRvIGR1bXAgaW5jb21pbmcg
ZGF0YSB0aGVuIHRoZSBkcml2ZSBuZWVkcyB0byBzdG9wIGFuZCB3YWl0IGZvciBpbi1wcm9ncmVz
cyBkYXRhIHRvIGZpbmlzaCB3cml0aW5nL2VyYXNpbmcgYmVmb3JlIHByb2Nlc3NpbmcgdGhlIG5l
eHQgY29tbWFuZC4NCg0KT25lIHBhcnRpY3VsYXIgc2VydmVyIEkgbWFuYWdlIGlzIExpbnV4IHJ1
bm5pbmcgb24gcGFzcy10aHJvdWdoIGRpc2tzIG9uIEh5cGVyLVYsIHNvIHRoZXJlIGlzIG5vIHdh
eSB0byBzZW5kIGEgdHJpbSBjb21tYW5kIHRvIHRoZSBhY3R1YWwgcGh5c2ljYWwgZGlza3MuIFRv
IG92ZXJjb21lIHRoaXMgSSBoYXZlIGEgMjBHIHBhcnRpdGlvbiBvbiBlYWNoIGRpc2sgd2hpY2gg
SSB0cmltIG9uY2UgYW5kIHRoZW4gZG9uJ3QgdXNlLiBUaGlzIGFjdHMgYXMgYSBidWZmZXIgdG8g
a2VlcCB0aGUgU1NEcyBoZWFsdGh5IGFuZCBmYXN0LiBPbmNlIGV2ZXJ5IGZldyBtb250aHMgZHVy
aW5nIGEgbWFpbnRlbmFuY2Ugd2luZG93IEkgYm9vdCB0aGUgc2VydmVyIGJhcmUgbWV0YWwgb24g
YSByZXNjdWUgZGlzayBhbmQgcGVyZm9ybSBhIHRyaW0gZnJvbSB0aGVyZS4gVGhlIHdyaXRlIHdv
cmtsb2FkIGlzbid0IGh1Z2Ugc28gdGhpcyBzZWVtcyB0byB3b3JrIHdlbGwuDQoNCg0KUGF1bC4N
Cg==
