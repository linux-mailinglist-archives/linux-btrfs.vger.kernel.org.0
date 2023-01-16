Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801E066B8F4
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Jan 2023 09:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbjAPIU6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Jan 2023 03:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbjAPIU5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Jan 2023 03:20:57 -0500
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01on2049.outbound.protection.outlook.com [40.107.108.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80A9186
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Jan 2023 00:20:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gxsDXjt3ipAhZ9MmPP2hD58uvN2bp7vOUoCj2bYYMAC4qmPOIsA7lQkuXeFxrEw3CxTnTbb5r2QAKSuoDacqHlJh1cs5sZ9KKYBN+gAAh6qtjWJLVCxA0ZF5TIJY3ykKd49CQG+N3fv/LxVQZKhJwkydooTowWT0EvFqmBy+TAYI7FtigEF5+7zQMXAH0t6O6V60vnjxlC9A+2QRCm8HGDOv9Z2Nn+eYxeTUNNGmNG6wU7UcxTJhIg91jPd1xZ4yTQsk+3t4u9uqjy2X7ddIwrlajqb/3wo060k5+o0sRU77wGqCc9MOHDQHivV2u5q3AY6TWtNC5+GxnqSFBGEF3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDI+nE8pLhP3rjfja1wu+42uP+26hsp91oq8+HAYV1U=;
 b=cOA0sbDOcnq2JgZRcnKMqbYQz5qkFT7kbh8OxIakHSYUuVzZ27hw2OFrm6VB95u+MMVnOveK53mFT7E3+S2e2VthHGoNJ4NLdlt3MB8wBRRezTFOWOQii9C4119WrBrsHJ1GOrRzeaqZq9LoO0L0kJ9HDKtw9RWcUlUddKvfz7s/Sqp43cVwFuHV4OJcL3wpNQaZ0Xs5CgjvUAukMzWjV4mxJCW1jsFnztq2/+RPtTzHVfab2w6+jbq4FXLWeeiz36E+PU1dRJqGwU5Y4Ux2YfdjeAZK1cvSItq60XTx8XAEX7J0nfv16zackND27pzNCAQ2Rak0QxT9Q97IjMpvpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=pauljones.id.au; dmarc=pass action=none
 header.from=pauljones.id.au; dkim=pass header.d=pauljones.id.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oakvillepondscapes.onmicrosoft.com;
 s=selector2-oakvillepondscapes-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDI+nE8pLhP3rjfja1wu+42uP+26hsp91oq8+HAYV1U=;
 b=CXbftySiy0LJJ5jmEpb1gCl6TnyLuq2ZIoIm7+3jdVqcKrpCMR9k4Zlxd8HTzff0Vr18z+gm53UDPuQspXzyZhmz/uLOCVid9ist5mj2X/JZnrnsJ1jXZ9roAMDFpR+gx8mHm5Sjq2LEUj2DwhgK9GuaR8ifPb7v3LcYkPcccGo=
Received: from SYCPR01MB4685.ausprd01.prod.outlook.com (2603:10c6:10:4a::22)
 by SY4PR01MB6091.ausprd01.prod.outlook.com (2603:10c6:10:f4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.10; Mon, 16 Jan
 2023 08:20:50 +0000
Received: from SYCPR01MB4685.ausprd01.prod.outlook.com
 ([fe80::349c:1835:91de:d539]) by SYCPR01MB4685.ausprd01.prod.outlook.com
 ([fe80::349c:1835:91de:d539%5]) with mapi id 15.20.6002.011; Mon, 16 Jan 2023
 08:20:50 +0000
From:   Paul Jones <paul@pauljones.id.au>
To:     "kreijack@inwind.it" <kreijack@inwind.it>,
        Josef Bacik <josef@toxicpanda.com>
CC:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: RE: [RFC][PATCH V5] btrfs: preferred_metadata: preferred device for
 metadata
Thread-Topic: [RFC][PATCH V5] btrfs: preferred_metadata: preferred device for
 metadata
Thread-Index: AQHZKQMAIm9GTBhDe0qPwJfOx724Q66ftPuAgAD/O+A=
Date:   Mon, 16 Jan 2023 08:20:50 +0000
Message-ID: <SYCPR01MB4685437F52218D9D2D19A2149EC19@SYCPR01MB4685.ausprd01.prod.outlook.com>
References: <20210117185435.36263-1-kreijack@libero.it>
 <ef8a85ac-4d77-1842-2969-fdfa8b2691e8@toxicpanda.com>
 <83f2e6f7-2513-6da1-6078-56ca6420d8e5@libero.it>
 <6433005a-21c8-fc9b-6fbd-ae9727751ca5@libero.it>
In-Reply-To: <6433005a-21c8-fc9b-6fbd-ae9727751ca5@libero.it>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pauljones.id.au;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYCPR01MB4685:EE_|SY4PR01MB6091:EE_
x-ms-office365-filtering-correlation-id: 2ed41488-52b0-40eb-a114-08daf79a93f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wKrnZZP5lWr3LL52V9nRWNHEYwtijm4hBKa22U04mYcl/yut4QBPb1G3k7bi1Ce/hbUZBYgcdqDdMsuyOPizlHSO6bTlRLgrGL8+8UBl0zuvSj2MhnUGxIRMWUi2hh0ERE6oLmdEXmjhiJVGOrBT9RkYEt6dNvIHJubT66QCPAO2S8QY0a5BAPAOEsjlEpgh97FWA7ezDhmkb9Zf6iNWJ/fvyJk3iYLNQtXmDfM5IGyAfNA3Dx94S/cilCoPQYSiuX1/5oc5/PE/thA0VSQyzZNrsbfw84f1dhaPXLXblvOwK0RhC5eZrL+0LhrguXza60nKPlNiQNCWZiabOUNM08ULn54sqxwp6659d7ARG/eVMbnxEiBMzUgMtCk1g9JL4IK3YWCMKBYGTbDkaJOcu/n00Q1uNYulXM0uikgeJ598mkJaqleaQKag32weJtu/Cb5Fd/haLKdADSaa+7a3i71bT8ATuTCFrlRgtfWLxWHPRpIe7PvJk4OXSfp/s7rp5Sr8RVyQwyxUICyUd1RJk5SYHhHGkXKwc6a4o++aJvwjOYt2kXoBSHSfGxGSPQMWeuFvOpczcvGsWDFEDYLjxFs6gIvdb07IBMWb/PAFhYmVW+bySV+SwEQQ/U9cjZBYMndUvxtcfCM7/X5U4/OgI8nLcyxKEuNgHxBH9rZSRy0+hr6jIpbwtQ9RZ6z31SutLd4zUtC77nhKRRMsBKr5UfImGgKfrmeacYqas7vGqP0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SYCPR01MB4685.ausprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39830400003)(136003)(366004)(346002)(396003)(376002)(451199015)(6506007)(53546011)(38100700002)(122000001)(2906002)(76116006)(966005)(26005)(33656002)(5660300002)(71200400001)(7696005)(316002)(9686003)(186003)(52536014)(8936002)(83380400001)(66476007)(110136005)(55016003)(478600001)(86362001)(38070700005)(4326008)(8676002)(41300700001)(66556008)(66946007)(64756008)(54906003)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QW1sRTFjY3VDR2hwSXdudFRFbnNxYXk5Y2xzSTVOaUNMSUVsQStSK0VPQVdB?=
 =?utf-8?B?Q2l1cVBEeUhTNmk2QkcwNmFMcGJmVXlHYTB5aktNUmwwaVI0ejA0aVB0M1Bv?=
 =?utf-8?B?RW1uSEtxWThwaU56Z1RkTW5uZ1h3N2E0Nk1VdyszYUF5aGE4UUx1RURhZkNH?=
 =?utf-8?B?MkVVek5aajdtNGdUdk1TTjIrSlFvZ1QzR3JGd1k1bDZNL2Y4OVU0SkhzRTlu?=
 =?utf-8?B?RG9nd1d4US81K1NoK3BJc1lUbit0dW50ZkZEMjBGckdYbmxzYWViVTkzWmlU?=
 =?utf-8?B?U2JLcktMbkFtOEN3Qnd6WVJEanJRTm9WMkJqejdDNGh5aWx1c3ZnNU4wSXQ5?=
 =?utf-8?B?VnByVVcyU2Z4a2VUNFFHOWNWekxzMFV6VE5POXYwa055b2x5YWxxbzRlZnFk?=
 =?utf-8?B?YjNXditPZHhFREhiZFZhUTF2TzB0cU02VmpTU1pncTZPTHh5RHoreWNoUDhS?=
 =?utf-8?B?eFVraElBR1VVVTBVTld1ODRDQ3VYd0k4Yk1ITWFQTldFd0JUdWxYa1RFNHdq?=
 =?utf-8?B?ZXl6empzbmZiWFcveVR5T1M1SG9qMWNxc3kwRlFzYWxINzNWbm4yckFwN1Q2?=
 =?utf-8?B?YlF0OFJEZ0FLMkFQNHB3RGFNR2h6U25NR1dnNWdDdnBWRkdLeWNxT0dqcXdB?=
 =?utf-8?B?UTZmTlJRcndxczl2NE84SzJWTWp6Wk0rM09LbEZ0ZzNXQVUyNVYwMVN3bU1G?=
 =?utf-8?B?SmZvWDNOWm15WHpNbVlyMWhIUFVSWStJdlJXb3NlOU9BNWo5dTZYbGtXNE54?=
 =?utf-8?B?WExxaE8wNVdtQndmbUNEZ3VUKzI2UHhyMlc2Uk1FZSsxamxndExqNlMzaSt0?=
 =?utf-8?B?cFBUdjdTbHdRR1h6SlAyQjVwTDNwK2tJdnVYOUp6Q0N2U29BZk5WTVNWYkV6?=
 =?utf-8?B?clVtRTQ1Z3VZWDlpUHlvVlFJR1JzSCtUZmtONk1ob0dyUDdsd3E2NDdtOWEz?=
 =?utf-8?B?SHRralI3SW40V2h2REdYMmpnbjlYNjhrNHgyN08veEplT1VjK280RDhmK25O?=
 =?utf-8?B?VXJ2S3NQcG9JMDQ2aHZUU25WY0FxNmo0aGZ0WHVTOUE4Wit6OGYvQjNBMW1w?=
 =?utf-8?B?LzFCNGpVZU5qenBvQ3Y0ZW1TVGlZeG5sOVdFcVNVclc0ZUVtRzg2czJMeDZh?=
 =?utf-8?B?dk5qWHBoMTdDSHdHQ3U5d3ZIOHZyemx5KzV0bzhoeTB3UEpEWHRRakxqQnNU?=
 =?utf-8?B?OGN6a1BmekJlZW5IM0JOeDlzMnZDekpMT25VNGVaOVMyWks2azVKOXhSOW9w?=
 =?utf-8?B?NHJudjNSRkJWSHVKTmYwSnJXKzY5RTZZa0k4NzBXTlFicEdLdkpLUjRmQUgv?=
 =?utf-8?B?bndNOXRzQTNuVC8zbHRXUXQrZUZKTWpEUE5ySmVXMFBscTd2a2t4a2J4Y20v?=
 =?utf-8?B?Y0JnbVd4ZFZXRUJaK0FMWll2R2VQemNGbkdPS2ZXa1pDRVU5TldFQk5vNDlo?=
 =?utf-8?B?ZGo2VStqdDRyL204K0xHeEZQR2x3Y01wcGhTY2tGeXpCdUJWbktwVkJ5Y2JR?=
 =?utf-8?B?clN0OUdOU0NsaUkzYjFQempUMWdLMmJYQlFJTmRhUjZ3c2JQL0VZWFZwWEJs?=
 =?utf-8?B?VkJEU3JOd1lPUW5YN2U3aXhGaWlYTWZsTDdhM3BHYzFTRG5pUFUvblJnRUNH?=
 =?utf-8?B?cmJ2YlhtZENSdGVNNlJ2ZnJxUkZ3YTNqL2I5aDlHWDV2K2NUbDAyTk1jYXpX?=
 =?utf-8?B?OXk3RFlDcUhWOWs5SHJnMUN2ek5VYXFpMDYrTWMvQ0FWMkozRXRKUmhnK3Ra?=
 =?utf-8?B?TWNYcjFqUnRJRHpyVytES2Mwd2wrWXdXMVMxQURZUmtKakJVdDVoUmQ1L0Zj?=
 =?utf-8?B?US84dXpidmMyc1BmU0Jlc0pRRkIyRTAzSUFtYzNRWDk5eWxXRFZJeDJGYWtr?=
 =?utf-8?B?VFR2UzNDVkhCRUUxVjU3TTZmTGowTzVuY3dpTFZFZkpCWHllM3hmU1ZGVCs5?=
 =?utf-8?B?SFh3VUpnakhHaGJGZnJxUWZGbjRIeVNTVEpEQ1JrUG9TcFM1YlZwR0ZlVzQ4?=
 =?utf-8?B?THB1VFJrWEhNYzZOdjZBSy9QVUxUWXJaZ3J6SWx4MHNMalZCZnJiRk5DN3FJ?=
 =?utf-8?B?WXNTRE5LQUR0TDFla3cvWTNlNWwyM2N4bGtFaEpCaTdDa2Ivb0EwdUxGeVAv?=
 =?utf-8?Q?708mzk3QipN8CvIHtFlgo2lMF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: pauljones.id.au
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYCPR01MB4685.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed41488-52b0-40eb-a114-08daf79a93f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2023 08:20:50.5693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8f216723-e13f-4cce-b84c-58d8f16a0082
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BbT3CeQ82JHL+0suoOY302R/lGdoyX83y8GATaR6cyV5lIrJ4UrYNEOLrY9mxUGNCjPcgF1M8RKaNPF54rLNKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4PR01MB6091
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBHb2ZmcmVkbyBCYXJvbmNlbGxp
IDxrcmVpamFja0BsaWJlcm8uaXQ+DQo+IFNlbnQ6IE1vbmRheSwgMTYgSmFudWFyeSAyMDIzIDQ6
MDUgQU0NCj4gVG86IEpvc2VmIEJhY2lrIDxqb3NlZkB0b3hpY3BhbmRhLmNvbT4NCj4gQ2M6IFp5
Z28gQmxheGVsbCA8Y2UzZzhqZGpAdW1haWwuZnVycnl0ZXJyb3Iub3JnPjsgbGludXgtDQo+IGJ0
cmZzQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1JGQ11bUEFUQ0ggVjVdIGJ0cmZz
OiBwcmVmZXJyZWRfbWV0YWRhdGE6IHByZWZlcnJlZCBkZXZpY2UNCj4gZm9yIG1ldGFkYXRhDQo+
IA0KPiBPbiAxNS8wMS8yMDIzIDE4LjAwLCBHb2ZmcmVkbyBCYXJvbmNlbGxpIHdyb3RlOg0KPiA+
IE9uIDI1LzAxLzIwMjEgMTYuMjEsIEpvc2VmIEJhY2lrIHdyb3RlOg0KPiA+IFsuLi5dDQo+ID4+
IE9rIHRoaXMgZGlzY3Vzc2lvbiBpcyBnb2luZyBpbiBhIGZldyBkaWZmZXJlbnQgZGlyZWN0aW9u
cywgYW5kDQo+ID4+IHRoZXJlJ3MgYSBsb3Qgb2YgbW92aW5nIHBhcnRzIGhlcmUuwqAgSSBkb24n
dCB3YW50IEdvZmZyZWRvIHRvIHdhbmRlcg0KPiA+PiBvZmYgYW5kIGRvIFY2IG9ubHkgdG8gaGF2
ZSB1cyBnbyBvZmYgaW50byB0aGUgd2VlZHMgb24gcmFuZG9tDQo+ID4+IHBhcnRpY3VsYXJzIG9m
IGhvdyB3ZSB0aGluayB0aGlzIHRoaW5nIGlzIHN1cHBvc2VkIHRvIHdvcmsuwqAgVG8gdGhhdA0K
PiA+PiBlbmQsIEkndmUgb3BlbmVkIGEgZGVzaWduIGlzc3VlIGluIGdpdGh1Yg0KPiA+Pg0KPiA+
PiBodHRwczovL2dpdGh1Yi5jb20vYnRyZnMvYnRyZnMtdG9kby9pc3N1ZXMvMTkNCj4gPj4NCj4g
Pj4gYW5kIGZpbGxlZCBvdXQgd2hhdCBJIHRoaW5rIGFyZSBhbGwgdGhlIHF1ZXN0aW9ucyBhbmQg
cG9pbnRzIHdlJ3ZlDQo+ID4+IGFsbCBicm91Z2h0IHVwIHRocm91Z2hvdXQgdGhlc2UgZGlzY3Vz
c2lvbnMuwqAgRXZlcnlib2R5IHBsZWFzZSB3ZWlnaA0KPiA+PiBpbiBvbiB0aGUgdGFzaywgbGF5
aW5nIG91dCB3aGF0IHRoZXkgdGhpbmsgaXMgdGhlIGJlc3Qgd2F5IGZvcndhcmQNCj4gPj4gZm9y
IHNvbWUvYWxsIG9mIHRoZXNlIHF1ZXN0aW9ucy4gT25jZSB3ZSBoYXZlIGFuIGFncmVlZCB1cG9u
IGRlc2lnbg0KPiA+PiB0aGVuIEdvZmZyZWRvIGNhbiBnbyBhbmQgZG8gVjYsIGFuZCB0aGVuIHdl
IG9ubHkgaGF2ZSB0byBhcmd1ZSBhYm91dA0KPiA+PiB0aGUgY29kZSBhbmQgbm90IHRoZSBkZXNp
Z24uwqAgVGhhbmtzLA0KPiA+Pg0KPiA+DQo+ID4gSGkgSm9zZWYsDQo+ID4gZG8geW91IHRoaW5r
IHRoYXQgdGhlcmUgd2lsbCBiZSBpbnRlcmVzdCBpbiByZXN1cnJlY3RpbmcgdGhpcyBwYXRjaGVz
ID8NCj4gPg0KPiA+IEkgc2F3IHNvbWUgZm9ybSBvZiBpbnRlcmVzdGluZyBieSBNYXJrUm9zZSAo
c2VlIGdpdGh1Yg0KPiA+IGh0dHBzOi8vZ2l0aHViLmNvbS9idHJmcy9idHJmcy10b2RvL2lzc3Vl
cy8xOSNpc3N1ZWNvbW1lbnQtDQo+IDEzNjgzNzc3NTkpDQo+ID4NCj4gPj4gSm9zZWYNCj4gDQo+
IE9rLCB0aGUgbGF0ZXN0IHVwZGF0ZXMgd2FzIGEgVjEyIHZlcnNpb246DQo+IFtQQVRDSCAwLzVd
W1YxMl0gYnRyZnM6IGFsbG9jYXRpb25faGludA0KPiANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvbGludXgtYnRyZnMvY292ZXIuMTY0NjU4OTYyMi5naXQua3JlaWphY2tAaW53aW5kLml0Lw0K
DQoNCkp1c3QgYWRkaW5nIHRoYXQgSSBoYXZlIGJlZW4gdXNpbmcgdGhpcyBwYXRjaHNldCBzaW5j
ZSBhYm91dCBWNCBhbmQgaXQgd29ya3MgYmVhdXRpZnVsbHkgdG8ga2VlcCBtZXRhZGF0YSBvbiBz
c2QgYW5kIGRhdGEgb24gaGRkIChvbiByYWlkMSkuIFdvdWxkIGJlIGdyZWF0IHRvIHNlZSBpdCBm
aW5hbGx5IG1lcmdlZCENCg0KDQpQYXVsLg0K
