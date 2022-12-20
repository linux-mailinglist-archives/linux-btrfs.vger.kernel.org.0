Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427AD652310
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Dec 2022 15:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbiLTOtf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Dec 2022 09:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233662AbiLTOs7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Dec 2022 09:48:59 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43651C91B;
        Tue, 20 Dec 2022 06:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1671547737; x=1703083737;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=D6URlExjKdP/KMoDEqMrS1dZxMnoSrTa57gjT/iJ/WQ=;
  b=dcLZ3OLlL+nOts74ehWWDijYImXCBzt6m8AEKhVHzjrenUQidcZHDJiD
   u0uQNDfu6fSJ28fniyxviVAku/1iYRyAH3TDBrgLkRoPnrrBE2UoEgt8I
   yRuRLcFnIQ37Pq+xmI7WxuNDYZQW2DOFn8+1GvbIXHJLSP9ai8JHczmys
   KiPxJBsbXiCB5vA8JEBmz+i+q2sMDcPIvJZ27kJCJHenI9mNsYJ4ih6w1
   e0CdCGljcR7Wfu6q86t6DqcbFsfXI4W37EqL04f89IhTKPHV+WVQPHStl
   IcQZHcm0qmlt+AJ/IYojfDPvHXVvqMsJ6VVWvkT8JCutrnY3T2xthtltf
   w==;
X-IronPort-AV: E=Sophos;i="5.96,259,1665417600"; 
   d="scan'208";a="224230366"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by ob1.hgst.iphmx.com with ESMTP; 20 Dec 2022 22:48:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fbAl7MsC0WLs1R21h8wD//b0bVUCpTz76mmi9nQCguXrEw27EHtxGcDvN8MoEXd3q6b9TclaH5cJ5xxTfzK/NTkGhUg4/bzw6iZZ/m1enJqdTlsvmSRG7DRyEjqq02OJ2bPXAzwB6Z+oyKwz0G5d95s7Y2wvXPLJtgn4xnSbb1Jry3SqgnxallfzJGxCQ4zyJYpR8uOJYXrW+qajF6DUG+rKgM5qXgw6M5DbiJk9sRt5/x84TX6NCspyt4/eKOZMZs13lein1RmOd7I8icFA4Unag1NCjraJZaERLziJHTSm/kVdlWCNBRkLWsgZr6SQZPgCsOOAP4G7JoKUiOIrgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6URlExjKdP/KMoDEqMrS1dZxMnoSrTa57gjT/iJ/WQ=;
 b=Adlcsa/Jwb7paa10MhpPk/hH4vLnWl0dplhGWSy8d37vgQ8Ih/MqIjkPcL90O2rmR80oEpnP6WhydRzxqJqYGmU+0gY9e19wu/k+gYUp14hH4aXwgTL547S3G+ZEO2meGSuW0KyT/i3DQRu5X60zolqV8Dvi3VIb6s9ainpGrF4JUkUD0tcVOL8u3OTQE4igzP973hYDqHlX3vkbpIIwUWjpaeJrUDV7FU/yRe4Kv3yOoQbNdwiPpo/JtkACkbebK4GdEEt5hNbIRzpyyfHXpvdYriHrORyMmmKyiMvH3Vv3k+OOa9/mFAV7juuhH8aj9nixNMcFP85DBIj6oBmxzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6URlExjKdP/KMoDEqMrS1dZxMnoSrTa57gjT/iJ/WQ=;
 b=flrfHstVg8IDAozN3tk/ITcxEt6pjj9AcEg1SaOIvjkPA/SCLTnZSf+D2V/UV3i2LXojsPqQzHWrHLSsXOOvR0w8+sdDGGrhLAN6GWf7O2gFzEmTdR8kd5e8sgndg6CX628sw4DIoh9F3NoQ13nlkoloGOxwo6/IuI6WU439Lys=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB4492.namprd04.prod.outlook.com (2603:10b6:5:29::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 14:48:52 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f66f:ab77:6874:af4b]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f66f:ab77:6874:af4b%9]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 14:48:51 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Zorro Lang <zlang@kernel.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH] fstests: skip btrfs/253 for zoned devices
Thread-Topic: [PATCH] fstests: skip btrfs/253 for zoned devices
Thread-Index: AQHZAyUiN2O8kxrvy0Wu9ilJJGmalK52oe0AgAAPR4CAAEzagA==
Date:   Tue, 20 Dec 2022 14:48:51 +0000
Message-ID: <2e2d5056-fe4b-1c97-8d42-baa2e48ae077@wdc.com>
References: <20221128122952.51680-1-johannes.thumshirn@wdc.com>
 <c682ddaf-44c9-ba98-933b-9e0cfdcf7bfe@wdc.com>
 <20221220101347.6fpruzp2i6yg72wy@zlang-mailbox>
In-Reply-To: <20221220101347.6fpruzp2i6yg72wy@zlang-mailbox>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB4492:EE_
x-ms-office365-filtering-correlation-id: 910f6d8d-cf27-4f27-8aef-08dae2994f82
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oYdYjMKIWnVpQq8ASFS3yU8NDtEO+uV4LtVHvDHGpGweZ8jgqgoIn1niq2Am3+PyA44NmxAt7jOYhPxWFp0qf1c6pUpLrRf3mdgQ60TWiAoHKlaGEcnoC9bp4Xptf+667ut8z3+EMlInaNs9uryjT9GrtS+JBiMWq9I9b0UJHLTbHC7zKVqH9TcaN4JAJ9l5AWUUYwZ/wpG4/BI1ZRGY0WP+Bqrrx/Z+GBVr/x8Uxyu6YJuzQdvIwhYIDbUcuIguTWggtUlehjr9pHveoPPXouWRYV4czRkCVl9Syq/M2G6zowp/pf6GYqKQvjyyLqK1zpanVT5US5BbXFk9WmpwBuaFTXwDRonafgnuSt9CYC7RDGBp993SPB9Mmk8ZOMbe1wSGSqemeWSfF2fx+uFLuoln3BjAcBFPg3wBLyIGfGibnhblqnxHkPJPBlIQtyG5oiSOgi2kSbz9+kH5wYq8DoahLcuP4evTvk6v/z0sSBQegQBwxhsrk2B84GYzVwPpxV1D1W3f/eNlErMDjW0426L80HYYALHv63qxw1GUEfRxoE7QHqJlMNVKoyhGbOGU2yaWrtxY8de++q0PAYbrobzN9Wd3ODgA6XOK9GeZDlabQWQXgl5GkgIXWzKG4Yrdz3LKAQ0aNdlbbvhsorNK3uB3ugscnhaFvx2H1Rs5xkbVxpgrUQYpdj6j+RCnxFO+RV9B8yZOGiVv4P0WeFaJ6BOWW7o3VlSarnxpiwgGAGaMZ4XommTRVNjg2MZJUBYfNznOVkVM/7sSD54VIk/llA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199015)(31686004)(82960400001)(122000001)(2906002)(38100700002)(2616005)(8936002)(91956017)(26005)(66946007)(66476007)(66556008)(66446008)(8676002)(64756008)(4326008)(186003)(71200400001)(5660300002)(38070700005)(36756003)(76116006)(6512007)(6916009)(83380400001)(316002)(478600001)(54906003)(6486002)(31696002)(86362001)(53546011)(41300700001)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wm5Ga2FXb1lOd1pHa05DQ2VaK1ZDOThRRDZjOURlKzhPL2s3aWQzc2tXbjh6?=
 =?utf-8?B?MHBVU3p3dUFDRFFEY1RxUXFSYjdBNVRNZ3RxV2E1MEJaV09mcnRaMUQzMnIr?=
 =?utf-8?B?UENNMzBrZ0Izb1NqQUt0QVdvWFQxMUdhSW1nWmUxNjJpUG05d3RMalYwNHVy?=
 =?utf-8?B?b0NjSTlHbmRic05Rcnd4OHRYY1RFTzdleVdQSWJPYTFiQzB2RmVJNVZTdTRw?=
 =?utf-8?B?WEdNV2dYRU9CcW9ORHYyMmcvTlRnNnNZYlM4NUJhaTBTQXIwbVZVTVE1WUpY?=
 =?utf-8?B?bkVIUnA2dGg5eUNsQWs2a1IxbHBETXdQbk9DREUxbE9CSGNoZ1pkQ082TEp0?=
 =?utf-8?B?WElDdEdVTGhzSmtwblJaWTBKOS9oKy9ja051YmsrNzIrSld3dnQ0Z1p1cTNx?=
 =?utf-8?B?WnlUMzRrR2JROEtKcnpockVGZk1KZ3MrejBEU09lUzFEWmZQaWg5SlppcG5n?=
 =?utf-8?B?M3g5SlpWK2t4a3FQbFNCaFZzeEJGQlloQlk5WEwxNHQ0Z3pvR0dNMmxXTFkx?=
 =?utf-8?B?bG9nZ2F6djEwN21jbFpvOUdNOHlmSllmU0RIODk0ZXlZZ1pzWDBUSUFTc2tF?=
 =?utf-8?B?UmtISHdQa3pQY0NSRHJ6TDJmU0xrWFFGdG84ZkFxZC9zenlBVmREUStzcFVk?=
 =?utf-8?B?aVI3SWkyOHE3YzRmTVhlQjRqYnFaNlNLM1plNHllM0NCdzFqZnBISXNTN0Qv?=
 =?utf-8?B?bW9xcHBvZWdLbzlTRW01a0JyUVZERDlyMzNlR2x0TkVwc1pUcGFYZjJVdElY?=
 =?utf-8?B?d2Y0NlorNFptVjJ0R2lFQkx3dTJKYXU3R2Y1a0taYW9aUVdVbkFUMEhNdGd2?=
 =?utf-8?B?MUMrT240ZzdpZ2FjOUpNNU9oR2dXVzRxb0dGZnNkTW5tSHJlcUMzK2l3ZnA1?=
 =?utf-8?B?dWd0NHNuMzVBd1ZCVTlXL2ZhMi9ZM1FPaTlPUmhhUDJSRFYvWUdXVXVFVEd3?=
 =?utf-8?B?NHJsalJaV0pGSkt2bHVOL01HcHZ4WWZYTGRzdnkxak9ad3BrNURJZzA5S3Q3?=
 =?utf-8?B?a1RTUzhiY3QxU0RjRVRkMittZ3BwK3pzcFkyYTZXQ3htaVZQNXdvYm9sVTlX?=
 =?utf-8?B?SEJ3aWhTNlM0bWorclRHdFFieEdKQXQ3TS9WODF4NjZhUWowa2FqbGJwT1BL?=
 =?utf-8?B?bUxwWC9OVDRWZFE2VDZyNW5WM3pLbzRzbWwrU25LYktxc1VYTGRCdmw1MkVm?=
 =?utf-8?B?cW04Tld6dUo1NmtUVDNtY2VzSHFHODNkWHZiK1lTMkQ4L1hmakNKR3M2dnlR?=
 =?utf-8?B?QzRaWEhSTVZGYlRnaG4xbXRDaWo3ODY0OFgyWnluOURMUjAvdUhrcnd0cWJ1?=
 =?utf-8?B?anB0b1M2WGtGdFBFVjBkUTh1Z3RHUU5kcld4SUVFaW1KL1REQk11RmJxSlZq?=
 =?utf-8?B?WVZkdDU1TW5HWGVNM3oyNWdHalpDMWgreEJOcnc1VkN3bWJHRHRpd0hzdmU5?=
 =?utf-8?B?dlVKbitSMUE1OGtGNFhJODNXVXVQWjFPZlJXUm8xTnFSOUttSmlsRUtBbFY1?=
 =?utf-8?B?QnJLbnFxdE8rU2lQWGZpSWhtM2tyTlNTRHB3YnVxYnd0b2JaUi9yc0JxajE3?=
 =?utf-8?B?aHJRcHFJemVEWmhObXRsYXRnVm9mUXhFQkpBREV2M1pyY0JJSEN2SEYwOCtD?=
 =?utf-8?B?WG5SelJad0VxeUd6T242dEFCTVduRWhrK2ZjeHh2bkVRWkFlamRFelozQkFi?=
 =?utf-8?B?UFYrb2dPSFpZVk5mZlVVbmtxTUo2V0FQdHRzT2tMUEFNcDVRMlRFdVVsSmZF?=
 =?utf-8?B?KzFWMUhJczBYdktZSTRrWGs1UW5BNG1lMlZWdzNWcDhpeWJkZlZXWTZqeUNO?=
 =?utf-8?B?QUdQQ25uRktYRHNEYTVGMHBzSHVqNXcwQUN1cU0xZWw1WWZxTWMrY2ZLSjlr?=
 =?utf-8?B?Y0Z4UkJ2SGRYSnBMaHdqdXB5dnp2RHh4T0VEVHk1cFBjMXFnWEpZT0wwZnBX?=
 =?utf-8?B?WlBmZkZjREFpR3JmcldWaElGR281ZS9GaGUzelNXNUt4TVl1THpnYVRpODl5?=
 =?utf-8?B?dFVxdWV2NU12c1JMcGxUSGdMOFNFa2Z4eDV2NTdVNjRJQ0JpUmhNeWVwVTNk?=
 =?utf-8?B?bjMwUmdRWXB5dVlhK0lBOG9KbHJSRFFKTE1TR25PMVdodTBzZFFiY2ZQS2hz?=
 =?utf-8?B?d2VVOXJ1dVFmNjZocDVSc0ZUSFVNYkUzWjFhVEZPNnBpeGJUcVNqYWFZcWw1?=
 =?utf-8?B?REE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D2306549D08884F9B91DD021569537C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 910f6d8d-cf27-4f27-8aef-08dae2994f82
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2022 14:48:51.8019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ts+ReBK92LNTyjaSlv5jXNGWdnOhOsfqKEVCYMQQZT9Ra4k5pEmpLdM4oWMaLW17j28zqCclM7AWyrJC3nXGOSm2L5TY0zSDCsdJnCAKbbY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4492
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMjAuMTIuMjIgMTE6MTQsIFpvcnJvIExhbmcgd3JvdGU6DQo+IE9uIFR1ZSwgRGVjIDIwLCAy
MDIyIGF0IDA5OjE5OjA2QU0gKzAwMDAsIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4+IE9u
IDI4LjExLjIyIDEzOjMwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6DQo+Pj4gVGhlIHRlc3Qt
Y2FzZSBidHJmcy8yNTMgdGVzdHMgYnRyZnMnIGNodW5rIHNpemUgc2V0dGluZywgd2hpY2ggaXMg
bm90DQo+Pj4gYXZhaWxhYmxlIG9uIHpvbmVkIGJ0cmZzLCBzbyB0aGUgdGVzdCB3aWxsIGFsd2F5
cyBmYWlsLg0KPj4+DQo+Pj4gU2tpcCB0aGUgdGVzdCBpbiBjYXNlIG9mIGEgem9uZWQgZGV2aWNl
Lg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50
aHVtc2hpcm5Ad2RjLmNvbT4NCj4+PiAtLS0NCj4+PiAgdGVzdHMvYnRyZnMvMjUzIHwgMSArDQo+
Pj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBh
L3Rlc3RzL2J0cmZzLzI1MyBiL3Rlc3RzL2J0cmZzLzI1Mw0KPj4+IGluZGV4IGZiYmI4MWZhZTc1
NC4uOTllYWVlMWU3Y2RlIDEwMDc1NQ0KPj4+IC0tLSBhL3Rlc3RzL2J0cmZzLzI1Mw0KPj4+ICsr
KyBiL3Rlc3RzL2J0cmZzLzI1Mw0KPj4+IEBAIC04MSw2ICs4MSw3IEBAIGFsbG9jX3NpemUoKSB7
DQo+Pj4gIF9zdXBwb3J0ZWRfZnMgYnRyZnMNCj4+PiAgX3JlcXVpcmVfdGVzdA0KPj4+ICBfcmVx
dWlyZV9zY3JhdGNoDQo+Pj4gK19yZXF1aXJlX25vbl96b25lZF9kZXZpY2UgIiR7U0NSQVRDSF9E
RVZ9Ig0KPj4+ICANCj4+PiAgIyBEZWxldGUgbG9nIGZpbGUgaWYgaXQgZXhpc3RzLg0KPj4+ICBy
bSAtZiAiJHtzZXFyZXN9LmZ1bGwiDQo+Pg0KPj4gUGluZz8NCj4gDQo+IERvIEkgbWlzdW5kZXJz
dGFuZCBzb21ldGhpbmc/IEkgdGhpbmsgdGhpcyBpc3N1ZSBoYXMgYmVlbiBmaXhlZCBsb25nIHRp
bWUNCj4gYWdvLCBieToNCj4gDQo+IGNvbW1pdCAyOTI1ZjNiN2Y3NzM4Zjg1YWFiZWY0ZThmZTAy
ZjI1N2ZjZTBiNzg2DQo+IEF1dGhvcjogTmFvaGlybyBBb3RhIDxuYW9oaXJvLmFvdGFAd2RjLmNv
bT4NCj4gRGF0ZTogICBUdWUgSnVsIDI2IDE2OjU3OjU5IDIwMjIgKzA5MDANCj4gDQo+ICAgICBi
dHJmcy8yNTM6IHNraXAgb24gem9uZWQgbW9kZSBhcyB3ZSBjYW5ub3QgY2hhbmdlIHRoZSBjaHVu
ayBzaXplDQo+IA0KPiBXaGljaCB4ZnN0ZXN0cyB2ZXJzaW9uIGRvIHlvdSB1c2U/IERvIHlvdSBz
dGlsbCBoaXQgYW55IHByb2JsZW1zPw0KDQpXaG9vcHNpZSwgbWF5YmUgaXQncyB0aW1lIGZvciBh
IHJlYmFzZS4NCg0KTXkgYmFkIHNvcnJ5Lg0KDQo=
