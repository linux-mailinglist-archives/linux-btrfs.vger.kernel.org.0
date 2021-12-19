Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBCF47A16B
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Dec 2021 17:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbhLSQng (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Dec 2021 11:43:36 -0500
Received: from mail-roabra01on2057.outbound.protection.outlook.com ([40.107.111.57]:30502
        "EHLO BRA01-ROA-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229742AbhLSQnd (ORCPT <rfc822;linux-btrfs@VGER.KERNEL.ORG>);
        Sun, 19 Dec 2021 11:43:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nq6CQ96/mnZWIbIEvKR8yKoLA7FRI+d7uBpF0rCvBkpuKFq6+eG8iZho9lOG2XnWxnowH20+yrbGgpKaQcxe7if7ljCdebmbl4I7vAr+JCEvAGvZHoytFBIEQO5TjcxeSgKLyowMCG1JDy2XY6e9J2OU3XC6jtX4y/ncV5EphsNgiervm6D4s6B1cpt8s1PTcnzejsvEEP3C69FBvCCQLR6U2+VsJpKXsVV51qN7IocZnnIlON25khufuT8mm4jkrd6C2+O+j4s9kCO7b6q+lmdp8Wu0G3YPs8ZF/9TZmsYO7gyROPfWV5r5+5UjmCLL5xPKUqCR6YALoO0HodTESQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1T/FacB8s/+rJtgdMAg4ZyN7TBI5tA1Ogz/QF9SC4Vc=;
 b=GwmY+xOou2Q+VGp4X3kKaMz98Q8CFsuyqtc8lB/WXb7I8sa53VB6DuoAdP0yApekwixbBa8CVmFVT1IQqnczP4nREX3p0cE/5/LMIZCCVTFE1k8rue2TnfEv4YHOlQvPaFldN0xL9AhTFFm/8CudGSCppQi5z+wYLYVzv8/4vfwM2nvF0+MBq9cv10M8wv5g6Gks1aTIu8VOe66744kdh6CGM4lZtRF4bHaiLHael5+p+Xv91JawPnGuQhWwtxeTP4Y2Ffz6Ie+HFmh4FTLNcKcLanh734BoCnmwyKkWITmozZzQ/MnLiRT3Ym+DcPrUobDIyXoSvYTh6nBfGcH7KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=stj.jus.br; dmarc=pass action=none header.from=stj.jus.br;
 dkim=pass header.d=stj.jus.br; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stjjus.onmicrosoft.com; s=selector2-stjjus-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1T/FacB8s/+rJtgdMAg4ZyN7TBI5tA1Ogz/QF9SC4Vc=;
 b=l7+s9FNS4rxsKISDZdF6hr5+My5Nnh6CRD1T5+fYwkEvfBrnrLhp8Il0Ugn1VVVbfOrRPJqUj4vweiIsyFCcuK1oEkibweNLHwjNdBg2Qr3J6C/73AxU7iS1fZ92yAeCHf7lSD7UIAaJMGi1v8pyGj1IjGvRf+YBSwKo2L2+Jk8=
Received: from FRBP284MB0699.BRAP284.PROD.OUTLOOK.COM (2603:10d6:203:1a::6) by
 FRBP284MB0540.BRAP284.PROD.OUTLOOK.COM (2603:10d6:203:39::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4801.17; Sun, 19 Dec 2021 16:43:28 +0000
Received: from FRBP284MB0699.BRAP284.PROD.OUTLOOK.COM
 ([fe80::fdbc:7b9d:f5ea:eea7]) by FRBP284MB0699.BRAP284.PROD.OUTLOOK.COM
 ([fe80::fdbc:7b9d:f5ea:eea7%7]) with mapi id 15.20.4801.020; Sun, 19 Dec 2021
 16:43:28 +0000
From:   Jorge Peixoto de Morais Neto <jpeixoto@stj.jus.br>
To:     "linux-btrfs@VGER.KERNEL.ORG" <linux-btrfs@VGER.KERNEL.ORG>
Subject: Recommendation: laptop with SATA HDD, NVMe SSD; compression;
 fragmentation
Thread-Topic: Recommendation: laptop with SATA HDD, NVMe SSD; compression;
 fragmentation
Thread-Index: AQHX9PeMAIFWwWTUJUSLIALJHEyg0w==
Date:   Sun, 19 Dec 2021 16:43:28 +0000
Message-ID: <b4d71024788f64c0012b8bb601bdba6603445219.camel@stj.jus.br>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=stj.jus.br;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8397802-c2de-4c2b-1900-08d9c30eaefa
x-ms-traffictypediagnostic: FRBP284MB0540:EE_
x-microsoft-antispam-prvs: <FRBP284MB0540657DE55D624F9EAA6E68F17A9@FRBP284MB0540.BRAP284.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qCDg/J8KE+WZFWSO51lX4K4/DWcoKbnya5nMm8ZsCiQIQ2w6aGxYraWGNOPBR1lg3I3ALUkkSrV1Vd3pxbubAcwjqidNDsl6zfBPunqTaEYdRhY5ycJJxs35iyGE8/uxyrGhvsZ2e5pRqbqbiN18FmiOhUBGbQLjnt0rdtizr8t/Lk82B8mbvVQ9kGwFbuNZrUqRUJ0aLPDhSdPqeRIVAy1pEPhZFP6Qa51y91t7G5j1BdXafJXP6Qg0mDqDIbl83KafCVgPM4/3Kuqi+QYHs3gkTgI2GV/XXE7ffHrb44ya4joj9twvCh7TACx62i1El8hcptktTaDLh2PvTaK3e8NBPDqgmN6X2qW1xTPC1omf6V5KcyM7NanleCiLQFHiCNBcdd/kleRCli3zBSvfBVQ//Fynt8NtTRqm532TQw5VvcEFvPL+yUku5z/CR9uzRjVKsq3wwDVXPSp4zHHNKLeQOa/Bo0U06N1IEXcBsojKNick39nvbRxyZ5ZdV2c843EyE2BzEmsqFO6ssZpdGw+9ZKn8oo4vhMhfqwqFKrx0Rk5E103ZtSPzDxGn/rZJu26rRFBYxY2FpSmTAZ4mqc132ds0SeltlU+YZDUW+vfJzdte1O4JOtGCOdL4VczFEYMKuELI1h7BYRre92esTFd2iWymWpYgwLIKnk4AxI178f/DQBZT11FEwfbRaHVNsd68jImU5adm5cbi3or8Yi3niKjtvS2hJBtnoa1VJF76EztoUXOtUwffKXurGiXmVJXN4XIunnUw/vx1x505gHPb7F5iRDwqRoTFar/O7k8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRBP284MB0699.BRAP284.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(6486002)(2906002)(38100700002)(122000001)(38070700005)(5660300002)(16799955002)(86362001)(36756003)(66446008)(66476007)(508600001)(66946007)(66556008)(64756008)(6512007)(8936002)(966005)(76116006)(186003)(91956017)(26005)(6506007)(8676002)(6916009)(71200400001)(2616005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUwxdTdOWERGN1NEcmFvS3RFV01TN2FLNUVnakR5K2k4V3hyL2FzSkRYM1NR?=
 =?utf-8?B?a0tYYldyYnRWeFdEYTZKZlpUMG1HNHZLK1V6UmZYaisxNjFhOHFOYllFZHc3?=
 =?utf-8?B?c1R5ZUI1emdDT2RhWHdKMFVVMTJkcm1qRG40NG04RGh2NzdzSnh2UnBuY3lL?=
 =?utf-8?B?RDFVUFNJalBZNjA3c1JsVndIbGM3T2p3aGh6YVZJUnQrdmo2c0xNbFVaK1k2?=
 =?utf-8?B?YmNLc1A0RHBUZWxENTlQLzZGemdjQWMvZUR1KzgyN0J4Y1FPOGZpUGhrSG5S?=
 =?utf-8?B?MHVuTTdmL0FaQnc3ZXhNbW51SUlVaFJPV1F0UjdvaG1HcEoxWVZ6UHpLYUxr?=
 =?utf-8?B?eUJVMjJPclpkVk1WM043MkV2c1pZakFjSFFQeHByM09yTys1N01MM1pKNzJP?=
 =?utf-8?B?Z2ttOGhFdUVtTGsralVaRFZWaTJ2Wi91SFpRY243K1lkL2FyUzN5L1dtU1FS?=
 =?utf-8?B?emRsNVVYL1VIaHNNM3lhTEo3OEVpQnF2dktPR0xuVFZaZXI2K3lLUzFYV3hh?=
 =?utf-8?B?YkpSTDdLeElDODRoTWlNV0R2VGZVQVkwRmR1VXU2RG5BMWpQNm5VSndYMHMx?=
 =?utf-8?B?WHZBTWhPK3ZhL2MrVllndmJ0NmFaUjlyV1RkUHFlWndPQzUvY3JkMndGOTVP?=
 =?utf-8?B?c0hNdGZlNllkRGQrWmtBRldoUUdkZG4ySy9la0JaL29sNU5xNjF6YnM1bnZ2?=
 =?utf-8?B?U2dQZVJ0b0Q1NGtKZnYyNVQxSXdPaU1QdzlvZHBHTmVkSElwQnpRS0tCRnVI?=
 =?utf-8?B?QTFHYWJtTU5Sc1RRZjE3aWxVKzZJSzc2R3BYbDQ2ekl3SFNaZTNMdjNUblNT?=
 =?utf-8?B?MktSY09CZmRpcSt6cFBlM2pST0FYa3lwODlOaCtDWUQ0YjhjSHNJUW9XSHVI?=
 =?utf-8?B?N2k3TGYvSklDVjV5WFFsZVA3TXB1Z0g1SDl6K2FnK3hmWmRMaXU0cUkvK3c5?=
 =?utf-8?B?TzZtQUJJNHhjem5mYzl2d0pScTRrOTFaKzNrRXJad0pmbFR0MFZnNGJ3bzRE?=
 =?utf-8?B?L2pabTZWMlMwMDJBcHdGcjFCaWhzT2pSWUtrYjYvQ3NmcFR1SnNraTNNR21U?=
 =?utf-8?B?MjRuZVFhbkI0WVM3bW5CVVYxK09nb1R1YXRpekM5UHN1Uld5R2tSRW9DMFhF?=
 =?utf-8?B?MDljbmVGOVFXQWF4SDVSbUpBamNkQzZzOWV3K2hrUFYreEwzekZBSzFHVkNF?=
 =?utf-8?B?bytWckY2U251Y3pDcU1TYkwzYlZvKzBEcUhrM0p0T0lEYnRtMlhWT0dRMVRs?=
 =?utf-8?B?TW0yemhrNm9Eb0xNaVRha3NBdVVBRHg0Z0djeU9WVXRndVFhVmZtTzhMZ1ZE?=
 =?utf-8?B?NTh3RXRCcVYzZFpoOG91K2w4VXRDSENKakRqcU82Y3ZabFNUckFzeU05aHVJ?=
 =?utf-8?B?c0l3S1hXc2xHSXJjVlRpQ2xlbVROb1BqSUVMb0NOamRaekZOMXRyd2poQ0ZP?=
 =?utf-8?B?MTVOWTdzblJ0WWZ1bC9FSk0zbWdqUU0wUFppWnRtcVU4Q2REaU80ZG9tTWZZ?=
 =?utf-8?B?VkNqQVRPeGtMWDNTMzd5cXAzSTZBVVZ3RGFzMWRlZVpWT1ZYYjg1RTVCdENN?=
 =?utf-8?B?TlUwUURscWEzcXoyK3RHUVVpZ2FrdUZLZ1h3elFxNEdMVGRjS29HZWs4SGpw?=
 =?utf-8?B?Wm9BSTRuQ1R6Z0pjMzJ0cHFCNFhHOFVXUEplWjU5WVQwaG55WHZyWUxGbGhq?=
 =?utf-8?B?Rld2dXdnM05rdGprMGRnY3phVXdvd1BHUVJhTjAyVFFkZlB5b3JISW1ENHJU?=
 =?utf-8?B?MElyNGk2bGNxNTRNemJzVFN3N09XWVROYWNCeHBSYU5mSW5sbXVHc0dlQVdO?=
 =?utf-8?B?ZnNwVE8zNUY5dnJVWXFmT2dNVURiVnRhM2ZDU2JtSnpzSHlCVkpUVTFhZjV0?=
 =?utf-8?B?Z0VTSUY4dDB2cS9aVElvd0pnekVqZE1WNzYxS2NSMUZOU05xNFNYazRFcmFY?=
 =?utf-8?B?dDJjUFNqbDFCRUhYSEM1cjdmNVd6MHRxcVVKbGtaeUJvNUp2eVBwei9CeTVj?=
 =?utf-8?B?dDlROGdsRkVDS0h1ajZmWVFOVEtIYms4SngyckZhdGl2Skh5TWY3ekhkQWtm?=
 =?utf-8?B?a3dIdGh2MHZoQVVoZW5vVXZOcENNWlROZGdqTEkxM3IwRWY3OGxWdWtyUkVL?=
 =?utf-8?B?Z3liaFVkRTdsTUYzSkhnd0ZmbmgvVUZ6Q0VnZ0VwQTY1QlVnTkVxek5xQk8v?=
 =?utf-8?Q?ARN5i0uLiUdZH7h0f0ailp8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9989282568A03E4A82F46FAF526E58C9@BRAP284.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: stj.jus.br
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FRBP284MB0699.BRAP284.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c8397802-c2de-4c2b-1900-08d9c30eaefa
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2021 16:43:28.0637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: de23d5f0-ccac-4c84-81d6-2892a8c055aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xC6zro3cGHHiE5koNNrPUcxSGmBy5ttzVdss7NXS3zYpZEFB8dYEWlzjFVGSEsJsL3o8Q/A5aa+HKFtOci0d6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRBP284MB0540
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

SGkuICBJIG93biBhIERlbGwgSW5zcGlyb24gNTU3MCBsYXB0b3Agd2l0aCAxwqBUQiBTQVRBIGlu
dGVybmFsIEhERCwgYQ0KbmV3IDI1MMKgR0IgTlZNZSBTU0TCuSwgMTbCoEdpQiBSQU0gYW5kIGFu
IGV4dGVybmFsIDEuNSBUQiBVU0IzIEhERC4gIEkNCnNlZWsgcmVsaWFiaWxpdHksIGR1cmFiaWxp
dHksIHBlcmZvcm1hbmNlIGFuZCBwb3dlciBlZmZpY2llbmN5Lg0KDQoqIERvdWJ0cw0KKiogU3Ry
b25nIGNvbXByZXNzaW9uIGR1cmluZyBpbnN0YWxsDQpGb3IgbGlmZXRpbWUgYW5kIHNwYWNlIHNh
dmluZywgSSBpbnRlbmQgdG8gaW5zdGFsbCBEZWJpYW4gdG8gdGhlIFNTRA0Kd2l0aCBjb21wcmVz
cy1mb3JjZT16c3RkOjEyLCBidXQgYWZ0ZXIgaW5zdGFsbGF0aW9uIGFkb3B0IGNvbXByZXNzLQ0K
Zm9yY2U9enN0ZC4gIEluc3RhbGxhdGlvbiB3aWxsIGJlIHNsb3ctLS1JJ2xsIGRvIHNvbWV0aGlu
ZyBlbHNlIHdoaWxlDQp0aGUgaW5zdGFsbGVyIHdvcmtzLS0tYnV0IHRoZSBpbnN0YWxsZWQgc3lz
dGVtIHdpbGwgYmUgZWZmaWNpZW50LCByaWdodD8NCg0KKiogSEREIENvbXByZXNzaW9uDQpCb3Ro
IEhERCBoYXZlIGEgbG90IG9mIGFscmVhZHktY29tcHJlc3NlZCBkYXRhOiB2aWRlb3MsIGF1ZGlv
LCBwaG90b3MsDQpjb21wcmVzc2VkIGFyY2hpdmVzIGFuZCBkaXNrIGltYWdlczsgYGNvbXByZXNz
LWZvcmNlJyB3b3VsZCBmb3JjZQ0KQnRyZnMgdG8gcmVjb21wcmVzcyBpdCBhbGwsIG9ubHkgdG8g
ZGlzY2FyZCB0aGUgcmVjb21wcmVzc2VkIGRhdGEgYW5kDQpzdG9yZSB0aGUgb3JpZ2luYWwuICBU
aGVyZWZvcmUgY29tcHJlc3M9enN0ZDo0IHdvdWxkIGJlIGJldHRlciwgcmlnaHQ/DQoNCioqIEZy
YWdtZW50YXRpb24NCklzIHRoZSBbR290Y2hhc11bXSBhcnRpY2xlIGFjY3VyYXRlIG9uIGZyYWdt
ZW50YXRpb24/DQoNCltHb3RjaGFzXTogaHR0cHM6Ly9idHJmcy53aWtpLmtlcm5lbC5vcmcvaW5k
ZXgucGhwL0dvdGNoYXMjRnJhZ21lbnRhdGlvbg0KDQpIb3cgc2hvdWxkIEkgYWRkcmVzcyBmcmFn
bWVudGF0aW9uIG9uIG15IGxhcHRvcD8gIEkgZG8gdXNlIE1vemlsbGENCkZpcmVmb3ggKGFuZCBH
TlUgSWNlQ2F0KSwgdW5nb29nbGVkLWNocm9taXVtLCBHTk9NRSBhbmQgRXZvbHV0aW9uLiAgSQ0K
aW50ZW5kIHRvIHB1dCB0aGVtIGFsbCBvbiB0aGUgU1NELiAgU2hvdWxkIEkgbW91bnQgd2l0aCBh
dXRvZGVmcmFnLCBvcg0Kd291bGQgaXQgZGVjcmVhc2UgU1NEIGxpZmV0aW1lPyAgV291bGQgaXQg
YmUgYmV0dGVyIHRvIG1hbnVhbGx5IGRlZnJhZw0KdGhlc2UgZGF0YWJhc2VzIChub3QgdGhlIHdo
b2xlIHBhcnRpdGlvbikgb25jZSBpbiBhIHdoaWxlPyAgT3Igc2hvdWxkIEkNCnNlZWsgYXBwbGlj
YXRpb24tc3BlY2lmaWMgbWVhbnMgdG8gZGVmcmFnL2NvbXBhY3QgdGhlaXIgZGF0YWJhc2VzPw0K
DQpJIGFsc28gaGF2ZSBhIFFFTVUtS1ZNIFZNIHdpdGggYSBxY293MiBkaXNrIGltYWdlIGN1cnJl
bnRseSB3ZWlnaHRpbmcgMjQNCkdCLiAgU2hvdWxkIEkgY29udmVydCB0aGUgcWNvdzIgaW1hZ2Ug
dG8gcmF3IGZvcm1hdD8gIE9yIHNob3VsZCBJDQpjb252ZXJ0IGl0IHRvIGEgbmV3IHFjb3cyIGlt
YWdlIHdpdGggdGhlIG5vY293IG9wdGlvbj8gIEkgZG8gbm90IHVzZQ0KZGlzayBlbmNyeXB0aW9u
IGFuZCBJIHJhcmVseSBzbmFwc2hvdCB0aGUgVk0gZGlzay4NCg0KKiBNb3JlIGNvbnRleHQNCkkg
ZG8gd2Vla2x5IGR1cGxpY2l0eSBiYWNrdXBzIHRvIGV4dGVybmFsIDEuNSBUQiBVU0IzIEhERC4g
IEknbGwgc3RhcnQNCmFsc28gZGFpbHkgcnN5bmNpbmcgc29tZSBvZiB0aGUgU1NEIGRhdGEgdG8g
dGhlIFNBVEEgSERELg0KDQpUaGUgU1NEIHdpbGwgaGF2ZSA1MCBHQiBleHRyYSBvdmVyIHByb3Zp
c2lvbmluZyBhbmQgYSAyMDAgR0IgcGFydGl0aW9uLA0KYmVzaWRlcyB0aGUgc3BlY2lhbCBVRUZJ
IHBhcnRpdGlvbi4gIFRoZSBTQVRBIEhERCB3aWxsIHN0YXJ0IHdpdGggMTYgR2lCDQpzd2FwIHBh
cnRpdGlvbiB0aGVuIGEgYmlnIHBhcnRpdGlvbi4gIEknbGwgcHV0IHN5c3RlbSBhbmQgL2hvbWUg
b24gdGhlDQpTU0QgYnV0IGFsbCBYREcgdXNlciBkaXJzwrIgb24gdGhlIEhERCwgYW5kIHRtcGZz
IG9uIC90bXAuICBBbGwgdGhyZWUNCmRyaXZlcyB3aWxsIGhhdmUgQnRyZnMgd2l0aCBzcGFjZV9j
YWNoZT12Miwgbm9hdGltZSwgenN0ZCBjb21wcmVzc2lvbg0KYW5kIHJlYXNvbmFibGUgZnJlZSBi
cmVhdGhpbmcgc3BhY2UuDQoNCkkgdXNlIEdub21lIGFuZDoNCi0gR05VIEVtYWNzDQotIG5vdG11
Y2ggYW5kIG9mZmxpbmVpbWFwIChJIG1heSBzd2l0Y2ggdG8gbWJzeW5jKQ0KLSBHTlUgSWNlQ2F0
LCBNb3ppbGxhIEZpcmVmb3ggYW5kIHVuZ29vZ2xlZC1jaHJvbWl1bQ0KLSBHYWppbSBhbmQgR05V
IEphbWkNCi0gRXZvbHV0aW9uDQotIEdub21lIEJveGVzIG9yIFZpcnR1YWwgTWFjaGluZSBNYW5h
Z2VyIHJ1bm5pbmcgYSBRRU1VLUtWTSBWTSB3aXRoDQogIDIgR2lCIFJBTSBhbmQgb25lIHFjb3cy
IGRpc2sgaW1hZ2UgY3VycmVudGx5IHdlaWdodGluZyAyNCBHQi4NCi0gbXB2DQotIE5leHRjbG91
ZCAoYWx3YXlzIHJ1bm5pbmcgYnV0IHJhcmVseSBzeW5jaW5nIGNoYW5nZXMpDQoNCkkgdXNlIHpz
d2FwOg0KDQogICAgR1JVQl9DTURMSU5FX0xJTlVYX0RFRkFVTFQ9InF1aWV0IHpzd2FwLmVuYWJs
ZWQ9MSB6c3dhcC56cG9vbD16M2ZvbGQNCnpzd2FwLmNvbXByZXNzb3I9bHpvLXJsZSINCg0KSSB1
c2UgRGViaWFuIHN0YWJsZSB3aXRoIG9ubHkgb2ZmaWNpYWwgcmVwb3NpdG9yaWVzLCBpbmNsdWRp
bmcNCmJ1bGxzZXllLWJhY2twb3J0cy4gIEkgbWFudWFsbHkgaW5zdGFsbGVkIEdOVSBHdWl4IHBh
Y2thZ2UgbWFuYWdlciBhbmQNCmhhdmUgMTYzIHBhY2thZ2VzIG9uIG1haW4gR3VpeCBwcm9maWxl
Lg0KDQoNCiogRm9vdG5vdGVzDQrCuSBBIDI1MMKgR0IgV0QgQmx1ZSBTTjU1MCByYXRlZCBmb3Ig
MTUwwqBUQlcuDQrCsiBTZWUgdGhlIHhkZy11c2VyLWRpciBtYW5wYWdlLg0KDQpLaW5kZXN0IHJl
Z2FyZHMsDQogIEpvcmdlDQoNCg==
