Return-Path: <linux-btrfs+bounces-14120-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E39A2ABC32B
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 May 2025 17:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3478C18834FC
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 May 2025 15:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E8B286401;
	Mon, 19 May 2025 15:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="biwR2JfU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC58128540A;
	Mon, 19 May 2025 15:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747669918; cv=none; b=c+CtC7glRGRXfiCHrM0HgPR6dVQQnsWF+6OdQR+r8Jp0xXYYJYO7Xqd2r6x0J9HVpCcVs8YsM2gFBQzBCFTLpVB+Trrsi44LYChxFIAcukFpFv95QQYSXuISmHDhaDabNJ7JjQm/xw9aheFEG6dpuquJOiKxpEOuYA3LRrE0jN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747669918; c=relaxed/simple;
	bh=XfFJjN8yEmZPOaLpnTpwHZ7+RU09j0Ve5fC15QiRSPc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=BYK8CBib/utbogD7uZo4f//C5kmoECg9HV6yzDOfz5Pwl4f7i5zh3NbTxZCZ9Cli8ANZMbhOjEhTHNeHMG0EjB2JklwiDYtaeYgiA5VWFWHbqg371c4W3XOKhlJCAzac/g0hZ7wKzsQMakixGmBPDo6KpVYss0DMXLVb0maAUWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=biwR2JfU; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-73c17c770a7so4935586b3a.2;
        Mon, 19 May 2025 08:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747669916; x=1748274716; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qrUabzzceMGW1C7dcZg7Q5IspUVe6Ijr8QW73C80h5I=;
        b=biwR2JfUf+hXVnetocu2p+rhZ2u7JXfTvrpEz7Ojwxr0gZQdeXspl4gn2fA5ux878D
         H0JmgDBKVlP2u3t28o1KJuxrWmLm0oNvdXD/KpRHuZ0D3fGph7j7/NnIEv3hNpPhQuHA
         RFCt0GmRcJ+Gu3P1u0hUKOUMOkIecrngj5v5Dmv8gz92sCOLZ9eOdXdpFvEMJ8IirZFF
         3R1DEdbydj8MfNvhTupKSBRLN0/i7Ciu77atlG+zKxwyYxDxK7Z9BkrjmMCRcY5rno8T
         rEw3UKmLuAkNMCly1TPKFmaCG2kwjQJrEsj1TYjbTfnZVXSckr4ed6Km8eSC9aRGkC6m
         tXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747669916; x=1748274716;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qrUabzzceMGW1C7dcZg7Q5IspUVe6Ijr8QW73C80h5I=;
        b=MdftzGWv5pqQ7FrmtftjMHcAtN9FcL8PMrFdDKD5FLoTmPmVgd8Kr9Zf+mHEw7kIJa
         nbp+NkGzOjJVZuxIxLazZr8acyBT+yiEjgdiB4ibpLKsY4AtTObKz3NfLl1xeCaprJX5
         1/luz7oBajhcacHQAbGRkaXoHx+p3SiUcAP6KX71qot1V+WFtaWeprtBXmHH1jtKW3S8
         CuPrw8d3YWev5Nfgf+ePIm345W2Q61U74lEhXyNhF+omVP23hMugGE8VZNDbScK2ji8l
         mnSTbAKwQ0Srju86nhaT52fnrpTwCimjtOcY3bsjQHpW9c+Zq1JBP62/iMVadKYyZNLw
         HfgA==
X-Forwarded-Encrypted: i=1; AJvYcCWaYkEBbOnrZyfBzASJ2tmRb6kBoREec9/wyoyMKqQCUutz1Ow1zRq7gVrYsTkC02nNjxX1r9fSuLON6jU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7dO//5zW0yXafSCWwZR7qh7AKlTAsEyrlgYx7If8QwnZ23yEY
	6K4IkVjqSkKbmEjXax5xg3HLraD/mVd3gHwU7zy+y2RRkh0xdVpCThnX
X-Gm-Gg: ASbGnctP0xzUn+ySD0F2M1njAkzQkW8BktB+NGUe1ZW1NRPCYjxNV0J8G/skFzT/aEa
	Bb8L5dgvQ9V9Dd0g3Kw71DYvvGyh3t/cdUg8Jru2pj0PmspK4Q15BAWXqWOFl0FMSddeBOuKNEh
	fzMqKm3DTYlo5ambSHLEgLurvzikWq1W7dlhFPOV0K5PAv+68lAPFVrdPQkVhRNk8GYML4E1jKa
	e5t9CkgfqDFxj4bnjA0iqrIYmmmbbbPkOMPGxxpUuvuPxRBsULuzF91FvXkc+kYK2avQml5g0fP
	LX0NjJdzuwDUG4ngkGFDGpVCj635fDOVQxmJtccLC8lFvH+EHkgDQfXaYHI2AxfysDeyOfwELEJ
	39UU0klE=
X-Google-Smtp-Source: AGHT+IG26klxUP+ER7iUVmZ4PgDJvCLWRTquYZsfGhf4h6v2/cfobFi14hcFkTpuUViMtDS3uXpcLQ==
X-Received: by 2002:a05:6a20:10a9:b0:216:60bc:2ca9 with SMTP id adf61e73a8af0-21660cb6eefmr15396122637.40.1747669915780;
        Mon, 19 May 2025 08:51:55 -0700 (PDT)
Received: from ubuntu.localdomain ([39.86.156.14])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eaf8db5csm6402218a12.34.2025.05.19.08.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 08:51:55 -0700 (PDT)
From: Penglei Jiang <superman.xpt@gmail.com>
To: syzbot+3a88c590edd72179657c@syzkaller.appspotmail.com,
	clm@fb.com,
	dsterba@suse.com,
	josef@toxicpanda.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] possible deadlock in btrfs_quota_enable (2)
Date: Mon, 19 May 2025 08:51:49 -0700
Message-Id: <20250519155149.2382-1-superman.xpt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <681fbc4c.050a0220.f2294.0018.GAE@google.com>
References: <681fbc4c.050a0220.f2294.0018.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

On Sat, 10 May 2025 13:51:24 -0700, syzbot wrote:
> syz.4.219/7436 is trying to acquire lock:
> ffff88806ce71918 (&fs_info->qgroup_ioctl_lock){+.+.}-{4:4}, at: btrfs_quota_enable+0x2be/0x1d50 fs/btrfs/qgroup.c:1059
> 
> but task is already holding lock:
> ffff88806ce724f8 (btrfs_trans_num_extwriters){++++}-{0:0}, at: join_transaction+0x164/0xd70 fs/btrfs/transaction.c:320
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #5 (btrfs_trans_num_extwriters){++++}-{0:0}:
>        lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5866
>        join_transaction+0x1a4/0xd70 fs/btrfs/transaction.c:321
>        start_transaction+0x6ae/0x1620 fs/btrfs/transaction.c:705
>        btrfs_dirty_inode+0x9f/0x190 fs/btrfs/inode.c:6129
>        inode_update_time fs/inode.c:2076 [inline]
>        touch_atime+0x2f6/0x6d0 fs/inode.c:2149
>        file_accessed include/linux/fs.h:2599 [inline]
>        filemap_read+0x1024/0x11d0 mm/filemap.c:2774
>        __kernel_read+0x469/0x8c0 fs/read_write.c:528
>        integrity_kernel_read+0x89/0xd0 security/integrity/iint.c:28
>        ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:480 [inline]
>        ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
>        ima_calc_file_hash+0x152c/0x18d0 security/integrity/ima/ima_crypto.c:568
>        ima_collect_measurement+0x42e/0x8e0 security/integrity/ima/ima_api.c:293
>        process_measurement+0x1121/0x1a40 security/integrity/ima/ima_main.c:385
>        ima_file_check+0xd7/0x120 security/integrity/ima/ima_main.c:613
>        security_file_post_open+0xbb/0x290 security/security.c:3130
>        do_open fs/namei.c:3882 [inline]
>        path_openat+0x2f26/0x3830 fs/namei.c:4039
>        do_filp_open+0x1fa/0x410 fs/namei.c:4066
>        do_sys_openat2+0x121/0x1c0 fs/open.c:1429
>        do_sys_open fs/open.c:1444 [inline]
>        __do_sys_openat fs/open.c:1460 [inline]
>        __se_sys_openat fs/open.c:1455 [inline]
>        __x64_sys_openat+0x138/0x170 fs/open.c:1455
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> -> #4 (btrfs_trans_num_writers){++++}-{0:0}:
>        reacquire_held_locks+0x127/0x1d0 kernel/locking/lockdep.c:5383
>        __lock_release kernel/locking/lockdep.c:5572 [inline]
>        lock_release+0x1b4/0x3e0 kernel/locking/lockdep.c:5887
>        percpu_up_read include/linux/percpu-rwsem.h:100 [inline]
>        __sb_end_write include/linux/fs.h:1778 [inline]
>        sb_end_intwrite+0x26/0x1c0 include/linux/fs.h:1895
>        __btrfs_end_transaction+0x248/0x640 fs/btrfs/transaction.c:1075
>        btrfs_dirty_inode+0x14c/0x190 fs/btrfs/inode.c:6143
>        inode_update_time fs/inode.c:2076 [inline]
>        __file_update_time fs/inode.c:2305 [inline]
>        file_update_time+0x344/0x490 fs/inode.c:2335
>        btrfs_page_mkwrite+0x634/0x16a0 fs/btrfs/file.c:1814
>        do_page_mkwrite+0x14a/0x310 mm/memory.c:3287
>        wp_page_shared mm/memory.c:3688 [inline]
>        do_wp_page+0x2626/0x5760 mm/memory.c:3907
>        handle_pte_fault mm/memory.c:6013 [inline]
>        __handle_mm_fault+0x1028/0x5380 mm/memory.c:6140
>        handle_mm_fault+0x2d5/0x7f0 mm/memory.c:6309
>        do_user_addr_fault+0xa81/0x1390 arch/x86/mm/fault.c:1337
>        handle_page_fault arch/x86/mm/fault.c:1480 [inline]
>        exc_page_fault+0x68/0x110 arch/x86/mm/fault.c:1538
>        asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
> 
> -> #3 (sb_pagefaults#2){.+.+}-{0:0}:
>        lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5866
>        percpu_down_read include/linux/percpu-rwsem.h:52 [inline]
>        __sb_start_write include/linux/fs.h:1783 [inline]
>        sb_start_pagefault include/linux/fs.h:1948 [inline]
>        btrfs_page_mkwrite+0x3b2/0x16a0 fs/btrfs/file.c:1798
>        do_page_mkwrite+0x14a/0x310 mm/memory.c:3287
>        do_shared_fault mm/memory.c:5594 [inline]
>        do_fault mm/memory.c:5656 [inline]
>        do_pte_missing mm/memory.c:4160 [inline]
>        handle_pte_fault mm/memory.c:5997 [inline]
>        __handle_mm_fault+0x18d2/0x5380 mm/memory.c:6140
>        handle_mm_fault+0x2d5/0x7f0 mm/memory.c:6309
>        do_user_addr_fault+0x764/0x1390 arch/x86/mm/fault.c:1388
>        handle_page_fault arch/x86/mm/fault.c:1480 [inline]
>        exc_page_fault+0x68/0x110 arch/x86/mm/fault.c:1538
>        asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
> 
> -> #2 (&mm->mmap_lock){++++}-{4:4}:
>        lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5866
>        down_read_killable+0x50/0x350 kernel/locking/rwsem.c:1547
>        mmap_read_lock_killable+0x1d/0x70 include/linux/mmap_lock.h:193
>        get_mmap_lock_carefully mm/memory.c:6355 [inline]
>        lock_mm_and_find_vma+0x2a8/0x300 mm/memory.c:6406
>        do_user_addr_fault+0x331/0x1390 arch/x86/mm/fault.c:1360
>        handle_page_fault arch/x86/mm/fault.c:1480 [inline]
>        exc_page_fault+0x68/0x110 arch/x86/mm/fault.c:1538
>        asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
>        filldir64+0x2b3/0x690 fs/readdir.c:371
>        dir_emit include/linux/fs.h:3861 [inline]
>        kernfs_fop_readdir+0x534/0x870 fs/kernfs/dir.c:1907
>        iterate_dir+0x5ac/0x770 fs/readdir.c:108
>        __do_sys_getdents64 fs/readdir.c:403 [inline]
>        __se_sys_getdents64+0xe4/0x260 fs/readdir.c:389
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> -> #1 (&root->kernfs_rwsem){++++}-{4:4}:
>        lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5866
>        down_write+0x96/0x1f0 kernel/locking/rwsem.c:1577
>        kernfs_add_one+0x41/0x520 fs/kernfs/dir.c:791
>        kernfs_create_dir_ns+0xde/0x130 fs/kernfs/dir.c:1091
>        sysfs_create_dir_ns+0x123/0x280 fs/sysfs/dir.c:59
>        create_dir lib/kobject.c:73 [inline]
>        kobject_add_internal+0x59f/0xb40 lib/kobject.c:240
>        kobject_add_varg lib/kobject.c:374 [inline]
>        kobject_init_and_add+0x125/0x190 lib/kobject.c:457
>        btrfs_sysfs_add_qgroups+0x111/0x2b0 fs/btrfs/sysfs.c:2616
>        btrfs_quota_enable+0x278/0x1d50 fs/btrfs/qgroup.c:1030
>        btrfs_ioctl_quota_ctl+0x183/0x1c0 fs/btrfs/ioctl.c:3676
>        vfs_ioctl fs/ioctl.c:51 [inline]
>        __do_sys_ioctl fs/ioctl.c:906 [inline]
>        __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:892
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> -> #0 (&fs_info->qgroup_ioctl_lock){+.+.}-{4:4}:
>        check_prev_add kernel/locking/lockdep.c:3166 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3285 [inline]
>        validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3909
>        __lock_acquire+0xaac/0xd20 kernel/locking/lockdep.c:5235
>        lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5866
>        __mutex_lock_common kernel/locking/mutex.c:601 [inline]
>        __mutex_lock+0x182/0xe80 kernel/locking/mutex.c:746
>        btrfs_quota_enable+0x2be/0x1d50 fs/btrfs/qgroup.c:1059
>        btrfs_ioctl_quota_ctl+0x183/0x1c0 fs/btrfs/ioctl.c:3676
>        vfs_ioctl fs/ioctl.c:51 [inline]
>        __do_sys_ioctl fs/ioctl.c:906 [inline]
>        __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:892
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> other info that might help us debug this:
> 
> Chain exists of:
>   &fs_info->qgroup_ioctl_lock --> btrfs_trans_num_writers --> btrfs_trans_num_extwriters
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   rlock(btrfs_trans_num_extwriters);
>                                lock(btrfs_trans_num_writers);
>                                lock(btrfs_trans_num_extwriters);
>   lock(&fs_info->qgroup_ioctl_lock);
> 
>  *** DEADLOCK ***
> 
> 5 locks held by syz.4.219/7436:
>  #0: ffff8880259ac420 (sb_writers#17){.+.+}-{0:0}, at: mnt_want_write_file+0x60/0x200 fs/namespace.c:600
>  #1: ffff88806ce70bd0 (&fs_info->subvol_sem){+.+.}-{4:4}, at: btrfs_ioctl_quota_ctl+0x178/0x1c0 fs/btrfs/ioctl.c:3675
>  #2: ffff8880259ac610 (sb_internal#3){.+.+}-{0:0}, at: btrfs_quota_enable+0x2b1/0x1d50 fs/btrfs/qgroup.c:1057
>  #3: ffff88806ce724d0 (btrfs_trans_num_writers){++++}-{0:0}, at: join_transaction+0x164/0xd70 fs/btrfs/transaction.c:320
>  #4: ffff88806ce724f8 (btrfs_trans_num_extwriters){++++}-{0:0}, at: join_transaction+0x164/0xd70 fs/btrfs/transaction.c:320

We assign a sequence number to each lock to represent the order in which
they are held:

	0: vfs freeze semaphores
	1: qgroup_ioctl_lock
	2: kernfs_rwsem
	3: mmap_lock
	4: btrfs_trans_num_writers
	5: btrfs_trans_num_extwriters

	cpu-0
	=====
	0: vfs freeze semaphores
	4: btrfs_trans_num_writers
	5: btrfs_trans_num_extwriters
	1: qgroup_ioctl_lock

	cpu-1
	=====
	1: qgroup_ioctl_lock
	2: kernfs_rwsem

	cpu-2
	=====
	2: kernfs_rwsem
	3: mmap_lock

	cpu-3
	=====
	3: mmap_lock
	4: btrfs_trans_num_writers
	5: btrfs_trans_num_extwriters

I believe we should adjust the order of locks in the CPU-0 call stack by moving
the acquisition of qgroup_ioctl_lock inside the start_transaction() function.
After the adjustment, it becomes as follows:

	0: vfs freeze semaphores
	1: qgroup_ioctl_lock
	4: btrfs_trans_num_writers
	5: btrfs_trans_num_extwriters

	static struct btrfs_trans_handle *
	start_transaction(struct btrfs_root *root, unsigned int num_items,
			unsigned int type, enum btrfs_reserve_flush_enum flush,
			bool enforce_qgroups)
	{
		...

		/*
		* If we are JOIN_NOLOCK we're already committing a transaction and
		* waiting on this guy, so we don't need to do the sb_start_intwrite
		* because we're already holding a ref.  We need this because we could
		* have raced in and did an fsync() on a file which can kick a commit
		* and then we deadlock with somebody doing a freeze.
		*
		* If we are ATTACH, it means we just want to catch the current
		* transaction and commit it, so we needn't do sb_start_intwrite(). 
		*/
		if (type & __TRANS_FREEZABLE)
			sb_start_intwrite(fs_info->sb);

		mutex_lock(&fs_info->qgroup_ioctl_lock);
		~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

		if (may_wait_transaction(fs_info, type))
			wait_current_trans(fs_info);

		do {
			ret = join_transaction(fs_info, type);
			if (ret == -EBUSY) {
				wait_current_trans(fs_info);
				if (unlikely(type == TRANS_ATTACH ||
					type == TRANS_JOIN_NOSTART))
					ret = -ENOENT;
			}
		} while (ret == -EBUSY);

		...
	}

