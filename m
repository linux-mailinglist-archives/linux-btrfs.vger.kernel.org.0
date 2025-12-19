Return-Path: <linux-btrfs+bounces-19894-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9645DCCF82C
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Dec 2025 12:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6D197300B929
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Dec 2025 11:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B682301002;
	Fri, 19 Dec 2025 11:02:29 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f80.google.com (mail-ot1-f80.google.com [209.85.210.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517EE288522
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Dec 2025 11:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766142149; cv=none; b=pt5QeLvUrOi+BL6OP4EzB/otZm4uICUya3asJA8kUJVRye9zcp2l71kR6joZ1zNek7xIlLmKpFjTt5zM6TmMPt28aaW1Ruxar8/9ERX8ZiedE4YAqEbxYIEpbbCe7FYJWh2m/7znVUR9qOy30T541UGmopG2Gjrxu5+nX0nQzvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766142149; c=relaxed/simple;
	bh=g/0hhMKP7mhzG1XKU9yj/UyILdGycHX+OsckLPok3/I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=f8z17Sc4wlJYwlpaDwO0SvXxbdz4Pgw2P3XWsf8UggUw/98/wZbTO6R6quYZm91Gv6TpLZ9FoEVnTUjlzVaPn1RpvPft6t85azN9ecZ1XyKsQC4+Ctz72f77bh6IpQfuawa7kDm/LO8CrP/e4bxP0Mr8CeSozyIk8ZGlmfFCu6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f80.google.com with SMTP id 46e09a7af769-7c76977192eso3415639a34.3
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Dec 2025 03:02:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766142146; x=1766746946;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+vbVp1bnGj2g0/dG+U28GSanOTxCftGmGn4den809Ow=;
        b=n6prvHENfHp/9QkNMbC1fWGdCVzf1zeews8CEYorPpvrWEj3mjNxaeFpv6t9J/LOMH
         o5jhdo0rWuUb/g7fWWAEJzVO8xt4F2UggnN5lig5gpbt103GWLYX711bMi0h/YaEk7Ci
         yBMo7Ha3r0RLDh2mL2SZjATmpnVjhinHfKPf/CLbbavpC3myHu44SrHDuF0LgSdWI2RW
         NgLjXqi5o0Vjv79Q7TTYT5iQzuMeNnoZv73Yv/4MSwUnJS+2c2jHyc5FkCKkPLEwI22D
         gjcdidjQ23l84QmDPgJU9STI1Tk8DnbrADae1eswKdnABhdg2nI75OXDZgc+Ae/NPvJ6
         LiKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWT43Bkjwxy9QU7x/mkcLMr11Tm/N0q9hBgCk7mmTlwNNUYQPbMFRurrqeewSyVnwAiIrVtcv9cW7fSLg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyY1hO0iJSJaD1htt81ZdogS20uQBbX8CoJOkOSrMOTrDjFiDbN
	G1pgJHb6hV4ql6q0nOtMSUZooT2QLIul4cGNVrQwL0CJytbhkKH0pnLtvck4JBF0H2EdV3XHP3k
	jG4Vcpuv72++h/qQ62/z9wLiSMck6JrAEZlDv2s/L4C1v9jbzrukOhWMewek=
X-Google-Smtp-Source: AGHT+IEe+VefVJI9ovy8GmB5tgs7hY18twq5R7NI0vStGISa7pmx0CSHKx4o0NX83ENW4TlkLY6dhsFdXA5nKzUAx0IcLk9djwdv
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:827:b0:659:9a49:8f12 with SMTP id
 006d021491bc7-65d0e9f40d5mr1142937eaf.35.1766142146309; Fri, 19 Dec 2025
 03:02:26 -0800 (PST)
Date: Fri, 19 Dec 2025 03:02:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <694530c2.a70a0220.207337.010d.GAE@google.com>
Subject: [syzbot] [btrfs?] possible deadlock in __btrfs_release_delayed_node (5)
From: syzbot <syzbot+c1c6edb02bea1da754d8@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    05c93f3395ed Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=12bacd92580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3b5338ad1e59a06c
dashboard link: https://syzkaller.appspot.com/bug?extid=c1c6edb02bea1da754d8
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6b5c913e373c/disk-05c93f33.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/15e75f1266ef/vmlinux-05c93f33.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dd930129c578/Image-05c93f33.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c1c6edb02bea1da754d8@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
btrfs-cleaner/8725 is trying to acquire lock:
ffff0000d6826a48 (&delayed_node->mutex){+.+.}-{4:4}, at: __btrfs_release_delayed_node+0xa0/0x9b0 fs/btrfs/delayed-inode.c:290

but task is already holding lock:
ffff0000dbeba878 (btrfs-tree-00){++++}-{4:4}, at: btrfs_tree_read_lock_nested+0x44/0x2ec fs/btrfs/locking.c:145

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (btrfs-tree-00){++++}-{4:4}:
       __lock_release kernel/locking/lockdep.c:5574 [inline]
       lock_release+0x198/0x39c kernel/locking/lockdep.c:5889
       up_read+0x24/0x3c kernel/locking/rwsem.c:1632
       btrfs_tree_read_unlock+0xdc/0x298 fs/btrfs/locking.c:169
       btrfs_tree_unlock_rw fs/btrfs/locking.h:218 [inline]
       btrfs_search_slot+0xa6c/0x223c fs/btrfs/ctree.c:2133
       btrfs_lookup_inode+0xd8/0x38c fs/btrfs/inode-item.c:395
       __btrfs_update_delayed_inode+0x124/0xed0 fs/btrfs/delayed-inode.c:1032
       btrfs_update_delayed_inode fs/btrfs/delayed-inode.c:1118 [inline]
       __btrfs_commit_inode_delayed_items+0x15f8/0x1748 fs/btrfs/delayed-inode.c:1141
       __btrfs_run_delayed_items+0x1ac/0x514 fs/btrfs/delayed-inode.c:1176
       btrfs_run_delayed_items_nr+0x28/0x38 fs/btrfs/delayed-inode.c:1219
       flush_space+0x26c/0xb68 fs/btrfs/space-info.c:828
       do_async_reclaim_metadata_space+0x110/0x364 fs/btrfs/space-info.c:1158
       btrfs_async_reclaim_metadata_space+0x90/0xd8 fs/btrfs/space-info.c:1226
       process_one_work+0x7e8/0x155c kernel/workqueue.c:3263
       process_scheduled_works kernel/workqueue.c:3346 [inline]
       worker_thread+0x958/0xed8 kernel/workqueue.c:3427
       kthread+0x5fc/0x75c kernel/kthread.c:463
       ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:844

-> #0 (&delayed_node->mutex){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x1774/0x30a4 kernel/locking/lockdep.c:5237
       lock_acquire+0x14c/0x2e0 kernel/locking/lockdep.c:5868
       __mutex_lock_common+0x1d0/0x2678 kernel/locking/mutex.c:598
       __mutex_lock kernel/locking/mutex.c:760 [inline]
       mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:812
       __btrfs_release_delayed_node+0xa0/0x9b0 fs/btrfs/delayed-inode.c:290
       btrfs_release_delayed_node fs/btrfs/delayed-inode.c:315 [inline]
       btrfs_remove_delayed_node+0x68/0x84 fs/btrfs/delayed-inode.c:1326
       btrfs_evict_inode+0x578/0xe28 fs/btrfs/inode.c:5587
       evict+0x414/0x928 fs/inode.c:810
       iput_final fs/inode.c:1914 [inline]
       iput+0x95c/0xad4 fs/inode.c:1966
       iget_failed+0xec/0x134 fs/bad_inode.c:248
       btrfs_read_locked_inode+0xe1c/0x1234 fs/btrfs/inode.c:4101
       btrfs_iget+0x1b0/0x264 fs/btrfs/inode.c:5837
       btrfs_run_defrag_inode fs/btrfs/defrag.c:237 [inline]
       btrfs_run_defrag_inodes+0x520/0xdc4 fs/btrfs/defrag.c:309
       cleaner_kthread+0x21c/0x418 fs/btrfs/disk-io.c:1516
       kthread+0x5fc/0x75c kernel/kthread.c:463
       ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:844

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(btrfs-tree-00);
                               lock(&delayed_node->mutex);
                               lock(btrfs-tree-00);
  lock(&delayed_node->mutex);

 *** DEADLOCK ***

1 lock held by btrfs-cleaner/8725:
 #0: ffff0000dbeba878 (btrfs-tree-00){++++}-{4:4}, at: btrfs_tree_read_lock_nested+0x44/0x2ec fs/btrfs/locking.c:145

stack backtrace:
CPU: 0 UID: 0 PID: 8725 Comm: btrfs-cleaner Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/03/2025
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:499 (C)
 __dump_stack+0x30/0x40 lib/dump_stack.c:94
 dump_stack_lvl+0xd8/0x12c lib/dump_stack.c:120
 dump_stack+0x1c/0x28 lib/dump_stack.c:129
 print_circular_bug+0x324/0x32c kernel/locking/lockdep.c:2043
 check_noncircular+0x154/0x174 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x1774/0x30a4 kernel/locking/lockdep.c:5237
 lock_acquire+0x14c/0x2e0 kernel/locking/lockdep.c:5868
 __mutex_lock_common+0x1d0/0x2678 kernel/locking/mutex.c:598
 __mutex_lock kernel/locking/mutex.c:760 [inline]
 mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:812
 __btrfs_release_delayed_node+0xa0/0x9b0 fs/btrfs/delayed-inode.c:290
 btrfs_release_delayed_node fs/btrfs/delayed-inode.c:315 [inline]
 btrfs_remove_delayed_node+0x68/0x84 fs/btrfs/delayed-inode.c:1326
 btrfs_evict_inode+0x578/0xe28 fs/btrfs/inode.c:5587
 evict+0x414/0x928 fs/inode.c:810
 iput_final fs/inode.c:1914 [inline]
 iput+0x95c/0xad4 fs/inode.c:1966
 iget_failed+0xec/0x134 fs/bad_inode.c:248
 btrfs_read_locked_inode+0xe1c/0x1234 fs/btrfs/inode.c:4101
 btrfs_iget+0x1b0/0x264 fs/btrfs/inode.c:5837
 btrfs_run_defrag_inode fs/btrfs/defrag.c:237 [inline]
 btrfs_run_defrag_inodes+0x520/0xdc4 fs/btrfs/defrag.c:309
 cleaner_kthread+0x21c/0x418 fs/btrfs/disk-io.c:1516
 kthread+0x5fc/0x75c kernel/kthread.c:463
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:844


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

