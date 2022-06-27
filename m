Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB1655D978
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jun 2022 15:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbiF0KXV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jun 2022 06:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234096AbiF0KXT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jun 2022 06:23:19 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2131.outbound.protection.outlook.com [40.107.21.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFDA5F9A
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Jun 2022 03:23:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RI+p8S1FnelOJyvYNuIAh7aT0SyJdw8HqUhJ4TjPix8racG74mJViHEQ6aRf7Wdwh6MSYy+At2opozI36eKf5Al8AV1dIHkv9223Y09K5cEiBEJosn+hjonlZdcyzp8NEtco9avk7ojoYFnXTh7ahycAxNXPL/1t8n8Kt9JR43DhyS1dvCV7nj41LC55zxPvBLet1iA38NpykTfa2CD/1pQchs7OHWtEtAIem+t1zu5jfc+mjPaytBrFxg5mHYZV3cqKWUAqla3sx124cD2FSMlNe4kb5FRHw+CEp33g0VmrxJxjUnoIXnMwqmHioFjc1zfrKEWhbn/mJDdjxuuRZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+3ssP+Br669DPnqZHgVY1pANAkniHmKTUSEyIzCJB4=;
 b=VuPvake158Y1CBd+6uf/ytNzKLkgscNZdppmm2PRu9BcI3v7SXOr4Lp5Qo5dlo01OAjm39bOKmhfXLKSkkSdOC2n4Emv+CWI9t/3Asb60HpsVON7mahlIeWOfnQ2b0b/EWO8mqK5hY4NQToKpKXF01VAvrE8eKQcvSIwEQuoFwVddfD1DRBQjwaK9OcxxU41dObMcpPgzcdnS6zL6FzfsqB9KIFeQBowZEIHtQ2z6VywDILbJ6OOxekDYmekQwDr9ubuhd23xpKJqiroRDf/3lqUbRZkQ4F9cKwqNAUmSOdm2TdACEKoD2yOv1/eAiUAh/C/w5Q1GU+ynHGLiE7Fuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bcom.cz; dmarc=pass action=none header.from=bcom.cz; dkim=pass
 header.d=bcom.cz; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bcom.cz; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+3ssP+Br669DPnqZHgVY1pANAkniHmKTUSEyIzCJB4=;
 b=ZNdogSocPupO/+arv/1YQEzThlWssy7/zCKEv2s5LdqdrcyetXx2ltEdMlWoCRBCg5em0tvEKnqc0b4cagcmEFYRWpZEOhHTrBJ2Y9k6XO2M6avEZq5awHmzBnBPEM2DzCHQ37SlmBm6rIs/fH6SCo99QLlwrgXbRrHjoe55fMg=
Received: from PAXPR03MB7856.eurprd03.prod.outlook.com (2603:10a6:102:213::23)
 by DU0PR03MB8720.eurprd03.prod.outlook.com (2603:10a6:10:3ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Mon, 27 Jun
 2022 10:23:11 +0000
Received: from PAXPR03MB7856.eurprd03.prod.outlook.com
 ([fe80::9922:97d9:a13f:6924]) by PAXPR03MB7856.eurprd03.prod.outlook.com
 ([fe80::9922:97d9:a13f:6924%7]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 10:23:11 +0000
From:   =?utf-8?B?TGlib3IgS2xlcMOhxI0=?= <libor.klepac@bcom.cz>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "quwenruo.btrfs@gmx.com" <quwenruo.btrfs@gmx.com>
Subject: Re: Question about metadata size
Thread-Topic: Question about metadata size
Thread-Index: AQHYigSW65wbq0NzSkyBZZP+sZI85K1jCCEAgAADogA=
Date:   Mon, 27 Jun 2022 10:23:11 +0000
Message-ID: <f9b7e2fea36afefaec844c385d34b280f766b10b.camel@bcom.cz>
References: <8415b7126cba5045d4b9d6510da302241fcfaaf0.camel@bcom.cz>
         <42e942e3-a6d9-1fcd-cd9b-5c22ee3f2e1f@gmx.com>
In-Reply-To: <42e942e3-a6d9-1fcd-cd9b-5c22ee3f2e1f@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.2-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bcom.cz;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 960745e8-3a4d-4381-2904-08da582709cd
x-ms-traffictypediagnostic: DU0PR03MB8720:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CB9Tp270sGOWn5QLqkMz9QZUy4YFqC3y5Ar+sPmcaWKwnpW+2anV5wMcqt5F/YSN/RnB7vymbDbYfiHTF1/Rh7mCjy3ZXW54n1kXHBGOd7PxgTRrWS4mPJR4thnmb9zcjaKB+Bz34BlqYuajb/Ck2IBIFZiGz6S/4B34lr/feY88AsrIo7uawbVopUTRu82BGMvNUBDYvh9F0mNvU90ao66ISQ6t948vLu6cPdKizBE0NjTeVQ0OFupKdlB+ZuS5o8WitvLGTdb7kDN0oK6q+CzEQu3WygdGpY8IIHhQYu7j9KQyicn0HbgPHASmHlWI2ZKb0ZaUFg1vSV4JEp6Q/PCiSvv/EWFWvsy4hwMOJYS4Bom3wvbKSsdP1Omafxb7Cz/THgcyVT7315RrHxkXpHHOw24lcATFlHC3CldpShHpFz2CeQ59kzTMBnb5+Bq64v+i9dkIF0Apr7bsoOqgtB6+xie32YCQ2J22tMiU/dg0heIbPplbaStT82FZfZzz/goexCDVPhSrJmhMdrP66TWICGdNPs8k8sUD9wLNwhO9YYjZPAijE2fmeXG9MRABnXITNLt3gYSpeCRNt5RUmIvIg9lRxjUX4rCog24j1lpmyKE19AgSvXq7VauBGqnF7ne3uN+gUBt5s604eG+7ARXFv1kvnBWGCuI2zVbRU8d95yZTI5NYe+fE75olQLrx1R6Sywlmr35ybXku99JRWNsEbj+Tm/Fss88iKeDfHxIrRlVL0PVjr13bZv6mLe4hM7Zfg3q2Q/AhKXyC+gwFSOvPem+YdfebuVGGOLDw6fA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR03MB7856.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(396003)(366004)(39850400004)(136003)(38100700002)(86362001)(6506007)(41300700001)(38070700005)(85182001)(6512007)(316002)(3480700007)(122000001)(186003)(83380400001)(478600001)(2616005)(71200400001)(110136005)(36756003)(2906002)(53546011)(8676002)(66556008)(5660300002)(66476007)(76116006)(91956017)(66946007)(64756008)(66446008)(8936002)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UG1SMzZkczVUbGg2bnVEUHJYZHQxVHdqMzlJRmZ5bEV4NUwxNFUrbm5ENm5M?=
 =?utf-8?B?NUVXdURlU2k0cnNjN2NJU0lzUTZPWUUwMjl0TkFhR0NVdzRMNTdCdHdMQ1pK?=
 =?utf-8?B?eTg2TnFtQm1DR1NYeEpTN0EyNmQwc3dnMnpldlNpQytpbis1T1A4TjZrWmN4?=
 =?utf-8?B?SVh6WFNIbHROaFRyMkkvU2hvY250RXd0c0FRenNUR2RjVmlYRXlJejJKZllr?=
 =?utf-8?B?NTFmSzFEeVF5aTF2YjFVa2lXeFlpMWRpS2UxN2FHZW42RXVZWHlBMmtLZ2RG?=
 =?utf-8?B?Wlpia2hrTGpFY2FjQjJvTWxDclBXMmxMSVlMSW5tVzdaYmxlV0xzYmk5dERH?=
 =?utf-8?B?ak9YR3QyOFV0MlVrc2FRcXdlWGx0YlNCSDRUUzhrZHN5NExRbCt1QlBYK2Z4?=
 =?utf-8?B?STZadFJrUWRiNkRyMUxWWUZFVkg4Z2Rtck5TUkJJVEFKSXN6Z2E3UVFjcWdI?=
 =?utf-8?B?V3RxdmFLZEJDaHovaEhTZHlTVndyRGVOdmxVN1o5Z1pkaVlFVHRLMklRaTlN?=
 =?utf-8?B?cEk5Q1p3YldoSHFGdytiSHJRU09SN2I3Kzl6KzRlTURwSHJSTmhRUGVpY3FT?=
 =?utf-8?B?MkI0VWRjSXpBWUVRbEZ0Z1krNitLc01CdDg3VGFuRmhsb2hoWkhpVFJESitD?=
 =?utf-8?B?NEhtYlRuYlozbzVQUDdzNTZWTnRrSzBBK05Dak15bzUyOUR0NEUyNGhrQUtx?=
 =?utf-8?B?cmxobGNjOTg0UW85cklER3lDdzN3Qy9nTUpjVFZhYUVUVDdoWExTMEdzMEh1?=
 =?utf-8?B?UURrd0QwT0w3WTJwWDRscmxOMGQvS1dCdG9JNmNMdnY0VCtmR3BsRDdNM1pC?=
 =?utf-8?B?Y3NOQUVUM3hXYWcxU1U1UlRxc0lDVjR2em9GVmpEYnJPeHQ5d1haa3JoNmFw?=
 =?utf-8?B?SWlzd0ptek16OXEyMUFhaytGVUVEVXI4NTU2UmdjTlJ5SmtlSUtiUllJSGh6?=
 =?utf-8?B?UzVOYXNlT1FycGFNREJFVmVRNW9TNGZXbGEwT2FpdjNuRHRJOFZ6RHd4L1Vm?=
 =?utf-8?B?U1IzYWZUVk1HTldLbVA1MDdId2w5KzFOL0JrS0VFam5Cd0pjbmhFWFJqWVNi?=
 =?utf-8?B?VUNSV1k2SGg5ZUVBek8vY1NScHhKbzdJUzBtdTdkNmM5RHNucHVRaWpGS2xm?=
 =?utf-8?B?WlRvWGJDUmxxQ1dITEdiWlU2a3FMZjFKOVdYeTRoSHBoYzZVN3Ewb1hGMG9B?=
 =?utf-8?B?U0o4Q084WUVqZy95MnNtVFBZR1pHU2dRQk1pQURkaWNRZ1gzdzlZb21RNWdl?=
 =?utf-8?B?eGx0WWpzQWpNYUhpZk15UXBDUy90ZGUwbmFvT25zbUdnUXpFdFJpcTl4MlMz?=
 =?utf-8?B?YnVuWUhOWUpGREZIMmpseUxqa0t0anlScncxc0VUeUlDS2R1dUp3cmF2blQ0?=
 =?utf-8?B?REs5d0tRUk5SNHQrMjNSMzl4S3NMeGE1NXBobEF0RjkvdUVBWXNNb2FxOG9R?=
 =?utf-8?B?SDBiY1c4Z095b0UrVnUxd2pIdU9jbG1KdGx0SjhENy92YTREMk1MZkI1ZVp4?=
 =?utf-8?B?b1pWMlVSWGcvY0ZwVWhaYnIwRVVJZzVLRWRoeFVTd0dRN3NIcXB5MnV2cGNp?=
 =?utf-8?B?NGZVaDRaOGZKVXBRNGQ4aHJvbllrUkgxajF2QnF4c2JyQU5hSmdlOUZzU0Iv?=
 =?utf-8?B?WWp3UG56UmFwTmZ5T1RpVFM4RmszdVNLMG5RcDRqekR6RGhhUXg3am5zbGpi?=
 =?utf-8?B?LzdrTjY2UkxMRXovd3VVWm53elB5ckNTanhuU0k5MUNEaThwWGlneFJjV1JJ?=
 =?utf-8?B?Ym5tWmhhY1ZSKzUzSXVNUUcwNEtiMWxIU0NMYjFIa2pXYXZkTkVoRlFSaVFJ?=
 =?utf-8?B?TEtrNTZ3V0ZrVjUzS0FMZzNRWTM1STFoMTFrZElQQ1EwOCsrZzhmYVZKZllN?=
 =?utf-8?B?OTU5bG40VEIrZUM1am1USzFqdGZJTnFBdnRNU1lEK1pibVZpdVNWcWQxUll3?=
 =?utf-8?B?TkJVWGlxWkJyU21IcTBIVTVyRjJhLzNmdlkwRjVEQWdMZk9qc1NCcFNFZEJX?=
 =?utf-8?B?bjBsaC8zeG4zM0xFQWwwSy8yRGhmN3hldjRqblNpUlRMazFiNVNlMzNydTE3?=
 =?utf-8?B?YWZzVUplaG4xZzlaelFDRENSeWNlQ2RCeHZIWmtpZFNocWl5eVhpZUo1ekFu?=
 =?utf-8?B?QmV1ZHV4NnJENEJiVnFHSDNzcU56OUZ3TnJYeVMxMlFIRnN2ZVNFakZMMktT?=
 =?utf-8?Q?s1v+CP3PtVq13QjBqbIis6Qis8y5yWMzozYWrXWOAjhd?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E79B12902A794049BC107500EA79EB8D@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bcom.cz
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR03MB7856.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 960745e8-3a4d-4381-2904-08da582709cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2022 10:23:11.7286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 86024d20-efe6-4f7c-a3f3-90e802ed8ce7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g8TfQOr7Ek/b7yGTPU0mfFqlqRMU6R60PAlurmfOxPO02Eh3MlC6kI6uXICEznu7tVqHKpSPrgDlD46u0xU0Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB8720
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gUG8sIDIwMjItMDYtMjcgYXQgMTg6MTAgKzA4MDAsIFF1IFdlbnJ1byB3cm90ZToNCj4gDQo+
IA0KPiBPbiAyMDIyLzYvMjcgMTc6MDIsIExpYm9yIEtsZXDDocSNIHdyb3RlOg0KPiA+IEhpLA0K
PiA+IHdlIGhhdmUgZmlsZXN5c3RlbSBsaWtlIHRoaXMNCj4gPiANCj4gPiBPdmVyYWxsOg0KPiA+
IMKgwqDCoMKgIERldmljZSBzaXplOsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
MzAuMDBUaUINCj4gPiDCoMKgwqDCoCBEZXZpY2UgYWxsb2NhdGVkOsKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAyNC45M1RpQg0KPiA+IMKgwqDCoMKgIERldmljZSB1bmFsbG9jYXRlZDrCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIDUuMDdUaUINCj4gPiDCoMKgwqDCoCBEZXZpY2UgbWlzc2luZzrCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDAuMDBCDQo+ID4gwqDCoMKgwqAgVXNlZDrC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMjQuOTJUaUIN
Cj4gPiDCoMKgwqDCoCBGcmVlIChlc3RpbWF0ZWQpOsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IDUuMDdUaULCoMKgwqDCoMKgIChtaW46IDIuNTRUaUIpDQo+ID4gwqDCoMKgwqAgRGF0YSByYXRp
bzrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAxLjAwDQo+ID4g
wqDCoMKgwqAgTWV0YWRhdGEgcmF0aW86wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIDEuMDANCj4gPiDCoMKgwqDCoCBHbG9iYWwgcmVzZXJ2ZTrCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCA1MTIuMDBNaULCoMKgwqDCoMKgICh1c2VkOiAwLjAwQikNCj4gPiANCj4gPiBEYXRh
LHNpbmdsZTogU2l6ZToyNC44NVRpQiwgVXNlZDoyNC44NFRpQiAoOTkuOTglKQ0KPiA+IMKgwqDC
oCAvZGV2L3NkY8KgwqDCoMKgwqDCoCAyNC44NVRpQg0KPiA+IA0KPiA+IE1ldGFkYXRhLHNpbmds
ZTogU2l6ZTo4OC4wMEdpQiwgVXNlZDo4MS41NEdpQiAoOTIuNjUlKQ0KPiA+IMKgwqDCoCAvZGV2
L3NkY8KgwqDCoMKgwqDCoCA4OC4wMEdpQg0KPiA+IA0KPiA+IFN5c3RlbSxEVVA6IFNpemU6MzIu
MDBNaUIsIFVzZWQ6My4yNU1pQiAoMTAuMTYlKQ0KPiA+IMKgwqDCoCAvZGV2L3NkY8KgwqDCoMKg
wqDCoCA2NC4wME1pQg0KPiA+IA0KPiA+IFVuYWxsb2NhdGVkOg0KPiA+IMKgwqDCoCAvZGV2L3Nk
Y8KgwqDCoMKgwqDCoMKgIDUuMDdUaUINCj4gPiANCj4gPiANCj4gPiBJcyBpdCBub3JtYWwgdG8g
aGF2ZSBzbyBtdWNoIG1ldGFkYXRhPyBXZSBoYXZlIG9ubHkgMTE5IGZpbGVzIHdpdGgNCj4gPiBz
aXplDQo+ID4gb2YgMjA0OCBieXRlcyBvciBsZXNzLg0KPiANCj4gVGhhdCB3b3VsZCBvbmx5IHRh
a2UgYXJvdW5kIDUwS2lCIHNvIG5vIHByb2JsZW0uDQo+IA0KPiA+IFRoZXJlIGlzIDg4NSBmaWxl
cyBpbiB0b3RhbCBhbmQgMTcgZGlyZWN0b3JpZXMsIHdlIGRvbid0IHVzZQ0KPiA+IHNuYXBzaG90
cy4NCj4gDQo+IFRoZSBvdGhlciBmaWxlcyByZWFsbHkgZGVwZW5kcy4NCj4gDQo+IERvIHlvdSB1
c2UgY29tcHJlc3Npb24sIGlmIHNvIG1ldGFkYXRhIHVzYWdlIHdpbGwgYmUgZ3JlYXRlbHkNCj4g
aW5jcmVhc2VkLg0KDQoNClllcywgd2UgdXNlIHpzdGQgY29tcHJlc3Npb24gLSBmaWxlc3lzdGVt
IGlzIG1vdW50ZWQgd2l0aCBjb21wcmVzcy0NCmZvcmNlPXpzdGQ6OQ0KDQo+IA0KPiBGb3Igbm9u
LWNvbXByZXNzZWQgZmlsZXMsIHRoZSBtYXggZmlsZSBleHRlbnQgc2l6ZSBpcyAxMjhNLCB3aGls
ZSBmb3INCj4gY29tcHJlc3NlZCBmaWxlcywgdGhlIG1heCBmaWxlIGV4dGVudCBzaXplIGlzIG9u
bHkgMTI4Sy4NCj4gDQo+IFRoaXMgbWVhbnMsIGZvciBhIDNUaUIgZmlsZSwgaWYgeW91IGhhdmUg
Y29tcHJlc3MgZW5hYmxlZCwgaXQgd2lsbA0KPiB0YWtlDQo+IDI0TSBmaWxlIGV4dGVudHMsIGFu
ZCBzaW5jZSBlYWNoIGZpbGUgZXh0ZW50IHRha2VzIGF0IGxlYXN0IDUzIGJ5dGVzDQo+IGZvcg0K
DQpUaGF0IGlzIGxvdCBvZiBleHRlbnRzIDspDQoNCj4gbWV0YWRhdGEsIG9uZSBzdWNoIDNUaUIg
ZmlsZSBjYW4gYWxyZWFkeSB0YWtlIG92ZXIgMSBHaUIgZm9yDQo+IG1ldGFkYXRhLg0KDQpJIGd1
ZXNzIHRoZXJlIGlzIG5vIHdheSB0byBpbmNyZWFzZSBleHRlbnQgc2l6ZT8NCldlIGNhbiB1c2Ug
aW50ZXJuYWwgY29tcHJlc3Npb24gb2YgbmFraXZvLCBidXQgbm90IHdpdGhvdXQgZGVsZXRpbmcg
YWxsDQpzdG9yZWQgZGF0YSBhbmQgY3JlYXRpbmcgZW1wdHkgcmVwb3NpdG9yeS4NCkFsc28gd2Ug
d2FudGVkIHRvIGRvIGNvbXByZXNzaW9uIGluIGJ0cmZzLCB3ZSBob3BlZCBpdCB3aWxsIGdpdmUg
bW9yZQ0KcG93ZXIgdG8gYmVlc2QgdG8gZG8gaXQncyB0aGluZyAoZm9yIGNvbXBhcmluZyBkYXRh
KQ0KDQo+IA0KPiBUaGFua3MsDQo+IFF1DQoNCldpdGggcmVnYXJkcywgTGlib3INCg0KPiA+IA0K
PiA+IE1vc3Qgb2YgdGhlIGZpbGVzIGFyZSBtdWx0aSBnaWdhYnl0ZSwgc29tZSBvZiB0aGVtIGhh
dmUgYXJvdW5kIDNUQg0KPiA+IC0NCj4gPiBhbGwgYXJlIHNuYXBzaG90cyBmcm9tIHZtd2FyZSBz
dG9yZWQgdXNpbmcgbmFraXZvLg0KPiA+IA0KPiA+IFdvcmtpbmcgd2l0aCBmaWxlc3lzdGVtIC0g
bW9zdGx5IGRlbGV0aW5nIGZpbGVzIHNlZW1zIHRvIGJlIHZlcnkNCj4gPiBzbG93IC0NCj4gPiBp
dCB0b29rIHNldmVyYWwgaG91cnMgdG8gZGVsZXRlIHNuYXBzaG90IG9mIG9uZSBtYWNoaW5lLCB3
aGljaA0KPiA+IGNvbnNpc3RlZCBvZiBmb3VyIG9yIGZpdmUgb2YgdGhvc2UgM1RCIGZpbGVzLg0K
PiA+IA0KPiA+IFdlIHJ1biBiZWVzZCBvbiB0aG9zZSBkYXRhLCBidXQgaSB0aGluaywgdGhlcmUg
d2FzIHRoaXMgbXVjaA0KPiA+IG1ldGFkYXRhDQo+ID4gZXZlbiBiZWZvcmUgd2Ugc3RhcnRlZCB0
byBkbyBzby4NCj4gPiANCj4gPiBXaXRoIHJlZ2FyZHMsDQo+ID4gTGlib3INCg==
