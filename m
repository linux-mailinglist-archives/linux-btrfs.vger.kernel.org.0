Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E115BF168
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Sep 2022 01:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbiITXmj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Sep 2022 19:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbiITXmT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Sep 2022 19:42:19 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70072.outbound.protection.outlook.com [40.107.7.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29AA50060
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Sep 2022 16:40:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GxjGvCSRp8dWIu1IIAVfjRJ+oei67qngGqTm+R6ikD1sx920mstI5KJ76ljRN7DCPp5JOS6szX/o5Y44xNmz9jjZEm1tIbubRg2WyELMUz5yzlZDoyHMFM/RNRLGgLf1CtgU5tzefKSe6I/Hntg2CxskaEbPl87wETlk5ECeXXLzlW9MuI//FoJWXlpe8FHbo0Bnw5AiYiWDkCJRMYhTXFTmXNW/m2JUykEGXzLRWtrSv0dzg3+R/L/ElGemL5bLzBtDL2H6SKcij/teY6FKLPpcWYPz+Y20x+q07ECq3c+Cp5oproJKdWWkzv+lBrFRXDFAFc0WHUFoB3W4/jVEvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dMA16pxgonpS5tIF8Y7YAa5g+FguX7UxALD+n8iefoE=;
 b=bciGRLHjI65dXhX9siP9RDFHlqIdfuvAJO9mpIbX19vxyo1nSFfsQw0KybzT56Pa0YfBSsV65LJ9QRl/lzJqLc8kxL1ok579r9hb7H7/1z/SK4lOuAR2I3opiN/fpxQQbUsM5XOk6m3im1nKFhtDr3s8pVTbrWSG1xQp83dPzuRt3SauSELF82v85uCqwXoYOhqF1ENpNOCmv9b+jY4TcBj1eHedAP1uvqrrxGPYKF2LZ6pBeP7pjXkGxk6osKufqdPebwz44wCdCQBHJtqUiz5E9rwD7nJakmCsO5aoZXhi53My75TQjSzxldgyGUm818YgwswpXsHBOsF0TZ5pgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMA16pxgonpS5tIF8Y7YAa5g+FguX7UxALD+n8iefoE=;
 b=V8tVaj9NjO/Fghs8p20PzorvQCcr5Bn5mmhskHVOXaZiYZI9SUnAPMWPZfT9ZTY8chmJnvNC7PQxhGulw0axSmmRYhiroRQSouwBesUblF3I54T8jOwWV4kZo/bWMPof8AvcOH/5j/8U+WDqOEF15sBbJCf8kucsYEx+ieKkSxnCLTllPPzcDtNL1pBvR3C7bQHdgHmvo6lWpgr2C7jmawQf2+j5XLl7bQIUII7EsLxPSPe2FiyC764v2GjaPV818ZHqkZ4NmHzk0Wk6G1mcJNL99lvzjqn+ElkqBZFB8OxAHoLScmWLTmP1VxtQ/M2Lg+2KYYpG/GLDNdy7Zy0d6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DU0PR04MB9444.eurprd04.prod.outlook.com (2603:10a6:10:35c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Tue, 20 Sep
 2022 23:40:28 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::3a32:8047:8c8a:85d9]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::3a32:8047:8c8a:85d9%6]) with mapi id 15.20.5654.016; Tue, 20 Sep 2022
 23:40:28 +0000
Message-ID: <b56c2284-4702-2d61-4b73-f68c21b73b70@suse.com>
Date:   Wed, 21 Sep 2022 07:40:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] btrfs: loosen the block-group-tree feature dependency
 check
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.cz>
References: <d43e26ecf12268e8bc75986052cc6021a096db74.1662961395.git.wqu@suse.com>
Content-Language: en-US
In-Reply-To: <d43e26ecf12268e8bc75986052cc6021a096db74.1662961395.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0097.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::12) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|DU0PR04MB9444:EE_
X-MS-Office365-Filtering-Correlation-Id: e597a325-d68d-4c75-6f53-08da9b617f67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ozF5YfU4JQ2D/gVyQWxzSpJBFS2Lo3r4UzPaS263aqbGXCusy5eK+hQISxuC8+TJfsBVsYrnOc1+Yu4hdhM2B5Ek2OZTN0151WxgCGcAP+OWwLzHvuFK3b1b04pYKGOsyuqbjvr56zvrfaVHA+P0GXEk0CfMW6yVsVc2jTdgRbr6spMMD/UAqSy2K//FCM+zXH7hVf4HoTqSZuqkWjj66OcMuKIoFbDf+7SPlaSRsPKiA9No3U2n307EaDjYuALvtIpTAMQZOBqWiN6vBIIIgPYT1UTVCgRe84L2RKL2WzehWqTQzjs3A3HGyAg8hpytje8AOHEXJdBOm/kiNV1+YSrVOnBiiv+9RVXfol7+/qQQ1JUDSm4oV5eg1ZGCktEG69AkPR9P4fyVmRijz7mYjrnYKaIsu0dUSP6TFCKSumhvKzOm+VIwE3zG7Frd8CptO4eJbNS6BgtzWwRXxwFhuW5ABIx72FbG9NY56b3gxUy+GbVmlh/IoXA7JBgSIHhnHUuDSjdHP891Qr2yGCSa9YJbP0g/NB1c6SAxjKXM0FZ9WPDMUsTDKwRYtR2id27eNF78nIGQvvMaCLoh2cFxSA8jhMEWig0Q3k0TdRhzb7gnx5TR4PpFLUqqen7OKUK19tLAnylvt3ydBXbNK4Dn4c9pccUEzzZ2ISyoOfhnwBxozbvgqh+MYw2XfnOlGwHVlysL4noSyj0lr9Xcdri66NdEyaiuw26TFbz/ej63pZopK1ckSY8DYC9Mw+ioXfC2hHgJgxxQpYRnYXD0kiuXss7SdW6EEDrDelMod6UztJc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(376002)(39860400002)(396003)(366004)(451199015)(316002)(83380400001)(8676002)(36756003)(66946007)(2906002)(66476007)(66556008)(86362001)(31696002)(38100700002)(30864003)(478600001)(6486002)(31686004)(53546011)(6512007)(186003)(2616005)(6916009)(8936002)(5660300002)(41300700001)(6666004)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEREWkZEc0ZQZ0t0b1FBM3g1NFpKM2QzWjc0R01xaVFENUpSMDI2TlZnT0dh?=
 =?utf-8?B?M1ZPN1UrNGNwL0xlbnQ2czA0Zm1xeFFMRzhvZDFHN2VyWVRDU0V4QlFuZUFF?=
 =?utf-8?B?Y2xVOGNudVRyeFpMUlZvb1dObzlpQWh1MGZ1dnlvZGxwdlJhU1lBbTI4MkIv?=
 =?utf-8?B?S3JBWFNFRXYzMkNNb1NSZUFMVzR6MGNnZmEva0NnTmNaZytiYXVJRjNjaWZw?=
 =?utf-8?B?WUtmNDYwb2EwMjl3R25mblllaXZ4d3pmeGtBQ0p0SGlhQ1luWFpYUndmNnVX?=
 =?utf-8?B?UzN3dk9zQ242bHJiLzE4d0xrS0V5dVZRSXBTVWw2YkF4N3JaUDRjVkpxcXVC?=
 =?utf-8?B?OXBTSVd5QVYxQ3B2L3dHRG1WQ3Vnejk3SkZTNWhFa0x1ZG5ocVpEY2NmUnB1?=
 =?utf-8?B?S1ZUUjZEc0VqNTJPK1ZTKzRrQzR4Vm1yako3K1RnSDVzMnZicDNNS2hGY3A3?=
 =?utf-8?B?ZnU3MDhMYzRBY2ZLUlhkd2prQkZZMncyNmRrU09CL0lmc1lnL0E3MCsva0hn?=
 =?utf-8?B?U2kvaHFJbFpIbGtwblVXYjFxT1d3K3JrQW5aaGx1cFdQSmQzaVZpMFBRTkxw?=
 =?utf-8?B?MHNkU29Hb2NYL25ScXpWZXdQZzFSK1BzY1Z5TEhEYkNFQjhOR2llYlJ5YW9y?=
 =?utf-8?B?R0NMclpZUk8rRmFVY3ZkSzg1bUVjTFJDTUpwTlNmVjdBRUxyeERla2JyT2ZE?=
 =?utf-8?B?a21oajlYUFBjZHVNVVIyTVhJdlBObjloT1RQLy8rUGxSUE9UMkxPYXA3czkw?=
 =?utf-8?B?Z2ljdjNua0lPRXdiWXN0VDN3eDRZRmxzSlFQN056T3VKQkcrQWc5SVFpZ2tT?=
 =?utf-8?B?Qk4xdCtXYk1RTGhadDR1TndXSENXc3dLbEFPTm5uMnBhZzVDUzNNc2ltaEFE?=
 =?utf-8?B?bUtwU212Uk1sMGhLb3k4a0FMdVpyWThDVUNVdzZaVThtcTBzSEorZUNSRkZj?=
 =?utf-8?B?TU9vYkZtT2JPVGt3S0YraWdNTkEvYWtVektHZy9sWlMyQVM5WDE0R2RSVXVN?=
 =?utf-8?B?dWh6MlFrQVJxMzFoZzE5eE5OREowWVUvM3UyWUxPQ2txTitSYVN2U0JQMThn?=
 =?utf-8?B?c0hZYnRKUm9Cdnp4SEdOTTZvSnpjWUpYZmpyUUJVczVuQklqd0pnSEpuUzNa?=
 =?utf-8?B?UnB5dVoxRk9OOWNZTzRnRlRGb2FUbllidkorcnJTTXYrTmI5M3N2WTd2bjV5?=
 =?utf-8?B?dFBtWTk1cWFzang0NUZXZU9FTXdNTnNkTGtOWCtuZXFsSTdycmxBNGYxaGN3?=
 =?utf-8?B?TXV6dm9TRVF5NGdraWhWVEJkaWRRU3cwYkg5TlFaOXRQSGJBd2ZERUMrazA1?=
 =?utf-8?B?WGJvSndyOXFSOEtuQnFlSUx0ZWxEWHlsTHpnN3pKdWtOVUwrcWR6OThSelM5?=
 =?utf-8?B?T0VjSHUwMm1Td2ZHc0NFNWZhbG1zOWJoTDBVYnBMTHFMMU1MNWY2cktCQjFD?=
 =?utf-8?B?dGdocndFbURCd2VLSzQwUEc2eUlUaXpLRWQ2bnJDUm9ySnVycDFjT2ZVZ3hM?=
 =?utf-8?B?N0FDczBpczZaUlJNMFZkQjl1TWVqRGMvZHBObXNMSjJGanJSQnVTUENydVJP?=
 =?utf-8?B?aGVmUHJJQTZRL3BKVUNzaC9JaFNPcVA5MkNtUUdOTzAyaUdGU1hLZ2crWHg1?=
 =?utf-8?B?WGw4L1JsQWJmMzdLTFZ6aHhEeGU1M21BWlNRWGVvaG5NVTJMUEVtQnBqZUJj?=
 =?utf-8?B?UU14V1JRU0xMRFJCYVI4eVAvNDQ0d21hZjY5TnlKbHUzK0FUUzRONCtJMm1r?=
 =?utf-8?B?VHhPQ0xNdkdIeGFPTnJXa2R2T3ErbU9VZ2JPSHllYjdhWHdLcFJBSC9pYWhs?=
 =?utf-8?B?cUdaMGRXNzdCazhlcUtpbWZOY1FhQi9KekI0ZmM2aTFZNmV3SEZlb3h3SFZG?=
 =?utf-8?B?Z2tEWnlkellLcThnKzNLSXRNOXRjQzNLYTdUS3pkQmRKU0pEckpDNW5ONlVr?=
 =?utf-8?B?TW95Y1UxRitnY1BPaEJUUzV6SDZzdnVpMkE0bU1KbHczVkdZUUg0aHF4THVO?=
 =?utf-8?B?N3RVWDEvRXVnOFg2NjlLRGE0b1F2cEhGbXZJdXJuYkp1MHRnN1dtZnloUDkr?=
 =?utf-8?B?Sk5zRng1UjRjTWFNbUo2ZzhUZjYzWTBwdDdPWXNpcnFwaU93QlRCMDdySkpm?=
 =?utf-8?B?R01BUm5YTWN5eTBRcG81VkFXdFlacElZV290Wm8zQ3Ava0hIYVZWNVNCbEt3?=
 =?utf-8?Q?AAO+2CBchleWOPQOq5JHlNk=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e597a325-d68d-4c75-6f53-08da9b617f67
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 23:40:28.3276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +VLtjTJIxM8Udem8JeOHvw8q+RdJEeJ5b7fyNMp4EOKMFiMUvURasL3hQFZWwulb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9444
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/12 13:44, Qu Wenruo wrote:
> [BUG]
> When one user did a wrong try to clear block group tree, which can not
> be done through mount option, by using "-o clear_cache,space_cache=v2",
> it will cause the following error on a fs with block-group-tree feature:
> 
>   BTRFS info (device dm-1): force clearing of disk cache
>   BTRFS info (device dm-1): using free space tree
>   BTRFS info (device dm-1): clearing free space tree
>   BTRFS info (device dm-1): clearing compat-ro feature flag for FREE_SPACE_TREE (0x1)
>   BTRFS info (device dm-1): clearing compat-ro feature flag for FREE_SPACE_TREE_VALID (0x2)
>   BTRFS error (device dm-1): block-group-tree feature requires fres-space-tree and no-holes
>   BTRFS error (device dm-1): super block corruption detected before writing it to disk
>   BTRFS: error (device dm-1) in write_all_supers:4318: errno=-117 Filesystem corrupted (unexpected superblock corruption detected)
>   BTRFS warning (device dm-1: state E): Skipping commit of aborted transaction.
> 
> [CAUSE]
> Although the dependency for block-group-tree feature is just an
> artificial one (to reduce test matrix), we put the dependency check into
> btrfs_validate_super().
> 
> This is too strict, and during space cache clearing, we will have a
> window where free space tree is cleared, and we need to commit the super
> block.
> 
> In that window, we had block group tree without v2 cache, and triggered
> the artificial dependency check.
> 
> This is not necessary at all, especially for such a soft dependency.
> 
> [FIX]
> Introduce a new helper, btrfs_check_features(), to do all the runtime
> limitation checks, including:
> 
> - Unsupported incompat flags check
> 
> - Unsupported compat RO flags check
> 
> - Setting missing incompat flags
> 
> - Aritifical feature dependency checks
>    Currently only block group tree will rely on this.
> 
> - Subpage runtime check for v1 cache
> 
> With this helper, we can move quite some checks from
> open_ctree()/btrfs_remount() into it, and just call it after
> btrfs_parse_options().
> 
> Now "-o clear_cache,space_cache=v2" will not trigger above error
> anymore.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Any feedback? I really hope this patch can be merged before we expose 
the kernel support for block group tree.

Or clear_space_cache mount option can easily flip the fs to RO.

Thanks,
Qu
> ---
>   fs/btrfs/disk-io.c | 174 +++++++++++++++++++++++++++++----------------
>   fs/btrfs/disk-io.h |   1 +
>   fs/btrfs/super.c   |  19 +----
>   3 files changed, 115 insertions(+), 79 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 54b5784a59e5..d50df66d6ce9 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3292,6 +3292,114 @@ int btrfs_start_pre_rw_mount(struct btrfs_fs_info *fs_info)
>   	return ret;
>   }
>   
> +/*
> + * Do various sanity and dependency checks on different features.
> + *
> + * This is the place for less strict checks (like for subpage or artificial
> + * feature dependency).
> + *
> + * For strict checks or possible corruption detection, they should go
> + * btrfs_validate_super().
> + *
> + * This function also should be called after btrfs_parse_option(), as some
> + * mount option (space_cache related) can modify on-disk format like free
> + * space tree and screw up certain feature dependency.
> + */
> +int btrfs_check_features(struct btrfs_fs_info *fs_info, struct super_block *sb)
> +{
> +	struct btrfs_super_block *disk_super = fs_info->super_copy;
> +	u64 incompat = btrfs_super_incompat_flags(disk_super);
> +	u64 compat_ro = btrfs_super_compat_ro_flags(disk_super);
> +
> +	if (incompat & ~BTRFS_FEATURE_INCOMPAT_SUPP) {
> +		btrfs_err(fs_info,
> +		    "cannot mount because of unsupported optional features (0x%llx)",
> +		    incompat);
> +		return -EINVAL;
> +	}
> +
> +	/* Runtime limitation for mixed block groups. */
> +	if ((incompat & BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS) &&
> +	    (fs_info->sectorsize != fs_info->nodesize)) {
> +		btrfs_err(fs_info,
> +"unequal nodesize/sectorsize (%u != %u) are not allowed for mixed block groups",
> +			fs_info->nodesize, fs_info->sectorsize);
> +		return -EINVAL;
> +	}
> +
> +	/* Mixed backref is an always-enabled feature. */
> +	incompat |= BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF;
> +
> +	/* Set compression related flags just in case. */
> +	if (fs_info->compress_type == BTRFS_COMPRESS_LZO)
> +		incompat |= BTRFS_FEATURE_INCOMPAT_COMPRESS_LZO;
> +	else if (fs_info->compress_type == BTRFS_COMPRESS_ZSTD)
> +		incompat |= BTRFS_FEATURE_INCOMPAT_COMPRESS_ZSTD;
> +
> +	/*
> +	 * An ancient flag, which should really be marked deprecated.
> +	 * Such runtime limitation doesn't really need a incompat flag.
> +	 */
> +	if (btrfs_super_nodesize(disk_super) > PAGE_SIZE)
> +		incompat |= BTRFS_FEATURE_INCOMPAT_BIG_METADATA;
> +
> +	if (compat_ro & ~BTRFS_FEATURE_COMPAT_RO_SUPP && !sb_rdonly(sb)) {
> +		btrfs_err(fs_info,
> +	"cannot mount read-write because of unsupported optional features (0x%llx)",
> +		       compat_ro);
> +		return -EINVAL;
> +	}
> +	/*
> +	 * We have unsupported RO compat features, although RO mounted, we
> +	 * should not cause any metadata write, including log replay.
> +	 * Or we could screw up whatever the new feature requires.
> +	 */
> +	if (unlikely(compat_ro && btrfs_super_log_root(disk_super) &&
> +		     !btrfs_test_opt(fs_info, NOLOGREPLAY))) {
> +		btrfs_err(fs_info,
> +"cannot replay dirty log with unsupported compat_ro features (0x%llx), try rescue=nologreplay",
> +			  compat_ro);
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Artificial limitations for block group tree, to force
> +	 * block-group-tree to rely on no-holes and free-space-tree.
> +	 * Mostly to reduce test matrix.
> +	 */
> +	if (btrfs_fs_compat_ro(fs_info, BLOCK_GROUP_TREE) &&
> +	    (!btrfs_fs_incompat(fs_info, NO_HOLES) ||
> +	     !btrfs_test_opt(fs_info, FREE_SPACE_TREE))) {
> +		btrfs_err(fs_info,
> +"block-group-tree feature requires no-holes and free-space-tree features");
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Subpage runtime limitation on v1 cache.
> +	 *
> +	 * V1 space cache still has some hard code PAGE_SIZE usage, while
> +	 * we're already defaulting to v2 cache, no need to bother
> +	 * v1 as it's going to be deprecated anyway.
> +	 */
> +	if (fs_info->sectorsize < PAGE_SIZE &&
> +	    btrfs_test_opt(fs_info, SPACE_CACHE)) {
> +		btrfs_warn(fs_info,
> +	"v1 space cache is not supported for page size %lu with sectorsize %u",
> +			   PAGE_SIZE, fs_info->sectorsize);
> +		return -EINVAL;
> +	}
> +	/*
> +	 * This function can be called by remount, thus we need spinlock to
> +	 * protect the super block.
> +	 */
> +	spin_lock(&fs_info->super_lock);
> +	btrfs_set_super_incompat_flags(disk_super, incompat);
> +	spin_unlock(&fs_info->super_lock);
> +
> +	return 0;
> +}
> +
>   int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_devices,
>   		      char *options)
>   {
> @@ -3441,72 +3549,12 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>   		goto fail_alloc;
>   	}
>   
> -	features = btrfs_super_incompat_flags(disk_super) &
> -		~BTRFS_FEATURE_INCOMPAT_SUPP;
> -	if (features) {
> -		btrfs_err(fs_info,
> -		    "cannot mount because of unsupported optional features (0x%llx)",
> -		    features);
> -		err = -EINVAL;
> -		goto fail_alloc;
> -	}
> -
> -	features = btrfs_super_incompat_flags(disk_super);
> -	features |= BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF;
> -	if (fs_info->compress_type == BTRFS_COMPRESS_LZO)
> -		features |= BTRFS_FEATURE_INCOMPAT_COMPRESS_LZO;
> -	else if (fs_info->compress_type == BTRFS_COMPRESS_ZSTD)
> -		features |= BTRFS_FEATURE_INCOMPAT_COMPRESS_ZSTD;
> -
> -	/*
> -	 * Flag our filesystem as having big metadata blocks if they are bigger
> -	 * than the page size.
> -	 */
> -	if (btrfs_super_nodesize(disk_super) > PAGE_SIZE)
> -		features |= BTRFS_FEATURE_INCOMPAT_BIG_METADATA;
> -
> -	/*
> -	 * mixed block groups end up with duplicate but slightly offset
> -	 * extent buffers for the same range.  It leads to corruptions
> -	 */
> -	if ((features & BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS) &&
> -	    (sectorsize != nodesize)) {
> -		btrfs_err(fs_info,
> -"unequal nodesize/sectorsize (%u != %u) are not allowed for mixed block groups",
> -			nodesize, sectorsize);
> -		goto fail_alloc;
> -	}
> -
> -	/*
> -	 * Needn't use the lock because there is no other task which will
> -	 * update the flag.
> -	 */
> -	btrfs_set_super_incompat_flags(disk_super, features);
> -
> -	features = btrfs_super_compat_ro_flags(disk_super) &
> -		~BTRFS_FEATURE_COMPAT_RO_SUPP;
> -	if (!sb_rdonly(sb) && features) {
> -		btrfs_err(fs_info,
> -	"cannot mount read-write because of unsupported optional features (0x%llx)",
> -		       features);
> -		err = -EINVAL;
> -		goto fail_alloc;
> -	}
> -	/*
> -	 * We have unsupported RO compat features, although RO mounted, we
> -	 * should not cause any metadata write, including log replay.
> -	 * Or we could screw up whatever the new feature requires.
> -	 */
> -	if (unlikely(features && btrfs_super_log_root(disk_super) &&
> -		     !btrfs_test_opt(fs_info, NOLOGREPLAY))) {
> -		btrfs_err(fs_info,
> -"cannot replay dirty log with unsupported compat_ro features (0x%llx), try rescue=nologreplay",
> -			  features);
> -		err = -EINVAL;
> +	ret = btrfs_check_features(fs_info, sb);
> +	if (ret < 0) {
> +		err = ret;
>   		goto fail_alloc;
>   	}
>   
> -
>   	if (sectorsize < PAGE_SIZE) {
>   		struct btrfs_subpage_info *subpage_info;
>   
> diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
> index 7e545ec09a10..c67c15d4d20b 100644
> --- a/fs/btrfs/disk-io.h
> +++ b/fs/btrfs/disk-io.h
> @@ -48,6 +48,7 @@ int __cold open_ctree(struct super_block *sb,
>   void __cold close_ctree(struct btrfs_fs_info *fs_info);
>   int btrfs_validate_super(struct btrfs_fs_info *fs_info,
>   			 struct btrfs_super_block *sb, int mirror_num);
> +int btrfs_check_features(struct btrfs_fs_info *fs_info, struct super_block *sb);
>   int write_all_supers(struct btrfs_fs_info *fs_info, int max_mirrors);
>   struct btrfs_super_block *btrfs_read_dev_super(struct block_device *bdev);
>   struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index eb0ae7e396ef..b0aeecc932b2 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2014,14 +2014,10 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
>   	if (ret)
>   		goto restore;
>   
> -	/* V1 cache is not supported for subpage mount. */
> -	if (fs_info->sectorsize < PAGE_SIZE && btrfs_test_opt(fs_info, SPACE_CACHE)) {
> -		btrfs_warn(fs_info,
> -	"v1 space cache is not supported for page size %lu with sectorsize %u",
> -			   PAGE_SIZE, fs_info->sectorsize);
> -		ret = -EINVAL;
> +	ret = btrfs_check_features(fs_info, sb);
> +	if (ret < 0)
>   		goto restore;
> -	}
> +
>   	btrfs_remount_begin(fs_info, old_opts, *flags);
>   	btrfs_resize_thread_pool(fs_info,
>   		fs_info->thread_pool_size, old_thread_pool_size);
> @@ -2117,15 +2113,6 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
>   			ret = -EINVAL;
>   			goto restore;
>   		}
> -		if (btrfs_super_compat_ro_flags(fs_info->super_copy) &
> -		    ~BTRFS_FEATURE_COMPAT_RO_SUPP) {
> -			btrfs_err(fs_info,
> -		"can not remount read-write due to unsupported optional flags 0x%llx",
> -				btrfs_super_compat_ro_flags(fs_info->super_copy) &
> -				~BTRFS_FEATURE_COMPAT_RO_SUPP);
> -			ret = -EINVAL;
> -			goto restore;
> -		}
>   		if (fs_info->fs_devices->rw_devices == 0) {
>   			ret = -EACCES;
>   			goto restore;
