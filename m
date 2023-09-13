Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B90779E489
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Sep 2023 12:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239538AbjIMKF7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Sep 2023 06:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbjIMKF6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Sep 2023 06:05:58 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D856F196;
        Wed, 13 Sep 2023 03:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694599554; x=1726135554;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=46BXg1nh3lKGD1XoYMghHJHZ9HSYDw6vkIy6ZjiCceQ=;
  b=ZTzlHQAZERN2JRDgrAtOiN9mklBiVzjuXDGXqKjjFg8zBqfY+MRWs0p8
   ee8JxM3F0/IRJ046kvqF27tS/YbjgeEJsp9LB0yi20VKV1+ufMeXm6IJ9
   3D/3duCQQa7vcd4nJH+BEDYWIpyM+4/KZaUCOTsH1UezhlmizADrbP7JC
   bVdR3oG4c9LiDiH9IDeBDcugUz4evrGy+1UW1n4Qr08ftbt5rRgg2coqr
   dEiDIxVst4YyWGKWbqYl5yaB7FyZtQgqVDzp9cE704PMKpuSyeXmBDGCR
   TivFb3ShRUYDglxtqbneTyBq12Z+jZcbXbgWUz2YU6q0lEq83oWPGG6i1
   Q==;
X-CSE-ConnectionGUID: hqq2jSMuQBesMuyIvehSEg==
X-CSE-MsgGUID: EfNIOeONSOSMUdGuSIOKnA==
X-IronPort-AV: E=Sophos;i="6.02,142,1688400000"; 
   d="scan'208";a="244175597"
Received: from mail-bn8nam12lp2170.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.170])
  by ob1.hgst.iphmx.com with ESMTP; 13 Sep 2023 18:05:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irAjbqhFYgJSUu2X0UtWV6vuBCNi+0SeO1tZe+DHiuFKIOcCjl8PA0gE+kg6dYvQL8v/k83fYqOIeLZp/DhRX1cgL03FgqSWR1PeDlPmR47vgzBByUUknaFQdTlj6/sjI/4FuqHpY4inJpKYzY5xdpiQ+xEfHumYS4oJKa3djSP6Kdl+etNgOSkX60H0aSbU3tPUvKPgIyucXDo5U3FcMX8Dl06+QD4s527DfcOHpcK8MaR5clfHD6Yk0IO/v/Vlm/7E9Nk+qQsKKhFYDKvU8EcP8lo5OVctAeQeKvUoQ1LEjzmAuZ3YGGN0YwykIEHJzLY6GsZOx3W/DDPu5Bosqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46BXg1nh3lKGD1XoYMghHJHZ9HSYDw6vkIy6ZjiCceQ=;
 b=WTAY/YpDaKGvwooa7dEv83cFtHyYPGCz+v8+Qgzt0Fw+FkRPuaERfV2zHOqSaxrTXFiXZVJGIOq5I4VM3K2VZ02E5yO/KD4rZbS7WJeUrZaFEPIyOWYwhFLQIeP9nHz4t78rSBxnxPk5DATjkmq8fiYQI+QU8wHS+BgdJU+JumORKs0aaZevCb1DHKdWL6R3oeywxt7RpMCPY1v5jBa6Of0Wrk9RpFsJBwHegfWOw3sYbBYWANWH+0NxHb3K3VYuTii9nJCQDiYkHLtTQRVhjr02WtM5ZoaMOlAnCzfWBvnbYKQlU4yf+ZaEVWSyGWjPRZmF9saPS/ozOBvfkqxAtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46BXg1nh3lKGD1XoYMghHJHZ9HSYDw6vkIy6ZjiCceQ=;
 b=EbR8bKPczVgYXvGTFedu9+5zczeFvvxTVqL75+BlltNwIZq/+JRZQUYaYCYGW0wRbffkECmQPA7zBgiaQQE+meOveZoibVyPJXe+hTOWgo/eiYUBHk3pGTZlHNzwLP4v1j7LUufIdo460F9f8a6Ry3BnSccSjLF5FbGVu+i1tVA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN0PR04MB7935.namprd04.prod.outlook.com (2603:10b6:408:152::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 10:05:51 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6%4]) with mapi id 15.20.6792.019; Wed, 13 Sep 2023
 10:05:51 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        "clm@fb.com" <clm@fb.com>
CC:     "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] btrfs: Remove some unused functions
Thread-Topic: [PATCH] btrfs: Remove some unused functions
Thread-Index: AQHZ5ibih9q4qahaDkC97zQazhf24rAYh3EA
Date:   Wed, 13 Sep 2023 10:05:50 +0000
Message-ID: <4399a6f7-b1b5-4b5d-a36a-7e1719db6b57@wdc.com>
References: <20230913094327.98852-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20230913094327.98852-1-jiapeng.chong@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN0PR04MB7935:EE_
x-ms-office365-filtering-correlation-id: 593727a2-7063-4e6c-a446-08dbb4410278
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A33233LMmgprG8drOu23dL2V7hGYgFETq9Ms0GkSpdjpsOKIE9hPIXb8VHtpF09ozB3mLGrsGBvIFM/qA2kzb+ejKgtypywSpaKBBAVuv/wot8gZHSxXPJh2C1yqKT7YeYjmTdgp4FMHsIoX19RJf+lcvHMu2U0NVZ/YVC3Dfrnebc2dvLNyddIkD/q9RhGw9WdFGhlhgJ+SKAix8VBarnVKjaA0+oPP0RULj97Op/Umj8YplBK3NBE0RjHkok9aFU+UQ7HwK3fdvsMNZICZYNix20KzStbBPM4V5Xo9RQx0krIDxhK4VUKt6OKh9dwlHLVnPb2+dajSmovE/GMgO75d302oJtjRS6jwkaYOUL56+TCrE0ah4uMNvNr34e9Gx7PYuUNAYSza/IQAyZEAa452bNRsz93ucK5r9tMYyiJODnLATInGaLjAvmCKrSLzRef0djqjEaXexkwEszdzHOpFMyK/iaIAsnKklMz/yMDmpNNM5ac3/Hh3kU8ikfFiGc97C7UhRyd83g0T9lD255Gqi5sBwT6XClkMHAQ+mn6bdiqyAsVr7iMBv7O0BuByMEuFeCHPTPLMyv0toV3AbxTvzwj9DYuHYgG843v7kNn5V8MrCunMu//sKum2dNZ9uoab5HYCIx7U8J3bzlNicxD7g75+znoLSz5jMLHyEYexKm5c5j3AH+Fe5LwvMMqb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(39860400002)(366004)(346002)(1800799009)(451199024)(186009)(31686004)(122000001)(53546011)(71200400001)(6486002)(6506007)(36756003)(86362001)(31696002)(38070700005)(38100700002)(82960400001)(2616005)(26005)(4744005)(2906002)(6512007)(478600001)(83380400001)(110136005)(316002)(4326008)(91956017)(76116006)(8676002)(5660300002)(8936002)(41300700001)(54906003)(66446008)(64756008)(66946007)(66556008)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFdySGp4UVJPajd1YzI0TXZPVHV6MEZGcm1aRWtRMndZWkVQcXFodG9aYVUx?=
 =?utf-8?B?Q3N1aUczMDhRMVFGdk5ZV1dvTTF0cE5mbEZVVnMwZWJaWkxPeDNyc29jY3lF?=
 =?utf-8?B?aWZXQS9jempHaUVweGl1UGw3TEQzQ0N5TGlVWVRCN3p1YkVRdVRkU05wSTc2?=
 =?utf-8?B?QmFSajJPV1g5RE45aXhwTHRFK2J5WDY1RENzTzhna0FreVd1SHFoRVBxR0N6?=
 =?utf-8?B?TzIwYXhjK2xkSVpuMDc5TWN1K2ZlTHZsTEtSUlFtM0pFTkhScDlCVzFjcjdN?=
 =?utf-8?B?QjQ1cmVHNDkyYVArdWRoQmhDOElrYkxsclZwMDk4VUJtYkZZNjQ5TnptazRG?=
 =?utf-8?B?ZDgwdFpIVHNXSXRlWlRVYmF4S3Q1ZXV2WHNEb2dYSUlpTmp3R0xkb3BKMnoz?=
 =?utf-8?B?NUExRGQvSG43dVkvSkErd2JvUGdsQ3k3OFI5ODZvY1Q4ODRiN3FQYXNTVldP?=
 =?utf-8?B?em00YXI2VzN1OUU3ellwWFptMlB0Q3dPUlVlNzVxUDJWQzk0cTA5T0RNL0hQ?=
 =?utf-8?B?NFVPUmUxUkZKcGh0aU1KNkRsZVFHUk9kOE9QYUtsQlVEUkJKZDM5ZWprK2dK?=
 =?utf-8?B?OVRCc1pHWWdkRVEwRUJqMEJCYVVxQ3o5blNQaWVIYUE4anBlVVhBeXZpcitQ?=
 =?utf-8?B?ODFmTTR3aVErL0J6c1ZMUGdReDJ6bWJENFdCa2J0VVBtalhVVVl3Q2JUclp1?=
 =?utf-8?B?blBabkpzQ2h0MVJlU0k0ZEtKdUdQQjFQYmwvN2ZmWm9iTm9VOUl3Z3pRUGpi?=
 =?utf-8?B?aG1sODhySVRNMzlWT1JZZFl4Ny8yZnZmWUtZWDIzMGZaUCt6alEzM3U3ZTV2?=
 =?utf-8?B?RXl2MExOWk5rOTU3Q0dna0htTFVpMVdyckMzYngwMnE1SkRUNFd6SkFRbGhY?=
 =?utf-8?B?bU9BQm5JNkg2RmpsZGVFV2cwSXFPVEFGUEFiZTRDdjNudFNpdTZySFNiUFVJ?=
 =?utf-8?B?K3NLY0pLajdCdkRYSGFraVhsQkpJQnRxbm1BQ3pFSExGS2lIdE1Sc1M4cUE4?=
 =?utf-8?B?VzhRYU5CM0RuMjA4TkpRSmQxb1dWNVZiNktxZjNJQWZXOGpISlJ4d290MlJt?=
 =?utf-8?B?cUJTd2hmUUMrSVVYcGpWVVhydFo2ZFZGaGcraTU4dmpweHVJRWNRdXQzVDI4?=
 =?utf-8?B?V1hVdnR5SHBwL3d2alZBSlFLdEJGV285bHF2aXVlbDRmUGcrQUdPMnBUdmw2?=
 =?utf-8?B?cS9HVlNqaVZPd1NJQ21LbnYxQ0hYZnh4MmtCVnJRbEZrSDQzUk5Zdks4bjJP?=
 =?utf-8?B?WjBHc3JFbWYvSkxkeEZGa0lXQXZUYjJQa3ljajBwN0dpWXpNNGVQWm1YNy9q?=
 =?utf-8?B?VEJuZWU5WktXeDhMVnh2L1RmSUJyb2o2TjEzdjVmT1dOQjR3L0JQZGxZNUlI?=
 =?utf-8?B?R3FuTXZQUmRiTzNkcGpibUw2TjRDclZWcjlnd3dwQ3FNWDUxTUIrSDA2UkJF?=
 =?utf-8?B?WHV1SGl0Q0xZZUM0dmJTZVMwWEo4OHZMNGkwVTQ3dzQ4LzJadXJNcFBLMk0x?=
 =?utf-8?B?bmpHT0FYbU1NeXFxWTJuUlZMbUJHM1NCQm9scTFxdEZhRkJrRXlTVWFuQzM5?=
 =?utf-8?B?U2tMRjcwazBXaDMwM2haY2xNYzV1Mk40c2VCMFp4ZEgrQnJNRHdXRGNGcHYz?=
 =?utf-8?B?Y0w5U3JvZkZjWncwTkxXMnpYWnJZVXZrSiswaG03OGErK3N1akUydDczMll3?=
 =?utf-8?B?RHJnN0Q2ZUN6RjNMSW9sK3p1QkhUTEU1U1R6K3ZzY0Mxd1NZZEtLM3Q4L0Vi?=
 =?utf-8?B?OFY3MDBwT09Zejc5QkRCMW5Qb3JVYjVYeDYvRW9kNFZKL0JSak9OOU5QRHl2?=
 =?utf-8?B?Q0NNVjBTSFVpWFQ1RjQ5em5yOGord2tZWFVGTCtPVkZ0SldLOXg1ZFNSMFpT?=
 =?utf-8?B?VEJSbFdBenE3OTJobk80UVhzbzhKdTgyMlE0R2VnQ1lvRlNuTGVoY3hienhR?=
 =?utf-8?B?QTdBZGhMNXNUMkRCVnYyUTdNSFJiSmFoT0RqdVhRdWlHa1hKd0J5Z3dLcWU1?=
 =?utf-8?B?S1FEbGhucmtKdlQvR1BHWTM5WmZTRGRBOEw3dDRuQVRDL1JoclhEd3htNU0r?=
 =?utf-8?B?SWJrMnc2MnM0Ry9MWmhUbE1VYmxsdXhuUm1SbmoyU3FqZzNjYTREaEY3azN3?=
 =?utf-8?B?TjZnRDV1K1NRV3g0Z3g0SFNHM3hBWFVLMUpDVys1MUNNNktua2hMT1VRa0hP?=
 =?utf-8?B?VGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <256B588A087E0644A21FE07FF8083CC1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hA9UYCVMkoq0yQWF22Oic2xOZIVszr2+IohGE0keXlw5FSIiso6s+c48db+o1gxV84MWgoKmj0uFvHLoFAA1MaXg7RPcEX/qvpsKXD/5sl10YaMGidmi2y4jfQoyobaTTSiIi9inMxgKmUDY48f1iTsIxnuAvLQD0wYoe/bUl74dTCIUjScUrwJIKwc+B/1WwS6WDqZpgrXUXo2GvI02IvtTzuRKom3mz6JFWH/acXwMnmOKolbwoX6svmi8zt8WwQqwtudhcpfEd248V0mgibB3D5JTJJwpQwPjmEPS63wyLB60BdL4aqlr0kFaALFtH6T1nCjY1bYPRA798vcjs43w4K0oRVrU+QZ8wQyOdE4ddV3PnFz3Z19d0jPjLXQYJrKRoQgS9FTBO0VUNGB0juwvCp6ApUJwYswo89ZVfu6/1+earVgK3IplK2b/39OdBaGhdBojwdruz+EM+iRPCM/7RD4vmwNAhnlKmFqqJzKi5KGYu/hG+zvHY6M3zj9oC5hiGjoNfgr1m5a1IivT5Pweoqh2Y4Pm9lnzEpchaboDAjpBZ1U/oOqpsB89Y3YjY2Gy5rG2OlH3P+/ETwBFLKeDriC5urYUNjzYMktxovR8TvwcroygxPhgSk9kNO/B6hv21NYorUIhaTXi+xJrYapkUcFdTp1SqYjaoSLq/ypLQ0zeJfvI0HmlUDbiiVaNEG6TIcS0qerGDE/2pAtVZFh+/yGBec5F4Z6j+SXAKW0lFm1aU6AC7mfj+5hGGuN7L2dbzJZGlHVvf/NQWjcvlXAR7qnbiVizsuWBXZWMWisPVIPSPVaVVBsBFPFBimQ5teh7aKFjs4tXoSI0ALA3MjVAI9wgKEfJoZaZ2MylKhgK7Ps3fHFDNzvpF4X/PtdSMJksnC2LXhdnYDJWRTbupSyOKPDTIvbxMcwk9gu8Z8A=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 593727a2-7063-4e6c-a446-08dbb4410278
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2023 10:05:51.0126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q2W0JV+Q7gXBYKQt6sKYTSBLXL17qLqv/fSK8lNpS/e8zXztiyvHfpUA0EkDNSHF7Q3utfOTAAUDc3y5iWYkZk1dwRU86yxUohb7nLIgA70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB7935
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMTMuMDkuMjMgMTE6NDQsIEppYXBlbmcgQ2hvbmcgd3JvdGU6DQo+IFRoZXNlIGZ1bmN0aW9u
cyBhcmUgZGVmaW5lZCBpbiB0aGUgcWdyb3VwLmMgZmlsZSwgYnV0IG5vdCBjYWxsZWQNCj4gZWxz
ZXdoZXJlLCBzbyBkZWxldGUgdGhlc2UgdW51c2VkIGZ1bmN0aW9ucy4NCg0KYW55d2hlcmUNCg0K
PiBmcy9idHJmcy9xZ3JvdXAuYzoxNDk6MTk6IHdhcm5pbmc6IHVudXNlZCBmdW5jdGlvbiAncWdy
b3VwX3RvX2F1eCcNCj4gZnMvYnRyZnMvcWdyb3VwLmM6MTU0OjM2OiB3YXJuaW5nOiB1bnVzZWQg
ZnVuY3Rpb24gJ3Vub2RlX2F1eF90b19xZ3JvdXAnLg0KDQpUaGUgbGFzdCB1c2VyIG9mIHRoZW0g
aXMgZ29uZSBzaW5jZToNCg0KZDg1MmE5MWE2OTZhICgiYnRyZnM6IHFncm91cDogdXNlIHFncm91
cF9pdGVyYXRvcl9uZXN0ZWQgdG8gaW4gDQpxZ3JvdXBfdXBkYXRlX3JlZmNudCgpIikNCg0KDQpS
ZXZpZXdlZC1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNv
bT4NCg0KDQo=
