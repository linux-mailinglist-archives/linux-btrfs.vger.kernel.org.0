Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9B95A205F
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Aug 2022 07:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244657AbiHZFj7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Aug 2022 01:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241159AbiHZFj6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Aug 2022 01:39:58 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F9EE29
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Aug 2022 22:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661492396; x=1693028396;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=47BbAMOf6b0+1sBkdjrSKrnaLShkFlt1uEg5NW7U0vo=;
  b=PR0HikHfHkmWjrXUzJLn8r2Yzaeb66BhidVGjPulsCeUSulimef1cZMf
   /W8KNWXCDO8iH9K0fKQcR+bl9OIOqEfWOdGlmkz6kQS8+4gRcnevKlGSb
   4URULMvq7zuu2HNjy1fIdBo4f/Lkh9IvclOXPocP2/goPl0JM33RBohEY
   zPaOprO3mnxen1p8vqNQcVcMECJ0Bpk4I0IxwJkoeGSZq2+cfiurbT33G
   qJf7q4+715xzZg64WIUrBekviP7jQcY6jPl3Njcrf+QsCLCWGsBDTOO4D
   t5W3e/5HWbQzmcg05ML08GfMGexJwOkh02k61/gy017Q5gc3AfCUMkuia
   A==;
X-IronPort-AV: E=Sophos;i="5.93,264,1654531200"; 
   d="scan'208";a="214865370"
Received: from mail-dm6nam11lp2175.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.175])
  by ob1.hgst.iphmx.com with ESMTP; 26 Aug 2022 13:39:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YGEYI1um9n+/mQa+IlHQTCysoNsqL+AZatKrWyeIRBeG45H4vKcyQ64uCSJ9pJsxF9rdLPx1qc6FaFdr0mBRiR9eoh9GZDXH//CGWPnGk31jujCBW98QJDp8kdCNcM0mIH3Jp6iAsSDVMps6dCNqjP0AkSZbrKABqSe/aJG3KtvNx5TalDfFRehFNxa1sJ0TCdLPcTKTBFv6ktZVaWX6o5C54HqfwVfLLo9d6sHeEoMfxmIUxgCSRZ83SiMba2R35jYrZ0EbXhAf9SXm4OeQUdHISD9cGnqd+jOFWPezJ+IC8CkQO78kicW0geeeQxs2pKGZUkEFS7GtHByrIWQTAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+S4kSLT43MiSK5/+5cmDeNptXNDhz7UkuLknrybLzk=;
 b=Sh89XyZec8F3v8y+6N0w7tRXNvJgGpEuVXEfYtJOHgYqPYj2MYdlgOXtlXFfM2E8utQ9L7r0xZMnZnTv7f79Znc0aWbvyfR86ibUYLAvjaMHwDzZO9n+Vs/UMt3m6IYKWP3jAL/gmODXFy2yVXwa3Z8Nts02ix+XDYbCIbzLAW5q8AHhlrFWCOE7KUEH6JsUJ0HCQZOk6dkWWYcYeUJaKLm7Kq/eQK6UD+KGG2AlhEZhnTK8xcDPF6EHUgTL9KcU86t4g9iJhRicUW3Uo0LfR8ul7oB3vdo945n0mlzyCaclgckxdrj45mQmH9FxvMAO8aGu8KLRXex3gvKHEPoC2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+S4kSLT43MiSK5/+5cmDeNptXNDhz7UkuLknrybLzk=;
 b=QYnfPjgdL9K56lgaKK3lcI1mn+CFT7YQW+NmILszu/e/U9j7aq9thTcs0HF+j0YSDdMn0jb/90vOWhlswdlm0MRO2KoUt92djZeOJZJhzgxnf8+67+VUklkC0KetpeOVjyVHXwTnuUb2fnqrIg2M3jd51neqlP5fb9/K2StlbWw=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by MWHPR04MB0289.namprd04.prod.outlook.com (2603:10b6:300:b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Fri, 26 Aug
 2022 05:39:54 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::7412:af67:635c:c0a9]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::7412:af67:635c:c0a9%5]) with mapi id 15.20.5566.015; Fri, 26 Aug 2022
 05:39:54 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: set pseudo max append zone limit in zone
 emulation mode
Thread-Topic: [PATCH] btrfs: zoned: set pseudo max append zone limit in zone
 emulation mode
Thread-Index: AQHYuPAhpHd8y1UUSEeYOlos5wiI5K3AqqeA
Date:   Fri, 26 Aug 2022 05:39:54 +0000
Message-ID: <20220826053953.jx4yvk3eaflcn74y@naota-xeon>
References: <20220826020400.144377-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20220826020400.144377-1-shinichiro.kawasaki@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 95daab44-9b2d-4e5d-1e61-08da8725673b
x-ms-traffictypediagnostic: MWHPR04MB0289:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BR3PBvY3MNaShYUVS2chK5EMcgg5n3vOaUidgavEEBFD/fGmLe6XzIPbWKqh9PQzf5oCXcvrhE9s7IOHhr2ICMalNt3BZQG54+3lSxGEOMdu6QwfBveO9va+XxQOOLoy0XETe/99DfATQburAG5kB9yjM2ZtE6Za/FH8jJEmCuoETPA05SBvANSGwaMLux4yu5IGHkUIJMZm8cl43n6HH5E8ZrLuv53K6T6OWT4mmo5CWssUG6gGm16hRpNc77H1zqQ+WVYxQ51fJTOYt4OLEmlXesBnGE8YWQzo6e0pUgjq8mf1PIRABgdKRXUVJ5+p3MZPWlNSHqIQbVDtobIn3ZXHhx0qeg4GNNLRtwdQ88tJMc1Wx4aXb42YNi6XKdBy1ZmxUv8khHvxanEggwu1JvNBl8mlXEeJMn1brluK5ylfXxqhVH3L2io3XfBnEYLwzlLE48ASJMVHk6tlKQVTWnrdC+B9ICl9N43JgmyaaJ6q1atSphSQ21WQceNyz/HjPD5vx9cBXw3a6WpXZs9KOX+MTr1fIM7+Nzqa4OS6iwVlz98iNLDtZNYot0qcrQK43KzNbW6pgOi5H8VzeSR0EHU78vQNpUwZ49qMPoVe12W1Ap1006jpFm1/Xarxguk/Y3jIyPvvqwUTtsSBne66LIbxr+SDsMz2XL2j4G5j1jXViH8wq1LFMR3uzykIFNOu38DSZXFG7sraZIt61YFJNQ814YfWHElcl9+2Q6j4Tlb1UnFUiRioge0pYckIntUiF9nD6DDxWxmA+GVNWpOJhw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(316002)(122000001)(71200400001)(6636002)(54906003)(76116006)(38100700002)(82960400001)(33716001)(91956017)(66556008)(64756008)(66476007)(66946007)(6486002)(66446008)(38070700005)(8676002)(4326008)(8936002)(186003)(6862004)(478600001)(83380400001)(6506007)(2906002)(9686003)(41300700001)(26005)(1076003)(86362001)(5660300002)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ohUA2AD76/DDRAP3pePpR59fmAk+MSWF2dOqCUeAlxSJKbNKDyJI5YaK4Zkp?=
 =?us-ascii?Q?b8m1oN9T0ZGKtTyqYYqLX+SPUY5wzpCJO9W7qn6vx6guhpgHjXPPFs2QwrDg?=
 =?us-ascii?Q?qByqcrVRAhG737Ad783K2y852FIFheyyl0SuaKJ6u//IE2UBFGOzkFrWUJEh?=
 =?us-ascii?Q?GPAQjm2nMpL0fuVvohGmmWPWfEu+Cen8c40HtI2pMsVutblBNVhebDSpSmT4?=
 =?us-ascii?Q?JJ3xuzWsnH5jZWAgZm87m+ufxVtReyxAvoTjQTc1ZAVrq62Vs2UwsKqr6I+m?=
 =?us-ascii?Q?gmu1JkUZBdpsFLQyQV1WpXB6ByvGDzbLO7idFz9473Th99m5A52ca/Sd3nJQ?=
 =?us-ascii?Q?lQ3kkpO2HYJ9CBenHCqULga5nCWenaKLwpda3gTROT21o2ta6+bzKcH8j8Oy?=
 =?us-ascii?Q?cdxvX/9vgHEZncjkcYDYqUeg4PjP5Gzvnt2ubtx1T1+FOEqhT1r866cWSm1V?=
 =?us-ascii?Q?5RO9bDR7LG2kroTq5F59smTz4QRVyD/wzvQGLoquYZfFnM9SqoDRKS/zghzc?=
 =?us-ascii?Q?XfZpAu8lmzE3yPYl88wn96Bpb5Sr5dlwmqcwwDG2knSnjcaxH4Rd6aUthApg?=
 =?us-ascii?Q?unvfJaIDNRV/zu5rVvFqcZyUvzmGc8tsDf/S+ZwwElUHUvBEDjLrpdF+3ktA?=
 =?us-ascii?Q?QbuHTa/fNh0Y07/pw/KHCBtspNiUgHUnrUaMuaQTwAidmw5CIprQK+bBJ37P?=
 =?us-ascii?Q?xI/aZo721MdywwvyQXyvEWqS1kLz/Z13kodze6BzpmFmouy+Ycm4t13s32mJ?=
 =?us-ascii?Q?APZHQfi9LIgUnY+CXPbTiIOwL8HcJR+sU2kbNWFc8PzuKL6lo4CzzwJ7GuPy?=
 =?us-ascii?Q?tIX+71cV/AVpXpWvbn0m8/2Aec842Is/EiiCE8N+MXYmP1TyyKOFn1vkJ0RF?=
 =?us-ascii?Q?bPiI1cDegK583DdWQXBRRkzUHQXr7neeSc+1i0GwUXFMaelRAXgyVcptX7ZI?=
 =?us-ascii?Q?hN2gJth5NzPlereg8tF6k3DzQxrp11aKDHcG1cWPNC8ryt5nKbDwcE/QmakC?=
 =?us-ascii?Q?WH9+oC3Gz1GEyKTTgBUHvrNnYrtIL8dEEOnSnY8Cx9AG0tXHzzh8vKVbXyFp?=
 =?us-ascii?Q?k4gCCQadz/zq7IFuh7t28QNJ89sX5Bai4c2Fcj+887cIPMZY22HqjCu8bkqi?=
 =?us-ascii?Q?5+J2s48eNB6Au4tr7zkYKWK5cA2G8R4ntNIHM+/gLSSa4UhcF6QD7VGwDs/P?=
 =?us-ascii?Q?CURT/0Zu2IzNHO3oHKZsglwOaVD3Y8VdNWXxGwvgl0XSkOIPYgcBeYBlCH90?=
 =?us-ascii?Q?Jrtnp8ZWHd1ZkZ5/E2ULFOcUyeiCyp0a2moHOfFTGHXPFyRH8HK+oywazzMi?=
 =?us-ascii?Q?ctBCimTNqRcpQV9zNvDNSbVGxKsu08bVz2y0WPdsei9zFoAjaNht9ubfVUjS?=
 =?us-ascii?Q?HJNlRfRdIzjJ+ESNCd5VanXip/7sThCoueB++nAI9ZAWLs9sto01ucSAL/7t?=
 =?us-ascii?Q?3uQTN/JkyfEWR5xeMJn0a6JqWly6iEq8Bqlipm458NNRQVc9tieniYSIaQnL?=
 =?us-ascii?Q?pmdC3AfabqKd0PoKq2//yK8mbDoZYmL0BvEID99hUte9qwbpVdcHU1l3JiRN?=
 =?us-ascii?Q?AfyVKgsSMQ9j7JXtVjjC3RnxnYdLmhuqN4GrBkmRI138adOqwyh9CJuuG8l4?=
 =?us-ascii?Q?IA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B3CF791895BA954CB979AF11884F7AB9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95daab44-9b2d-4e5d-1e61-08da8725673b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 05:39:54.1188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5hJtZuF2PRSTfLqyYm6M2Jzat+OcTLwIejBgoBJXqD/9MmVt2oBTzljPXH1avvcoj7euyNoCYTJaaahwlj4sDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0289
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 26, 2022 at 11:04:00AM +0900, Shin'ichiro Kawasaki wrote:
> The commit 7d7672bc5d10 ("btrfs: convert count_max_extents() to use
> fs_info->max_extent_size") introduced a division by
> fs_info->max_extent_size. This max_extent_size is initialized with max
> zone append limit size of the device btrfs runs on. However, in zone
> emulation mode, the device is not zoned then its zone append limit is
> zero. This resulted in zero value of fs_info->max_extent_size and caused
> zero division error.
>=20
> Fix the error by setting non-zero pseudo value to max append zone limit
> in zone emulation mode. Set the pseudo value based on max_segments as
> suggested in the commit c2ae7b772ef4 ("btrfs: zoned: revive
> max_zone_append_bytes").
>=20
> Fixes: 7d7672bc5d10 ("btrfs: convert count_max_extents() to use fs_info->=
max_extent_size")
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>  fs/btrfs/zoned.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index b150b07ba1a7..560dd0a67536 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -421,10 +421,19 @@ int btrfs_get_dev_zone_info(struct btrfs_device *de=
vice, bool populate_cache)
>  	 * since btrfs adds the pages one by one to a bio, and btrfs cannot
>  	 * increase the metadata reservation even if it increases the number of
>  	 * extents, it is safe to stick with the limit.
> +	 *
> +	 * When zoned btrfs is in zone emulation mode, bdev is a non-zoned
> +	 * device and does not have valid max zone append size. In this case,
> +	 * use max_segments * PAGE_SIZE as the pseudo max_zone_append_size.

Using 'zoned filesystem' or 'zoned mode' is preferred to 'zoned
btrfs'. And, 'zoned btrfs is in zone emulation mode' looks a bit wordy. So,
how about this?

   With the zoned emulation, we can have non-zoned device on the zoned
   mode. In this case, we don't have a valid max zone append size. So, use
   ...

>  	 */
> -	zone_info->max_zone_append_size =3D
> -		min_t(u64, (u64)bdev_max_zone_append_sectors(bdev) << SECTOR_SHIFT,
> -		      (u64)bdev_max_segments(bdev) << PAGE_SHIFT);
> +	if (bdev_is_zoned(bdev)) {
> +		zone_info->max_zone_append_size =3D min_t(u64,
> +			(u64)bdev_max_zone_append_sectors(bdev) << SECTOR_SHIFT,
> +			(u64)bdev_max_segments(bdev) << PAGE_SHIFT);
> +	} else {
> +		zone_info->max_zone_append_size =3D
> +			bdev_max_segments(bdev) << PAGE_SHIFT;

We need to cast it to "(u64)" to keep enough bit width.

> +	}
>  	if (!IS_ALIGNED(nr_sectors, zone_sectors))
>  		zone_info->nr_zones++;
> =20
> --=20
> 2.37.2
> =
