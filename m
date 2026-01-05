Return-Path: <linux-btrfs+bounces-20105-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E1DCF4B14
	for <lists+linux-btrfs@lfdr.de>; Mon, 05 Jan 2026 17:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B50430829B8
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jan 2026 16:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584D13054EF;
	Mon,  5 Jan 2026 16:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7gIrh/Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990C83451A3
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Jan 2026 16:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767629770; cv=none; b=nJc2FYB7e6YTG8vXits3xL9Odj+9NHG66JyhsZh7Dlqa8mQEirNoZb7RHP036Zu/EX8t5nrOftUCoPXltvZYoZfYH8R8FMmuTXvwjGvvNBKmhxpuz4AH+6SF2VIAsVsFQ8N1nbGURJn5ePSLelf2wx6xQ918R9NdpUovqFx19dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767629770; c=relaxed/simple;
	bh=bTUj8SLiVaeeASWyFJoXqtKxD5fsuIba8l/SqhBfLNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Laml/li7SPi2CE8M+p7rHnD+nzXpiFU7DjIQDeAwUMBA8LlU686pgLYHzZt0NCfLAP/hz2KzX5+XSvO1jDcGNUAXE17+jmrdDDo8oWUCNQhSWIDfmltZBWZu2/86gk991Ecpd1NWXervkEHvcx/ue2jOdpyEHWHjvXdlaBn+ml8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7gIrh/Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 070D4C19422
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Jan 2026 16:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767629770;
	bh=bTUj8SLiVaeeASWyFJoXqtKxD5fsuIba8l/SqhBfLNs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=G7gIrh/Ybt1e145XNMinQPS8PrSnyVBK9i6XG44+diYeBZK9oqXLYnDGbZvCiV/Ca
	 VKZT82I65obd6ebPdF5tm6oL6eAZ/J9hRGZpTS4nizIKXwSglBdEepPwzbH9mXZiGh
	 qKZqJWZXklKmrsZOFwINmwuVs77g7N720+xMR8OPZPikhAQSxe0k36lDokXH0AumkW
	 W8mvg18ntCJpsxpMqRe+RXgvE9qFss1amBS2lLzqKKzFRb3ZiuxlZOc5FTYcjBsW78
	 jbxFvJ4d4dP2c5XQyOjTyeWrmVzqFICgMWxzY3/h6TD6e+JnMV4mGjkEaokWLcL7xe
	 DWaFfzwypto6Q==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b7a6e56193cso21737966b.3
        for <linux-btrfs@vger.kernel.org>; Mon, 05 Jan 2026 08:16:09 -0800 (PST)
X-Gm-Message-State: AOJu0YxswkvFbB7MKlRlcksFurAtmhkbg64oLskbfNd3T919F9jDwb39
	1ijKesdWWr/CLEgtaGYQr6nQ3TtjNgFpOL1uYyxPU9sCmtlncgFvb9iXmAvizWWRtnF/XjXpEyd
	ePAXw+9nKAPtVkUmPFXtzCO6E1KAwf8s=
X-Google-Smtp-Source: AGHT+IHD3kX2NZX6Gv0FO2H1fyKCNxYRUHZ2okCNH5riqomHwp4dyuHf5LDS2bX5yfm8It7QO8FD8SgaKlTtjH07exw=
X-Received: by 2002:a17:907:1b0a:b0:b83:6e2b:890d with SMTP id
 a640c23a62f3a-b8426ac78fbmr35524366b.25.1767629768554; Mon, 05 Jan 2026
 08:16:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7cdad50af2ac47b00bc1d81dfc97ad8776528d86.1766874707.git.wqu@suse.com>
In-Reply-To: <7cdad50af2ac47b00bc1d81dfc97ad8776528d86.1766874707.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 5 Jan 2026 16:15:31 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5rboRQD0GGAVHtGvcJcUnrOuJQuwEw1WfN6K-jzaT1cg@mail.gmail.com>
X-Gm-Features: AQt7F2pdmm0wfV3gB_YkJHffbztw6e_WWP4CJKUsExNZD8j4_EwieNl7rS4A1lk
Message-ID: <CAL3q7H5rboRQD0GGAVHtGvcJcUnrOuJQuwEw1WfN6K-jzaT1cg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: do not sync fs when the fs is not yet fully mounted
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, ZhengYuan Huang <gality369@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 27, 2025 at 10:32=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
> [LOCKDEP WARNING]
> There is a lockdep warning between qgroup related tree lock and
> kernfs_rwsem.
>
> However the involved call chains show that the fs is being mounted
> meanwhile the fs is also triggering sync_fs() from unmounting process:

So we can have an unmount during mount?
That sentence is confusing.

>
> WARNING: possible circular locking dependency detected
> 6.18.0-dirty #1 Tainted: G           OE
> ------------------------------------------------------
> syz.0.279/4686 is trying to acquire lock:
> ffff888014b4d7e0 (&mm->mmap_lock){++++}-{4:4}, at:
> mmap_read_lock_killable include/linux/mmap_lock.h:377 [inline]
> ffff888014b4d7e0 (&mm->mmap_lock){++++}-{4:4}, at:
> get_mmap_lock_carefully mm/mmap_lock.c:378 [inline]
> ffff888014b4d7e0 (&mm->mmap_lock){++++}-{4:4}, at:
> lock_mm_and_find_vma+0x146/0x630 mm/mmap_lock.c:429
>
> but task is already holding lock:
> ffff88800aa8c188 (&root->kernfs_rwsem){++++}-{4:4}, at:
> kernfs_fop_readdir+0x146/0x860 fs/kernfs/dir.c:1893
>
> which lock already depends on the new lock.
>
> the existing dependency chain (in reverse order) is:
>
> -> #7 (&root->kernfs_rwsem){++++}-{4:4}:
>       down_write+0x91/0x210 kernel/locking/rwsem.c:1590
>       kernfs_add_one+0x39/0x700 fs/kernfs/dir.c:791
>       kernfs_create_dir_ns+0x103/0x1a0 fs/kernfs/dir.c:1093
>       sysfs_create_dir_ns+0x143/0x2b0 fs/sysfs/dir.c:59
>       create_dir lib/kobject.c:73 [inline]
>       kobject_add_internal+0x24d/0xad0 lib/kobject.c:240
>       kobject_add_varg lib/kobject.c:374 [inline]
>       kobject_init_and_add+0x114/0x1a0 lib/kobject.c:457
>       btrfs_sysfs_add_one_qgroup+0xe2/0x170 fs/btrfs/sysfs.c:2599
>       btrfs_read_qgroup_config+0x86f/0x1310 fs/btrfs/qgroup.c:488
>       open_ctree+0x3bda/0x6d60 fs/btrfs/disk-io.c:3592
>       btrfs_fill_super fs/btrfs/super.c:987 [inline]
>       btrfs_get_tree_super fs/btrfs/super.c:1951 [inline]
>       btrfs_get_tree_subvol fs/btrfs/super.c:2094 [inline]
>       btrfs_get_tree+0x114c/0x22e0 fs/btrfs/super.c:2128
>       vfs_get_tree+0x9a/0x370 fs/super.c:1758
>       fc_mount fs/namespace.c:1199 [inline] <<<<
>       do_new_mount_fc fs/namespace.c:3642 [inline]
>       do_new_mount fs/namespace.c:3718 [inline]
>       path_mount+0x5aa/0x1e90 fs/namespace.c:4028
>       do_mount fs/namespace.c:4041 [inline]
>       __do_sys_mount fs/namespace.c:4229 [inline]
>       __se_sys_mount fs/namespace.c:4206 [inline]
>       __x64_sys_mount+0x282/0x320 fs/namespace.c:4206
>       x64_sys_call+0x1a7d/0x26a0
> arch/x86/include/generated/asm/syscalls_64.h:166
>       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>       do_syscall_64+0x91/0xa90 arch/x86/entry/syscall_64.c:94
>       entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> -> #6 (btrfs-quota-00){++++}-{4:4}:
>       down_read_nested+0xa0/0x4d0 kernel/locking/rwsem.c:1662
>       btrfs_tree_read_lock_nested+0x32/0x1d0 fs/btrfs/locking.c:145
>       btrfs_tree_read_lock fs/btrfs/locking.h:188 [inline]
>       btrfs_read_lock_root_node+0x73/0xb0 fs/btrfs/locking.c:266
>       btrfs_search_slot_get_root fs/btrfs/ctree.c:1742 [inline]
>       btrfs_search_slot+0x3e0/0x3580 fs/btrfs/ctree.c:2066
>       update_qgroup_info_item fs/btrfs/qgroup.c:882 [inline]
>       btrfs_run_qgroups+0x4f3/0x870 fs/btrfs/qgroup.c:3112
>       commit_cowonly_roots+0x1f3/0x8f0 fs/btrfs/transaction.c:1354
>       btrfs_commit_transaction+0x1c64/0x3f70 fs/btrfs/transaction.c:2459
>       btrfs_sync_fs+0xf2/0x660 fs/btrfs/super.c:1057
>       sync_filesystem fs/sync.c:66 [inline]
>       sync_filesystem+0x1ba/0x260 fs/sync.c:30
>       generic_shutdown_super+0x88/0x520 fs/super.c:621 <<<<
>       kill_anon_super+0x41/0x80 fs/super.c:1288
>       btrfs_kill_super+0x41/0x60 fs/btrfs/super.c:2134
>       deactivate_locked_super+0xb5/0x1a0 fs/super.c:473
>       deactivate_super fs/super.c:506 [inline]
>       deactivate_super+0xad/0xd0 fs/super.c:502
>       cleanup_mnt+0x214/0x460 fs/namespace.c:1318
>       __cleanup_mnt+0x1b/0x30 fs/namespace.c:1325
>       task_work_run+0x16a/0x270 kernel/task_work.c:227
>       resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>       exit_to_user_mode_loop+0x147/0x190 kernel/entry/common.c:43
>       exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inl=
ine]
>       syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [in=
line]
>       syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
>       do_syscall_64+0x3a0/0xa90 arch/x86/entry/syscall_64.c:100
>       entry_SYSCALL_64_after_hwframe+0x76/0x7e

Can you please paste the whole lockdep splat?
This misses several stack traces and the report at the bottom with the
detected lock dependencies:


Chain exists of:
&mm->mmap_lock --> btrfs-quota-00 --> &root->kernfs_rwsem

Possible unsafe locking scenario:

      CPU0                    CPU1
      ----                    ----
rlock(&root->kernfs_rwsem);
                              lock(btrfs-quota-00);
                              lock(&root->kernfs_rwsem);
rlock(&mm->mmap_lock);

>
> [CAUSE]
> At btrfs_sync_fs() we always assume the fs is already fully mounted, but
> if it's not the case we have more problems to bother other than just
> lockdep warnings.

But how did you arrive at the conclusion that the fs is not already
fully mounted?
There are stack traces of mmap writes, which suggests the fs is fully
mounted (otherwise how could they happen?).

We may have a nested mount going on (like mounting the subvolume of an
already mounted fs into another mount point).

To me it seems the best would be to call btrfs_sysfs_add_one_qgroup()
in btrfs_read_qgroup_config() after releasing the path, and then
search again in the quota tree for the next qgroup.

Thanks.


>
> [FIX]
> Check if the target fs is fully mounted, if not skip btrfs_sync_fs()
> completely.



>
> Reported-by: ZhengYuan Huang <gality369@gmail.com>
> Link: https://lore.kernel.org/linux-btrfs/CAOmEq9XdTN64=3DoE7na3J+vCG+fV2=
bFHSpprHswcE_wEfk_edNg@mail.gmail.com/
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/super.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index c141b7e1ee81..af98f622023f 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -1013,6 +1013,9 @@ int btrfs_sync_fs(struct super_block *sb, int wait)
>         struct btrfs_fs_info *fs_info =3D btrfs_sb(sb);
>         struct btrfs_root *root =3D fs_info->tree_root;
>
> +       if (unlikely(!test_bit(BTRFS_FS_OPEN, &fs_info->flags)))
> +               return 0;
> +
>         trace_btrfs_sync_fs(fs_info, wait);
>
>         if (!wait) {
> --
> 2.52.0
>
>

