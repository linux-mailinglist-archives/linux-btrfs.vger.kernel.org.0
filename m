Return-Path: <linux-btrfs+bounces-5728-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6089907EDC
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jun 2024 00:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 264A21F233E3
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 22:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FC24F8A0;
	Thu, 13 Jun 2024 22:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxrl314Q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1A214036A
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2024 22:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718317819; cv=none; b=jl0egN+8FEaYKtVL/brSx80Y8os2dUNKMzcddi9DhjwU+fP38PM65yk4LWb40pqo0BUzJtWv7Wddqa0vR9x0bQX0iqwYHVfQu0zPkbhiN63VgRwxtWdeKTuH7ZLqW3VNt6sJvI+/D9Nm4hvJtsQsHPTRTwYU2JdYBG3zZFuZm1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718317819; c=relaxed/simple;
	bh=1iL9n7helVGkMvQSz0ZT3lZM7R9qIcgSgdFrpbRpi+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nHt16ROrjXX9Qcn5YuUgpArF6EmALS7bABh3c5MgfRvT8AG7+LMfuQ0ddnvpJWgvhVdTkVHBTxh+0yziBBSPUijd7HJUv3EjNai/wZ/ktEm2Am3Ed8pqIbfBoSWpKg5u1CR8nqGzf5KlbX/WBOCTVX+N7BBvpNlo7HXJSMTlPDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxrl314Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C0AC2BBFC
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2024 22:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718317819;
	bh=1iL9n7helVGkMvQSz0ZT3lZM7R9qIcgSgdFrpbRpi+w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oxrl314Q1/XO9t9cZH+rT4eGvZRD86v33Rk5+mr7cqPD8AvLywXUjSAB9WtJowc//
	 3XfzcAfNV+e5leXoj+m+NIQBHJZ2nbC7U9UcMRhHDFlB7HQdaIOXIho/JBIinrY63p
	 UpkEP2PU9atAd9xa1oUuhYGaEvUZoQQJWaxAugrJgITQyT5YaYN6zqlNYeV/M+O9/b
	 Ks+dGY5D4uxgW+A3BzZ4DU8AWkZXsjlCIDKW4LIR0H4AAfQ2RkTU1dX6krAuzRGlYd
	 pyPYs0LoQADPX+UFqdDxr8HiU70q2Ho91Flqgy+ZNbwxWO30oM0fP7MwDO6gbmfue/
	 Ij0LLR7JZh/Rw==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a6f3efa1cc7so456392766b.0
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2024 15:30:19 -0700 (PDT)
X-Gm-Message-State: AOJu0YyApUtbsjG9n8uM39WPYQKvPalM8csrX2q78Qz6O3O1czR9YAyu
	bu9d3uLbFmpZlbWO4e/FZaQAnSw4XsNct68mylA+QywPLXz7S0jpbkfTvC4+nNPzSe9j0HYieAd
	6wx7UWePCLaSgrrPYI0W8d7uWNUs=
X-Google-Smtp-Source: AGHT+IELShfLXhsYZRgwB43wn8tONcWNfENH0W4NEBbGEJEoz0WHik0YHG9kennGOXd/Do7TQKyadkTlLDPJy0l7yUI=
X-Received: by 2002:a17:907:86a6:b0:a6e:4e0:8a56 with SMTP id
 a640c23a62f3a-a6f524740c7mr380431466b.32.1718317817984; Thu, 13 Jun 2024
 15:30:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1718276261.git.fdmanana@suse.com> <818b41faf6260be972ffa3bd436dda518963384b.1718276261.git.fdmanana@suse.com>
 <04f49180-cdb0-4665-abe4-136dbc85fbb3@gmx.com> <CAL3q7H6CPShWF0ik8bgFu42dNySrnq=ZMdg07jUXdgRttHMqiQ@mail.gmail.com>
 <82aea39f-f895-469c-b973-9556980d7732@gmx.com>
In-Reply-To: <82aea39f-f895-469c-b973-9556980d7732@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 13 Jun 2024 23:29:41 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6XBO3Yf6t+14JceN2SNbQuWHZngKjVkMRexE53LKce_w@mail.gmail.com>
Message-ID: <CAL3q7H6XBO3Yf6t+14JceN2SNbQuWHZngKjVkMRexE53LKce_w@mail.gmail.com>
Subject: Re: [PATCH 1/4] btrfs: use NOFS context when getting inodes during
 logging and log replay
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 11:21=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com>=
 wrote:
>
>
>
> =E5=9C=A8 2024/6/14 07:24, Filipe Manana =E5=86=99=E9=81=93:
> > On Thu, Jun 13, 2024 at 10:37=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.=
com> wrote:
> >>
> >>
> >>
> >> =E5=9C=A8 2024/6/13 20:35, fdmanana@kernel.org =E5=86=99=E9=81=93:
> >>> From: Filipe Manana <fdmanana@suse.com>
> >>>
> >>> During inode logging (and log replay too), we are holding a transacti=
on
> >>> handle and we often need to call btrfs_iget(), which will read an ino=
de
> >>> from its subvolume btree if it's not loaded in memory and that result=
s in
> >>> allocating an inode with GFP_KERNEL semantics at the btrfs_alloc_inod=
e()
> >>> callback - and this may recurse into the filesystem in case we are un=
der
> >>> memory pressure and attempt to commit the current transaction, result=
ing
> >>> in a deadlock since the logging (or log replay) task is holding a
> >>> transaction handle open.
> >>>
> >>> Syzbot reported this with the following stack traces:
> >>>
> >>>      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> >>>      WARNING: possible circular locking dependency detected
> >>>      6.10.0-rc2-syzkaller-00361-g061d1af7b030 #0 Not tainted
> >>>      ------------------------------------------------------
> >>>      syz-executor.1/9919 is trying to acquire lock:
> >>>      ffffffff8dd3aac0 (fs_reclaim){+.+.}-{0:0}, at: might_alloc inclu=
de/linux/sched/mm.h:334 [inline]
> >>>      ffffffff8dd3aac0 (fs_reclaim){+.+.}-{0:0}, at: slab_pre_alloc_ho=
ok mm/slub.c:3891 [inline]
> >>>      ffffffff8dd3aac0 (fs_reclaim){+.+.}-{0:0}, at: slab_alloc_node m=
m/slub.c:3981 [inline]
> >>>      ffffffff8dd3aac0 (fs_reclaim){+.+.}-{0:0}, at: kmem_cache_alloc_=
lru_noprof+0x58/0x2f0 mm/slub.c:4020
> >>>
> >>>      but task is already holding lock:
> >>>      ffff88804b569358 (&ei->log_mutex){+.+.}-{3:3}, at: btrfs_log_ino=
de+0x39c/0x4660 fs/btrfs/tree-log.c:6481
> >>>
> >>>      which lock already depends on the new lock.
> >>>
> >>>      the existing dependency chain (in reverse order) is:
> >>>
> >>>      -> #3 (&ei->log_mutex){+.+.}-{3:3}:
> >>>             __mutex_lock_common kernel/locking/mutex.c:608 [inline]
> >>>             __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
> >>>             btrfs_log_inode+0x39c/0x4660 fs/btrfs/tree-log.c:6481
> >>>             btrfs_log_inode_parent+0x8cb/0x2a90 fs/btrfs/tree-log.c:7=
079
> >>>             btrfs_log_dentry_safe+0x59/0x80 fs/btrfs/tree-log.c:7180
> >>>             btrfs_sync_file+0x9c1/0xe10 fs/btrfs/file.c:1959
> >>>             vfs_fsync_range+0x141/0x230 fs/sync.c:188
> >>>             generic_write_sync include/linux/fs.h:2794 [inline]
> >>>             btrfs_do_write_iter+0x584/0x10c0 fs/btrfs/file.c:1705
> >>>             new_sync_write fs/read_write.c:497 [inline]
> >>>             vfs_write+0x6b6/0x1140 fs/read_write.c:590
> >>>             ksys_write+0x12f/0x260 fs/read_write.c:643
> >>>             do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline=
]
> >>>             __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:3=
86
> >>>             do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
> >>>             entry_SYSENTER_compat_after_hwframe+0x84/0x8e
> >>>
> >>>      -> #2 (btrfs_trans_num_extwriters){++++}-{0:0}:
> >>>             join_transaction+0x164/0xf40 fs/btrfs/transaction.c:315
> >>>             start_transaction+0x427/0x1a70 fs/btrfs/transaction.c:700
> >>>             btrfs_commit_super+0xa1/0x110 fs/btrfs/disk-io.c:4170
> >>>             close_ctree+0xcb0/0xf90 fs/btrfs/disk-io.c:4324
> >>>             generic_shutdown_super+0x159/0x3d0 fs/super.c:642
> >>>             kill_anon_super+0x3a/0x60 fs/super.c:1226
> >>>             btrfs_kill_super+0x3b/0x50 fs/btrfs/super.c:2096
> >>>             deactivate_locked_super+0xbe/0x1a0 fs/super.c:473
> >>>             deactivate_super+0xde/0x100 fs/super.c:506
> >>>             cleanup_mnt+0x222/0x450 fs/namespace.c:1267
> >>>             task_work_run+0x14e/0x250 kernel/task_work.c:180
> >>>             resume_user_mode_work include/linux/resume_user_mode.h:50=
 [inline]
> >>>             exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
> >>>             exit_to_user_mode_prepare include/linux/entry-common.h:32=
8 [inline]
> >>>             __syscall_exit_to_user_mode_work kernel/entry/common.c:20=
7 [inline]
> >>>             syscall_exit_to_user_mode+0x278/0x2a0 kernel/entry/common=
.c:218
> >>>             __do_fast_syscall_32+0x80/0x120 arch/x86/entry/common.c:3=
89
> >>>             do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
> >>>             entry_SYSENTER_compat_after_hwframe+0x84/0x8e
> >>>
> >>>      -> #1 (btrfs_trans_num_writers){++++}-{0:0}:
> >>>             __lock_release kernel/locking/lockdep.c:5468 [inline]
> >>>             lock_release+0x33e/0x6c0 kernel/locking/lockdep.c:5774
> >>>             percpu_up_read include/linux/percpu-rwsem.h:99 [inline]
> >>>             __sb_end_write include/linux/fs.h:1650 [inline]
> >>>             sb_end_intwrite include/linux/fs.h:1767 [inline]
> >>>             __btrfs_end_transaction+0x5ca/0x920 fs/btrfs/transaction.=
c:1071
> >>>             btrfs_commit_inode_delayed_inode+0x228/0x330 fs/btrfs/del=
ayed-inode.c:1301
> >>>             btrfs_evict_inode+0x960/0xe80 fs/btrfs/inode.c:5291
> >>>             evict+0x2ed/0x6c0 fs/inode.c:667
> >>>             iput_final fs/inode.c:1741 [inline]
> >>>             iput.part.0+0x5a8/0x7f0 fs/inode.c:1767
> >>>             iput+0x5c/0x80 fs/inode.c:1757
> >>>             dentry_unlink_inode+0x295/0x480 fs/dcache.c:400
> >>>             __dentry_kill+0x1d0/0x600 fs/dcache.c:603
> >>>             dput.part.0+0x4b1/0x9b0 fs/dcache.c:845
> >>>             dput+0x1f/0x30 fs/dcache.c:835
> >>>             ovl_stack_put+0x60/0x90 fs/overlayfs/util.c:132
> >>>             ovl_destroy_inode+0xc6/0x190 fs/overlayfs/super.c:182
> >>>             destroy_inode+0xc4/0x1b0 fs/inode.c:311
> >>>             iput_final fs/inode.c:1741 [inline]
> >>>             iput.part.0+0x5a8/0x7f0 fs/inode.c:1767
> >>>             iput+0x5c/0x80 fs/inode.c:1757
> >>>             dentry_unlink_inode+0x295/0x480 fs/dcache.c:400
> >>>             __dentry_kill+0x1d0/0x600 fs/dcache.c:603
> >>>             shrink_kill fs/dcache.c:1048 [inline]
> >>>             shrink_dentry_list+0x140/0x5d0 fs/dcache.c:1075
> >>>             prune_dcache_sb+0xeb/0x150 fs/dcache.c:1156
> >>>             super_cache_scan+0x32a/0x550 fs/super.c:221
> >>>             do_shrink_slab+0x44f/0x11c0 mm/shrinker.c:435
> >>>             shrink_slab_memcg mm/shrinker.c:548 [inline]
> >>>             shrink_slab+0xa87/0x1310 mm/shrinker.c:626
> >>>             shrink_one+0x493/0x7c0 mm/vmscan.c:4790
> >>>             shrink_many mm/vmscan.c:4851 [inline]
> >>>             lru_gen_shrink_node+0x89f/0x1750 mm/vmscan.c:4951
> >>>             shrink_node mm/vmscan.c:5910 [inline]
> >>>             kswapd_shrink_node mm/vmscan.c:6720 [inline]
> >>>             balance_pgdat+0x1105/0x1970 mm/vmscan.c:6911
> >>>             kswapd+0x5ea/0xbf0 mm/vmscan.c:7180
> >>>             kthread+0x2c1/0x3a0 kernel/kthread.c:389
> >>>             ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
> >>>             ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> >>>
> >>>      -> #0 (fs_reclaim){+.+.}-{0:0}:
> >>>             check_prev_add kernel/locking/lockdep.c:3134 [inline]
> >>>             check_prevs_add kernel/locking/lockdep.c:3253 [inline]
> >>>             validate_chain kernel/locking/lockdep.c:3869 [inline]
> >>>             __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:513=
7
> >>>             lock_acquire kernel/locking/lockdep.c:5754 [inline]
> >>>             lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
> >>>             __fs_reclaim_acquire mm/page_alloc.c:3801 [inline]
> >>>             fs_reclaim_acquire+0x102/0x160 mm/page_alloc.c:3815
> >>>             might_alloc include/linux/sched/mm.h:334 [inline]
> >>>             slab_pre_alloc_hook mm/slub.c:3891 [inline]
> >>>             slab_alloc_node mm/slub.c:3981 [inline]
> >>>             kmem_cache_alloc_lru_noprof+0x58/0x2f0 mm/slub.c:4020
> >>>             btrfs_alloc_inode+0x118/0xb20 fs/btrfs/inode.c:8411
> >>>             alloc_inode+0x5d/0x230 fs/inode.c:261
> >>>             iget5_locked fs/inode.c:1235 [inline]
> >>>             iget5_locked+0x1c9/0x2c0 fs/inode.c:1228
> >>>             btrfs_iget_locked fs/btrfs/inode.c:5590 [inline]
> >>>             btrfs_iget_path fs/btrfs/inode.c:5607 [inline]
> >>>             btrfs_iget+0xfb/0x230 fs/btrfs/inode.c:5636
> >>>             add_conflicting_inode fs/btrfs/tree-log.c:5657 [inline]
> >>>             copy_inode_items_to_log+0x1039/0x1e30 fs/btrfs/tree-log.c=
:5928
> >>>             btrfs_log_inode+0xa48/0x4660 fs/btrfs/tree-log.c:6592
> >>>             log_new_delayed_dentries fs/btrfs/tree-log.c:6363 [inline=
]
> >>>             btrfs_log_inode+0x27dd/0x4660 fs/btrfs/tree-log.c:6718
> >>>             btrfs_log_all_parents fs/btrfs/tree-log.c:6833 [inline]
> >>>             btrfs_log_inode_parent+0x22ba/0x2a90 fs/btrfs/tree-log.c:=
7141
> >>>             btrfs_log_dentry_safe+0x59/0x80 fs/btrfs/tree-log.c:7180
> >>>             btrfs_sync_file+0x9c1/0xe10 fs/btrfs/file.c:1959
> >>>             vfs_fsync_range+0x141/0x230 fs/sync.c:188
> >>>             generic_write_sync include/linux/fs.h:2794 [inline]
> >>>             btrfs_do_write_iter+0x584/0x10c0 fs/btrfs/file.c:1705
> >>>             do_iter_readv_writev+0x504/0x780 fs/read_write.c:741
> >>>             vfs_writev+0x36f/0xde0 fs/read_write.c:971
> >>>             do_pwritev+0x1b2/0x260 fs/read_write.c:1072
> >>>             __do_compat_sys_pwritev2 fs/read_write.c:1218 [inline]
> >>>             __se_compat_sys_pwritev2 fs/read_write.c:1210 [inline]
> >>>             __ia32_compat_sys_pwritev2+0x121/0x1b0 fs/read_write.c:12=
10
> >>>             do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline=
]
> >>>             __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:3=
86
> >>>             do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
> >>>             entry_SYSENTER_compat_after_hwframe+0x84/0x8e
> >>>
> >>>      other info that might help us debug this:
> >>>
> >>>      Chain exists of:
> >>>        fs_reclaim --> btrfs_trans_num_extwriters --> &ei->log_mutex
> >>>
> >>>       Possible unsafe locking scenario:
> >>>
> >>>             CPU0                    CPU1
> >>>             ----                    ----
> >>>        lock(&ei->log_mutex);
> >>>                                     lock(btrfs_trans_num_extwriters);
> >>>                                     lock(&ei->log_mutex);
> >>>        lock(fs_reclaim);
> >>>
> >>>       *** DEADLOCK ***
> >>>
> >>>      7 locks held by syz-executor.1/9919:
> >>>       #0: ffff88802be20420 (sb_writers#23){.+.+}-{0:0}, at: do_pwrite=
v+0x1b2/0x260 fs/read_write.c:1072
> >>>       #1: ffff888065c0f8f0 (&sb->s_type->i_mutex_key#33){++++}-{3:3},=
 at: inode_lock include/linux/fs.h:791 [inline]
> >>>       #1: ffff888065c0f8f0 (&sb->s_type->i_mutex_key#33){++++}-{3:3},=
 at: btrfs_inode_lock+0xc8/0x110 fs/btrfs/inode.c:385
> >>>       #2: ffff888065c0f778 (&ei->i_mmap_lock){++++}-{3:3}, at: btrfs_=
inode_lock+0xee/0x110 fs/btrfs/inode.c:388
> >>>       #3: ffff88802be20610 (sb_internal#4){.+.+}-{0:0}, at: btrfs_syn=
c_file+0x95b/0xe10 fs/btrfs/file.c:1952
> >>>       #4: ffff8880546323f0 (btrfs_trans_num_writers){++++}-{0:0}, at:=
 join_transaction+0x430/0xf40 fs/btrfs/transaction.c:290
> >>>       #5: ffff888054632418 (btrfs_trans_num_extwriters){++++}-{0:0}, =
at: join_transaction+0x430/0xf40 fs/btrfs/transaction.c:290
> >>>       #6: ffff88804b569358 (&ei->log_mutex){+.+.}-{3:3}, at: btrfs_lo=
g_inode+0x39c/0x4660 fs/btrfs/tree-log.c:6481
> >>>
> >>>      stack backtrace:
> >>>      CPU: 2 PID: 9919 Comm: syz-executor.1 Not tainted 6.10.0-rc2-syz=
kaller-00361-g061d1af7b030 #0
> >>>      Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-=
debian-1.16.2-1 04/01/2014
> >>>      Call Trace:
> >>>       <TASK>
> >>>       __dump_stack lib/dump_stack.c:88 [inline]
> >>>       dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
> >>>       check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2187
> >>>       check_prev_add kernel/locking/lockdep.c:3134 [inline]
> >>>       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
> >>>       validate_chain kernel/locking/lockdep.c:3869 [inline]
> >>>       __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
> >>>       lock_acquire kernel/locking/lockdep.c:5754 [inline]
> >>>       lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
> >>>       __fs_reclaim_acquire mm/page_alloc.c:3801 [inline]
> >>>       fs_reclaim_acquire+0x102/0x160 mm/page_alloc.c:3815
> >>>       might_alloc include/linux/sched/mm.h:334 [inline]
> >>>       slab_pre_alloc_hook mm/slub.c:3891 [inline]
> >>>       slab_alloc_node mm/slub.c:3981 [inline]
> >>>       kmem_cache_alloc_lru_noprof+0x58/0x2f0 mm/slub.c:4020
> >>>       btrfs_alloc_inode+0x118/0xb20 fs/btrfs/inode.c:8411
> >>>       alloc_inode+0x5d/0x230 fs/inode.c:261
> >>>       iget5_locked fs/inode.c:1235 [inline]
> >>>       iget5_locked+0x1c9/0x2c0 fs/inode.c:1228
> >>>       btrfs_iget_locked fs/btrfs/inode.c:5590 [inline]
> >>>       btrfs_iget_path fs/btrfs/inode.c:5607 [inline]
> >>>       btrfs_iget+0xfb/0x230 fs/btrfs/inode.c:5636
> >>>       add_conflicting_inode fs/btrfs/tree-log.c:5657 [inline]
> >>>       copy_inode_items_to_log+0x1039/0x1e30 fs/btrfs/tree-log.c:5928
> >>>       btrfs_log_inode+0xa48/0x4660 fs/btrfs/tree-log.c:6592
> >>>       log_new_delayed_dentries fs/btrfs/tree-log.c:6363 [inline]
> >>>       btrfs_log_inode+0x27dd/0x4660 fs/btrfs/tree-log.c:6718
> >>>       btrfs_log_all_parents fs/btrfs/tree-log.c:6833 [inline]
> >>>       btrfs_log_inode_parent+0x22ba/0x2a90 fs/btrfs/tree-log.c:7141
> >>>       btrfs_log_dentry_safe+0x59/0x80 fs/btrfs/tree-log.c:7180
> >>>       btrfs_sync_file+0x9c1/0xe10 fs/btrfs/file.c:1959
> >>>       vfs_fsync_range+0x141/0x230 fs/sync.c:188
> >>>       generic_write_sync include/linux/fs.h:2794 [inline]
> >>>       btrfs_do_write_iter+0x584/0x10c0 fs/btrfs/file.c:1705
> >>>       do_iter_readv_writev+0x504/0x780 fs/read_write.c:741
> >>>       vfs_writev+0x36f/0xde0 fs/read_write.c:971
> >>>       do_pwritev+0x1b2/0x260 fs/read_write.c:1072
> >>>       __do_compat_sys_pwritev2 fs/read_write.c:1218 [inline]
> >>>       __se_compat_sys_pwritev2 fs/read_write.c:1210 [inline]
> >>>       __ia32_compat_sys_pwritev2+0x121/0x1b0 fs/read_write.c:1210
> >>>       do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
> >>>       __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
> >>>       do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
> >>>       entry_SYSENTER_compat_after_hwframe+0x84/0x8e
> >>>      RIP: 0023:0xf7334579
> >>>      Code: b8 01 10 06 03 (...)
> >>>      RSP: 002b:00000000f5f265ac EFLAGS: 00000292 ORIG_RAX: 0000000000=
00017b
> >>>      RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00000000200002c=
0
> >>>      RDX: 0000000000000001 RSI: 0000000000000000 RDI: 000000000000000=
0
> >>>      RBP: 0000000000000000 R08: 0000000000000000 R09: 000000000000000=
0
> >>>      R10: 0000000000000000 R11: 0000000000000292 R12: 000000000000000=
0
> >>>      R13: 0000000000000000 R14: 0000000000000000 R15: 000000000000000=
0
> >>>       </TASK>
> >>>
> >>> Fix this by ensuring we are under a NOFS scope whenever we call
> >>> btrfs_iget() during inode logging and log replay.
> >>>
> >>> Reported-by: syzbot+8576cfa84070dce4d59b@syzkaller.appspotmail.com
> >>> Link: https://lore.kernel.org/linux-btrfs/000000000000274a3a061abbd92=
8@google.com/
> >>> Fixes: 712e36c5f2a7 ("btrfs: use GFP_KERNEL in btrfs_alloc_inode")
> >>
> >> I'm wondering if logging is the only location where we can trigger the
> >> deadlock.
> >>
> >> Would regular inode_get() causing such deadlock?
> >
> > What is inode_get()? I can't find anything with that exact name.
>
> My bad, I mean iget().

We don't have anything called exactly iget() either... :)
You mean btrfs_iget()?

>
> >
> > If it's some path with a transaction handle open that can trigger
> > btrfs_alloc_inode() then yes, otherwise it depends on what locks are
> > held if any.
> >
>
> Then would it be safer to revert the offending commit, aka make
> btrfs_alloc_inode() to use the old GFP_NOFS?
>
> I just checked ext4_alloc_inode() and f2fs_alloc_inode(), both are still
> using NOFS instead.
>
> Thus I'm wondering if it's really a good idea to go GFP_KERNEL in the
> first place.

The GFP_KERNEL is fine in some paths, like during dentry lookup
(btrfs_lookup_dentry() callback),
where we don't hold a transaction handle or any lock that would cause
a deadlock in case reclaim is triggered.

>
> Thanks,
> Qu

