Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53EB462CE9C
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Nov 2022 00:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbiKPXRP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Nov 2022 18:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233825AbiKPXRL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Nov 2022 18:17:11 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D5712085;
        Wed, 16 Nov 2022 15:17:08 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M9Wyy-1opxTS3gxw-005WXh; Thu, 17
 Nov 2022 00:16:51 +0100
Message-ID: <cb6073e5-e465-8934-05a1-42d83ac4470e@gmx.com>
Date:   Thu, 17 Nov 2022 07:16:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v6 2/2] btrfs: qgroup: fix sleep from invalid context bug
 in update_qgroup_limit_item()
Content-Language: en-US
To:     ChenXiaoSong <chenxiaosong2@huawei.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhangxiaoxu5@huawei.com, yanaijie@huawei.com, wqu@suse.com
References: <20221116142354.1228954-1-chenxiaosong2@huawei.com>
 <20221116142354.1228954-3-chenxiaosong2@huawei.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20221116142354.1228954-3-chenxiaosong2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:4ARWBwaruX9+tgd/2+tyL08LRrkr/UgvVfCSNM0yms5829PmX8U
 pCS8MGGV2agB/dBQ7kBfAJuYV4XGFgmaIkp1O5PJnTmXILvzSc6PwnmYxUg9RQajDqBsELY
 SC6/VtcVogZf5ci6ZKYdwkk9yysOJ3PHx/Yr+9REeIXfkwJYxeSCB//k6/Ms+zsJNTZXgLf
 4DBWn/SON2j+2drlLU24w==
UI-OutboundReport: notjunk:1;M01:P0:Q0jR8L+7en4=;TC3CsQiNZKviEyjScmTPxV7Kftk
 tMgUGq/GOe5WDJj5+ptb/HbRgVF1Y61pxCotizL10yhYhTWLhBUT4J1Q3uOi16/B7HF5W6p7d
 45POMJ3js4ndTG/NoBr+RYaOB5PzOuuIQwUbEkR9izQbNQ25KZam3gpkXErfiX/LTAnEIGGQg
 1ylxsD97jQh02KxfAbDKD43/bGCPXiw8a5vAl72H/Yu/etCTYY/HbqCTZIZbWcS2BKsrmzpQq
 obUqT9xzmk/7dhzKUte+zPsCz/3OmFFCSU9uGFKlUFss5mM3xdlCn4eBIJMsvMjJbzEuXb2Ue
 +ac5/NEXwIFFSONff/mvrYHkw5F1+1JPGxLxm84JJd1yX9GKgKpI7a7DJkHjKTWwQa9B/icqY
 GA4gx7u7x5nh3s20xSU3Kt7vq6niuW40mfgUwCtiP2CttgDFoQFtt8uZaJK3Hma5bntT2XqyF
 q4faiVL4MmoVlYSeRxOB5zVE2tgZA6JDOO5TqejFyDJqu13OoBHYGujjbBpuvzDKvYyjXZ/3V
 WEyKpCwWfqXoADTHu7ofU89LKxN56gJzsv6/bQRL7mUPOvfA9P1CkaTeXv/GJxABpee4/SqC0
 lGVe6JKNyhtHU6trsRi4msNaThTV+P1dI7g0EnHSCmW9YmZHfYMnhvYpJtDufy/zpHGg0cLkf
 wWbKO3y3nPRqYaWENxSdql3CLHX5s7Ck5tFwNumfDRAWBsAJSkCFpIpYvaFWcDRe4q6CETbpC
 8Ps8nBGm7JzwT7InFBUXch3ZyVqflgMm1DDPPCZXHelHtmm9TdHeWk8v35N1hg9Vi1igxzen/
 X4QcCwN5C+sKxFNGI24dzlH7jQvWgl/r5Whz1GPwf03I++0MOk78Oe0J9+DPWvlbYsOtgfqGd
 6Un4GN5lxCIovPTNTHMOnQK5e38+dMoeH6vqEMxkCE6OkqjynIO2CFDn7ItSQSz+OzBnC904t
 RS7srDkSkpsMwZkrbd7CRzabUJ8=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/11/16 22:23, ChenXiaoSong wrote:
> Syzkaller reported BUG as follows:
> 
>    BUG: sleeping function called from invalid context at
>         include/linux/sched/mm.h:274
>    Call Trace:
>     <TASK>
>     dump_stack_lvl+0xcd/0x134
>     __might_resched.cold+0x222/0x26b
>     kmem_cache_alloc+0x2e7/0x3c0
>     update_qgroup_limit_item+0xe1/0x390
>     btrfs_qgroup_inherit+0x147b/0x1ee0
>     create_subvol+0x4eb/0x1710
>     btrfs_mksubvol+0xfe5/0x13f0
>     __btrfs_ioctl_snap_create+0x2b0/0x430
>     btrfs_ioctl_snap_create_v2+0x25a/0x520
>     btrfs_ioctl+0x2a1c/0x5ce0
>     __x64_sys_ioctl+0x193/0x200
>     do_syscall_64+0x35/0x80
> 
> Fix this by calling qgroup_dirty() on @dstqgroup, and update limit item in
> btrfs_run_qgroups() later.
> 
> Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/qgroup.c | 9 +--------
>   1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 9334c3157c22..b74105a10f16 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -2951,14 +2951,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
>   		dstgroup->rsv_rfer = inherit->lim.rsv_rfer;
>   		dstgroup->rsv_excl = inherit->lim.rsv_excl;
>   
> -		ret = update_qgroup_limit_item(trans, dstgroup);
> -		if (ret) {
> -			qgroup_mark_inconsistent(fs_info);
> -			btrfs_info(fs_info,
> -				   "unable to update quota limit for %llu",
> -				   dstgroup->qgroupid);
> -			goto unlock;
> -		}
> +		qgroup_dirty(fs_info, dstgroup);
>   	}
>   
>   	if (srcid) {
