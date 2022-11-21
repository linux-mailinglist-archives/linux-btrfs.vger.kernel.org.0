Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0819631813
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Nov 2022 02:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiKUBDi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 20 Nov 2022 20:03:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiKUBDg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 20 Nov 2022 20:03:36 -0500
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01on2078.outbound.protection.outlook.com [40.107.108.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770DB1C92E
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Nov 2022 17:03:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XhiKeIw40hNes9/TWLCFsJddN6g2vJXxd9GCm1N+S1jZKgtJOKeAIQDPaaqE6DnQ4vSn2YWs12XdbN+/rd6z6yBvANdCMMNbHMD2yC3rVWn1hLkpcvfXld2yCMWt8ehZL4OBXEalkP42bIGFFGWSdIabEbbmT1ey5mKDq1Hb3yvKMzlWK87kLHoFeJNG95ivAYhrt+Vawlvj2oufBdUfp2R6A9X4wcgQfzXMYKOcExsBLPDwb+8/CaItRHeMAYDQftWp+tt3TCcsQA8D18pYhT4jCDR1PtXVF4Uqw3iddzVuKbnRmbNvbsTWkRlrZTtaOOfnmlnGvuxrL19uCA0rmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPw0DgWeUXhOg1NOU/NpFGVBcto0DwYmxabod3st7tQ=;
 b=WAmetRozlrjU/5oj2XBBLoIc5rZU24ZVwjapYClkqNy29jPG2vII4ZrklnDNB0SrhURXFu42gIGASEQZt+9KMUQP9q6XQ6GgX2+AQKvj6lnSZUwoyEiU0o7Qw4s6eIrQODG3ax/OrW6x67ll7qmcp1cg1/A2GbwWPE61cy/08TYjjWIp/WxaaIsxjZyNdG/0SQFSom59Zos44IpAswcwTnpMUXz++eXGKwfQQmI9ZEtqJ275E42AFWIVx7LeFISncEZzjlLfccsswA0LNcPFEADauIivZiBhiBkaJy/D/UULS50V+99SI4/AfogvFuZ1Gqx0qOYIRjk2Ll7I8Y+ylg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=pauljones.id.au; dmarc=pass action=none
 header.from=pauljones.id.au; dkim=pass header.d=pauljones.id.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oakvillepondscapes.onmicrosoft.com;
 s=selector2-oakvillepondscapes-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPw0DgWeUXhOg1NOU/NpFGVBcto0DwYmxabod3st7tQ=;
 b=GOu7xCZ97tOgP0oeSZ2ayR+ApNCgsk7QMhnTgmWw69KIFY1Ho+aUW8EhWYHb40l3wrsnLpEvW3Hu0yE6S59zbRAuF6SVtXQwTcz+oo5mFNcD82LzfaELFghbGyRUzeY51Rws1LKWsLIhUDKnxrRWLcy9a4rMMtFv5IAi498aqaE=
Received: from SYCPR01MB4685.ausprd01.prod.outlook.com (2603:10c6:10:4a::22)
 by SYBPR01MB8012.ausprd01.prod.outlook.com (2603:10c6:10:1a3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 01:03:30 +0000
Received: from SYCPR01MB4685.ausprd01.prod.outlook.com
 ([fe80::d796:9d1e:56c7:9b1c]) by SYCPR01MB4685.ausprd01.prod.outlook.com
 ([fe80::d796:9d1e:56c7:9b1c%7]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 01:03:29 +0000
From:   Paul Jones <paul@pauljones.id.au>
To:     Hendrik Friedel <hendrik@friedels.name>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: RE: Re[4]: block group x has wrong amount of free space
Thread-Topic: Re[4]: block group x has wrong amount of free space
Thread-Index: AQHY/NIDzgb4G2naakmkFzkLVxvpjq5IjwFQ
Date:   Mon, 21 Nov 2022 01:03:29 +0000
Message-ID: <SYCPR01MB468562139D0709239BB2CCC39E0A9@SYCPR01MB4685.ausprd01.prod.outlook.com>
References: <em9da2c7f3-31bb-426b-89a3-51fd1dea8968@7b52163e.com>
 <em7df90458-9cac-4818-8a43-0d59e69a14fc@7b52163e.com>
 <ff2940de-babf-d83c-b9d0-1fe8d18909a9@gmx.com>
 <emca736322-38d8-49ca-9c93-083a5bbe946f@7b52163e.com>
 <bcb7a3f2-fa48-1846-e983-2e1ed771275e@gmx.com>
 <em62944e8a-0e4b-4028-ae00-383aac0608ab@7b52163e.com>
 <d7cc9778-9e97-f749-e110-d93a7045e341@gmx.com>
 <em7ed36627-a727-470e-872c-a2af32cdb18d@7b52163e.com>
 <em8aefb52c-4cdc-4cfb-ad52-1c807d8f7756@7b52163e.com>
 <emcca5c139-84cb-403b-af68-e288e31878e3@7b52163e.com>
 <c91c89b4-58e6-526a-bfb8-fb332e792cc3@gmx.com>
 <em6eb00339-18ce-4f15-8b9d-da8058301e72@7b52163e.com>
 <5fcf68ec-836a-3517-289d-bb77527468f7@gmx.com>
 <ema0c172ea-7620-4949-8f89-1504aaf516ca@7b52163e.com>
 <SYCPR01MB4685F00E2D2EB81E014D33159E099@SYCPR01MB4685.ausprd01.prod.outlook.com>
 <em53860311-b978-4908-abfd-24b5acca9c5a@7b52163e.com>
In-Reply-To: <em53860311-b978-4908-abfd-24b5acca9c5a@7b52163e.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pauljones.id.au;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYCPR01MB4685:EE_|SYBPR01MB8012:EE_
x-ms-office365-filtering-correlation-id: 7fe07671-af35-49ff-fb56-08dacb5c3419
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o0kckN0q/o/NHpehmjtJJQcZbzWzSThNuBT8vx4vhY1xafEUNZI5jvASsJ2zx+ztwk9m0iu2+yF671L/V/bPdAfqOTjimgBiEvNHV/1fwNxtQYusRK1ctcK5dRCBZeRZ9+gjA0iQ4sIFz/BDwrR6yZuTi47n2ZosEHH963wf7bO/4g39vml+9J+ufiEhkHFw+upia/2QkrRY2tfLsWau47jNt2UswjISJsJ21y1t7qV8zFFI4wAn05079qth3r2VRWejqS6Dyx834zmB+Duze+QqhP1R5uHl3LT54C2bIeo6mF2oNW8YSbq0tGVsuPbMb2N84rtinUcTwfmhW1GG7PY8jiFQUP3thBOTgPDco8I9WlmJ03iYx/21wYsIwaoEHgf4JCquiko0jXhGs3bkOv0w0vyplUf6jwTt4JZyPfduSzIvnF/QvUOcS/cz0N+CBmrvzV8b/Mua8ctJliLxBAriX5cdlBTTfoPEhRC8NOHOCN82kk48Y3MNgoxYq54MW7pjwoIwwmYOgBi9avcw5KV8fUV40K5Avm3wxQrA4jkCNdxaPDZqjTt8ehw72SNOICmyat1KSUsMRXM/vpOPxfWGIp3KiUot9qMNdDV8WMMiPZZIpKDn1tax1NHmfxVWlkxBZRxXfnfdTdJm+sfW9t8Cpn1T7F9fmF2FHoNegCHjQmnlJtx2/RV701SdVAAa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SYCPR01MB4685.ausprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(346002)(39830400003)(396003)(366004)(451199015)(86362001)(38070700005)(5660300002)(55016003)(33656002)(71200400001)(6506007)(7696005)(316002)(26005)(76116006)(9686003)(66946007)(66556008)(66476007)(64756008)(66446008)(8676002)(110136005)(53546011)(41300700001)(83380400001)(52536014)(186003)(8936002)(2906002)(478600001)(122000001)(4744005)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWVVMG82OGlpS3pTT2pENS85cG5tQmo1U09rbGFWSFZxQTFZNDFFcGlUbnNm?=
 =?utf-8?B?QStjRGJrZjRqVitZd01pVVpVOUtFT3p1akZZOThJTUdpR3l2SS8yRSttcUhu?=
 =?utf-8?B?ak13NDJaVnI3OFNzeFovTklmWmUrT1U5Ym9Oc2U2SUpoNkVzcHhsVzVOQlFr?=
 =?utf-8?B?K01EZ3ZxWUt1SlY3cEtHT1YrbHVhZ2JpMk5yc2oxOXB4WlFlQTQ3UlBtYkxX?=
 =?utf-8?B?NUhpdGJ6MVV3clpLSzg5SlFTWG1WMjZEMzB1M3ZaWjFLcG8yc1NUWThGOVB0?=
 =?utf-8?B?NTBqbVk5Snh5ekgrWHhWaHVFd0ZBVnZaRzRqQXF6VG5iTlB3bUNCYkpiZnBl?=
 =?utf-8?B?QTYyenIydDNVdTJXOC9xLzhiQWJlSFZDNExkYkNIOCtlWTFuTUlaUVl3Uzg2?=
 =?utf-8?B?dmRGc0dycVdwKzhDNXZ6bnYrUkNJSUwvNXIrS0UzQWZ2L2xXYnZrWHl1SkJO?=
 =?utf-8?B?aENpcWpjci94RGpweC9iUGk3eWR3YXhPd1A5L2FJUEFib2FseVo3NXEwZVZY?=
 =?utf-8?B?YVB3VHNJZWFyblY4cWY2bFkyUzNIOStvaHJnTWg5UFlEMGUzUnNLRXNiSkVL?=
 =?utf-8?B?eHJlUHZpcFU0djMrcVdGdzUxVXZhNDNwc0JqTEdHRDFPT1JUYi83L2wyVko5?=
 =?utf-8?B?bWp0YXlsVjN4dnlJZTNjcnE3YmVXQkhmdVlQYVBTelJrTHVkSEFjNDZiWHNn?=
 =?utf-8?B?dXRDMGRCamNqRFZMYm4wTmU0Mllpa0p5VENSQzByeXlIQ0xTZllrUUdxV08w?=
 =?utf-8?B?bisrMTBwU1VnbDR4czZ1OE1OY2E3ZWt6cEo5eFFlOS82Q1Y2SkQyc21uMjh3?=
 =?utf-8?B?a0d6a2NaYzJYM3lPSG5RRElaem55NkF5YjZ1K0NIdWpCdnBIaW9CZk90dmhP?=
 =?utf-8?B?OG04am1DYUMwT0RreGVEUC9TRmtEN2NYVVI5UXhLby9rTEE0QnlTQjBIMTc3?=
 =?utf-8?B?VVpkV3hOT0lnTVNPOHpSQ2c3Q3VOMmJhb2tScWlYWWJVMWtqclBuV0wvS2dH?=
 =?utf-8?B?OGRWSlBRSEdzTWJqNm5idDhtMUN6THlHbDl3NzVTcEM2L0VFRVBKWTV1NzFa?=
 =?utf-8?B?YktROXN2RmVPcFZrQlRpNXVwV3U3STZpZkVnRkt1ekF2bGl4bFJEUlAveDF6?=
 =?utf-8?B?MkFsRE5rOVZPeGZudFQzYlZ3NEtBaU1wdDJXeG8zdE1SdzBEV0tiTzZZRmZI?=
 =?utf-8?B?V3BVWHlIN2ROWCt1ZTBnMFhhTkVxTXc5MzVpdk81Zlg1SkROWldhS3JTWEYw?=
 =?utf-8?B?Ykd4VVAwVEZJaEpvUU5MNXRTMzBWRHVNSCtCSlpOLzdEZTJkZ1IzKzd5L0ZN?=
 =?utf-8?B?NWhRRzBtY0hQSUY1WWZrMmFxUjM5dE5QbCtxclZsSndpTDRwcnFVQ2NyUGhF?=
 =?utf-8?B?Wm5WOUVuM21peEhvbHBzOXNBZXV6L01ZaE1kcU5lcUxCbDlnZUdJNFQxaysz?=
 =?utf-8?B?Zm5XelVDRzNtU3JQdHJFdGdNTUxDdFpVZGRWWjNBbFRaRDl4UmNVaEpuVXhY?=
 =?utf-8?B?L3RlRy9hdDhUQ2NWZlJxMjBlZlVkOHZWTTJTLzdCVUFBbjkyWXZJU09pZlBl?=
 =?utf-8?B?dkJ2ZmRTbDgvTEhTZnVDYVdkZ1FtckNWS0tjUXJHK09VUjN4Zy9ZbkJSVmtE?=
 =?utf-8?B?R1pGMTFXNU8vYUxJdzBVa1VoZnZBaE1HOWV2ZkRoL3VVR0dCTjBZc3BoQk0r?=
 =?utf-8?B?L1VacERGY0sxVllaM1gwRVJiTGZLUDdOdnNxSzZMNzU2VjMvVkk3UWpnaXpu?=
 =?utf-8?B?QUY3Nmw0VTBCbS9SWDIxVWRQSEwvVGt2SG5PYnkzOExsMDcvOEwrRHlSMmVI?=
 =?utf-8?B?LzZtOGVUWEJ0YTFQMDR6R2VXUnpDN25tcVRSTk5aK0c2ZGh3UkpGdFgxbGlY?=
 =?utf-8?B?M0xSRlJpUjltK2RRUkNVNTlGTjhoRXprY2FZYjFNYTBiajE1WlJ4V1BaNEJR?=
 =?utf-8?B?ZGtESlBISnRRVlU1NlB0Yk9HZHkrV2FMU0dlSW82UHMvWHh4R3dHaUJQbzhT?=
 =?utf-8?B?SWNldmlXWHF2bXZnZW1UQlB6b3o4SUJ3eURxaERUUkZPaFllN3I2cmk2cDdR?=
 =?utf-8?B?d1NVZy90d3luV3BCTW9mNnUydEx4VzRhMmtpVXphQmU5ZE9GdzVDNUJCMU55?=
 =?utf-8?Q?/otISJ4Kk2HoM1sGb4HJc63wv?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: pauljones.id.au
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYCPR01MB4685.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fe07671-af35-49ff-fb56-08dacb5c3419
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2022 01:03:29.7425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8f216723-e13f-4cce-b84c-58d8f16a0082
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xvpDblzr5jeZ56arzrLQ1InUhjyIF3N1XTTiUyyO9VQimJ108hugHyqoMfXwn4qnsZLR53zUnRH/87LOOcIBLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYBPR01MB8012
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIZW5kcmlrIEZyaWVkZWwgPGhl
bmRyaWtAZnJpZWRlbHMubmFtZT4NCj4gU2VudDogU3VuZGF5LCAyMCBOb3ZlbWJlciAyMDIyIDEw
OjIwIFBNDQo+IFRvOiBQYXVsIEpvbmVzIDxwYXVsQHBhdWxqb25lcy5pZC5hdT47IFF1IFdlbnJ1
bw0KPiA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT47IGxpbnV4LWJ0cmZzQHZnZXIua2VybmVsLm9y
Zw0KPiBTdWJqZWN0OiBSZVs0XTogYmxvY2sgZ3JvdXAgeCBoYXMgd3JvbmcgYW1vdW50IG9mIGZy
ZWUgc3BhY2UNCj4gDQo+IEhlbGxvLA0KPiA+VGhpcyBpbmRpY2F0ZXMgeW91IGhhdmUgYSBwaHlz
aWNhbCBwcm9ibGVtIHdpdGggeW91ciBkaXNrIC0gSSB3b3VsZCB0cnkNCj4gc3dhcHBpbmcgdGhl
IGNhYmxlcy4gVHJ5IGFuZCBmaXggdGhpcyBiZWZvcmUgeW91IGRvIGFueXRoaW5nIGVsc2UuDQo+
ID4NCj4gWWVzLCBJIHRoaW5rIHNvLCB0b28gYW5kIEkgd2lsbCB3b3JrIG9uIHRoaXMuDQo+IFdo
YXQgSSBkbyBub3QgdW5kZXJzdGFuZDoNCj4gV2h5IGRvZXMgQlRSRlMgbm90IGNvcGUgd2l0aCB0
aGlzIHdpdGhvdXQgZmlsZXN5c3RlbSBlcnJvcnM/IEkgbWVhbjogSSBoYXZlDQo+IHR3byBkcml2
ZXMuIEJUUkZTIHNob3VsZCBtYXJrIHRoaXMgb25lIGJhZCBhbmQgY29udGludWUgd2l0aCB0aGUg
b3RoZXIuDQo+IA0KPiBJcyB0aGlzIGV4cGVjdGVkIGJlaGF2aW91cj8NCg0KSXQgbG9va2VkIGxp
a2Ugb25seSB0aGUgZnJlZSBzcGFjZSBjYWNoZSB3YXMgY29ycnVwdGVkLCBhbmQgdGhhdCBjYW4g
YmUgcmVidWlsdCB3aXRob3V0IGxvc2luZyBhbnkgZGF0YS4gSSBiZWxpZXZlIHRoZXJlIHdlcmUg
YSBmZXcgcHJvYmxlbXMgd2l0aCB0aGUgdjEgY2FjaGUgdGhhdCB3b3VsZCBjYXVzZSB0aGF0IG9j
Y2FzaW9uYWxseS4gSSd2ZSBwZXJzb25hbGx5IGhhZCBubyBwcm9ibGVtcyB3aXRoIHRoZSB2MiBj
YWNoZSB3aGVuIEkgYWNjaWRlbnRseSB1bnBsdWcgdGhlIHdyb25nIGRyaXZlIG9yIGJ1bXAgY2Fi
bGVzLg0KDQpQYXVsLg0K
