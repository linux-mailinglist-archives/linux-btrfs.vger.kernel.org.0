Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6CD47E102
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Dec 2021 10:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347516AbhLWJyV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Dec 2021 04:54:21 -0500
Received: from mail-eopbgr00137.outbound.protection.outlook.com ([40.107.0.137]:41730
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239351AbhLWJyV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Dec 2021 04:54:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yu8XpjOa/tYoH6VWbVTBMXPz8lvK8VybzZC9WDIhQYNt6ZJPi1iYTi1XlfqdWTE8T5Z4e7Q6CCTcFIFVNuJ+1fTNNs8AiA68y3YZsDgzsRBKBQnAVPsqXT1RrnzM03RxsEAR/BRMSywAoBH0NHu+RqGzt5l9KgB/MOopfV6ezSRICBjD+KAvadFZO5F9v/9uVIMsw6qt9hL9V5ZxJkGnqtzEkEt/YZmCcEaCpNprLEdlJL42cgiJK94XHOPhfO3bwoxL2drc2k8J8MrUA9Zq7jdPsW6uprrvXqGmYMAlbGl44YaDYL8oa1FSimHIhRn7ZSGpm0J7PRjBTiEtQu9SWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8sDFOUrrnapXDazaL7PlTU+GOCKqF6HuXQsC1CSjts8=;
 b=M4vfVuPXGVOjCsjMJcLNjVXE281J6BsozwlgTIYaEk99FIWyB8veS+Y19W6AIi8vPnGX4MdnjNL5SHnGNSeozixKmRIpPWUvFwRH9ZVeayzz2XglS46DZK2RnZpeV47JTzqmXW19190hBVzXOiq+iQrfsaJzW4PAdjJXsJPIwys7aXkzoKEGqseiscycJvAtqINlmBC5VQ5LlBokmV0sJd5x4djIH0NZcSIYvE/QFEeM0PhSw/nWifXHStp3XqkD8ei1UffN9iT4th2wdA/eEIuywdRMmo3PbM4k9t7H2K0U59djKvmnrv4I3uK6j+PyL7xNqTiCNYaSCY0jmrqz2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bcom.cz; dmarc=pass action=none header.from=bcom.cz; dkim=pass
 header.d=bcom.cz; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bcom.cz; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8sDFOUrrnapXDazaL7PlTU+GOCKqF6HuXQsC1CSjts8=;
 b=gi6kqcqqoqRO4WkH0CU3IZcqUEYg+4WMEiUDo4P4dl+Yx2tAGjFTNCreAUTe3b1KcKipuLt+dZggwa5ZX434nJL8Dy+n2TbM4O68xGDleUqDOTaow3YqxFkBS0weJ6cjVTiMTAUGOy4fv1lCbBezmNoIzI64KCgSmE8SNuP2Vtk=
Received: from PAXPR03MB7856.eurprd03.prod.outlook.com (2603:10a6:102:213::23)
 by PAXPR03MB7918.eurprd03.prod.outlook.com (2603:10a6:102:215::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18; Thu, 23 Dec
 2021 09:54:16 +0000
Received: from PAXPR03MB7856.eurprd03.prod.outlook.com
 ([fe80::f4ac:e73c:4b3e:a321]) by PAXPR03MB7856.eurprd03.prod.outlook.com
 ([fe80::f4ac:e73c:4b3e:a321%8]) with mapi id 15.20.4823.019; Thu, 23 Dec 2021
 09:54:16 +0000
From:   =?utf-8?B?TGlib3IgS2xlcMOhxI0=?= <libor.klepac@bcom.cz>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Btrfs lockups on ubuntu with bees
Thread-Topic: Btrfs lockups on ubuntu with bees
Thread-Index: AQHX4tMAp1surAV4LE6J53J71m075qwpqUsAgABOBACAByrgAIACSC4AgAAB1ACADJQ9gA==
Date:   Thu, 23 Dec 2021 09:54:16 +0000
Message-ID: <757a8f5a62644be35a2e06102bbb12fa68f0352e.camel@bcom.cz>
References: <c9f1640177563f545ef70eb6ec1560faa1bb1bd7.camel@bcom.cz>
         <20211209044438.GO17148@hungrycats.org>
         <6b1f34700075ef5256800edfe2c486fee36902d6.camel@bcom.cz>
         <YbfOXO3ZPEXLB397@hungrycats.org>
         <340ab9b906fd1b1e4fe2f0329c6be85a9958e661.camel@bcom.cz>
         <f6b25f1a-f90c-98c4-6d07-bd76b38572c6@suse.com>
In-Reply-To: <f6b25f1a-f90c-98c4-6d07-bd76b38572c6@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.2-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bcom.cz;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85f9907e-bd4a-4dfb-30b8-08d9c5fa2ee1
x-ms-traffictypediagnostic: PAXPR03MB7918:EE_
x-microsoft-antispam-prvs: <PAXPR03MB79186B75DA511BC6C0E84CF78A7E9@PAXPR03MB7918.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: junvHsEvq+Vfg10t2u5JmExAC/dUP9WkHwBLui08NEnD/vI8eLgjZGSCM71dq/Tb813pVoRTa6GktYRKXqldJtdL6Hop+NMYHz808Qu4fR8J0pdpzuS53lgeLzdl7HNnVuWVV6CPgytnxbUYutcFtUKUhEW7zgKXQoUvqnBsh4Db+8XxBnqrLRZ18Gs/0dL56kRTl525HXeoPQJjGFcQbErI9zo7Ax8ax819Tye7PxBiMv3Qv5YjRVN64kxVallhrLkSW/o7J198Mc+cwL8mYa6HLi85v6mqaePtWjvn5Pw9gJH27XDR6YxQJMx+eLGl6Gv3zfFRShBQD4MGt5qumhFwWMWeeMkP6uJ8TRrtbzg8mmDzJemujnTQkQZn/QYs+I8T0wPshn4ZxaLYORWgMU1qc8zUd43FuCu8/De8Hr1YwMUMqWbSKQE4UlAb8uzdDrfzfsRTI2hmOIvE5ThTECt2hgqFUF0yPdHnVk+NJSW30+drr/MGjPKFQbWr9JSSQltZxnq3s6NrHiC8FOHXPsZMcAE6qJRsD/EyP5PzYTL62kh3Z8lJ87w5pW2vRWXvcbi220wEfID8i0eqNpFXZ0r2laUs8df99Mm3JkTFlP2mpJ2f7z1p0fidxd/Yx6URiThx4LH2KYcyWUtZhYHsQaCBg2gjmxrUdZcX1HMh7xkf7ViUyPLBXH7kbGDSxJTp9DA5CG/vaHoFJSS8zz9+mvUJ1sUojk+ukHLQNXI/bFNm0PBsWDm2yp6zKZeRrcVnhJEKTLr2ejRDpZpGNbpSQLnY88CriWVQR6crNhRlSHw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR03MB7856.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(136003)(376002)(366004)(39840400004)(6486002)(91956017)(508600001)(36756003)(186003)(66446008)(8676002)(6512007)(76116006)(64756008)(66476007)(66556008)(26005)(66946007)(83380400001)(71200400001)(5660300002)(966005)(316002)(85182001)(38100700002)(6506007)(2616005)(122000001)(2906002)(86362001)(38070700005)(4001150100001)(6916009)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWFGUEJVYlZKK0lQVVJVaWIvcUF1Q09LZ0VldE5mS0U3Q0YxS0hDZmZuQlBu?=
 =?utf-8?B?UjFyKzJPUlJhSkF2ZXZyME9IcjJ3Q0FYbUtEK3MrYmluT0xQbjFaU0hMVTRS?=
 =?utf-8?B?WEtnRXlQSDl1S0RVNVJ1UTJhakRwTTRublhub2wrRFZoMnFPRFBSNGhOWS80?=
 =?utf-8?B?aSs4T2RrYnUwdExMeVpudURrUE5ZeUdMeHh5bnVvd0ZMYzFMRDcxdkhFbkNN?=
 =?utf-8?B?ZXlXNzJ0R3JHWXhFV0Y0MUVoeGZtVHh3SE4weWFhRXA2UEtQaUl4aXBMWEtY?=
 =?utf-8?B?aVl2bktOd25CckRDUnZpVTZZYmM3YmFOczl4Q3BhUk11RUcrRXN6UkZnalU1?=
 =?utf-8?B?SjVTYmdYSlVlRHordVpzNjYxcEdPYk9rbDM5bkdSR0pQYzBBMWhTanlhOUtZ?=
 =?utf-8?B?TlNpQ2ZvWEdtRzZ4MXdmQzhZOFg2dzd4cE5Oc1p6QlgwOWY1TmRMdVJvMnVH?=
 =?utf-8?B?U1ZPKzlrallXc2dMZ2JXcEV4T0xuM2s3Skk3VVByaFJ3cHc1dE9xSVZhTVRl?=
 =?utf-8?B?YnNDRk8rczRaRDBLZHorYUFvUlZtK2ZjcHpCczN5dnJnd1M3MjZZbG5Icit0?=
 =?utf-8?B?a1JiSEt4SklyL25iK3NZdzU2QnBCYUtYM2ZaRHdzRFloU0Y1bnZhdG1vWmt6?=
 =?utf-8?B?TENobVZPMStGK0p2cWw0eC9KSitacmxBaXNDSG9vL0h6ek9KZ2ZtaGZrUjcy?=
 =?utf-8?B?c0w1TjNORUtuaUEzRWRJQzRqRlFOUE1qenl3aG11QXZvTUN3V051NU1LUnNv?=
 =?utf-8?B?QytTK3N6STNhM3BGQWdpbW83Q29oVGhPQjJGVHRpbVNnOGVHRCsyMWgvRk80?=
 =?utf-8?B?TjVSaWNRczVvN1JrWjlydGJnTU1UZURYMmhyanJLVEJRUWV4VXplTnRQa2xM?=
 =?utf-8?B?VUtLVWlSZjRLZk15RGdCYUlQbDJNQVZKckpSU1duQjlHak5GZlY5Yzk1UXRz?=
 =?utf-8?B?b0pnU0I1K2FBMDJ5bFN6bFVuT2dUWHVMck1lZjRXczc2aW5MWlV1MDdkd3BR?=
 =?utf-8?B?K25reHdFeHNUNm12REFWck9pZkZ5ZTB1a1NQT0VidjFaVG5pNm9NNml5Vzdy?=
 =?utf-8?B?NU9JaVV0WUovbnIwU2ZoVzZ4UldzVTgwYUlHb3ArN21udG9zSmxMRDgrMzA1?=
 =?utf-8?B?MUFmR0NrbllvdmRkUmttZzd3S2duQnREcTloMlZJLzRjazJmNW1qMjV5OWlD?=
 =?utf-8?B?T014RjZhSTJQc1E0dWhZNW9hMTlJYitFODBXTEMrTlIwZ2VVRmgzeU93M2g5?=
 =?utf-8?B?aEZPWEtVV1FsYnlNL2xPSlBBMUxBem1GR3p5bUluRkZDSHFzRFk2Q2RQa3hm?=
 =?utf-8?B?UlcwbmliQkZLT3ZsSzdiN1hXQmZCQ2JOaVhkYkdtbHVLdHhRQXlRaCs0SkdQ?=
 =?utf-8?B?ZWx2c2J3QlArTzhiTDkxTzd0L2JiUkdrdnNOcGM3aEZQcE1LYW56L2FkWUJD?=
 =?utf-8?B?dmk3VVdjenBvSVVmY3NUK0xaT3Zxd0pCMCtyUi9ZMHdwdHFYM3NtSFU1TUJ6?=
 =?utf-8?B?TlBFQmVRTG9MY3J3YzBwMWtjbXhQd25MZ2lFTmZ3TDVvNFpRejNsd01oalBJ?=
 =?utf-8?B?YjJZbm1MZk41VG1DMXhYVWxyd1NlckJPZ1hHK0IzQnZ2VGNHbEpOUi8rVHFE?=
 =?utf-8?B?WWtFaU9zZUtqZzR5d0FDL1dzbmcydjR5aC9OK0lQamJRYXkvRmgwekVkQnpT?=
 =?utf-8?B?d0dmdUJmVWZ1RUc3TEFrdDJGTUJOOEZCVk1SSEVkZ1NzOUhNcEJQL0FKYWJp?=
 =?utf-8?B?RzhvMzRQekR1cGx2c2hodDFEc3Z6SHg3S3dtT3RlcjBiMEYxL0dSZFZwNTVu?=
 =?utf-8?B?eDdZaUxhWXNWVVk2V2N0NkhLMFVNWXZjN2dCT3NPTDdURG5xREpkU09tN3p0?=
 =?utf-8?B?VmNHdEdoNU5nWjJKdGUwMGFIQ0Jwb3Nwa3FvOERGNlJENW1Yd2xxSjB5ZzJL?=
 =?utf-8?B?Sm5VVGx3RFdUa1doT3hNb0lyUHZvcFRITDA2dmMwTHZzU1VPK2lKdFlVZHNO?=
 =?utf-8?B?WjRmY2srSXJQR25HcTE4cWRmWmR3NWtLWEg0NWs3NlRrYS9DTlRraFpsMzBH?=
 =?utf-8?B?aTJHNng4Z0JTcUVYYVJwSVA4QXh0c1JaZ1BXaU8xZ3BtdCtFdjdIQ242eDFO?=
 =?utf-8?B?b0FEb2dvTkkyanAwMWFjQy9uZVcxVjVSNXg0Vk1QTkRRdkRWMHlPSFNGQXl1?=
 =?utf-8?Q?q3qu8TyN53eD7S78NQTkf4o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA60A6F668154D4C8B616719D9128051@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bcom.cz
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR03MB7856.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f9907e-bd4a-4dfb-30b8-08d9c5fa2ee1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2021 09:54:16.8016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 86024d20-efe6-4f7c-a3f3-90e802ed8ce7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HNMg6Z3hB8CklQCTrXJZQR/Yy5tTdAhyxWjC+EWqD9qiI0m2tHGKpWKZR+jPtcQo7stdnD9owOUl0FiJKfN8dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB7918
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

SGksDQoNCk9uIFN0LCAyMDIxLTEyLTE1IGF0IDExOjQ4ICswMjAwLCBOaWtvbGF5IEJvcmlzb3Yg
d3JvdGU6DQo+IA0KPiANCj4gT24gMTUuMTIuMjEg0LMuIDExOjQyLCBMaWJvciBLbGVww6HEjSB3
cm90ZToNCj4gPiANCj4gPiBPbiBQbywgMjAyMS0xMi0xMyBhdCAxNzo1MSAtMDUwMCwgWnlnbyBC
bGF4ZWxsIHdyb3RlOg0KPiA+ID4gT24gVGh1LCBEZWMgMDksIDIwMjEgYXQgMDk6MjM6NTNBTSAr
MDAwMCwgTGlib3IgS2xlcMOhxI0gd3JvdGU6DQo+ID4gPiA+IEhpLA0KPiA+ID4gPiB0aGFua3Mg
Zm9yIGxvb2tpbmcgaW50byBpdC4NCj4gPiA+ID4gTW9yZSBiZWxsb3cNCj4gPiA+ID4gwqAuLi4u
Li4NCj4gPiA+ID4gTG9ja3VwIGhhcHBlbmVkIGFsc28gYXQgc2Vjb25kIGN1c3RvbWVyLCB3aGVy
ZSB3ZSB0cmllZCB0byB1c2UNCj4gPiA+ID4gdGhpcw0KPiA+ID4gPiBzb2x1dGlvbi4NCj4gPiA+
ID4gR29vZCBuZXdzIGlzLCB0aGF0IHdoZW4gd2Ugc3RvcCBiZWVzLCBpdCBkb2VzIG5vdCBoYXBw
ZW4gYWdhaW4NCj4gPiA+ID4gYW5kDQo+ID4gPiA+IGJ0cmZzIHNjcnViIHNheXMsIHRoYXQgYWxs
IGRhdGEgYXJlIG9rLg0KPiA+ID4gPiBCYWQgbmV3cyBpcywgd2Ugd2lsbCBydW4gb3V0IG9mIGRp
c2sgc3BhY2Ugc29vbiA7KQ0KPiA+ID4gDQo+ID4gPiBEb3duZ3JhZGluZyB0byA1LjEwLjgyIHNl
ZW1zIHRvIHdvcmsgYXJvdW5kIHRoZSBpc3N1ZSAocHJvYmFibHkNCj4gPiA+IGFsc28NCj4gPiA+
IC44MyBhbmQgLjg0IHRvbywgYnV0IHdlIGhhdmUgbW9yZSB0ZXN0aW5nIGhvdXJzIG9uIC44Miku
DQo+ID4gPiANCj4gPiBPaywgdGhhbmtzIGZvciBpbmZvLiBJIHdpbGwgdHJ5LCBpZiB3ZSBjYW4g
cnVuIHRoaXMgbWFjaGluZSB3aXRoDQo+ID4gZGViaWFuDQo+ID4ga2VybmVsIGZyb20gc3RhYmxl
IC0gNS4xMC54DQo+ID4gDQo+ID4gPiA+IEFyZSB5b3UgaW50ZXJlc3RlZCBpbiB0cmFjZSBmcm9t
IGtlcm5lbD8gSSBzYXZlZCBpdCwgYnV0IGkNCj4gPiA+ID4gZG9uJ3QNCj4gPiA+ID4ga25vdywN
Cj4gPiA+ID4gaWYgaXQncyB0aGUgc2FtZSBhcyBiZWZvcmUuDQo+ID4gPiANCj4gPiA+IFN1cmUu
DQo+ID4gDQo+ID4gSGVyZSBpdCBpcyANCj4gPiBodHRwczovL2Rvd25sb2FkLmJjb20uY3ovYnRy
ZnMvdHJhY2U1LnR4dA0KPiANCj4gVGhhdCdzIHRoZSBzYW1lIGlzc3VlIHRoYXQgWnlnbyBoYXMg
cmVwb3J0ZWQsIGNhcmUgdG8gYWxzbyBwZXJmb3JtDQo+IHRoZQ0KPiBzdGVwcyBJIG91dGxpbmVk
IGluIHRoZSBmb2xsb3dpbmcgZW1haWw6DQo+IA0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9s
aW51eC1idHJmcy9jNjEyNTU4Mi1hMWRjLTExMTQtODIxMS0NCj4gNDg0MzdkYmY0OTc2QHN1c2Uu
Y29tL1QvI203OWU5ZGE4N2I4ZWMxNWM0MDk5OTk5OWQzZmZjMzQ4ZjI3MWZiZjMzDQo+IA0KPiAN
ClNvcnJ5LCBjYW5ub3QgZXhwZXJpbWVudCBtdWNoIG9uIHRob3NlIG1hY2hpbmVzLg0KSSB3ZW50
IGJhY2sgdG8ga2VybmVsIDUuMTAueCAsIGFzIFp5Z28gc3VnZ2VzdGVkLsKgDQpBbHNvIGhhZCBt
aW5vciBoZWFydCBhdHRhY2ssIHdoZW4gaXQgc2FpZCAiY2Fubm90IG9wZW4gY3RyZWUiIG9uIGZp
cnN0DQpib290IHdpdGggdGhhdCBrZXJuZWwsIGJ1dCBpdCB3YXMgZmluZSBvbiBuZXh0IG1vdW50
DQoNCkxpYm9yDQoNCg0KPiA+ID4gDQo+ID4gPiA+IFRoYW5rcywNCj4gPiA+ID4gTGlib3INCj4g
PiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiA+ID4gDQo=
