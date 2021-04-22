Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03C0367F6A
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Apr 2021 13:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236149AbhDVLRf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Apr 2021 07:17:35 -0400
Received: from mout.gmx.net ([212.227.17.22]:34671 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235937AbhDVLRe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Apr 2021 07:17:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1619090216;
        bh=/roUwf88lwTIKBFVojmoiIJxbkUXEqSenGyQs4YEXvk=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=g0L9il6Mz+2SLmFttGWvH9/P64OKi7+1VeKyB8yLwSfvbGAJm6/5wp53J4jgwTCCi
         Ez7HnCekzysKG7CUgZiqwOwl2B4DR56KnuKuSwxDf6cnx6qKv2KLfL7kvKNVRzqaSt
         /K7ijdkm/ke6rHBwgbQbhISNurIRnI2PMXapMYO4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MWici-1m6TTr33pg-00X0E3; Thu, 22
 Apr 2021 13:16:56 +0200
Subject: Re: [PATCH] btrfs: fix deadlock when cloning inline extents and using
 qgroups
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <d098a031cc7d59823711dd37f3f5f4b4c56c04be.1619087885.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <251af61c-deeb-0cb8-068a-b700dead99b7@gmx.com>
Date:   Thu, 22 Apr 2021 19:16:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <d098a031cc7d59823711dd37f3f5f4b4c56c04be.1619087885.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:M/3YuKAQU10zzT2qJPUrb35XyCDCg1/9dc6d0X2YzkG8+//yoba
 bosGW5XSPQDAZU9DMlvP0Tevgfv3b3HsklV5ASf1BAk4v2D8WH/6OUFLRLidiEkKLhOQ55m
 pmloUI6WDRhx83OXPzDVo7hpa5V1dBxKTeJsX3H6tfAR0ZzcplCrptHEyxjAvn4OVCQF3yo
 DPWIjDnOWV/w2Yim4tSdg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:InQ3ICIHlF8=:mj0A59Zu+L95R3LcLrY9iX
 6X1p/031EkuGPpddNTg8x73SfZDKHKr+BJ6Q3ksu22oo1MHJRYF2rxes9N1PtFPEdbHXTzDyY
 fm7AIx0lcvyg+9ZZUYFC6hybRiLfV7u33t2pMKidcP9xqm0UBgwRiyXVq1vIAUnglYLF+oLwA
 XvcBd3sjRK9JebrPJz/dAyjfSzNaUywuBKHRiPJ0hdsq7dwfezo4AoTypUh93Lcd3Ge/43bwH
 AtsluJmK/HF6LaHjXh87gt/wuJ92jKligifx3fbLO3I/OEX8VGJosquNainmQMpMg1IAw2oDz
 ORlEJeXuBz1mtD8fNNfCsWqnzA5DL/RKAu+cP55X3l2TYzTCJt2pNDmnRkrArvzUhdgPMFfim
 IOD4/SxaRUWDPq2tQ31Bq+c+yj64rqsXqAsVk/HBXx3ah0liO544rMUKum/HDVCdEde6drlLU
 xNUOTboKmTO16pCpdZI0SPyNpkR79Eo4CcxSSRJtIlW+nij3mffGyI3pMTpVY4PxVD0eCvYB/
 18gimzNiZawmeVIzQl7SqPkdVZAW/t3wEYjVjRCYZOd8hPwo1K0yXmEMGG0kr3SRLm5bsKg4l
 N9/exR4hsboaKSvnR71PodXyZ+N2IUp3YyWTTOQzq4AyHZ7Lgps5vBjwRlbYpt3qqNmhz41/s
 7w+jAOXqUjVzDzsyCwJDX1uYw9q+IJdcQJLDzy/Pyfu4AyFvWblSLBtNkypd2sSmARqcftNkd
 WVI0pAsLn2fdXRmoF0x17wLhirfDzTEEs4RJ5OIliLLOg6XeNz58Dl0Gb5n6OHoOY5VcXr1tU
 0Npwwr/k/eR3ezqtx3lF+w66oaWeoHdsc0U6GeLMztaFHAFVU9LlUTZTorh92DBWairu3SFH7
 IWacTWnN02dq9jOEY/m0E+/L8RlGDp04d+ebAncdeOQbSPNRiGd6/V1AqexsTAuTZFpYLvrUn
 ziw+2+6bHxpqrmuHxTyLe59b8IxUYVIDvxhk8P3khdjFAdVeeFxtPJmnmzZNVFKilVfFPdnR8
 Fkm8iVn4fwvFp4EakYZoBXZePE3Cj6JuxkLUrCcKH6ZEbbtVSbD6l2OQCeEoZIpXmVcQ3Ivf0
 JFv4tWMm/aqlBeI/IjMJQgffK5OYLwGkX4JRzKkZElWNiIE1Uor340HGZkFI7aj2fYN2Lzr2k
 wof1auazHu0zjHBCTeN7SkUj5Cb2UlosGld3p1geDQ1bVc1QqqN+FgOdDZLO/gle05re+qP0R
 3J6WIHPCpDsZB24rQ
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/4/22 =E4=B8=8B=E5=8D=887:08, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> There are a few exceptional cases where cloning an inline extent needs t=
o
> copy the inline extent data into a page of the destination inode.
>
> When this happens, we end up starting a transaction while having a dirty
> page for the destination inode and while having the range locked in the
> destination's inode iotree too. Because when reserving metadata space
> for a transaction we may need to flush existing delalloc in case there i=
s
> not enough free space, we have a mechanism in place to prevent a deadloc=
k,
> which was introduced in commit 3d45f221ce627d ("btrfs: fix deadlock when
> cloning inline extent and low on free metadata space").
>
> However when using qgroups, a transaction also reserves metadata qgroup
> space, which can also result in flushing delalloc in case there is not
> enough available space at the moment. When this happens we deadlock, sin=
ce
> flushing delalloc requires locking the file range in the inode's iotree
> and the range was already locked at the very beginning of the clone
> operation, before attempting to start the transaction.
>
> When this issue happens, stack traces like the following are reported:
>
> [72747.556262] task:kworker/u81:9   state:D stack:    0 pid:  225 ppid: =
    2 flags:0x00004000
> [72747.556268] Workqueue: writeback wb_workfn (flush-btrfs-1142)
> [72747.556271] Call Trace:
> [72747.556273]  __schedule+0x296/0x760
> [72747.556277]  schedule+0x3c/0xa0
> [72747.556279]  io_schedule+0x12/0x40
> [72747.556284]  __lock_page+0x13c/0x280
> [72747.556287]  ? generic_file_readonly_mmap+0x70/0x70
> [72747.556325]  extent_write_cache_pages+0x22a/0x440 [btrfs]
> [72747.556331]  ? __set_page_dirty_nobuffers+0xe7/0x160
> [72747.556358]  ? set_extent_buffer_dirty+0x5e/0x80 [btrfs]
> [72747.556362]  ? update_group_capacity+0x25/0x210
> [72747.556366]  ? cpumask_next_and+0x1a/0x20
> [72747.556391]  extent_writepages+0x44/0xa0 [btrfs]
> [72747.556394]  do_writepages+0x41/0xd0
> [72747.556398]  __writeback_single_inode+0x39/0x2a0
> [72747.556403]  writeback_sb_inodes+0x1ea/0x440
> [72747.556407]  __writeback_inodes_wb+0x5f/0xc0
> [72747.556410]  wb_writeback+0x235/0x2b0
> [72747.556414]  ? get_nr_inodes+0x35/0x50
> [72747.556417]  wb_workfn+0x354/0x490
> [72747.556420]  ? newidle_balance+0x2c5/0x3e0
> [72747.556424]  process_one_work+0x1aa/0x340
> [72747.556426]  worker_thread+0x30/0x390
> [72747.556429]  ? create_worker+0x1a0/0x1a0
> [72747.556432]  kthread+0x116/0x130
> [72747.556435]  ? kthread_park+0x80/0x80
> [72747.556438]  ret_from_fork+0x1f/0x30
>
> [72747.566958] Workqueue: btrfs-flush_delalloc btrfs_work_helper [btrfs]
> [72747.566961] Call Trace:
> [72747.566964]  __schedule+0x296/0x760
> [72747.566968]  ? finish_wait+0x80/0x80
> [72747.566970]  schedule+0x3c/0xa0
> [72747.566995]  wait_extent_bit.constprop.68+0x13b/0x1c0 [btrfs]
> [72747.566999]  ? finish_wait+0x80/0x80
> [72747.567024]  lock_extent_bits+0x37/0x90 [btrfs]
> [72747.567047]  btrfs_invalidatepage+0x299/0x2c0 [btrfs]
> [72747.567051]  ? find_get_pages_range_tag+0x2cd/0x380
> [72747.567076]  __extent_writepage+0x203/0x320 [btrfs]
> [72747.567102]  extent_write_cache_pages+0x2bb/0x440 [btrfs]
> [72747.567106]  ? update_load_avg+0x7e/0x5f0
> [72747.567109]  ? enqueue_entity+0xf4/0x6f0
> [72747.567134]  extent_writepages+0x44/0xa0 [btrfs]
> [72747.567137]  ? enqueue_task_fair+0x93/0x6f0
> [72747.567140]  do_writepages+0x41/0xd0
> [72747.567144]  __filemap_fdatawrite_range+0xc7/0x100
> [72747.567167]  btrfs_run_delalloc_work+0x17/0x40 [btrfs]
> [72747.567195]  btrfs_work_helper+0xc2/0x300 [btrfs]
> [72747.567200]  process_one_work+0x1aa/0x340
> [72747.567202]  worker_thread+0x30/0x390
> [72747.567205]  ? create_worker+0x1a0/0x1a0
> [72747.567208]  kthread+0x116/0x130
> [72747.567211]  ? kthread_park+0x80/0x80
> [72747.567214]  ret_from_fork+0x1f/0x30
>
> [72747.569686] task:fsstress        state:D stack:    0 pid:841421 ppid:=
841417 flags:0x00000000
> [72747.569689] Call Trace:
> [72747.569691]  __schedule+0x296/0x760
> [72747.569694]  schedule+0x3c/0xa0
> [72747.569721]  try_flush_qgroup+0x95/0x140 [btrfs]
> [72747.569725]  ? finish_wait+0x80/0x80
> [72747.569753]  btrfs_qgroup_reserve_data+0x34/0x50 [btrfs]
> [72747.569781]  btrfs_check_data_free_space+0x5f/0xa0 [btrfs]
> [72747.569804]  btrfs_buffered_write+0x1f7/0x7f0 [btrfs]
> [72747.569810]  ? path_lookupat.isra.48+0x97/0x140
> [72747.569833]  btrfs_file_write_iter+0x81/0x410 [btrfs]
> [72747.569836]  ? __kmalloc+0x16a/0x2c0
> [72747.569839]  do_iter_readv_writev+0x160/0x1c0
> [72747.569843]  do_iter_write+0x80/0x1b0
> [72747.569847]  vfs_writev+0x84/0x140
> [72747.569869]  ? btrfs_file_llseek+0x38/0x270 [btrfs]
> [72747.569873]  do_writev+0x65/0x100
> [72747.569876]  do_syscall_64+0x33/0x40
> [72747.569879]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> [72747.569899] task:fsstress        state:D stack:    0 pid:841424 ppid:=
841417 flags:0x00004000
> [72747.569903] Call Trace:
> [72747.569906]  __schedule+0x296/0x760
> [72747.569909]  schedule+0x3c/0xa0
> [72747.569936]  try_flush_qgroup+0x95/0x140 [btrfs]
> [72747.569940]  ? finish_wait+0x80/0x80
> [72747.569967]  __btrfs_qgroup_reserve_meta+0x36/0x50 [btrfs]
> [72747.569989]  start_transaction+0x279/0x580 [btrfs]
> [72747.570014]  clone_copy_inline_extent+0x332/0x490 [btrfs]
> [72747.570041]  btrfs_clone+0x5b7/0x7a0 [btrfs]
> [72747.570068]  ? lock_extent_bits+0x64/0x90 [btrfs]
> [72747.570095]  btrfs_clone_files+0xfc/0x150 [btrfs]
> [72747.570122]  btrfs_remap_file_range+0x3d8/0x4a0 [btrfs]
> [72747.570126]  do_clone_file_range+0xed/0x200
> [72747.570131]  vfs_clone_file_range+0x37/0x110
> [72747.570134]  ioctl_file_clone+0x7d/0xb0
> [72747.570137]  do_vfs_ioctl+0x138/0x630
> [72747.570140]  __x64_sys_ioctl+0x62/0xc0
> [72747.570143]  do_syscall_64+0x33/0x40
> [72747.570146]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> So fix this by skipping the flush of delalloc for an inode that is
> flagged with BTRFS_INODE_NO_DELALLOC_FLUSH, meaning it is currently unde=
r
> such a special case of cloning an inline extent, when flushing delalloc
> during qgroup metadata reservation.
>
> The special cases for cloning inline extents were added in kernel 5.7 by
> by commit 05a5a7621ce66c ("Btrfs: implement full reflink support for
> inline extents"), while having qgroup metadata space reservation flushin=
g
> delalloc when low on space was added in kernel 5.9 by commit
> c53e9653605dbf ("btrfs: qgroup: try to flush qgroup space when we get
> -EDQUOT"). So use a "Fixes:" tag for the later commit to ease stable
> kernel backports.
>
> Reported-by: Wang Yugui <wangyugui@e16-tech.com>
> Link: https://lore.kernel.org/linux-btrfs/20210421083137.31E3.409509F4@e=
16-tech.com/
> Fixes: c53e9653605dbf ("btrfs: qgroup: try to flush qgroup space when we=
 get -EDQUOT")
> CC: stable@vger.kernel.org # 5.9+
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/ctree.h  | 3 ++-
>   fs/btrfs/inode.c  | 5 +++--
>   fs/btrfs/ioctl.c  | 2 +-
>   fs/btrfs/qgroup.c | 2 +-
>   fs/btrfs/send.c   | 4 ++--
>   5 files changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 278e0cbc9a98..1807e7a8d1d7 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3127,7 +3127,8 @@ int btrfs_truncate_inode_items(struct btrfs_trans_=
handle *trans,
>   			       struct btrfs_inode *inode, u64 new_size,
>   			       u32 min_type);
>
> -int btrfs_start_delalloc_snapshot(struct btrfs_root *root);
> +int btrfs_start_delalloc_snapshot(struct btrfs_root *root,
> +				  bool in_reclaim_context);
>   int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, long nr,
>   			       bool in_reclaim_context);
>   int btrfs_set_extent_delalloc(struct btrfs_inode *inode, u64 start, u6=
4 end,
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 1a349759efae..23854d180e94 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -9691,7 +9691,8 @@ static int start_delalloc_inodes(struct btrfs_root=
 *root,
>   	return ret;
>   }
>
> -int btrfs_start_delalloc_snapshot(struct btrfs_root *root)
> +int btrfs_start_delalloc_snapshot(struct btrfs_root *root,
> +				  bool in_reclaim_context)
>   {
>   	struct writeback_control wbc =3D {
>   		.nr_to_write =3D LONG_MAX,
> @@ -9704,7 +9705,7 @@ int btrfs_start_delalloc_snapshot(struct btrfs_roo=
t *root)
>   	if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state))
>   		return -EROFS;
>
> -	return start_delalloc_inodes(root, &wbc, true, false);
> +	return start_delalloc_inodes(root, &wbc, true, in_reclaim_context);
>   }
>
>   int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, long nr,
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index b1328f17607e..0ba0e4ddaf6b 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1051,7 +1051,7 @@ static noinline int btrfs_mksnapshot(const struct =
path *parent,
>   	 */
>   	btrfs_drew_read_lock(&root->snapshot_lock);
>
> -	ret =3D btrfs_start_delalloc_snapshot(root);
> +	ret =3D btrfs_start_delalloc_snapshot(root, false);
>   	if (ret)
>   		goto out;
>
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 2319c923c9e6..366a6a289796 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -3562,7 +3562,7 @@ static int try_flush_qgroup(struct btrfs_root *roo=
t)
>   		return 0;
>   	}
>
> -	ret =3D btrfs_start_delalloc_snapshot(root);
> +	ret =3D btrfs_start_delalloc_snapshot(root, true);
>   	if (ret < 0)
>   		goto out;
>   	btrfs_wait_ordered_extents(root, U64_MAX, 0, (u64)-1);
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index 55741adf9071..bd69db72acc5 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -7170,7 +7170,7 @@ static int flush_delalloc_roots(struct send_ctx *s=
ctx)
>   	int i;
>
>   	if (root) {
> -		ret =3D btrfs_start_delalloc_snapshot(root);
> +		ret =3D btrfs_start_delalloc_snapshot(root, false);
>   		if (ret)
>   			return ret;
>   		btrfs_wait_ordered_extents(root, U64_MAX, 0, U64_MAX);
> @@ -7178,7 +7178,7 @@ static int flush_delalloc_roots(struct send_ctx *s=
ctx)
>
>   	for (i =3D 0; i < sctx->clone_roots_cnt; i++) {
>   		root =3D sctx->clone_roots[i].root;
> -		ret =3D btrfs_start_delalloc_snapshot(root);
> +		ret =3D btrfs_start_delalloc_snapshot(root, false);
>   		if (ret)
>   			return ret;
>   		btrfs_wait_ordered_extents(root, U64_MAX, 0, U64_MAX);
>
