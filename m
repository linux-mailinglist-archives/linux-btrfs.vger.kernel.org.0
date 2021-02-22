Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C11E33222C3
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Feb 2021 00:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbhBVXrJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Feb 2021 18:47:09 -0500
Received: from mout.gmx.net ([212.227.15.19]:46753 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230403AbhBVXrI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Feb 2021 18:47:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1614037534;
        bh=QvHSz/MvMPqVWGX9RIAp7Eyr2jbxXLGTZ3KIr74+QWo=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=DdoORLF8wte5zCu+7t5woiXUK9KEJcW80x2bawUtnCZd2bDD+6awoPexJCtiwZZqk
         dj0Kfx8qa/tdtQsLr5Bx1TpjwNyG1vhEZ25CYFIdJMaHU28EtvS07orQ5+chY+raRU
         T7rIbOuuITGb7dXN7nsxg9lQ5WRPZrlolb5Hod4E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mq2j2-1lb4Wq0C26-00nCug; Tue, 23
 Feb 2021 00:45:34 +0100
Subject: Re: [PATCH 3/6] btrfs: Don't flush from
 btrfs_delayed_inode_reserve_metadata
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20210222164047.978768-1-nborisov@suse.com>
 <20210222164047.978768-4-nborisov@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <40e8a541-fc36-5c6d-d7c8-e37b03b85521@gmx.com>
Date:   Tue, 23 Feb 2021 07:45:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210222164047.978768-4-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uBpkhY9U02Oa4Ix/GK2Yk4xLcV+1o6JaeDSed0/oTw3t7FYV6ZB
 7wuw4v5SA/SeWisUelpVT15SBDRWVYzMAItybyst19NYtpqapuXfYX4J8VPpBJMpX+E5j++
 oRdajyZEu6lGxRLC4AOCYKGR6DN/ga2Lw6cTTDdzYso4Irc4xFriXZLi7iqljTvo91Vo1Wy
 X/+8Pr9MU1Ar6hbj+N77w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZeF4M9Slb64=:xqwpv7RgpoxPmTXDNeN45i
 GigXK1clnwrD+m7ZjMayCph0LBIgONEvuYYn+zeSbu2KUewFJ597iIV+TldsBfP4wZ+HjDgMD
 Q8OH3PcjL6wVLgrjom2bV9pNx9IjTuDH5kCPPH7CLhbc/z2GlG41TjKR5AB9PxLBI8RrDpPlc
 f8uhbd66QsopgckA0bxQ+yMUjokuDOAoej5pS3Kwt327qsIgMXkVw48XoLT2ne5sI0CQNBfhw
 1gh8/3dTfaPD2v3SvH6SMG/RKaUEFoYzjUjpQQ6qvaAZzr1hrylD+zBvI936jWpFYsH8CAXUk
 EOv4BDSE9RIxE6iLbWpc08PT1pGs1TkDTkaVO0cFzKN2bg2k8yZZWp+TdMTWTN/T/39tbR5ej
 Sbbm39SHoTl6a38tqMoTtDoFwOIrlprW8Y28WVEtf7QMKgu26L9zzpjfqMZzuNAIsxOZ7xNma
 Rmhyf1xTgRINkN7uWdCygEYHUzNurmW0T04hyv4EQCI8kzEk8tkRn5MBX9wth9clWOIgWZKO0
 ge1Bws1aDTgdFnWp+Qep+ZXqi0PqBnPsP9lzIbtXZMWbfuVZ3cJ10Snro+FRMXFwCI2rFD9BD
 s3IDxLd9W01qoT31+rKpDuXlq9LAXtFSfvMA8rG9JuyHdf0Mk8103EzYreTcPeQbpRLfccmfk
 /+Hk/Q6BKyt93qHeKpO8gBuEggXuJfJi/JkaN5D9LRNci4Ug2wWJIX60U3ZWorH+L/gMBH+dC
 XM5S1p1pZOy0j6yDyaZfL4sHBfbbM9KtudIalKXI6Z5XuInPr4tBzuudrSvlIqRZD6cK6iDz/
 lnErLRCNoHwZnYtfUpBJvUQ/T1EbS1LczdPfSBq89f3IMMgvYFnDY1vRTXB9CU8JB8qqlanwr
 Z5TFD2zqjtEExEq/PW3Q==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/2/23 =E4=B8=8A=E5=8D=8812:40, Nikolay Borisov wrote:
> Calling btrfs_qgroup_reserve_meta_prealloc from
> btrfs_delayed_inode_reserve_metadata can result in flushing delalloc
> while holding a transaction and delayed node locks. This is is dead-lock
> prone. In the past multiple commits:
>
>   * ae5e070eaca9 ("btrfs: qgroup: don't try to wait flushing if we're
> already holding a transaction")
>
>   * 6f23277a49e6 ("btrfs: qgroup: don't commit transaction when we alrea=
dy
>   hold the handle")
>
> Tried to solve various aspects of this but this was always a
> whack-a-mole game. Unfortunately those 2 fixes don't solve a deadlock
> scenario involving btrfs_delayed_node::mutex. Namely, one thread
> can call btrfs_dirty_inode as a result of reading a file and modifying
> its atime:
>
>> PID: 6963   TASK: ffff8c7f3f94c000  CPU: 2   COMMAND: "http-0.0.0.0-62"
>>   #0 [ffffaedd02a67a00] __schedule at ffffffffa529e07d
>> #1 [ffffaedd02a67a90] schedule at ffffffffa529e4ff
>> #2 [ffffaedd02a67aa0] schedule_timeout at ffffffffa52a1bdd
>> #3 [ffffaedd02a67b18] wait_for_completion at ffffffffa529eeea <-- sleep=
s with delayed node mutex held
>> #4 [ffffaedd02a67b68] start_delalloc_inodes at ffffffffc0380db5 [btrfs]
>> #5 [ffffaedd02a67be8] btrfs_start_delalloc_snapshot at ffffffffc0393836=
 [btrfs]
>> #6 [ffffaedd02a67bf0] try_flush_qgroup at ffffffffc03f04b2 [btrfs]
>> #7 [ffffaedd02a67c40] __btrfs_qgroup_reserve_meta at ffffffffc03f5bb6 [=
btrfs] <-- tries to reserve space and starts delalloc inodes.
>> #8 [ffffaedd02a67c68] btrfs_delayed_update_inode at ffffffffc03e31aa [b=
trfs] <-- Acquires delayed node mutex
>> #9 [ffffaedd02a67cc0] btrfs_update_inode at ffffffffc0385ba8 [btrfs]
>> #10 [ffffaedd02a67ce8] btrfs_dirty_inode at ffffffffc038627b [btrfs] <-=
- TRANSACTIION OPENED
>> #11 [ffffaedd02a67d18] touch_atime at ffffffffa4cf0000
>> #12 [ffffaedd02a67d58] generic_file_read_iter at ffffffffa4c1f123
>> #13 [ffffaedd02a67e40] new_sync_read at ffffffffa4ccdc8a
>> #14 [ffffaedd02a67ec8] vfs_read at ffffffffa4cd0849
>> #15 [ffffaedd02a67ef8] ksys_read at ffffffffa4cd0bd1
>> #16 [ffffaedd02a67f38] do_syscall_64 at ffffffffa4a052eb
>> #17 [ffffaedd02a67f50] entry_SYSCALL_64_after_hwframe at ffffffffa54000=
8c
>
> This will cause an asynchronous work to flush the delalloc inodes to
> happen which can try to acquire the same delayed_node mutex:
>
>> PID: 455    TASK: ffff8c8085fa4000  CPU: 5   COMMAND: "kworker/u16:30"
>> #0 [ffffaedd009f77b0] __schedule at ffffffffa529e07d
>> #1 [ffffaedd009f7840] schedule at ffffffffa529e4ff
>> #2 [ffffaedd009f7850] schedule_preempt_disabled at ffffffffa529e80a
>> #3 [ffffaedd009f7858] __mutex_lock at ffffffffa529fdcb <--- goes to sle=
ep, never wakes up.
>> #4 [ffffaedd009f78f8] btrfs_delayed_update_inode at ffffffffc03e3143 [b=
trfs] <-- tries to acquire the mutex
>> #5 [ffffaedd009f7950] btrfs_update_inode at ffffffffc0385ba8 [btrfs]   =
<-- This is the same inode that pid 6963 is holding
>> #6 [ffffaedd009f7978] cow_file_range_inline.constprop.78 at ffffffffc03=
86be7 [btrfs]
>> #7 [ffffaedd009f7a30] cow_file_range at ffffffffc03879c1 [btrfs]
>> #8 [ffffaedd009f7ab8] btrfs_run_delalloc_range at ffffffffc038894c [btr=
fs]
>> #9 [ffffaedd009f7b40] writepage_delalloc at ffffffffc03a3c8f [btrfs]
>> #10 [ffffaedd009f7ba0] __extent_writepage at ffffffffc03a4c01 [btrfs]
>> #11 [ffffaedd009f7c08] extent_write_cache_pages at ffffffffc03a500b [bt=
rfs]
>> #12 [ffffaedd009f7d08] extent_writepages at ffffffffc03a6de2 [btrfs]
>> #13 [ffffaedd009f7d38] do_writepages at ffffffffa4c277eb
>> #14 [ffffaedd009f7db8] __filemap_fdatawrite_range at ffffffffa4c1e5bb
>> #15 [ffffaedd009f7e40] btrfs_run_delalloc_work at ffffffffc0380987 [btr=
fs] <-- starts running delayed nodes
>> #16 [ffffaedd009f7e58] normal_work_helper at ffffffffc03b706c [btrfs]
>> #17 [ffffaedd009f7e98] process_one_work at ffffffffa4aba4e4
>> #18 [ffffaedd009f7ed8] worker_thread at ffffffffa4aba6fd
>> #19 [ffffaedd009f7f10] kthread at ffffffffa4ac0a3d
>> #20 [ffffaedd009f7f50] ret_from_fork at ffffffffa54001ff
>
> To fully address those cases the complete fix is to never issue any
> flushing while holding the transaction or the delayed node lock. This
> patch achieves it by calling qgroup_reserve_meta directly which will
> either succeed without flushing or will fail and return -EDQUOT. In the
> latter case that return value is going to be propagated to
> btrfs_dirty_inode which will fallback to start a new transaction. That's
> fine as the majority of time we expect the inode will have
> BTRFS_DELAYED_NODE_INODE_DIRTY flag set which will result in directly
> copying the in-memory state.
>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

The fix is indeed much better.

It avoids the performance regression from my previous
btrfs_dirty_inode() fix, but still remove the flush in the context.

With merge with previous patch, feel free to add:

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/delayed-inode.c | 3 ++-
>   fs/btrfs/inode.c         | 2 +-
>   2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> index ac9966e76a2f..6dcf2cd1b39e 100644
> --- a/fs/btrfs/delayed-inode.c
> +++ b/fs/btrfs/delayed-inode.c
> @@ -627,7 +627,8 @@ static int btrfs_delayed_inode_reserve_metadata(
>   	 */
>   	if (!src_rsv || (!trans->bytes_reserved &&
>   			 src_rsv->type !=3D BTRFS_BLOCK_RSV_DELALLOC)) {
> -		ret =3D btrfs_qgroup_reserve_meta_prealloc(root, num_bytes, true);
> +		ret =3D qgroup_reserve_meta(root, num_bytes,
> +					  BTRFS_QGROUP_RSV_META_PREALLOC, true);
>   		if (ret < 0)
>   			return ret;
>   		ret =3D btrfs_block_rsv_add(root, dst_rsv, num_bytes,
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 547d6c1287d5..bf2d0d3ae7c5 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -6081,7 +6081,7 @@ static int btrfs_dirty_inode(struct inode *inode)
>   		return PTR_ERR(trans);
>
>   	ret =3D btrfs_update_inode(trans, root, BTRFS_I(inode));
> -	if (ret && ret =3D=3D -ENOSPC) {
> +	if (ret && (ret =3D=3D -ENOSPC || ret =3D=3D -EDQUOT)) {
>   		/* whoops, lets try again with the full transaction */
>   		btrfs_end_transaction(trans);
>   		trans =3D btrfs_start_transaction(root, 1);
>
