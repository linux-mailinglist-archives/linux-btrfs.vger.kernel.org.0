Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8805E574F
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Sep 2022 02:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiIVA21 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Sep 2022 20:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiIVA2Z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Sep 2022 20:28:25 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140080.outbound.protection.outlook.com [40.107.14.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA483A9279
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Sep 2022 17:28:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aDjLzKmYYPwt9iruDjkGnMqkVP8VZJbATvXHAqF55x7q2OCFXLgbYQ4Bew9CuQBnV/wh6wXMtreNfRomGPEcFspA0Z0SKCHWGkw/LZsuY5L/8T7hLCJXsxVv75IF/wRuM4lRQKlZWiRaCEiVW8c4+pn8vchJgxTHPmZSFcIGybGwaP1vcnKRSwQCxrGmPczL02NwNtBZWf8hdeFstW6BzMo6Re7edyyoeCP4pvI9y7YbWMMwlbCWb5xlpBIHCHid41aPwYZKUPYLgpG63PjjeLT7fPSy6ZgXK1fZBNFamXC/CNYnVNdbVEux6x7tb/FLAclL4RBajuA97UEk7H+5pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fsh0HfEjfKuYzSMHOx3t/kpO5F961J0mWxnsxpUm/Q=;
 b=CrCzsl2sVcEPY910yW9zmBU8XMq1QW0KbNr6gIvu8jwd5w+8bUtmp5QUCypHg2dgMmjTq1xU2AEIjT39ROAf3uxnbI6XZAHMssqqTNJ/UZeEO+g1Ul4ShcWg8Lpgi53FeGEFPqb4ozpCDi2peuw5YFYtUiVuZtyGvFD3yquWpvvLLq9ojWuEjOx1q+LNdLbCkfWCfaKekmTGIYsNVRAPPxyXovIO1UYj9VhsZs5fi8rWyGYyl/FrRerYc7+dRf3k5XOwgwuCU2mBtGn07CRjiwzPxLolRx7ypj9FJ8eH9YeO7oyxb3X8Ngy/M7gemgu+l6N4Kc47t75i+2kLBOVOAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fsh0HfEjfKuYzSMHOx3t/kpO5F961J0mWxnsxpUm/Q=;
 b=bu3ktcphkxqgV8yJIi9F0wSnwLDXUW3AhyQIdf7hhqfrddqSp6Bfo7gFF1Grbv+hQ50n6NYbmxRgDwE+SbDMCIwwWwXRgiK2bXlWcBGMKYdGemELqSzMIsKQzNn4jbGFDhEl+4Q95LcQXwrppoJ5piq8s+8Xw6C9dEAPOwOZa6O6rcov3Td51/qO8pxM0NkUEZcH/mOQMqnJnQJpAPsg8s163FpZRRtUWePhkCSQZ1V5USlEFImJaeMLSW2Uk4jiDgxQRY7LLBnO6dRvZt7syZw5fL8LcktYmbkfg3faX7/bVfVvJ7hIz9N9YnuGJFCZVqPJhJRxbxgFQa9pwUp4sQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB8478.eurprd04.prod.outlook.com (2603:10a6:10:2c4::13)
 by VE1PR04MB7424.eurprd04.prod.outlook.com (2603:10a6:800:1a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18; Thu, 22 Sep
 2022 00:28:20 +0000
Received: from DB9PR04MB8478.eurprd04.prod.outlook.com
 ([fe80::5913:2f6a:33a4:1968]) by DB9PR04MB8478.eurprd04.prod.outlook.com
 ([fe80::5913:2f6a:33a4:1968%7]) with mapi id 15.20.5654.018; Thu, 22 Sep 2022
 00:28:20 +0000
Message-ID: <453cad9e-6360-1408-166e-ee8af458ca27@suse.com>
Date:   Thu, 22 Sep 2022 08:28:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 06/16] btrfs: extract mount options and features init code
 into its own init helper
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <cover.1663804335.git.wqu@suse.com>
 <fb43f9f53955660e0d930828ca2a46db2acf935f.1663804335.git.wqu@suse.com>
In-Reply-To: <fb43f9f53955660e0d930828ca2a46db2acf935f.1663804335.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0063.namprd17.prod.outlook.com
 (2603:10b6:a03:167::40) To DB9PR04MB8478.eurprd04.prod.outlook.com
 (2603:10a6:10:2c4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8478:EE_|VE1PR04MB7424:EE_
X-MS-Office365-Filtering-Correlation-Id: 39a9d030-595b-44fb-6c50-08da9c315816
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CWa3iA9jCOmnaoHbe6c/eWUe6ADlpEP6XNidhzsHuje1AkxBkWqI1HG8M3rnkvp7oywmFZrhPJh6PQ67H2B57RzYPnxMT6m2iPedJHibERfU8Vu39KGfUK1ywFYks+UIjRbw9bGXHf23yHMygNSlsKAr9i5HNwRNiZLl24qxftq8OQLF/H0+nIZTJAlYz5s20+fzBKhLhN+09fk/217biuCfTUp97R/JMNLVHsGmln9dv9sGWo1kaBxGdrKaZ0gCOanIhjAzyP7yRIU5jlnqd69Ew8faDIubhbBxx1qt0r99eKcX+7JHTVbnoU8Z/YE3kvfvVVuWu1bJrqQmbDM+xxbqK1nNC1A++JAdfVUlxp16Hr+AMr6KVhVfc+OOu38OsRHvQTcxq98wdsqGdg9/hKO+0u0IMxyKDCva1E/aIjgyh2xG8iHEECH70ql5VOMmHlP7vNIGnJXsqJe9z/SUHcxA1zDCTbBBDoSGCVdpHrGbyhZrC6s8LO1IvCfQler84JPLuYjVLNpsyZ1FIk9hH4nJ6FG4n+JKJ+KtGayMty6l/J/CpdE1JpCT13PpJyC+uchPd3ItZBLq/Po2NVJCoeuIi7v11ye93tJxvr9F0G+Y65eoY927ftTLH436lYU86DliOOOKhxhhqgXxwVAmPb3IF11VbrVl4S5I3Euj/suyQSDPMcQnLEOsWxXLTvgakzaKyCicnUmSzTthp8RSQtVoX7A5VBiEy9zVxm0R3nFxx2inJkLTgjlXtLvhRVNfN8cxB0ThxPunXybY55YsA3DItnEs1jLb4ayu0t54u1o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8478.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199015)(30864003)(36756003)(6506007)(53546011)(6512007)(41300700001)(86362001)(31696002)(316002)(6916009)(8676002)(6666004)(6486002)(66556008)(66476007)(478600001)(66946007)(83380400001)(31686004)(8936002)(2616005)(186003)(2906002)(5660300002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUIvcW1BVWNCQ2VPKzc2VklBd2I3UlNsUGl2MzZFNE9wRlV2S1JXS2RpUzBB?=
 =?utf-8?B?TWUweVYxOFh1MFNvYVlqaHhYbGY2NUEzSnhEN28wY3ZjSU1VeHl1azJBMEo2?=
 =?utf-8?B?VVhpK3hiTWdqS1laQ0liV2NLNmljMU0zTTFMcU4wakJaTjIwd3pGck1nczk3?=
 =?utf-8?B?SzRoOExtWGxzZ3dseE1odms4Y2o5cUd5Y3c5ZDNFaWV3RmZjd1dsQjc2QTBh?=
 =?utf-8?B?THZmdXU0QkF5QnBqd0NzdGtUaDJRakxtV0FIM0pCeVREQ1JKTmRkN2Fab1RN?=
 =?utf-8?B?c0R3TEZPRjRDVWZLUTVqbVFmRUNRN0xNV3lRL0xSSmllSjM4U2gyakxsbW41?=
 =?utf-8?B?YzlNQkxZMjhFVjY5V2NXZmJWWWtvUFBhN0orNjJ3Zi9BNEFsYmhxZ24vZkZh?=
 =?utf-8?B?eVJ1OUZRUjIvalFvblQzbHFWMmhpZ0NWaUtUa3VKVkdKOHhVRWJzTmFoM1Jn?=
 =?utf-8?B?cDV4MlFWQk5SV0R4TVMwWUJBdXlEK3p3YldwYjV4cjA3Umk1N3BOSDQ5c3Vw?=
 =?utf-8?B?RVQwVmR2aTl1Q3g0VmZ0ZDV6NW1QanZlUFZxL2NjTUN5SENTVkhKc1RFTHNh?=
 =?utf-8?B?Ylg2ZEJwRms2U1ZLMlJ5eE1uYlpEQWFrWExJWG5hYmxiUEpkVmpFSWY1NytS?=
 =?utf-8?B?OWZOSElUaXNwbVZxdVZINUxON2N5V2EzLzJOSzE2NDJmRUF4UkNNQUpPUk1C?=
 =?utf-8?B?cmovY3JrekRKNmhlMFVCNTBkYXB2MHhncFNuWDRhSzNBNnRQTG14SkJra2l6?=
 =?utf-8?B?WHFMeENIRzNnblhCREVzenVkNTVVWU9FMTFYK2twbk1uakl2MVJvY1BuQ3dt?=
 =?utf-8?B?dVd0TXB2dkx1cFRpa2MrVTNKUlFuQU1TV2kzS20yWnIzcGQvQnVxMXFpQ1N0?=
 =?utf-8?B?dGxKRHpoYytTR05GZkhvaXU3R1RKYU5tYUROSmhmVUgrNHo5NWJJN2wwU05a?=
 =?utf-8?B?Yjlwb1R5bWFER3EyMkJhOTZyQjUzU2lMWm1DbzFSZDdUN3hDUFBtRHgxL3V2?=
 =?utf-8?B?UFQwWktQUElCZ0lyVzRvMDZZUU8vL0pGUGl6a0lFS0VZdzkrREl6WG9tUXRL?=
 =?utf-8?B?MzJPNGsxRDI5djkrMkYyWVBjejVsQUpPamZrOVFhV2ZBYUZSczZpK21KQ3Rs?=
 =?utf-8?B?SHJtSWFibU9abFllYW5IcGpiZlJQYXl2aW5QcmcwQWV6UGpvZTI0WTRhbFd3?=
 =?utf-8?B?akd0VnVnSmhHRjcvTlBoZDAyc0d3SEJrNDc4SlY3NWNrckloSW5nVmhja2Uy?=
 =?utf-8?B?ZnRYK0lzOUMrak1mRGpBdUN3bzlDNlNPOXZsN0NQVHZBdVQwQUZTdEI0c2t4?=
 =?utf-8?B?aFAvbXFEWlBpTktkWjgyajloVU91bjUzM3VjWmwyM3FGZ0xQNm5xM3gvQ1cv?=
 =?utf-8?B?bVJjemxwZ1kzZGhQZDl3S3N0THhDZG1MZkZHRFUzVGt6M3VxSkFEckVCNGN4?=
 =?utf-8?B?MXJCcjZHa0kwODUvSGl6WjY3MlRYUENPcDExYytvaTVpRzlVSDY4VDlTczhW?=
 =?utf-8?B?Ukw1YSswNHovZ0EzeHhuTjl2V1UrcWRkdGN0VkFTK1ZlaE1pcDRLbEttUStt?=
 =?utf-8?B?QlNCeTAvYUMwc0ZCUDlDazVsZTFiSk5DTHRJcDdKbVF5NElobnY0R3BCM2FY?=
 =?utf-8?B?RGMxY244OEJ6c1NROHQ2RWh2em9rK3dKTDNmT2hPOURKTzAwQ2FSY2E1a2N0?=
 =?utf-8?B?WGJDM3JvVjIwcXpXU00rS1NxUlRISFlWSnpnc09zSVIvVE90VmxCMnZwV0lM?=
 =?utf-8?B?MUluSzVaeE9XRjV6Ykh6bkFoWVRCMlFadlJPNm9CbGo0ODByUnhuUjRLdjdO?=
 =?utf-8?B?V25JOWtKNXRYeG9IWGx2T2F6VS9rRWJINno5WXMzQmVSTnRxWHhLZ0pWSExY?=
 =?utf-8?B?MlFTTGo4VHljZTMyMzI5N1p4NEwwdmxRUXAxYWJOWDJESm1FZFJUcjUrelQ2?=
 =?utf-8?B?Z1VaVFdUWjVvTUxVVjVsOTdKVHdLa2t2OWlxbEVGcWQvTXZzOFRLQ1I1M08r?=
 =?utf-8?B?elJIa1RCRnM1dmN0eE9OTmpmM2FlR0p5SStqdnFlaVZtaURFUlFZbmNpU0c0?=
 =?utf-8?B?RHAzbHMzVFNHRjg5MUs0cXZXNEJEOHVFNkw3eEFhank2cE01K2VZaXYrYlF0?=
 =?utf-8?B?dnBjOHhHTm9TWExTWW1wSEtkUENqQytybFdvK205ZFRHb1hhaDY1dzZrMHpk?=
 =?utf-8?Q?h8X/IpTpiY1gkT9pM1YyjzA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a9d030-595b-44fb-6c50-08da9c315816
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8478.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 00:28:19.9675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PiZck4atwL8hwcUQgs1JWXMS43kpANvv7OqK8iaau1Pa3DRyuRZdi5ISRgZc4SLI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7424
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/22 08:06, Qu Wenruo wrote:
> This patch will extract the mount option parsing and features checking
> code into a new helper, open_ctree_features_init().
> 
> This extraction also did the following non-functional change:
> 
> - Add btrfs_fs_info::__options member
>    Currently the open_ctree_* helpers can only accept a single @fs_info
>    parameter, to parse the mount options we have to use a temporary
>    pointer for this purpose.
> 
>    Thankfully we don't need to do anything like freeing it.
> 
> - Move ssd optimization check into open_ctree_features_init()
> 
> - Move check_int related code into open_ctree_features_init()
>    The mount time integrity check doesn't rely on any tree blocks, thus
>    is safe to be called at feature init time.
> 
> - Separate @features variable into @incompat and @compat_ro
>    So there will be no confusion, and compiler should be clever enough
>    to optimize them out anyway.
> 
> - Properly return error for subpage initialization failure
>    Preivously we just goto fail_alloc label, relying on the default
>    -EINVAL error.
>    Now we can return a proper -ENOMEM error instead.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/ctree.h   |   6 ++
>   fs/btrfs/disk-io.c | 176 +++++++++++++++++++++++----------------------
>   2 files changed, 96 insertions(+), 86 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 8b7b7a212da0..88dc3b2896d7 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -1106,6 +1106,12 @@ struct btrfs_fs_info {
>   	struct lockdep_map btrfs_trans_pending_ordered_map;
>   	struct lockdep_map btrfs_ordered_extent_map;
>   
> +	/*
> +	 * Temporary pointer to the mount option string.
> +	 * This is to workaround the fact that all open_ctree() init
> +	 * functions can only accept a single @fs_info pointer.
> +	 */
> +	char *__options;
>   #ifdef CONFIG_BTRFS_FS_REF_VERIFY
>   	spinlock_t ref_verify_lock;
>   	struct rb_root block_tree;
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index f4c04cb1c0d6..ec9038eeaa0f 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3446,118 +3446,78 @@ static int open_ctree_super_init(struct btrfs_fs_info *fs_info)
>   	return ret;
>   }
>   
> -struct init_sequence {
> -	int (*init_func)(struct btrfs_fs_info *fs_info);
> -	void (*exit_func)(struct btrfs_fs_info *fs_info);
> -};
> -
> -static const struct init_sequence open_ctree_seq[] = {
> -	{
> -		.init_func = open_ctree_btree_inode_init,
> -		.exit_func = open_ctree_btree_inode_exit,
> -	}, {
> -		.init_func = open_ctree_super_init,
> -		.exit_func = NULL,
> -	}
> -};
> -
> -
> -int __cold open_ctree(struct super_block *sb, char *options)
> +static int open_ctree_features_init(struct btrfs_fs_info *fs_info)
>   {
> -	u64 generation;
> -	u64 features;
> -	bool open_ctree_res[ARRAY_SIZE(open_ctree_seq)] = {0};
> -	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
> -	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
>   	int ret;
> -	int err = -EINVAL;
> -	int level;
> -	int i;
> -
> -	fs_info->sb = sb;
> -
> -	/* Caller should have already initialized fs_info->fs_devices. */
> -	ASSERT(fs_info->fs_devices);
> -
> -	for (i = 0; i < ARRAY_SIZE(open_ctree_seq); i++) {
> -		ret = open_ctree_seq[i].init_func(fs_info);
> -		if (ret < 0)
> -			goto fail;
> -		open_ctree_res[i] = true;
> -	}
> +	u64 incompat;
> +	u64 compat_ro;
>   
> -	ret = btrfs_parse_options(fs_info, options, fs_info->sb->s_flags);
> -	if (ret) {
> -		err = ret;
> -		goto fail_alloc;
> -	}
> +	ret = btrfs_parse_options(fs_info, fs_info->__options,
> +				  fs_info->sb->s_flags);
> +	if (ret)
> +		return ret;
>   
> -	features = btrfs_super_incompat_flags(fs_info->super_copy) &
> -		~BTRFS_FEATURE_INCOMPAT_SUPP;
> -	if (features) {
> +	incompat = btrfs_super_incompat_flags(fs_info->super_copy);
> +	if (incompat & ~BTRFS_FEATURE_INCOMPAT_SUPP) {
>   		btrfs_err(fs_info,
>   		    "cannot mount because of unsupported optional features (0x%llx)",
> -		    features);
> -		err = -EINVAL;
> -		goto fail_alloc;
> +		    incompat & ~BTRFS_FEATURE_INCOMPAT_SUPP);
> +		return -EINVAL;
>   	}
>   
> -	features = btrfs_super_incompat_flags(fs_info->super_copy);
> -	features |= BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF;
> +	incompat |= BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF;
>   	if (fs_info->compress_type == BTRFS_COMPRESS_LZO)
> -		features |= BTRFS_FEATURE_INCOMPAT_COMPRESS_LZO;
> +		incompat |= BTRFS_FEATURE_INCOMPAT_COMPRESS_LZO;
>   	else if (fs_info->compress_type == BTRFS_COMPRESS_ZSTD)
> -		features |= BTRFS_FEATURE_INCOMPAT_COMPRESS_ZSTD;
> +		incompat |= BTRFS_FEATURE_INCOMPAT_COMPRESS_ZSTD;
>   
>   	/*
>   	 * Flag our filesystem as having big metadata blocks if they are bigger
>   	 * than the page size.
>   	 */
>   	if (btrfs_super_nodesize(fs_info->super_copy) > PAGE_SIZE)
> -		features |= BTRFS_FEATURE_INCOMPAT_BIG_METADATA;
> +		incompat |= BTRFS_FEATURE_INCOMPAT_BIG_METADATA;
>   
>   	/*
>   	 * mixed block groups end up with duplicate but slightly offset
>   	 * extent buffers for the same range.  It leads to corruptions
>   	 */
> -	if ((features & BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS) &&
> +	if ((incompat & BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS) &&
>   	    (fs_info->sectorsize != fs_info->nodesize)) {
>   		btrfs_err(fs_info,
>   "unequal nodesize/sectorsize (%u != %u) are not allowed for mixed block groups",
>   			fs_info->nodesize, fs_info->sectorsize);
> -		goto fail_alloc;
> +		return -EINVAL;
>   	}
>   
>   	/*
>   	 * Needn't use the lock because there is no other task which will
>   	 * update the flag.
>   	 */
> -	btrfs_set_super_incompat_flags(fs_info->super_copy, features);
> +	btrfs_set_super_incompat_flags(fs_info->super_copy, incompat);
>   
> -	features = btrfs_super_compat_ro_flags(fs_info->super_copy) &
> -		~BTRFS_FEATURE_COMPAT_RO_SUPP;
> -	if (!sb_rdonly(fs_info->sb) && features) {
> +	compat_ro = btrfs_super_compat_ro_flags(fs_info->super_copy);
> +	if (!sb_rdonly(fs_info->sb) &&
> +	    (compat_ro & ~BTRFS_FEATURE_COMPAT_RO_SUPP)) {
>   		btrfs_err(fs_info,
>   	"cannot mount read-write because of unsupported optional features (0x%llx)",
> -		       features);
> -		err = -EINVAL;
> -		goto fail_alloc;
> +		       compat_ro & ~BTRFS_FEATURE_COMPAT_RO_SUPP);
> +		return -EINVAL;
>   	}
>   	/*
>   	 * We have unsupported RO compat features, although RO mounted, we
>   	 * should not cause any metadata write, including log replay.
>   	 * Or we could screw up whatever the new feature requires.
>   	 */
> -	if (unlikely(features && btrfs_super_log_root(fs_info->super_copy) &&
> +	if (unlikely((compat_ro & ~BTRFS_FEATURE_COMPAT_RO_SUPP)
> +		     && btrfs_super_log_root(fs_info->super_copy) &&
>   		     !btrfs_test_opt(fs_info, NOLOGREPLAY))) {
>   		btrfs_err(fs_info,
>   "cannot replay dirty log with unsupported compat_ro features (0x%llx), try rescue=nologreplay",
> -			  features);
> -		err = -EINVAL;
> -		goto fail_alloc;
> +			  compat_ro & ~BTRFS_FEATURE_COMPAT_RO_SUPP);
> +		return -EINVAL;
>   	}
>   
> -
>   	if (fs_info->sectorsize < PAGE_SIZE) {
>   		struct btrfs_subpage_info *subpage_info;
>   
> @@ -3577,11 +3537,73 @@ int __cold open_ctree(struct super_block *sb, char *options)
>   			   fs_info->sectorsize, PAGE_SIZE);
>   		subpage_info = kzalloc(sizeof(*subpage_info), GFP_KERNEL);
>   		if (!subpage_info)
> -			goto fail_alloc;
> +			return -ENOMEM;
>   		btrfs_init_subpage_info(subpage_info, fs_info->sectorsize);
>   		fs_info->subpage_info = subpage_info;
>   	}
>   
> +	if (!btrfs_test_opt(fs_info, NOSSD) &&
> +	    !fs_info->fs_devices->rotating)
> +		btrfs_set_and_info(fs_info, SSD, "enabling ssd optimizations");
> +
> +#ifdef CONFIG_BTRFS_FS_CHECK_INTEGRITY
> +	if (btrfs_test_opt(fs_info, CHECK_INTEGRITY)) {

Btrfs/220 would crash at this stage.

> +		ret = btrfsic_mount(fs_info, fs_info->fs_devices,
> +				    btrfs_test_opt(fs_info,
> +					CHECK_INTEGRITY_DATA) ? 1 : 0,
> +				    fs_info->check_integrity_print_mask);

Surprisingly btrfsic_mount() needs to btrfs logical address mapping at 
least, thus it can only be called after chunk tree being initialized.

Would move this into open_ctree_chunk_tree_init() instead.

Thanks,
Qu

> +		if (ret)
> +			btrfs_warn(fs_info,
> +				"failed to initialize integrity check module: %d",
> +				ret);
> +	}
> +#endif
> +
> +	return 0;
> +}
> +
> +struct init_sequence {
> +	int (*init_func)(struct btrfs_fs_info *fs_info);
> +	void (*exit_func)(struct btrfs_fs_info *fs_info);
> +};
> +
> +static const struct init_sequence open_ctree_seq[] = {
> +	{
> +		.init_func = open_ctree_btree_inode_init,
> +		.exit_func = open_ctree_btree_inode_exit,
> +	}, {
> +		.init_func = open_ctree_super_init,
> +		.exit_func = NULL,
> +	}, {
> +		.init_func = open_ctree_features_init,
> +		.exit_func = NULL,
> +	}
> +};
> +
> +int __cold open_ctree(struct super_block *sb, char *options)
> +{
> +	u64 generation;
> +	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
> +	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
> +	bool open_ctree_res[ARRAY_SIZE(open_ctree_seq)] = {0};
> +	int ret;
> +	int err = -EINVAL;
> +	int level;
> +	int i;
> +
> +	fs_info->sb = sb;
> +	fs_info->__options = options;
> +
> +	/* Caller should have already initialized fs_info->fs_devices. */
> +	ASSERT(fs_info->fs_devices);
> +
> +	for (i = 0; i < ARRAY_SIZE(open_ctree_seq); i++) {
> +		ret = open_ctree_seq[i].init_func(fs_info);
> +		if (ret < 0)
> +			goto fail;
> +		open_ctree_res[i] = true;
> +	}
> +
>   	ret = btrfs_init_workqueues(fs_info);
>   	if (ret) {
>   		err = ret;
> @@ -3736,29 +3758,12 @@ int __cold open_ctree(struct super_block *sb, char *options)
>   	if (IS_ERR(fs_info->transaction_kthread))
>   		goto fail_cleaner;
>   
> -	if (!btrfs_test_opt(fs_info, NOSSD) &&
> -	    !fs_info->fs_devices->rotating) {
> -		btrfs_set_and_info(fs_info, SSD, "enabling ssd optimizations");
> -	}
> -
>   	/*
>   	 * Mount does not set all options immediately, we can do it now and do
>   	 * not have to wait for transaction commit
>   	 */
>   	btrfs_apply_pending_changes(fs_info);
>   
> -#ifdef CONFIG_BTRFS_FS_CHECK_INTEGRITY
> -	if (btrfs_test_opt(fs_info, CHECK_INTEGRITY)) {
> -		ret = btrfsic_mount(fs_info, fs_devices,
> -				    btrfs_test_opt(fs_info,
> -					CHECK_INTEGRITY_DATA) ? 1 : 0,
> -				    fs_info->check_integrity_print_mask);
> -		if (ret)
> -			btrfs_warn(fs_info,
> -				"failed to initialize integrity check module: %d",
> -				ret);
> -	}
> -#endif
>   	ret = btrfs_read_qgroup_config(fs_info);
>   	if (ret)
>   		goto fail_trans_kthread;
> @@ -3851,7 +3856,6 @@ int __cold open_ctree(struct super_block *sb, char *options)
>   fail_sb_buffer:
>   	btrfs_stop_all_workers(fs_info);
>   	btrfs_free_block_groups(fs_info);
> -fail_alloc:
>   	btrfs_mapping_tree_free(&fs_info->mapping_tree);
>   fail:
>   	for (i = ARRAY_SIZE(open_ctree_seq) - 1; i >= 0; i--) {
