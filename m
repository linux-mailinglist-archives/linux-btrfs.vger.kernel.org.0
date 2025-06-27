Return-Path: <linux-btrfs+bounces-15048-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 088CCAEB7EE
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 14:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FBDE169239
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 12:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC232D3EF3;
	Fri, 27 Jun 2025 12:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5NrU681"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47FB2D3EE7
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 12:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751028200; cv=none; b=pKsuDwtrFYzsnvWt3Dxg08Wf6exEIHSec/niEclYggeYTtiZDQpH/J+lol1c3ld6iYAlw5Oy/W+hZWsFeU9+s7lKk/dSUUSchgOXT6823Eh29i9IKgI4egA9rhS+PrXFcfjj2VzYDS3OHdB3p7v0UDaGKevRAo5G+WWEYHord4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751028200; c=relaxed/simple;
	bh=5IYrJJJDkMizet8Rb8HawbyM5yjNE633YrzJ6ljSMpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ma7B0zfyo1Htn2DDw+y2EVFZYxpfb8+FhAPJCSXur/7OvKU7ZkDmJofamnLnleMEdPfperUKos+0LQVfb2A1wGQSO4BI4wl2mr7OQEC8jJmfayAe/0xLRyiVx/3hwcLEiJCYYycTptPPFCibeUBjrsEAAGQtkO6X8W959QGayzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5NrU681; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B72EC4CEF2
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 12:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751028200;
	bh=5IYrJJJDkMizet8Rb8HawbyM5yjNE633YrzJ6ljSMpI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=L5NrU681YngelDYNWhjfGTUnRN/E7sRPbULe2IykrCml3xb/ohXiknWyF9g9JKOpw
	 xL8eGMGF8LoHWSmCLSfw7rN9xcHFrjyFI4AyOElhy+7b9hkL7n8oTtUM+8XEXLZpE1
	 ZJpolPTaaJWbD6mmVPRoOXUPMAV4xgBYZcaZk4bOcU4Q+o3ig3xnebmFxMFt6SXZoP
	 gKVCLgpQWtEj6Clq/czvvZ7nQK+i6UDdFsKbzl/umuUYLxcsUDPloa7W3lSvAiFzjL
	 UaLmhQY0kD2lXVfuNJfXadMo5oDCqKv17VeDen9xc8FyPGxCpdi1FXvVROTT7C5gwE
	 zFjwH84lI/8/A==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-60c9d8a16e5so86208a12.0
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 05:43:20 -0700 (PDT)
X-Gm-Message-State: AOJu0YyqP7P/zSJvGVjFuwlk96G5dbJpO7TnPTuhXxR9rkb6574hTZNw
	I5E/IFmsUsmKLdAS3bLpxvLeOmvCtO0miFQaI8R4hyv33rzWH10aavXh6PxqyQ1aDn/1/a5I/zF
	wx0kzlLFmou+UkKnnCsI1mZT95+Lvs1o=
X-Google-Smtp-Source: AGHT+IFUecm9j1Rte19JthDTiZqOsIQp7hqCGIx1vonLmdVdvs4VN810JelJKe9izsV4104ACn+AbmDICaSli83xIZQ=
X-Received: by 2002:a17:906:794b:b0:ae0:cf23:cc15 with SMTP id
 a640c23a62f3a-ae35011f737mr307656866b.43.1751028199013; Fri, 27 Jun 2025
 05:43:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627091914.100715-1-jth@kernel.org> <20250627091914.100715-6-jth@kernel.org>
In-Reply-To: <20250627091914.100715-6-jth@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 27 Jun 2025 13:42:41 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5Hy2nJgdw5t22YR4Q38Y-sjqSPYsicvZDinQ=yZQSP+w@mail.gmail.com>
X-Gm-Features: Ac12FXwvDfU5rnmZD8UNQClbezp0904fJUXP8mKpTkABVNiPey0ktej3UAkYBdk
Message-ID: <CAL3q7H5Hy2nJgdw5t22YR4Q38Y-sjqSPYsicvZDinQ=yZQSP+w@mail.gmail.com>
Subject: Re: [PATCH RFC 5/9] btrfs: remove delalloc_root_mutex
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, 
	Naohiro Aota <naohiro.aota@wdc.com>, David Sterba <dsterba@suse.com>, 
	Josef Bacik <josef@toxicpanda.com>, Boris Burkov <boris@bur.io>, Filipe Manana <fdmanana@suse.com>, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 10:23=E2=80=AFAM Johannes Thumshirn <jth@kernel.org=
> wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> When benchmarking garbage collection on zoned BTRFS filesystems on ZNS
> drives, we regularly observe hung_task messages like the following:
>
> INFO: task kworker/u132:2:297 blocked for more than 122 seconds.
>        Not tainted 6.16.0-rc1+ #1225
>  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message=
.
>  task:kworker/u132:2  state:D stack:0     pid:297   tgid:297   ppid:2    =
  task_flags:0x4208060 flags:0x00004000
>  Workqueue: events_unbound btrfs_preempt_reclaim_metadata_space
>  Call Trace:
>   <TASK>
>   __schedule+0x2f9/0x7b0
>   schedule+0x27/0x80
>   schedule_preempt_disabled+0x15/0x30
>   __mutex_lock.constprop.0+0x4af/0x890
>   ? srso_return_thunk+0x5/0x5f
>   btrfs_start_delalloc_roots+0x8a/0x290
>   ? timerqueue_del+0x2e/0x60
>   shrink_delalloc+0x10c/0x2d0
>   ? srso_return_thunk+0x5/0x5f
>   ? psi_group_change+0x19e/0x460
>   ? srso_return_thunk+0x5/0x5f
>   ? btrfs_reduce_alloc_profile+0x9a/0x1d0
>   flush_space+0x202/0x280
>   ? srso_return_thunk+0x5/0x5f
>   ? need_preemptive_reclaim+0xaa/0x190
>   btrfs_preempt_reclaim_metadata_space+0xe7/0x340
>   process_one_work+0x192/0x350
>   worker_thread+0x25a/0x3a0
>   ? __pfx_worker_thread+0x10/0x10
>   kthread+0xfc/0x240
>   ? __pfx_kthread+0x10/0x10
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork+0x152/0x180
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork_asm+0x1a/0x30
>   </TASK>
>  INFO: task kworker/u132:2:297 is blocked on a mutex likely owned by task=
 kworker/u129:0:2359.
>  task:kworker/u129:0  state:R  running task     stack:0     pid:2359  tgi=
d:2359  ppid:2
>
> The affected tasks are blocked on 'struct btrfs_fs_info::delalloc_root_mu=
tex',
> a global lock that serializes entry into btrfs_start_delalloc_roots().
> This lock was introduced in commit 573bfb72f760 ("Btrfs: fix possible
> empty list access when flushing the delalloc inodes") but without a
> clear justification for its necessity.
>
> However, the condition it was meant to protect against=E2=80=94a possibly=
 empty
> list access=E2=80=94is already safely handled by 'list_splice_init()', wh=
ich
> does nothing when the source list is empty.
>
> There are no known concurrency issues in btrfs_start_delalloc_roots()
> that require serialization via this mutex. All critical regions are
> either covered by per-root locking or operate on safely isolated lists.

Nop... see comments further below.

>
> Removing the lock eliminates the observed hangs and improves metadata
> GC throughput, particularly on systems with high concurrency like
> ZNS-based deployments.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/disk-io.c | 1 -
>  fs/btrfs/fs.h      | 1 -
>  fs/btrfs/inode.c   | 2 --
>  3 files changed, 4 deletions(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 35cd38de7727..929f39886b0e 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2795,7 +2795,6 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_in=
fo)
>         mutex_init(&fs_info->unused_bg_unpin_mutex);
>         mutex_init(&fs_info->reclaim_bgs_lock);
>         mutex_init(&fs_info->reloc_mutex);
> -       mutex_init(&fs_info->delalloc_root_mutex);
>         mutex_init(&fs_info->zoned_meta_io_lock);
>         mutex_init(&fs_info->zoned_data_reloc_io_lock);
>         seqlock_init(&fs_info->profiles_lock);
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index a388af40a251..04ebc976f841 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -606,7 +606,6 @@ struct btrfs_fs_info {
>          */
>         struct list_head ordered_roots;
>
> -       struct mutex delalloc_root_mutex;
>         spinlock_t delalloc_root_lock;
>         /* All fs/file tree roots that have delalloc inodes. */
>         struct list_head delalloc_roots;
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 80c72c594b19..d68f4ef61c43 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -8766,7 +8766,6 @@ int btrfs_start_delalloc_roots(struct btrfs_fs_info=
 *fs_info, long nr,
>         if (BTRFS_FS_ERROR(fs_info))
>                 return -EROFS;
>
> -       mutex_lock(&fs_info->delalloc_root_mutex);
>         spin_lock(&fs_info->delalloc_root_lock);
>         list_splice_init(&fs_info->delalloc_roots, &splice);
>         while (!list_empty(&splice)) {
> @@ -8800,7 +8799,6 @@ int btrfs_start_delalloc_roots(struct btrfs_fs_info=
 *fs_info, long nr,
>                 list_splice_tail(&splice, &fs_info->delalloc_roots);
>                 spin_unlock(&fs_info->delalloc_root_lock);
>         }
> -       mutex_unlock(&fs_info->delalloc_root_mutex);

The lock is useful and exists to make sure two tasks calling this
function wait for all dealloc to be flushed and ordered extents to
complete for all inodes from all roots.

The problem is similar to the one I pointed out for the next patch,
but perhaps a bit more subtle.

So after applying this patch:

1) Task A enters btrfs_start_delalloc_roots() and takes the spinlock
fs_info->delalloc_root_lock;

2) Task A splices the fs_info->delalloc_roots list into the local
splice list. The list has two roots, root X and root Y;

3) Task  A enters the first iteration of the while loop, extracts root
X from the split list, grabs a reference for it, adds it back to the
fs_info->delalloc_roots list and unlocks fs_info->delalloc_root_lock;

4) Task B enters btrfs_start_delalloc_roots(), takes the
fs_info->delalloc_root_lock lock;

5) Task B splices the fs_info->delalloc_roots list into the local
splice list - the list only contains root X -> root Y is held only the
splice list from task A.

As a consequence task B will never wait for writeback and ordered
extents from inodes from root Y to complete.
Therefore breaking the expected semantics of btrfs_start_delalloc_roots().

Thanks.



>         return ret;
>  }

>
> --
> 2.49.0
>
>

