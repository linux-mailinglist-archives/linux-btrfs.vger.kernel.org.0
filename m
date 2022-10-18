Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7CB602C50
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Oct 2022 15:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiJRNEt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Oct 2022 09:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiJRNEr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Oct 2022 09:04:47 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA772CE10
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Oct 2022 06:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666098285; x=1697634285;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=ba7YUVcKQqIhkQfQB9bIw8KKZsZUEesj8FV2OIWMIko9mHebLKbWmBha
   QZPXA3ryrJCz9NOJuIkaXAIt410LzVe1MZrXdgT5CcUiol1df/9j8y2q+
   gfPjFzooDv6vUzQggxLA3rmLYBok6zq3ImI9c8g/XcTWJxrfEtdyNJaHv
   rkmUDgrsJgyfEItJx2M2t9FLmwTbwHMAqVMQDKk7Ebmx3LTMZIwKCS9Vs
   +6JoBvKnOb98mbo25wj7VJzPRmnER2AZIffXkWDabur3jrlAqiEw9+lPx
   L7QaR4zrr3uhnPkzfm29gHxhftkNcK60hYH9XT8kmWr2kDDzRsj8NZtr+
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,193,1661788800"; 
   d="scan'208";a="214119844"
Received: from mail-bn8nam12lp2173.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.173])
  by ob1.hgst.iphmx.com with ESMTP; 18 Oct 2022 21:04:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DulO5HE7SMXbXkWpnoxt5JgdfR28kY7LTmFzGePJsmKn7+dwctGRC64/OEzSg7jdVY5MH4OMhWUAzgBtB7srwpbX+YXV6BMlJixLWtz/vwBkLp20ph6LlTvoh2a97qKFxgIM8G7ZpgnF95dlwHjr9wH/pXXmsWh6yeHhSenS8jFZGhoGxDe8YX4K5CeFsvuZDZd11LcDib1u+d/xUwRY2URFV7grzFPWzeG/pLFAO4kCoKtPbEubjjGzuz+aTsofdSWic1Sa5St958DUwM2mHM7L2USmO6es7IBa7XODILl2XU8roS+IeO6ceD5X51NHTyeup4ZQOoYF/qHjxPO1yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=dPCbOIy7Divyu23M5qyGvWgbBSiUeQ25o4pLUNpu6n961kATpTC4UIrHan5kLsA2vKYfGjIkQ5WqjqRmOHATIGbhYjL0RcctAJBhBEWQ/reUgk2jXxRMF/vgtD0aoYQpr6/M4kXN7z0RyuWTXzLQn9pFF5j0Z3fnCJZCRSGRU9L+KqylIw9JC7tfJL6a3yKbfla6OZeQz9isWUK6lUWk7rQHcZiq1nDgu1XfOTgOdm+v5m/PGK4Po1ijD0EFiepPGTHkX0ExXJg0jAayoRxutAcYIALl6vGYjYeWg53EOUUq4r4G/jQifHZLs7nwO0k9D5mwK2BRKkk5cTZ4PcqvQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=v0LR1MMFEfO/VlpHiNzoUrAyVeh2qQo/q/C7IuVc40a1sNYhEPWwKgCu1vTY4O47Y2dgTxELPODadQK3bJTv88+9UAuK4JQ/XgJ5U4OVsvtF/KJBgodwZ3X/eBaAQbkQr5qFir8eG2DDZzu692NXiQ0LWpYB9ZQ0rSHhDZWLtsU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL0PR04MB5155.namprd04.prod.outlook.com (2603:10b6:208:5d::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Tue, 18 Oct
 2022 13:04:40 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::34a2:dabd:a115:edff]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::34a2:dabd:a115:edff%5]) with mapi id 15.20.5723.034; Tue, 18 Oct 2022
 13:04:40 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v2 10/16] btrfs: add a BTRFS_FS_NEED_TRANS_COMMIT flag
Thread-Topic: [PATCH v2 10/16] btrfs: add a BTRFS_FS_NEED_TRANS_COMMIT flag
Thread-Index: AQHY4lwHab5OgmbM+kWEytMYWQ2kG64UH6UA
Date:   Tue, 18 Oct 2022 13:04:40 +0000
Message-ID: <9c1c745b-9b87-5362-aa63-4977fae2cf80@wdc.com>
References: <cover.1666033501.git.josef@toxicpanda.com>
 <243a33d43e7c4cf294762fff62a9dfa45c64fe6c.1666033501.git.josef@toxicpanda.com>
In-Reply-To: <243a33d43e7c4cf294762fff62a9dfa45c64fe6c.1666033501.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BL0PR04MB5155:EE_
x-ms-office365-filtering-correlation-id: 8cf8d7bd-048f-4385-2edf-08dab109519c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CDDz6q6PGvrmKRu3/B9UEyIpMLEMb6DX0pD0aaRH8ToWZPD9N56XCOu5Dkh6F7vKRUAfAk/3T1vd6jqfYeRCn2CC3wDMh2PXmKxIZ22Udm5SQaMUUXNBtCZL6i+ff8BX8o6KfnGbYyOoHKXf0w1XKgdhv9xEK8vrS4nWNV5riMag3B3rI/BDZaKJrIkn+2ip8Mv+ouvJ0Ghut3+nRexqG7IN3bKIB88J3OPKGgsXWgSHEGUV3xjU4itNS16ThmhSEWgwWlE9h0W2VWi4BnIgTvtK4o5CcsOhDfKI8y7fehg6/0avqyjvlN576bily3KpMhy71ib7S9Yw15loNuIRb618PAds70Ks/dz1l/ZQW/oiy/DaQShBQ+5uhwjtHfYdeR+nqdHx3HJ2Yo1dAu8UMbjwv0v0MW8t6vqHvyXL23NIu4ybOe883gsAwKWSIlZT+LbII+L4jvPgsws6AwpT6YTG8rDeowuue7GeEzpFIZuvMSTejL3p2uyHYK+HUG3c769HSdZD+qEMiolgs46Zm1cMu3xDrELIr2n4mSCVqte0UctV8WKFCkhEzbvg0ODzB5o4EMiYAlYLgzA6mAlbFgUM1Ue2RIVmLriGT0/wRShkwVVuX8u6X1M55BWRJzmMKSOxbIkBPcJKhJNl2AzFUuJl1HLyAoq1tNo3zIAJaCWRGcCM/c5rS+UsJO1kTONAGWluzwfOdSnKwWCEiMtp4SW7EC2Gmv3AvYtRARp7dWfhZRAp/w66VJ+suViMB0W5HuAAGEYGLlXDERLozndvAaJsaYwcK3jmJoaWevBqmB/8rfSWTkL4kt3sBAoxUyicimYcmM5DT59f6j0eWaEItA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(366004)(396003)(376002)(451199015)(19618925003)(38070700005)(82960400001)(36756003)(31696002)(86362001)(38100700002)(558084003)(122000001)(91956017)(76116006)(66556008)(66946007)(316002)(31686004)(5660300002)(66446008)(66476007)(8936002)(6486002)(64756008)(71200400001)(2906002)(186003)(2616005)(110136005)(6512007)(8676002)(26005)(4270600006)(41300700001)(6506007)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cEtpeHE4UHp1eUI1T2ZnOUlqU1dvckpyYkdWR3YwRVVwL1ViY1BuZWxuazlI?=
 =?utf-8?B?Wkk4cVJDUnliKzhFZFMwTGhQMzlFbzU1NU5vUHBrc2t0bWRFTStxV3krODh2?=
 =?utf-8?B?ejEreFNFUUJ1eUJkeXQxQnVJOTVQSyt4b3BqS0VXWlV5RHhkMTFKUzIxcjFO?=
 =?utf-8?B?TlVTK3lhVDNkOW9nbmNvVWVnWTRQenhzWjlJQXpDbHc0ZUg0S2JWK0MrVWE2?=
 =?utf-8?B?Lzdjd2x2TGh5K1lqR1N4Q0NyVkRWK25GT2pHYkloSWZGb25xTEtUdWhtTmlK?=
 =?utf-8?B?R1VYN3FFNGZrcTZEbzM0K3BZMVE5K0hRZW81VWdwSEJvcGduZjkvOUJTcVpx?=
 =?utf-8?B?RWxJZmtWWmZXYVoxS0VJOHpyQUVXRmVCU2Y2Z1ROUm9salNKOUhYc0lyV3Rt?=
 =?utf-8?B?M1kwT01xai9NckJoVVdFOEVZa3pmYlhtcllpY2JjMGJXUlJQMzFtUit3T3VM?=
 =?utf-8?B?MXQ1YVFmVDJSRXVwZzJ5aVo5MWtaVE5aMlgrWEt1cTM1Q0NpWkkyU3h6UlJE?=
 =?utf-8?B?SldDQlQvcjBtZC9mMVNXL2F2TzkrYUJuVjVPdjBXNFFtbkVYdGtlcENYUlZm?=
 =?utf-8?B?YVluYkQySS8wV3BURXZweHRwOUVsWXVObll1d3JvcUhBQm9TTkhOaWhNa1M0?=
 =?utf-8?B?SzllRjR0TmdiNkw3ZzlJaU1lcEFCdG9mRW5pVWNYU2dsZmxYZitsNk8zajZv?=
 =?utf-8?B?NEs0MVM3Q0lGeUdPQnlYUUFCOU15MlFMTzdadnFTUDlxYjlFYkJtQlM1cTQ2?=
 =?utf-8?B?NHcvMHBCNkpIRjRSVm0zcXowWnMraHRPcytSNVBLTFZhQ0I0RytGV0VoVnVn?=
 =?utf-8?B?cjZkaC9sNnpFa3hoWU5SZzhtYk5JRmZWNnRGY3F1Rkp3dUpxalovbkN0WXdT?=
 =?utf-8?B?T1FkaURQcGZjZzcrTi9Lb0haL0dJOVpFTy9QTXRvcTVwVjBJaEdnKysvbnFQ?=
 =?utf-8?B?ejJKTzk0cmMvRDBzMjdoWDdZUHI3ZHVqU1RLbW5OTEVpNUxNTGJkaytMbGtX?=
 =?utf-8?B?N29OV0xwcWh1amJjbVFSWEgzYWJHUm03ajlydFFMbHZaeUdBUjNHYTY5MVJP?=
 =?utf-8?B?YkhDY3U1dm82TzQ0MlpvYWdNcE0wZ2JQUE04VHpaZHlOcWIvQ1U3eDE0MHo5?=
 =?utf-8?B?ZDRNZklDMUVmbGMyQVMxb1JxZDgvSyt1QU9Fc1RVNndjWDlaMnV5Q0RUbHQr?=
 =?utf-8?B?QUErVUgxNEUzbGo3OHlSZjRZTHBiZVd2Q08zUVV2S3lycHhJem5FbUdRam55?=
 =?utf-8?B?cDNZOXd5TXRZdkE4LytrbERWTWJYeXlyRndXMkhSOE1CcUtKZnkzY2NFSWZs?=
 =?utf-8?B?bUozWmViOUZSZU1RWldhVkJ4RkNuZ1Jza3lqSFhXTEhuVXJCTmllSVQxenVm?=
 =?utf-8?B?Q05WNk5iM1VGbnhBanEwKzNQSXM4Wk8rUkVBRys2UjBtMmh1NmRjaFlYR2s0?=
 =?utf-8?B?dTV6a2QzOUFFaGRKUkszQy9IZS9zZWEyTTZlUHRxUUI0dmNkT2k3N1NmWDRW?=
 =?utf-8?B?Vit2RklGdGEwRE1Yai9Od0ozR3BDaEhCZUtDU2FMWWlYdWM4WnF6WGtzMWNM?=
 =?utf-8?B?VmpIV1FVRm9RZzZnNFRaS0lUQWV5LzNqRUQyY3FHYmVxZ0tzTytNb3B0dTY1?=
 =?utf-8?B?YUt3NDc0YVZCczBuOTVlNGMrcjVKa1Y2MDJ2ckgwQ3NsL2RUNEJmOHpvaXdS?=
 =?utf-8?B?K1BXSUFSTWhjMzlncGdMZE5uWTdIeXdzQlNaUTA0N0ZUeFh3RkxWbSs1Ymww?=
 =?utf-8?B?eTg3YWtYQ2tGSG11TkVUR255a3k5a3BMbnd5bm1TUXZSNlk5REhjaFN5bjZG?=
 =?utf-8?B?NUR6ZC8yYWZBUDBWd0V6VmVPWjVEbW1vb1d4cTBaOU5WQXVWZ2NKUHlkL042?=
 =?utf-8?B?MFNHVGthcEFORGVBYzNPRDhBY1lLMEVoNnQrcUdxM0J1MkxXL3c5dU5oc2lQ?=
 =?utf-8?B?L1JmZEVwYWIyRWhYSzVuNWZnM2JCN096Rm1zUWF2TEs0QXAyV0xMcktrNFBD?=
 =?utf-8?B?Wll3MGR6SWNCNVlockxlYVdRbllwS2tiRjc3U3VyVERxd0t1Vjg2UnJueERn?=
 =?utf-8?B?Q2U2MklUM1pWbnkzUFlTNTJ2U3h3em5PVm84ZlFpN0wvcEQyR0c5OGtrYU5j?=
 =?utf-8?B?S0lhaU16N0IwYlRuTlpvV043bmpjUytnWXlwMjVxTkpzMzVnUldoOU16K3dL?=
 =?utf-8?Q?okfs5GtGSegDZxAHm68b6oE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A5121C17505BB84A85B8BC63BC5150A0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf8d7bd-048f-4385-2edf-08dab109519c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 13:04:40.8202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: upvTBG653uojcsh0NjezF0AnTnNsS1Bo6/k1VpjlLovGzaput55LfGIOMMd06rng0xdMsiaKs/48doh0P3jnhO2nz1OmnFM5c0y2gxDJkhY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB5155
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
