Return-Path: <linux-btrfs+bounces-9843-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 230B79D6B6E
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Nov 2024 21:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE0FE282A5A
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Nov 2024 20:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD31619340F;
	Sat, 23 Nov 2024 20:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcv8SubQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E84517BA6
	for <linux-btrfs@vger.kernel.org>; Sat, 23 Nov 2024 20:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732393235; cv=none; b=Yb6EGMXQvS0OLudu5e+Qu632jXWnNiiexa3S7FYNp+VASX60RLTP3ktBGHEzMD/7jhrIkLZ9G+H6pds+SdqbSLlzRONM1zlG3xle76MH6XX+QAcBcPBQkfDrQfyG4h4QbAk4nYmNHWXZM06nx0o5ucLIN3pxc61d4i+wiIP5G4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732393235; c=relaxed/simple;
	bh=TSIXj0vN7x46qk/e9JjE1yn47X1Fmb7un/jY/h8kFL8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nI+4/tx82f0j/goSUZDEvrs854z8vMtVSb02oidsDRyMeVNnu+hW5Gkj42OT4ILvCL61o4b3+dQe3ReI8V2ebD3DXxG2mNj8dwWXf1RqcuYlyAHCvhGW1fAP+bnWYuYNe1EjAow9bmCZQuvK9+4wAWbpyhKDapF4Zkp91IPF6ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcv8SubQ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-431481433bdso28814775e9.3
        for <linux-btrfs@vger.kernel.org>; Sat, 23 Nov 2024 12:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732393231; x=1732998031; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OWxGV8VftvSsma7ZiBHXLvqGocXXC45z1W1PeoufShA=;
        b=bcv8SubQPmDj65Nxjw0PVpWyGuz8L2HZSTwuv3qBIWebqTJgycE0B/+XW8dD29c5G6
         xKJFv679lYIvH85EQrEPb0RhsOhwJZzjIgFQCYVH+Rf+NEAdvNInpLaY8DiA5gUa1Qbr
         7YAm3SZBwaRqPmKtiRu2dKGkofTvXQUqYdamo2y/bfLDcswjOJmI6Pkz1GQM4Q7l/XHW
         7zzimkVUa9P9Eli7myLZ/x+ZurnPDdl6EdESrBjXPi6wD40E/s+6L8SJEWO+WX0tJOuP
         Gl3oKVLynWma6g+3gddjAzlmgUlHaO6ArFK5FSarbBQaOdPvGoI3MGCsKTEk2ZN1t6p0
         Yuqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732393231; x=1732998031;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OWxGV8VftvSsma7ZiBHXLvqGocXXC45z1W1PeoufShA=;
        b=BegUjJ9vz+5mE2Rd4BWJpbQ/xAHsdYGS7hvQt9SlDVCSp5ZR+lf+ALC5OZTDraII1L
         Mg2TZ7CVx+7X3uu5ojaK/lpxPa8UY5CxllZcO4nzjMdNhV2Cu2NSrmQSXAQ3qhv5cvTy
         4fmOeYBP20qQp+MKH/cqFt6Mibw1ppfTppl1lpeK6zSjvQqg5IrWiOGBaxqWkImrTLuP
         umgVHcjiG5RBhbm6b4CidYfanXKBpuHxSF6ZTdAFb2LgNX4EA2OlSgyHYEYIY7jD3+br
         SlmrQLbDQbWn4tka9tnPk2mbYaPD2g1bn/0qDqNTrLyKUYbI+vnZ7OFXORzcit90j6bC
         rpvg==
X-Gm-Message-State: AOJu0YwkIgRFPnBLQggCmL1m1iTft9/rZ5K77+p9AmqyDs4oRZduxnoT
	5XtA5orsLzZBv15sR5A4A2oXrJBPTM7kYRkTGGzKhuVlOB7tBpvOWx3P2mHS
X-Gm-Gg: ASbGncupMxnJqnOz28UXQXqe5tIaagbIi90P//hyJ4Zg6q4JuLeGy38AarvaylYwtSc
	YuViwaPyeo4pIukdfrCsmzH4QNxTxGB6EBdb+Uc1cYS7yOnz4nxbht0H1M/v5Q5Q6hwmGqBakLU
	9GjZLVIyj012qdDUuSx6h/uq9U3H9fS3q908pQ5ZbKvgR/jWE0eRYtPBmhJQGJTLGu2NxaDqnX+
	73L1HDektSuB9Xy7a9kLdNKcKmiwJzdbhj56RGLN7fuX1vmyP5muG7BXgM=
X-Google-Smtp-Source: AGHT+IGpg0OhQgEkdMBy5NiNWoiW8E7iuHkDv70x5lGXztrQAFM5+hbSMwo3lRtdhzxFoUANEEcpyQ==
X-Received: by 2002:a05:600c:5643:b0:430:5887:c238 with SMTP id 5b1f17b1804b1-434872f5942mr55681945e9.11.1732393231098;
        Sat, 23 Nov 2024 12:20:31 -0800 (PST)
Received: from debian.local ([84.66.149.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434932dbc7esm19701585e9.37.2024.11.23.12.20.29
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2024 12:20:30 -0800 (PST)
Date: Sat, 23 Nov 2024 20:20:28 +0000
From: Chris Bainbridge <chris.bainbridge@gmail.com>
To: linux-btrfs@vger.kernel.org
Subject: WARNING: possible circular locking dependency detected
Message-ID: <Z0I5DApYx_uqT2pb@debian.local>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I noticed this splat in the log of a new kernel build. I think it was
triggered when mounting a btrfs filesystem from a USB drive, but I
wasn't able to reproduce it so easily.

[  781.752971] ======================================================
[  781.752973] WARNING: possible circular locking dependency detected
[  781.752974] 6.12.0-08446-g228a1157fb9f #5 Not tainted
[  781.752976] ------------------------------------------------------
[  781.752977] kswapd0/141 is trying to acquire lock:
[  781.752978] ffff991d17e61ce8 (&delayed_node->mutex){+.+.}-{4:4}, at: __btrfs_release_delayed_node.part.0+0x3f/0x280 [btrfs]
[  781.753030]
               but task is already holding lock:
[  781.753031] ffffffffa00c8100 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0xc9/0xa80
[  781.753037]
               which lock already depends on the new lock.

[  781.753038]
               the existing dependency chain (in reverse order) is:
[  781.753039]
               -> #3 (fs_reclaim){+.+.}-{0:0}:
[  781.753042]        fs_reclaim_acquire+0xbd/0xf0
[  781.753045]        __kmalloc_node_noprof+0xa9/0x4f0
[  781.753048]        __kvmalloc_node_noprof+0x24/0x100
[  781.753049]        sbitmap_init_node+0x98/0x240
[  781.753053]        scsi_realloc_sdev_budget_map+0xdd/0x1d0
[  781.753056]        scsi_add_lun+0x458/0x760
[  781.753058]        scsi_probe_and_add_lun+0x15e/0x480
[  781.753060]        __scsi_scan_target+0xfb/0x230
[  781.753062]        scsi_scan_channel+0x65/0xc0
[  781.753064]        scsi_scan_host_selected+0xfb/0x160
[  781.753066]        do_scsi_scan_host+0x9d/0xb0
[  781.753067]        do_scan_async+0x1c/0x1a0
[  781.753069]        async_run_entry_fn+0x2d/0x120
[  781.753072]        process_one_work+0x210/0x730
[  781.753075]        worker_thread+0x193/0x350
[  781.753077]        kthread+0xf3/0x120
[  781.753079]        ret_from_fork+0x40/0x70
[  781.753081]        ret_from_fork_asm+0x11/0x20
[  781.753084]
               -> #2 (&q->q_usage_counter(io)#10){++++}-{0:0}:
[  781.753087]        blk_mq_submit_bio+0x970/0xb40
[  781.753090]        __submit_bio+0x116/0x200
[  781.753093]        submit_bio_noacct_nocheck+0x1bf/0x420
[  781.753095]        submit_bio_noacct+0x1cd/0x620
[  781.753097]        submit_bio+0x38/0x100
[  781.753099]        btrfs_submit_dev_bio+0xf1/0x340 [btrfs]
[  781.753132]        btrfs_submit_bio+0x132/0x170 [btrfs]
[  781.753160]        btrfs_submit_chunk+0x19a/0x650 [btrfs]
[  781.753187]        btrfs_submit_bbio+0x1b/0x30 [btrfs]
[  781.753215]        read_extent_buffer_pages+0x197/0x220 [btrfs]
[  781.753254]        btrfs_read_extent_buffer+0x95/0x1d0 [btrfs]
[  781.753292]        read_block_for_search+0x21c/0x3b0 [btrfs]
[  781.753328]        btrfs_search_slot+0x362/0x1030 [btrfs]
[  781.753359]        btrfs_init_root_free_objectid+0x88/0x120 [btrfs]
[  781.753392]        btrfs_get_root_ref+0x21a/0x3c0 [btrfs]
[  781.753422]        btrfs_get_fs_root+0x13/0x20 [btrfs]
[  781.753450]        btrfs_lookup_dentry+0x606/0x670 [btrfs]
[  781.753482]        btrfs_lookup+0x12/0x40 [btrfs]
[  781.753511]        __lookup_slow+0xf9/0x1a0
[  781.753514]        walk_component+0x10c/0x180
[  781.753516]        path_lookupat+0x67/0x1a0
[  781.753518]        filename_lookup+0xee/0x200
[  781.753520]        vfs_path_lookup+0x54/0x90
[  781.753522]        mount_subtree+0x8b/0x150
[  781.753525]        btrfs_get_tree+0x3a3/0x890 [btrfs]
[  781.753557]        vfs_get_tree+0x27/0x100
[  781.753563]        path_mount+0x4f3/0xc00
[  781.753566]        __x64_sys_mount+0x120/0x160
[  781.753568]        x64_sys_call+0x8a1/0xfb0
[  781.753569]        do_syscall_64+0x87/0x140
[  781.753573]        entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  781.753578]
               -> #1 (btrfs-tree-01){++++}-{4:4}:
[  781.753581]        lock_release+0x12f/0x2c0
[  781.753586]        up_write+0x1c/0x1f0
[  781.753587]        btrfs_tree_unlock+0x33/0xc0 [btrfs]
[  781.753625]        unlock_up+0x1ce/0x380 [btrfs]
[  781.753657]        btrfs_search_slot+0x33a/0x1030 [btrfs]
[  781.753683]        btrfs_lookup_inode+0x52/0xe0 [btrfs]
[  781.753702]        __btrfs_update_delayed_inode+0x6f/0x2f0 [btrfs]
[  781.753723]        btrfs_commit_inode_delayed_inode+0x123/0x130 [btrfs]
[  781.753741]        btrfs_evict_inode+0x2ff/0x440 [btrfs]
[  781.753761]        evict+0x11f/0x2d0
[  781.753763]        iput.part.0+0x1bb/0x290
[  781.753764]        iput+0x1c/0x30
[  781.753765]        do_unlinkat+0x2d2/0x320
[  781.753767]        __x64_sys_unlinkat+0x35/0x70
[  781.753768]        x64_sys_call+0x51b/0xfb0
[  781.753769]        do_syscall_64+0x87/0x140
[  781.753771]        entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  781.753773]
               -> #0 (&delayed_node->mutex){+.+.}-{4:4}:
[  781.753774]        __lock_acquire+0x1615/0x27d0
[  781.753776]        lock_acquire+0xc9/0x300
[  781.753777]        __mutex_lock+0xd9/0xe80
[  781.753780]        mutex_lock_nested+0x1b/0x30
[  781.753781]        __btrfs_release_delayed_node.part.0+0x3f/0x280 [btrfs]
[  781.753799]        btrfs_remove_delayed_node+0x2a/0x40 [btrfs]
[  781.753816]        btrfs_evict_inode+0x1a5/0x440 [btrfs]
[  781.753834]        evict+0x11f/0x2d0
[  781.753835]        dispose_list+0x39/0x80
[  781.753836]        prune_icache_sb+0x59/0x90
[  781.753838]        super_cache_scan+0x14e/0x1d0
[  781.753839]        do_shrink_slab+0x176/0x7a0
[  781.753841]        shrink_slab+0x4b6/0x970
[  781.753842]        shrink_one+0x125/0x200
[  781.753844]        shrink_node+0xc75/0x13c0
[  781.753846]        balance_pgdat+0x50b/0xa80
[  781.753847]        kswapd+0x224/0x480
[  781.753849]        kthread+0xf3/0x120
[  781.753850]        ret_from_fork+0x40/0x70
[  781.753852]        ret_from_fork_asm+0x11/0x20
[  781.753853]
               other info that might help us debug this:

[  781.753853] Chain exists of:
                 &delayed_node->mutex --> &q->q_usage_counter(io)#10 --> fs_reclaim

[  781.753856]  Possible unsafe locking scenario:

[  781.753857]        CPU0                    CPU1
[  781.753858]        ----                    ----
[  781.753858]   lock(fs_reclaim);
[  781.753859]                                lock(&q->q_usage_counter(io)#10);
[  781.753861]                                lock(fs_reclaim);
[  781.753862]   lock(&delayed_node->mutex);
[  781.753863]
                *** DEADLOCK ***

[  781.753864] 2 locks held by kswapd0/141:
[  781.753865]  #0: ffffffffa00c8100 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0xc9/0xa80
[  781.753868]  #1: ffff991d1dbc30e0 (&type->s_umount_key#30){++++}-{4:4}, at: super_cache_scan+0x39/0x1d0
[  781.753872]
               stack backtrace:
[  781.753873] CPU: 13 UID: 0 PID: 141 Comm: kswapd0 Not tainted 6.12.0-08446-g228a1157fb9f #5
[  781.753875] Hardware name: HP HP Pavilion Aero Laptop 13-be0xxx/8916, BIOS F.12 04/11/2023
[  781.753876] Call Trace:
[  781.753877]  <TASK>
[  781.753880]  dump_stack_lvl+0x8d/0xe0
[  781.753883]  dump_stack+0x10/0x20
[  781.753885]  print_circular_bug+0x27d/0x350
[  781.753887]  check_noncircular+0x14c/0x170
[  781.753889]  __lock_acquire+0x1615/0x27d0
[  781.753892]  lock_acquire+0xc9/0x300
[  781.753894]  ? __btrfs_release_delayed_node.part.0+0x3f/0x280 [btrfs]
[  781.753912]  __mutex_lock+0xd9/0xe80
[  781.753914]  ? __btrfs_release_delayed_node.part.0+0x3f/0x280 [btrfs]
[  781.753931]  ? __btrfs_release_delayed_node.part.0+0x3f/0x280 [btrfs]
[  781.753948]  mutex_lock_nested+0x1b/0x30
[  781.753949]  ? mutex_lock_nested+0x1b/0x30
[  781.753951]  __btrfs_release_delayed_node.part.0+0x3f/0x280 [btrfs]
[  781.753968]  btrfs_remove_delayed_node+0x2a/0x40 [btrfs]
[  781.753984]  btrfs_evict_inode+0x1a5/0x440 [btrfs]
[  781.754003]  ? lock_release+0xda/0x2c0
[  781.754007]  evict+0x11f/0x2d0
[  781.754009]  dispose_list+0x39/0x80
[  781.754010]  prune_icache_sb+0x59/0x90
[  781.754011]  super_cache_scan+0x14e/0x1d0
[  781.754014]  do_shrink_slab+0x176/0x7a0
[  781.754016]  shrink_slab+0x4b6/0x970
[  781.754018]  ? mark_held_locks+0x4d/0x80
[  781.754019]  ? shrink_slab+0x2fe/0x970
[  781.754021]  ? shrink_slab+0x383/0x970
[  781.754023]  shrink_one+0x125/0x200
[  781.754025]  ? shrink_node+0xc59/0x13c0
[  781.754027]  shrink_node+0xc75/0x13c0
[  781.754029]  ? shrink_node+0xaa7/0x13c0
[  781.754031]  ? mem_cgroup_iter+0x352/0x470
[  781.754034]  balance_pgdat+0x50b/0xa80
[  781.754035]  ? balance_pgdat+0x50b/0xa80
[  781.754037]  ? finish_task_switch.isra.0+0xd7/0x3a0
[  781.754042]  kswapd+0x224/0x480
[  781.754044]  ? sugov_hold_freq+0xc0/0xc0
[  781.754046]  ? balance_pgdat+0xa80/0xa80
[  781.754047]  kthread+0xf3/0x120
[  781.754049]  ? kthread_insert_work_sanity_check+0x60/0x60
[  781.754051]  ret_from_fork+0x40/0x70
[  781.754052]  ? kthread_insert_work_sanity_check+0x60/0x60
[  781.754054]  ret_from_fork_asm+0x11/0x20
[  781.754057]  </TASK>

