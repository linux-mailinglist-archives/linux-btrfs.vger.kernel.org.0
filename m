Return-Path: <linux-btrfs+bounces-1449-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 670C382D91A
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jan 2024 13:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F41F1C216FF
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jan 2024 12:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8861168BB;
	Mon, 15 Jan 2024 12:52:57 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2053.outbound.protection.outlook.com [40.107.239.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B47168A9
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Jan 2024 12:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=USbIZinfodata.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=USbIZinfodata.onmicrosoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=anWFI9C/5IVT84VfU0BSQ6aulpKi23dSaRuILM9Fh5+6ZnjfemS9PI/XieDcLxVMEZJS309dTD8FCd67VoFUh7/c5zSGs90XuzOwNvF+eSoASi4LOAh0WXGGWB520Dw0TbOsQCx1fgzvZZG2hjODRMH6Ubogr7W+JdpnDPn0i8WNfbZAjHpxte46WCqiFuA7pXHjPnSO6WkRTavIkEorcrOu9YsgeZrxpnWAIY8xSANkgUJ9qtNuELZRXhPE2cO3HbV7yt1sAcQ9AXP33ygcE451xafh9/+2l1L0EKoBUNe6WnjUOhwbXNj+PXRuvfzvINuGEAsrFVylFDan+RUW7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYbiwBwZJTZJHEd0EjKCSCeNzfYoJoZk7uvn4Mpv7BI=;
 b=Rol+DuoIsvt03kxMIT3+u0/SmsSq2JVCNzDyzpRQ+Zd8nvzieL+fhq84NcZ/8Nb2IKDWs1k93PVb3RTCeim+ZPhbccKWrFonk2WWS7tDnxHfd8Hdj+j3fLLl4qaEXX6Mj5SeCtCJxxsT/zdyf+o0v3j4FI3tTQOKQaTfiB3lwmHCdt6YodFuMee0tsj3GG/5+BMc92AkIXw7LMQb/q0gOKLxKPBTq9wjvspA+0vTxphrhWiEJhS4xRkbcITwI1H7wo3adYruEDh1guTORp7n66XNIMAL7zZiGZktCHmBhL9Ngf6bhD9VUY7eA+BhaTDkxcRkGNgzi2txHp4xyAS/pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=usbizinfodata.onmicrosoft.com; dmarc=pass action=none
 header.from=usbizinfodata.onmicrosoft.com; dkim=pass
 header.d=usbizinfodata.onmicrosoft.com; arc=none
Received: from PN3P287MB2559.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:208::9)
 by MA0P287MB2180.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:101::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Mon, 15 Jan
 2024 12:52:51 +0000
Received: from PN3P287MB2559.INDP287.PROD.OUTLOOK.COM
 ([fe80::d2ef:b83c:14b9:f325]) by PN3P287MB2559.INDP287.PROD.OUTLOOK.COM
 ([fe80::d2ef:b83c:14b9:f325%6]) with mapi id 15.20.7181.022; Mon, 15 Jan 2024
 12:52:51 +0000
From: Emma Conner <Emma.Conner@USbIZinfodata.onmicrosoft.com>
To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: RE: vger Hardware decisions makers
Thread-Topic: vger Hardware decisions makers
Thread-Index: AQHaR7HAsK0I5fjF3UqBNz20pNBnRQ==
Date: Mon, 15 Jan 2024 12:52:51 +0000
Message-ID:
 <63821224-1016-2e33-82ca-8a754e67d28e@USbIZinfodata.onmicrosoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none
 header.from=USbIZinfodata.onmicrosoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3P287MB2559:EE_|MA0P287MB2180:EE_
x-ms-office365-filtering-correlation-id: d2f99c88-40da-4948-eb6e-08dc15c8e297
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 1iyu0f02YeoUOAxhS7pGWcZulryluQGW3t5jToikqRRRkQm+d9uU8lfPQsiH9tY/Qw0tMKtncjg0zENv2Bxqzs5JcN9w7hlURYIkL8WbvlkaX8l47dg0v4dNZeAmRQtKF2I+Teei4sut3bFoNlFEarRyw1spDt5SfhAfa+7+qWHGoBPF0PSRAwil37C261q1DTG8KpJiaOTiw44EeqoXexODgzOOp2qHWnktLmz1j4rNnn7gqMZHko3EyFffaYvqztYecAZknk0OqplTwcR3GOyBp9AdNV8D8wDwE0o/1wTbAmd7GxsYqzP3N/E2GN+und7hMydvVrU5w36ckTPWe1ewW2uN3OaPEITtG8JEwIMAPIOBLOvHYwtaWpLIu6tcFQyAfCKUiiePZGMEGcbhBEFQuwTV57O9/PJOTyPOQOyne0tk+FFCP7BMLauMY3nrkFs/ariMRJnQBFOhAKLSFhw1xEnM1FJA2TVTWZehojMy0k5A8FZQSlLRmPbvCDlRbPl/7iqvh4liegpMN+xb7V/srMKXkNv26jtsoSFjX+cIvevEwLOBc4EQs3h+pZ/BBofkRMFyR4GAuM6GLqOHXT6i0d9kiWuelar7gtUD6uE7D5NaJZb2j0l1yYEp1R+5NaUPTA8gPjgpkCpIDzZ6/g==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB2559.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(39850400004)(34096005)(366004)(346002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(71200400001)(26005)(2616005)(478600001)(6512007)(6506007)(53546011)(91956017)(3480700007)(83380400001)(76116006)(5660300002)(2906002)(41300700001)(66476007)(66446008)(6486002)(8936002)(64756008)(66556008)(6916009)(316002)(66946007)(8676002)(122000001)(86362001)(38100700002)(38070700009)(31696002)(66899024)(31686004)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UGJCVXVocC96T0ZLWmhGNkI1b0VIL0N0MW5wRjdiOFg3OXBiSmZaNVNjVm9I?=
 =?utf-8?B?VzcxdURJV0NiQWJxZUVBY29HdVpibUpWYkYvYjF0SFNhMk9aVTNBNER2eUpj?=
 =?utf-8?B?UzhZcWxLWkhtaDdOVDBucjJ2UzNkZVozRWdTNEo1TlFrVjZ5d1czUDFNMnI5?=
 =?utf-8?B?THVheFNsZVdCb1FJWHN0aHdHZEF6dis1ZFJldTl3Ti9KdGRaVkp3L0xyQ2NR?=
 =?utf-8?B?bFd6a0JpKzZMYnNtMitUb1JnV3VOWDZaYjlSTENsR0Ewdmg2bDVtQ0FsczYr?=
 =?utf-8?B?U1NVWjBJWExjNlEzU1VaTTFxNVVsSnFqTUhKQ1AreEtpdlBJQ3J3ajN1Y28v?=
 =?utf-8?B?dThIYVBFb3c1aUxXTXZxUlhGQkxSMUdYUFM5WndDQXhxdWhpNUQ3NDRYQkxp?=
 =?utf-8?B?UXVCVnladXFKNFQ3bFNEUlZrMEU5bXdvbk9EdDV1bUZmVTdnMytXcEhyVU9T?=
 =?utf-8?B?V0V6SC9KV3FieDh6YytURHc4U3VockZOeThPQU56ME05QWx2c3h2ZmMyT1Vi?=
 =?utf-8?B?N2pzWGw0MkhaeXNneURSQ3ZPUnhBQVRvdnBta3VMaytIN09wa2U3YWhzbnM3?=
 =?utf-8?B?VHJLR2JqbkZveVRGVFNWaFAwUy9FUldEQ2RNR3BSSGRCRXYxdjZqWVJJZjlG?=
 =?utf-8?B?bWc5clNvRjNqY0lxek91OVhSd0hwQ0cxRHg2TUpSQlRrWE5KbG9LWXlaQUor?=
 =?utf-8?B?bGlreFBUV0NiOVoyZG1YRkhnRTdrdHBKL2hYLzNJby9sY1ZQcys4eUM3M2VZ?=
 =?utf-8?B?ekNOYnNzRE9zeVk3dU8xcnp4ZndoTWJscWNRczg1NWVLL1F0Y2psYnNJSS8r?=
 =?utf-8?B?NUhRY21WUnRUUjVOMHhpYW1MWlc0a0hvVDQwKzNKNndTRDdOYkRYYU1IQXlL?=
 =?utf-8?B?cy9aKzk1eWVyNE1ZWTJqSzNtbmhvc2FVbDVpV3JmNDVlYmVSTHNOeGliaWJR?=
 =?utf-8?B?RVRkV081N1dTN2tQYUcra2VudkdpR2ZNc1M1TUFQa0RNbEVEWHNxSGhwTXcv?=
 =?utf-8?B?MWFvUS8wQ2xOVk1FNkg1UDNSRG1pcFpUZWJDVUdSb3c1YmRvU2FiZnpDZXFx?=
 =?utf-8?B?anZIYjVPcXRpWHUvWGY4WStsT3JUNG1Rc09HQWlCVHBhc0g4TzYrTFJSVnZR?=
 =?utf-8?B?SzdVTy84T0hwOGxaZzgxcG1YWU1rNHJZY08yU0Rmd3NtVEs4Z2lYQ29oaUF4?=
 =?utf-8?B?bHJNRlB2SE0wV2E5bmhxUjgwSzdTWmdJa1k3bWNiUDdHM1ZHSmhFUElqS29U?=
 =?utf-8?B?eGJaYi91L0lOdnp6T1YzUUJOTlZVem9yKzg0aTVONW80TWwzb3MyQ0JLQ2RZ?=
 =?utf-8?B?M2RYalZDNUErbFZwZkEvVGJBaXRTRzJTak5ONm1jamoveDU4VWVCMVl2WGFZ?=
 =?utf-8?B?aWQ1bmlwZWh1bVRxUWZ1NE0xNmd5L2pNaXk4U0dtQSt5NlRFNlBncUZPUnZR?=
 =?utf-8?B?Y2ZYQ3h3SFp6UkFMb3NzTU1TVkpYMW96bS9KOFNRRkowNE92cWZYY1RNWGJs?=
 =?utf-8?B?NGxXT1c2bUQvN0hDbjJwRmVJeTdYNjFoTFFHalVldld3NWZidWIwcGE1N0pn?=
 =?utf-8?B?QmEyeWZiVUs1OUhkemJmbnFwL0wydGkvRTVzN3RCSS9Wc0ZDOURDODE0Qy9m?=
 =?utf-8?B?bnBtb2hYNUZPS3RHWXlBdVlnbkxId0R5RC9BSzYxM0ppNzNFZE9EZ2J2TVY4?=
 =?utf-8?B?OEtPREN6aXFwcDZOUTh1ZHB2ME5CRmg3Z1ovUVlWUFpQdllnM3VGY0JrSklW?=
 =?utf-8?B?cmNiTGNuaDMvQXBWcHgvK0ZIaExTcEJFcGF0NVBsVi9lcmVQSEYxR3ZCWjlz?=
 =?utf-8?B?US94b0M1Q1RFUmdVWkdJRzlSdjZpZ0JiNXhuVVpjUFVRdUthUXZIaklvQkhN?=
 =?utf-8?B?RytrckwwRENPYjhFT2hiMVZzaUJSMVZnR21ndW9uZ0JoejBOYUthOHNBaGFV?=
 =?utf-8?B?UURkcUd0a1VmVkJHTlMzM3FwMTdaYTQ3YThoQTNWWW5PZllySERNMHd6TjB0?=
 =?utf-8?B?VnhqckwrUFVUcjZITEd4c0NMUGlyOC9WeUlmbHFKWGdpUFZ2VHQ1L3VLNWRJ?=
 =?utf-8?B?ZlZKVjJXam1JTE11bnpya09ZbGxlQmlUQTZEcWo5N3N3RXVka0hXeC82cUho?=
 =?utf-8?B?N2VjSmdiNVUxS2RRZ2QwbDVOemlPbVY2djkxdkN1bDZHY1hZejgvQnNhMXNi?=
 =?utf-8?Q?Iw0ipvoaGjhRRs9QpiNRQTk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <566E3820F5E819468BB87297312181AD@INDP287.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: USbIZinfodata.onmicrosoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB2559.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d2f99c88-40da-4948-eb6e-08dc15c8e297
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2024 12:52:51.8827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c8985d2c-274e-4d2e-b47a-e4113825a86d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lNYGanffWcMHFk/13oWQO1O8O4NHf8IiAJJ7buEYug0KL6Fv/zMbx02n7m1jwnVwdcqJxZWY4cVOWvopxAAc4vb49BIStbXk1h8ES4oviMRBD/m6JLKWjYAx+4IqZKlPTR1ukZ1mKZK/QQ4uqQ9hLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB2180

SGksDQoNCkkgZW1haWxlZCB5b3UgYWJvdXQgb3VyIElUIGFuZCBjb21wdXRlciBkZWNpc2lvbnMg
bWFrZXJzIGNvbnRhY3RzIA0KZGF0YWJhc2UuIFdlIGNhbiBncmFudCB5b3UgYWNjZXNzIHRvIG91
ciB1cGRhdGVkIElUIGFuZCBjb21wdXRlciANCmRlY2lzaW9ucyBtYWtlcnMgd2l0aCBJVCwgSVMs
IEhlbHAgRGVzaywgQWRtaW4gbWFuYWdlcnMsIE93bmVycyBvZiBzbWFsbCANCmJ1c2luZXNzIGV0
Yy4NCg0KSSB3YW50ZWQgdG8gY2lyY2xlIGJhY2sgYW5kIHNlZSBpZiB5b3UgYXJlIGludGVyZXN0
ZWQgdG8gc2VuZCBtZSB5b3VyIA0KdGFyZ2V0IGpvYiB0aXRsZXMgYW5kIGluZHVzdHJpZXMgc28g
d2UgY2FuIHNlbmQgeW91IG1vcmUgaW5mb3JtYXRpb24uDQoNClJlZ2FyZHMsDQpFbW1hDQoNCkVt
bWEgQ29ubmVyIHwgTWFya2V0aW5nIENvbnN1bHRhbnQNCg0KT24gMDMtMTAtMjAyMyAxMTo0Mywg
RW1tYSBDb25uZXIgd3JvdGU6DQoNCkhpLA0KDQpXb3VsZCB5b3UgYmUgaW50ZXJlc3RlZCBpbiBy
ZWFjaGluZyBvdXQgdG8gSVQgYW5kIGNvbXB1dGVyIGRlY2lzaW9ucyANCm1ha2VycyB0byBwcm9t
b3RlL3NlbGwgeW91ciBwcm9kdWN0cyBhbmQgc2VydmljZXM/DQoNCiDCoMKgIEMsIFZQLCBEaXJl
Y3RvciBvciBNYW5hZ2VyIGxldmVsIFRlY2hub2xvZ3kgb2ZmaWNlcg0KIMKgwqAgQywgVlAsIERp
cmVjdG9yIG9yIE1hbmFnZXIgbGV2ZWwgSVQgT3BlcmF0aW9ucw0KIMKgwqAgQywgVlAsIERpcmVj
dG9yIG9yIE1hbmFnZXIgbGV2ZWwgSW5mb3JtYXRpb24gc2VjdXJpdHkgb2ZmaWNlcg0KIMKgwqAg
Q29tcHV0ZXIgTWFuYWdlcnMNCiDCoMKgIEhlbHAgZGVzayBNYW5hZ2VyDQogwqDCoCBJbmZvcm1h
dGlvbiBTeXN0ZW1zIE1hbmFnZXINCiDCoMKgIEFkbWluIE1hbmFnZXINCiDCoMKgIElUIFNwZWNp
YWxpc3QNCiDCoMKgIE93bmVycywgQ0VPLCBQcmVzaWRlbnRzIGV0Yw0KDQpXZSB3b3VsZCBiZSBo
YXBweSB0byBjdXN0b21pemUgeW91ciBsaXN0IGFjY29yZGluZ2x5IGZvciBhbnkgb3RoZXIgDQpy
ZXF1aXJlbWVudHMgdGhhdCB5b3UgaGF2ZS4gUGxlYXNlIGxldCBtZSBrbm93IGluZHVzdHJpZXMg
YW5kIGpvYiB0aXRsZXMgDQp5b3UgdGFyZ2V0IHNvIEkgY2FuIGdldCBiYWNrIHRvIHlvdSB3aXRo
IGFkZGl0aW9uYWwgaW5mb3JtYXRpb24uDQoNCkFwcHJlY2lhdGUgeW91ciByZXNwb25zZS4NCg0K
DQpSZWdhcmRzLA0KRW1tYSBDb25uZXIgfCBNYXJrZXRpbmcgQ29uc3VsdGFudA0KDQpSZXBseSBv
bmx5IG9wdC1vdXQgaW4gdGhlIHN1YmplY3QgbGluZSB0byByZW1vdmUgZnJvbSB0aGUgbWFpbGlu
ZyBsaXN0Lg0K

