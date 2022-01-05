Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 766C4484BF7
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jan 2022 02:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236843AbiAEBMF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Jan 2022 20:12:05 -0500
Received: from mail-me3aus01on2053.outbound.protection.outlook.com ([40.107.108.53]:29743
        "EHLO AUS01-ME3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233194AbiAEBMF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 4 Jan 2022 20:12:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4ZVqKG0SU7ICOFkprDrbsjZX43R08jum6vwzUBsVTPweS7zGf813u++i8B43/SYMHYDlfFUuzncBqT3I9gU9Y+DJUrcLjYvXldNGl9W+6I+Vv3ql/NZvbhljLu+VDeeY0ejTvA//qGqq9IoHU6mdv19eoTY2LCgp9qUPpjYsk7nHYod0evgHITh99pcEo6mwbruXSs2fhXPZoyA818+zc52L5JAA63arWmKv2KY9nguI5XrVWTKq9C8Ryoxl6Tsw11bjpNmNKrBYnR+LmiRbgQq40qDwcmgSnHp+IW9Iv8W4ggl1QmTrNsl0+XoPEEJ7Vje/HeDvpQHRcPFClbX3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1tmDci80dKouLAmwaqK4RMSzyOe+dq7gt9dd+ne0ttQ=;
 b=lzQudyTcOEI9fEfjJ8hkauTNhnioTl0NOdCWdWS2FK4w0g2M7kNK4m7RunpZ+SIiPoh9tqA+e8+oRTG2g7DWjzldawmN+XUgoFHTwyoKic17poogzwGElo5D5hGkQ7uRD7i9mZ4uSJk0Aztwrb8wmVsskZYocj3j+e7fpBUEq45y3PEYuu3wa917gZiAWQyxXtR4XZujIdD3mY4a2iiujMv3a6rdVnHRG1r9SWzYks/yf1H9SPlspfzpQbUwZ950LHbAlBbvBBFeI4Ryon0YYnTG/5KUNyE6W2uQJIdAxJX+oiAPf14ch42xO8CjWekZMuNtheH0w3gvdrfT/QYNkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=pauljones.id.au; dmarc=pass action=none
 header.from=pauljones.id.au; dkim=pass header.d=pauljones.id.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oakvillepondscapes.onmicrosoft.com;
 s=selector2-oakvillepondscapes-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tmDci80dKouLAmwaqK4RMSzyOe+dq7gt9dd+ne0ttQ=;
 b=lccm22E+ZWWYXAxWCnuIygVCvlqtYu5EnBL2PkjU2RafEkVMGeLdCLHe+PIELg4jhqsipK3+01awRy/iIHQadf4gxq3WFRz4RCc/MTMKBUyGOOsGLofPap9VpV75gvUAebXq3ZJINNI250f8XTJGtRrlXwYSqvCqKPJM/ZVJPr8=
Received: from SYXPR01MB1918.ausprd01.prod.outlook.com (2603:10c6:0:2b::11) by
 SYBPR01MB6764.ausprd01.prod.outlook.com (2603:10c6:10:12f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4844.14; Wed, 5 Jan 2022 01:12:01 +0000
Received: from SYXPR01MB1918.ausprd01.prod.outlook.com
 ([fe80::1140:be98:7c93:495c]) by SYXPR01MB1918.ausprd01.prod.outlook.com
 ([fe80::1140:be98:7c93:495c%6]) with mapi id 15.20.4844.016; Wed, 5 Jan 2022
 01:12:01 +0000
From:   Paul Jones <paul@pauljones.id.au>
To:     Eric Levy <contact@ericlevy.name>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: RE: "hardware-assisted zeroing"
Thread-Topic: "hardware-assisted zeroing"
Thread-Index: AQHYAJJLIVw9h/1xU0+KjDsfbyZYVqxRJdGAgAAB9ICAAAeeAIABgVSAgACnP4CAAB4YgIAAArOAgAAadBCAAAZngIAABimQ
Date:   Wed, 5 Jan 2022 01:12:01 +0000
Message-ID: <SYXPR01MB1918E2947F617AE6436C3E9E9E4B9@SYXPR01MB1918.ausprd01.prod.outlook.com>
References: <2c80ca8507181b1e65a67bbd4dca459d24a47da2.camel@ericlevy.name>
         <b0d434dd-e76d-fdfa-baa2-bb7e00d28b01@gmx.com>
         <487b4d965a6942d6c2d1fad91e4e5a4aa29e2871.camel@ericlevy.name>
         <e3fd9851-ccf4-6f04-b376-56c6f7383de7@gmx.com>
         <faa7edb08a5cf68e8668546facbb8c60ae5a22e7.camel@ericlevy.name>
         <YdSy09eCHqU5sgez@hungrycats.org>
         <f264615001da2f24ca418fdaa4b4567b7ff4cb22.camel@ericlevy.name>
         <2193547e-d88e-9f53-6777-793b58130afd@gmx.com>
         <SYXPR01MB1918C7BCE283C34FE862387E9E4B9@SYXPR01MB1918.ausprd01.prod.outlook.com>
 <ca2d0ec03b6ec81add904d44e432ec063777b6e0.camel@ericlevy.name>
In-Reply-To: <ca2d0ec03b6ec81add904d44e432ec063777b6e0.camel@ericlevy.name>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pauljones.id.au;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb5a0da0-0924-4697-2e34-08d9cfe860ea
x-ms-traffictypediagnostic: SYBPR01MB6764:EE_
x-microsoft-antispam-prvs: <SYBPR01MB676416FBADC3A7081EDF90189E4B9@SYBPR01MB6764.ausprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4RTHIYJ/vkkEYAFanjyA8ziC19o9LfaiiX2DSOOmeaSZN/dij2hhbBw/F56JpyhVFskjKJRzo0TSrElxrDy3ozH5wwps2pCdbYE9WbZkLfiiOSyJvlxEDX2xQUpKSTzkkSGfPS+M/MlE07oraFVz5/Vlzt/zbA78ALkIOg5+x5BjzERnDEwmpvxV9g4oIO1jFjlJ9x8YKuYnpfUAEmGe2YcbdDGTMIM2Qrsg8t9jZFPpXMjHrPF4BUFooPMtC+ljOk7z9938XqpHXubQPrHV5d96IIHYwApmSBVApOEhUVvYtO87nj61N2HzfuTPPCLOlI3tblK2Q4/xlH7KOTIRG5L5IBkDsMSzbpcM01/x3Ilw3NESu+Yox7gAsLfywcr3Nfxjwp1/Qgb2h1j0UnLSjC080ORzwxYjv5b0Tht55utsyE2GiauAhIV1UOJw+EpTuqx9QlZF+YFdwagd8l3mflk1+ZPA4T0Coprb1NfTzV3+Zumu8hzw+qgh+JWTrnGxdpg8v8xocRv9cBTObekmGhwRtLYJNkyD9xc4rh1BZv1r0Qx8xYtJqw4wSdesQeoyrknaX/G/554iNrnpo3YV2nEl0VsQTa4e2Piqp9YHO8ytLHL1F/AHOCNLkpGaKwVSfvzOPwN/muJUwphaf9NXcruP8cNBMoY2Z9POIG9WRXff2bf3PhCwr5R2LDJreghblDtkomBNGF7giNoBtfOOQA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SYXPR01MB1918.ausprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39830400003)(366004)(346002)(376002)(396003)(26005)(508600001)(4744005)(83380400001)(8676002)(8936002)(316002)(55016003)(5660300002)(86362001)(186003)(122000001)(33656002)(52536014)(38070700005)(66556008)(9686003)(53546011)(76116006)(110136005)(7696005)(71200400001)(66446008)(66476007)(66946007)(64756008)(2906002)(6506007)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHhpbWpGdlZjaFdFK3ZGbHZjdXJwd0Y1SFY0NHV4VXhsVEtBMlpmNjViUXgr?=
 =?utf-8?B?SHMrU0tPS1BwVHZaSXIxU0ZyZExzRG8wdE8yeXhFMm55TENwZG94YlkrTFo2?=
 =?utf-8?B?WHVQZmZnWnhtVEhvRVpQdlM0Yjc3SHZZZHhrRFpJMFVWaWRiZEVNNXpKYkRS?=
 =?utf-8?B?MGQydXRwNVJNV3dmUkpWcmZxVXlqek1iWVhHT0Y4THFPdXVPUDhVenhoc0lq?=
 =?utf-8?B?SVR0RzN3MnlxZnlIdmpsVXpzQzVPb2lOaXcra3RlYTliQVRlT25jTzBhWVNE?=
 =?utf-8?B?VWJkdUhQSTYwa1VnV05oR3BUYjd4dW1wd2VQVlN0b0VHM2d2T0RhT3hFYlpk?=
 =?utf-8?B?Um5PY1MrWHZtZUV0MVd4QUtscVdWM2x2a3VLT1crR0ROclRsTDlNbjlSUUVB?=
 =?utf-8?B?ZElIVVhvVUhrZCttaWYzSDFZRnJrMG5wM3g0cVJmUEhVUjQySGwyRElTWGdM?=
 =?utf-8?B?dk9ZbCt0Y3huR3VWWnBEcldPMnFuVlN0anRTOUlrUE0zTG0rTXdrZ24yVGR4?=
 =?utf-8?B?NU9DSHM5TFd1S1dOWlhDZ3Vjei95MEVUVnNSMFVMTkpnbmZkSHUzczRyYjJF?=
 =?utf-8?B?VVhaVHJFVW5tajNrQWROT05FTkF5ODVPWnhwZjcvdGlHcEdjQ2pzMVZKOGd5?=
 =?utf-8?B?SXR3WUh6SXFWc3pGR1RkRXp1OE0xRFZPaXhjUTBVZEhrU2RoOVNWVC9GQWxp?=
 =?utf-8?B?d3hvaWhTa29TNmcwTHBkb0FNSmhXT1BvZXRXREhleVduUEpCV3o2cVBMRlRQ?=
 =?utf-8?B?b1V2aUJxNWtDVHJkOW9qUkhKT24rbzl0a1ZMQmdCbkpiS2tralVuSlFVZitw?=
 =?utf-8?B?SG1UUkhwVjhTVnl3SDRRUlE0VWdxRUpmOERhK3BTRkE5a0ptN004cm9VNENn?=
 =?utf-8?B?ajVMMU8vb1ZBZmlXb0V3QzVPY1kwbmtlK0NldHlSeVhoWGlwWUEzMCswVUZo?=
 =?utf-8?B?VGJ6SEtXSVhmMldGTzBpekJUNGtvS3VVN3hWQ2oyKzUybUtIY1ZKTEU3NStX?=
 =?utf-8?B?SkxtdmRjM3RERVJSU3pnL05DN0lidG1LcHBIVTZHbStuSlhwS01nczF4WjJ4?=
 =?utf-8?B?VlV4NG9KMHpDajNYNUJhYTh4dTZGR1hYVTlxVklwdHpJeDBGL0NlYmozbFdk?=
 =?utf-8?B?TE5qaEFiODFpK0FWTGRla0FPdmU0ZUFxdGNWQm5OK2hrMktPSjcrRStaUHlX?=
 =?utf-8?B?UUw2RWZBVUZiQ2dkTS80Sm9xdjdidjMwTjhxOURYM1NGbDJvRTZoRjlSOFE5?=
 =?utf-8?B?SUFOSU9YTHZDa3hPcVVjQTcvaG1PeDlLRHN1Qmw4aDA3TDJCODdBYU5aaU84?=
 =?utf-8?B?S1BKQjVHNDY0KytIY3EvcGVicmRZbnB5dUM1YnFWc1lsYVNpbUdtcVE3UU55?=
 =?utf-8?B?SFRFelo4Q0JEMDhxUFdXSG5EYzRMbU1BS2FEUnNUQm40RkQ4Ui9IWWR0Ukgy?=
 =?utf-8?B?ZUp3cm1vT2gvTElOWDFkS2dxV3VrUklIR2JINVlpZ1NxUDB0Q2U3YnJ2MHFM?=
 =?utf-8?B?allQSXJ5WmttbWEwbVdQV1grdVlqcHMyaDlVWmZPTG9UV1A4eFBjaHFNUWda?=
 =?utf-8?B?ajZESTRPazh4bUNCeHhtL0gvUzQ3bEtYZFg0bkRMTnFQMjRCV1d6eitvSzl3?=
 =?utf-8?B?Tng3NlBlVlRWanIxVmJ5QzdaWTc1ZGpqSEZtbTlQSUNleUdicTI0SWkybTFL?=
 =?utf-8?B?cFJKQWpjS0VVUzdUZ2xoR29teWhyQWxDRkFpbmFUMWIyL1R0enhxc2FTRzQr?=
 =?utf-8?B?dlo0NzlaODdyd2MybzFIeUNxOC9IZWc4UkQ1UFRmUFp1NlQwT0RZQ043cHdw?=
 =?utf-8?B?Unc0enprYzd0Vi9KdHBQZEdJWElscE0vY3h5RnhUdlRMRHNwTmdmQTFHRnpx?=
 =?utf-8?B?eUUyeDJ3RHFHM3A2YnplVisyU3NZTHNLOFNIMkpWc0diMWhkVWJBSlFCK3Mw?=
 =?utf-8?B?UVhjODVvZzJMdkxUWmtpUVlib3RkRTJNVjE4UzkweGdPNEtmRFJmWDRCQ0M0?=
 =?utf-8?B?dU9FUFl0SDA2ZHlubTM2anQwUjNrZWVxb0FPMWkzK1pGTHN6SzRUQUdHYUU5?=
 =?utf-8?B?N2YwdjNzTDNqbWJvc1dlSzlIYmZjT1ZLOG02MGlhZlJLa0p6dVY0b3lxZjht?=
 =?utf-8?B?N2l0eHZ5ZklHWi9xRkptWWFYWGhNWkdOQ3lpc2FDZTRLUWxvUkdpUFZQVjRV?=
 =?utf-8?Q?dR+F5bRYBE9jzWXte02vzRM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: pauljones.id.au
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYXPR01MB1918.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb5a0da0-0924-4697-2e34-08d9cfe860ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2022 01:12:01.3552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8f216723-e13f-4cce-b84c-58d8f16a0082
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gcRJymJu74o5pk4YS6vqWp4Wsi2MuCj7q5yyjjQ0ApzCLtWuBmBwIIPQtBe/aibb4meOboC+b7Vup4afeiWBEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYBPR01MB6764
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIExldnkgPGNvbnRhY3RA
ZXJpY2xldnkubmFtZT4NCj4gU2VudDogV2VkbmVzZGF5LCA1IEphbnVhcnkgMjAyMiAxMTo0NCBB
TQ0KPiBUbzogbGludXgtYnRyZnNAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiAiaGFy
ZHdhcmUtYXNzaXN0ZWQgemVyb2luZyINCj4gDQo+IE9uIFdlZCwgMjAyMi0wMS0wNSBhdCAwMDoz
OCArMDAwMCwgUGF1bCBKb25lcyB3cm90ZToNCj4gDQo+ID4gSXQncyBhbHNvIG5lZWRlZCB0byBr
ZWVwIHRocm91Z2hwdXQgaGlnaCBvbiBuZWFyIGZ1bGwgZHJpdmVzLCBhcyBmbGFzaA0KPiA+IGNh
bid0IHdyaXRlIGF0IGFueXdoZXJlIG5lYXIgdGhlIHJhdGVkIHNwZWVkIG9mIHRoZSBkcml2ZS4g
SWYgdGhlcmUgaXMNCj4gPiBub3QgZW5vdWdoIGZyZWUgYmxvY2tzIHRvIGR1bXAgaW5jb21pbmcg
ZGF0YSB0aGVuIHRoZSBkcml2ZSBuZWVkcyB0bw0KPiA+IHN0b3AgYW5kIHdhaXQgZm9yIGluLXBy
b2dyZXNzIGRhdGEgdG8gZmluaXNoIHdyaXRpbmcvZXJhc2luZyBiZWZvcmUNCj4gPiBwcm9jZXNz
aW5nIHRoZSBuZXh0IGNvbW1hbmQuDQo+IA0KPiBJc24ndCB0aGUgYWRkcmVzcyBvZiBhIGZyZWUg
YmxvY2ssIGZvciB3cml0aW5nIG5ldyBkYXRhLCByZXNvbHZlZCBieSB0aGUgZmlsZQ0KPiBzeXN0
ZW0sIGJhc2VkIG9uIHRoZSBhbGxvY2F0aW9uIGRhdGEgaXQgbWFpbnRhaW5zLCBub3QgYnkgdGhl
IGhhcmR3YXJlPw0KDQpZZXMsIGJ1dCBpbiBhbiBzc2QgaXQgd2lsbCBnZXQgcmVtYXBwZWQgKGlu
IGhhcmR3YXJlKSBhcyBwYXJ0IG9mIHRoZSB3ZWFyLWxldmVsaW5nIGFsZ29yaXRobSwgb3RoZXJ3
aXNlIHRoZSBmcm9udCBwYXJ0IHdpbGwgd2VhciBmYXN0ZXIgdGhhbiB0aGUgcmVhciwgYXNzdW1p
bmcgZnJlZSBzcGFjZSBpcyBhbGxvY2F0ZWQgZnJvbSB0aGUgZnJvbnQuDQo=
