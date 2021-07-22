Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 155853D1AB0
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jul 2021 02:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhGUXlB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jul 2021 19:41:01 -0400
Received: from mout.gmx.net ([212.227.15.18]:34817 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229679AbhGUXlB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jul 2021 19:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626913293;
        bh=bFhOMgoqt1NyLEROyUlDmBd6c43jfnM3hxtyn6P7Dz8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=XEJzj3Lm/dDqav1SCnNh4ZlnfAmfM9Y0wMFyLRyt29CAmEPflRpz+va922Y4CXDb9
         WLCVKWL/MJ54yYDSGZ71TS5Kwz0pa2P4qFz0/uj2QEOr+7JIYZCVUjs093hh5Sr+dk
         gZucHKEweT2r2yF0tnxB/9vtU2N9zBKgsAThpd6I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MCKBc-1ly4kA3sME-009Oo8; Thu, 22
 Jul 2021 02:21:33 +0200
Subject: Re: [PATCH] btrfs: fix lock inversion problem when doing qgroup
 extent tracing
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <19938c9b47e3e14784c9d17f062da1a51261864f.1626885079.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <7b8603ba-ea95-597b-d240-cd9782955189@gmx.com>
Date:   Thu, 22 Jul 2021 08:21:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <19938c9b47e3e14784c9d17f062da1a51261864f.1626885079.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:d3Aa24B4yIQ82bqNbJexZg0AJfmFey9AIGDX2HtcaNcHTzt891R
 dOKb6fwWY1h6nMLmH9uoqV26Y4on9RrDpiZqEqqWzGSgxNtq/4bQ00RcPqJa+IzerqKGqPX
 SXNkLZGzfDWf0tF8Z0ajhYB+8a29UEIegFDyzu2WRR15V1/baminQOkAXqxv9eDByZZ1ED1
 GqaQrVeeXeieuwP2yA8Pw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:avVVoxoTojk=:BsOgzXiVaCrgHckMLDlqqm
 P3AWoB3XCvVoiG4R97Sod/yJd5+GqoZ2PIKeFRwp9Oq0uD4ddGugInSloD32i+IXFIKKSKVFx
 N1X+kznhMIDS0ntNlambfnSYNeYx4CLb2UadeT+x7y6DuHYQHYM02h4RuPrDPwHhqiCxbxSVF
 HsH0rbJNBcvqAYcVR9EdofhHdR/AQEAoBCGAOmnaftXxrcI7+CdJOZgv/Te2Fa5rVRWFiNbtG
 jgTzL/Llj/0PpfyMgesxmjBKuTHdIVZTEp5q5Xgy3d54mMuKSGVHeezA6eTQY8eB5PwL1ZgrL
 deRFg5Pn3iEACfBFsSNzLaD45rQGQhXXO2CrG5R/HpkjpSZyOL2Ntpa1ob4EgK2CgasXwePQx
 DP9PmKWZzhF0n4+qcI6UMuX8TK0x6M7eiN+EqpRmHAaIhbyNnNAIuvjITxHRXfjj3DhI4WmpR
 3nV1/PyokPLmAOcspMetCvX9hU15GjCmP/9v8ddXJnJ9tyw8SBz0XQlPEmJElGwvGiP6qeOYT
 1X4ImZkYOXp3JdMT6DvhSPEj4VYXOsf0V/qCp+AQ3sGY7x4G04rsA7xJYgEc33EQK9dMoMCTL
 kWwqv8BF6T4UEqXF7O2+y8iwbtx2H744HJLozNXem4+E/b4B6kNIEPBvt4xJK16TfdyZcXvaP
 zIb3Rdcpo9JpJyypBH7KleDr0FXrwNZHqWnBYfhZ/00qZfRPI/IRc/UY1vpC3Nlvda9efhYws
 qF7EiJlzX275u9IkUBm+GkPfe6KsPyWcCY2y1EfSThbQQYcCPPnLp+Hu4WRHVGkhZafGmeFDU
 5lAsqv/3D+B9GLkd4trOWjZryUtjIx07NnI2UhypRSp7Y8nerXsV1CMDBJny7KevctRymk/y3
 v9EK2/riQx3YGl6f5Ie1G/rW8Q6nd9m6Q0Gpht+SfYybfrscRJWdNnmR1iaZB564lEMx3vsrL
 4pd2QH6B7PuwicSofAapCLXdg99236F/bkQCva/SQDErOd1aGandPd9xTAP3Rq0V3ZK26cjVB
 gd8o0GEHmGbbwgPzpeFitIZTCgqWWygVDLSFpozx0ODpwt2Al0J0iHM539N19QeturcinkZV0
 4f7C9V06wZZUpaE/XnoS5wPlFK7/8wt61VjvzW8wUwn027KxJ15zRVBXw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/22 =E4=B8=8A=E5=8D=8812:31, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> At btrfs_qgroup_trace_extent_post() we call btrfs_find_all_roots() with =
a
> NULL value as the transaction handle argument, which makes that function
> take the commit_root_sem semaphore, which is necessary when we don't hol=
d
> a transaction handle or any other mechanism to prevent a transaction
> commit from wiping out commit roots.
>
> However btrfs_qgroup_trace_extent_post() can be called in a context wher=
e
> we are holding a write lock on an extent buffer from a subvolume tree,
> namely from btrfs_truncate_inode_items(), called either during truncate
> or unlink operations. In this case we end up with a lock inversion probl=
em
> because the commit_root_sem is a higher level lock, always supposed to b=
e
> acquired before locking any extent buffer.
>
> Lockdep detects this lock inversion problem since we switched the extent
> buffer locks from custom locks to semaphores, and when running btrfs/158
> from fstests, it reported the following trace:
>
> [ 9057.626435] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [ 9057.627541] WARNING: possible circular locking dependency detected
> [ 9057.628334] 5.14.0-rc2-btrfs-next-93 #1 Not tainted
> [ 9057.628961] ------------------------------------------------------
> [ 9057.629867] kworker/u16:4/30781 is trying to acquire lock:
> [ 9057.630824] ffff8e2590f58760 (btrfs-tree-00){++++}-{3:3}, at: __btrfs=
_tree_read_lock+0x24/0x110 [btrfs]
> [ 9057.632542]
>                 but task is already holding lock:
> [ 9057.633551] ffff8e25582d4b70 (&fs_info->commit_root_sem){++++}-{3:3},=
 at: iterate_extent_inodes+0x10b/0x280 [btrfs]
> [ 9057.635255]
>                 which lock already depends on the new lock.
>
> [ 9057.636292]
>                 the existing dependency chain (in reverse order) is:
> [ 9057.637240]
>                 -> #1 (&fs_info->commit_root_sem){++++}-{3:3}:
> [ 9057.638138]        down_read+0x46/0x140
> [ 9057.638648]        btrfs_find_all_roots+0x41/0x80 [btrfs]
> [ 9057.639398]        btrfs_qgroup_trace_extent_post+0x37/0x70 [btrfs]
> [ 9057.640283]        btrfs_add_delayed_data_ref+0x418/0x490 [btrfs]
> [ 9057.641114]        btrfs_free_extent+0x35/0xb0 [btrfs]
> [ 9057.641819]        btrfs_truncate_inode_items+0x424/0xf70 [btrfs]
> [ 9057.642643]        btrfs_evict_inode+0x454/0x4f0 [btrfs]
> [ 9057.643418]        evict+0xcf/0x1d0
> [ 9057.643895]        do_unlinkat+0x1e9/0x300
> [ 9057.644525]        do_syscall_64+0x3b/0xc0
> [ 9057.645110]        entry_SYSCALL_64_after_hwframe+0x44/0xae
> [ 9057.645835]
>                 -> #0 (btrfs-tree-00){++++}-{3:3}:
> [ 9057.646600]        __lock_acquire+0x130e/0x2210
> [ 9057.647248]        lock_acquire+0xd7/0x310
> [ 9057.647773]        down_read_nested+0x4b/0x140
> [ 9057.648350]        __btrfs_tree_read_lock+0x24/0x110 [btrfs]
> [ 9057.649175]        btrfs_read_lock_root_node+0x31/0x40 [btrfs]
> [ 9057.650010]        btrfs_search_slot+0x537/0xc00 [btrfs]
> [ 9057.650849]        scrub_print_warning_inode+0x89/0x370 [btrfs]
> [ 9057.651733]        iterate_extent_inodes+0x1e3/0x280 [btrfs]
> [ 9057.652501]        scrub_print_warning+0x15d/0x2f0 [btrfs]
> [ 9057.653264]        scrub_handle_errored_block.isra.0+0x135f/0x1640 [b=
trfs]
> [ 9057.654295]        scrub_bio_end_io_worker+0x101/0x2e0 [btrfs]
> [ 9057.655111]        btrfs_work_helper+0xf8/0x400 [btrfs]
> [ 9057.655831]        process_one_work+0x247/0x5a0
> [ 9057.656425]        worker_thread+0x55/0x3c0
> [ 9057.656993]        kthread+0x155/0x180
> [ 9057.657494]        ret_from_fork+0x22/0x30
> [ 9057.658030]
>                 other info that might help us debug this:
>
> [ 9057.659064]  Possible unsafe locking scenario:
>
> [ 9057.659824]        CPU0                    CPU1
> [ 9057.660402]        ----                    ----
> [ 9057.660988]   lock(&fs_info->commit_root_sem);
> [ 9057.661581]                                lock(btrfs-tree-00);
> [ 9057.662348]                                lock(&fs_info->commit_root=
_sem);
> [ 9057.663254]   lock(btrfs-tree-00);
> [ 9057.663690]
>                  *** DEADLOCK ***
>
> [ 9057.664437] 4 locks held by kworker/u16:4/30781:
> [ 9057.665023]  #0: ffff8e25922a1148 ((wq_completion)btrfs-scrub){+.+.}-=
{0:0}, at: process_one_work+0x1c7/0x5a0
> [ 9057.666260]  #1: ffffabb3451ffe70 ((work_completion)(&work->normal_wo=
rk)){+.+.}-{0:0}, at: process_one_work+0x1c7/0x5a0
> [ 9057.667639]  #2: ffff8e25922da198 (&ret->mutex){+.+.}-{3:3}, at: scru=
b_handle_errored_block.isra.0+0x5d2/0x1640 [btrfs]
> [ 9057.669017]  #3: ffff8e25582d4b70 (&fs_info->commit_root_sem){++++}-{=
3:3}, at: iterate_extent_inodes+0x10b/0x280 [btrfs]
> [ 9057.670408]
>                 stack backtrace:
> [ 9057.670976] CPU: 7 PID: 30781 Comm: kworker/u16:4 Not tainted 5.14.0-=
rc2-btrfs-next-93 #1
> [ 9057.672030] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BI=
OS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> [ 9057.673492] Workqueue: btrfs-scrub btrfs_work_helper [btrfs]
> [ 9057.674258] Call Trace:
> [ 9057.674588]  dump_stack_lvl+0x57/0x72
> [ 9057.675083]  check_noncircular+0xf3/0x110
> [ 9057.675611]  __lock_acquire+0x130e/0x2210
> [ 9057.676132]  lock_acquire+0xd7/0x310
> [ 9057.676605]  ? __btrfs_tree_read_lock+0x24/0x110 [btrfs]
> [ 9057.677313]  ? lock_is_held_type+0xe8/0x140
> [ 9057.677849]  down_read_nested+0x4b/0x140
> [ 9057.678349]  ? __btrfs_tree_read_lock+0x24/0x110 [btrfs]
> [ 9057.679068]  __btrfs_tree_read_lock+0x24/0x110 [btrfs]
> [ 9057.679760]  btrfs_read_lock_root_node+0x31/0x40 [btrfs]
> [ 9057.680458]  btrfs_search_slot+0x537/0xc00 [btrfs]
> [ 9057.681083]  ? _raw_spin_unlock+0x29/0x40
> [ 9057.681594]  ? btrfs_find_all_roots_safe+0x11f/0x140 [btrfs]
> [ 9057.682336]  scrub_print_warning_inode+0x89/0x370 [btrfs]
> [ 9057.683058]  ? btrfs_find_all_roots_safe+0x11f/0x140 [btrfs]
> [ 9057.683834]  ? scrub_write_block_to_dev_replace+0xb0/0xb0 [btrfs]
> [ 9057.684632]  iterate_extent_inodes+0x1e3/0x280 [btrfs]
> [ 9057.685316]  scrub_print_warning+0x15d/0x2f0 [btrfs]
> [ 9057.685977]  ? ___ratelimit+0xa4/0x110
> [ 9057.686460]  scrub_handle_errored_block.isra.0+0x135f/0x1640 [btrfs]
> [ 9057.687316]  scrub_bio_end_io_worker+0x101/0x2e0 [btrfs]
> [ 9057.688021]  btrfs_work_helper+0xf8/0x400 [btrfs]
> [ 9057.688649]  ? lock_is_held_type+0xe8/0x140
> [ 9057.689180]  process_one_work+0x247/0x5a0
> [ 9057.689696]  worker_thread+0x55/0x3c0
> [ 9057.690175]  ? process_one_work+0x5a0/0x5a0
> [ 9057.690731]  kthread+0x155/0x180
> [ 9057.691158]  ? set_kthread_struct+0x40/0x40
> [ 9057.691697]  ret_from_fork+0x22/0x30
>
> Fix this by making btrfs_find_all_roots() never attempt to lock the
> commit_root_sem when it is called from btrfs_qgroup_trace_extent_post().
>
> We can't just pass a non-NULL transaction handle to btrfs_find_all_roots=
()
> from btrfs_qgroup_trace_extent_post(), because that would make backref
> lookup not use commit roots and acquire read locks on extent buffers, an=
d
> therefore could deadlock when btrfs_qgroup_trace_extent_post() is called
> from the btrfs_truncate_inode_items() code path which has acquired a wri=
te
> lock on an extent buffer of the subvolume btree.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/backref.c            |  6 +++---
>   fs/btrfs/backref.h            |  3 ++-
>   fs/btrfs/delayed-ref.c        |  4 ++--
>   fs/btrfs/qgroup.c             | 38 +++++++++++++++++++++++++++--------
>   fs/btrfs/qgroup.h             |  2 +-
>   fs/btrfs/tests/qgroup-tests.c | 20 +++++++++---------
>   6 files changed, 48 insertions(+), 25 deletions(-)
>
> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> index 7a8a2fc19533..78b202d198b8 100644
> --- a/fs/btrfs/backref.c
> +++ b/fs/btrfs/backref.c
> @@ -1488,15 +1488,15 @@ static int btrfs_find_all_roots_safe(struct btrf=
s_trans_handle *trans,
>   int btrfs_find_all_roots(struct btrfs_trans_handle *trans,
>   			 struct btrfs_fs_info *fs_info, u64 bytenr,
>   			 u64 time_seq, struct ulist **roots,
> -			 bool ignore_offset)
> +			 bool ignore_offset, bool skip_commit_root_sem)
>   {
>   	int ret;
>
> -	if (!trans)
> +	if (!trans && !skip_commit_root_sem)
>   		down_read(&fs_info->commit_root_sem);
>   	ret =3D btrfs_find_all_roots_safe(trans, fs_info, bytenr,
>   					time_seq, roots, ignore_offset);
> -	if (!trans)
> +	if (!trans && !skip_commit_root_sem)
>   		up_read(&fs_info->commit_root_sem);
>   	return ret;
>   }
> diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
> index 17abde7f794c..ff5f07f9940b 100644
> --- a/fs/btrfs/backref.h
> +++ b/fs/btrfs/backref.h
> @@ -47,7 +47,8 @@ int btrfs_find_all_leafs(struct btrfs_trans_handle *tr=
ans,
>   			 const u64 *extent_item_pos, bool ignore_offset);
>   int btrfs_find_all_roots(struct btrfs_trans_handle *trans,
>   			 struct btrfs_fs_info *fs_info, u64 bytenr,
> -			 u64 time_seq, struct ulist **roots, bool ignore_offset);
> +			 u64 time_seq, struct ulist **roots, bool ignore_offset,
> +			 bool skip_commit_root_sem);
>   char *btrfs_ref_to_path(struct btrfs_root *fs_root, struct btrfs_path =
*path,
>   			u32 name_len, unsigned long name_off,
>   			struct extent_buffer *eb_in, u64 parent,
> diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> index 06bc842ecdb3..ca848b183474 100644
> --- a/fs/btrfs/delayed-ref.c
> +++ b/fs/btrfs/delayed-ref.c
> @@ -974,7 +974,7 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_ha=
ndle *trans,
>   		kmem_cache_free(btrfs_delayed_tree_ref_cachep, ref);
>
>   	if (qrecord_inserted)
> -		btrfs_qgroup_trace_extent_post(fs_info, record);
> +		btrfs_qgroup_trace_extent_post(trans, record);
>
>   	return 0;
>   }
> @@ -1069,7 +1069,7 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_=
handle *trans,
>
>
>   	if (qrecord_inserted)
> -		return btrfs_qgroup_trace_extent_post(fs_info, record);
> +		return btrfs_qgroup_trace_extent_post(trans, record);
>   	return 0;
>   }
>
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 07ec06d4e972..0fa121171ca1 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -1704,17 +1704,39 @@ int btrfs_qgroup_trace_extent_nolock(struct btrf=
s_fs_info *fs_info,
>   	return 0;
>   }
>
> -int btrfs_qgroup_trace_extent_post(struct btrfs_fs_info *fs_info,
> +int btrfs_qgroup_trace_extent_post(struct btrfs_trans_handle *trans,
>   				   struct btrfs_qgroup_extent_record *qrecord)
>   {
>   	struct ulist *old_root;
>   	u64 bytenr =3D qrecord->bytenr;
>   	int ret;
>
> -	ret =3D btrfs_find_all_roots(NULL, fs_info, bytenr, 0, &old_root, fals=
e);
> +	/*
> +	 * We are always called in a context where we are already holding a
> +	 * transaction handle. Often we are called when adding a data delayed
> +	 * reference from btrfs_truncate_inode_items() (truncating or unlinkin=
g),
> +	 * in which case we will be holding a write lock on extent buffer from=
 a
> +	 * subvolume tree. In this case we can't allow btrfs_find_all_roots() =
to
> +	 * acquire fs_info->commit_root_sem, because that is a higher level lo=
ck
> +	 * that must be acquired before locking any extent buffers.
> +	 *
> +	 * So we want btrfs_find_all_roots() to not acquire the commit_root_se=
m
> +	 * but we can't pass it a non-NULL transaction handle, because otherwi=
se
> +	 * it would not use commit roots and would lock extent buffers, causin=
g
> +	 * a deadlock if it ends up trying to read lock the same extent buffer
> +	 * that was previously write locked at btrfs_truncate_inode_items().
> +	 *
> +	 * So pass a NULL transaction handle to btrfs_find_all_roots() and
> +	 * explicitly tell it to not acquire the commit_root_sem - if we are
> +	 * holding a transaction handle we don't need its protection.
> +	 */
> +	ASSERT(trans !=3D NULL);
> +
> +	ret =3D btrfs_find_all_roots(NULL, trans->fs_info, bytenr, 0, &old_roo=
t,
> +				   false, true);
>   	if (ret < 0) {
> -		fs_info->qgroup_flags |=3D BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
> -		btrfs_warn(fs_info,
> +		trans->fs_info->qgroup_flags |=3D BTRFS_QGROUP_STATUS_FLAG_INCONSISTE=
NT;
> +		btrfs_warn(trans->fs_info,
>   "error accounting new delayed refs extent (err code: %d), quota incons=
istent",
>   			ret);
>   		return 0;
> @@ -1758,7 +1780,7 @@ int btrfs_qgroup_trace_extent(struct btrfs_trans_h=
andle *trans, u64 bytenr,
>   		kfree(record);
>   		return 0;
>   	}
> -	return btrfs_qgroup_trace_extent_post(fs_info, record);
> +	return btrfs_qgroup_trace_extent_post(trans, record);
>   }
>
>   int btrfs_qgroup_trace_leaf_items(struct btrfs_trans_handle *trans,
> @@ -2629,7 +2651,7 @@ int btrfs_qgroup_account_extents(struct btrfs_tran=
s_handle *trans)
>   				/* Search commit root to find old_roots */
>   				ret =3D btrfs_find_all_roots(NULL, fs_info,
>   						record->bytenr, 0,
> -						&record->old_roots, false);
> +						&record->old_roots, false, false);
>   				if (ret < 0)
>   					goto cleanup;
>   			}
> @@ -2645,7 +2667,7 @@ int btrfs_qgroup_account_extents(struct btrfs_tran=
s_handle *trans)
>   			 * current root. It's safe inside commit_transaction().
>   			 */
>   			ret =3D btrfs_find_all_roots(trans, fs_info,
> -				record->bytenr, BTRFS_SEQ_LAST, &new_roots, false);
> +			   record->bytenr, BTRFS_SEQ_LAST, &new_roots, false, false);
>   			if (ret < 0)
>   				goto cleanup;
>   			if (qgroup_to_skip) {
> @@ -3179,7 +3201,7 @@ static int qgroup_rescan_leaf(struct btrfs_trans_h=
andle *trans,
>   			num_bytes =3D found.offset;
>
>   		ret =3D btrfs_find_all_roots(NULL, fs_info, found.objectid, 0,
> -					   &roots, false);
> +					   &roots, false, false);
>   		if (ret < 0)
>   			goto out;
>   		/* For rescan, just pass old_roots as NULL */
> diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
> index 7283e4f549af..880e9df0dac1 100644
> --- a/fs/btrfs/qgroup.h
> +++ b/fs/btrfs/qgroup.h
> @@ -298,7 +298,7 @@ int btrfs_qgroup_trace_extent_nolock(
>    * using current root, then we can move all expensive backref walk out=
 of
>    * transaction committing, but not now as qgroup accounting will be wr=
ong again.
>    */
> -int btrfs_qgroup_trace_extent_post(struct btrfs_fs_info *fs_info,
> +int btrfs_qgroup_trace_extent_post(struct btrfs_trans_handle *trans,
>   				   struct btrfs_qgroup_extent_record *qrecord);
>
>   /*
> diff --git a/fs/btrfs/tests/qgroup-tests.c b/fs/btrfs/tests/qgroup-tests=
.c
> index f3137285a9e2..98b5aaba46f1 100644
> --- a/fs/btrfs/tests/qgroup-tests.c
> +++ b/fs/btrfs/tests/qgroup-tests.c
> @@ -224,7 +224,7 @@ static int test_no_shared_qgroup(struct btrfs_root *=
root,
>   	 * quota.
>   	 */
>   	ret =3D btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &old_roots=
,
> -			false);
> +			false, false);
>   	if (ret) {
>   		ulist_free(old_roots);
>   		test_err("couldn't find old roots: %d", ret);
> @@ -237,7 +237,7 @@ static int test_no_shared_qgroup(struct btrfs_root *=
root,
>   		return ret;
>
>   	ret =3D btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &new_roots=
,
> -			false);
> +			false, false);
>   	if (ret) {
>   		ulist_free(old_roots);
>   		ulist_free(new_roots);
> @@ -261,7 +261,7 @@ static int test_no_shared_qgroup(struct btrfs_root *=
root,
>   	new_roots =3D NULL;
>
>   	ret =3D btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &old_roots=
,
> -			false);
> +			false, false);
>   	if (ret) {
>   		ulist_free(old_roots);
>   		test_err("couldn't find old roots: %d", ret);
> @@ -273,7 +273,7 @@ static int test_no_shared_qgroup(struct btrfs_root *=
root,
>   		return -EINVAL;
>
>   	ret =3D btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &new_roots=
,
> -			false);
> +			false, false);
>   	if (ret) {
>   		ulist_free(old_roots);
>   		ulist_free(new_roots);
> @@ -325,7 +325,7 @@ static int test_multiple_refs(struct btrfs_root *roo=
t,
>   	}
>
>   	ret =3D btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &old_roots=
,
> -			false);
> +			false, false);
>   	if (ret) {
>   		ulist_free(old_roots);
>   		test_err("couldn't find old roots: %d", ret);
> @@ -338,7 +338,7 @@ static int test_multiple_refs(struct btrfs_root *roo=
t,
>   		return ret;
>
>   	ret =3D btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &new_roots=
,
> -			false);
> +			false, false);
>   	if (ret) {
>   		ulist_free(old_roots);
>   		ulist_free(new_roots);
> @@ -360,7 +360,7 @@ static int test_multiple_refs(struct btrfs_root *roo=
t,
>   	}
>
>   	ret =3D btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &old_roots=
,
> -			false);
> +			false, false);
>   	if (ret) {
>   		ulist_free(old_roots);
>   		test_err("couldn't find old roots: %d", ret);
> @@ -373,7 +373,7 @@ static int test_multiple_refs(struct btrfs_root *roo=
t,
>   		return ret;
>
>   	ret =3D btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &new_roots=
,
> -			false);
> +			false, false);
>   	if (ret) {
>   		ulist_free(old_roots);
>   		ulist_free(new_roots);
> @@ -401,7 +401,7 @@ static int test_multiple_refs(struct btrfs_root *roo=
t,
>   	}
>
>   	ret =3D btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &old_roots=
,
> -			false);
> +			false, false);
>   	if (ret) {
>   		ulist_free(old_roots);
>   		test_err("couldn't find old roots: %d", ret);
> @@ -414,7 +414,7 @@ static int test_multiple_refs(struct btrfs_root *roo=
t,
>   		return ret;
>
>   	ret =3D btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &new_roots=
,
> -			false);
> +			false, false);
>   	if (ret) {
>   		ulist_free(old_roots);
>   		ulist_free(new_roots);
>
