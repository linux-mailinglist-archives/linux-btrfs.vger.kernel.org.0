Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018AA624DDE
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Nov 2022 23:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbiKJW7V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Nov 2022 17:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbiKJW7T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Nov 2022 17:59:19 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363B013DEE;
        Thu, 10 Nov 2022 14:59:18 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MkHMP-1pH5zZ3ofB-00ke26; Thu, 10
 Nov 2022 23:58:53 +0100
Message-ID: <335ddbf7-ea4b-157f-be77-a729d798fd03@gmx.com>
Date:   Fri, 11 Nov 2022 06:58:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Content-Language: en-US
To:     ChenXiaoSong <chenxiaosong2@huawei.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, zhangxiaoxu5@huawei.com
References: <20221110141342.2129475-1-chenxiaosong2@huawei.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] btrfs: qgroup: fix sleep from invalid context bug in
 update_qgroup_limit_item()
In-Reply-To: <20221110141342.2129475-1-chenxiaosong2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:QlNMiMZiZUFan1EzdvgSc1HGguCsA159G8Fjynzr0RNGiLeTacc
 +KLw8qcdSR1ySr9CQFfGVcd3Q6UA/9cw0CXUuWlLDYkHZaZVYvQlyyZKaxTt1d+0HOEmxS9
 cBzrVKOF5VRRIyHvk5hr3oFXSz3kVaXrwggSUmSuYX3Wfe4xZMkMVAW6hNL3jrBHoaIFx/L
 uRAp1I4tQEysMTCZHYNfg==
UI-OutboundReport: notjunk:1;M01:P0:tnawMJDR8uw=;YBCekbcvs+F2j9JRDHtISyWP8LG
 LnBPVLam3d1T5+K0yo0yxQG7FQoe7+kGzvybYLfs4fu9bx9u67U/9GldDE0LPz8OfpwdUZJ54
 z8YcOS7oOtR3lJZufFTJh2FBVXos6nbQvGwfVqlT9MJb/BsZnTMCjCi8xDKhi8CmUQlc/LCGX
 qX1DcnOl8oloc37euepOH7s5khjWZNMkwNNniBO304zyiqFxjFDJMiibs73xq6ybg7SPpVRVY
 LVQM8Z0nancXpxhuFvRe2cUlm1sIkBVbywec93GoSiwiwitA2OQiqD/CdI3MKqnukBDHNxCFk
 WMzpNJFIOkWxKDC+4mpYzmcUa6f1z2VByZQq2Bo0df4cf6fCXC7nGl63nImxnCKuZqo++xaMI
 P3k5HKs2mLG7qveJW/swCWn3fDu7rjmN2hzyPKLuObpeqINRSa9lKg4Ssz1XxjTF1fjXoAcZO
 jzqVLzUd2NQUD2iNGQYphY5bh7qW7gjRQqc6yToZ2TtufuvVrk564d1PCMaV4/kAtU6ItH5Eg
 xGowvnotcmB/MLhKh4O1dONLIhh9FwKPGGanct/7gIHwCvfdEZ4bN010dm5AvL0Z6l18ADl/x
 Frkehq2I5vNGMA1g69UkL5aI1L5Or8YQUPSDbp7L4jB0SxZukaOvKEto8nhB9yIvAGNS8Gsb7
 AC8swQF5rP/llW6Pvy9B3vFVxREsMt08mdNHh9mavZAvoB8vj7DlpQF9ET4hb1bJx9Jjhhg/V
 6s89d3PTArymWbJ1xniILoKkMTFJWkCN7a11flyaPztApnP8B6RuATRizb+gn9WA1pcrbfIcf
 VG3TXJ7F/LIIIxzTCzwelM8MxlcjiklZ8yWzfCeY2ZedB4WCmuie5ZG00TM09+CZlfLYsFcwE
 DU97K+Ab9rS35ccFuyA7/NhCMAII08SBjNTrlXp+bm+IAI3RcD3I+QDoXq20r0x1NUcBQU5Mr
 aGI4Afcc6okRdk9PzGwLSTdCwmk=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/11/10 22:13, ChenXiaoSong wrote:
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
> Fix this by introducing __update_qgroup_limit_item() helper, allocate
> memory outside of the spin lock.
> 
> Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>

Unfortunately, __update_qgroup_limit_item() can still sleep.

As it calls btrfs_search_slot(), which can lead to disk IO if the qgroup 
tree is not cached.


I believe the proper way is to either unlock the spinlock inside 
btrfs_qgroup_inherit() (which needs extra scrutiny on the qgroup lock), 
or delayed the limit item updates until we have unlocked the spinlock.

To me, the latter one seems more reasonable, as it's just one qgroup 
(@dstgroup), and we're doing the same delayed work for sysfs interface 
creation.

Thanks,
Qu

> ---
>   fs/btrfs/qgroup.c | 35 ++++++++++++++++++++++++++---------
>   1 file changed, 26 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 9334c3157c22..99a61cc04b68 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -768,11 +768,11 @@ static int del_qgroup_item(struct btrfs_trans_handle *trans, u64 qgroupid)
>   	return ret;
>   }
>   
> -static int update_qgroup_limit_item(struct btrfs_trans_handle *trans,
> -				    struct btrfs_qgroup *qgroup)
> +static int __update_qgroup_limit_item(struct btrfs_trans_handle *trans,
> +				      struct btrfs_qgroup *qgroup,
> +				      struct btrfs_path *path) >   {
>   	struct btrfs_root *quota_root = trans->fs_info->quota_root;
> -	struct btrfs_path *path;
>   	struct btrfs_key key;
>   	struct extent_buffer *l;
>   	struct btrfs_qgroup_limit_item *qgroup_limit;
> @@ -783,10 +783,6 @@ static int update_qgroup_limit_item(struct btrfs_trans_handle *trans,
>   	key.type = BTRFS_QGROUP_LIMIT_KEY;
>   	key.offset = qgroup->qgroupid;
>   
> -	path = btrfs_alloc_path();
> -	if (!path)
> -		return -ENOMEM;
> -
>   	ret = btrfs_search_slot(trans, quota_root, &key, path, 0, 1);
>   	if (ret > 0)
>   		ret = -ENOENT;
> @@ -806,6 +802,21 @@ static int update_qgroup_limit_item(struct btrfs_trans_handle *trans,
>   	btrfs_mark_buffer_dirty(l);
>   
>   out:
> +	return ret;
> +}
> +
> +static int update_qgroup_limit_item(struct btrfs_trans_handle *trans,
> +				    struct btrfs_qgroup *qgroup)
> +{
> +	struct btrfs_path *path;
> +	int ret;
> +
> +	path = btrfs_alloc_path();
> +	if (!path)
> +		return -ENOMEM;
> +
> +	ret = __update_qgroup_limit_item(trans, qgroup, path);
> +
>   	btrfs_free_path(path);
>   	return ret;
>   }
> @@ -2860,6 +2871,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
>   	bool need_rescan = false;
>   	u32 level_size = 0;
>   	u64 nums;
> +	struct btrfs_path *path;
>   
>   	/*
>   	 * There are only two callers of this function.
> @@ -2935,6 +2947,11 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
>   		ret = 0;
>   	}
>   
> +	path = btrfs_alloc_path();
> +	if (!path) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
>   
>   	spin_lock(&fs_info->qgroup_lock);
>   
> @@ -2950,8 +2967,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
>   		dstgroup->max_excl = inherit->lim.max_excl;
>   		dstgroup->rsv_rfer = inherit->lim.rsv_rfer;
>   		dstgroup->rsv_excl = inherit->lim.rsv_excl;
> -
> -		ret = update_qgroup_limit_item(trans, dstgroup);
> +		ret = __update_qgroup_limit_item(trans, dstgroup, path);
>   		if (ret) {
>   			qgroup_mark_inconsistent(fs_info);
>   			btrfs_info(fs_info,
> @@ -3053,6 +3069,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
>   
>   unlock:
>   	spin_unlock(&fs_info->qgroup_lock);
> +	btrfs_free_path(path);
>   	if (!ret)
>   		ret = btrfs_sysfs_add_one_qgroup(fs_info, dstgroup);
>   out:
