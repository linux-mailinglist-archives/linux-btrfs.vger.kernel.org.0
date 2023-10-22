Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28BE57D20C6
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Oct 2023 04:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjJVCk5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 21 Oct 2023 22:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJVCk4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 21 Oct 2023 22:40:56 -0400
Received: from mail-oa1-f80.google.com (mail-oa1-f80.google.com [209.85.160.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FCEDF
        for <linux-btrfs@vger.kernel.org>; Sat, 21 Oct 2023 19:40:54 -0700 (PDT)
Received: by mail-oa1-f80.google.com with SMTP id 586e51a60fabf-1e9a324c12fso3533985fac.2
        for <linux-btrfs@vger.kernel.org>; Sat, 21 Oct 2023 19:40:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697942454; x=1698547254;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uU8lb1l1yKfhs7iHHIqOMOJAFdCISWoOXZEw6aTB7b4=;
        b=U7+C/7oWRRB7tx8oztXGIgtO18jcZ2XEXP1mgpu4qN8X0+zTQ3MLu4ZnMOIHdgtaKp
         SUt2RW3lYHXQgPcn+ORntLWJlBQRG1aY6sNbrMUuLNbmQ8PwO4A0XP1Zk4D4JHu+niAg
         ECoQQdWc+pMYpTyc10B+KqTuG5e22Esxy4EhEIImD7FtauBm6GT+livL6Shyf5ddxyCI
         jrRsVjPMjNBaHjQlrMWTooA6XAualagCxKmgA5EfObEvLmJT18SyQlXEmza6eMHazEj+
         OS/DA/NalmFSo9VmKQ3mMfx7AvP0YVOr345ZyYtSUaRy5wbCZv633Q4nekQ4o9wPH5z6
         dMJQ==
X-Gm-Message-State: AOJu0YxbPLTpkHNY9y/bPgjMhe0JX+1AWXJBOUGueiVA94yojzz1jve6
        FphSszUVfIAzcYozp/RXtOIHJJQAj8OxxRt+MOJrwFxdXt4y
X-Google-Smtp-Source: AGHT+IFHZ6P7o+3eMU28/NkHHkQTYEEHjSvBSzx432SAOF7tvLU7F4B1w1hLQmsTWuE5/cSvMxyb5JkINrs9wcT8EwARUgU91GPM
MIME-Version: 1.0
X-Received: by 2002:a05:6870:5692:b0:1ea:1bc4:d06b with SMTP id
 p18-20020a056870569200b001ea1bc4d06bmr2659490oao.10.1697942453878; Sat, 21
 Oct 2023 19:40:53 -0700 (PDT)
Date:   Sat, 21 Oct 2023 19:40:53 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d005440608450810@google.com>
Subject: [syzbot] [btrfs?] BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low! (4)
From:   syzbot <syzbot+b2869947e0c9467a41b6@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,PLING_QUERY,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    78124b0c1d10 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1557da89680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f27cd6e68911e026
dashboard link: https://syzkaller.appspot.com/bug?extid=b2869947e0c9467a41b6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=137ac45d680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16e4640b680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bd512de820ae/disk-78124b0c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a47a437b1d4f/vmlinux-78124b0c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3ae8b966bcd7/Image-78124b0c.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/d5d514495f15/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b2869947e0c9467a41b6@syzkaller.appspotmail.com

BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
turning off the locking correctness validator.
CPU: 0 PID: 5571 Comm: kworker/u4:8 Not tainted 6.6.0-rc6-syzkaller-g78124b0c1d10 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Workqueue: btrfs-cache btrfs_work_helper
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:233
 show_stack+0x2c/0x44 arch/arm64/kernel/stacktrace.c:240
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
 dump_stack+0x1c/0x28 lib/dump_stack.c:113
 lookup_chain_cache_add kernel/locking/lockdep.c:3815 [inline]
 validate_chain kernel/locking/lockdep.c:3836 [inline]
 __lock_acquire+0x1c60/0x75e8 kernel/locking/lockdep.c:5136
 lock_acquire+0x23c/0x71c kernel/locking/lockdep.c:5753
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x48/0x60 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 __clear_extent_bit+0x1b4/0xaf0 fs/btrfs/extent-io-tree.c:596
 clear_extent_bit fs/btrfs/extent-io-tree.h:146 [inline]
 clear_extent_bits fs/btrfs/extent-io-tree.h:158 [inline]
 btrfs_free_excluded_extents fs/btrfs/block-group.c:840 [inline]
 caching_thread+0x18bc/0x1b64 fs/btrfs/block-group.c:909
 btrfs_work_helper+0x340/0x1504 fs/btrfs/async-thread.c:314
 process_one_work+0x694/0x1204 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x938/0xef4 kernel/workqueue.c:2784
 kthread+0x288/0x310 kernel/kthread.c:388
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:857
BTRFS info (device loop0): qgroup scan completed (inconsistency flag cleared)
BTRFS info (device loop0): qgroup scan completed (inconsistency flag cleared)
BTRFS info (device loop0): qgroup scan completed (inconsistency flag cleared)


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
