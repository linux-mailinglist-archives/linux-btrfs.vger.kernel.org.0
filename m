Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9B0504D88
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Apr 2022 10:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237087AbiDRIIA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Apr 2022 04:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234566AbiDRIH5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Apr 2022 04:07:57 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F25EBC9E
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Apr 2022 01:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1650269116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rhodKoVRhANbyYgXXueCgly/q9zTJOK0/kiwFtCBfk4=;
        b=hzaegDI+LGruPDhD1Ch2/3cJaS2YtL9xckdTbA/Q3l65BXq4M9hiDbCf9xaJI5efkjQpAO
        +TvjgzPBhVIfJpR01rbbjPDSyazAfOoCeZ7RtYIQaxnjMe0T81sN3OXoL0/ZBTrZUghxSz
        Ig1Lc9ir+/iDZ9ADBucHnxwUOTIoImU=
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur03lp2058.outbound.protection.outlook.com [104.47.10.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-15-EKEtnRKbM4yhS0AYEbfQFg-1; Mon, 18 Apr 2022 10:05:15 +0200
X-MC-Unique: EKEtnRKbM4yhS0AYEbfQFg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hpTAsikNGPBPRQt8PVAqrgI6a290vBxuCwyh/d/s1+50WkoXh4bmKT0caxeIlh63c0CLTmkc8cqPLozDgQ3UY0ppLTvAhIkdmRCU1Ys4Y/YyCJa6kj9Le0IN8P54U1XVO/9FIlAI0wOb+wKQXCZCRiOXcrgC64B0V9MSkKUeEyGldAjeLkNboOp2e8JF8ClBsFE199sHRgdBZv6v06xGvWZjBbRNuSq7mlnKgt7aDwUh3V4eAYvyny4JFnFXVYOd+Udc2i5YyWiToGPcpFYmDGCjdKmM39mZpxFul5smc1iM0by/XgSJFykj7BZ7cMH85KKdsNyY2kOWD2x+PjIY6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rhodKoVRhANbyYgXXueCgly/q9zTJOK0/kiwFtCBfk4=;
 b=OLOVSpzmycsRwAouPn5kc+dQSzPHutjan8jSyQeU/ge9cW12sFCbyMoaWwx/I+srmjxnO5IxwnYx+8TPbmdU0Xbh1Ylpd2r4zayJI9H1IzIsTNHo+KGZsnhmx366sidwZ0JMdkEiytZb0x0S3HNpKik8K89aKvXgSi6cDkUqfi9f5bUY4QlW/JnBp9PPDWaOSgiXuto2TDK9Xg9JHhNEEpNm2E+5NEXqjeVi0R6XGntAmb0/Z7ncEkwNmZBohJcGZJWr5sYk9QvWoRTZuqjd8UKrvHjLBSPWciMxKgAkzjkHDpXWrC/6u4q6X3j4+llueFNCa02yvvFELZhM5S2N+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 by AM7PR04MB6886.eurprd04.prod.outlook.com (2603:10a6:20b:106::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Mon, 18 Apr
 2022 08:05:13 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::415f:1551:a6d5:face]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::415f:1551:a6d5:face%6]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 08:05:13 +0000
Message-ID: <cbf20712-6acc-bbf6-99ba-1eccf6518644@suse.com>
Date:   Mon, 18 Apr 2022 16:05:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 3/3] btrfs: use a normal workqueue for rmw_workers
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20220418044311.359720-1-hch@lst.de>
 <20220418044311.359720-4-hch@lst.de>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <20220418044311.359720-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0064.namprd08.prod.outlook.com
 (2603:10b6:a03:117::41) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b84312f2-ee91-41f0-923a-08da21122a55
X-MS-TrafficTypeDiagnostic: AM7PR04MB6886:EE_
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-Microsoft-Antispam-PRVS: <AM7PR04MB6886AE7EF77E224A9C265DCED6F39@AM7PR04MB6886.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w/8zsw1DGuHkBFRmLVr06BPuksenkc5wwgaMNJKFPH0wh6ZDbjd/q9IZEJ7bw69pGsuKJY2H4TTs4whvrwgzEmsIIzDq+hULn1tpiKevMhpp5f0Wwz4pmw/j3IEHQ5gNEKZjsgeEilvhTPRlkjKFtBfkHqwDokmEobYU0Cg9I1whurBlTdKsYmEXPQz6PuySHpxJUCUTZcdPiR5UBkLewU6HqSXGFDZsGO/P/igGKG21B+Xqoz4WrKqwyojIUQU1Ku6iMSk8h8D2FUkvePHk5Hio9Ubb0RlE3XBdgWISUvGf+MOxJmr0qmn+XP8ZQkGYlFKk/sZaPuFXb44e+nyJ1lbfKo9p/XO3EJOPMwRi/KQTlrDYNBSDdmV+sLVFyPLhM40cKrYiHZRN7GHmsSBMrj5lBg/AU8kRbCmmUYj8gmGAEQQYTSgZvAcAgA594lT7nJq5fysZ0D/GocKR01/xUNdxjZ6TIiYwvzxRSyPU6Z6NsMt2zIzyYVWV7nJn6jdTnqYxbTooRGCmgGYO3JNfKXctuFKL/dOW5rc8m2D39Pw+RNJu5RCZz2Mt1D+yPKr3bejHrvlJ2xj7uajREKjw6x2bNjF8P5AIbpEEtOmNIdetCHj1JultL7OkpnapCatrV8lmKyj02RpcZACcHAKHLTRDi/J3KWHShmO0rRlD//J5ZJw56/qsnB9OjF5LIWlq2bMqJIlNEZF/MpAauj1zvJ4P41dH1lNTm+3I8NHwpFw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(66476007)(66946007)(66556008)(8676002)(38100700002)(4326008)(83380400001)(2906002)(31696002)(8936002)(31686004)(5660300002)(36756003)(110136005)(53546011)(316002)(6636002)(508600001)(2616005)(6486002)(26005)(6666004)(6512007)(6506007)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aldYclZsUE9UYzdqclBsNHVpcGh5QlN5Qk1lRUNYbXc4Wlo3QnhjaHVJVHli?=
 =?utf-8?B?WHhIYitJanpCZlhjbXhzNHNLcW1LanZWSlROODdQMWMzaW9ueDJYbEp5RklP?=
 =?utf-8?B?aWgrUGRVdzA3UG8rYVRVTHBsRHorUHFQdVFQem1qYnE3bFpwU1Z3YndQNEJj?=
 =?utf-8?B?ZFQwWDBCajZXSUJvR094YUZxUVM2VE1ocTR1QjdrYWY4bTRyVWdHb1FOMkQ3?=
 =?utf-8?B?N1Iwa1hGOTRnUTV3UjI3NzRyMURIazFDT3N4TGZWTWtUSU03WktvNWhTVTJp?=
 =?utf-8?B?ZVg3ekRqR25jMGIxd0dtSTZnWWVpZWpTcDdjdkJiS3FVdGFFTnB0MENPUmRa?=
 =?utf-8?B?eFloNDF4UTIvbXB6SEwzZ0h2U3RlcXJnaDJyM0tvMVdtMjBpRndrUGwxRHVY?=
 =?utf-8?B?aHBSTlZLbEl4TFl2bFFBTGlHMForam5vMk45eEZuUU9xSWlXTmhCMU5RMzZ0?=
 =?utf-8?B?bkgyV1pITXFoUlVxYUMwQ1V6MXNBcWZDOVVWTDZtTjhyUzZiZzJhaHk5VkQ0?=
 =?utf-8?B?eXh3amN3YXp6cWp5Tm9ISGFUemtuVjVOdTQ1eGZXNzdncW9NazI5SmIxWVZx?=
 =?utf-8?B?bm1qZTIyR3l6U20rV3NuanR5ejYwTHFzb1hBNmVOMHQvT2htazhDQVRQakxM?=
 =?utf-8?B?MkJWekMwUytaTEZWSzRuMWFTY05wUmhtakxyZHdsZ0hoN2pCWThRR0tJNzRl?=
 =?utf-8?B?eU4yOVFwRTFtWXlKZmQrcmpzMEZGdlhpbFFCeUY5dFNlejFDZEJDNTdMOHNo?=
 =?utf-8?B?QlMrSjJjVysxSjNmOHFNcWVOQS81bENwVWhxaE80dUQyclV3ck5WVDd2K250?=
 =?utf-8?B?dzVzbDN4b3dZUWpPQlZSanYzQjhNa0xQMEJLODhNQkRwd3ZIcXU5ZE5zKzl4?=
 =?utf-8?B?cSthcE9VampoK1hHT1AyV1k1ZnFDUS9xNlFRK0JkeG9LbU8yMmpGWWZ4MVE0?=
 =?utf-8?B?SjNYeUo3VmRBNkdZbTFFZ1F1RnFqNlB4SXljdHo5dVVIZ3NNcXlqVHgvM2xw?=
 =?utf-8?B?cnR6N2N3dExnK0puV2xnaVpZZXp4d2htNDQ2bytiRVk3UGFyNytUSHZleUhn?=
 =?utf-8?B?QUJJajh1dHF6S1NxVlF2dEFKKzlCOUcwcnZUQ0lTVG1TUzV4RzcwSmJ0Z3k5?=
 =?utf-8?B?RXpPTDhMeWZBVDBlcUp2cDJ0ZEtqM1JjT2ZRM2ZtcklrUkFwTS9KWWdGS1Rq?=
 =?utf-8?B?Vjhna25Vc1JGdUkyWXFQUzNCMlhRWlVSSDVKR3hLRENCNjBBMk5CV2V3SUhK?=
 =?utf-8?B?WmVQb0lUTEZMT0IzWXZzL1Q4M0lQcUtwTjVIbEdCcTRSbXpSVEFFNXJPekwx?=
 =?utf-8?B?Z3ZNaW9WSWc4c3NCNUZRbjFKMnVBalNERkorYlU0OHI5VDlpVjVpbG5UWmsr?=
 =?utf-8?B?VlpldzNVMXVNa01BS0s2WTQ1cHRaYytrY3dscnNFWnlHSzZMNm9QWG5ucXhB?=
 =?utf-8?B?ZU1reTVZeXhuR1JTUlRNNTNNWkRMR0luUm0xdDRzSG1MR3JGTGM2dXhwOEs5?=
 =?utf-8?B?MkFJbURKZnBQdTlib0J5U1E4M04rRUxiaTdRYlhvYmcxeEJKZUVSNkJjYUN1?=
 =?utf-8?B?OS9tSUhXbkJZcVVjMnhibDJRTVlQWXNtTkMwUnY0dFRZV083Wkl4clFBSTBD?=
 =?utf-8?B?c1pyT0k2NmpTcGp5QStHaHlCZVVHcG84eDN2T010anB3ZmlHeGhJcFNEOHBS?=
 =?utf-8?B?Uk5zOVptMm94M0hzNlEwaTY1cUpzZ1Y1cjduYU1mS01SaUN3RkZ4MEhXYUFk?=
 =?utf-8?B?WkUrQ1Q3anJWajh5NjRNQkFCaS9ESElYdFVVa1EyT0ZPaFNFbWhiMXJPYXlP?=
 =?utf-8?B?WDJiUGRKWVFuanhRN1oyZEhZbmEyUnhNK05CUlZCeTB0a3o1eG1sczNtSTYy?=
 =?utf-8?B?S3AvQXpjYWl3eWVjOERvM29vMWNoWGNuOHkvU0FYWTZFbmlHZk1JWWVjQlR4?=
 =?utf-8?B?SXNYSExlS0xsaFVVTlFNSkdtR0IrTjVjNDkwd1JJQ1JHYkVib0RGVWJ6OEUv?=
 =?utf-8?B?aGYrS3dEQXRCOSszVWV0RDNqcGVjWnZjdkVlazR3NGljK0xoNWlGNkZqV1hw?=
 =?utf-8?B?ak5aWVBDWVloK3J3dUlsMEpjVWowOHA5OUVkSUhOa2FrUFFDRnFnWElpbTdz?=
 =?utf-8?B?a2krUVRPYW5yWkpFNGpuNGxoSUtKRXVOU0RGdHZGUzBCSVBtKzJDQkJRS2gv?=
 =?utf-8?B?NHMxTzl3NUdjVlRnVWVFM0lsUjJQRHpTZkFpdDFrczV1TlZLRVFzekc3US9k?=
 =?utf-8?B?WXd0SkxFUHI4di8wUFNERGkzU3RKRUtET1lOSzh1QlR5S2p6ZzVYSUI0Zk00?=
 =?utf-8?Q?6CvarDhmevnO/mcRh7?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b84312f2-ee91-41f0-923a-08da21122a55
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2022 08:05:13.1131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4DRT9hFx4wm7dKftPDOOCSX/fOihGsh+Gq4JE3C/kgxwxBikvPCDE4K6Ww/z474f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6886
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/18 12:43, Christoph Hellwig wrote:
> rmw_workers doesn't need ordered execution or thread disabling threshold
> (as the thresh parameter is less than DFT_THRESHOLD).
> 
> Just switch to the normal workqueues that use a lot less resources,
> especially in the work_struct vs btrfs_work structures.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/ctree.h   |  2 +-
>   fs/btrfs/disk-io.c |  5 ++---
>   fs/btrfs/raid56.c  | 29 ++++++++++++++---------------
>   3 files changed, 17 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 59135f0850a6e..74fbd92f704f9 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -853,7 +853,7 @@ struct btrfs_fs_info {
>   	struct btrfs_workqueue *endio_workers;
>   	struct btrfs_workqueue *endio_meta_workers;
>   	struct btrfs_workqueue *endio_raid56_workers;
> -	struct btrfs_workqueue *rmw_workers;
> +	struct workqueue_struct *rmw_workers;
>   	struct btrfs_workqueue *endio_meta_write_workers;
>   	struct btrfs_workqueue *endio_write_workers;
>   	struct btrfs_workqueue *endio_freespace_worker;
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 980616cc08bfc..cc7ca8a0df697 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2290,7 +2290,7 @@ static void btrfs_stop_all_workers(struct btrfs_fs_info *fs_info)
>   	btrfs_destroy_workqueue(fs_info->workers);
>   	btrfs_destroy_workqueue(fs_info->endio_workers);
>   	btrfs_destroy_workqueue(fs_info->endio_raid56_workers);
> -	btrfs_destroy_workqueue(fs_info->rmw_workers);
> +	destroy_workqueue(fs_info->rmw_workers);
>   	btrfs_destroy_workqueue(fs_info->endio_write_workers);
>   	btrfs_destroy_workqueue(fs_info->endio_freespace_worker);
>   	btrfs_destroy_workqueue(fs_info->delayed_workers);
> @@ -2500,8 +2500,7 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info)
>   	fs_info->endio_raid56_workers =
>   		btrfs_alloc_workqueue(fs_info, "endio-raid56", flags,
>   				      max_active, 4);
> -	fs_info->rmw_workers =
> -		btrfs_alloc_workqueue(fs_info, "rmw", flags, max_active, 2);
> +	fs_info->rmw_workers = alloc_workqueue("btrfs-rmw", flags, max_active);
>   	fs_info->endio_write_workers =
>   		btrfs_alloc_workqueue(fs_info, "endio-write", flags,
>   				      max_active, 2);
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index 79438cdd604ea..c1c320f87216d 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -77,7 +77,7 @@ struct btrfs_raid_bio {
>   	/*
>   	 * for scheduling work in the helper threads
>   	 */
> -	struct btrfs_work work;
> +	struct work_struct work;
>   
>   	/*
>   	 * bio list and bio_list_lock are used
> @@ -176,8 +176,8 @@ struct btrfs_raid_bio {
>   
>   static int __raid56_parity_recover(struct btrfs_raid_bio *rbio);
>   static noinline void finish_rmw(struct btrfs_raid_bio *rbio);
> -static void rmw_work(struct btrfs_work *work);
> -static void read_rebuild_work(struct btrfs_work *work);
> +static void rmw_work(struct work_struct *work);
> +static void read_rebuild_work(struct work_struct *work);
>   static int fail_bio_stripe(struct btrfs_raid_bio *rbio, struct bio *bio);
>   static int fail_rbio_index(struct btrfs_raid_bio *rbio, int failed);
>   static void __free_raid_bio(struct btrfs_raid_bio *rbio);
> @@ -186,12 +186,12 @@ static int alloc_rbio_pages(struct btrfs_raid_bio *rbio);
>   
>   static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
>   					 int need_check);
> -static void scrub_parity_work(struct btrfs_work *work);
> +static void scrub_parity_work(struct work_struct *work);
>   
> -static void start_async_work(struct btrfs_raid_bio *rbio, btrfs_func_t work_func)
> +static void start_async_work(struct btrfs_raid_bio *rbio, work_func_t work_func)
>   {
> -	btrfs_init_work(&rbio->work, work_func, NULL, NULL);
> -	btrfs_queue_work(rbio->bioc->fs_info->rmw_workers, &rbio->work);
> +	INIT_WORK(&rbio->work, work_func);
> +	queue_work(rbio->bioc->fs_info->rmw_workers, &rbio->work);
>   }
>   
>   /*
> @@ -1599,7 +1599,7 @@ struct btrfs_plug_cb {
>   	struct blk_plug_cb cb;
>   	struct btrfs_fs_info *info;
>   	struct list_head rbio_list;
> -	struct btrfs_work work;
> +	struct work_struct work;
>   };
>   
>   /*
> @@ -1667,7 +1667,7 @@ static void run_plug(struct btrfs_plug_cb *plug)
>    * if the unplug comes from schedule, we have to push the
>    * work off to a helper thread
>    */
> -static void unplug_work(struct btrfs_work *work)
> +static void unplug_work(struct work_struct *work)
>   {
>   	struct btrfs_plug_cb *plug;
>   	plug = container_of(work, struct btrfs_plug_cb, work);
> @@ -1680,9 +1680,8 @@ static void btrfs_raid_unplug(struct blk_plug_cb *cb, bool from_schedule)
>   	plug = container_of(cb, struct btrfs_plug_cb, cb);
>   
>   	if (from_schedule) {
> -		btrfs_init_work(&plug->work, unplug_work, NULL, NULL);
> -		btrfs_queue_work(plug->info->rmw_workers,
> -				 &plug->work);
> +		INIT_WORK(&plug->work, unplug_work);
> +		queue_work(plug->info->rmw_workers, &plug->work);
>   		return;
>   	}
>   	run_plug(plug);
> @@ -2167,7 +2166,7 @@ int raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bioc,
>   
>   }
>   
> -static void rmw_work(struct btrfs_work *work)
> +static void rmw_work(struct work_struct *work)
>   {
>   	struct btrfs_raid_bio *rbio;
>   
> @@ -2175,7 +2174,7 @@ static void rmw_work(struct btrfs_work *work)
>   	raid56_rmw_stripe(rbio);
>   }
>   
> -static void read_rebuild_work(struct btrfs_work *work)
> +static void read_rebuild_work(struct work_struct *work)
>   {
>   	struct btrfs_raid_bio *rbio;
>   
> @@ -2621,7 +2620,7 @@ static void raid56_parity_scrub_stripe(struct btrfs_raid_bio *rbio)
>   	validate_rbio_for_parity_scrub(rbio);
>   }
>   
> -static void scrub_parity_work(struct btrfs_work *work)
> +static void scrub_parity_work(struct work_struct *work)
>   {
>   	struct btrfs_raid_bio *rbio;
>   

