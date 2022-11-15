Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD8062AE9F
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 23:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbiKOWuw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 17:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbiKOWuv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 17:50:51 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F40BCB;
        Tue, 15 Nov 2022 14:50:50 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MORAU-1oamU70bWA-00PyO4; Tue, 15
 Nov 2022 23:50:29 +0100
Message-ID: <8845454d-9942-8216-2f00-2bb12bad0e41@gmx.com>
Date:   Wed, 16 Nov 2022 06:50:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v4 3/3] btrfs: qgroup: fix sleep from invalid context bug
 in update_qgroup_limit_item()
Content-Language: en-US
To:     ChenXiaoSong <chenxiaosong2@huawei.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhangxiaoxu5@huawei.com, yanaijie@huawei.com, wqu@suse.com
References: <20221115171709.3774614-1-chenxiaosong2@huawei.com>
 <20221115171709.3774614-4-chenxiaosong2@huawei.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20221115171709.3774614-4-chenxiaosong2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:qf4UcSkypubV65Z6pVPtMUkjo4L+Q7azP7Z8uLzXO8IYUD1jxMe
 1qZwDgiKLUrnevm7tjsbzauTaB/07Gnr1EI9nzqmdOOfEjQ5EESP46Dl8hjkoutRpDdzXcv
 TGsvUv/J5E3SbX8AF7vUdPh0ngCREK2mwwrE3gDtQpN7Jqd+IMWG3ZB7qPYIlHGWT2xUJWD
 ra5CwJK+MTA62JGPoIwWg==
UI-OutboundReport: notjunk:1;M01:P0:QrughL3YMH0=;KGDkQr7lOw5M29GsaFewPxfwPou
 wvWylbZp4VU6Sgef8yEUQDBYu97Xdez2rINtAfqsVeOumF4t2YuyWS1iuu+p3G7qvvuAJnFIA
 E8Ad0Dn77QSWXVFwNL3kUzWk8uxtxw7Sw0BUb75ivHX1hD7EVq9C41KuTjJbTAfH7EcGvhagl
 jYgwV2VZCaLbQPFoiUMiAT49QqCA5HtkapUjd+r376ZybFSyK4gbmk6vHxk8N4MI9AW6JAYgC
 IQaWXLNFAEzUeG0ElzyAnOqp2LaNQ1/kYmzpWNxY4cIgB565wFFZSzx9M4sZd6V48CF6t90Wi
 p0FUVLd2n8nkaVH28uWwpxx+JJGJ7dP86juOwtbfok/i7D5THrL0Qk4YlvyUAJIRfdGjk1U3j
 tzf6zHTQwCvn1qb4VI+ZFeL+1Fz5GLpfIRAVo4Ea52OSjZ6dAH1UolzJ0GRYp88hp+w9bvd8q
 YQRId1wZUrgZaBGsCIya9RP8oa6Sa2hgYfrJ2CtKsJXkcGV90j0Kt/dF0B76/03ZaLwAqWXvE
 IdTEXnCYkEfUq6UAUN2x2ab8thRki4QgfOd31r2GWyOoNc8TzPwr0GHP0+xcn7ZvQxkhyMP7Y
 BwmAP/eCwexTXYD0Qp1B4bpOn4mCgxm2Gu7Wl8qx7F+gMGL5eGpleAASjsLlKj5fk7dmzPfLG
 8oyqtFXeqnRnJE9mxy4Js+ueWDjS+Wq8fDP91+TWtA+SCZsomKQ6du+ogbXA245TlF+FqADh7
 h58PcYCWX7xBKYM7R8oOPChORLy8sVeRlxIDNrqnLvj2GAtm0rW3P/HqgLtXFnB7+9wO/qr8o
 RhUzAeuIyMeKFW9koipoyW509qMkVjrZceTPiSfaOyoFUTQ8y7UDEft/KcaG58H8eIwSo1N0e
 hgday+Aw5zC77WWY8A6wAb6YCwpv0bdUB9vNX36EPL1VIh9mrlNnQe3qUCnhIhaKHIShOwsr/
 l979FJFl6Ef+Qv3M8jVvgCRCmtc=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/11/16 01:17, ChenXiaoSong wrote:
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
> 
> Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
> ---
>   fs/btrfs/qgroup.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index ca609a70d067..f84507ca3b99 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -2867,6 +2867,8 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
>   	bool need_rescan = false;
>   	u32 level_size = 0;
>   	u64 nums;
> +	bool update_limit = false;
> +	int err;
>   
>   	/*
>   	 * There are only two callers of this function.
> @@ -2957,10 +2959,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
>   		dstgroup->max_excl = inherit->lim.max_excl;
>   		dstgroup->rsv_rfer = inherit->lim.rsv_rfer;
>   		dstgroup->rsv_excl = inherit->lim.rsv_excl;
> -
> -		ret = btrfs_update_quoto_limit(trans, dstgroup, fs_info);
> -		if (ret)
> -			goto unlock;
> +		update_limit = true;

Nope, just call qgroup_dirty() for @dstgroup.

Thanks,
Qu
>   	}
>   
>   	if (srcid) {
> @@ -2987,6 +2986,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
>   		dstgroup->max_excl = srcgroup->max_excl;
>   		dstgroup->rsv_rfer = srcgroup->rsv_rfer;
>   		dstgroup->rsv_excl = srcgroup->rsv_excl;
> +		update_limit = false;
>   
>   		qgroup_dirty(fs_info, dstgroup);
>   		qgroup_dirty(fs_info, srcgroup);
> @@ -3055,6 +3055,11 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
>   
>   unlock:
>   	spin_unlock(&fs_info->qgroup_lock);
> +	if (update_limit) {
> +		err = btrfs_update_quoto_limit(trans, dstgroup, fs_info);
> +		if (err)
> +			ret = err;
> +	}
>   	if (!ret)
>   		ret = btrfs_sysfs_add_one_qgroup(fs_info, dstgroup);
>   out:
