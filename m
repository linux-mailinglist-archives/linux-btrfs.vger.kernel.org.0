Return-Path: <linux-btrfs+bounces-8112-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 032B497BE4E
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Sep 2024 17:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74968B2180B
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Sep 2024 15:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1461C8FD0;
	Wed, 18 Sep 2024 15:03:27 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAAE1C8FBD
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Sep 2024 15:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726671806; cv=none; b=XeKrtDLJZeO111T9Hv1uSzIJFucQtVfCtzw05ljwPKkRiolk9iZPrcPRsnKgFI49SN4l7VlGiwjC+wVPb5TQKxoLRg9sckhA5aEdpLiDkszteTdQlvFK1e5c/12GdNKLQ2JkQkGSeQxAihyTFWSOCwAWJobGjJ9HCw8ghYmmWYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726671806; c=relaxed/simple;
	bh=BhzpLIq6Vxfl5iUIGMXzekYXB+e52TdqSnfp5qidmWE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ldz4EPJTxtgY3U0l9d3ughKHf6P93yCe3154BaPsYuZMwDdyx3lta+rhD8QSPGt1wpkOuPdBWQ6oSmRkyjMqqji+kmkGXisOM7pxXq2JrFB0E3axIGsQRuSwsMG0vDtW9vz1U8nC1VTbar8ZiieoSQUGep+xvbjMzmyMYlT34fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a04bf03b1aso123441875ab.1
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Sep 2024 08:03:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726671804; x=1727276604;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+UC6Mc3Avq1l/u0KK21V2/bnbzcYLVONph6/3dO9HTk=;
        b=SVuWlquu0Dlj59COUX9p5W7MIcPpRdGHJQh+YRbLPrx2N6+LytDPGhMzOMigK6rzJO
         bszWM8UUWHquQ+W+TD78PtrMs15jPfZ9XA5VyDrRgrRVdGXt3slX+imLB3O83GXTiZV5
         nIVB1fL1S0NKYYgiSvcvEE2zWFzq+NxVPdv1eSSuMToff6CWivwDPM7CValMiOGYmmwz
         p/NGY2CXuKvZWWjOyzB92Hpaxecz9ddhpM7Lh+qkat+t8MYERUga3GJSTLbh+MRgXD2N
         vsfCYNXizfWPpnXEgTjtMU0BQxpXqwgm0ro0leajw22yaoiGCuQTMFe8zqK+K05a70fc
         5bhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOujjamsVwCNQfGBR7iar1mtzn7aqJ6JD0Ys4fwGYotSC76VU7BIu5xH8IY7YgKcPAYK6q0WxUjB8fcA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx9ycI4bA87vecAAVv7bkWq/NxYwHv/+MLcC9HbomLMJ/W0wDF
	elu+mJIRe7as6eDpNh2rBtSfrUCBiu2wQMAr3ldFilNxXibMMyjut96MwRaruCXd5JTvAzUF9QK
	jXi12tOqcJ5LQjBnFUtzMvIIlsUvxq6flWDGk4JlotXuso6OcoPaSjhE=
X-Google-Smtp-Source: AGHT+IGhaa35gFQtE7Vu6kAqFod34bDr20BPHRMrc2dgJZosDloT+LS7bv0hMwlqO3aSKOat4cDUUzLJfcHG+Xzj1r6MMSb7kWtL
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:5a9:b0:3a0:8c68:7705 with SMTP id
 e9e14a558f8ab-3a08c6877c6mr146178425ab.21.1726671804203; Wed, 18 Sep 2024
 08:03:24 -0700 (PDT)
Date: Wed, 18 Sep 2024 08:03:24 -0700
In-Reply-To: <66e55308.050a0220.1f4381.0004.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66eaebbc.050a0220.252d9a.0015.GAE@google.com>
Subject: Re: [syzbot] [btrfs?] BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low! (7)
From: syzbot <syzbot+74f79df25c37437e4d5a@syzkaller.appspotmail.com>
To: chao@kernel.org, clm@fb.com, dsterba@suse.com, jaegeuk@kernel.org, 
	josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    5f5673607153 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=137fc69f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dedbcb1ff4387972
dashboard link: https://syzkaller.appspot.com/bug?extid=74f79df25c37437e4d5a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12b8f500580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10dbc4a9980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/40172aed5414/disk-5f567360.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/58372f305e9d/vmlinux-5f567360.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d2aae6fa798f/Image-5f567360.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/e4b8f51425ac/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+74f79df25c37437e4d5a@syzkaller.appspotmail.com

BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
turning off the locking correctness validator.
CPU: 0 UID: 0 PID: 137 Comm: kworker/u8:4 Not tainted 6.11.0-rc7-syzkaller-g5f5673607153 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: btrfs-endio-write btrfs_work_helper
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:319
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:326
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:119
 dump_stack+0x1c/0x28 lib/dump_stack.c:128
 lookup_chain_cache_add kernel/locking/lockdep.c:3815 [inline]
 validate_chain kernel/locking/lockdep.c:3836 [inline]
 __lock_acquire+0x1fa0/0x779c kernel/locking/lockdep.c:5142
 lock_acquire+0x240/0x728 kernel/locking/lockdep.c:5759
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x48/0x60 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 btrfs_block_rsv_size fs/btrfs/block-rsv.h:136 [inline]
 btrfs_use_block_rsv+0x184/0x73c fs/btrfs/block-rsv.c:495
 btrfs_alloc_tree_block+0x16c/0x12d4 fs/btrfs/extent-tree.c:5130
 btrfs_force_cow_block+0x4e4/0x1c9c fs/btrfs/ctree.c:573
 btrfs_cow_block+0x318/0xa28 fs/btrfs/ctree.c:754
 btrfs_search_slot+0xba0/0x2a08
 btrfs_lookup_file_extent+0x124/0x1bc fs/btrfs/file-item.c:267
 btrfs_drop_extents+0x370/0x2ad8 fs/btrfs/file.c:251
 insert_reserved_file_extent+0x2b4/0xa6c fs/btrfs/inode.c:2911
 insert_ordered_extent_file_extent+0x348/0x508 fs/btrfs/inode.c:3016
 btrfs_finish_one_ordered+0x6a0/0x129c fs/btrfs/inode.c:3124
 btrfs_finish_ordered_io+0x120/0x134 fs/btrfs/inode.c:3266
 finish_ordered_fn+0x20/0x30 fs/btrfs/ordered-data.c:331
 btrfs_work_helper+0x340/0xd28 fs/btrfs/async-thread.c:314
 process_one_work+0x79c/0x15b8 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x978/0xec4 kernel/workqueue.c:3389
 kthread+0x288/0x310 kernel/kthread.c:389
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

