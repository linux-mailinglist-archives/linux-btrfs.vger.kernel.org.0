Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40EF255DC20
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jun 2022 15:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235065AbiF0OeL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jun 2022 10:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234201AbiF0OeK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jun 2022 10:34:10 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60103.outbound.protection.outlook.com [40.107.6.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E1EB4B0
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Jun 2022 07:34:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7QHU6QRvt4FyG5BNEBLPsv0EL44judG6GYSNxi/tFfJ38J8MvmwX0TsVsgdytHnBcAsFgiM0edmhEKYgQxhuyZJaV6jmJIz94O6c0lWIAUEKLwfhuMnU/j/iqGDQI7COYhmSphzstXWg5MZtdo7cIEML75I4sN/0XYAffB4tDov/kk8sMaaGNreCsgJBeMIwOcxSCmKtheEwgXgfUMtT3GNG82rYlE1OinYi5xoe5b65Z8OKGl/A0dnRdpHMTC344t2XL1jgkFBXZPVRwvxhQQVpy6Toimi2pkNahMbht2sbvLfnJXiYw8PWS9jVzeOcEjN59OYHJ5iooi3qVDndg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4dTF4YDw1utqJacAyrg3BpGlKk8vRTf7g/MaGltQfM=;
 b=EPupAuWwMqglz+XPTEWHLdQ6FcvOKZPg9oFM9RtKHSEnyl1/yv17SGdba8+W5VALoPOLdIgjKAg7UTvlOK1X/gAf+CzzmZRAK0AL4WNoNooEgGhJ48J+Vcz2SVl5yGnaTF0GG8QRZKPUa+/ppIC5nts4SxWKMu5DxvXfCcmECTz4PZp03UsV54v483yeulR3ltZA1n8YGiivu0tkd2OyDWUlUc1Yjc+B08ryJ8B41C+gPgh5Lq4bdW1Hgag17Z9N6o2kYV6GVyp3wpkE0SbUSOFQ9lnIrI+YEyxlDGrbwLHJEL8copT6mfLzsth9uPW47LlGlmeRm5OEczENJwrOGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bcom.cz; dmarc=pass action=none header.from=bcom.cz; dkim=pass
 header.d=bcom.cz; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bcom.cz; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4dTF4YDw1utqJacAyrg3BpGlKk8vRTf7g/MaGltQfM=;
 b=kdg0XNTWTp6UDDKhVN+twId7+S93mVNadhi7vb50g5ubQ82y5wjl/w/upOPc3X8nz6cGCSfeey/WJuhkpR6RIiCoB+kTX2ojifqDO+aB50jUnwu9u3uqZ3ZCaQlHgmB3G1wji3K25tevuN2taIqVBuxKbRqauv94SEGMrGme/kE=
Received: from PAXPR03MB7856.eurprd03.prod.outlook.com (2603:10a6:102:213::23)
 by AS4PR03MB8155.eurprd03.prod.outlook.com (2603:10a6:20b:4e2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Mon, 27 Jun
 2022 14:34:03 +0000
Received: from PAXPR03MB7856.eurprd03.prod.outlook.com
 ([fe80::9922:97d9:a13f:6924]) by PAXPR03MB7856.eurprd03.prod.outlook.com
 ([fe80::9922:97d9:a13f:6924%7]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 14:34:03 +0000
From:   =?utf-8?B?TGlib3IgS2xlcMOhxI0=?= <libor.klepac@bcom.cz>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "quwenruo.btrfs@gmx.com" <quwenruo.btrfs@gmx.com>
Subject: Re: Question about metadata size
Thread-Topic: Question about metadata size
Thread-Index: AQHYigSW65wbq0NzSkyBZZP+sZI85K1jCCEAgAADogCAAAi/AIAAF0gAgAAGFQCAAB/7AA==
Date:   Mon, 27 Jun 2022 14:34:02 +0000
Message-ID: <1e4f9dab54ee17f3ddb22287ae37b8f9c2dd4984.camel@bcom.cz>
References: <8415b7126cba5045d4b9d6510da302241fcfaaf0.camel@bcom.cz>
         <42e942e3-a6d9-1fcd-cd9b-5c22ee3f2e1f@gmx.com>
         <f9b7e2fea36afefaec844c385d34b280f766b10b.camel@bcom.cz>
         <068fdbd5-d704-c929-355b-9cf0f500807f@gmx.com>
         <d97f1c183d0babf67c888c7fb79316be0d3f5073.camel@bcom.cz>
         <6a345774-e87c-ad3f-1172-e1d59f1382a7@gmx.com>
In-Reply-To: <6a345774-e87c-ad3f-1172-e1d59f1382a7@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.2-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bcom.cz;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b37abbab-4c99-4612-2553-08da584a1508
x-ms-traffictypediagnostic: AS4PR03MB8155:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8mj1j1JPMTrxNJp1N7kEH0WF4+drvdjRA1lr3nM8K1m59q6WPuerRA9Z4s+gqUkIkPNe05grazxuqnNfheFErc+jQxX3nnfZu0/0ogalZYABM42Vrd5jsREtjOWuqM5YwhUTlximTwmUk7J0KlcQblyNNfjIMa9/Cgg6JW/qwi3GYVId7izBIrMrXCV1b0QadOVX0P/9KT3ItgadpTXbXVMlIGkKiwz/Aj3TJ6nxIl+sIDQr0jIAXIjnA9lVhYPWnGd0vvmth/3zs195AX+9RWAJefAyOqTb3fACYCrK3sPhHs5hTpBa/x5wLk+aIKJhjJI2aqLFMSjwCUfuTHI+E6iERX8dBpCD/63Gz+flMzACX3sjyVgUzZOpMPLiCMQywwkLsQN9188U0vJ2DsQOCCqB4mxXM88hgekAFoJSBUUugQu9UHZRQ/TB6qaT0jT2wZxRa0A1MiU1NqM84Tlv09FKCQsInYE2KPMtehttcvWrKO8vl2BMLod5Kxxi3xdTWYM/dsLuiBLEJRy4rQdEbXmAXoKqcBSDjbnm/oslRm3Gqi5rzJLJ3NV06zivl528/v/GiQHOpu2vMt3cwWdHQzRm/KRwzFNljGSjUsgLFE/71SaFXxWI5jf5gyVwhC6q5s288cY8a30bOCBrrYdPyh4kb+SRvS6/r+mlpjL8/VQraH99GcxqlQKi4xod5tnfFkuStI3LHfOyC0pqq6Je7UoVzrVN8lFOHEDyIiE4e6Wc85b5TozGAA26QlaCcC5u/8ulyrhm29/UaXHAAYYhRwULPsa3i5+Gmh0T7qqpyXs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR03MB7856.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(366004)(136003)(346002)(39850400004)(53546011)(5660300002)(38070700005)(86362001)(8936002)(6506007)(83380400001)(8676002)(64756008)(66446008)(66946007)(66476007)(76116006)(66556008)(2906002)(41300700001)(91956017)(6512007)(85182001)(2616005)(6486002)(71200400001)(110136005)(122000001)(3480700007)(186003)(38100700002)(316002)(478600001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QmhvckhZdWU2ZUh3Y2M0cXh2RnNrVFpMMGJvbkI5Y0o0Q3NPeVRrdEd0OEVR?=
 =?utf-8?B?eVBWVUlPM3B5a3dFQnpGY0thYis4Z2U3LytwQjVHektpMS9KTncxdHdpTWE1?=
 =?utf-8?B?T1d4Y0FBUllMeU9EOGVnT2ZYNVZFeERwQVJKYk9XbElKVk9iMVJHVGx5aFhM?=
 =?utf-8?B?Z2pXWTBzS3lDNVhrdjIvMmhLK1pXdW5OcFhWUmJNY21JUFk2N01pVE81UDY4?=
 =?utf-8?B?VGt5eVcrdmdZMHFVM0s4a1VDYWJUSEE0UURrdHYrMXI1OUw4L1VyYUpPWTNQ?=
 =?utf-8?B?ZHRISGVhNGV6dkRMcFNPTWRYSkYzY2pVMVkwU0YxRHo2c0VvTCtkck9kcWRY?=
 =?utf-8?B?QWJmSTZyaVZ4bkdlYjJjdjhBSzd6WER1K3BTMURLMVE5Mm9RS2RCRTRUOGUz?=
 =?utf-8?B?eDJoYmx2TWVFZjRtVzhSUThVYlZIZ2lpYkRDZnVHUlNsZ1RyNktxY1lRQjB2?=
 =?utf-8?B?cTArMEVkc0VLMTJ0R245NGVsQWtsdEtLVGRBbjR4aWdrb2Q4bjEycHZNMzQw?=
 =?utf-8?B?eFF2cnBxcjNmZWZ3a3VZMEtDWHliTm15UmpSdVhxWld5NW1qMUNscGYxakEr?=
 =?utf-8?B?REg4NHJMYURQVTZCbTNJZXNkQXRtT3hWUEM2Ylhtek5teW5sNXRWK3JlZ1Iz?=
 =?utf-8?B?V2dzL0dCNWhENEpxNVlVcUtPRWJRUGNoMVVCaEQ3NkExT0dVc3ZYSjR2d2V6?=
 =?utf-8?B?K1FxRzdUdUxISG1rN3JkajR6eWNZK3IvVytHVnRlWW5RS1o2bnlxNUk4WUk3?=
 =?utf-8?B?dHJqYTRRQ2E1TStoYXdRejgxUmdqM3FSQ1dwdERoRVNiZnJWaU9PNkRGa3lI?=
 =?utf-8?B?R1VjYk9POElEOHZ0QmdkcXAzMlVOTjBZVkFCRFAyNUdCd1pncytrYkhNcTlD?=
 =?utf-8?B?S2tXWThKb3RXaWJJOTJQWUdzVWZKV3owQ2luaEd5LzVtSCtoejZPbjJOc0hh?=
 =?utf-8?B?Rnp6akh1TkE2MFVlQTNTaVNqY1QwdnFLRDVkV0RWVW5IT1Bka2dBd2hKcHVx?=
 =?utf-8?B?amxQZVM4MkJqTGRxclliejRUd0p4dVRnSGhBNFhCSStLYWNub3pWZnpqRVdT?=
 =?utf-8?B?cTJOQUtxZGFxNzZrOUlqSEt3T05BYVc4c2pUVXREVEFGUU9zdjRsc2o1WjVy?=
 =?utf-8?B?ZmVrWEdoV2diaS84cUhHM2pxMmVBRWIzczlDcCswNU5UVHljMW42bVE0R2cx?=
 =?utf-8?B?bG90OHBvalNMTzBwcmlERWIxWEFiZW1BTzFLeG1zdHAwM3NFYmYwR2xRMmhR?=
 =?utf-8?B?Y2tNdTJDRlh5dk0zaHpNRHNKcFFHU05lRGlJZFlPQzVKeCtLL3M0WEZRZENz?=
 =?utf-8?B?eTFqZjlFYWNlS080WDNkSFRoaHpoZmw0UDlRWkE5ZUxRK1BrNDJuZDd4NkhX?=
 =?utf-8?B?aWxJb0plS2xsa0Y0bkEwWFIwVjl6dzBYNnFsUFREaHRuWHRvcWE2eE5vN0lk?=
 =?utf-8?B?SG5VUlk4Q0FmN3ZIVUtEQ3BIR1pnL2tqVmVqTTdJazBPV2lJNzdHeHVUc3c0?=
 =?utf-8?B?R1ptSXRIMnhnYTBsTHI5aDhxYitNL2IxOEgxQ0VVdHRVNHh5QklSc01kcDc2?=
 =?utf-8?B?R0hsWTNoWXJJTlpEN0pwOGpMTVNoYUx1eVNCS1MyT000VnVmOVhLVlZ1WklY?=
 =?utf-8?B?TmJlWThFQ043NFl4MUNxNWV4K1M5SjdGcCt2Q1dPb1hFSE5MMGVqeUJBZkh4?=
 =?utf-8?B?bEhTZ1h1eVdvNW1wTTFmQnNTZWI1ejZXT3IrQjNVRkgwbDNLUHFRL1p4TWJH?=
 =?utf-8?B?RHIzVzlBRHhvQldoSnZMd2FSa09nUWNpUncxMVAzaXVXVGl6VHVIMy9xMUNi?=
 =?utf-8?B?NDN4clU2bDduS0ZYcFg5Q1N4Mk82WEpmazY3dkVuMU0rNUtxb1lBSHp4d3lN?=
 =?utf-8?B?ODFSaTRUYW52SlplbHVCZHpWUEFZaGZtRGtZdEpaRzkvSHNsV1Rqa2dRN1Jl?=
 =?utf-8?B?dHFOejU1MjY1eERnbFdJYklWNGhKZUZ6KzhXMXFVU1FXblZJTkJKSXJmMjh4?=
 =?utf-8?B?WDFleGxXMkJTcjdtaG5SNGsvdE5USDZBaDEzZFBPazVjNEJRNE5CTWMyL1Ey?=
 =?utf-8?B?QzZFcG43MFdKY21xREVPS2x6b25XQktXSU1OUCttaEEzU3R6SGVnam9UeEwv?=
 =?utf-8?B?a2NFU1BxNmg1SHdjOStLdGZLQUNvbGZXNnZwR05BaTQ5aWI5TUx5MEt3VG9J?=
 =?utf-8?Q?OS0cb4+A9Um3iYzQ1dU5e7sB3D3FSOqeSCfzGe0y7vjL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E41B120AAEB2DA449A0E5AFE598BF103@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bcom.cz
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR03MB7856.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b37abbab-4c99-4612-2553-08da584a1508
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2022 14:34:02.9713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 86024d20-efe6-4f7c-a3f3-90e802ed8ce7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LFQi9OjtGHqnL3dXnoURAdHD+NksETkxxjvLODDhMNwhcZKbaVeBVsGfc+R5pf1H2IOXkXqialFFzPcOHiRSRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR03MB8155
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gUG8sIDIwMjItMDYtMjcgYXQgMjA6MzkgKzA4MDAsIFF1IFdlbnJ1byB3cm90ZToNCj4gDQo+
IA0KPiBPbiAyMDIyLzYvMjcgMjA6MTcsIExpYm9yIEtsZXDDocSNIHdyb3RlOg0KPiA+IE9uIFBv
LCAyMDIyLTA2LTI3IGF0IDE4OjU0ICswODAwLCBRdSBXZW5ydW8gd3JvdGU6DQo+ID4gPiANCj4g
PiA+IA0KPiA+ID4gT24gMjAyMi82LzI3IDE4OjIzLCBMaWJvciBLbGVww6HEjSB3cm90ZToNCj4g
PiA+ID4gT24gUG8sIDIwMjItMDYtMjcgYXQgMTg6MTAgKzA4MDAsIFF1IFdlbnJ1byB3cm90ZToN
Cj4gPiA+ID4gPiANCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBPbiAyMDIyLzYvMjcgMTc6MDIsIExp
Ym9yIEtsZXDDocSNIHdyb3RlOg0KPiA+ID4gPiA+ID4gSGksDQo+ID4gPiA+ID4gPiB3ZSBoYXZl
IGZpbGVzeXN0ZW0gbGlrZSB0aGlzDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IE92ZXJhbGw6
DQo+ID4gPiA+ID4gPiDCoMKgwqDCoMKgwqAgRGV2aWNlIHNpemU6wqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAzMC4wMFRpQg0KPiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKgIERldmlj
ZSBhbGxvY2F0ZWQ6wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDI0LjkzVGlCDQo+ID4gPiA+ID4g
PiDCoMKgwqDCoMKgwqAgRGV2aWNlIHVuYWxsb2NhdGVkOsKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
NS4wN1RpQg0KPiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKgIERldmljZSBtaXNzaW5nOsKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMC4wMEINCj4gPiA+ID4gPiA+IMKgwqDCoMKgwqDC
oCBVc2VkOsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAy
NC45MlRpQg0KPiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKgIEZyZWUgKGVzdGltYXRlZCk6wqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgNS4wN1RpQsKgwqDCoMKgwqAgKG1pbjoNCj4gPiA+ID4gPiA+
IDIuNTRUaUIpDQo+ID4gPiA+ID4gPiDCoMKgwqDCoMKgwqAgRGF0YSByYXRpbzrCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAxLjAwDQo+ID4gPiA+ID4gPiDCoMKg
wqDCoMKgwqAgTWV0YWRhdGEgcmF0aW86wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIDEuMDANCj4gPiA+ID4gPiA+IMKgwqDCoMKgwqDCoCBHbG9iYWwgcmVzZXJ2ZTrCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCA1MTIuMDBNaULCoMKgwqDCoMKgICh1c2VkOg0KPiA+ID4gPiA+
ID4gMC4wMEIpDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IERhdGEsc2luZ2xlOiBTaXplOjI0
Ljg1VGlCLCBVc2VkOjI0Ljg0VGlCICg5OS45OCUpDQo+ID4gPiA+ID4gPiDCoMKgwqDCoMKgIC9k
ZXYvc2RjwqDCoMKgwqDCoMKgIDI0Ljg1VGlCDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IE1l
dGFkYXRhLHNpbmdsZTogU2l6ZTo4OC4wMEdpQiwgVXNlZDo4MS41NEdpQiAoOTIuNjUlKQ0KPiA+
ID4gPiA+ID4gwqDCoMKgwqDCoCAvZGV2L3NkY8KgwqDCoMKgwqDCoCA4OC4wMEdpQg0KPiA+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gPiBTeXN0ZW0sRFVQOiBTaXplOjMyLjAwTWlCLCBVc2VkOjMuMjVN
aUIgKDEwLjE2JSkNCj4gPiA+ID4gPiA+IMKgwqDCoMKgwqAgL2Rldi9zZGPCoMKgwqDCoMKgwqAg
NjQuMDBNaUINCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gVW5hbGxvY2F0ZWQ6DQo+ID4gPiA+
ID4gPiDCoMKgwqDCoMKgIC9kZXYvc2RjwqDCoMKgwqDCoMKgwqAgNS4wN1RpQg0KPiA+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IElzIGl0IG5vcm1hbCB0byBoYXZlIHNvIG11
Y2ggbWV0YWRhdGE/IFdlIGhhdmUgb25seSAxMTkNCj4gPiA+ID4gPiA+IGZpbGVzDQo+ID4gPiA+
ID4gPiB3aXRoDQo+ID4gPiA+ID4gPiBzaXplDQo+ID4gPiA+ID4gPiBvZiAyMDQ4IGJ5dGVzIG9y
IGxlc3MuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gVGhhdCB3b3VsZCBvbmx5IHRha2UgYXJvdW5k
IDUwS2lCIHNvIG5vIHByb2JsZW0uDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBUaGVyZSBpcyA4
ODUgZmlsZXMgaW4gdG90YWwgYW5kIDE3IGRpcmVjdG9yaWVzLCB3ZSBkb24ndA0KPiA+ID4gPiA+
ID4gdXNlDQo+ID4gPiA+ID4gPiBzbmFwc2hvdHMuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gVGhl
IG90aGVyIGZpbGVzIHJlYWxseSBkZXBlbmRzLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IERvIHlv
dSB1c2UgY29tcHJlc3Npb24sIGlmIHNvIG1ldGFkYXRhIHVzYWdlIHdpbGwgYmUgZ3JlYXRlbHkN
Cj4gPiA+ID4gPiBpbmNyZWFzZWQuDQo+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gWWVzLCB3
ZSB1c2UgenN0ZCBjb21wcmVzc2lvbiAtIGZpbGVzeXN0ZW0gaXMgbW91bnRlZCB3aXRoDQo+ID4g
PiA+IGNvbXByZXNzLQ0KPiA+ID4gPiBmb3JjZT16c3RkOjkNCj4gPiA+ID4gDQo+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gRm9yIG5vbi1jb21wcmVzc2VkIGZpbGVzLCB0aGUgbWF4IGZpbGUgZXh0ZW50
IHNpemUgaXMgMTI4TSwNCj4gPiA+ID4gPiB3aGlsZQ0KPiA+ID4gPiA+IGZvcg0KPiA+ID4gPiA+
IGNvbXByZXNzZWQgZmlsZXMsIHRoZSBtYXggZmlsZSBleHRlbnQgc2l6ZSBpcyBvbmx5IDEyOEsu
DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gVGhpcyBtZWFucywgZm9yIGEgM1RpQiBmaWxlLCBpZiB5
b3UgaGF2ZSBjb21wcmVzcyBlbmFibGVkLCBpdA0KPiA+ID4gPiA+IHdpbGwNCj4gPiA+ID4gPiB0
YWtlDQo+ID4gPiA+ID4gMjRNIGZpbGUgZXh0ZW50cywgYW5kIHNpbmNlIGVhY2ggZmlsZSBleHRl
bnQgdGFrZXMgYXQgbGVhc3QNCj4gPiA+ID4gPiA1Mw0KPiA+ID4gPiA+IGJ5dGVzDQo+ID4gPiA+
ID4gZm9yDQo+ID4gPiA+IA0KPiA+ID4gPiBUaGF0IGlzIGxvdCBvZiBleHRlbnRzIDspDQo+ID4g
PiA+IA0KPiA+ID4gPiA+IG1ldGFkYXRhLCBvbmUgc3VjaCAzVGlCIGZpbGUgY2FuIGFscmVhZHkg
dGFrZSBvdmVyIDEgR2lCIGZvcg0KPiA+ID4gPiA+IG1ldGFkYXRhLg0KPiA+ID4gPiANCj4gPiA+
ID4gSSBndWVzcyB0aGVyZSBpcyBubyB3YXkgdG8gaW5jcmVhc2UgZXh0ZW50IHNpemU/DQo+ID4g
PiANCj4gPiA+IEN1cnJlbnRseSBpdCdzIGhhcmQgY29kZWQuIFNvIG5vIHdheSB0byBjaGFuZ2Ug
dGhhdCB5ZXQuDQo+ID4gPiANCj4gPiA+IEJ1dCBwbGVhc2Uga2VlcCBpbiBtaW5kIHRoYXQsIGJ0
cmZzIGNvbXByZXNzaW9uIG5lZWRzIHRvIGRvDQo+ID4gPiB0cmFkZS1vZmYNCj4gPiA+IGJldHdl
ZW4gd3JpdGVzLCBhbmQgdGhlIGRlY29tcHJlc3NlZCBzaXplLg0KPiA+ID4gDQo+ID4gPiBFLmcu
IGlmIHdlIGNhbiBoYXZlIGFuIDFNaUIgY29tcHJlc3NlZCBleHRlbnQsIGJ1dCBpZiAxMDIwS2lC
IGFyZQ0KPiA+ID4gb3ZlcndyaXR0ZW4sIGp1c3Qgb25lIDRLaUIgaXMgcmVhbGx5IHJlZmVycmVk
LCB0aGVuIHRvIHJlYWQgdGhhdA0KPiA+ID4gNEtpQg0KPiA+ID4gd2UNCj4gPiA+IG5lZWQgdG8g
ZGVjb21wcmVzcyBhbGwgdGhhdCAxTWlCIGp1c3QgdG8gcmVhZCB0aGF0IDRLaUIuDQo+ID4gDQo+
ID4gWWVzLCBpIGdldCByZWFzb24gZm9yIHRoaXMuDQo+ID4gSSBqdXN0IG5ldmVyIHJlYWxpc2Vk
IHRoZSBkaWZmZXJlbmNlIGluIGV4dGVudCBzaXplIGFuZCBpdCdzIGltcGFjdA0KPiA+IG9uDQo+
ID4gbWV0YWRhdGEgc2l6ZS9udW1iZXIgb2YgZXh0ZW50cy4NCj4gPiANCj4gPiA+IFNvIHBlcnNv
bmFsbHkgc3BlYWtpbmcsIGlmIHRoZSBtYWluIHB1cnBvc2Ugb2YgdGhvc2UgbGFyZ2UgZmlsZXMN
Cj4gPiA+IGFyZQ0KPiA+ID4ganVzdCB0byBhcmNoaXZlLCBub3QgdG8gZG8gZnJlcXVlbnQgd3Jp
dGUgb24sIHRoZW4gdXNlciBzcGFjZQ0KPiA+ID4gY29tcHJlc3Npb24gd291bGQgbWFrZSBtb3Jl
IHNlbnNlLg0KPiA+IA0KPiA+IE9rLCB0aGVzZSBmaWxlcyBhcmUgd3JpdGVuIG9uY2UgYW5kIGRl
bGV0ZWQgYWZ0ZXIgMTQgZGF5cyAoZXZlcnkgMTQNCj4gPiBkYXlzLCBuZXcgZnVsbCBiYWNrdXAg
aXMgY3JlYXRlZCBhbmQgb2xkZXN0IGZ1bGxiYWNrdXAgaXMgZGVsZXRlZC4NCj4gPiBGdWxsDQo+
ID4gYmFja3VwIGlzIGR1bXAgb2Ygd2hvbGUgZGlzayBpbWFnZSBmcm9tIHZtd2FyZSksIHVubGVz
cyBuZWVkZWQgZm9yDQo+ID4gc29tZQ0KPiA+IHJlY292ZXJ5LiBUaGVuIGl0J3MgbW91bnRlZCBh
cyBkaXNrIGltYWdlLg0KPiA+IA0KPiA+ID4gDQo+ID4gPiBUaGUgZGVmYXVsdCBidHJmcyB0ZW5k
cyB0byBsZWFuIHRvIHdyaXRlIHN1cHBvcnQuDQo+ID4gPiANCj4gPiA+ID4gV2UgY2FuIHVzZSBp
bnRlcm5hbCBjb21wcmVzc2lvbiBvZiBuYWtpdm8sIGJ1dCBub3Qgd2l0aG91dA0KPiA+ID4gPiBk
ZWxldGluZw0KPiA+ID4gPiBhbGwNCj4gPiA+ID4gc3RvcmVkIGRhdGEgYW5kIGNyZWF0aW5nIGVt
cHR5IHJlcG9zaXRvcnkuDQo+ID4gPiA+IEFsc28gd2Ugd2FudGVkIHRvIGRvIGNvbXByZXNzaW9u
IGluIGJ0cmZzLCB3ZSBob3BlZCBpdCB3aWxsDQo+ID4gPiA+IGdpdmUNCj4gPiA+ID4gbW9yZQ0K
PiA+ID4gPiBwb3dlciB0byBiZWVzZCB0byBkbyBpdCdzIHRoaW5nIChmb3IgY29tcGFyaW5nIGRh
dGEpDQo+ID4gPiANCj4gPiA+IFRoZW4gSSBndWVzcyB0aGVyZSBpcyBub3QgbXVjaCB0aGluZyB3
ZSBjYW4gaGVscCByaWdodCBub3csIGFuZA0KPiA+ID4gdGhhdA0KPiA+ID4gbWFueSBleHRlbnRz
IGFyZSBhbHNvIHNsb3dpbmcgZG93biBmaWxlIGRlbGV0aW9uIGp1c3QgYXMgeW91DQo+ID4gPiBt
ZW50aW9uZWQuDQo+ID4gDQo+ID4gU28gaSB3aWxsIGhhdmUgdG8gZXhwZXJpbWVudCwgaWYgdXNl
ciBsYW5kIGNvbXByZXNzaW9uIGFsbG93cyB1cyB0bw0KPiA+IGRvDQo+ID4gc29tZSByZWFzb25i
bGUgZGVkdXBsaWNhdGlvbiB3aXRoIGJlZXNkLg0KPiANCj4gQXMgbG9uZyBhcyB0aGUgY29tcHJl
c3Npb24gYWxnb3JpdGhtL3Rvb2wgY2FuIHJlcHJvZHVjZSB0aGUgc2FtZQ0KPiBjb21wcmVzc2Vk
IGRhdGEgZm9yIHRoZSBzYW1lIGlucHV0LCB0aGVuIGl0IHdvdWxkIGJlIGZpbmUuDQoNClRoYXQg
aSBkb24ndCBrbm93LiBJIGFzc3VtZSB0aGF0IHJhdyBkaXNrIGR1bXAgZnJvbSB2bXdhcmUgc2hv
dWxkIGJlDQp0aGUgc2FtZSBpbiBjYXNlIHRoYXQgZGF0YSB3ZXJlIG5vdCBjaGFuZ2VkIGluc2lk
ZSB2aXJ0dWFsIG1hY2hpbmUuIA0KSSBqdXN0IGRvbid0IGtub3cgaWYgZm9yIGV4YW1wbGUsIG9u
ZSBiaXQgY2hhbmdlcyBhdCAxVEIgbWFyayAob3V0IG9mDQphbGwgM1RCIG9mIGRhdGEpLCBpZiB0
aGUgcmVzdCBvZiBpbWFnZSBnZXRzIGRpZmZlcmVudCBvdXRwdXQgZnJvbQ0KY29tcHJlc3Npb24g
b3Igbm90Lg0KDQo+IA0KPiA+IEl0IG1heSBtYXliZSBzcGVlZCB1cCBiZWVzZCwgaXQgY2Fubm90
IGtlZXAgdXAgd2l0aCBkYXRhIGluZmx1eCwNCj4gPiBtYXliZQ0KPiA+IGl0J3MgKGFsc28pIGJl
Y2F1c2UgdGhlIG51bWJlciBvZiBmaWxlIGV4dGVudHMuDQo+ID4gVW5mb3J0dW5hdGVseSBpdCB3
aWxsIG1lYW4gc29tZSBzZXJpb3VzIGRhdGEganVnZ2xpbmcgaW4gcHJvZHVjdGlvbg0KPiA+IGVu
dmlyb25tZW50Lg0KPiANCj4gSSdtIHdvbmRlcmluZyBjYW4gd2UganVzdCByZW1vdW50IHRoZSBm
cyB0byByZW1vdmUgdGhlIGNvbXByZXNzPXpzdGQNCj4gbW91bnQgb3B0aW9uPw0KPiANCj4gU2lu
Y2UgY29tcHJlc3M9enN0ZCB3aWxsIG9ubHkgYWZmZWN0IG5ldyB3cml0ZXMgYW5kIHRvIHVzZXIt
c3BhY2UNCj4gY29tcHJlc3Npb24gc2hvdWxkIGJlIHRyYW5zcGFyZW50LCBkaXNhYmxpbmcgYnRy
ZnMgY29tcHJlc3Npb24gYXQgYW55DQo+IHRpbWUgcG9pbnQgc2hvdWxkIG5vdCBjYXVzZSBwcm9i
bGVtcy4NCg0KWWVhaCwgc3VyZSwgaSBjYW4gcmVtb3VudCBidHJmcyB3aXRob3V0IGNvbXByZXNz
aW9uLg0KQnV0IHRoZSBhcHAgaGFzIGNvbXByZXNzaW9uIChpdCB1c2VzIHpsaWIpIHNldHRpbmcg
aGFyZGNvZGVkIGluIGl0J3MNCmRhdGEgcmVwb3NpdG9yeSBmb3JtYXQsIHNvIGkgd2lsbCBoYXZl
IHRvIGNyZWF0ZSBlbXB0eSByZXBvc2l0b3J5IGFuZA0KbWlncmF0ZSBkYXRhIHRoZXJlIGZyb20g
YWN0aXZlIHJlcG9zaXRvcnkgKHNvIGkgd2lsbCBuZWVkIHRvIHNxdWVlemUNCnR3byBjb3BpZXMg
b2YgZGF0YSB0byB0aGUgc2FtZSBkaXNrKQ0KDQpUaGFua3MsDQpMaWJvcg0KDQo+IA0KPiBUaGFu
a3MsDQo+IFF1DQo+IA0KPiA+IA0KPiA+IFRoYW5rcywNCj4gPiBMaWJvcg0KPiA+IA0KPiA+IA0K
PiA+ID4gDQo+ID4gPiBUaGFua3MsDQo+ID4gPiBRdQ0KPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4g
PiA+IA0KPiA+ID4gPiA+IFRoYW5rcywNCj4gPiA+ID4gPiBRdQ0KPiA+ID4gPiANCj4gPiA+ID4g
V2l0aCByZWdhcmRzLCBMaWJvcg0KPiA+ID4gPiANCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4g
TW9zdCBvZiB0aGUgZmlsZXMgYXJlIG11bHRpIGdpZ2FieXRlLCBzb21lIG9mIHRoZW0gaGF2ZQ0K
PiA+ID4gPiA+ID4gYXJvdW5kDQo+ID4gPiA+ID4gPiAzVEINCj4gPiA+ID4gPiA+IC0NCj4gPiA+
ID4gPiA+IGFsbCBhcmUgc25hcHNob3RzIGZyb20gdm13YXJlIHN0b3JlZCB1c2luZyBuYWtpdm8u
DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IFdvcmtpbmcgd2l0aCBmaWxlc3lzdGVtIC0gbW9z
dGx5IGRlbGV0aW5nIGZpbGVzIHNlZW1zIHRvIGJlDQo+ID4gPiA+ID4gPiB2ZXJ5DQo+ID4gPiA+
ID4gPiBzbG93IC0NCj4gPiA+ID4gPiA+IGl0IHRvb2sgc2V2ZXJhbCBob3VycyB0byBkZWxldGUg
c25hcHNob3Qgb2Ygb25lIG1hY2hpbmUsDQo+ID4gPiA+ID4gPiB3aGljaA0KPiA+ID4gPiA+ID4g
Y29uc2lzdGVkIG9mIGZvdXIgb3IgZml2ZSBvZiB0aG9zZSAzVEIgZmlsZXMuDQo+ID4gPiA+ID4g
PiANCj4gPiA+ID4gPiA+IFdlIHJ1biBiZWVzZCBvbiB0aG9zZSBkYXRhLCBidXQgaSB0aGluaywg
dGhlcmUgd2FzIHRoaXMNCj4gPiA+ID4gPiA+IG11Y2gNCj4gPiA+ID4gPiA+IG1ldGFkYXRhDQo+
ID4gPiA+ID4gPiBldmVuIGJlZm9yZSB3ZSBzdGFydGVkIHRvIGRvIHNvLg0KPiA+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gPiBXaXRoIHJlZ2FyZHMsDQo+ID4gPiA+ID4gPiBMaWJvcg0K
