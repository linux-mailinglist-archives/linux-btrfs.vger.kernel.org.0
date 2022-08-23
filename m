Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9643759E4BA
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Aug 2022 15:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240294AbiHWNy7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Aug 2022 09:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241374AbiHWNyi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Aug 2022 09:54:38 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E4614CD6F;
        Tue, 23 Aug 2022 04:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661252327;
        bh=QzClyQjItAq9n15Vo08UoxP0sYk/1xDKVKAWEJOn6V8=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=SQwUdi0susLGi3/Um4fbAqTQPH9gTgHfLtt47e+WR4xoMYdM0n7b6aKj6WcQI9a2u
         gtmHhUdDmBJtKoSOy6JU5KbgdTVnrB673htDuzGQoZs0NNJ9jksNcSE+xWirqWdjJN
         P8VHYda86K5NFhWTbq3DsEW5a7gp5GFEBU9EoFA4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MgvvJ-1p5H9U26dZ-00hKe3; Tue, 23
 Aug 2022 12:58:47 +0200
Message-ID: <dd780c08-6265-ed80-6f76-c49325696631@gmx.com>
Date:   Tue, 23 Aug 2022 18:58:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Ye Bin <yebin10@huawei.com>, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220823015931.421355-1-yebin10@huawei.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH -next] btrfs: fix use-after-free in btrfs_get_global_root
In-Reply-To: <20220823015931.421355-1-yebin10@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yrYgNRslMVv5j9sTsveYSc8pqFSQdmO5lOFs+3M3Wq6qqw795ue
 zshATddVpb84ByjrkLYnGerRUMmKqiRnv9R1aOgLXmESioEWYAOACbgFyukcNtXPXM7roeJ
 +DruLGhwO+zAgHxI7ciXi4iFZtuy32ogRbgH/MDE4TDtfb1qPSJqraj/S4MEJbFNchfICF/
 mVSCtJl3D6yzCf3aibLfw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ja9Ms1PCBHI=:jKv752sMWAa30U5yXaSziW
 a2OIEr6gE6JFRlJBr8CS8uv9M4imSh2P/JZ9zU0Qe7GEGeHy1iEjlz3q6ICjWQLqo7C6/i1bF
 GFttEZTOnXVQxkMDq/m99m1Wn5ILoUFLYIhUE+yUJ/BGCRKaPAx/J55MA8gRzoOBbAud4WlfT
 UrFgY0Bbo+oDSiLeh84GXy6GuxuPbmorWGf+8Z4U3N7h7JGSgHhX2LcK25JuoKboE40ldlma3
 AOzzJ0QEVTpyRgi+C3PDDbIeehohGINhfd4/enjzQ3LCAqqPzIETH5qul7cB73/85JCX05a1Y
 MUvo5RgrR6Xuw/46igXrJcsCfNwlW3eQwOcVbu4D6cnZe5uQ3kU376QxZ7e05J3Re7wQDn1RM
 LCI7SxxupXCpX0SnzpqezelrH9klVciDbJIoNvWyR/twN3Scrrz0kxvZF+AwIgdoUFTeh0tbe
 JZxfJc6DTxvgOGFYP3IKme+bv3ugZQe2hD/jgdmg0xhse2MIfgts2ZSqxC7YPPFbeMbzJk4Od
 ZQu9CoJYnF6SCsdnDtjcH/5SnNHv8R3BglEcYoCwyRedAiNbB20z4tTjmsE88CQX71BhtvtUA
 mYNhyEQcMIlkZ5PhMCiRWzzQuNfnzcuCmUl5T0WpODARPEH3xKeGZaYnRmY8nuF7jM1m6VZLl
 Pp7T6/0pdWBn9YgubjPAtsnpqhGIzAx5fB1Npewxubz2ryKtTE1dAmsTY5C/5gv9Tb8y39GuW
 SK4iMFbUjO3DtLkgjfLdVVvHPqHQQ2Byeb6SJ7yv2Xc0IsjuaeAzzOBR8CBCuwHDSV6z6086N
 oEhfmAnX34jNcGBFpaMNl5I4BPSBlpSDeFDE+ZMeaTUJssg3VSADMwqn41dTcA6FEYIGX64oM
 oXWmpzERHZAgZvNRU0r/bwUUXD3IPtyyu5bop+iQgB0mkdOmSbxH54xubOeJYCclEp/zR4aid
 hQ0PJOvXOpbQxP587MaqAXzE6jw0hh74yithe96acTreSN3sbIQHR06PzYo+GcBYYJmCjO5FF
 PsbSueqz2fjlwxF/cQLUiqmjXe49jeZurY+0zdYeisR4IQ2IjmZLoRVTT8Q7J6UIMF73QsnnD
 pN1KErZImMzMcXlbK3pDoEbM9jIDcroHFcP/A/QkgG0NzCUNx007aHVcg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/23 09:59, Ye Bin wrote:
> Syzkaller reported UAF as follows:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: use-after-free in btrfs_get_global_root+0x663/0xa10
> Read of size 4 at addr ffff88811ddbb3c0 by task kworker/u16:1/11
>
> CPU: 4 PID: 11 Comm: kworker/u16:1 Not tainted 6.0.0-rc1-next-20220822+ =
#2
> Workqueue: btrfs-qgroup-rescan btrfs_work_helper
> Call Trace:
>   <TASK>
>   dump_stack_lvl+0x6e/0x91
>   print_report.cold+0xb2/0x6bb
>   kasan_report+0xa8/0x130
>   kasan_check_range+0x13f/0x1d0
>   btrfs_get_global_root+0x663/0xa10
>   btrfs_get_fs_root_commit_root+0xa5/0x150
>   find_parent_nodes+0x92f/0x2990
>   btrfs_find_all_roots_safe+0x12d/0x220
>   btrfs_find_all_roots+0xbb/0xd0

This means, we're looking for all of the parents subvolumes roots of a
bytenr.

Function btrfs_get_fs_root_commit_root() can only be called for indirect
ref, and at that stage, we're pretty sure that we're grabbing a
subvolume root.

>   btrfs_qgroup_rescan_worker+0x600/0xc30
>   btrfs_work_helper+0xff/0x750
>   process_one_work+0x52c/0x930
>   worker_thread+0x352/0x8c0
>   kthread+0x1b9/0x200
>   ret_from_fork+0x22/0x30
>   </TASK>
>
> Allocated by task 1895:
>   kasan_save_stack+0x1e/0x40
>   __kasan_kmalloc+0xa9/0xe0
>   btrfs_alloc_root+0x40/0x820
>   btrfs_create_tree+0xf8/0x500

But the allocated-by stack shows, the root belongs to quota root, the
only root that is created during qgroup enabling.

This doesn't sound sane to me.

The stacks are saying that, at least some tree blocks are shared by both
a subvolume and quota root, which is already against the on-disk format.

Mind to share the reproducer?

Thanks,
Qu

>   btrfs_quota_enable+0x30a/0x1120
>   btrfs_ioctl+0x50a3/0x59f0
>   __x64_sys_ioctl+0x130/0x170
>   do_syscall_64+0x3b/0x90
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> Freed by task 1895:
>   kasan_save_stack+0x1e/0x40
>   kasan_set_track+0x21/0x30
>   kasan_set_free_info+0x20/0x40
>   __kasan_slab_free+0x127/0x1c0
>   kfree+0xa8/0x2d0
>   btrfs_put_root+0x1ca/0x230
>   btrfs_quota_enable+0x87c/0x1120
>   btrfs_ioctl+0x50a3/0x59f0
>   __x64_sys_ioctl+0x130/0x170
>   do_syscall_64+0x3b/0x90
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Above issue may happens as follows:
>            p1                                  p2
> btrfs_quota_enable
>    spin_lock(&fs_info->qgroup_lock);
>    fs_info->quota_root =3D quota_root;
>    spin_unlock(&fs_info->qgroup_lock);
>
>    ret =3D qgroup_rescan_init -> return error
>    if (ret)
>      btrfs_put_root(quota_root);
>       kfree(root);
>
>    if (ret) {
>     ulist_free(fs_info->qgroup_ulist);
>     fs_info->qgroup_ulist =3D NULL;
>     btrfs_sysfs_del_qgroups(fs_info);
>    }                                btrfs_qgroup_rescan_worker
>                                       btrfs_find_all_roots
> 				       btrfs_find_all_roots_safe
> 				         find_parent_nodes
> 					   btrfs_get_fs_root_commit_root
> 					     btrfs_grab_root(fs_info->quota_root)
> 	                                  -> quota_root already freed
>
> Syzkaller also reported another issue:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: use-after-free in ulist_release+0x30/0xb3
> Read of size 8 at addr ffff88811413d048 by task rep/2921
>
> CPU: 3 PID: 2921 Comm: rep Not tainted 6.0.0-rc1-next-20220822+ #3
> rep[2921] cmdline: ./rep
> Call Trace:
>   <TASK>
>   dump_stack_lvl+0x6e/0x91
>   print_report.cold+0xb2/0x6bb
>   kasan_report+0xa8/0x130
>   ulist_release+0x30/0xb3
>   ulist_reinit+0x16/0x56
>   btrfs_qgroup_free_refroot+0x288/0x3f0
>   btrfs_qgroup_free_meta_all_pertrans+0xed/0x1e0
>   commit_fs_roots+0x28c/0x430
>   btrfs_commit_transaction+0x9a6/0x1b40
>   btrfs_qgroup_rescan+0x7e/0x130
>   btrfs_ioctl+0x48ed/0x59f0
>   __x64_sys_ioctl+0x130/0x170
>   do_syscall_64+0x3b/0x90
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
>   </TASK>
>
> Allocated by task 2900:
>   kasan_save_stack+0x1e/0x40
>   __kasan_kmalloc+0xa9/0xe0
>   ulist_alloc+0x5c/0xe0
>   btrfs_quota_enable+0x1b2/0x1160
>   btrfs_ioctl+0x50a3/0x59f0
>   __x64_sys_ioctl+0x130/0x170
>   do_syscall_64+0x3b/0x90
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> Freed by task 2900:
>   kasan_save_stack+0x1e/0x40
>   kasan_set_track+0x21/0x30
>   kasan_set_free_info+0x20/0x40
>   __kasan_slab_free+0x127/0x1c0
>   kfree+0xa8/0x2d0
>   ulist_free.cold+0x15/0x1a
>   btrfs_quota_enable+0x8bf/0x1160
>   btrfs_ioctl+0x50a3/0x59f0
>   __x64_sys_ioctl+0x130/0x170
>   do_syscall_64+0x3b/0x90
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> To solve above issues just set 'fs_info->quota_root' after qgroup_rescan=
_init
> return success.
>
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>   fs/btrfs/qgroup.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index db723c0026bd..16f0b038295a 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -1158,18 +1158,18 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_=
info)
>   	if (ret)
>   		goto out_free_path;
>
> -	/*
> -	 * Set quota enabled flag after committing the transaction, to avoid
> -	 * deadlocks on fs_info->qgroup_ioctl_lock with concurrent snapshot
> -	 * creation.
> -	 */
> -	spin_lock(&fs_info->qgroup_lock);
> -	fs_info->quota_root =3D quota_root;
> -	set_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags);
> -	spin_unlock(&fs_info->qgroup_lock);
> -
>   	ret =3D qgroup_rescan_init(fs_info, 0, 1);
>   	if (!ret) {
> +		/*
> +		 * Set quota enabled flag after committing the transaction, to
> +		 * avoid deadlocks on fs_info->qgroup_ioctl_lock with concurrent
> +		 * snapshot creation.
> +		 */
> +		spin_lock(&fs_info->qgroup_lock);
> +		fs_info->quota_root =3D quota_root;
> +		set_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags);
> +		spin_unlock(&fs_info->qgroup_lock);
> +
>   	        qgroup_rescan_zero_tracking(fs_info);
>   		fs_info->qgroup_rescan_running =3D true;
>   	        btrfs_queue_work(fs_info->qgroup_rescan_workers,
