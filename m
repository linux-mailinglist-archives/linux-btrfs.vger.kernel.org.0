Return-Path: <linux-btrfs+bounces-14978-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E491AE982D
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 10:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6C57188675A
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 08:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E423B27CB02;
	Thu, 26 Jun 2025 08:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARqYvKm/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99033277CB4;
	Thu, 26 Jun 2025 08:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750926237; cv=none; b=hllYS3zb0DYwKj4SQefPO79kE87gsQTAW+itZD3JBlZLYfeNLV+UULwh7LPneVohVloQvu0IVrRX8cig8sIEJiFVExrvhZIQKHByQyQNsIPsgSQt4Sj2dVizao6aWh8DFYICUJ6Vc6FDf0x1eTH/y+4uieWGN77YseY4aYwCLIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750926237; c=relaxed/simple;
	bh=2sg4aKZ50PN6JTMf/VRT1394fNauO+9uaVnhwqbtqOs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=p00VyhSsqTEVRH1bbxQyP/DB78t98x28yqo2e/qJYfsFzVk11/5rMSbJRwl2HYcpX0pVOnKcEuufbnsImUgRo+AGZNyy74yCgFAl59KM0+4lj1omzjTXWsMcWKXQVcEvA7hZzMxTb6Rdkl8+8Nu5Vk1c9whkuPwi4xpvg0MZ6I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ARqYvKm/; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-311e46d38ddso676525a91.0;
        Thu, 26 Jun 2025 01:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750926235; x=1751531035; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Tsh3K6SkAfSJY7NsGkkV19W6WnijDmjK5b+ryFXoGuk=;
        b=ARqYvKm//MxRBaiNEndTA6EgHqBjl5UU8fMgVaQfVqtJRhA7oZSpPD6mabT/vfffnu
         CcXsLFRDveQgddOsqqUTroCIU7jYoZti1pNhj+JY55BN5w7KwAA9SQ6Xl0C8C5Y2Kml4
         TQbVH1dr+9ixPDzjGlm9b33YzrKv+1cXaHpSnaHLEWqLf/55BtEhHrBuTZwG5j62Rdca
         0WVgzTZv8gv2XHKiNdkLvXqPObw4i7VEeMdAzyVFtsIGDCupuh/dq+xncU6QuCBf13pP
         98GWiXSCYMJuqsA+PmT2b2roEwiUuft8Mz9zw9m60kB+m6o+LcSRAhVIYCFUp+S2FFbg
         E9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750926235; x=1751531035;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tsh3K6SkAfSJY7NsGkkV19W6WnijDmjK5b+ryFXoGuk=;
        b=QlEoOhbv9n6PGjEhw+NBwF6SGbfVrudFuurmWA1y4vtkot/OFgbmYO5Vq/RX6/VPJC
         LWjQkW1s1QqzGac0MhBpg2c0EYdS4kN75kGYFvISXeuwAWI9nAhdOKz8hnpp7hNU+zry
         SjvGEnN1U1c5c5H+NeZNbpt7TnDuL2RO5eiQSom+pb38P6gwSROFhqpwRh0SU7rhBGgv
         ZMoeO6zZbI3gA+BPxf+XXCZ3sCK1up1PluXXoD+okAEFRe/fd4qAWLaRVJNSTqazzblu
         r9dwHS1b+bP+Hs94EmrPUB6ii28KYiaMRCZQkSRxH8YwJUuz5Se0AxudfsVlARHS3L2a
         jYGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfXM9+XabPWeYG1WLqZbw3bgrr/gNXW1VG+jWaM/+9rXMHYxq+K3Kp3toZEDjkVgESINVIyyi3RouACZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlWOwkB50XNZjTjrwNLNCt4TN19kQdzB/UDVnwTRocPRfwpnT0
	sqp6CVlalI2WoKa93w/rdyg889bKKWZjZt2jwStnRI3tM9BD5+Cj9UqiR2mv1wwxG95YJbVUMpT
	l/XP+C9ANn+d0mH95KjLfUPxRhbm8U1s=
X-Gm-Gg: ASbGncs7ZWcrMrWZrSIcR4hhg/o1+HyQqTPYxPG2TfNWrxCt5GlyNx8BcepCozLBF42
	0FTdyOEErIKicJ9Iz898lqbhjxJHJqrF/Z+oCV/beuUaPrw96RW6IchnEq6hZ9GBtpEz0aTe5HG
	5WGS/HxUqWEx7A4i9RqBFfJm1821TGQqY5A+bRiKJzOxI/3A==
X-Google-Smtp-Source: AGHT+IEGKAohTJSHe22xS/jVsWWxT1Fmy3ETG3MSsLsZMPN88Wib90yrGSu/JbMYnIrfFkX0sXh5lR66MNgYDAZvlm8=
X-Received: by 2002:a17:90b:3841:b0:313:27e5:7ff1 with SMTP id
 98e67ed59e1d1-316158914c3mr3651277a91.1.1750926234747; Thu, 26 Jun 2025
 01:23:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: haoran zheng <zhenghaoran154@gmail.com>
Date: Thu, 26 Jun 2025 16:23:43 +0800
X-Gm-Features: Ac12FXx_b22x_S53c8T6GrLkNkO30iOuZVu8b-qSK91ehaiZWEJ-0il9Sa56c5s
Message-ID: <CAKa5YKiTodi=aDMqa8gb4o+4RAdis=-OYFv4HP9nQ3EHcCTzMA@mail.gmail.com>
Subject: [BUG] Five data races in btrfs
To: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, zzzccc427@gmail.com
Content-Type: text/plain; charset="UTF-8"

[BUG] Five data races in btrfs

Hello maintainers,

I would like to report five data race bugs we discovered in the BTRFS
filesystem on Linux kernel v6.16-rc3. These issues were identified
using our data race detector.

We are currently analyzing the Btrfs codebase and have identified
several instances that may involve potential data races during
concurrent execution. While we have reviewed the relevant code
paths carefully, we are uncertain whether these issues could lead
to any practical impact or system instability.

Below is a summary of the findings:

---

1. Race between `__btrfs_set_fs_incompat()` and `btrfs_fs_incompat()`

`__btrfs_set_fs_incompat()` performs a write to the
`super_copy->incompat_flags` field under `fs_info->super_lock` while
`btrfs_need_stripe_tree_update()` calls `btrfs_fs_incompat()` without
acquiring `super_lock`, which may read a stale or partially updated
value of `incompat_flags`.

===========================DATARACE===========================
 __btrfs_set_fs_incompat+0x12b/0x150 fs/btrfs/fs.c:150
 btrfs_ioctl_default_subvol+0x2e5/0x380 fs/btrfs/ioctl.c:2930
 btrfs_ioctl+0xd1f/0xe40 fs/btrfs/ioctl.c:5249
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0x91/0xf0 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1a0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
 0x0
============OTHER_INFO============
 get_unaligned_le64 include/linux/unaligned.h:28 [inline]
 btrfs_super_incompat_flags fs/btrfs/accessors.h:890 [inline]
 btrfs_need_stripe_tree_update fs/btrfs/raid-stripe-tree.h:42 [inline]
 btrfs_map_block+0x426/0x1960 fs/btrfs/volumes.c:6674
 btrfs_submit_chunk fs/btrfs/bio.c:694 [inline]
 btrfs_submit_bbio+0x291/0xa70 fs/btrfs/bio.c:799
 write_one_eb+0x8d8/0x960 fs/btrfs/extent_io.c:1828
 submit_eb_page fs/btrfs/extent_io.c:1985 [inline]
 btree_write_cache_pages+0x3b1/0x8e0 fs/btrfs/extent_io.c:2035
 btree_writepages+0x6b/0x190 fs/btrfs/disk-io.c:520
 do_writepages+0x102/0x370 mm/page-writeback.c:2687
 filemap_fdatawrite_wbc mm/filemap.c:389 [inline]
 __filemap_fdatawrite_range mm/filemap.c:422 [inline]
 filemap_fdatawrite_range+0x9a/0xd0 mm/filemap.c:440
 btrfs_write_marked_extents+0x130/0x230 fs/btrfs/transaction.c:1150
 btrfs_sync_log+0xcfd/0x11f0 fs/btrfs/tree-log.c:3113
 btrfs_sync_file+0x74b/0xaa0 fs/btrfs/file.c:1692
 generic_write_sync include/linux/fs.h:2970 [inline]
 btrfs_do_write_iter+0x4ba/0x5a0 fs/btrfs/file.c:1391
 btrfs_file_write_iter+0x3d/0x60 fs/btrfs/file.c:1401
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0x379/0x580 fs/read_write.c:679
 ksys_write+0x93/0x120 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1a0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
=================================

---

2. Race between `btrfs_defrag_file()` and `inode_need_compress()`

In `btrfs_defrag_file()`, the field `inode->defrag_compress` is
assigned while holding the inode lock via `btrfs_inode_lock()`.
But in `inode_need_compress()`, the same field is read without
any apparent locking or memory barrier.

===========================DATARACE===========================
 btrfs_defrag_file+0x127d/0x1570 fs/btrfs/defrag.c:1501
 btrfs_ioctl_defrag+0x256/0x2f0 fs/btrfs/ioctl.c:2574
 btrfs_ioctl+0xba4/0xe40
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0x91/0xf0 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1a0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
 0x0
============OTHER_INFO============
 inode_need_compress fs/btrfs/inode.c:788 [inline]
 btrfs_run_delalloc_range+0x206/0x8a0 fs/btrfs/inode.c:2336
 writepage_delalloc+0x52c/0x8b0 fs/btrfs/extent_io.c:1255
 extent_writepage fs/btrfs/extent_io.c:1558 [inline]
 extent_write_cache_pages fs/btrfs/extent_io.c:2248 [inline]
 btrfs_writepages+0x930/0xe70 fs/btrfs/extent_io.c:2376
 do_writepages+0x102/0x370 mm/page-writeback.c:2687
 filemap_fdatawrite_wbc mm/filemap.c:389 [inline]
 __filemap_fdatawrite_range mm/filemap.c:422 [inline]
 filemap_fdatawrite_range+0x9a/0xd0 mm/filemap.c:440
 btrfs_fdatawrite_range+0x6b/0xf0 fs/btrfs/file.c:3701
 btrfs_direct_write+0x37d/0x6b0 fs/btrfs/direct-io.c:960
 btrfs_do_write_iter+0x21f/0x5a0 fs/btrfs/file.c:1381
 btrfs_file_write_iter+0x3d/0x60 fs/btrfs/file.c:1401
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0x379/0x580 fs/read_write.c:679
 ksys_write+0x93/0x120 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1a0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
=================================

---

3. Race between `join_transaction()` and `btrfs_get_fs_generation()`

In `join_transaction()`, `fs_info->generation` is assigned while
holding the lock `fs_info->trans_lock`. But reads of
`fs_info->generation` are done using READ_ONCE() in
`btrfs_get_fs_generation()`.

===========================DATARACE===========================
 join_transaction+0x6ee/0x740 fs/btrfs/transaction.c:390
 start_transaction+0x54e/0xea0 fs/btrfs/transaction.c:699
 btrfs_join_transaction+0x42/0x60 fs/btrfs/transaction.c:823
 btrfs_dirty_inode+0xa6/0x1c0 fs/btrfs/inode.c:6093
 btrfs_update_time+0xa3/0xe0 fs/btrfs/inode.c:6127
 inode_update_time fs/inode.c:2124 [inline]
 touch_atime+0xb7/0x1d0 fs/inode.c:2197
 file_accessed include/linux/fs.h:2601 [inline]
 filemap_read+0x49d/0x520 mm/filemap.c:2763
 btrfs_file_read_iter+0x71/0x190 fs/btrfs/file.c:3658
 new_sync_read fs/read_write.c:484 [inline]
 vfs_read+0x311/0x460 fs/read_write.c:565
 ksys_read+0x93/0x120 fs/read_write.c:708
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1a0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
 0x0
============OTHER_INFO============
 btrfs_get_fs_generation fs/btrfs/fs.h:915 [inline]
 try_release_extent_mapping+0x13b/0x3a0 fs/btrfs/extent_io.c:2489
 __btrfs_release_folio fs/btrfs/inode.c:7267 [inline]
 btrfs_invalidate_folio+0x666/0x730 fs/btrfs/inode.c:7466
 folio_invalidate mm/truncate.c:126 [inline]
 truncate_cleanup_folio+0xf5/0x130 mm/truncate.c:146
 truncate_inode_pages_range+0x126/0x4c0 mm/truncate.c:326
 truncate_inode_pages mm/truncate.c:407 [inline]
 truncate_pagecache mm/truncate.c:716 [inline]
 truncate_setsize+0x71/0x90 mm/truncate.c:741
 btrfs_setsize fs/btrfs/inode.c:5126 [inline]
 btrfs_setattr+0x351/0xa30 fs/btrfs/inode.c:5165
 notify_change+0x4d8/0x550 fs/attr.c:552
 do_truncate+0x11b/0x160 fs/open.c:65
 handle_truncate fs/namei.c:3451 [inline]
 do_open fs/namei.c:3834 [inline]
 path_openat+0xfad/0x1210 fs/namei.c:3989
 do_filp_open+0xda/0x1d0 fs/namei.c:4016
 do_sys_openat2+0x91/0x100 fs/open.c:1428
 do_sys_open fs/open.c:1443 [inline]
 __do_sys_open fs/open.c:1451 [inline]
 __se_sys_open fs/open.c:1447 [inline]
 __x64_sys_open+0xac/0xd0 fs/open.c:1447
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1a0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
=================================

---

4. Race between `btrfs_super_bytes_used()` and `btrfs_update_block_group()`

In `btrfs_set_backup_bytes_used()`, super_copy is read and stored  without
holding lock `info->delalloc_root_lock`. But in `btrfs_update_block_group()`
the `info->super_copy` is set concurrently.

===========================DATARACE===========================
 get_unaligned_le64 include/linux/unaligned.h:28 [inline]
 btrfs_super_bytes_used fs/btrfs/accessors.h:874 [inline]
 backup_super_roots fs/btrfs/disk-io.c:1706 [inline]
 write_all_supers+0xf9d/0x1dc0 fs/btrfs/disk-io.c:4101
 btrfs_commit_transaction+0xf73/0x1c40 fs/btrfs/transaction.c:2528
 transaction_kthread+0x1f8/0x330 fs/btrfs/disk-io.c:1602
 kthread+0x2d5/0x300 kernel/kthread.c:464
 ret_from_fork+0x4d/0x60 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
============OTHER_INFO============
 btrfs_update_block_group+0xf0/0x7a0 fs/btrfs/block-group.c:3650
 do_free_extent_accounting fs/btrfs/extent-tree.c:2975 [inline]
 __btrfs_free_extent+0xde5/0x1d00 fs/btrfs/extent-tree.c:3338
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1976 [inline]
 __btrfs_run_delayed_refs+0x5a3/0x1a50 fs/btrfs/extent-tree.c:2046
 btrfs_run_delayed_refs+0xd1/0x2b0 fs/btrfs/extent-tree.c:2158
 btrfs_commit_transaction+0x27a/0x1c40 fs/btrfs/transaction.c:2196
 insert_balance_item fs/btrfs/volumes.c:3771 [inline]
 btrfs_balance+0x11a4/0x1770 fs/btrfs/volumes.c:4647
 btrfs_ioctl_balance+0x290/0x470 fs/btrfs/ioctl.c:3587
 btrfs_ioctl+0xcaf/0xe40 fs/btrfs/ioctl.c:5305
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0x91/0xf0 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1a0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77

---

5. Race between `btrfs_defrag_file()` and `btrfs_defrag_file()`

In the function btrfs_defrag_file(), we also noticed a possible
race condition involving the writeback_index field of the
address_space structure associated with the inode. Specifically,
the code performs a read and conditional write without any
evident locking:

===========================DATARACE===========================
 btrfs_defrag_file+0x2ca/0x1570 fs/btrfs/defrag.c:1426
 btrfs_ioctl_defrag+0x256/0x2f0 fs/btrfs/ioctl.c:2574
 btrfs_ioctl+0xd56/0xe40
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0x91/0xf0 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1a0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
 0x0
============OTHER_INFO============
 btrfs_defrag_file+0x2fa/0x1570 fs/btrfs/defrag.c:1427
 btrfs_ioctl_defrag+0x256/0x2f0 fs/btrfs/ioctl.c:2574
 btrfs_ioctl+0xd56/0xe40
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0x91/0xf0 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1a0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
=================================

