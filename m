Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538C526FB53
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Sep 2020 13:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgIRLWT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Sep 2020 07:22:19 -0400
Received: from mail-io1-f79.google.com ([209.85.166.79]:44218 "EHLO
        mail-io1-f79.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgIRLWR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Sep 2020 07:22:17 -0400
Received: by mail-io1-f79.google.com with SMTP id l8so4223008ioa.11
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Sep 2020 04:22:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=6fqJQsz1Jbwu67p9ASKT5y3MgGNvM30+uUXyMzpjo4I=;
        b=mD2NQW85TYa7oO/fdZAryzRq3PlhW1D4eF0Ru7xeQp2vms7jSEqzkj482M8AV7NDhu
         PP+7TwOS1kVSAd1SvEIfmID9o7UATv90iKptqUgwxLk5uVXmw2DwwI+za2OjqQWe66SR
         6UlDWf5s+4Yt1Vg6l1QAo8rd3ZiRbDKwN849dakWqCNa5DHXcH7LClkn6FbBTJ8kPcnI
         fLgyAWONgobhbGvi2KE/mZH/LL4jgEk2D+e3a4lSZaouMjiuQfR6Cp5tq2Gynn0yhJd1
         OKMW5EQ6hLKELxJgaYYvue3LrFsvT3H/Hb59CHjzGus2zmbWagn/Vvr6w35SH9bKEDBI
         fPVg==
X-Gm-Message-State: AOAM532vmPBEmqZ5vvMeugyqGlqrWTgyPSOtRurmC6LphLttz1HTyVaI
        ocdIQMug535TImxDtle5bxBQE7aDw/h6/aUXfcQ2t60W2OYR
X-Google-Smtp-Source: ABdhPJwEyLOu4LAZIPoxN9PvfctfWBTUn0UY7J3yUggMPcb5Qg0j6zCCey4r5eR5NXVop1CAF+L+Bn9YoSlnExIOVxrLBw3Juydt
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:bea:: with SMTP id d10mr28275794ilu.143.1600428136444;
 Fri, 18 Sep 2020 04:22:16 -0700 (PDT)
Date:   Fri, 18 Sep 2020 04:22:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008fbadb05af94b61e@google.com>
Subject: WARNING in close_fs_devices (2)
From:   syzbot <syzbot+4cfe71a4da060be47502@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e4c26faa Merge tag 'usb-5.9-rc5' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15bf1621900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c61610091f4ca8c4
dashboard link: https://syzkaller.appspot.com/bug?extid=4cfe71a4da060be47502
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4cfe71a4da060be47502@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 3612 at fs/btrfs/volumes.c:1166 close_fs_devices.part.0+0x607/0x800 fs/btrfs/volumes.c:1166
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 3612 Comm: syz-executor.2 Not tainted 5.9.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fd lib/dump_stack.c:118
 panic+0x347/0x7c0 kernel/panic.c:231
 __warn.cold+0x20/0x46 kernel/panic.c:600
 report_bug+0x1bd/0x210 lib/bug.c:198
 handle_bug+0x38/0x90 arch/x86/kernel/traps.c:234
 exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:254
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:536
RIP: 0010:close_fs_devices.part.0+0x607/0x800 fs/btrfs/volumes.c:1166
Code: 0f b6 04 02 84 c0 74 02 7e 33 48 8b 44 24 18 c6 80 30 01 00 00 00 48 83 c4 30 5b 5d 41 5c 41 5d 41 5e 41 5f c3 e8 99 ce 6a fe <0f> 0b e9 71 ff ff ff e8 8d ce 6a fe 0f 0b e9 20 ff ff ff e8 d1 d5
RSP: 0018:ffffc900091777e0 EFLAGS: 00010246
RAX: 0000000000040000 RBX: ffffffffffffffff RCX: ffffc9000c8b7000
RDX: 0000000000040000 RSI: ffffffff83097f47 RDI: 0000000000000007
RBP: dffffc0000000000 R08: 0000000000000001 R09: ffff8880988a187f
R10: 0000000000000000 R11: 0000000000000001 R12: ffff88809593a130
R13: ffff88809593a1ec R14: ffff8880988a1908 R15: ffff88809593a050
 close_fs_devices fs/btrfs/volumes.c:1193 [inline]
 btrfs_close_devices+0x95/0x1f0 fs/btrfs/volumes.c:1179
 open_ctree+0x4984/0x4a2d fs/btrfs/disk-io.c:3434
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
 path_mount+0x1387/0x2070 fs/namespace.c:3192
 do_mount fs/namespace.c:3205 [inline]
 __do_sys_mount fs/namespace.c:3413 [inline]
 __se_sys_mount fs/namespace.c:3390 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3390
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x46004a
Code: b8 a6 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 fd 89 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 da 89 fb ff c3 66 0f 1f 84 00 00 00 00 00
RSP: 002b:00007f414d78da88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f414d78db20 RCX: 000000000046004a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f414d78dae0
RBP: 00007f414d78dae0 R08: 00007f414d78db20 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000020000000
R13: 0000000020000100 R14: 0000000020000200 R15: 000000002001a800
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
