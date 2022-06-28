Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A706855E84A
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jun 2022 18:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345260AbiF1OTM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jun 2022 10:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345493AbiF1OTC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jun 2022 10:19:02 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60111.outbound.protection.outlook.com [40.107.6.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9296407
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Jun 2022 07:18:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GfReG4BRD7npsRH30NMUHiJt5zRR840H2UxpKxKZai0GQhShU9rz2mHbJfKCAu3rS7z4I3MDPpfAD6Ffk78JLydqdQaCSkVjUQeaDe+Eqy1huW4BX3blAHTsXnZne81wvdhuAyF6GBw+QP+0s4fy/mvu4GnFNNqGG/nA0c93KrZdYrDn6F6XqKYa/wUF0CY6jQsiwl4BITvrNh5fyYWcwIFXvfaXYBDCJzuQkH1kc567aX/469tiOTj85/8NAlrxpPU9DRXwrcQjB5KMnpTgoy0WbI+wS4n9ZWsw+jyEtDJK10wHqrIe1ksGTYHxO7dUaF7yOOXBHIeG9R4ItJAlVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYHrLMSEEJTHjWfbUFspn0tVA1lx070PxXzU6nb9c0M=;
 b=IaPEbgH6I/NZrX12AOdmoZILndCLjqff1s8T9PctO+qbkCNnK0ZOBNNs2LnzljcQz9yi83roH2ycgTeDprCYUW1gA9hmgD2gMNqGyyRn7G4Cs370dPDSqIlT/Rq+n5pzg4T03vNB+XO2yC3Imx4BiAAWJgRQ0jkzs9T1y078vk3ELI42mJXTjSn+f0amKyEEjKIIkoh/5kv/EkXaWUO2anexpsiLbp9U730oUjah+xshTSdBW9g+o+LBKhA9TWaTkKivw5ESIrC7rkU8BCLOOkWZ41dRaNyPBxp4o8F8j+MMNK+/IDEqH6d2k6ShOPxjs1NthLtsOFCqitEKdbfVrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bcom.cz; dmarc=pass action=none header.from=bcom.cz; dkim=pass
 header.d=bcom.cz; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bcom.cz; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYHrLMSEEJTHjWfbUFspn0tVA1lx070PxXzU6nb9c0M=;
 b=eXCnf+09qZhlc+Jae02e7G9RsWltmLPWmbPSKALvh/r4f+hBucpkoGHbJs3eYayD9q+r6SgFLfd9FOvW9Aj5pQMMy4xY2qsgb2XOvUzEXiaFfHcnne/7F/qtr9R3KFiVKfZsE6MWxbOUavgqDi9DlxVOeuGghhzg5KqyIJjR1wo=
Received: from PAXPR03MB7856.eurprd03.prod.outlook.com (2603:10a6:102:213::23)
 by AM6PR03MB5315.eurprd03.prod.outlook.com (2603:10a6:20b:d1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Tue, 28 Jun
 2022 14:18:54 +0000
Received: from PAXPR03MB7856.eurprd03.prod.outlook.com
 ([fe80::9922:97d9:a13f:6924]) by PAXPR03MB7856.eurprd03.prod.outlook.com
 ([fe80::9922:97d9:a13f:6924%7]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 14:18:54 +0000
From:   =?utf-8?B?TGlib3IgS2xlcMOhxI0=?= <libor.klepac@bcom.cz>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "joshua@mailmag.net" <joshua@mailmag.net>
Subject: Re: Question about metadata size
Thread-Topic: Question about metadata size
Thread-Index: AQHYigSW65wbq0NzSkyBZZP+sZI85K1jCCEAgAADogCAAAi/AIAAF0gAgAAGFQCAACO0gIAACL0AgAAB/YCAAX+mgA==
Date:   Tue, 28 Jun 2022 14:18:54 +0000
Message-ID: <744b2a3ee6fd26824de682a4d6fdc367db85f0fa.camel@bcom.cz>
References: <2b839657cfb533eee9b01a2197e76cf01916a195.camel@bcom.cz>
         <6a345774-e87c-ad3f-1172-e1d59f1382a7@gmx.com>
         <E77A8A5F-4C3F-479C-9428-DE56C82A8618@mailmag.net>
         <cc28f1516a8fe92007994d1a3fcee93f@mailmag.net>
In-Reply-To: <cc28f1516a8fe92007994d1a3fcee93f@mailmag.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.2-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bcom.cz;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3becd19-3c99-465d-edad-08da591121e2
x-ms-traffictypediagnostic: AM6PR03MB5315:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mZvfvWB+BXInXyjl03xJ+DJF+XnE0+IQNYweUSb3TVa1SZoL+j7nGHev3amAD9LNDcgAgq36wwB5Xir+yhxknGN2aJIbauC0K21CWIu2zCRT/WNqD+GmJWfdL2A06a3BITrF0Z9XCgj2QUtX/I6P7VdZEly0ZJqYEIYMU6QCCzsBoCCY6pjP+4fKltJUv7b0sTSFDGdWBvMos9f+wVk4cOUVHponvpW3c9Lsp4LEiRuvaOtHGWoOoNWh5a9xdh9uPAGtgN/X6Rnx3NN0UNuhUO1fyHlTuQ0x4pCOSGGTcH2SI6gDuLno2tJsTQd2f7ctj+YGcACN8Hs4lQ0mN417O4PlWheznooX29zt/sMR+RDC0KlHiSB9RSnGvbG6jicl05rQxrds9MxKs8dDTSGZ0Z8ejqp29e5kTJXoNlYnJwzCkkF6ETidQMncqX9jUwQUc09eiROfeA2bm64YWNcM2WUgMPQ8FZeNGaZjgmbeHWXmcJ92dqv6v83LjcShBDWLrszjZLKSl8rWNTRSOF2kB4+vMuUfo6bWyuCoYa2pXKlT9dsVuFlExLbS3cAsJz9Spjj2Wd1RX/9U8GUmvRCEVPr+Pq5BS1kOsZzF1dsEmAoTgyMLhD+VUoyz3sjIDW+5vTz6yw0io4orXfXxgPG5ms/3IVooGwt1cvxdPvUqX0YmkR+na+raobyAFlhgnX0Va61hEluR03QTrm1kNXJjlX/8Fg0tgQdYwaCCltErGHNoNTBPkLO7NXLNvSJpWDUB2+3yA2zGsfxKtoWS+byfeuibKzS8Vb833GqBdkcmbhzlfkaaRpY7/pdovz7skxHsI1bGfqDiapxOAmLY7CTwwQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR03MB7856.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(366004)(39850400004)(346002)(376002)(41300700001)(6506007)(38100700002)(76116006)(66946007)(36756003)(66476007)(122000001)(38070700005)(66556008)(91956017)(6512007)(85182001)(8936002)(8676002)(66446008)(71200400001)(83380400001)(5660300002)(64756008)(478600001)(6486002)(2906002)(316002)(966005)(110136005)(2616005)(86362001)(186003)(3480700007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0FDaHMrVWFnKzRSZ1F0NDhVQ1hSZ1ZpYzcwdXp2N1JPRUZBMFpEd2N0bm1t?=
 =?utf-8?B?ZHFBYW1lVG9SVVZzdEFYb0xKYUdGTWpmazRYQjBqN1BIRXlIcDBiTDZzbzNM?=
 =?utf-8?B?OXpiK2tYVzJuVVZ6VkFOdngvU3BTRm41UmdyZXJiV09ERHpJaHIwNm55VGFH?=
 =?utf-8?B?Y01QNmxPMGtPVkYrWHY1YUtUTWIwci9KM1R0MGROODBjQXRRK014UXN2RnAy?=
 =?utf-8?B?Y0NXUXBtS1VEMzB0UFF0SjNKRTI4Q2Nublg5dlZHSjdHRVRZN21maFNSUUI2?=
 =?utf-8?B?cTJBcXNtMFE0R0dhK1RqVTlOc0lwZGliQXdrWEJWb3dZSnpDdUk4ZDROcUpi?=
 =?utf-8?B?VHpsd3RsYjlsU1R5SGY0K3NuYlpMS2RwSDJEMURocHhaSG5tWXlVSzRqanhT?=
 =?utf-8?B?VDBFNDZiSG8xRDhQYjVUa2xHYkl6NlZRV1c3VkdieHVEU1ZpQjhkU2NORDd4?=
 =?utf-8?B?a2IxMmc1ZmpFQUY5TWdPSmFZNWRQS29WK1BuUjNEL2JBKzBxcHNkYTJGcTBn?=
 =?utf-8?B?Z3gxOU1mM0ZmMks0UFYza0xCaXh5eE9sSnFKQmFUL3FQYnRTWWdKYkVWVWZl?=
 =?utf-8?B?aDh2NjJIOFh3S2lRUFZVUGZROG0yL1RNNVROdytkTnhNSVVLSnI4K3pBSUUr?=
 =?utf-8?B?SURLN2FmOGE5a09RTGNONTZIWnBUM1BvSzB5eDJmbk9JTFc0bHlQV0JuUjVT?=
 =?utf-8?B?cDlUTnNONTBrUlZYa0tIbFczN3ptR2tsM0owaWlxbTFkK1RkQ3Mxd0VQM0ZK?=
 =?utf-8?B?MEttaDBvMjlmTUlpVTluTDIxeEJURGh4dTZDN24wVExkYVhQSWhZa2pQWERy?=
 =?utf-8?B?NXFFRmQ3Qkw5Z05mRmJhQjBtc0VCRWFqRWl2ZWNlT0Jlb2FDRU1xdzUrcGx5?=
 =?utf-8?B?L1VTMEgxOUJQS0pQV25kRlg1MEVoWm0zK0JFQVBGeHhlZnB0RUY2eU1rNzE1?=
 =?utf-8?B?bXpWOTN1WXZiUTRxdDdBcFVCZHdXSjFmb0dXS0JyWEVtanlXUmhBUnVIZnR3?=
 =?utf-8?B?TnlZd3VBM1F3RDZwcFpxSG9QVmJub24rWXh0blg3MzF2R2dxTmVJS1g2M3dD?=
 =?utf-8?B?ZjdRTnh3NVZmdjg2SDZVSlBHY242Z0IzOTF5endBM1BaQUh0SEpjaGlDakRH?=
 =?utf-8?B?TVZjN1lxTWxwdVhhSU5XZGo0VUNZSjdPS0tqRCtkTytMbkJZdUhKaUQ0UEZU?=
 =?utf-8?B?UW5OWlpYZkFONkRkVVY5UUhFVEpvcHIxdnBmdHZTVkVmS1dZV2QwQzVwYlhi?=
 =?utf-8?B?MFBjL2pwUkJBNHJoYzI0M1FKMG81azlPM0pWa3dvTXA5WVpjRmUxbHNDaE9s?=
 =?utf-8?B?SUVid2E1KzRmdkVNeTdBUWNWZmpxV1FiL1JvZzJUVktWS2xRZHp5Rk8yT0FM?=
 =?utf-8?B?ZW14VUowWDIxODlFaXcyK2MxZ0Q3b1ZDNDIzemZNR3dTbFZZVzh1b3pQejN1?=
 =?utf-8?B?RjQ1akx6eS9KWmc2Y3JDYnpPOThQbDhtMGptY2toNWQzWElZL1N2QitJcTlP?=
 =?utf-8?B?dlE3N1hlSU05bFpaVXdlSHZNZlcyYkUxRkxQdEdRZmFJRCtqbmtrYW5ldVBl?=
 =?utf-8?B?T3B3OUl1MHBpNTVWeG05clM1eStUNnhjYVRjd3gyemxhU2s1ckNpaEVVUGla?=
 =?utf-8?B?bzBWOXN3b25TcnBWLzNUY1l4SzJtYWJMa1FSZkMyc2RPV2ZLUE04TEV5aERO?=
 =?utf-8?B?Y0xMUndqU2cyem5KdDZ3K1dvV2NFeitGM1BlZFoxbUhmWEl5eUhrRFh4dXdK?=
 =?utf-8?B?NU95bW84YXhXUCtrTXNHeUU5cEJBc1VWVmtWRGdJM0NKakZ3WGlQdDlJUEpO?=
 =?utf-8?B?MkxpS1RMZ1VMcUpIUHZ3V3dXRGYwTFdjT1hrV3pyeS9mQnpRbWdpWnE2YThW?=
 =?utf-8?B?RkltcUJWOGNXZXI1bFVWSThBbTFiRjdLOTV2ODRnbEpvYmkwMkJmMG1jU1R2?=
 =?utf-8?B?TXNRajJsaGdaZXBWMkFGUlA5YTdNZFlZbm5Tb1VpSnZTdm0yeWZCZ1lPaVU4?=
 =?utf-8?B?L2M3KzdIMlczbkNuVnlJRUl5RTFZRURDa0h5ejNaMmlEbzBPbWo4NHdpSWRK?=
 =?utf-8?B?eWtCY2JPNnUxSUprNzg2dnFHT3pIR0VkNkJTNURiRWhhcldrRytsNDR5K3pD?=
 =?utf-8?B?M3pQRXBkRkwxN21NaFp1MTV2SFEvQkZQK3JtZWZsWlNYejQ0RGJwdmpIQWUr?=
 =?utf-8?Q?albPHDPRfvLW6Vfrn/LrNwd1EeHLlx5Aa7fMtUfX6TWz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1901708F7F204C47B78232655E77ABB1@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bcom.cz
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR03MB7856.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3becd19-3c99-465d-edad-08da591121e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2022 14:18:54.3714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 86024d20-efe6-4f7c-a3f3-90e802ed8ce7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dBBhLzepvCHmOlFdjal2LoS4cP6coWYGA+cAruRDy5Aa+PBkOHNyxJ0z5BTv0M3Hzv4rlGDQXVrAi6Q2N7Lreg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB5315
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

SGksDQoNCk9uIFBvLCAyMDIyLTA2LTI3IGF0IDE1OjI1ICswMDAwLCBKb3NodWEgd3JvdGU6DQo+
IA0KPiBIbW0sIHlvdSBhcHBlYXIgdG8gYmUgcGFydGlhbGx5IGNvcnJlY3QuDQo+IA0KPiBUaGVp
ciBkb2N1bWVudGF0aW9uOg0KPiBodHRwczovL2hlbHBjZW50ZXIudmVlYW0uY29tL2JhY2t1cC83
MC9icF92c3BoZXJlL3RvcGljX2NvbXByZXNzaW9uLmgNCj4gdG1sDQo+IENsYWltcyB0aGF0Og0K
PiAiRGVkdXBlLWZyaWVuZGx5IOKAlCB0aGlzIGlzIGFuIG9wdGltaXplZCBjb21wcmVzc2lvbiBs
ZXZlbCBmb3IgdmVyeQ0KPiBsb3cgQ1BVIHVzYWdlIGFuZCB1c2VzIGEgdmVyeSBzaW1wbGUsIGZp
eGVkIGRpY3Rpb25hcnkuIFRoaXMgbWV0aG9kDQo+IGNhbiBiZSBhIGdvb2QgY29tcHJvbWlzZSB3
aGVuIHVzaW5nIGRlZHVwbGljYXRpbmcgc3RvcmFnZSBvciBXQU4NCj4gYWNjZWxlcmF0b3JzIGJl
Y2F1c2UsIHdoaWxlIGl0IHdpbGwgbG93ZXIgdGhlIGRlZHVwZSByYXRpbyBjb21wYXJlZA0KPiB0
byBubyBjb21wcmVzc2lvbiwgaXQgd2lsbCBzZW5kIGxlc3MgZGF0YSB0byB0aGUgZGVkdXBsaWNh
dGluZw0KPiBhcHBsaWFuY2UuIg0KPiANCj4gU28gaXQgZGlkbid0IGRvIHdoYXQgSSB3YXMgZXhw
ZWN0aW5nLCBhcyBpdCdzIHB1cnBvc2UgaXMgd2hhdCB5b3UNCj4gc2FpZDrCoCBtb3JlIGZvciB0
YWtpbmcgdGhlIGRlZHVwZSBsb2FkIG9mZiB0aGUgYmFja3VwIHNlcnZlcihzKS7CoCANCj4gDQo+
IEludGVyZXN0aW5nLCB0aGFua3MgZm9yIHBvaW50aW5nIHRoYXQgb3V0Lg0KPiANCg0KSSBqdXN0
IGdvdCBhbnN3ZXIgZnJvbSBuYWtpdm8gc3VwcG9ydCwgYWJvdXQgY29tcHJlc3Npb24uDQpJdCBj
b21wcmVzc2VzIHNlcGFyYXRlbHkgb3ZlciA0TUIgYmxvY2tzIG9mIGRhdGEuDQpTbyBpdCBzaG91
bGQvbWF5IGJlIGRlZHVwZSBmcmllbmRseT8NCg0KTGlib3INCg0KDQo+ID4gDQo+ID4gPiA+IEl0
IG1heSBtYXliZSBzcGVlZCB1cCBiZWVzZCwgaXQgY2Fubm90IGtlZXAgdXAgd2l0aCBkYXRhDQo+
ID4gPiA+IGluZmx1eCwNCj4gPiA+ID4gbWF5YmUNCj4gPiA+ID4gaXQncyAoYWxzbykgYmVjYXVz
ZSB0aGUgbnVtYmVyIG9mIGZpbGUgZXh0ZW50cy4NCj4gPiA+ID4gVW5mb3J0dW5hdGVseSBpdCB3
aWxsIG1lYW4gc29tZSBzZXJpb3VzIGRhdGEganVnZ2xpbmcgaW4NCj4gPiA+ID4gcHJvZHVjdGlv
bg0KPiA+ID4gPiBlbnZpcm9ubWVudC4NCj4gPiA+IA0KPiA+ID4gSSdtIHdvbmRlcmluZyBjYW4g
d2UganVzdCByZW1vdW50IHRoZSBmcyB0byByZW1vdmUgdGhlDQo+ID4gPiBjb21wcmVzcz16c3Rk
DQo+ID4gPiBtb3VudCBvcHRpb24/DQo+ID4gPiANCj4gPiA+IFNpbmNlIGNvbXByZXNzPXpzdGQg
d2lsbCBvbmx5IGFmZmVjdCBuZXcgd3JpdGVzIGFuZCB0byB1c2VyLXNwYWNlDQo+ID4gPiBjb21w
cmVzc2lvbiBzaG91bGQgYmUgdHJhbnNwYXJlbnQsIGRpc2FibGluZyBidHJmcyBjb21wcmVzc2lv
biBhdA0KPiA+ID4gYW55DQo+ID4gPiB0aW1lIHBvaW50IHNob3VsZCBub3QgY2F1c2UgcHJvYmxl
bXMuDQo+ID4gPiANCj4gPiA+IFRoYW5rcywNCj4gPiA+IFF1DQo+ID4gPiANCj4gPiA+ID4gDQo+
ID4gPiA+IFRoYW5rcywNCj4gPiA+ID4gTGlib3INCj4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4g
PiA+IA0KPiA+ID4gPiA+IFRoYW5rcywNCj4gPiA+ID4gPiBRdQ0KPiA+ID4gPiA+IA0KPiA+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBUaGFua3MsDQo+ID4gPiA+ID4g
PiA+IFF1DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IFdpdGggcmVnYXJkcywgTGlib3INCj4g
PiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+IE1vc3Qgb2YgdGhl
IGZpbGVzIGFyZSBtdWx0aSBnaWdhYnl0ZSwgc29tZSBvZiB0aGVtIGhhdmUNCj4gPiA+ID4gPiA+
ID4gPiBhcm91bmQNCj4gPiA+ID4gPiA+ID4gPiAzVEINCj4gPiA+ID4gPiA+ID4gPiAtDQo+ID4g
PiA+ID4gPiA+ID4gYWxsIGFyZSBzbmFwc2hvdHMgZnJvbSB2bXdhcmUgc3RvcmVkIHVzaW5nIG5h
a2l2by4NCj4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiBXb3JraW5nIHdpdGggZmls
ZXN5c3RlbSAtIG1vc3RseSBkZWxldGluZyBmaWxlcyBzZWVtcw0KPiA+ID4gPiA+ID4gPiA+IHRv
DQo+ID4gPiA+ID4gPiA+ID4gYmUNCj4gPiA+ID4gPiA+ID4gPiB2ZXJ5DQo+ID4gPiA+ID4gPiA+
ID4gc2xvdyAtDQo+ID4gPiA+ID4gPiA+ID4gaXQgdG9vayBzZXZlcmFsIGhvdXJzIHRvIGRlbGV0
ZSBzbmFwc2hvdCBvZiBvbmUNCj4gPiA+ID4gPiA+ID4gPiBtYWNoaW5lLA0KPiA+ID4gPiA+ID4g
PiA+IHdoaWNoDQo+ID4gPiA+ID4gPiA+ID4gY29uc2lzdGVkIG9mIGZvdXIgb3IgZml2ZSBvZiB0
aG9zZSAzVEIgZmlsZXMuDQo+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gV2UgcnVu
IGJlZXNkIG9uIHRob3NlIGRhdGEsIGJ1dCBpIHRoaW5rLCB0aGVyZSB3YXMgdGhpcw0KPiA+ID4g
PiA+ID4gPiA+IG11Y2gNCj4gPiA+ID4gPiA+ID4gPiBtZXRhZGF0YQ0KPiA+ID4gPiA+ID4gPiA+
IGV2ZW4gYmVmb3JlIHdlIHN0YXJ0ZWQgdG8gZG8gc28uDQo+ID4gPiA+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gPiA+ID4gV2l0aCByZWdhcmRzLA0KPiA+ID4gPiA+ID4gPiA+IExpYm9yDQo=
