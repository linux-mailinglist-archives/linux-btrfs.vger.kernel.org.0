Return-Path: <linux-btrfs+bounces-20025-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B550CDF51D
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Dec 2025 08:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5CBB93000DC9
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Dec 2025 07:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E3723815D;
	Sat, 27 Dec 2025 07:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoUWgXby"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5721E14A4F0
	for <linux-btrfs@vger.kernel.org>; Sat, 27 Dec 2025 07:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766821653; cv=none; b=CL6cepcf6V+70d0aMwckQfTYDiLgku76wOb7q2OlPMS2CY96P16N/hRXoYOFDa+dUO5x56WnnNyswJ5nHemt+npTRM30zVcveRUwYe28uI2ML4FTVIyadH0DtXbfZr7Chp3ujJPe2sRvYMEaOn1Bo26IukXlw3SrAfxE/Ix85w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766821653; c=relaxed/simple;
	bh=87aYFbv9wQyNG2znU+75u2USt3EW6siv5j5eYO3LLSo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=t759JGQdRPJBxgOhJLG+qGcMX9flaToetaEO6NI8t7eiYdSwJDj+XANw1XRmRePTZAYbgvd1CL4hNEhDm/i4u9U+rkP/CVWa2q/Ns7pDYs40Z/T1wZTNPFZfKpvZQX/LqMcprZ/8qxS1rUiYE7K4R2DvfnEMG2K0Oi55fVP9kNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FoUWgXby; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-64b8123c333so11293308a12.3
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Dec 2025 23:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766821650; x=1767426450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0IDoRhbG/BTS6YLQHJSEuitJCGYe2RO7TOLdZcFwBvE=;
        b=FoUWgXbysw6Oondi+HgDYAtqmqFrtoOSdVc7sXiqENQBoPrAMh+YDaIA9jdDGZdF06
         ZZaSR8jXXK4/xa7ZaRtSP+X/O53Y+w/GTEd6AOx2rNAQ+9qROyMRnKxoBoPn2Nm02KHw
         bScOJNsvxCUwrupsJVfsVrzB6qL2B1/RyiG5xeMrcWsFvaPGa51mQV3lkS+619V+j0FY
         J7LtAMpDzNVYIP3oM9Il+Zxkkxhw9H1uCgpQmeMis04xE9Kt4tFBbImoZmIsGTc7Qtl5
         fOkiLUYG5NNV0EALIZ2piCkhI6aIjc4hJg1dZ7F90JdIItagFrDSKNiqKwEVFw2e28QO
         6Khw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766821650; x=1767426450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0IDoRhbG/BTS6YLQHJSEuitJCGYe2RO7TOLdZcFwBvE=;
        b=kVndfL0gPesv7/EVLc4PCMuLlpDJuwsF0t1VTtknUktWGKULXYXlJY3tXlfaOMrhmo
         vxIWgJs4WZSZ1fql8X+RYaitMrsbPJA6U64Jbin+6bXMBmGi2ZqxzqWXtffAbfhmVLd5
         6J7mJhFz5dlr8exrx9LiCsrnedvIHm1px23HQgKUui49iWal4RGl9iH/KA8B9cJsCHzN
         UIcDjdKj5bbkorryQuNMC1HYJLDM1didoG6RqFxtSF9PJ4/SrhhN2cscOzCB3oYOGacw
         uTSJLPbPbCm1RDWq+7lQlpajLlXnNPBKScQbBbE/txq1OOTWdgTqAp7N7YQqFZZuVM2L
         CrjA==
X-Gm-Message-State: AOJu0YzZ6KBbfKHI9kYRZi/jzHd6soZZlPMaMsH7HpieX5++5X245BHt
	4FryPrXbKXT+fbYqWWmTGJ7RIHuVit7JWHYpYYIhJS2YWpMyztkhDoyYnqEtGySOaLGB+ymm7xj
	MbOGgWJclrdlIAc3eAtoz/8C13C67C90=
X-Gm-Gg: AY/fxX4flSCby8VOBc+YDUYBwRgsP09K/WjzRcgDfgMGnmUUZShMsqQiWzdxEpcePgL
	xswv9kKOM0MluzEVSxlTrkfB46Kx//X+Y7F1CZ7xsUAonuLa/0I2dmMRjlc4lpD/peNTAcQqTmj
	oDXX/9HYtyXtkGNzCBK7XUD1l8zGjMeWtTJAwfwqJeR2UZGKVRC4IW/3LO3C1OzOvAdbwi/9FXH
	j5Vz739cxpbbadyBASnKLan+ltNwnhV5hF5L7rqCxiLeB2dkz5iqt7UNBDG2swGCNZ4pCcO
X-Google-Smtp-Source: AGHT+IFDL6fVDs2YzAEE6xM4j0Ham5rcrWQ7Zu69j8xRPhcvsv9tbdnK6aVvx33viB01kOUM+AxJ+CqrNiH8feMs3Eg=
X-Received: by 2002:a05:6402:50cf:b0:64b:9fa4:b586 with SMTP id
 4fb4d7f45d1cf-64b9fa4b629mr22281190a12.25.1766821649306; Fri, 26 Dec 2025
 23:47:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: ZhengYuan Huang <gality369@gmail.com>
Date: Sat, 27 Dec 2025 15:47:18 +0800
X-Gm-Features: AQt7F2ohkVCQBtGONUKUCQiiOdUZmRqKijD1vymITTcpIKFDo0pwu9VHXT69Q-Y
Message-ID: <CAOmEq9WKw2_Xq4hEMZte=ZdMiXphWJW7759untUxc19Q8iOj5A@mail.gmail.com>
Subject: [BUG] lockdep: possible circular locking dependency between
 mm->mmap_lock and kernfs_rwsem via btrfs qgroup path
To: clm@fb.com, dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org, baijiaju1990@gmail.com, r33s3n6@gmail.com, 
	zzzccc427@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello maintainers,

I would like to report a lockdep warning indicating a possible circular loc=
king
dependency involving mm->mmap_lock, root->kernfs_rwsem, and btrfs qgroup-re=
lated
locks.

This issue was found using a custom fuzzing tool that stresses filesystem, =
mm,
and sysfs interactions. The kernel is marked as -dirty only because I local=
ly
added some debug code to print additional call stacks; no locking logic or
control flow related to this issue was modified.

This warning can be understood as a triggering lock ordering observed in th=
e
current context combined with an existing dependency chain recorded by lock=
dep.

Chain A (triggering ordering in the current context):
root->kernfs_rwsem -> mm->mmap_lock.

It arises when getdents64() on a kernfs directory calls
kernfs_fop_readdir(). While holding root->kernfs_rwsem, filldir64() trigger=
s a
user page fault while accessing the userspace buffer, and the fault path
(lock_mm_and_find_vma()) attempts to take mm->mmap_lock.

Chain B (dependency chain reported by lockdep):
mm->mmap_lock -> sb_pagefaults-> btrfs_trans_num_writers
-> btrfs_trans_num_extwriters -> fs_info->reloc_mutex
-> btrfs-quota-00 -> root->kernfs_rwsem.

This is a dependency chain in the lockdep graph; individual edges
may originate from different runtime contexts. Below I analyze this chain
in detail (for convenience, =E2=80=9C#N=E2=80=9D labels refer to the same l=
ock numbering
as in the full lockdep report):

Lock ordering between mm->mmap_lock and sb_pagefaults (#0 -> #2):
Both paths enter do_user_addr_fault(). mm->mmap_lock is first acquired via
lock_mm_and_find_vma() at arch/x86/mm/fault.c:1359. While holding this lock=
,
handle_mm_fault() (at arch/x86/mm/fault.c:1387) eventually acquires
sb_pagefaults.

lock A:
do_user_addr_fault()
-> lock_mm_and_find_vma()
   -> get_mmap_lock_carefully()
      -> mmap_read_lock_killable()
         -> down_read_killable(&mm->mmap_lock)

lock B:
do_user_addr_fault()
-> handle_mm_fault()
   -> __handle_mm_fault()
      -> handle_pte_fault()
         -> do_pte_missing()
            -> do_fault()
               -> do_shared_fault()
                  -> do_page_mkwrite()
                     -> btrfs_page_mkwrite()
                        -> sb_start_pagefault()

Lock ordering between sb_pagefaults and btrfs_trans_num_writers (#2 -> #3):
Both paths enter btrfs_page_mkwrite(). sb_pagefaults is first held via
sb_start_pagefault() at fs/btrfs/file.c:1874. Then btrfs_trans_num_writers =
is
acquired via file_update_time() at fs/btrfs/file.c:1915.

lock B:
btrfs_page_mkwrite()
-> sb_start_pagefault()

lock C:
btrfs_page_mkwrite()
-> file_update_time()
   -> __file_update_time()
      -> inode_update_time()
         -> btrfs_update_time()
            -> btrfs_dirty_inode()
               -> btrfs_start_transaction()
                  -> start_transaction()
                     -> sb_start_intwrite()

Lock ordering between btrfs_trans_num_writers and
btrfs_trans_num_extwriters (#3 -> #4):
Both paths enter btrfs_dirty_inode(). btrfs_trans_num_writers is first
held via btrfs_start_transaction() at fs/btrfs/inode.c:6279. Then
btrfs_trans_num_extwriters is acquired via btrfs_start_transaction() at
fs/btrfs/inode.c:6280.

lock C:
btrfs_dirty_inode()
-> btrfs_start_transaction()
   -> start_transaction()
      -> sb_start_intwrite()

lock D:
btrfs_dirty_inode()
-> btrfs_start_transaction()
   -> join_transaction()
      -> btrfs_lockdep_acquire()

Lock ordering between btrfs_trans_num_extwriters and
fs_info->reloc_mutex (#4 ->#5):
Both paths enter btrfs_start_transaction(). btrfs_trans_num_extwriters is
first held via join_transaction() at fs/btrfs/transaction.c:705. Then
fs_info->reloc_mutex is acquired via btrfs_record_root_in_trans() at
fs/btrfs/transaction.c:779.

lock D:
btrfs_start_transaction()
-> join_transaction()
   -> btrfs_lockdep_acquire()

lock E:
btrfs_start_transaction()
-> btrfs_record_root_in_trans()
   -> mutex_lock_nested()
      -> mutex_lock()

Lock ordering between fs_info->reloc_mutex and btrfs-quota-00 (#5 -> #6):
Both paths enter btrfs_commit_transaction(). fs_info->reloc_mutex is
first acquired
via mutex_lock(&fs_info->reloc_mutex) at fs/btrfs/transaction.c:2405. Then
btrfs-quota-00 is acquired via commit_cowonly_roots() at
fs/btrfs/transaction.c:1354.

lock E:
btrfs_commit_transaction()
-> mutex_lock()

lock F:
btrfs_commit_transaction()
-> commit_cowonly_roots()
   -> btrfs_run_qgroups()
      -> update_qgroup_info_item()
         -> btrfs_search_slot()
            -> btrfs_search_slot_get_root()
               -> btrfs_read_lock_root_node()
                  -> btrfs_tree_read_lock()

Lock ordering between btrfs-quota-00 and root->kernfs_rwsem (#6 -> #7):
Both paths enter btrfs_read_qgroup_config().The qgroup tree is first
accessed via
btrfs_search_slot_for_read() at fs/btrfs/qgroup.c:418.Then root->kernfs_rws=
em is
acquired via btrfs_sysfs_add_one_qgroup() at fs/btrfs/qgroup.c:488.

lock F:
btrfs_read_qgroup_config()
-> btrfs_search_slot_for_read()
   -> btrfs_search_slot()
      -> btrfs_search_slot_get_root()
         -> btrfs_read_lock_root_node()
            -> btrfs_tree_read_lock()

lock G:
btrfs_read_qgroup_config()
-> btrfs_sysfs_add_one_qgroup()
   -> kobject_init_and_add()
      -> kobject_add_varg()
         -> kobject_add_internal()
            -> create_dir()
               -> sysfs_create_dir_ns()
                  -> kernfs_create_dir_ns()
                     -> kernfs_add_one()
                        -> down_write(&root->kernfs_rwsem)

After reviewing the code paths involved, I could not find a clear execution=
 path
corresponding to the #0 -> #1 and #1 -> #2 edges reported by lockdep. I was=
,
however, able to identify a concrete path establishing the ordering between=
 #0
and #2, and therefore focused on that relationship in the analysis above.

Overall, this may result in a circular locking dependency, as reported
by lockdep.

My understanding of some of the paths may be incomplete, as I'm still learn=
ing
the kernel internals. If there are mistakes or alternative interpretations,
please let me know =E2=80=94 any guidance would be appreciated.

Full lockdep report is attached below:

WARNING: possible circular locking dependency detected
6.18.0-dirty #1 Tainted: G           OE
------------------------------------------------------
syz.0.279/4686 is trying to acquire lock:
ffff888014b4d7e0 (&mm->mmap_lock){++++}-{4:4}, at:
mmap_read_lock_killable include/linux/mmap_lock.h:377 [inline]
ffff888014b4d7e0 (&mm->mmap_lock){++++}-{4:4}, at:
get_mmap_lock_carefully mm/mmap_lock.c:378 [inline]
ffff888014b4d7e0 (&mm->mmap_lock){++++}-{4:4}, at:
lock_mm_and_find_vma+0x146/0x630 mm/mmap_lock.c:429

but task is already holding lock:
ffff88800aa8c188 (&root->kernfs_rwsem){++++}-{4:4}, at:
kernfs_fop_readdir+0x146/0x860 fs/kernfs/dir.c:1893

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #7 (&root->kernfs_rwsem){++++}-{4:4}:
      down_write+0x91/0x210 kernel/locking/rwsem.c:1590
      kernfs_add_one+0x39/0x700 fs/kernfs/dir.c:791
      kernfs_create_dir_ns+0x103/0x1a0 fs/kernfs/dir.c:1093
      sysfs_create_dir_ns+0x143/0x2b0 fs/sysfs/dir.c:59
      create_dir lib/kobject.c:73 [inline]
      kobject_add_internal+0x24d/0xad0 lib/kobject.c:240
      kobject_add_varg lib/kobject.c:374 [inline]
      kobject_init_and_add+0x114/0x1a0 lib/kobject.c:457
      btrfs_sysfs_add_one_qgroup+0xe2/0x170 fs/btrfs/sysfs.c:2599
      btrfs_read_qgroup_config+0x86f/0x1310 fs/btrfs/qgroup.c:488
      open_ctree+0x3bda/0x6d60 fs/btrfs/disk-io.c:3592
      btrfs_fill_super fs/btrfs/super.c:987 [inline]
      btrfs_get_tree_super fs/btrfs/super.c:1951 [inline]
      btrfs_get_tree_subvol fs/btrfs/super.c:2094 [inline]
      btrfs_get_tree+0x114c/0x22e0 fs/btrfs/super.c:2128
      vfs_get_tree+0x9a/0x370 fs/super.c:1758
      fc_mount fs/namespace.c:1199 [inline]
      do_new_mount_fc fs/namespace.c:3642 [inline]
      do_new_mount fs/namespace.c:3718 [inline]
      path_mount+0x5aa/0x1e90 fs/namespace.c:4028
      do_mount fs/namespace.c:4041 [inline]
      __do_sys_mount fs/namespace.c:4229 [inline]
      __se_sys_mount fs/namespace.c:4206 [inline]
      __x64_sys_mount+0x282/0x320 fs/namespace.c:4206
      x64_sys_call+0x1a7d/0x26a0
arch/x86/include/generated/asm/syscalls_64.h:166
      do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
      do_syscall_64+0x91/0xa90 arch/x86/entry/syscall_64.c:94
      entry_SYSCALL_64_after_hwframe+0x76/0x7e

-> #6 (btrfs-quota-00){++++}-{4:4}:
      down_read_nested+0xa0/0x4d0 kernel/locking/rwsem.c:1662
      btrfs_tree_read_lock_nested+0x32/0x1d0 fs/btrfs/locking.c:145
      btrfs_tree_read_lock fs/btrfs/locking.h:188 [inline]
      btrfs_read_lock_root_node+0x73/0xb0 fs/btrfs/locking.c:266
      btrfs_search_slot_get_root fs/btrfs/ctree.c:1742 [inline]
      btrfs_search_slot+0x3e0/0x3580 fs/btrfs/ctree.c:2066
      update_qgroup_info_item fs/btrfs/qgroup.c:882 [inline]
      btrfs_run_qgroups+0x4f3/0x870 fs/btrfs/qgroup.c:3112
      commit_cowonly_roots+0x1f3/0x8f0 fs/btrfs/transaction.c:1354
      btrfs_commit_transaction+0x1c64/0x3f70 fs/btrfs/transaction.c:2459
      btrfs_sync_fs+0xf2/0x660 fs/btrfs/super.c:1057
      sync_filesystem fs/sync.c:66 [inline]
      sync_filesystem+0x1ba/0x260 fs/sync.c:30
      generic_shutdown_super+0x88/0x520 fs/super.c:621
      kill_anon_super+0x41/0x80 fs/super.c:1288
      btrfs_kill_super+0x41/0x60 fs/btrfs/super.c:2134
      deactivate_locked_super+0xb5/0x1a0 fs/super.c:473
      deactivate_super fs/super.c:506 [inline]
      deactivate_super+0xad/0xd0 fs/super.c:502
      cleanup_mnt+0x214/0x460 fs/namespace.c:1318
      __cleanup_mnt+0x1b/0x30 fs/namespace.c:1325
      task_work_run+0x16a/0x270 kernel/task_work.c:227
      resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
      exit_to_user_mode_loop+0x147/0x190 kernel/entry/common.c:43
      exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inlin=
e]
      syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inli=
ne]
      syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
      do_syscall_64+0x3a0/0xa90 arch/x86/entry/syscall_64.c:100
      entry_SYSCALL_64_after_hwframe+0x76/0x7e

-> #5 (&fs_info->reloc_mutex){+.+.}-{4:4}:
      __mutex_lock_common kernel/locking/mutex.c:598 [inline]
      __mutex_lock+0x1ac/0x1ba0 kernel/locking/mutex.c:760
      mutex_lock_nested+0x1b/0x30 kernel/locking/mutex.c:812
      btrfs_record_root_in_trans+0x118/0x190 fs/btrfs/transaction.c:503
      start_transaction+0x607/0x1830 fs/btrfs/transaction.c:779
      btrfs_start_transaction+0x32/0x50 fs/btrfs/transaction.c:816
      btrfs_create_common+0x1bd/0x270 fs/btrfs/inode.c:6786
      btrfs_create+0x11a/0x170 fs/btrfs/inode.c:6832
      lookup_open.isra.0+0x10b0/0x1470 fs/namei.c:3796
      open_last_lookups fs/namei.c:3895 [inline]
      path_openat+0x11e2/0x2cd0 fs/namei.c:4131
      do_filp_open+0x20c/0x480 fs/namei.c:4161
      do_sys_openat2+0x117/0x1c0 fs/open.c:1437
      do_sys_open fs/open.c:1452 [inline]
      __do_sys_creat fs/open.c:1530 [inline]
      __se_sys_creat fs/open.c:1524 [inline]
      __x64_sys_creat+0xe2/0x140 fs/open.c:1524
      x64_sys_call+0x1249/0x26a0 arch/x86/include/generated/asm/syscalls_64=
.h:86
      do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
      do_syscall_64+0x91/0xa90 arch/x86/entry/syscall_64.c:94
      entry_SYSCALL_64_after_hwframe+0x76/0x7e

-> #4 (btrfs_trans_num_extwriters){++++}-{0:0}:
      join_transaction+0x1e9/0xfa0 fs/btrfs/transaction.c:321
      start_transaction+0x3b8/0x1830 fs/btrfs/transaction.c:705
      btrfs_start_transaction+0x32/0x50 fs/btrfs/transaction.c:816
      btrfs_create_common+0x1bd/0x270 fs/btrfs/inode.c:6786
      btrfs_create+0x11a/0x170 fs/btrfs/inode.c:6832
      lookup_open.isra.0+0x10b0/0x1470 fs/namei.c:3796
      open_last_lookups fs/namei.c:3895 [inline]
      path_openat+0x11e2/0x2cd0 fs/namei.c:4131
      do_filp_open+0x20c/0x480 fs/namei.c:4161
      do_sys_openat2+0x117/0x1c0 fs/open.c:1437
      do_sys_open fs/open.c:1452 [inline]
      __do_sys_creat fs/open.c:1530 [inline]
      __se_sys_creat fs/open.c:1524 [inline]
      __x64_sys_creat+0xe2/0x140 fs/open.c:1524
      x64_sys_call+0x1249/0x26a0 arch/x86/include/generated/asm/syscalls_64=
.h:86
      do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
      do_syscall_64+0x91/0xa90 arch/x86/entry/syscall_64.c:94
      entry_SYSCALL_64_after_hwframe+0x76/0x7e

-> #3 (btrfs_trans_num_writers){++++}-{0:0}:
      __lock_release kernel/locking/lockdep.c:5574 [inline]
      lock_release+0x124/0x2b0 kernel/locking/lockdep.c:5889
      percpu_up_read include/linux/percpu-rwsem.h:112 [inline]
      __sb_end_write include/linux/fs.h:1911 [inline]
      sb_end_intwrite include/linux/fs.h:2028 [inline]
      __btrfs_end_transaction+0x563/0x870 fs/btrfs/transaction.c:1076
      btrfs_end_transaction+0x1c/0x30 fs/btrfs/transaction.c:1110
      btrfs_dirty_inode+0x107/0x1d0 fs/btrfs/inode.c:6286
      btrfs_update_time fs/btrfs/inode.c:6306 [inline]
      btrfs_update_time+0xa9/0xe0 fs/btrfs/inode.c:6297
      inode_update_time fs/inode.c:2129 [inline]
      __file_update_time fs/inode.c:2357 [inline]
      file_update_time+0x137/0x1a0 fs/inode.c:2387
      btrfs_page_mkwrite+0x4ba/0x1c10 fs/btrfs/file.c:1915
      do_page_mkwrite+0x174/0x360 mm/memory.c:3489
      do_shared_fault mm/memory.c:5792 [inline]
      do_fault+0x34e/0x1400 mm/memory.c:5854
      do_pte_missing mm/memory.c:4362 [inline]
      handle_pte_fault mm/memory.c:6195 [inline]
      __handle_mm_fault+0x139c/0x2280 mm/memory.c:6336
      handle_mm_fault+0x2fb/0x710 mm/memory.c:6505
      do_user_addr_fault+0x3de/0x1110 arch/x86/mm/fault.c:1336
      handle_page_fault arch/x86/mm/fault.c:1476 [inline]
      exc_page_fault+0x73/0x110 arch/x86/mm/fault.c:1532
      asm_exc_page_fault+0x27/0x30 arch/x86/include/asm/idtentry.h:569

-> #2 (sb_pagefaults#2){.+.+}-{0:0}:
      percpu_down_read_internal include/linux/percpu-rwsem.h:53 [inline]
      percpu_down_read_freezable include/linux/percpu-rwsem.h:83 [inline]
      __sb_start_write include/linux/fs.h:1916 [inline]
      sb_start_pagefault include/linux/fs.h:2081 [inline]
      btrfs_page_mkwrite+0x2c8/0x1c10 fs/btrfs/file.c:1874
      do_page_mkwrite+0x174/0x360 mm/memory.c:3489
      do_shared_fault mm/memory.c:5792 [inline]
      do_fault+0x34e/0x1400 mm/memory.c:5854
      do_pte_missing mm/memory.c:4362 [inline]
      handle_pte_fault mm/memory.c:6195 [inline]
      __handle_mm_fault+0x139c/0x2280 mm/memory.c:6336
      handle_mm_fault+0x2fb/0x710 mm/memory.c:6505
      do_user_addr_fault+0x3de/0x1110 arch/x86/mm/fault.c:1336
      handle_page_fault arch/x86/mm/fault.c:1476 [inline]
      exc_page_fault+0x73/0x110 arch/x86/mm/fault.c:1532
      asm_exc_page_fault+0x27/0x30 arch/x86/include/asm/idtentry.h:569

-> #1 (vm_lock){++++}-{0:0}:
      __vma_enter_locked+0x1d0/0x400 mm/mmap_lock.c:63
      __vma_start_write+0x27/0x150 mm/mmap_lock.c:87
      vma_start_write include/linux/mmap_lock.h:212 [inline]
      mprotect_fixup+0x352/0xa40 mm/mprotect.c:828
      setup_arg_pages+0x489/0xb90 fs/exec.c:670
      load_elf_binary+0xae6/0x4af0 fs/binfmt_elf.c:1028
      search_binary_handler fs/exec.c:1670 [inline]
      exec_binprm fs/exec.c:1702 [inline]
      bprm_execve fs/exec.c:1754 [inline]
      bprm_execve+0x8bd/0x15c0 fs/exec.c:1730
      kernel_execve+0x29f/0x370 fs/exec.c:1920
      run_init_process+0x14c/0x180 init/main.c:1404
      try_to_run_init_process init/main.c:1411 [inline]
      kernel_init+0x167/0x290 init/main.c:1539
      ret_from_fork+0x4b9/0x650 arch/x86/kernel/process.c:158
      ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #0 (&mm->mmap_lock){++++}-{4:4}:
      check_prev_add kernel/locking/lockdep.c:3165 [inline]
      check_prevs_add kernel/locking/lockdep.c:3284 [inline]
      validate_chain kernel/locking/lockdep.c:3908 [inline]
      __lock_acquire+0x16d3/0x2880 kernel/locking/lockdep.c:5237
      lock_acquire kernel/locking/lockdep.c:5868 [inline]
      lock_acquire+0x16c/0x300 kernel/locking/lockdep.c:5825
      down_read_killable+0x9f/0x520 kernel/locking/rwsem.c:1560
      mmap_read_lock_killable include/linux/mmap_lock.h:377 [inline]
      get_mmap_lock_carefully mm/mmap_lock.c:378 [inline]
      lock_mm_and_find_vma+0x146/0x630 mm/mmap_lock.c:429
      do_user_addr_fault+0x4db/0x1110 arch/x86/mm/fault.c:1359
      handle_page_fault arch/x86/mm/fault.c:1476 [inline]
      exc_page_fault+0x73/0x110 arch/x86/mm/fault.c:1532
      asm_exc_page_fault+0x27/0x30 arch/x86/include/asm/idtentry.h:569
      filldir64+0x1c9/0x590 fs/readdir.c:381
      dir_emit include/linux/fs.h:3988 [inline]
      kernfs_fop_readdir+0x3c9/0x860 fs/kernfs/dir.c:1910
      iterate_dir+0x276/0x9e0 fs/readdir.c:108
      __do_sys_getdents64 fs/readdir.c:410 [inline]
      __se_sys_getdents64 fs/readdir.c:396 [inline]
      __x64_sys_getdents64+0x143/0x2a0 fs/readdir.c:396
      x64_sys_call+0x2527/0x26a0
arch/x86/include/generated/asm/syscalls_64.h:218
      do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
      do_syscall_64+0x91/0xa90 arch/x86/entry/syscall_64.c:94
      entry_SYSCALL_64_after_hwframe+0x76/0x7e

other info that might help us debug this:

Chain exists of:
&mm->mmap_lock --> btrfs-quota-00 --> &root->kernfs_rwsem

Possible unsafe locking scenario:

      CPU0                    CPU1
      ----                    ----
rlock(&root->kernfs_rwsem);
                              lock(btrfs-quota-00);
                              lock(&root->kernfs_rwsem);
rlock(&mm->mmap_lock);

*** DEADLOCK ***

3 locks held by syz.0.279/4686:
#0: ffff888015621cf8 (&f->f_pos_lock){+.+.}-{4:4}, at:
fdget_pos+0x269/0x350 fs/file.c:1232
#1: ffff888013426de8 (&type->i_mutex_dir_key#6){++++}-{4:4}, at:
iterate_dir+0x17c/0x9e0 fs/readdir.c:101
#2: ffff88800aa8c188 (&root->kernfs_rwsem){++++}-{4:4}, at:
kernfs_fop_readdir+0x146/0x860 fs/kernfs/dir.c:1893

stack backtrace:
CPU: 1 UID: 0 PID: 4686 Comm: syz.0.279 Tainted: G           OE
6.18.0-dirty #1 PREEMPT(voluntary)
Tainted: [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS
1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
<TASK>
__dump_stack lib/dump_stack.c:94 [inline]
dump_stack_lvl+0xbe/0x130 lib/dump_stack.c:120
dump_stack+0x15/0x20 lib/dump_stack.c:129
print_circular_bug+0x28c/0x360 kernel/locking/lockdep.c:2043
check_noncircular+0x14e/0x170 kernel/locking/lockdep.c:2175
check_prev_add kernel/locking/lockdep.c:3165 [inline]
check_prevs_add kernel/locking/lockdep.c:3284 [inline]
validate_chain kernel/locking/lockdep.c:3908 [inline]
__lock_acquire+0x16d3/0x2880 kernel/locking/lockdep.c:5237
lock_acquire kernel/locking/lockdep.c:5868 [inline]
lock_acquire+0x16c/0x300 kernel/locking/lockdep.c:5825
down_read_killable+0x9f/0x520 kernel/locking/rwsem.c:1560
mmap_read_lock_killable include/linux/mmap_lock.h:377 [inline]
get_mmap_lock_carefully mm/mmap_lock.c:378 [inline]
lock_mm_and_find_vma+0x146/0x630 mm/mmap_lock.c:429
do_user_addr_fault+0x4db/0x1110 arch/x86/mm/fault.c:1359
handle_page_fault arch/x86/mm/fault.c:1476 [inline]
exc_page_fault+0x73/0x110 arch/x86/mm/fault.c:1532
asm_exc_page_fault+0x27/0x30 arch/x86/include/asm/idtentry.h:569
RIP: 0010:filldir64+0x1c9/0x590 fs/readdir.c:381
Code: 04 24 e8 1a 6c 77 ff 0f b7 45 d4 66 41 89 44 24 10 e8 0b 6c 77
ff 8b 45 d0 83 e0 0f 41 88 44 24 12 e8 fb 6b 77 ff 49 83 c4 13 <43> c6
04 2c 00 e8 ed 6b 77 ff 49 83 fd 07 76 3e e8 e2 6b 77 ff 4c
RSP: 0018:ffff88801309f948 EFLAGS: 00010202
RAX: 0000000000000000 RBX: ffff88801309faf0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000005dd3b93c
RBP: ffff88801309f9b8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 00007f37d0000ffb
R13: 000000000000000c R14: ffff88800e4a2c20 R15: ffff88801309fb14
dir_emit include/linux/fs.h:3988 [inline]
kernfs_fop_readdir+0x3c9/0x860 fs/kernfs/dir.c:1910
iterate_dir+0x276/0x9e0 fs/readdir.c:108
__do_sys_getdents64 fs/readdir.c:410 [inline]
__se_sys_getdents64 fs/readdir.c:396 [inline]
__x64_sys_getdents64+0x143/0x2a0 fs/readdir.c:396
x64_sys_call+0x2527/0x26a0 arch/x86/include/generated/asm/syscalls_64.h:218
do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
do_syscall_64+0x91/0xa90 arch/x86/entry/syscall_64.c:94
entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7f37dfbd80f7
Code: 5c 5d e9 fc 57 f8 ff 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3 0f
1e fa b8 ff ff ff 7f 48 39 c2 48 0f 47 d0 b8 d9 00 00 00 0f 05 <48> 3d
00 f0 ff ff 77 01 c3 48 c7 c2 b0 ff ff ff f7 d8 64 89 02 48
RSP: 002b:00007f37e0984a78 EFLAGS: 00000293 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 00007f37d0000b70 RCX: 00007f37dfbd80f7
RDX: 0000000000008000 RSI: 00007f37d0000ba0 RDI: 0000000000000005
RBP: 00007f37e0984ab0 R08: 00007f37d0000090 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000293 R12: 00007f37d0000b74
R13: 00007f37d0000ba0 R14: ffffffffffffffb0 R15: 0000000000000000
</TASK>
----------------
Code disassembly (best guess):
   0: 04 24                add    $0x24,%al
   2: e8 1a 6c 77 ff        call   0xff776c21
   7: 0f b7 45 d4          movzwl -0x2c(%rbp),%eax
   b: 66 41 89 44 24 10    mov    %ax,0x10(%r12)
11: e8 0b 6c 77 ff        call   0xff776c21
16: 8b 45 d0              mov    -0x30(%rbp),%eax
19: 83 e0 0f              and    $0xf,%eax
1c: 41 88 44 24 12        mov    %al,0x12(%r12)
21: e8 fb 6b 77 ff        call   0xff776c21
26: 49 83 c4 13          add    $0x13,%r12
* 2a: 43 c6 04 2c 00        movb   $0x0,(%r12,%r13,1) <-- trapping instruct=
ion
2f: e8 ed 6b 77 ff        call   0xff776c21
34: 49 83 fd 07          cmp    $0x7,%r13
38: 76 3e                jbe    0x78
3a: e8 e2 6b 77 ff        call   0xff776c21
3f: 4c                    rex.WR
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Apologies for the duplicate and incorrect emails, which were caused by
my unfamiliarity with the mailing list workflow. Please ignore the previous
messages and consider this email as the correct version. Thank you for
your attention.

Best regards,
ZhengYuan Huang

