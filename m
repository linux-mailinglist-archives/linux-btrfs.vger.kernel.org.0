Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22E642733BA
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 22:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgIUUoK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 16:44:10 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:35137 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgIUUoK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 16:44:10 -0400
Received: by mail-io1-f70.google.com with SMTP id e83so10982807ioa.2
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Sep 2020 13:44:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=VxFaPc9OXa6+VO9gz0wrGX7j9K0q34rLiWQ3Al4BndM=;
        b=Q/ixJO6rkxaXZBuVKtkN7RShwWsWkj3i2bccVl4JwtLIeO28zM4QS29jag9/axusDl
         8onRs/6Yb94spbrpsPeQf0lp83uYS70NgjkRL65CNUda6LD3bw6dzQk4TxuXGa7oc/JE
         x1nt2dU+/1oqmqXyg89NI47C8yMndRnm6ZO68R9cpZ6L8gk6Im+tM89yEur49Nv66Qp+
         wDCJokomXjb6WR16qjsE+MClzFn+pt/O5+RV8/gprSV9tyW2xgruwjQlDkpCtRm5Q52k
         ek6gCFkHaZy0g+Auga689LXTq3ZvLaOsGJOiP5Z2SsbXsHLtgQF6jvdax3/qSyDdxgSi
         xa7w==
X-Gm-Message-State: AOAM532bBd76fVjytkEV/2CdH45Snwt2oztK4ojns9s9v+Y5gEW3fvBT
        Lpp7lctwREWV3i5wb3Xcn39PRmQxbEdgffXZ5WSmTEMxk01G
X-Google-Smtp-Source: ABdhPJwXqRYs+DMwN4FVCVTTmtGcukyhBdqC3KHlmzGlRmDnsGdmV56aRGj6GuIpXDBmKFH2kpd1L/cw1NzdVsOtEwEXbu43CQUr
MIME-Version: 1.0
X-Received: by 2002:a92:dc03:: with SMTP id t3mr1459240iln.245.1600721049449;
 Mon, 21 Sep 2020 13:44:09 -0700 (PDT)
Date:   Mon, 21 Sep 2020 13:44:09 -0700
In-Reply-To: <20200921170120.GK6756@twin.jikos.cz>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008979ac05afd8e916@google.com>
Subject: Re: WARNING in close_fs_devices (2)
From:   syzbot <syzbot+4cfe71a4da060be47502@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, dsterba@suse.cz,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in close_fs_devices

BTRFS info (device loop5): enabling ssd optimizations
BTRFS warning (device loop5): failed to read fs tree: -5
------------[ cut here ]------------
WARNING: CPU: 0 PID: 8915 at fs/btrfs/volumes.c:1166 close_fs_devices.part.0+0x607/0x800 fs/btrfs/volumes.c:1166
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 8915 Comm: syz-executor.4 Not tainted 5.8.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 panic+0x31e/0x797 kernel/panic.c:231
 __warn.cold+0x20/0x4a kernel/panic.c:600
 report_bug+0x1bd/0x210 lib/bug.c:198
 handle_bug+0x38/0x90 arch/x86/kernel/traps.c:235
 exc_invalid_op+0x13/0x40 arch/x86/kernel/traps.c:255
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:540
RIP: 0010:close_fs_devices.part.0+0x607/0x800 fs/btrfs/volumes.c:1166
Code: 0f b6 04 02 84 c0 74 02 7e 33 48 8b 44 24 18 c6 80 30 01 00 00 00 48 83 c4 30 5b 5d 41 5c 41 5d 41 5e 41 5f c3 e8 e9 19 4d fe <0f> 0b e9 71 ff ff ff e8 dd 19 4d fe 0f 0b e9 20 ff ff ff e8 e1 33
RSP: 0018:ffffc90006777818 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffffffffffffff RCX: ffffffff83288276
RDX: ffff8880921402c0 RSI: ffffffff83288307 RDI: 0000000000000007
RBP: dffffc0000000000 R08: 0000000000000001 R09: ffff8880a7206c7f
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888095742130
R13: ffff8880957421ec R14: ffff8880a7206d08 R15: ffff888095742050
 close_fs_devices fs/btrfs/volumes.c:1193 [inline]
 btrfs_close_devices+0x95/0x1f0 fs/btrfs/volumes.c:1179
 open_ctree+0x49e6/0x4a96 fs/btrfs/disk-io.c:3456
 btrfs_fill_super fs/btrfs/super.c:1316 [inline]
 btrfs_mount_root.cold+0x14/0x165 fs/btrfs/super.c:1672
 legacy_get_tree+0x105/0x220 fs/fs_context.c:592
 vfs_get_tree+0x89/0x2f0 fs/super.c:1547
 fc_mount fs/namespace.c:978 [inline]
 vfs_kern_mount.part.0+0xd3/0x170 fs/namespace.c:1008
 vfs_kern_mount+0x3c/0x60 fs/namespace.c:995
 btrfs_mount+0x234/0xaa0 fs/btrfs/super.c:1732
 legacy_get_tree+0x105/0x220 fs/fs_context.c:592
 vfs_get_tree+0x89/0x2f0 fs/super.c:1547
 do_new_mount fs/namespace.c:2875 [inline]
 do_mount+0x159c/0x2000 fs/namespace.c:3200
 __do_sys_mount fs/namespace.c:3410 [inline]
 __se_sys_mount fs/namespace.c:3387 [inline]
 __x64_sys_mount+0x18f/0x230 fs/namespace.c:3387
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x46004a
Code: b8 a6 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 fd 89 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 da 89 fb ff c3 66 0f 1f 84 00 00 00 00 00
RSP: 002b:00007f5e059b1a88 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f5e059b1b20 RCX: 000000000046004a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f5e059b1ae0
RBP: 00007f5e059b1ae0 R08: 00007f5e059b1b20 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000020000000
R13: 0000000020000100 R14: 0000000020000200 R15: 0000000020000140
Kernel Offset: disabled
Rebooting in 86400 seconds..


Tested on:

commit:         d1db82c9 btrfs: move btrfs_rm_dev_replace_free_srcdev outs..
git tree:       git://github.com/kdave/btrfs-devel.git misc-5.9
console output: https://syzkaller.appspot.com/x/log.txt?x=1007c6c3900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=72e4ae28d563b993
dashboard link: https://syzkaller.appspot.com/bug?extid=4cfe71a4da060be47502
compiler:       gcc (GCC) 10.1.0-syz 20200507

