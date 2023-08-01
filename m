Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484AD76B4DD
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Aug 2023 14:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbjHAMfe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Aug 2023 08:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233376AbjHAMfd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Aug 2023 08:35:33 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E5C1FFD
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Aug 2023 05:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690893327; x=1722429327;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=Kmu8u8MezrOx5zC782UeYTovpvAsdgHWhsrMm6qH2dWB/f6ZRjpTqKWY
   G4qAYn4TYnD0BNQA+0932hciA6GVctQr25ent4GAVhSiPwu3jZcS4NujT
   rUZyChwcYFOPrd/llND4fT5UR+Z11v83Y0MsZIyLhfs9u5Ow0vG6Xrstv
   bo7DvVDZjJ5bmrrL3RltKorviZ0JzIUAUl9UbG7n22+TR7Vde2Y6h6p66
   R6nJywiPxeQVL1rpth7gXWf89/lVDjsYGM5XWKrQ5EVjM0Tn+p2XhArYB
   KLTqflhYjBzR/ArTDX0LWx6BVWRldZJQwMaeS/XUAJuhSgDw0lkgkgUln
   g==;
X-IronPort-AV: E=Sophos;i="6.01,247,1684771200"; 
   d="scan'208";a="344885963"
Received: from mail-bn7nam10lp2109.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.109])
  by ob1.hgst.iphmx.com with ESMTP; 01 Aug 2023 20:35:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WTQ1NL+pKxWVsjyoOF0NPsyfhrUUjp24gkcj/D3y4EALcP6i1jadNn7tI038eEIPaxz9GIxwgfbB0dvjfvzQfeIflsQpcUEAuqURXi4HLxxJmkRLSjQbsVjOgvm7iaO+3XwQafPu+EFRbtrUI5aEftg7JAdTMlmJDFIvagVB4Ge7EHTKk4vMFQS+Zq7s2K3XF8dbRz69r8lSS/oakyRcvqFmhwjT+AXtWJfXPGl0Ewoy775opZkCwmT4E2CA3fco7p/P14vQfghuCz4oc2ks1qNe2xHlOfmR2Z1NGUNHrXcxkULF0/MZYPZfIVSm/jeUSfcQW4cztrGOk0akRZmcFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=g6g0SwwtrRHC4c6EEj6A+XnOMyjQMUWO+k1orEoHg0KtcpmPLgRrUGmzO/wDEaZy5ZHr+cNVEdu1Mmcj8Fx6GmnRSwE7R+DsyV3kic9il4CBNHZ0hOUxELFB975sZskOGklu7Pq7eFG9YyGRCfpWNLDuMI6EiZFU1wQ84+S0T7pOllP4VXzeqeBOlBCJL9JPCq4JBK5gg3dfoLkM7a0tzp/ycJkhX2C72U8+2HSHSpHcxiIzrKlwIzZI65NIAceCHIjRCXBGWCBoPUkxSxE0B6/qakXTJbbi5Lj9b4B2cdSmFjNrI34Z9WQt4LpRYbvHivTsJiAdpcCxCTRllagwjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=Tmegxc4uoZnsISdh1OBFPtieYcmvEPScC3Y58E9Pn08ZkXGiOr6C2OWmYCl9LC9xCQDpaDcEWRuGIxGrnISnHNwIPM6roG7S1kjGzdrYPmBWy0mSUN2zDhIMQSp6vD/yoxOxwbJYsH0kVrnwEP3XNz+Iphb7JhMtVNHsd43X9sw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN0PR04MB8173.namprd04.prod.outlook.com (2603:10b6:408:15c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 12:35:24 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::c91f:4f3e:5075:e7a8]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::c91f:4f3e:5075:e7a8%6]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 12:35:24 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     "hch@infradead.org" <hch@infradead.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>
Subject: Re: [PATCH v2 10/10] btrfs: zoned: re-enable metadata over-commit for
 zoned mode
Thread-Topic: [PATCH v2 10/10] btrfs: zoned: re-enable metadata over-commit
 for zoned mode
Thread-Index: AQHZw9Ndlp9a0G9wzkulW2O8lRWpWa/VYaIA
Date:   Tue, 1 Aug 2023 12:35:24 +0000
Message-ID: <40100f04-7c2c-dad2-8b10-f589673e0715@wdc.com>
References: <cover.1690823282.git.naohiro.aota@wdc.com>
 <be465bfae4cd5b64aa1d0e4920f61a66dc4550a8.1690823282.git.naohiro.aota@wdc.com>
In-Reply-To: <be465bfae4cd5b64aa1d0e4920f61a66dc4550a8.1690823282.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN0PR04MB8173:EE_
x-ms-office365-filtering-correlation-id: 1ee8394b-6511-4543-aced-08db928bc784
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n1zrwHj+fAODzsodCCoOaqqiWk3D+Az8/1117SXpW+xnRC5NMDJOj+wkQsVRFMSqE0Euj0hto6thyQ/YAuLZhaPYmn552myKR/f0RzjhZqA6kr0C7QxClGIJh6Nup+eeVCWr9lVxprJfPcFQPeprWEek+WPCjkJJqyn2ezGASkMo/Ul0Ph8+Z2e3CCaknJ5r32aOlFCPeWfU6ExJGA6MDVqn3jWe+I3AH3vdYhQMXweBxrKY9pYGBsBX4SSPzM0HatLxVFAIXB3C3FHaYQ2P1opgbU386hEzjw0ku0RF3laIOQkU/kPpUJvdIrSJSTV2ENO5Yf4MQ4v4PjA+/NQLPWDnxTaQXHF5OIPAq0NRrHVC6sLt9YqfxCxLhk+DCZlROdeaFJNTPdodQBxzOox8Oc2rWvNzBPrSqQ32UCjJ3uki1y4/zLrElvlIxYKa7TU6DX6i20eGLH6Sv+gTc9+qZ/X6h1AsdPIMA3oUguQL9CiCcCFqpQO0zVWXEr+50ZlpWqWuy7JL0s+BKG6c1ucyCoYCiJp739S4pE3ec6Jhsg7R7AiijHsCcuf5JfWRaNBTnuVG/g4UUiKBGXs0UP+2dK0iLvxerhBfzbY+PissQ+eRh0Dc0/Ae2aTc07azJ47wNZRrtbCInRVUmKj1gQp7VfBz0baW70LA7awxA/ijh3Yb0qarzl5VKcmzKF2DhlWZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(451199021)(38070700005)(8936002)(8676002)(31686004)(36756003)(6486002)(41300700001)(478600001)(4270600006)(2616005)(2906002)(26005)(316002)(31696002)(186003)(19618925003)(86362001)(6506007)(558084003)(76116006)(5660300002)(38100700002)(122000001)(91956017)(6512007)(54906003)(4326008)(110136005)(82960400001)(66446008)(66556008)(66476007)(64756008)(71200400001)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QmUvMTNVd1dKeG42U2x2T3JxL3JrUUQ1SGhEYWlRRExaTmNRZitoOGowM1Np?=
 =?utf-8?B?bFlWd0xjWXk3T1BKWXUyRlZZUTYzSndVcktLRXhzRFBXSmRZSEkvM3B2NVFv?=
 =?utf-8?B?STV6Y2JSMHVhSnM1VjI3RVZUdndDVkFDbjVMQlVzNWsyZnhuYU1va2h6V2Zu?=
 =?utf-8?B?Ri9iR0srdmJDeFozbUtaN2FqajJYNG42TTMvU3paWXhYTGVLY3VBS2xTSVpI?=
 =?utf-8?B?akZvUWQ2RnFoUlpwcEFmeWFoVFJwVHYrVjA4K2o3c2NwQlROWU5zd0ZUOEpJ?=
 =?utf-8?B?dmFoYldFVmhYV1IvUW5HT3Rsb0FLQ1VnMUF4MmFRbXBkYnN3MlhHOTdCNW1x?=
 =?utf-8?B?ZGxyVkl1TUZkeGJZcVBxaElpc2hBU0F2UVVkTzRyVnlJVEpvZlk0UFJTVzFk?=
 =?utf-8?B?eHgyNXZJWWx3bUE3b2loNzVGZWM0aW1EUXRkZzQyUmhuYzBqM2FvMkNxUWRM?=
 =?utf-8?B?S3pqQ0N5UXVQZ1F0RW1MMS9YMnlidDUxcXFodktIemFlTUFhdWx6VEFGZFRB?=
 =?utf-8?B?bzh5aVQxUlNRQXB2M2V1Rlg4K2RiOG9CSWpxRDM1SUVWSC9mMWI0Y0pVNHVX?=
 =?utf-8?B?WFhEUTJ6K3BpNEpFT2RhMHlQQVZ5QVQ2c0N1dDQ4R08xWFA5aXovMDl1d3VJ?=
 =?utf-8?B?aklMbjBwYkJPZlNvR1g2OEcvU2h4UUlpWlBCNTRtQ2VKcHZPTFQzVi9JajRE?=
 =?utf-8?B?eVFiM21iWUV2SlIzdTI4dysrMWRXZkNib2hwRERaUHRpdjI0dTAxK2hURlBF?=
 =?utf-8?B?M2gvRjV3YVN4UzVrcGhna1VyZ0NWUVZwNTR5dWtEOE03M0pKZ3JSNjZuaS9L?=
 =?utf-8?B?RTg4dGQyRVlvTE5KdHhXQXRDWWVoKyt1RnMwMFMxMGtzVjBKZHZtMzBBMjdH?=
 =?utf-8?B?c2t2TXNPZFdWMURsU0xVSVNIZWRSSEJadE1tR0JxcXJoYmQvZTlsM0kwYy9C?=
 =?utf-8?B?bytYejJBVURUYjlWd3g4WU5RNURPMlZSTTVYcEtobWUyZDRqbzA0SW95Z0V6?=
 =?utf-8?B?RW11VEYyUjlBcE44NDN1VElkSzVCZ2ZqdXdDZm5yRTVYYTlMT3ZwSmdwYXhW?=
 =?utf-8?B?OFhqVWVvZy91RDBpc3QrcHh5YmQwVnJab2hKT1RLcVZIcXVYdWdRM0V3QWp6?=
 =?utf-8?B?a0dWM0FadW5lSzNUVFNvd3E1N3dhL3ozVlZFTzd5dDFpb1NFdnh2UE94dzNS?=
 =?utf-8?B?Y3VwOW9XSkpSZGRyRmdjSjRYbmI5bkVzdVlMR24zL2twdDhROTFHVmIxeitr?=
 =?utf-8?B?VGtna1Q3Um01eGllYUg4NEgzRlMvR3hscnFFcTJZZ3lCVHBIenRqM0ZHMFdv?=
 =?utf-8?B?ZEZqS1UzRjlPN3d2NXJpSU1kSm5PTUxkMHBQTkRwUTdEbFF1WFJrS1M3MzBV?=
 =?utf-8?B?MjRuVHVyZGt3Q0RGVUF6dUpucStGcWl5aXFxT3N3THVQejBqYUtFTkx5OEJw?=
 =?utf-8?B?R3ZKZVl2aWZyeUNMMXZJVGd5T0VQMzlCNnlDc09YaFpyTWpoeHdvZzZ0Y1lZ?=
 =?utf-8?B?Q1ZjdVl1WGFMdERTbHFRMDlSVWk1b3BiNlpoZXk3YWJzeGU2amlpZWJsc1Zo?=
 =?utf-8?B?TDhNU09YT0FRZ1JKVDNMOVdBYjl6Q1BEeEo2VjhVdTREdHRiSU5KNzhncTlD?=
 =?utf-8?B?VzZjMzhpRnZuMmVCZXJQaWdzU0VZLzR4cVBYQjJwT0pidzQ0bjFHTWNQZi9k?=
 =?utf-8?B?WFhhblQxOEorZzMzdG13V3dpdVdUZFgxNGlGUUUvem84QXdYd3B1OU5mMGpQ?=
 =?utf-8?B?ZmlGZWgrODJ5aWdrQzUraE1lNlExQVlOQUJFZVBoK1U1Y1JrcWthMHdxbkZ4?=
 =?utf-8?B?aFdoWmFZRytuNHRQcy9tczdINmNHTzMwQXpkSGJYUkJZaEZxWExkaDZxN1Bx?=
 =?utf-8?B?clo4cktuY2hWNmtEdHpFNjdDZ0tobDcwU2xXNGx6YUZ3Wmt4djlIUlZzTXQv?=
 =?utf-8?B?WmhYSVZOVFc3eW5Zb29zdnR5S0NWcGNzeHkwdDNVcXNKdGlqejRZZDViMGNL?=
 =?utf-8?B?RFp6ZEV5REJwSnVOZkdKRXpFbFpvQVNmTTFCbXBFUVFYVXNkZkh4MTdjS0Rj?=
 =?utf-8?B?NEVZSHNzWEdWV0lLYXkyRjN2UFQvOVRQRzB3MWNSNTM5TjNOZk5SVk5IVWJD?=
 =?utf-8?B?c3RQbDFad0gxZGs1Z2UxajVxUytGdlJTWnNtbUVNMWVXSEhBRGY4V20zbGdq?=
 =?utf-8?B?d0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D2857E17B8F704FBEFCCA4928141AD6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9H/cw6dTCb9PcPboe/zEdI84nboRTwr57PYLDVy/zECqhd7HzKGp5J26aBpjlsKFFDIaVTeP44fA4D3fjDVh83j2M7CubclP5mP2syY7JV/s+Pn8rB48i6JTNCozBCPdMSU7f0//ssg77m0uWWJiIF9Bt21TRkUStFGbBzPHM0c8oa3qWzY8pz2kit5YK40g0zEMhsm+j4lQKeJeCJEyGb8DYdinDAcqiAhEaiTVVObR89tGf2v2kEZRK6Q4GVv1faX6PPeHPXAOHrWr1FFXGfmbuiB7m0NihRh1lZE8XWdTNLTiIqtwKc49AUmM0fF9CaM6dBp+S6pBtV5MEovZvvtAOf/5tt/M2WqOz3TQIO7jthv0Z5ZBa+VQdv7JnbO9o/THktYj+QxDxJynUlZBGxejmMH1uLFA2ZWJSyOjjiT3i6TMiVmn7FTS2gXTbGG7cc9KTjOfwLKCUDSG0W4xluJRsT/0atRkZMlvDtY0axfvIt8pe/StSldTpyo57KBHJfk9lHBYNG6jIYOrmXnE/h2ar22jic/dAp5zeITk4l+t7uMnVxFbRqkFfX6g9V+pf8k6YLIUevb681l8dwVK0CprvSNKjt4TnS1Is8KwpJE8oX6vYZnRa9c7gqxC2KfGQHLjMXQpsoNSrQs5mpV22AWk7dhzviEM6S0USshQ/infdcjbbLU4rkSIjznFBNsq5cRzbbFZ+xQ/ubyfYAfaUUn1FhAnMjgPwZeaGhgTmWYD4I0SH2plAy0DavP6tXuS+/3ym820ibq8+2Nupk1ID2N1TwaGm2wEtYt3qE8uQGfn/r81qes9x88RetGrTSFNgZgmCiWVUZXHxAlLNy2FXjJyd20e6T6wzBFKDz4z6CnWb0ZCDJS5piTINuDBqDyR
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ee8394b-6511-4543-aced-08db928bc784
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 12:35:24.8341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eHCCzlFH7+TKt757oNzqEFIEEn5JqnyEwFe38Sf6ucq1/isERNzulYKr0SGIK1wf0f9vneBejnq8hNDp1EenUxM2D8sckNDO4VTTmaftYR8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8173
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==
