Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED19B73802D
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jun 2023 13:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbjFULG5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jun 2023 07:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbjFULG3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jun 2023 07:06:29 -0400
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01on2087.outbound.protection.outlook.com [40.107.107.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74582126
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Jun 2023 04:05:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qd7cdJDjy2++uZQ0Salw4Q6yZj7i4xT9PQoNwLySwTtxM6nRI8wd9aCgMRNiHLgi1qa2nCWIkS/eI2fBdnR2c5SjNqWiU54sc6C6sNpfyZzY2MA0Oic+u6BfaRN2ZPwSCc8+Kq82SP0qV7oAqvc677fbHGzMvRvmwUOBlwtsZSMZTHC7KmQQkc2jXBRpb2rJS1+yPE2fEXBDs9DgVNRqDZ0Ax19/I/fAoja3Q+q1L6ibiGvLmXebI4TMPoQMEfdfMPFebfOdBVWMR+txQWeyp7g1+4QF+VTvcBgPCPfJb8S8KlJcruhTL0Ak5Jl5uDEuoFWAZR5nWOkAK+QLB72Dqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8ifPN/SKX5f6S+Ef52BL0gA0WZhdy971HckOmodppQ=;
 b=OQa82E+3gsJgqrPuHZLvUL92bcA02yEsgyoa9p4Ew5S62zV65RmDQAIFWc+3rzeHGX+XyUmY3rDFcpQkB5INcK8d1iyykumbxWpowMHpYvlSwU5LXEeBO1yOajfSSZj0nf/+772OP6a/N3DCt0NCLYBJKSB6Gn9Kma/vQLa+aZTgjDfjpFezyv6t/Jmja3OfxzdoCwlwwQJBfWoPzgKgwH2u+AxA5hNa2BYVkN9hBd4zT5xc7Tg5u/pSVDoGc20rseiRMzlMZguGlyClXk+grbYM9Kk04LBu7r8aHiewUIHNCyB5iRgHlHkAEcA+/MNsYE/aOU+DpBPsxIKwnaQUNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=pauljones.id.au; dmarc=pass action=none
 header.from=pauljones.id.au; dkim=pass header.d=pauljones.id.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oakvillepondscapes.onmicrosoft.com;
 s=selector2-oakvillepondscapes-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8ifPN/SKX5f6S+Ef52BL0gA0WZhdy971HckOmodppQ=;
 b=IfZHErurEiEAK7dJnfAPM+EfhsrPestTJ7WTGuXibjCzqGjB4f68D0tEWbt6jhPikg9WYK4y/79z3uXHDdhee9kePNaD6ADgmVbmrQyOUEhxlYhTKC7lzR3NQYUeVfyqAqQtuDo9IJMrXVFvW5BDHasykUQL4MbI2qVxm3P7CuA=
Received: from SYCPR01MB4685.ausprd01.prod.outlook.com (2603:10c6:10:4a::22)
 by MEWPR01MB8653.ausprd01.prod.outlook.com (2603:10c6:220:1f8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 11:04:48 +0000
Received: from SYCPR01MB4685.ausprd01.prod.outlook.com
 ([fe80::e5b9:9692:ecbd:fb4f]) by SYCPR01MB4685.ausprd01.prod.outlook.com
 ([fe80::e5b9:9692:ecbd:fb4f%4]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 11:04:48 +0000
From:   Paul Jones <paul@pauljones.id.au>
To:     Filipe Manana <fdmanana@kernel.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: RE: btrfs replace without size restriction?
Thread-Topic: btrfs replace without size restriction?
Thread-Index: AdmkDReXhL8v/HFYTgKvho7pOkYr7wAFHCaAAAOLTFA=
Date:   Wed, 21 Jun 2023 11:04:48 +0000
Message-ID: <SYCPR01MB4685DCF4F97371E348E0A21B9E5DA@SYCPR01MB4685.ausprd01.prod.outlook.com>
References: <SYCPR01MB4685ABD2A45F14C694BC68DA9E5DA@SYCPR01MB4685.ausprd01.prod.outlook.com>
 <CAL3q7H65vzvsATJSeS5YeX-ADEdJ6JDXY8H1XfiCQgDhPAhkmA@mail.gmail.com>
In-Reply-To: <CAL3q7H65vzvsATJSeS5YeX-ADEdJ6JDXY8H1XfiCQgDhPAhkmA@mail.gmail.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pauljones.id.au;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYCPR01MB4685:EE_|MEWPR01MB8653:EE_
x-ms-office365-filtering-correlation-id: 1abe1cec-c33e-423e-dc71-08db72475439
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NCMq1bf/ezcOUWi07gkyrTpmtC3hs3jo3J7OxquHu7qjW8hJKlfeT5yNOi5npV/aul6+lG6zeM7NX9q7SP/bpLe1gw7yI5YGM9P6c0JvJ7yZzX15BeXhSqjWQVRJ3B9lHhfvbmZOsreYEJ4tieIgJ/vzKAx0oN62C0MpbJCdZns+OA7ZBGbyXAcTPsZx03LxkXBOLNUJ0nlC003593vm+oMmpkAyyEE9D4axpraNLBHEI2/jD4RhPYlkm+H9sWCyyK3AyQ7Xr4VEZdouv48zC+qdyvE/wGger7orGyahP0ZEp8xwW2+sKqaljJS5dRQLEcpxD698VHfSCHsBLINOJAnRRK3WeFQbNl3oviGrz0M4fMEQ9igQxlhV1bEVZoYG2/rLg73DRDUnBCMsUEORwW2bXNeN00GiNLhD8U7g5iUGV7ZietiHf2ci3U78sFaUZVW0jJm31dDPSv+W2ao47S5IUdXF/KuWLntCBuZqrortY07IukKaAFWVUH/GMRefHCWX63HlIl7wzojWzu0OqyQcv5yGYvuaKtwRuHTDy/NZrBozeewVhsOWlrcxHRd74d0cTjqzdaNx/AFsHsUdQWbfoza73G4gL9RrDkMCRQg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SYCPR01MB4685.ausprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(376002)(396003)(39830400003)(136003)(451199021)(55016003)(8936002)(5660300002)(52536014)(8676002)(6916009)(64756008)(4326008)(66556008)(66446008)(66476007)(66946007)(76116006)(316002)(41300700001)(2906002)(7696005)(966005)(478600001)(71200400001)(26005)(186003)(9686003)(53546011)(83380400001)(33656002)(122000001)(6506007)(38100700002)(86362001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFdlNlM3TWZMNVpZRDBPOUtkQWY3UkRaRm1Hd254OFYrZURnWWdGODEzZit4?=
 =?utf-8?B?SXpBaDV2azhpVEozdTNMN0xyemZoemQ0U05FYy96a0JhZXpDQjdqbUJxZlRo?=
 =?utf-8?B?MUxwSGRHNWM1eGpoVE94bE1KdXE0aFlHejFKTlZmTkVYVit4T1FKRDlrYzF3?=
 =?utf-8?B?czdzbTlzelNaSzdpVEdkM2tuZVVUTXJFbzg4Y2hkL2xLRC85ZmwrNjEzWW14?=
 =?utf-8?B?OW8xdG9CTHRyaWtKWXNRUjVjUG9XM3d0d3RZdXBXN0RQN21yZjNDNEUzZHRN?=
 =?utf-8?B?VkJMUm5najh4T0VnVkN1R3haaXNjNEhReGtKVHdUNjZJWnRKTHVUM283SGZX?=
 =?utf-8?B?WnhrN3VHanNnV0xzZ3QyZTJVNk5DRGVIdVRtV3h5STNmS3VDSDRYRUdRN1JN?=
 =?utf-8?B?NHhYZC8yOUYwaGpLdzBqV1pqMW1Pc3g1NjJ0aEhWRUk4M015T1FWaHZwRHhE?=
 =?utf-8?B?MGFkekRwcWhTYzdGNk5tOWROVW1OYzF4SDhDdXY5dVZsaytpZHdJMnFvTm9I?=
 =?utf-8?B?TEJvYUhnWmRIeldQZGVrT21IQWZaQWZnL1Z1WVptQmJrQVJ6NmZVYlhQMmdn?=
 =?utf-8?B?dzlYaGZnd3pDenl3Sm9WTkdlY3BNekl5enN4Y3dNTmhncUVhem9IeUNQYnJ0?=
 =?utf-8?B?ZXFOcW9DbjR5dXdYb2J6TlZhNGpvMDRyNnNkZjc5NGNMbmRJcGI1QjhLbVJ0?=
 =?utf-8?B?dytpd1g3R0EvaURyNjdvczNqb2ZqQWRBakhydGhqQ0dtUkxKTFVSZmY5YThF?=
 =?utf-8?B?d2tVVTNoZEcrMk5QWjhJUFdLOVFXd3FMeVdpMjUwdzlna2RycUt0ejZ2T0Rw?=
 =?utf-8?B?aG82RjFvQ20wU09rMVkwcWpBN1NIc1oyQ1RzUzUxVFl3LzBYV0lpOHVhcWY1?=
 =?utf-8?B?STRFODdjclE5MkhoYmppRGdkcE9lWWwvNlBoWGFRTlpnRTJTcGZlZXhhU1Nw?=
 =?utf-8?B?LzZqaHlRb2VESWJmZUFmWUpWUU01L1h5VnZGN1VmQ2JmVXRxLzhSbWM0bG9K?=
 =?utf-8?B?NER6dTBUSlhSd1FKMWJGd3dOaVJXdGhqM1RQVkhzWDZmMmk4OGRIYU1DMG5Z?=
 =?utf-8?B?Uy9nMU1ER29DZzd2UkNLNUpWNVRaVU05dHlaVTFsR2lPZHdUaWM0MStJYTZM?=
 =?utf-8?B?cDZ1RndmMkt5TFVHMEgzNjBOdGdkY0wrRkV2VnpCMzFZQzFhUEROYWhzNTMw?=
 =?utf-8?B?bUJtc2Jib09ZVUU5OFlVUXFOSjFIR3ZnUi90cDMzaUR6MVI2aEtPRzV2NSth?=
 =?utf-8?B?UWFxMytuNHVrS3daTUdMdXpaR0dJbjhLMWNBeUx2bEE0WGZXS3RmbVpIVm8x?=
 =?utf-8?B?OWhRRTkvT0oxREhmN21tOWhHUGxHL2FXbnRDaFo0TVBBakVxNldGVjVZaVp5?=
 =?utf-8?B?dWR5TUlyRmhLYU1Ja3VZTldBWkhmNTV6cXpXc3dGVXdZbXFWbXZzeDMyYSs4?=
 =?utf-8?B?cS9SUml3V2Y0VTdWMGNaT3lnZUdLRSs1Z0FYSHRXcXFtY3Nka3l3dFZIa3Jn?=
 =?utf-8?B?OWc3RXVLRkIyUk9nSnRZdVNFbi9HRE53TWh1N2tXbXY1a3hQUnJyWFNydzFm?=
 =?utf-8?B?R1loWlhKZjlzcVV4TDdGSWVEd29KTXRTMStMQ1M2UnlGVTBseEcxeERTRW8x?=
 =?utf-8?B?SXpYYjIrMDNGQVhmSk1iL0FNRUpSYityc3duZFd4UmcrUWlCT045RkE2S2lW?=
 =?utf-8?B?STZ3elJkQ1ZFelNUTCtTT0kxK290Y1F0QmdIOFpwNGo3bUJHMGlnWklUbWhI?=
 =?utf-8?B?eDNSdExsNTFkTEdPL3hRUnI2azNmZENvNktVaW10dkxuaHBJckVWcE9FMUxo?=
 =?utf-8?B?WDd6bVdJNmd5aFpwWlp0WnJ3em50QXRsazBhemlxa25YT081bFFVakZCRHN0?=
 =?utf-8?B?dEhITUpsVU9BbDdqZWNncFFFdGJrbGM4d1JteGJ0a1lRdk91MDF4QWJlNHhG?=
 =?utf-8?B?RzlXNTVRZDRRTkR1a0c1UXNlRkk5VHU5aFJZc0pnV3JWOVJna0toQ3VERXFn?=
 =?utf-8?B?b1MydFlQV3B6ZE9FWVVhSWNjNTNMRFkrbHZFWXRDc2JqbUVqT2NBQVNJSHZn?=
 =?utf-8?B?aktFYWp4Snh0T1NvMmMxc0xGY0tFd2pkckw5aHZZdGd4bU5rOG1pWlBMMHV5?=
 =?utf-8?Q?AxwIaQSCJH6JFl31+zjpJx4Os?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: pauljones.id.au
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYCPR01MB4685.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1abe1cec-c33e-423e-dc71-08db72475439
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 11:04:48.4285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8f216723-e13f-4cce-b84c-58d8f16a0082
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: npTNurTysTIlcDOUI4bMGQkKJCUpikJCnze6ZaJXuFIS7P/VU+QvFFVsUqb7ZDGHnuWFTHw/38x16vymvhAZfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEWPR01MB8653
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGaWxpcGUgTWFuYW5hIDxmZG1h
bmFuYUBrZXJuZWwub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIEp1bmUgMjEsIDIwMjMgNzoyMCBQ
TQ0KPiBUbzogUGF1bCBKb25lcyA8cGF1bEBwYXVsam9uZXMuaWQuYXU+DQo+IENjOiBsaW51eC1i
dHJmc0B2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IGJ0cmZzIHJlcGxhY2Ugd2l0aG91
dCBzaXplIHJlc3RyaWN0aW9uPw0KPiANCj4gT24gV2VkLCBKdW4gMjEsIDIwMjMgYXQgODozM+KA
r0FNIFBhdWwgSm9uZXMgPHBhdWxAcGF1bGpvbmVzLmlkLmF1PiB3cm90ZToNCj4gPg0KPiA+IEhp
IGFsbCwNCj4gPg0KPiA+IFdvdWxkIGl0IGJlIHBvc3NpYmxlIHRvIG1vZGlmeSBidHJmcyByZXBs
YWNlIHRvIGhhdmUgdGhlIGFiaWxpdHkgdG8gZm9yY2UNCj4gcmVwbGFjZSB3aXRoIGEgc21hbGxl
ciBkaXNrIHRoYW4gdGhlIG9yaWdpbmFsPyBPbmUgb2YgbXkgZGlza3MganVzdCBmYWlsZWQgaW4g
YQ0KPiByYWlkMSBzZXR1cCBzbyBJIHRyaWVkIHRvIHJlcGxhY2UgaXQgd2l0aCBhIGRpc2sgb2Yg
YSBkaWZmZXJlbnQgYnJhbmQsIGJ1dCBpdCB3YXMNCj4gcmVqZWN0ZWQgYXMgdGhlIG5ldyBkaXNr
IGlzIGEgZmV3IHNlY3RvcnMgc21hbGxlciB0aGFuIHRoZSBvbGQgb25lISBJIGhhdmUgMjAlDQo+
IGZyZWUgc3BhY2Ugc28gbm8gaXNzdWUgdGhlcmUuDQo+ID4gQWRkaW5nIGEgbmV3IGRpc2sgYW5k
IGRlbGV0aW5nIHRoZSBvbGQgb25lIHNlZW1zIHNpZ25pZmljYW50bHkgc2xvd2VyIHRoYW4NCj4g
cmVwbGFjZS4NCj4gDQo+IEl0IG1heSBzb3VuZCBzaW1wbGUgYnV0IGl0J3Mgbm90Lg0KPiBUaGUg
b25seSB3YXkgdG8gZG8gaXQgd291bGQgcmVxdWlyZSBkb2luZyBhIGxvdCBvZiBleHRyYSBJTywg
YW5kIGluIGNhc2UgdGhlDQo+IGRldmljZSB0aGF0IG5lZWRzIHRvIGJlIHJlcGxhY2VkIGlzIG5v
dCBoZWFsdGh5IGFueW1vcmUsIGl0IG1heSBsZWFkIHRvIGENCj4gcm9hZGJsb2NrLg0KPiANCj4g
U2VlIHRoZSBkaXNjdXNzaW9uIGFib3V0IHRoaXMgYXQ6DQo+IA0KPiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9saW51eC0NCj4gYnRyZnMvQ0FMM3E3SDYwZ05CQ196elU4Z2paX3M9N01uTjIzeUZ6
UXFZeGFuaHZ6TU81MHF0WEpnQG1haWwuDQo+IGdtYWlsLmNvbS8NCg0KT2sgdGhhbmtzLCBJIHRo
b3VnaHQgdGhhdCBtaWdodCBiZSB0aGUgY2FzZS4NCkkgZGlkbid0IHRoaW5rIHRvIHRyeSBpdCwg
YnV0IGlmIEkgd2FzIHRvIGRkIHRoZSBvbGQgZGlzayBvbnRvIHRoZSBuZXcgb25lLCBsZXQgaXQg
ZmFpbCBhdCB0aGUgZW5kLCByZW1vdmUgdGhlIG9sZCBkaXNrLCB0aGVuIG1vdW50IGFuZCBzY3J1
Yiwgd291bGQgdGhhdCBoYXZlIHdvcmtlZCBnaXZlbiBpdCdzIHJhaWQxPw0KDQpQYXVsLg0K
