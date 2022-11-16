Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3AC562BD9B
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Nov 2022 13:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238874AbiKPMWa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Nov 2022 07:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238848AbiKPMWG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Nov 2022 07:22:06 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2EC12ACD;
        Wed, 16 Nov 2022 04:19:08 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N5VD8-1p2Fdg01Oc-016y61; Wed, 16
 Nov 2022 13:18:42 +0100
Message-ID: <89c0d7bd-713b-dd3a-7a18-75371f967561@gmx.com>
Date:   Wed, 16 Nov 2022 20:18:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v5 2/2] btrfs: qgroup: fix sleep from invalid context bug
 in update_qgroup_limit_item()
Content-Language: en-US
To:     ChenXiaoSong <chenxiaosong2@huawei.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhangxiaoxu5@huawei.com, yanaijie@huawei.com, wqu@suse.com
References: <20221116130716.991901-1-chenxiaosong2@huawei.com>
 <20221116130716.991901-3-chenxiaosong2@huawei.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20221116130716.991901-3-chenxiaosong2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:0AWTmC124QyQ+RiTmfM6ZaC2tofSr+Yv2Yc80aRPZ/y6x7NwrTt
 X9wlBP4XVMaVElOe5THqaHZ1A5o7xfWFDyTF4E3HPq+r2byj0LXFE2DrMPoojQeIfWgcNEL
 bIzznedP1bTRyI7mZKsBzAg3yIvoQuTEsbJYYIOlnTvTGyHcG+9rJBziGSijQlUpEzGGaVx
 Un/lV5dtk9Vku+87gCryQ==
UI-OutboundReport: notjunk:1;M01:P0:b3gYyPzCAFY=;vN3i3/i/DTUVD4hGlmS47usbDKC
 JFFJDNOopWIjb0PTvnn5SV2jnVZOtibEfnwMMwjf6DCBSi/zj+RzMHxgyUj/qve4MOmbQ2BY1
 lBjm8zPw6T0ixXdoLKX2r7PO0T5vONb+kqX980WPGmJWrswsKMZOXCxLuyUeILOgu9Pr3pJ8d
 Gj//RP6tcqobtNSxUjCWplIrhJMI7FXLXanbsCMhj0r/CiZgP2EuS4QmFAE0anwOzEAhbcjqd
 8ZSmU4DO1ezxOJOAbSyfOR+SLEl/OMsctTlhQGeyL38KM3lYlZV0GA4cDbwGXRcKyhTWtj0wx
 sZQ+pBWqunJk0+2pUw8iuy6iz3qUQWSTPGfYtqEBL7qSX9b6Kp5BdnO2d1UafEEmSi6Khmd3k
 4JWVUnNjuxpBqeyjw6VGZ9VRVEgXHqT0PQl8R3HmAOI89rDOyFpIjyhvWYBZlKnWpr2OdzCIB
 iiTN/a/6seZG/dmfuaosUkXEqTsmGWnvsSkacf1g7Hs4Kh5p8UzXhum4mpIas7PSfNcJ5ITmI
 nNlQc1vxJVf0ZyVKaOT1ri0ghPMdJ4AkeZTFz2ASnJnH3+iNtZQsNvyseiG39ndCG8/rXDKZb
 ecgaunEZyBMNhcRoqg908wRGF8WhCqG3iC22OsHzMPwaL4i5dXEhAkeqNqya6bDbNjEao2tr3
 g3MJEmOT+TYlcXYHT145EkCLnYuSrGQ8G4gfUSUlJYW/a/zyP2FN3GsyPDWeYid1f3Bknqzoc
 ztR1m4W33hfxWoHng98TfhRzq+9brYSqQcMD8UIp4ii39qQEbk2E9JYtWj4yW/icD4d/PXmDh
 OpfT+cWXArkQjFJ9GOQPiwPSBJ+exjc0KFXsFSfnhKQbaZswnTNZwToTAWebtRIxNKm1bvN6l
 xw+jqUNPbajUluXKtpDJyG971bDacnXDexRr91VnMKC3OKaBvJwBejk9iH2sMdRnz38IEd71o
 Hr4tFCBA9BFOWgzi229tgp7YZ2c=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/11/16 21:07, ChenXiaoSong wrote:
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
> ---
>   fs/btrfs/qgroup.c | 29 ++++++++++++-----------------
>   1 file changed, 12 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 9334c3157c22..8f5c52e24430 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -2860,6 +2860,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
>   	bool need_rescan = false;
>   	u32 level_size = 0;
>   	u64 nums;
> +	bool dirty_dstgrp = false;

I don't know why you insist on such bool (and the extra lable).

I have mentioned how qgroup_dirty() works, it can be called how ever 
many times, and the qgroup code will handle it without problem.

So the whole patch can be just as simple as:

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 05e79f7b4433..e0522c6c0d67 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -2965,14 +2965,7 @@ int btrfs_qgroup_inherit(struct 
btrfs_trans_handle *trans, u64 srcid,
                 dstgroup->rsv_rfer = inherit->lim.rsv_rfer;
                 dstgroup->rsv_excl = inherit->lim.rsv_excl;

-               ret = update_qgroup_limit_item(trans, dstgroup);
-               if (ret) {
-                       qgroup_mark_inconsistent(fs_info);
-                       btrfs_info(fs_info,
-                                  "unable to update quota limit for %llu",
-                                  dstgroup->qgroupid);
-                       goto unlock;
-               }
+               qgroup_dirty(fs_info, dstgroup);
         }

         if (srcid) {


>   
>   	/*
>   	 * There are only two callers of this function.
> @@ -2941,7 +2942,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
>   	dstgroup = add_qgroup_rb(fs_info, objectid);
>   	if (IS_ERR(dstgroup)) {
>   		ret = PTR_ERR(dstgroup);
> -		goto unlock;
> +		goto dirty;
>   	}
>   
>   	if (inherit && inherit->flags & BTRFS_QGROUP_INHERIT_SET_LIMITS) {
> @@ -2950,21 +2951,13 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
>   		dstgroup->max_excl = inherit->lim.max_excl;
>   		dstgroup->rsv_rfer = inherit->lim.rsv_rfer;
>   		dstgroup->rsv_excl = inherit->lim.rsv_excl;
> -
> -		ret = update_qgroup_limit_item(trans, dstgroup);
> -		if (ret) {
> -			qgroup_mark_inconsistent(fs_info);
> -			btrfs_info(fs_info,
> -				   "unable to update quota limit for %llu",
> -				   dstgroup->qgroupid);
> -			goto unlock;
> -		}
> +		dirty_dstgrp = true;
>   	}
>   
>   	if (srcid) {
>   		srcgroup = find_qgroup_rb(fs_info, srcid);
>   		if (!srcgroup)
> -			goto unlock;
> +			goto dirty;
>   
>   		/*
>   		 * We call inherit after we clone the root in order to make sure
> @@ -2985,20 +2978,20 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
>   		dstgroup->max_excl = srcgroup->max_excl;
>   		dstgroup->rsv_rfer = srcgroup->rsv_rfer;
>   		dstgroup->rsv_excl = srcgroup->rsv_excl;
> +		dirty_dstgrp = true;
>   
> -		qgroup_dirty(fs_info, dstgroup);
>   		qgroup_dirty(fs_info, srcgroup);
>   	}
>   
>   	if (!inherit)
> -		goto unlock;
> +		goto dirty;
>   
>   	i_qgroups = (u64 *)(inherit + 1);
>   	for (i = 0; i < inherit->num_qgroups; ++i) {
>   		if (*i_qgroups) {
>   			ret = add_relation_rb(fs_info, objectid, *i_qgroups);
>   			if (ret)
> -				goto unlock;
> +				goto dirty;
>   		}
>   		++i_qgroups;
>   
> @@ -3022,7 +3015,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
>   
>   		if (!src || !dst) {
>   			ret = -EINVAL;
> -			goto unlock;
> +			goto dirty;
>   		}
>   
>   		dst->rfer = src->rfer - level_size;
> @@ -3043,15 +3036,17 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
>   
>   		if (!src || !dst) {
>   			ret = -EINVAL;
> -			goto unlock;
> +			goto dirty;
>   		}
>   
>   		dst->excl = src->excl + level_size;
>   		dst->excl_cmpr = src->excl_cmpr + level_size;
>   		need_rescan = true;
>   	}
> +dirty:
> +	if (dirty_dstgrp)
> +		qgroup_dirty(fs_info, dstgroup);
>   
> -unlock:
>   	spin_unlock(&fs_info->qgroup_lock);
>   	if (!ret)
>   		ret = btrfs_sysfs_add_one_qgroup(fs_info, dstgroup);
