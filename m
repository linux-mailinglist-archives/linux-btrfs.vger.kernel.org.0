Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C8462563F
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Nov 2022 10:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbiKKJJy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Nov 2022 04:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbiKKJJx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Nov 2022 04:09:53 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A0365D7;
        Fri, 11 Nov 2022 01:09:51 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MiJVG-1pVUgY2FMM-00fS1p; Fri, 11
 Nov 2022 10:09:30 +0100
Message-ID: <df7ede88-86a2-1c6d-0343-c97a851b9bdf@gmx.com>
Date:   Fri, 11 Nov 2022 17:09:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Content-Language: en-US
To:     ChenXiaoSong <chenxiaosong2@huawei.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhangxiaoxu5@huawei.com
References: <20221111090212.2266807-1-chenxiaosong2@huawei.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v2] btrfs: qgroup: fix sleep from invalid context bug in
 update_qgroup_limit_item()
In-Reply-To: <20221111090212.2266807-1-chenxiaosong2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:adN0BvpY9LFW83nGRg2sI4NzI0n5q9vd7DcF/upA6ogrTnaTe++
 7UgwSGVj7uFsEiPD/a74sSIZRNXL92kHgV3enPbnl4N4/icc94245Er872ezOoxSYUywdQn
 r9GhcCBp1Ff8jg8f1KHcivRYFWgdj30tg1m9ueoXmmazzd+anouruVLZgBEuVFVu0OYjuNO
 C3O6AxRhGwvM5d+HgBUKQ==
UI-OutboundReport: notjunk:1;M01:P0:XhtG/YgKL7A=;aHOHIZ1BRv8H/ZdpVFE23iyv8b1
 Tnd/2h5C79fwMW2l5585UL5TtvZLPnMKlBk2bQB174cn8KX730VMd4XRkhf05CW3u//dIzq/U
 TmhpZk3G63vrQFotqdDhcPKsfOVX7B08/AMXFJsagLbTazTpCLV226L8FIlA+k29AcrUbqTSd
 x+KZX78D8cEDGeMGKIbo0m6UZzVxahaBl7JCTs73R4xAIsG3ZDuroPj8ML/ENvwQTPNDYNtX5
 gFDodHJJXBUyUskXs4ln6luH5yTnZ49M+FxRITeonfmDNpEGEhxH3rgAsQBysgeatw/1dIIwG
 n3w+YPV/McTzCmrWYLkOsd5kmlr9ljrqILPQ5PnNAYnelY5ffbIGIn+6BiNrhvazRwZUVXbBy
 Bo/yJl/GD19C1QiG3h7Kvpnlb4BE55//37X4COGaWY0WSGw6zbEgQfKuuGXTw4UllnxzrVi7P
 7KZ8j7MqCNqmkDqsmm7OqwFl/M8rIO4ogWS5wcz6UI8IueHllF76MnJrPy7rrHPjbWQcnylab
 E24XOMkFhoM9KUBJqWkKmwS3v9axoTf3HWbf/XmZL4v1gJfMOz0yIQQZcJeljjLOt/KO2p8Ex
 IKoQXcVEf50A8T/stgZSl3+pyI/VJoFM+a3vlBHq7NQ+yNj6HD0KeUAmqc03bU5KsnmfdH92h
 gekmvftQrkLa6mFox7DgEvth9zhLr2OYUDcqIxn5DvsF4SNffDfbQSMNYKFbHiUXHpDNOOKVh
 TShgBX777AvQnjJrK6mPdeQE7OdLCoe8CWpDM/wu+dCHkm51/RFekQA9hXE2eXu9QfUyWtuHS
 stNyJxicdCH9QcYb2KA/tDEVrcIGzMlbbxaB3TbeIEysf67L3wwJUEKSQ8AMYUbjfxMi9SCb9
 dCamuhE7YzVXjJncwnbzVj9qTKsFFWeCiorWTAQaZ8K9cja/kSITA4g0qg/R/OI2bWyDjrpqx
 tC196Tfqufd0bFU/q3etnesnGss=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/11/11 17:02, ChenXiaoSong wrote:
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
> Fix this by delaying the limit item updates until unlock the spin lock.

The overall idea is way better now.

But sorry that I didn't immediately find out the best solution at the 
first glance.

In fact, your v2 path just lets me remember what is the correct way to 
handle such situation.

> 
> Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
> ---
>   fs/btrfs/qgroup.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 9334c3157c22..2792d63c0da4 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
[...]
> @@ -2985,6 +2978,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
>   		dstgroup->max_excl = srcgroup->max_excl;
>   		dstgroup->rsv_rfer = srcgroup->rsv_rfer;
>   		dstgroup->rsv_excl = srcgroup->rsv_excl;
> +		update_limit = true;
>   
>   		qgroup_dirty(fs_info, dstgroup);
>   		qgroup_dirty(fs_info, srcgroup);

You caught the "if (srcid)" branch, which also changed the 
limit/rfer/excl numbers of the destination qgroup, but didn't call 
update_qgroup_limit_item().


But if you check the function qgroup_dirty() a little deeper, you can 
find out that, qgroup_dirty() will move the target qgroup into 
fs_info->dirty_qgroups list.

And later at btrfs_run_qgroups() (which is called during 
btrfs_commit_transaction(), and also after create_pending_snapshots()), 
we will update the quota tree to reflect the result.

So this means, all you need is just call qgroup_dirty() on @dstqgroup, 
and call it a day.
Everything else will be properly handled.

Sorry I didn't notice this earlier...

Thanks,
Qu

> @@ -3053,6 +3047,12 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
>   
>   unlock:
>   	spin_unlock(&fs_info->qgroup_lock);
> +	if (update_limit && update_qgroup_limit_item(trans, dstgroup)) {
> +		qgroup_mark_inconsistent(fs_info);
> +		btrfs_info(fs_info,
> +			   "unable to update quota limit for %llu",
> +			   dstgroup->qgroupid);
> +	}
>   	if (!ret)
>   		ret = btrfs_sysfs_add_one_qgroup(fs_info, dstgroup);
>   out:
