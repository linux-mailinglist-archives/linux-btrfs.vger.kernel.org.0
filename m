Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C208A464D53
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Dec 2021 12:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243810AbhLALzo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Dec 2021 06:55:44 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:21383 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243133AbhLALzn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 1 Dec 2021 06:55:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1638359541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Q4HooFv11pqrWVUHIip413F+RXiUXFmwHrK/GvFa7M=;
        b=eOScaPtLXC0wVCcQLGsWMK4kZMU2xcP6MBIdpo8Uh+hCMCRVenp08tZI1pbz2sbeQz+R3M
        lKY++oOIYa5cuLrfry9AzuYqlzmLRKp0MVZnYS6bIt9xATukSKrtaFSDw/rDnbZgMyDlcj
        8Em+dJheUAG15DPQKWygB58DorDCH+o=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2058.outbound.protection.outlook.com [104.47.1.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-17-I13DmbMGPYqV2F7LT0Znrw-1; Wed, 01 Dec 2021 12:52:20 +0100
X-MC-Unique: I13DmbMGPYqV2F7LT0Znrw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIU82rOB3Rmc39W/7qusdUI43HH88NSzigUBQ1m/3KwwtFGWHVAHtzkgiu9LjpgSzkjycOpHpAx5CCV+VpzcnvwJ1SkCXMrxGwdPVbKbt5SlP+I+nsfa3UG9xa5qZTCP7MwN/0AiLgr0CURT5Eo9ZvooBj1oFR3gYn+JwibXWG7WVLksypJk+ArYsObffjzzBUcP8UqEx3DexygEoCmX2knSz8/O8/61qUPmmdW5rNb+fy5z9bnLoycr3pUkMTu9zzqZ179xh/5eV5en2MufdUT5vQ/P4ipjgLPPcUG0vw1SMwKfOCM2Wxz7cNQoicmZERYWc8w5EQ/SAgDmpl5XxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Q4HooFv11pqrWVUHIip413F+RXiUXFmwHrK/GvFa7M=;
 b=cddp8qVrwwPYA4WOLuIZVg90sE983XpzZrIuTEFCbUMFxpAaHjSn0tFT1U8a4lDP8Jl6emz5iC7VMn8nDUqvajZ0pyAwTnpLhFnruadS5qnpGm/YQtf7EvzrPBJw08Sn3AVOuPQ5TQI0wHLcUqIXwhnjftogzpjbe26pbiRZkbH5LaK9hvJV0IopAuoPsdN3rJ2RHAR907aGTUevEgEv9ICyWEPJU47/uCqXwO7iM/KIvO/sOTK2j/2TK745b5VzbOzHUl6eheMKXqMIsHtPStig7k3pG/a2GTWAtpcgNRkgOenX9ie8eYR/2t6DcBVbQO4K3o1q8ysoW3srHCqP6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 by DU2PR04MB8661.eurprd04.prod.outlook.com (2603:10a6:10:2dc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 11:52:19 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::ed16:bc50:4079:9286]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::ed16:bc50:4079:9286%9]) with mapi id 15.20.4734.023; Wed, 1 Dec 2021
 11:52:19 +0000
Message-ID: <a2320b53-8af2-575b-9589-faf1f1bb41a6@suse.com>
Date:   Wed, 1 Dec 2021 19:52:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 02/17] btrfs: save bio::bi_iter into btrfs_bio::iter
 before submitting
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com
References: <20211201051756.53742-1-wqu@suse.com>
 <20211201051756.53742-3-wqu@suse.com>
In-Reply-To: <20211201051756.53742-3-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0024.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::37) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
Received: from [0.0.0.0] (149.28.201.231) by BYAPR06CA0024.namprd06.prod.outlook.com (2603:10b6:a03:d4::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Wed, 1 Dec 2021 11:52:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bcd10129-c6d3-48d3-bd13-08d9b4c10701
X-MS-TrafficTypeDiagnostic: DU2PR04MB8661:
X-Microsoft-Antispam-PRVS: <DU2PR04MB86611D0A8DEDD06C3C939782D6689@DU2PR04MB8661.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dwjXlWY7OaAX3FjmnRDOMJyL7DCpucG331v1aOomUjcf5zg4w2py+fW9ZwY0DkglSxOr+ActtsYOWAesINSBvgqAPGOWO/oTVpb14+oe+640+4trHBP7Ep+gjMlUwqtGCs8Yv6xZz1ctVts9zL7VhVlt6zSnEDUJM2/EsOxAMRHzqMQlfXR1bB9JB5N4WBFlbxg0b7x1PSJf1athBU6Ai4rVLOtIVP6sguRJFktfTu0/jo56fl+yNtvOXLt8dRieyHag70kBXUPo1pLypzrgUSNKuUzFyU3AP7x76Q5AbOLE0RtlTVyYSV9Cgd1zvlJIN2mSN6ugTTwXJe6rhaUbWX+cZP/QDePHpYVKQoYIRhZJSy1aw7J4wSbEqAEISirOuA+QFA+JiBfC+rOAz/XVbu+Y6VSx/Xmrvd2p9oovCoXYRpJhBLqqac8Ar0sS6wctt7HpRhHJtmcBfyWfglIuXa1AQEN032OwpHh6qcy1EicOWp6K4BX0eCgRK0mkOME8FkVo3n6Dwv/eXfeLsI0QPRXEky9nNCK76UdBjF0zJN7maGLPYxOGJtP46wrSmU9vRA2d5RDBuU+8kVIoPxgsrUH6ED+R2dIx+th0TFFoB20Ty+Q/HoZNLbpXGfF3Vk58wWDOOcJ1lqXlXMAprJQC4Rt+9iVeArPLgPD7WfUQ02zdaMpVfZaFl4BV+A/rThJS2qb419JBMbgUqj9N0+AkbEuGscgItJggZsEI8JOFn8xLLdH8M2M8XmbvQf36wip3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6706004)(66556008)(26005)(2906002)(16576012)(31696002)(83380400001)(8676002)(53546011)(36756003)(5660300002)(316002)(508600001)(8936002)(86362001)(6486002)(66476007)(38100700002)(6916009)(6666004)(31686004)(956004)(66946007)(2616005)(186003)(4326008)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHBBS2xEOStJeFBMY0E1Lzc2RE5uYS8xY095T3NnZEZ4cFBobE5XRGxtUW92?=
 =?utf-8?B?cllqWGljSXZPOHlqYXhRZDE4ZWV6cWZzSUlUTUROR0YxNGw2RHpzemwyOGoy?=
 =?utf-8?B?c3RyaWE3UUE4THRBWERPZ3FLR3pnZVNtS1RuYUNHeHlFZm9vanltT0lwYTBD?=
 =?utf-8?B?WFNPMStRSjZlUkdvRnBzZVZPc3JnK01IR09UajlTdWtsL3VCeXZVYjE5Y3Zy?=
 =?utf-8?B?RFFwMC9uWDJjdEIxTmtoU1l4OGVaS1kySXlzNElYU2J3b2I2cHlOWlZtUGEx?=
 =?utf-8?B?MEpROVE3TTVmZGk0c21TWkw2RFFjaENjaTdTN3ZaVUJTNHU0cXhEMldnWE5N?=
 =?utf-8?B?WkxHUUpPYW1CeGRRaFo2a2R6YVBaSytqMFU1eWxFYWEySmxRM0lmMTAvNGV3?=
 =?utf-8?B?TzMyZDJ5SlA0N0EvU09KRHNEVHk5SkUwU09zRzJtVzF5dm5OUGNCSUtRSmtK?=
 =?utf-8?B?RllmL09xc0lOT0RsWXM5VkJja1NlRC9Jb2E2UGc0UjdnZlNHQkdHaUszRzYy?=
 =?utf-8?B?WGVIQjBiYlBMdTg0Tlk1RVhxUk5LaW45KzU0MS93L1BNd3llSnhDS1VrbVdG?=
 =?utf-8?B?NWhIQTB1UFZzcWJFNjcrZUkyclprQ05WaSs1NFg2YndwUVN6NjIvanFYWUly?=
 =?utf-8?B?NzRSbGVnSU5MUVFOZ0VIb0NzSTEvQ1ppZXdtOWg0SEYvamc3RXRvVmJjSmJ0?=
 =?utf-8?B?K1l6U0M1aUtqQmpKR3NJVy9KL2l4MmNjck5JeWF1N0VJeWQzMGUxcHNTOFgw?=
 =?utf-8?B?THVwNlFRYmIxeTJtSDJRcGVIVFVUWjhYeDVzSkxyT2FETGFBUnEyQ3YrV3Ay?=
 =?utf-8?B?NmM5WFlWTjZNVDlGb3A3NXRPUnAzaExiN2FHMUY5V0M1MXQyZUNxc1FFSHpl?=
 =?utf-8?B?VXdMeEYvRHh2Uk5SM01adWg3cXRzZm9TWnp1ZTVKa24zQjVmZ0ZmSUlzQ1VG?=
 =?utf-8?B?ZzVFcnMxeTM2TkRTWHpXeTJubTY0Z3EyS2V2cnVPdFJyYnpHSklLNUcyQ3Fj?=
 =?utf-8?B?aDc2TUZEd0JMbE53VzVNNi9uNHl0WmVDY3doVVlvWkFWUHl0d0pSOU9oM3FG?=
 =?utf-8?B?Tk5DbmVyTVpFY2xFem5DVSs1Wjkvc3daa1lycWhSQ3FZZXJJYXRIWmRLMU1U?=
 =?utf-8?B?Q0xwaS9FaU9wV3RrUW0rVFFNZ0RsVUZyNEhsbm9vMGd0alNDdDR4UkxQWnZI?=
 =?utf-8?B?OFBPMTRFbDl6dGtCZ2hnZE1jc1pVU2xOT3dnVnN2Ykp3WlJOZ0tJa21rUDk3?=
 =?utf-8?B?RUhFcXVVYXhJUkd0MFlOOUMrZm5lR2pqQWUxVmV0WTNKRUNLMEJOZ00xcm5n?=
 =?utf-8?B?YVRZdHBRN0V6My9MT3lZcUVxcHp4VjhnbXZtWHRZMzg5TkFCdkpJbjRTb2o5?=
 =?utf-8?B?RWtWWVhZRXdxdVhXQ21BRzMrdG45Y2FobFdTK0N6TndWZlZ4TEY1WnZLTWpC?=
 =?utf-8?B?UUlTQkpzaVlPU2FhTlJkZXdmdElZZ3dkRnJWSEFYaGtjMFUvQ0JmQWVjb3Y5?=
 =?utf-8?B?Y3ExckE3bHQ4TC9SOUozTTFYbzMrZ2ZYaXE2SjFzL0VqOXNuZnhxa2UwODU2?=
 =?utf-8?B?TmJPN0UybzVWRXpFS0RrbmVnbW1DMTc5aVMvcU8xMHlONmhCVm43Q2tsMUo0?=
 =?utf-8?B?elpESVJuYUpIR2VxbC9TbytwSEZNNzRlQi9oeng5S0VTSFZVNDdzMmtXQjlM?=
 =?utf-8?B?REhPR3VQa0EyMUNiNGhndDhxem5oS1pVcmtYbGhnM1kvRS9LVzBmelRyUDNn?=
 =?utf-8?B?eTZtV0hnSkcvMWVXU0VRWmVZUUhsaGZqUkszNGVBVUwxdHZxRGhPb2dRb0NL?=
 =?utf-8?B?Q1JORjdzdDJNY2xBRDV3SEpOQzA2Y25kOWVIb3REZUEwSnlJeW5wUWNpTmll?=
 =?utf-8?B?M0hMTnNuL1d2NEdlbExtaGkrOFZiZ3p1Q0NwbUtIWTZldkJTSUlBc0N5SE4r?=
 =?utf-8?B?NldBQkwwQWFlS1dzbUc5Vk1UdzBiVjM4bEtTN0w4MnFORGxkYTgwc0NiZGNh?=
 =?utf-8?B?NEhBQ240a3J6R25HekNQd2NCMGxZVmN2dU9PelVnV3Nmdk9obFZWZi9wK1pa?=
 =?utf-8?B?OGxZdEx0ejgxMVdmNWdkeHRtRkZDQ1Z2RVpGbE9yNUVpQzBiUExrZTljY05i?=
 =?utf-8?Q?tWKI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcd10129-c6d3-48d3-bd13-08d9b4c10701
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 11:52:19.1705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hGskQKR/eJSDmWmTLXbwUf75ntrWOTmPL8hvksaeYUIPL2cZ5tAETnYGNUfr8D7K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8661
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/12/1 13:17, Qu Wenruo wrote:
> Since block layer will advance bio::bi_iter, at endio time we can no
> longer rely on bio::bi_iter for split bio.
> 
> But for the incoming btrfs_bio split at btrfs_map_bio() time, we have to
> ensure endio function is only executed for the split range, not the
> whole original bio.
> 
> Thus this patch will introduce a new helper, btrfs_bio_save_iter(), to
> save bi_iter into btrfs_bio::iter.
> 
> The following call sites need this helper call:
> 
> - btrfs_submit_compressed_read()
>    For compressed read. For compressed write it doesn't really care as
>    they use ordered extent.
> 
> - raid56_parity_write()
> - raid56_parity_recovery()
>    For RAID56.
> 
> - submit_stripe_bio()
>    For all other cases.

These are not enough.

There are cases where we allocate a bio but without going through 
btrfs_map_bio(), and error out.

In that case, those bios don't have bbio::iter, and can cause errors in 
generic/475 related to data/metadata writeback failure.

Fixed in my github repo, by just adding more btrfs_bio_save_iter() calls 
in error paths.

Thanks,
Qu
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/compression.c |  3 +++
>   fs/btrfs/raid56.c      |  2 ++
>   fs/btrfs/volumes.c     | 14 ++++++++++++++
>   fs/btrfs/volumes.h     | 18 ++++++++++++++++++
>   4 files changed, 37 insertions(+)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index e776956d5bc9..cc8d13369f53 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -870,6 +870,9 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>   	/* include any pages we added in add_ra-bio_pages */
>   	cb->len = bio->bi_iter.bi_size;
>   
> +	/* Save bi_iter so that end_bio_extent_readpage() won't freak out. */
> +	btrfs_bio_save_iter(btrfs_bio(bio));
> +
>   	while (cur_disk_byte < disk_bytenr + compressed_len) {
>   		u64 offset = cur_disk_byte - disk_bytenr;
>   		unsigned int index = offset >> PAGE_SHIFT;
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index 0e239a4c3b26..13e726c88a81 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -1731,6 +1731,7 @@ int raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc,
>   		return PTR_ERR(rbio);
>   	}
>   	bio_list_add(&rbio->bio_list, bio);
> +	btrfs_bio_save_iter(btrfs_bio(bio));
>   	rbio->bio_list_bytes = bio->bi_iter.bi_size;
>   	rbio->operation = BTRFS_RBIO_WRITE;
>   
> @@ -2135,6 +2136,7 @@ int raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bioc,
>   
>   	rbio->operation = BTRFS_RBIO_READ_REBUILD;
>   	bio_list_add(&rbio->bio_list, bio);
> +	btrfs_bio_save_iter(btrfs_bio(bio));
>   	rbio->bio_list_bytes = bio->bi_iter.bi_size;
>   
>   	rbio->faila = find_logical_bio_stripe(rbio, bio);
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index f38c230111be..b70037cc1a51 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6829,6 +6829,20 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
>   		BUG();
>   	}
>   
> +	/*
> +	 * At endio time, bi_iter is no longer reliable, thus we have to save
> +	 * current bi_iter into btrfs_bio so that even for split bio we can
> +	 * iterate only the split part.
> +	 *
> +	 * And this has to be done before any bioc error, as endio functions
> +	 * will rely on bbio::iter.
> +	 *
> +	 * For bio create by btrfs_bio_slit() or btrfs_bio_clone*(), it's
> +	 * already set, but we can still have original bio which has its
> +	 * iter not initialized.
> +	 */
> +	btrfs_bio_save_iter(btrfs_bio(bio));
> +
>   	for (dev_nr = 0; dev_nr < total_devs; dev_nr++) {
>   		dev = bioc->stripes[dev_nr].dev;
>   		if (!dev || !dev->bdev || test_bit(BTRFS_DEV_STATE_MISSING,
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 3b8130680749..f9178d2c2fd6 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -334,6 +334,12 @@ struct btrfs_bio {
>   	struct btrfs_device *device;
>   	u8 *csum;
>   	u8 csum_inline[BTRFS_BIO_INLINE_CSUM_SIZE];
> +	/*
> +	 * Saved bio::bi_iter before submission.
> +	 *
> +	 * This allows us to interate the cloned/split bio properly, as at
> +	 * endio time bio::bi_iter is no longer reliable.
> +	 */
>   	struct bvec_iter iter;
>   
>   	/*
> @@ -356,6 +362,18 @@ static inline void btrfs_bio_free_csum(struct btrfs_bio *bbio)
>   	}
>   }
>   
> +/*
> + * To save bbio::bio->bi_iter into bbio::iter so for callers who need the
> + * original bi_iter can access the original part of the bio.
> + * This is especially important for the incoming split btrfs_bio, which needs
> + * to call its endio for and only for the split range.
> + */
> +static inline void btrfs_bio_save_iter(struct btrfs_bio *bbio)
> +{
> +	if (!bbio->iter.bi_size)
> +		bbio->iter = bbio->bio.bi_iter;
> +}
> +
>   struct btrfs_io_stripe {
>   	struct btrfs_device *dev;
>   	u64 physical;
> 

