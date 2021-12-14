Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F23FB4742D5
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Dec 2021 13:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbhLNMob (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Dec 2021 07:44:31 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:22224 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230205AbhLNMoa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Dec 2021 07:44:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1639485869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PYM8+Q9pF4Scp4bFC0Z3kAL9sBcjWbcO9FU7rfypX5U=;
        b=MOzNy3ruMwRkNra3UFAyi3JVpVnYBNToH5R695wyDNsalUzEEunElPqr1eTpFj7JCZvMc5
        8EaOeOxCNOI8wrO6yrCnGldWR7X09x99MH3QZqKnKTkueCsn/P4CBxbN0exeMvbM24qEnq
        /gn4cwFrEXTQdiwuvKVftaxZOupZaU8=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2105.outbound.protection.outlook.com [104.47.18.105]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-31--NmDnSH2MZaLdND6D7Qmkw-1; Tue, 14 Dec 2021 13:44:28 +0100
X-MC-Unique: -NmDnSH2MZaLdND6D7Qmkw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Osu5FhayOGRoARZdRgY5TnHfY8MREFP+urplK0zlUV6htwHdUJC/R1ZGYsxrBiTiDJ21Oz5+O26q6cAv5VrTAM1lUXk4DALge++bOTspNHklFZeiT28In9Vd5tEEgkGLEswLkI7MU2t1A68qFShHg7RYwNCRE1VdORUDvIOJTasCkSAmoNoEs4QZJEpid11FesKWEObvVgba/dtAsJPyd611Qxeqz0sMxy4tXt0ivis6hmprp8hNX8HnC/rWFfkaYWCQxIimG0sP1CNLTkBD2zfML5nURc97yDuTGBIFMMNb+DQ2kMkQhZZ8XgPxI+rPuIi0/ekvXOfSPLwzv2s1KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PYM8+Q9pF4Scp4bFC0Z3kAL9sBcjWbcO9FU7rfypX5U=;
 b=XEyE0uT3LrP2MBUc5XnkQPuIFJiHkFRsRF3D8yEehmCw8rTnoyloS4zcRBX35VBNzYT37hFfsA2pKcM7tIxCenXW0ZGe85ib2Q0Bnp4Oj5xagStsX+wwAVScVr5TpiJ4OTC5uymkBkZcMQFZg8Bnm2IR8xaKW9JgwzyT9PvibPcTrYgC3obtxZ7euzfMbZIqQ/+Ry+ScFJeoC0gu9tnKw8pr0qtYGJCPRr+8bbuK1s7Kz8vJm08mlp2sR5IhXgQyfcaC/hEEcJobzksFXyo7p3x6Iocih9SZEh9mNumSctCXAm5uEhipCzaUf2Qx0qGlPOjr43RhrO2YikyC43wqzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 by DU2PR04MB8520.eurprd04.prod.outlook.com (2603:10a6:10:2d3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Tue, 14 Dec
 2021 12:44:27 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::7547:9d8a:d148:986e]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::7547:9d8a:d148:986e%5]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 12:44:26 +0000
Message-ID: <a9c3a89e-1990-7748-94d6-cbdc1f0349d2@suse.com>
Date:   Tue, 14 Dec 2021 20:44:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/3] btrfs: remove the unnecessary path parameter for
 scrub_raid56_parity()
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <20211213131054.102526-1-wqu@suse.com>
 <20211213131054.102526-2-wqu@suse.com>
In-Reply-To: <20211213131054.102526-2-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0132.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::17) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cfc879d0-5480-4837-394b-08d9beff76ae
X-MS-TrafficTypeDiagnostic: DU2PR04MB8520:EE_
X-Microsoft-Antispam-PRVS: <DU2PR04MB8520C3C4D807E180C0372D2DD6759@DU2PR04MB8520.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:883;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j29uwx4szWuoVEN/x03a/xK+t8m2+UOeUMoxlsCef0DO4aznLdAh316+0gVzOMsqKmS7IG95HHe0Oi8jm/+V7PUS19ngLDnXK/87M/ikY/KyeJXz401hNj5H3X249lVoRzQUj77SmuOfZZ+KzfGAqgwKKcu1Fmn4qIOvyhscIBFXeuj7qHP+h+DbmPNTc7Dro0KRPv1GeF6KTn8cEf12bS1sLz4/l21gGyye00w6BToHgKh5I+QjpjkkN/HzNgoklgW08Jju9KkU0iAknkZkC+8/zQOKjcEUvDVoBGu1l87pkCt+XLqkhfR6zUOiZI+WwVK1EIPz33z2jdPPUt1XtQC1ABR6cRhy32A/wG/8XfV7eUXhhkGf3Cz/IyDyzYw6a6ku1iOYJGKccMf1l9HziJDXFHy8vbXGvKL1qdC192iS6vQCtJurN/n+50rBduNbscORfmk2dr+O4ijr6eDhFtfxV6HHOmxOmw/hJiqi0kRsUN2C2oDHgHZ0erGPftbspRn51Q/z2p5zsLt9X6oqKjUYA9xDa26tkUSY8uQwMYC7LgXYsyVSI0t7srf4/JxW753sztQXVjLw6XHW1ZquoscP/aoZlP72e4DSGQDNfP/ZJekZtsav/E02NyQtS7Wcl5xfT4VSbr28/ku+L2VYPPepnmxuYKcND4A4ZrQOn5zltCZ1CMXLwG8Bq29Dy/AdeWdwnLozkdqIPyIvjRKT/S+At2ZRDD02rEjASZl2rrY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(8676002)(6666004)(6512007)(6916009)(2616005)(508600001)(83380400001)(5660300002)(36756003)(6506007)(66476007)(66946007)(2906002)(31686004)(38100700002)(66556008)(316002)(8936002)(6486002)(86362001)(53546011)(26005)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3d0aENsejEza0FQTDBIZm1XbVd1UC9SeVJWNDhOUHprTzFuMDE4T25EcGdG?=
 =?utf-8?B?dS9SbkVNRjZ2c2YvVzBsQ3VFR0NINjg0YUJPSjhBejFScDkyL01zZkdSRFdS?=
 =?utf-8?B?M293cFRCN2h4UFZOZmJYaGt2eXgyYnBudEhnWk5MZGNxVVhVNVZIS3FUOTRT?=
 =?utf-8?B?cjRLeW9ObDcxRlRKSUNKcGVscmJaU0phUDdleTNkN2hIK2tVL1UrTVozTUhS?=
 =?utf-8?B?bEdmdXJBT2RZbWx2enJ3L2tPZCtyTFIwMFh2VU9MUkQxZ01ROHU3S2JPTFRo?=
 =?utf-8?B?RDdYUUxWZ0U4ZzNOcTRxR1pXUUU5QzJvVkZ4QlpPQmExV2g1OS9BVzlKYjBV?=
 =?utf-8?B?b3pLM2diSGx2blVDUXRlLzBYV25XbGJ6NlMybm41aDdOc0J2WWRpb29ndVlD?=
 =?utf-8?B?Q1BmcytWbEFhNGUvVHQ3K3pJMlhrNnFGNjV2OEFERmZIa0R0Q1V2WGd1Vjlh?=
 =?utf-8?B?L1JEc25JOEx3akM3Z0FkQTl3V1FrRHV1TUZlUjh1V0JJRU5XWDk3SzFqdlQz?=
 =?utf-8?B?R2FSVy9WdllEWHJsNUlMRGxsTWxNeTJReHpZbnFZY0ZmVExOWEZBdTg3Umpu?=
 =?utf-8?B?WmVJTldXa3JINDdWeE50WmxXZ0FTTmhkWklFQWZkSnRlaGNlWFFSY2Z4YlAy?=
 =?utf-8?B?MDV4bjhrTHZ0Wi9OdWpVaUJHUSt2YjdaNnBrRWdaWFRJZHRUd1dyaDZLVHdY?=
 =?utf-8?B?d2YzZnNMNVkvVmJKOUZKREdJRDh5TmsxbU94MlRsZ25jdVdHRmNNNk9tTlha?=
 =?utf-8?B?dEVkNWpFN2xWTzQ5NmdxdHQ5WFRSTmlPSVhlZ0Z4dzBjU05TaldHbmRhME1h?=
 =?utf-8?B?Y2lYT29MeGxSOU02aWZnbWw2YjRkTXZMYVdxa3k4WnhVa1dlR2lxZ2l2VHcz?=
 =?utf-8?B?Q1FyZ2d0cGx0UkNKa2ZlQjgxUkJDVjdERGswM2JIdENaaWJsNmQ4QXVIOUYy?=
 =?utf-8?B?V3IyZlBxMlJWUWRYNEsveEJ1b2FPY1dpOTNXTjFHL1NsZU9nS0ZrendVVEpE?=
 =?utf-8?B?a011eGZiRWhWVnBDa1dURDczSG4zRHNCby9vRUlkVERHdU0xdkE5cUMxeXJm?=
 =?utf-8?B?cklGUWdOeU04WFY5cmZuMmFkczlLcGg3Q0htTDZQOFk5ZThNQU01S0VkTnlN?=
 =?utf-8?B?a1c3WVFIUlRhQUdwVHQ1WTVsRWRYeFVkd2FnR0FQeDJGbWRsR3dIbUdva0ZE?=
 =?utf-8?B?dithaFlnYzNtYk50SWdUelF6UnJncWI3bUZrSUwvenhlOHVZNTVjdWpiK3JW?=
 =?utf-8?B?a2FBQkxhSy9IQmFJZUFUVDJ1Z1l4Zk5OQ3M2c2s4WHQwaVIwSDNWUThjT3Fa?=
 =?utf-8?B?T1FnWWhONlY3THBZRHNxOHU1VXpVQVRpZ2VKTlQ3S0EwUkxUVG5GQlNTUS9q?=
 =?utf-8?B?eFR2cVpHNWpvTWM4U085OGk3OGJmbWV1QVh0RWtmREE1NWNDOEw0Q05SZWVh?=
 =?utf-8?B?RUEreFZRL0tidUF1V0RhcXZ2UUlzSmRQSmJRZ3hqWFdPQzdPWTk1YjNwUUkw?=
 =?utf-8?B?cjU1cktpOGNqZHdpdDdkdjFoajFTS1dKQURiaE14OENna0RhQzhwN1dqOENz?=
 =?utf-8?B?WmFyclNIVTNyZ2hYc1I4bytoZHRjRlNFUmE3cGxHRkFsV3dkeGNBMW5CNHRa?=
 =?utf-8?B?Nk8zMk14ejBKcjZWMUxkeVNRTll2aEMwWkw5aFRPcGpYZnV1T1ZrUEk2bEJW?=
 =?utf-8?B?TC9wRHFKRjdReEx6eTdVOHpuSFJWODZiS0JIVmxmUG8vMXM5eEhrSUNqTHdF?=
 =?utf-8?B?Q1R4Sm9MSkRMQjZya1cyUGRENXo5T1Q2eERuZS9LRGQzTWlzNDJndlBkZjhR?=
 =?utf-8?B?WnZya3BCUmF6aHJiR1VVSlVGWi9tRUhTOW03MlNvYlVpd0ttdVU5TVRRRDBJ?=
 =?utf-8?B?VXZQaERZTVhRa2o1a0xBb1RLV0Yvd3B1bVFWUGxycS9teWNJYmVkdG9WYWw5?=
 =?utf-8?B?bjZ4UlZ4UkgrazhHUURHalNOd1R0Y3g0dEMzT3NJakYwbTk2MkxlbzF2OXly?=
 =?utf-8?B?RUQxYzc5TStUY2FpcktqeXEvcTdtdTFLaCszRVhEWmFzcEVYc1lHTzNGa0tZ?=
 =?utf-8?B?TGlHZ0ovcWp2bDVTcGR6bWkza2Z2R1BFUWFQWWVQZFZydzFZVkxxQ1dsU0hQ?=
 =?utf-8?Q?vTX0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfc879d0-5480-4837-394b-08d9beff76ae
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 12:44:26.8890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HdEP+VFsLLPuhv8q41Hr0pAPrzNOjQgMeZ6WQ0zDC52JzPC04Lld62U3wJn5IKGM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8520
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/12/13 21:10, Qu Wenruo wrote:
> In function scrub_stripe() we allocated two btrfs_path, one @path for
> extent tree search and another @ppath for full stripe extent tree search
> for RAID56.
> 
> This is totally uncessary, as the @ppath usage is completely inside
> scrub_raid56_parity(), thus we can move the path allocation into
> scrub_raid56_parity() completely.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/scrub.c | 28 ++++++++++++++--------------
>   1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 15a123e67108..a3bd3dfd5e8b 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -2892,7 +2892,6 @@ static void scrub_parity_put(struct scrub_parity *sparity)
>   static noinline_for_stack int scrub_raid56_parity(struct scrub_ctx *sctx,
>   						  struct map_lookup *map,
>   						  struct btrfs_device *sdev,
> -						  struct btrfs_path *path,
>   						  u64 logic_start,
>   						  u64 logic_end)
>   {
> @@ -2901,6 +2900,7 @@ static noinline_for_stack int scrub_raid56_parity(struct scrub_ctx *sctx,
>   	struct btrfs_root *csum_root;
>   	struct btrfs_extent_item *extent;
>   	struct btrfs_io_context *bioc = NULL;
> +	struct btrfs_path *path;
>   	u64 flags;
>   	int ret;
>   	int slot;
> @@ -2919,6 +2919,14 @@ static noinline_for_stack int scrub_raid56_parity(struct scrub_ctx *sctx,
>   	int extent_mirror_num;
>   	int stop_loop = 0;
>   
> +	path = btrfs_alloc_path();
> +	if (!path) {
> +		spin_lock(&sctx->stat_lock);
> +		sctx->stat.malloc_errors++;
> +		spin_unlock(&sctx->stat_lock);
> +		return -ENOMEM;
> +	}
> +
>   	ASSERT(map->stripe_len <= U32_MAX);
>   	nsectors = map->stripe_len >> fs_info->sectorsize_bits;
>   	bitmap_len = scrub_calc_parity_bitmap_len(nsectors);
> @@ -2928,6 +2936,7 @@ static noinline_for_stack int scrub_raid56_parity(struct scrub_ctx *sctx,
>   		spin_lock(&sctx->stat_lock);
>   		sctx->stat.malloc_errors++;
>   		spin_unlock(&sctx->stat_lock);
> +		btrfs_free_path(path);
>   		return -ENOMEM;
>   	}
>   
> @@ -3117,7 +3126,7 @@ static noinline_for_stack int scrub_raid56_parity(struct scrub_ctx *sctx,
>   	scrub_wr_submit(sctx);
>   	mutex_unlock(&sctx->wr_lock);
>   
> -	btrfs_release_path(path);
> +	btrfs_free_path(path);
>   	return ret < 0 ? ret : 0;
>   }
>   
> @@ -3167,7 +3176,7 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
>   					   int num, u64 base, u64 length,
>   					   struct btrfs_block_group *cache)
>   {
> -	struct btrfs_path *path, *ppath;
> +	struct btrfs_path *path;
>   	struct btrfs_fs_info *fs_info = sctx->fs_info;
>   	struct btrfs_root *root;
>   	struct btrfs_root *csum_root;
> @@ -3229,12 +3238,6 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
>   	if (!path)
>   		return -ENOMEM;
>   
> -	ppath = btrfs_alloc_path();
> -	if (!ppath) {
> -		btrfs_free_path(path);
> -		return -ENOMEM;
> -	}
> -
>   	/*
>   	 * work on commit root. The related disk blocks are static as
>   	 * long as COW is applied. This means, it is save to rewrite
> @@ -3243,8 +3246,6 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
>   	path->search_commit_root = 1;
>   	path->skip_locking = 1;
>   
> -	ppath->search_commit_root = 1;
> -	ppath->skip_locking = 1;

The new path in the raid56 functions doesn't have this.

This is causing false alerts in raid56 dev-replace test cases, like 
btrfs/072.
Which reports csum mismatch for metadata.

Would fix it in next update.

Thanks,
Qu

>   	/*
>   	 * trigger the readahead for extent tree csum tree and wait for
>   	 * completion. During readahead, the scrub is officially paused
> @@ -3347,7 +3348,7 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
>   				stripe_logical += base;
>   				stripe_end = stripe_logical + increment;
>   				ret = scrub_raid56_parity(sctx, map, scrub_dev,
> -							  ppath, stripe_logical,
> +							  stripe_logical,
>   							  stripe_end);
>   				if (ret)
>   					goto out;
> @@ -3518,7 +3519,7 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
>   						stripe_end = stripe_logical +
>   								increment;
>   						ret = scrub_raid56_parity(sctx,
> -							map, scrub_dev, ppath,
> +							map, scrub_dev,
>   							stripe_logical,
>   							stripe_end);
>   						if (ret)
> @@ -3565,7 +3566,6 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
>   
>   	blk_finish_plug(&plug);
>   	btrfs_free_path(path);
> -	btrfs_free_path(ppath);
>   
>   	if (sctx->is_dev_replace && ret >= 0) {
>   		int ret2;

