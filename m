Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17965B9756
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 11:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiIOJXv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 05:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiIOJXt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 05:23:49 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140079.outbound.protection.outlook.com [40.107.14.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DF589CD3
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 02:23:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YnHxDCJLcax5SFVanz8+E6Ff9EX/FZj1yK8Te3t2/RZKgrB3USrsxRFnZ+NKuHfZ/UGXwKOGlqn80VuAXKHx2SzDr8Zs1NuDfdmTf7Ud3Tyg2i5l/5bEhthHN/uaHStfH5rLmBd9JIPq42NRV9cIsjbnNBND0enoqrnGcbQXErqPOHdPRsSinX7Wt/182ldjVx7CxCNMYeGIAn7WQuP4PYf8yTdMqOB6LGOQ795cxGoGKupqePgLbWUadE5bDCiDc/f4w+T4IdR6Z+r2PdkOSqEfNnUXRRpzYhnue3kW7z882xXimTucVMSERVEcoCyOnRTMS9ht0xTuZ8RObRIXeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVs1C+SRvkVWAqK2npfRQtMt/yDu7CG+BZbtLJRLHq0=;
 b=ZsTmYfPNcnwsSx4uogCtprHxhUWSxwXKMf0WRhKYrEDhQpYR0jt7xsaKtzY2v8zG9KmpaSq7KeBV4bc8uRg+pudnIOsWXxquY0xlg53il9jMy/rA8WL7sXbahs6icV2KrFJPqzT1Q9XXdPpLJEmzJSdvuHL10NMf0fXrdRkeZvM7f52D3cf6oqN0Yn5GAKWqE7vyj4Imt5DraaKR6lXcGWk3+qdRTOkQ+MisxF29KXJOfSzFuSYIVp11AFfOMoa2I6VbvVq0SdwmhD220LPZ5KIZ1WTio/WhWV/Z2c3bwviWAo0a6kHvg4+vnrG1LIGWo291cB36Z20Z9WCJOZ1Y/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVs1C+SRvkVWAqK2npfRQtMt/yDu7CG+BZbtLJRLHq0=;
 b=yPIh/Cm0APZdPZxrotF1duhDIKoGiw+qqIp7d96M7EdQ7C0Voe9H9uaBC7Ye0/G9g4O2mva7gpDw0YR4mHTY3Y7aOsmIaHbTdDG9pmwNcRr7r+Qo3ngF0B2K01ZJl0eArCETL6a6I3LfsF8OHd16rbx6OTWJd4+0CpVfvzYms46WHhXAhzxGkIFdmvaOGeTba0cx6sTmb8GTO9jEysBTTM5iPmgsjnRr2DvQp4kiETTeAaKQL93uKeAj1eKcq+5B+v9lyf0lPkDfy1yW1WolqKd7V+ILIWbAY/HZ2z6BoEDShgo+PZwb0jSR2S49/XQxGPaUFo32CJdVDBQrYt9DOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by PA4PR04MB9486.eurprd04.prod.outlook.com (2603:10a6:102:27d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 09:23:42 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::3a32:8047:8c8a:85d9]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::3a32:8047:8c8a:85d9%5]) with mapi id 15.20.5632.015; Thu, 15 Sep 2022
 09:23:42 +0000
Message-ID: <b3e9accb-6317-1a9e-b691-905111b2b7b9@suse.com>
Date:   Thu, 15 Sep 2022 17:23:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 13/17] btrfs: move trans_handle_cachep out of ctree.h
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1663167823.git.josef@toxicpanda.com>
 <68e9b87432b738ef6547294d9e5d307cfbdaf13d.1663167823.git.josef@toxicpanda.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <68e9b87432b738ef6547294d9e5d307cfbdaf13d.1663167823.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0PR07CA0109.namprd07.prod.outlook.com
 (2603:10b6:510:4::24) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|PA4PR04MB9486:EE_
X-MS-Office365-Filtering-Correlation-Id: a8329087-7f4c-443d-2adb-08da96fbfb22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4qXbF57tROCCFmhomm8mLiRNZ9JRDqDJlscW/qrx6IBlG6hKaq57etaFe1T+kr7SEiYaZ4yNk9wuMeaGBtw3vYHbySzp0iTQWce7uZyw+O6YbXc2KprpvbUhXGs6dPv7JmdjvKt7UQ7axIAazaZDcQGHHvkI2VSYfSSJAR7QCQATNv+b2wSoCn39zFeIxQsSZUQ8vyQF+uN98+KKNRTfnARpAZy2DW2JtEUP5O4Ez3Si4UjHLPmQOpeAWh8QFFt/HTGDhTyHWDRlYlc0eEJvIqQPEMxcrmvTZh7ECHQiy0UD89XV6dedl+2at8EjQH6mcy/Qykdo+fBUQ4lKXm0pz1KxA5Vy2wq3Jiy0lq1O3IgYuchcg0fTjVmCxIVFsxZP9MfK4qUdEJw9+ArOjdhFd/BHK+axEj+XuyH91CxXKoWbNj9nTeNNLgoxZF392zjJWTa+4yzi4FTKUPGMv/6u1npCFPVr4mvKuH6arHmu2t7EDEvejy/VSyrlArzaWnT7Dq5FyI6aZzDqZN8YomEWBSk9v+Dq9mT4/JHMjYRnHW3aWuc1qyWHLYatvf4wb2JAzOokcdmm4clkg31knpWNwN15tx09M1wtZ9rUzvNbHsBFBFq6NjHG4NabSveOxBSEtAfW8mrYs6hZl9Uxia/iLEQcamY6iBmJ6AOzSJZBWizkKEievz/rTfTGniSYf0RalNVxoQ7DfXtSdv/ySi020wWTyrflnQw3TR7bhA41GaoIIp1LeY/pNsEbk8/Ep+kkpr/vPCPChb5dOXk5Cxd3bA1pO+a0OtTfhuyhEJEoNDM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(376002)(396003)(366004)(39860400002)(451199015)(31686004)(5660300002)(83380400001)(38100700002)(6486002)(66946007)(86362001)(8676002)(31696002)(6512007)(66556008)(53546011)(66476007)(6666004)(478600001)(36756003)(8936002)(316002)(41300700001)(2906002)(186003)(6506007)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0dmNENTSWFCTmJ3OXRZY1daUk1LVnluc1VQSDJCMEo5djBhaDVMRTNadFBy?=
 =?utf-8?B?NWJRMEFNY0RXRUN0cWhvVXA5SCttMWNjbGlNendaOUFnbTFYWUtFTGFVdjZG?=
 =?utf-8?B?aUY2dVZQelRiZXlVVndkbVFSaUJQKzloejFuemdqQW96anNSSzhvSFNZbEta?=
 =?utf-8?B?YWwxWW82OC9QcDBvUVJFQ1c3b1ZwZTh2cWt0WlV6R3d0cmZTRGpPdkVRL2ZV?=
 =?utf-8?B?aDhFOXpDanJmRFppYXFHUmk4TWx2cGJveWhyQXRhSFRlOHhDNGJ6Q3hVbUR1?=
 =?utf-8?B?K1BFQW01WG50RE9jc1l5bGZFNUVmYzNMV1BGU1NqMXJuNHVnYkZFN0VaZTd0?=
 =?utf-8?B?aEYreFhjZHArR2pDcDBZeTR3bE9Hb0FLQ3F2NEtDU3pIeGFlbzcvVzA4MW1R?=
 =?utf-8?B?UHltUHVQMitOY21CK1B5dkl2VFBrYy8yaEJpSzQ2WktsQlRQYWIrWkM3UDhL?=
 =?utf-8?B?ejMrMVgwNDMrYTdBaWNwekwxZkhQbWNlbWVRdENzaVRpdC8rYlY2ZFdlRWlI?=
 =?utf-8?B?d2JxUlF6eG11MVRtNGUwRU1rSmZkUFNBVCtKZy9DM1Z1Q2pNeTFwWmwyaXFS?=
 =?utf-8?B?M0VtQlgyNi82OGlWVVR0aUVDamM1NS9kNUZwcUpkdys4Znhzdzgrd2VGdEhR?=
 =?utf-8?B?dkRPbHBBZUF5d0V3RUhlN2RMVjhBMDhkdmRtUVZSSmNYcjZrcnNZZFVycGZl?=
 =?utf-8?B?MHAyVlMzQ3FLZ1BBNWx6SzA4N1hnN2QrelQ4b21IMGJIQkUyYkVmRmF2dW1D?=
 =?utf-8?B?djNBazNycEtZNzJ1UGRjaGxWL1JZeDliRWV0STVncHc1TnY0ZStCWGhwVWd3?=
 =?utf-8?B?S05pSnVsaGNSekVXeE94a01ZMzlhbnM4UlBzYzhOM0dFSDhaUzJvY2hOWGNW?=
 =?utf-8?B?eHVDVmtvMHd2SFRiZzlEeFR0Z1l2dmMrZHlJbHEwcmEvdlBTTXVNbk1SRzRE?=
 =?utf-8?B?MGt5VTl2c2ZubU9CRnFqM1FybnYrZjNmM05WbVgwOFZ4dDEyK1NuRXM2ZTha?=
 =?utf-8?B?ekVvRzRpL04ydWV2M1p4N1RMNWtxZGVYRjRhRnAwZVUrOHdqREUxZDhDTUVl?=
 =?utf-8?B?aWpSd280QjZHR2gyU3MvRHpBZi9nVGRJVU9Pb3pPVTlGY2I3dm43bHdFNVN0?=
 =?utf-8?B?ck5iMWtoTEdaQWVkZ1pkZHg5OFMzd1htSzlyTEY4U2FSSXBveTNrZXFaNHpo?=
 =?utf-8?B?UXdjS0ZsYmZ2S0V5M1ZLYmFCaEdYTWlkVko1RmtyeXJWTmF4SlJRb3NaSHFS?=
 =?utf-8?B?RS9lditJakU3TWdIVmkxeHAvaU5wKzhJMTBGU2RUWmd2bDY5Z2RYcXhiTFdV?=
 =?utf-8?B?YkdtZUxnZ2d5VHg3STBoaHJYVjRpVW9wNVp6Yk55N0U1SUkwWFYwTXh0RzVv?=
 =?utf-8?B?MmJ3ZnkyanZ0RTJNS2oxQmE4V2cwTnBQSkllbkY0UHMrV1RJTWM1cm1OVmwv?=
 =?utf-8?B?MENvalNDNUMrZTBIYmFqL21laWV2RnJWWTl0eUQvQUNBeDlTbnFhMm5wVzZj?=
 =?utf-8?B?QjZTNldGcWVQNWFHZ3RObkJhdXhlUzdlYlhteU5MMm0vUXNZU05VMU5pK0ll?=
 =?utf-8?B?MzFTUnBPR2IrRERMQTFhSDJxSm5sbWsrY1pqK1dRNUVkc2Y3TXhleTVWZGxN?=
 =?utf-8?B?NURrNkdVdU1hM1Q2bVhDcGZmNmtNeXVQbGg0N2k3K0FMVXcvQ0txVk1NVVA4?=
 =?utf-8?B?TERXWnNKY0R5VElyMkxKM2tGL1d1bGlabjNTZCtMdXU3UGdzWklkTnlxbE01?=
 =?utf-8?B?TFg5L3hpRkwzU3NaUDlxbFpmbWVsL1dWUzJkVG1taDVEclBpNU5aUzBUY2lj?=
 =?utf-8?B?RUZwVnpHb2RqYnVhRnpqS0phVmlEaXU2SFptSDlJVjRlcFJKSGZMclo4V0kx?=
 =?utf-8?B?NFR3dEpQa2hBMXcyaTdrNVpHaTFCY1dsVW0rblM0WVpRRkhOTFpUakp5bTJr?=
 =?utf-8?B?RDRPcGliSGZTdHJxbFpReElnSFdHU1JuYXkwdW0xcGplNStveDJUQ2I0L0Jl?=
 =?utf-8?B?MWwzdDlLVmtWTTVvWFVpZVFLdGxwZDVtaUY3Z050SE5DSXZ5NW0vU2hDSHgv?=
 =?utf-8?B?cCsyeEJiVFhKVmNyaTRrbzEyOTFNeWFXWFI2WGhUMWZjWlFxcHVCam1OaTV5?=
 =?utf-8?B?Rmpmd3VQekQ2UTZIZjFDRUNlZGhCUis5Yzd3Uy9RKzN1RzlkaFVEOW80K3pN?=
 =?utf-8?Q?8WTNEAR/LmmCzuOKvyKEy3A=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8329087-7f4c-443d-2adb-08da96fbfb22
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 09:23:42.1717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5T/H54VdkUk9hafut+QngJPTySEGuawWVWHhhO0Gif0vBNfjiDNt/vNlxTWKaOVN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9486
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/14 23:06, Josef Bacik wrote:
> This is local to the transaction code, remove it from ctree.h and
> inode.c, create new helpers in the transaction to handle the init work
> and move the cachep locally to transaction.c.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/ctree.h       |  1 -
>   fs/btrfs/inode.c       |  8 --------
>   fs/btrfs/super.c       |  9 ++++++++-
>   fs/btrfs/transaction.c | 17 +++++++++++++++++
>   fs/btrfs/transaction.h |  2 ++
>   5 files changed, 27 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index d99720cf4835..439b205f4207 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -41,7 +41,6 @@ struct btrfs_pending_snapshot;
>   struct btrfs_delayed_ref_root;
>   struct btrfs_space_info;
>   struct btrfs_block_group;
> -extern struct kmem_cache *btrfs_trans_handle_cachep;
>   extern struct kmem_cache *btrfs_path_cachep;
>   extern struct kmem_cache *btrfs_free_space_cachep;
>   extern struct kmem_cache *btrfs_free_space_bitmap_cachep;
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 998d1c7134ff..78e7f5397d58 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -107,7 +107,6 @@ static const struct address_space_operations btrfs_aops;
>   static const struct file_operations btrfs_dir_file_operations;
>   
>   static struct kmem_cache *btrfs_inode_cachep;
> -struct kmem_cache *btrfs_trans_handle_cachep;
>   struct kmem_cache *btrfs_path_cachep;
>   struct kmem_cache *btrfs_free_space_cachep;
>   struct kmem_cache *btrfs_free_space_bitmap_cachep;
> @@ -8938,7 +8937,6 @@ void __cold btrfs_destroy_cachep(void)
>   	rcu_barrier();
>   	bioset_exit(&btrfs_dio_bioset);
>   	kmem_cache_destroy(btrfs_inode_cachep);
> -	kmem_cache_destroy(btrfs_trans_handle_cachep);
>   	kmem_cache_destroy(btrfs_path_cachep);
>   	kmem_cache_destroy(btrfs_free_space_cachep);
>   	kmem_cache_destroy(btrfs_free_space_bitmap_cachep);
> @@ -8953,12 +8951,6 @@ int __init btrfs_init_cachep(void)
>   	if (!btrfs_inode_cachep)
>   		goto fail;
>   
> -	btrfs_trans_handle_cachep = kmem_cache_create("btrfs_trans_handle",
> -			sizeof(struct btrfs_trans_handle), 0,
> -			SLAB_TEMPORARY | SLAB_MEM_SPREAD, NULL);
> -	if (!btrfs_trans_handle_cachep)
> -		goto fail;
> -
>   	btrfs_path_cachep = kmem_cache_create("btrfs_path",
>   			sizeof(struct btrfs_path), 0,
>   			SLAB_MEM_SPREAD, NULL);
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 2add5b23c476..9f7fc1c71148 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2737,10 +2737,14 @@ static int __init init_btrfs_fs(void)
>   	if (err)
>   		goto free_compress;
>   
> -	err = extent_state_init_cachep();
> +	err = btrfs_transaction_init();
>   	if (err)
>   		goto free_cachep;
>   
> +	err = extent_state_init_cachep();
> +	if (err)
> +		goto free_transaction;
> +
>   	err = extent_buffer_init_cachep();
>   	if (err)
>   		goto free_extent_cachep;
> @@ -2809,6 +2813,8 @@ static int __init init_btrfs_fs(void)
>   	extent_buffer_free_cachep();
>   free_extent_cachep:
>   	extent_state_free_cachep();
> +free_transaction:
> +	btrfs_transaction_exit();
>   free_cachep:
>   	btrfs_destroy_cachep();
>   free_compress:
> @@ -2820,6 +2826,7 @@ static int __init init_btrfs_fs(void)
>   
>   static void __exit exit_btrfs_fs(void)
>   {
> +	btrfs_transaction_exit();
>   	btrfs_destroy_cachep();
>   	btrfs_delayed_ref_exit();
>   	btrfs_auto_defrag_exit();
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index d1f1da6820fb..ae7d4aca771d 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -24,6 +24,8 @@
>   #include "space-info.h"
>   #include "zoned.h"
>   
> +static struct kmem_cache *btrfs_trans_handle_cachep;
> +
>   #define BTRFS_ROOT_TRANS_TAG 0
>   
>   /*
> @@ -2600,3 +2602,18 @@ void btrfs_apply_pending_changes(struct btrfs_fs_info *fs_info)
>   		btrfs_warn(fs_info,
>   			"unknown pending changes left 0x%lx, ignoring", prev);
>   }
> +
> +int __init btrfs_transaction_init(void)
> +{
> +	btrfs_trans_handle_cachep = kmem_cache_create("btrfs_trans_handle",
> +			sizeof(struct btrfs_trans_handle), 0,
> +			SLAB_TEMPORARY | SLAB_MEM_SPREAD, NULL);
> +	if (!btrfs_trans_handle_cachep)
> +		return -ENOMEM;
> +	return 0;
> +}
> +
> +void __cold btrfs_transaction_exit(void)
> +{
> +	kmem_cache_destroy(btrfs_trans_handle_cachep);
> +}
> diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
> index 970ff316069d..b5651c372946 100644
> --- a/fs/btrfs/transaction.h
> +++ b/fs/btrfs/transaction.h
> @@ -236,4 +236,6 @@ void btrfs_add_dropped_root(struct btrfs_trans_handle *trans,
>   			    struct btrfs_root *root);
>   void btrfs_trans_release_chunk_metadata(struct btrfs_trans_handle *trans);
>   
> +int __init btrfs_transaction_init(void);
> +void __cold btrfs_transaction_exit(void);
>   #endif
