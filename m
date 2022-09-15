Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E653E5B9769
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 11:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiIOJ2T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 05:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiIOJ2L (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 05:28:11 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2060d.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1b::60d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32748A6D7
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 02:28:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lObu/IH9yKNqjPg5sZa/rAWzp6US+4edZa+DK9efwwYI5JPhDLGyvEmiUDUH7A8gbZftulJBCpzhkispr4oerRbRWal/cUXHK7to/5t3B0aY08K77wnV2gOsXlrG5WI5jd56HDPrWi/rCdGuX/y7NiPuA4jP0EUzj0tH7nZcBhe+rNBb/GwGPdwn/X09pJDAUZnA0g2HbylziQNfGt2L2To0iSEB2MS3RYECiWjgZStO/jkIJbR6E/KDzW8p0AcrpEMIRj1kZYZBX9mhjkjeOSqJqWnOEnYo0Ls+t40SODCG2IhagA6hLZ+X3lYnUYks7iR1FVPIr518adCTrPPxnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3jLuEjfT+2SdkRAH+BgNfD2VclQWB3pRlT9ieDGe1o=;
 b=WeydX2lKht5HnSMN0l+zoJ1WxrtmFadC97pKa2tBJBlOvVK0FCTwsWvo+KdarS30xi1RR1zEMxUTlLecFuibIcEGi7KV1+mim9FbAGGTJllrsWSdre02Wsrl4bYUthUjDVcapvvPSHMBz+BYn3hieLGACUL+En6EsLPCJxx3qY8bFh+2LgSHe/HAgU60RyZdn+Nz8YfNBrj18s5DQqv1Q6WOX7r9nyd5yEwvfgrHfRhTgxFb3isrcWcoyeoslVR8+ZxIwVTu2Ndhg66Kuj0woYQNd8uRN9HHPGocW0s+jVoSJlK4yricPjy4IAo7lhne/tVrBr5m7HNGw9UnQcDg2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3jLuEjfT+2SdkRAH+BgNfD2VclQWB3pRlT9ieDGe1o=;
 b=zRQusQpKjkxpMrXgd6PdgXSO1kF9gqOK/OEs8bR094utUVhYk1hnysI3uDE/cSLYwloXMQ6/Qfr9G/U1wkdlCrOAS+L1P6Cz3dhwLpwxD83bTHuoNaYPRWpyFCJIq2PbWoQkWEiY+SKVbTqpp4+QZT/QKv/HzeQ4kuw280c6piTHARdUkZkOm4tCOMwm+1h9P3IT0UjlQf6+0nfsXTaqIXQvKZlYhbhjk3bIE7r68gyXr1PO6Q+HiAPVX7ghHrGSFoKnvW+rcl+EMv2mAKonN6p+NPYKEs6b5ceGuA3h89zZPo+lRv8Ee/MGD66ZT41G6IF4THAzgIs0fKH65s9IeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AS8PR04MB8326.eurprd04.prod.outlook.com (2603:10a6:20b:3ff::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.14; Thu, 15 Sep
 2022 09:28:04 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::3a32:8047:8c8a:85d9]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::3a32:8047:8c8a:85d9%5]) with mapi id 15.20.5632.015; Thu, 15 Sep 2022
 09:28:02 +0000
Message-ID: <bb59552f-85ec-5172-bb6d-f3a76febd491@suse.com>
Date:   Thu, 15 Sep 2022 17:27:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 15/17] btrfs: move free space cachep's out of ctree.h
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1663167823.git.josef@toxicpanda.com>
 <d74e617ece68c21850260393cdce86ad5ae33ee9.1663167824.git.josef@toxicpanda.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <d74e617ece68c21850260393cdce86ad5ae33ee9.1663167824.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0252.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::17) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|AS8PR04MB8326:EE_
X-MS-Office365-Filtering-Correlation-Id: 70cd5998-3d42-48aa-4927-08da96fc963f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2sbNuT+YmNRSOeJ31fQix52tsb/DXAVHrch20RdY3VbX0WdM99F4efidCgyrFASs2wvQAbWmUCCinduTEh2CeC92GVAqneUoN80L84U+GRMkLMZomJ6H4cgIsnGSdxcoWbLkhfOE7PjAdvvQ3DSycSdFUj9weDc6uVWjDKfnpy4Vsr7fVTdXLxRTegFstHzSBl4OQgo0aEwas1j+9NZE9GhsZC6MQdiDwLTUxzZzKFaafucTNeeAoEe4XmS8GDI+0VCdFz0uyfrqIxPKra5rHJuXnNi1I+mXpxQorbZ5tyq2BvHOUsOZnyyQGkCH7xn4hePSyL8CJJlYB6h6/3HzB451njp/7ybAIxOWXlaEwK+aRv0l1zk5VMqoGL/wb9PG/obPaD/VZ7xHlaJNV5J2vq+bUD0ECuMbgC9T90BNm1Wdob+hYF1RKyJGSGKVVpQptwDfTdSd7vuMJ7CQl4MZa9x6p8GMV03MfKZQ/B30GhexgS5auzMXeOAyciPM9Zbo0L9bQBMgNUzWaDSsqWMl6HnSuzCAG9Dc1NE1RSxoK8XY9ffMa6XZtDlZGkciWxTivJ9gjmFait81atoEvTTFif8XvK+KuunW1k55p67YaXRoPGGPYgfwjFGk7GyKm4/fRIzte/UQcBZw5ekuLsDnc5VbxLo+Gl0ySa2gXKHv/bMf+qlsirFLWlMzD7VZzF7Op+TytMvCzGuzqAJertlE02sa0bWFiyVFZfRFlt5llxmRg3yGpXNHnajZq8So+30BJ7htE6KFT1osH6zfi+LVvXrBbo3yTtfXw5457jSlOU0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(376002)(366004)(396003)(39860400002)(451199015)(41300700001)(53546011)(6512007)(6666004)(6506007)(316002)(478600001)(6486002)(36756003)(38100700002)(186003)(2616005)(31696002)(83380400001)(86362001)(31686004)(66476007)(5660300002)(8936002)(8676002)(66556008)(2906002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yi95ZnBmRTNCNm5GRUpnMGlZblZkaDdiMTRHTGh5ZHVxcWh2OUFkZlUyVkhO?=
 =?utf-8?B?QzdEZm5BalRTd1FBbFUvaW9pZlFHbDZtblh6ajY0QjRoRXZDU2QrNnB4TmEx?=
 =?utf-8?B?NGYyVWFodE5UTEtZRkdKZWZMMUFJbEp0WkpOUm5ndFJDZEJHWXVzZjBmNndm?=
 =?utf-8?B?YUljOXlIRzVLblJGUW5ydVNib3loaGllalNDL3lRbEplS3dpVThMdUVBdStI?=
 =?utf-8?B?OG5nbTd1MEFNQ3ZhY3lySFVheVZsMGlHcVB4Z0dIVVVCWWNadDA5QVVPblo3?=
 =?utf-8?B?ZnNPZDFPTTNmK1MzNFpHbzZlcVNwV0pZa01pNzZiQjBTSjhET1J1ckM0cnc1?=
 =?utf-8?B?QlBzMXRvV0c3dGdReGE5NmhFRkdnMzExcXYrdzBNWTF2bmlLR2dKSy9DZ0Zv?=
 =?utf-8?B?YTVvY1kyeWNDTUhXRW5wOVhuWU1TRXVYejhSdFQ0K3ppU2Y4WTltR1VSN0Zv?=
 =?utf-8?B?TWNzNDJGMFQ1NEtobFJHSklGZ1JHRVNBbktpY2t1RCtudm4yUmlVQlU0TEhn?=
 =?utf-8?B?YlJia0dHdGxTdFRRSWdkUFk1UFJFejNwb2lVNXB4NVZVRzA1WHpuUGV5V0xm?=
 =?utf-8?B?cFRRdiswY0E2R1pVbERPMFBMZFVscUVuZE00NUo5djRuRlVEWnNLRHFqQ3px?=
 =?utf-8?B?WkZtVm9mbVZ1clVTQ3BsOEVNS2VuTnFLbE04SWk1d2lET3dValVVRHBQeFJF?=
 =?utf-8?B?UnNNaTMyd0IrbXlXMzdGVisxQU5xTkhqUXV0QmlzQjQ3eEdpcmtOUURTaHFH?=
 =?utf-8?B?UWQxcnRicFNyVCtjekx3RVcxeGJ0TUZKaUdTZjFZblFUUGROVWV2a1ZBSUR0?=
 =?utf-8?B?UXV1QnNtMkNwZllCS0tZMGhERksrc2tCUjNLRFRQdlZ1dWkxRmtkejFQOHdE?=
 =?utf-8?B?ZG1PeStaMXJYOEx1eklHaVZPWmd6cXJMOElpaGExRXFVNkJza05ybXZ3WXc0?=
 =?utf-8?B?U0JpeXlNSk03VjJ3RnZDa1hXTHJhb1lqZjVObHFkN1lobWZlZFp5SVpINndY?=
 =?utf-8?B?aWRYUy81dUg4WTB1djRQVWxzM2ZLQ0NwL3FOQ2tDVWVRZGlkZGpKdTg5bU9F?=
 =?utf-8?B?REQydi9WT2JjQ0txUXV6MUw2cEdCRHdudlFnMjBoei8yKzg1RmRtNFZLWWgx?=
 =?utf-8?B?ejNrSkFVamwyYnc3d1dmT3lmYVZlSVJtaEhZbUNXR2JzRjUyalR3QVgwYStB?=
 =?utf-8?B?OTNyRkhlMzV4RVNHNmNCSjFWNWJLMXZqbzVQYkpCRlVXTk5kUTB1UGpVY3lv?=
 =?utf-8?B?ODhuTzBxT0VOYVdoWE9BSHBzU2swTGJpL3k1elh3RDY5WUJqa2NzNUY3U01D?=
 =?utf-8?B?T2hPL01HQmZGTXFxQWJKSStEL3h6SjVraHd4M2xEa1l4K0V6NGVyei9ESy82?=
 =?utf-8?B?OXNWU09oN2JlMUdYbU9zSVZPb0VwUGxock9MT3RHWjIxMzdXWlJubWdMZUZp?=
 =?utf-8?B?alhHaEQxbVhUbFpEWVppVXpGc2NzMlNnYlp2WXRhSENDaHltMzVWdk0zUWhL?=
 =?utf-8?B?WTRDZmU2Y0ZnaWtuL2RzeUdHdzBaYTNJWnA4SzJIZmVCNkhFNUxPN1J1Y2dm?=
 =?utf-8?B?cDdscGVEY0UxejBEdEIrVSt5dEkxd0RoSW13VW5qbEJwbFc5YURlOSs3MXVX?=
 =?utf-8?B?UEw2ZEdGeEROVTlOWTRES1Bpd0VFTFdsTlNyazBwRmZFSkpBWU9NbmdEWUpv?=
 =?utf-8?B?VTFlMGR2VU9jRVJRQnN2ZTdaUlptSTkwTnJURDhnM1RNUDlrcENlTXdiQlkw?=
 =?utf-8?B?TGlXTmNlOWNkbU0xWHNJWGtYWmJXQm5QWmZRMmF4c3FlRlRKeTlXWDVhZXA5?=
 =?utf-8?B?M25zVXpkN2V1T250NitGN0ltNGhjak1YQTlJbUpMUk8wL2JRdHFwb0dMNlZr?=
 =?utf-8?B?MkRMbTBId0NJM25jTjAvOWMxbDBmcGFxRTdTTGhMamRncDBtd1RnT3lmejJa?=
 =?utf-8?B?SmJZNTEzTG5zRjdVeHo1RnpPUDdrZ1gzZVBEZ0VhZ0FIMnBYNzI4VnpzekxI?=
 =?utf-8?B?QjBVaTY5TS9jcTU0a0VsVytkVVlHSS90QUhpd3p1aGwvcUErMmw5TElpSlFi?=
 =?utf-8?B?TGZUNU9WTUNlL0Rpa3c1bUk4QXZBUGZUTTRzR1hmeGUvd09BSXlCSUpYeGJM?=
 =?utf-8?B?dktHQk1FTWpHTTNJdHpPUnJ0RzNpazBPSC9aU1BKcklKWkFkNUVqQ1cyVUxk?=
 =?utf-8?Q?8+E5YbpPjNMt2erdNNXee+Y=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70cd5998-3d42-48aa-4927-08da96fc963f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 09:28:02.3938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KOi6x7MugU6Zcvon43XtsV2AyJNEgoiFOdXX2ZOSDDD38p9wawu4HGAsa69UQ53X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8326
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/14 23:06, Josef Bacik wrote:
> This is local to the free-space-cache.c code, remove it from ctree.h and
> inode.c, create new init/exit functions for the cachep, and move it
> locally to free-space-cache.c.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/ctree.h            |  2 --
>   fs/btrfs/free-space-cache.c | 28 ++++++++++++++++++++++++++++
>   fs/btrfs/free-space-cache.h |  2 ++
>   fs/btrfs/inode.c            | 16 ----------------
>   fs/btrfs/super.c            |  9 ++++++++-
>   5 files changed, 38 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 3a61f5c0ab5f..af6f6764d9a4 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -41,8 +41,6 @@ struct btrfs_pending_snapshot;
>   struct btrfs_delayed_ref_root;
>   struct btrfs_space_info;
>   struct btrfs_block_group;
> -extern struct kmem_cache *btrfs_free_space_cachep;
> -extern struct kmem_cache *btrfs_free_space_bitmap_cachep;
>   struct btrfs_ordered_sum;
>   struct btrfs_ref;
>   struct btrfs_bio;
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index 7859eeca484c..ee03c5e6db4c 100644
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -29,6 +29,9 @@
>   #define MAX_CACHE_BYTES_PER_GIG	SZ_64K
>   #define FORCE_EXTENT_THRESHOLD	SZ_1M
>   
> +static struct kmem_cache *btrfs_free_space_cachep;
> +static struct kmem_cache *btrfs_free_space_bitmap_cachep;
> +
>   struct btrfs_trim_range {
>   	u64 start;
>   	u64 bytes;
> @@ -4132,6 +4135,31 @@ int btrfs_set_free_space_cache_v1_active(struct btrfs_fs_info *fs_info, bool act
>   	return ret;
>   }
>   
> +int __init btrfs_free_space_init(void)
> +{
> +	btrfs_free_space_cachep = kmem_cache_create("btrfs_free_space",
> +			sizeof(struct btrfs_free_space), 0,
> +			SLAB_MEM_SPREAD, NULL);
> +	if (!btrfs_free_space_cachep)
> +		return -ENOMEM;
> +
> +	btrfs_free_space_bitmap_cachep = kmem_cache_create("btrfs_free_space_bitmap",
> +							PAGE_SIZE, PAGE_SIZE,
> +							SLAB_MEM_SPREAD, NULL);
> +	if (!btrfs_free_space_bitmap_cachep) {
> +		kmem_cache_destroy(btrfs_free_space_cachep);
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +void __cold btrfs_free_space_exit(void)
> +{
> +	kmem_cache_destroy(btrfs_free_space_cachep);
> +	kmem_cache_destroy(btrfs_free_space_bitmap_cachep);
> +}
> +
>   #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
>   /*
>    * Use this if you need to make a bitmap or extent entry specifically, it
> diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
> index eaf30f6444dd..cab954a9d97b 100644
> --- a/fs/btrfs/free-space-cache.h
> +++ b/fs/btrfs/free-space-cache.h
> @@ -88,6 +88,8 @@ struct btrfs_io_ctl {
>   	int bitmaps;
>   };
>   
> +int __init btrfs_free_space_init(void);
> +void __cold btrfs_free_space_exit(void);
>   struct inode *lookup_free_space_inode(struct btrfs_block_group *block_group,
>   		struct btrfs_path *path);
>   int create_free_space_inode(struct btrfs_trans_handle *trans,
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 1401e2da9284..da5be8f23f68 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -107,8 +107,6 @@ static const struct address_space_operations btrfs_aops;
>   static const struct file_operations btrfs_dir_file_operations;
>   
>   static struct kmem_cache *btrfs_inode_cachep;
> -struct kmem_cache *btrfs_free_space_cachep;
> -struct kmem_cache *btrfs_free_space_bitmap_cachep;
>   
>   static int btrfs_setsize(struct inode *inode, struct iattr *attr);
>   static int btrfs_truncate(struct inode *inode, bool skip_writeback);
> @@ -8936,8 +8934,6 @@ void __cold btrfs_destroy_cachep(void)
>   	rcu_barrier();
>   	bioset_exit(&btrfs_dio_bioset);
>   	kmem_cache_destroy(btrfs_inode_cachep);
> -	kmem_cache_destroy(btrfs_free_space_cachep);
> -	kmem_cache_destroy(btrfs_free_space_bitmap_cachep);
>   }
>   
>   int __init btrfs_init_cachep(void)
> @@ -8949,18 +8945,6 @@ int __init btrfs_init_cachep(void)
>   	if (!btrfs_inode_cachep)
>   		goto fail;
>   
> -	btrfs_free_space_cachep = kmem_cache_create("btrfs_free_space",
> -			sizeof(struct btrfs_free_space), 0,
> -			SLAB_MEM_SPREAD, NULL);
> -	if (!btrfs_free_space_cachep)
> -		goto fail;
> -
> -	btrfs_free_space_bitmap_cachep = kmem_cache_create("btrfs_free_space_bitmap",
> -							PAGE_SIZE, PAGE_SIZE,
> -							SLAB_MEM_SPREAD, NULL);
> -	if (!btrfs_free_space_bitmap_cachep)
> -		goto fail;
> -
>   	if (bioset_init(&btrfs_dio_bioset, BIO_POOL_SIZE,
>   			offsetof(struct btrfs_dio_private, bio),
>   			BIOSET_NEED_BVECS))
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index acd590bed579..c2e634de01e4 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2745,10 +2745,14 @@ static int __init init_btrfs_fs(void)
>   	if (err)
>   		goto free_transaction;
>   
> -	err = extent_state_init_cachep();
> +	err = btrfs_free_space_init();
>   	if (err)
>   		goto free_ctree;
>   
> +	err = extent_state_init_cachep();
> +	if (err)
> +		goto free_free_space;
> +
>   	err = extent_buffer_init_cachep();
>   	if (err)
>   		goto free_extent_cachep;
> @@ -2817,6 +2821,8 @@ static int __init init_btrfs_fs(void)
>   	extent_buffer_free_cachep();
>   free_extent_cachep:
>   	extent_state_free_cachep();
> +free_free_space:
> +	btrfs_free_space_exit();
>   free_ctree:
>   	btrfs_ctree_exit();
>   free_transaction:
> @@ -2832,6 +2838,7 @@ static int __init init_btrfs_fs(void)
>   
>   static void __exit exit_btrfs_fs(void)
>   {
> +	btrfs_free_space_exit();
>   	btrfs_ctree_exit();
>   	btrfs_transaction_exit();
>   	btrfs_destroy_cachep();
