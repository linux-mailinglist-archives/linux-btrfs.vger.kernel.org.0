Return-Path: <linux-btrfs+bounces-14121-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6BEABC557
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 May 2025 19:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 964E73A5988
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 May 2025 17:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17E7288C15;
	Mon, 19 May 2025 17:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZqeRehnD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528F52882C6
	for <linux-btrfs@vger.kernel.org>; Mon, 19 May 2025 17:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747674899; cv=none; b=Y2B0fGhRaFO5xlHOruaAcmnBBjFxXZiTiLHYDgbNBX8xE9M2BG82zmDRTh3P3OSQlZybKyqNM0gGxEuR//mMA6oiW5LJ/ChtSGJhcuhHfujslSFTjXRH+Twa6Effae9E540wtHOO2DHjAOagO/KF+RaB5VPEdPW2BFiB9jnnJZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747674899; c=relaxed/simple;
	bh=i/Xr8nUkf95hXHF4M2ZlURGI+CcmTVHnHsgn83jJM2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pl8jXntlCZSHD3CsGFpG8H5dE0zIgN+wr7LOOeng825boSURtHawfhWj0SDhcZtYKV8fIBwpY2Atfm2/hRIePykv0R+PTIoPoZ3D4vv8GptezKeOlmHrKy+EH/Bgre/hv+HeLadkG5l1/d5tAFUVWa6OGJHCRIIGFMxzmt5GbGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZqeRehnD; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-601470b6e93so6355487a12.3
        for <linux-btrfs@vger.kernel.org>; Mon, 19 May 2025 10:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747674894; x=1748279694; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j/dJ91jAs2x/40mIcwdVFSGRCzkWtOHnSOd4I9iR8Rw=;
        b=ZqeRehnDVlge2yZ0Mow4CWcFWxjDKG/Qk4Nv5wsFoXMz6meRKL1kNGWSLmqM/aoI+Q
         cwx/pRKtzcdmqmdJ5Q95OCQAWmMYbrzsUmw/hD/QzIR50jZ6f6G3RT/0rbQhVKMIOQ2M
         IbFWubMUN7eeg7wtT4PEvkhbyF3pYItdrfa2FnEmxCIJmxv310Lk1PAQOXClMGTWMxa8
         lE+qqeIV4Lj8UM7LGf6CchYj7GdegblLK3UgEbbzR0mYkAVyNU8WeJOmWUuSR5kEVtyp
         CRGARwze80OcDnJIru3hPSnZYXHFa5tOyf254dVD5NMVzFxb+NtdaUyKFTJnCuUH54oZ
         KjIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747674894; x=1748279694;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j/dJ91jAs2x/40mIcwdVFSGRCzkWtOHnSOd4I9iR8Rw=;
        b=thfX3y1uhhQOHwzsUxoQX+Ybrg4pb3V0qDZP1GPSGYJueVyzIGNqpoqKSJZt2lY2Ln
         jRQRYRqNmonmEUcLXGYMox/essO3UVQWTxUHtq91I6s3b2HqDv5KOSvz48z62LH4SI2L
         GCiCcWx6Z4G583xbPBJdecfyMB1CE9td8aGAxEl7kuluItoWLk6fYCidzjT9VCtVnpEi
         iLZk85rM8xMR1JsxqFvMuvxdCeTPPA+DqQvwZu6DYz5Yt1OEq4k4WrhcxYcJAErOSCUZ
         bCzc8xdTo0vjZSEcGHARjKPwcfMXP6O3ipv1XxMfw1uM+T361AlRPikx5h7SKbq8pdN6
         P4tQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyJYSutzr2FXNhsrxJhVoETr7T7v+liTW8kbpPrPfBcgX9H/5RCfvF5MwsFskMcLS7jrDGZ1EGjwcwZA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8se5Gf84eGP5Y5Lr2JJGQrcYK+AXYVvxnxnFvDomNqh7t2+0h
	sHNOn5liW0cqzZYYN2enU5xhNQGd+c8UALUCmm7FcK4lMwGA9CreZ3SErX0c260XtKPfELdknmF
	0jMZaBmwRqa/x+G1b0+YPLVnUewvKursejdMuzxHK6w==
X-Gm-Gg: ASbGnctF5M3y+xW/eKFkSuRomH2C6m1DBNWW1mODJoBUYapuTY08xjvphEgGLEIn+61
	JfjSdkvPBwrkJDhl7/ylJQ9vZZa03R3B+rGGZdAOdcd4USOOK+S1y1Q4kRJS3KeGCA6IgY79Lyl
	jtTBVdMWzfAGDLU1DlFrZkTW7+kWHOkh4=
X-Google-Smtp-Source: AGHT+IEbjxF32+GNV7625qjFK7sXt6zIG2FfobPHuTxAsz3eEm/bllXKrOeVsvVvK8MNKxXT81djXQk9hyTt8E5zLfU=
X-Received: by 2002:a17:907:3d12:b0:ad2:28a0:4248 with SMTP id
 a640c23a62f3a-ad52d45aedemr1327804366b.3.1747674894337; Mon, 19 May 2025
 10:14:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <681fbc4c.050a0220.f2294.0018.GAE@google.com> <20250519155149.2382-1-superman.xpt@gmail.com>
In-Reply-To: <20250519155149.2382-1-superman.xpt@gmail.com>
From: Daniel Vacek <neelx@suse.com>
Date: Mon, 19 May 2025 19:14:43 +0200
X-Gm-Features: AX0GCFvvV9nAwH9bSVWpQz8uJYyBDHDhH_MpZhq7FuKWwJ1CpEyFTV4YyLaDdxg
Message-ID: <CAPjX3Fffh10wX=UajkXwJHnu0i9sRAkZJ_R_awwU2BKFNvpuTQ@mail.gmail.com>
Subject: Re: [syzbot] [btrfs?] possible deadlock in btrfs_quota_enable (2)
To: Penglei Jiang <superman.xpt@gmail.com>
Cc: syzbot+3a88c590edd72179657c@syzkaller.appspotmail.com, clm@fb.com, 
	dsterba@suse.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 May 2025 at 17:53, Penglei Jiang <superman.xpt@gmail.com> wrote:
>
> On Sat, 10 May 2025 13:51:24 -0700, syzbot wrote:
> > syz.4.219/7436 is trying to acquire lock:
> > ffff88806ce71918 (&fs_info->qgroup_ioctl_lock){+.+.}-{4:4}, at: btrfs_quota_enable+0x2be/0x1d50 fs/btrfs/qgroup.c:1059
> >
> > but task is already holding lock:
> > ffff88806ce724f8 (btrfs_trans_num_extwriters){++++}-{0:0}, at: join_transaction+0x164/0xd70 fs/btrfs/transaction.c:320
> >
> > which lock already depends on the new lock.
> >
> >
> > the existing dependency chain (in reverse order) is:
> >
> > -> #5 (btrfs_trans_num_extwriters){++++}-{0:0}:
> >        lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5866
> >        join_transaction+0x1a4/0xd70 fs/btrfs/transaction.c:321
> >        start_transaction+0x6ae/0x1620 fs/btrfs/transaction.c:705
> >        btrfs_dirty_inode+0x9f/0x190 fs/btrfs/inode.c:6129
> >        inode_update_time fs/inode.c:2076 [inline]
> >        touch_atime+0x2f6/0x6d0 fs/inode.c:2149
> >        file_accessed include/linux/fs.h:2599 [inline]
> >        filemap_read+0x1024/0x11d0 mm/filemap.c:2774
> >        __kernel_read+0x469/0x8c0 fs/read_write.c:528
> >        integrity_kernel_read+0x89/0xd0 security/integrity/iint.c:28
> >        ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:480 [inline]
> >        ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
> >        ima_calc_file_hash+0x152c/0x18d0 security/integrity/ima/ima_crypto.c:568
> >        ima_collect_measurement+0x42e/0x8e0 security/integrity/ima/ima_api.c:293
> >        process_measurement+0x1121/0x1a40 security/integrity/ima/ima_main.c:385
> >        ima_file_check+0xd7/0x120 security/integrity/ima/ima_main.c:613
> >        security_file_post_open+0xbb/0x290 security/security.c:3130
> >        do_open fs/namei.c:3882 [inline]
> >        path_openat+0x2f26/0x3830 fs/namei.c:4039
> >        do_filp_open+0x1fa/0x410 fs/namei.c:4066
> >        do_sys_openat2+0x121/0x1c0 fs/open.c:1429
> >        do_sys_open fs/open.c:1444 [inline]
> >        __do_sys_openat fs/open.c:1460 [inline]
> >        __se_sys_openat fs/open.c:1455 [inline]
> >        __x64_sys_openat+0x138/0x170 fs/open.c:1455
> >        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >        do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
> >        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > -> #4 (btrfs_trans_num_writers){++++}-{0:0}:
> >        reacquire_held_locks+0x127/0x1d0 kernel/locking/lockdep.c:5383
> >        __lock_release kernel/locking/lockdep.c:5572 [inline]
> >        lock_release+0x1b4/0x3e0 kernel/locking/lockdep.c:5887
> >        percpu_up_read include/linux/percpu-rwsem.h:100 [inline]
> >        __sb_end_write include/linux/fs.h:1778 [inline]
> >        sb_end_intwrite+0x26/0x1c0 include/linux/fs.h:1895
> >        __btrfs_end_transaction+0x248/0x640 fs/btrfs/transaction.c:1075
> >        btrfs_dirty_inode+0x14c/0x190 fs/btrfs/inode.c:6143
> >        inode_update_time fs/inode.c:2076 [inline]
> >        __file_update_time fs/inode.c:2305 [inline]
> >        file_update_time+0x344/0x490 fs/inode.c:2335
> >        btrfs_page_mkwrite+0x634/0x16a0 fs/btrfs/file.c:1814
> >        do_page_mkwrite+0x14a/0x310 mm/memory.c:3287
> >        wp_page_shared mm/memory.c:3688 [inline]
> >        do_wp_page+0x2626/0x5760 mm/memory.c:3907
> >        handle_pte_fault mm/memory.c:6013 [inline]
> >        __handle_mm_fault+0x1028/0x5380 mm/memory.c:6140
> >        handle_mm_fault+0x2d5/0x7f0 mm/memory.c:6309
> >        do_user_addr_fault+0xa81/0x1390 arch/x86/mm/fault.c:1337
> >        handle_page_fault arch/x86/mm/fault.c:1480 [inline]
> >        exc_page_fault+0x68/0x110 arch/x86/mm/fault.c:1538
> >        asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
> >
> > -> #3 (sb_pagefaults#2){.+.+}-{0:0}:
> >        lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5866
> >        percpu_down_read include/linux/percpu-rwsem.h:52 [inline]
> >        __sb_start_write include/linux/fs.h:1783 [inline]
> >        sb_start_pagefault include/linux/fs.h:1948 [inline]
> >        btrfs_page_mkwrite+0x3b2/0x16a0 fs/btrfs/file.c:1798
> >        do_page_mkwrite+0x14a/0x310 mm/memory.c:3287
> >        do_shared_fault mm/memory.c:5594 [inline]
> >        do_fault mm/memory.c:5656 [inline]
> >        do_pte_missing mm/memory.c:4160 [inline]
> >        handle_pte_fault mm/memory.c:5997 [inline]
> >        __handle_mm_fault+0x18d2/0x5380 mm/memory.c:6140
> >        handle_mm_fault+0x2d5/0x7f0 mm/memory.c:6309
> >        do_user_addr_fault+0x764/0x1390 arch/x86/mm/fault.c:1388
> >        handle_page_fault arch/x86/mm/fault.c:1480 [inline]
> >        exc_page_fault+0x68/0x110 arch/x86/mm/fault.c:1538
> >        asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
> >
> > -> #2 (&mm->mmap_lock){++++}-{4:4}:
> >        lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5866
> >        down_read_killable+0x50/0x350 kernel/locking/rwsem.c:1547
> >        mmap_read_lock_killable+0x1d/0x70 include/linux/mmap_lock.h:193
> >        get_mmap_lock_carefully mm/memory.c:6355 [inline]
> >        lock_mm_and_find_vma+0x2a8/0x300 mm/memory.c:6406
> >        do_user_addr_fault+0x331/0x1390 arch/x86/mm/fault.c:1360
> >        handle_page_fault arch/x86/mm/fault.c:1480 [inline]
> >        exc_page_fault+0x68/0x110 arch/x86/mm/fault.c:1538
> >        asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
> >        filldir64+0x2b3/0x690 fs/readdir.c:371
> >        dir_emit include/linux/fs.h:3861 [inline]
> >        kernfs_fop_readdir+0x534/0x870 fs/kernfs/dir.c:1907
> >        iterate_dir+0x5ac/0x770 fs/readdir.c:108
> >        __do_sys_getdents64 fs/readdir.c:403 [inline]
> >        __se_sys_getdents64+0xe4/0x260 fs/readdir.c:389
> >        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >        do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
> >        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > -> #1 (&root->kernfs_rwsem){++++}-{4:4}:
> >        lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5866
> >        down_write+0x96/0x1f0 kernel/locking/rwsem.c:1577
> >        kernfs_add_one+0x41/0x520 fs/kernfs/dir.c:791
> >        kernfs_create_dir_ns+0xde/0x130 fs/kernfs/dir.c:1091
> >        sysfs_create_dir_ns+0x123/0x280 fs/sysfs/dir.c:59
> >        create_dir lib/kobject.c:73 [inline]
> >        kobject_add_internal+0x59f/0xb40 lib/kobject.c:240
> >        kobject_add_varg lib/kobject.c:374 [inline]
> >        kobject_init_and_add+0x125/0x190 lib/kobject.c:457
> >        btrfs_sysfs_add_qgroups+0x111/0x2b0 fs/btrfs/sysfs.c:2616
> >        btrfs_quota_enable+0x278/0x1d50 fs/btrfs/qgroup.c:1030
> >        btrfs_ioctl_quota_ctl+0x183/0x1c0 fs/btrfs/ioctl.c:3676
> >        vfs_ioctl fs/ioctl.c:51 [inline]
> >        __do_sys_ioctl fs/ioctl.c:906 [inline]
> >        __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:892
> >        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >        do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
> >        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > -> #0 (&fs_info->qgroup_ioctl_lock){+.+.}-{4:4}:
> >        check_prev_add kernel/locking/lockdep.c:3166 [inline]
> >        check_prevs_add kernel/locking/lockdep.c:3285 [inline]
> >        validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3909
> >        __lock_acquire+0xaac/0xd20 kernel/locking/lockdep.c:5235
> >        lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5866
> >        __mutex_lock_common kernel/locking/mutex.c:601 [inline]
> >        __mutex_lock+0x182/0xe80 kernel/locking/mutex.c:746
> >        btrfs_quota_enable+0x2be/0x1d50 fs/btrfs/qgroup.c:1059
> >        btrfs_ioctl_quota_ctl+0x183/0x1c0 fs/btrfs/ioctl.c:3676
> >        vfs_ioctl fs/ioctl.c:51 [inline]
> >        __do_sys_ioctl fs/ioctl.c:906 [inline]
> >        __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:892
> >        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >        do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
> >        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > other info that might help us debug this:
> >
> > Chain exists of:
> >   &fs_info->qgroup_ioctl_lock --> btrfs_trans_num_writers --> btrfs_trans_num_extwriters
> >
> >  Possible unsafe locking scenario:
> >
> >        CPU0                    CPU1
> >        ----                    ----
> >   rlock(btrfs_trans_num_extwriters);
> >                                lock(btrfs_trans_num_writers);
> >                                lock(btrfs_trans_num_extwriters);
> >   lock(&fs_info->qgroup_ioctl_lock);
> >
> >  *** DEADLOCK ***
> >
> > 5 locks held by syz.4.219/7436:
> >  #0: ffff8880259ac420 (sb_writers#17){.+.+}-{0:0}, at: mnt_want_write_file+0x60/0x200 fs/namespace.c:600
> >  #1: ffff88806ce70bd0 (&fs_info->subvol_sem){+.+.}-{4:4}, at: btrfs_ioctl_quota_ctl+0x178/0x1c0 fs/btrfs/ioctl.c:3675
> >  #2: ffff8880259ac610 (sb_internal#3){.+.+}-{0:0}, at: btrfs_quota_enable+0x2b1/0x1d50 fs/btrfs/qgroup.c:1057
> >  #3: ffff88806ce724d0 (btrfs_trans_num_writers){++++}-{0:0}, at: join_transaction+0x164/0xd70 fs/btrfs/transaction.c:320
> >  #4: ffff88806ce724f8 (btrfs_trans_num_extwriters){++++}-{0:0}, at: join_transaction+0x164/0xd70 fs/btrfs/transaction.c:320
>
> We assign a sequence number to each lock to represent the order in which
> they are held:
>
>         0: vfs freeze semaphores
>         1: qgroup_ioctl_lock
>         2: kernfs_rwsem
>         3: mmap_lock
>         4: btrfs_trans_num_writers
>         5: btrfs_trans_num_extwriters
>
>         cpu-0
>         =====
>         0: vfs freeze semaphores
>         4: btrfs_trans_num_writers
>         5: btrfs_trans_num_extwriters
>         1: qgroup_ioctl_lock
>
>         cpu-1
>         =====
>         1: qgroup_ioctl_lock
>         2: kernfs_rwsem
>
>         cpu-2
>         =====
>         2: kernfs_rwsem
>         3: mmap_lock
>
>         cpu-3
>         =====
>         3: mmap_lock
>         4: btrfs_trans_num_writers
>         5: btrfs_trans_num_extwriters
>
> I believe we should adjust the order of locks in the CPU-0 call stack by moving
> the acquisition of qgroup_ioctl_lock inside the start_transaction() function.

Do you mean from here (and many other locations)?

--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1056,7 +1056,6 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info,
         */
        trans = btrfs_start_transaction(tree_root, 2);

-       mutex_lock(&fs_info->qgroup_ioctl_lock);
        if (IS_ERR(trans)) {
                ret = PTR_ERR(trans);
                trans = NULL;

> After the adjustment, it becomes as follows:
>
>         0: vfs freeze semaphores
>         1: qgroup_ioctl_lock
>         4: btrfs_trans_num_writers
>         5: btrfs_trans_num_extwriters
>
>         static struct btrfs_trans_handle *
>         start_transaction(struct btrfs_root *root, unsigned int num_items,
>                         unsigned int type, enum btrfs_reserve_flush_enum flush,
>                         bool enforce_qgroups)
>         {
>                 ...
>
>                 /*
>                 * If we are JOIN_NOLOCK we're already committing a transaction and
>                 * waiting on this guy, so we don't need to do the sb_start_intwrite
>                 * because we're already holding a ref.  We need this because we could
>                 * have raced in and did an fsync() on a file which can kick a commit
>                 * and then we deadlock with somebody doing a freeze.
>                 *
>                 * If we are ATTACH, it means we just want to catch the current
>                 * transaction and commit it, so we needn't do sb_start_intwrite().
>                 */
>                 if (type & __TRANS_FREEZABLE)
>                         sb_start_intwrite(fs_info->sb);
>
>                 mutex_lock(&fs_info->qgroup_ioctl_lock);
>                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
>                 if (may_wait_transaction(fs_info, type))
>                         wait_current_trans(fs_info);

And how about putting it only after the wait?

>                 do {
>                         ret = join_transaction(fs_info, type);
>                         if (ret == -EBUSY) {
>                                 wait_current_trans(fs_info);
>                                 if (unlikely(type == TRANS_ATTACH ||
>                                         type == TRANS_JOIN_NOSTART))
>                                         ret = -ENOENT;
>                         }
>                 } while (ret == -EBUSY);
>
>                 ...
>         }
>

