Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 310672C72DD
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Nov 2020 23:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389781AbgK1VuG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 28 Nov 2020 16:50:06 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:45464 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387669AbgK1USB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 28 Nov 2020 15:18:01 -0500
Received: by mail-io1-f69.google.com with SMTP id x7so280812ion.12
        for <linux-btrfs@vger.kernel.org>; Sat, 28 Nov 2020 12:17:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Ehas9/uWgezbAqUFc//OPdBHdsrnNi7OIOegc/dRGek=;
        b=hwuwtysKb2UltjAkoHen3vN9rSVuKOqG/FtULXT5YZUtDJDTwq7o0v27wgiwZyP+39
         kk55aJaIyzcHxomOIIz1xFYTu7A+L1Lna63WUJALe23xoiE2SNvlwBaoUFPHzhoEntW5
         9RgxpqPvvjm1mJ1vMJwaABwOZN60nNcudGMOFReC2gLAJU2hurq5GpBX2gzKx9OLwmCk
         GfwqpgxG+bEzlLzYErUfRuYw2xKrPtdjSHy+28sXDFT8RcGffBI/1iv+/hSu2suFq9sG
         EM9HYRyiudny2dA+xIHbeJ0CbuTo+Hw/Nn2XTMR/z0fzUuGyt86pUSPGEKc9cTOQx7fr
         FSRg==
X-Gm-Message-State: AOAM530vtOs/aDqUODyJALzNBC88XQNTZtZi9mVwgLiT9AAo8yo5Ef3A
        pz1+MyNbF4yW0nw8EWUUASaxwdhxxUAiHbfCbaSuxeeaMbBM
X-Google-Smtp-Source: ABdhPJyD0/wX+ANrFMtDd3Yf5pSf6uf/lZR6CePpgor4Mu1tR5OUziyQ0h8k8j2aRLEF2VvAVAxg1Y2WLY/Q3/CIEW0lfSezo6x4
MIME-Version: 1.0
X-Received: by 2002:a92:50b:: with SMTP id q11mr12684622ile.49.1606594634583;
 Sat, 28 Nov 2020 12:17:14 -0800 (PST)
Date:   Sat, 28 Nov 2020 12:17:14 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007e15b505b530766d@google.com>
Subject: WARNING in close_fs_devices (3)
From:   syzbot <syzbot+a70e2ad0879f160b9217@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d5beb314 Merge tag 'hyperv-fixes-signed' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1232777d500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7994ac0f2a9b95d9
dashboard link: https://syzkaller.appspot.com/bug?extid=a70e2ad0879f160b9217
compiler:       clang version 11.0.0 (https://github.com/llvm/llvm-project.git ca2dcbd030eadbf0aa9b660efe864ff08af6e18b)

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a70e2ad0879f160b9217@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 8484 at fs/btrfs/volumes.c:1160 close_fs_devices+0x71d/0x7b0 fs/btrfs/volumes.c:1160
Modules linked in:
CPU: 0 PID: 8484 Comm: syz-executor.3 Not tainted 5.10.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:close_fs_devices+0x71d/0x7b0 fs/btrfs/volumes.c:1160
Code: c4 38 5b 41 5c 41 5d 41 5e 41 5f 5d c3 e8 bb 5b 3f fe 0f 0b e9 6f f9 ff ff e8 af 5b 3f fe 0f 0b e9 3c ff ff ff e8 a3 5b 3f fe <0f> 0b e9 69 ff ff ff 48 c7 c1 24 64 0e 8d 80 e1 07 80 c1 03 38 c1
RSP: 0018:ffffc900016dfc80 EFLAGS: 00010293
RAX: ffffffff8335c3bd RBX: 0000000000000001 RCX: ffff888015323480
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffff888024b82108 R08: ffffffff8335c31f R09: ffffed10038cdd27
R10: ffffed10038cdd27 R11: 0000000000000000 R12: dffffc0000000000
R13: ffff88801c66e860 R14: 1ffff110038cdd0c R15: 1ffff110038cdd0a
FS:  0000000003329940(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055ad0a12280f CR3: 000000006814e000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 btrfs_close_devices+0x8c/0x400 fs/btrfs/volumes.c:1172
 close_ctree+0x5bf/0x6ae fs/btrfs/disk-io.c:4152
 generic_shutdown_super+0x120/0x2a0 fs/super.c:464
 kill_anon_super+0x36/0x60 fs/super.c:1108
 btrfs_kill_super+0x3d/0x50 fs/btrfs/super.c:2263
 deactivate_locked_super+0xa7/0xf0 fs/super.c:335
 cleanup_mnt+0x462/0x510 fs/namespace.c:1118
 task_work_run+0x137/0x1c0 kernel/task_work.c:151
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:164 [inline]
 exit_to_user_mode_prepare+0xe4/0x170 kernel/entry/common.c:191
 syscall_exit_to_user_mode+0x4a/0x170 kernel/entry/common.c:266
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x4608e7
Code: 64 89 04 25 d0 02 00 00 58 5f ff d0 48 89 c7 e8 2f be ff ff 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 ad 89 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffe70ea1cb8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000004608e7
RDX: 00000000004031f8 RSI: 0000000000000002 RDI: 00007ffe70ea1d60
RBP: 0000000000000538 R08: 0000000000000000 R09: 000000000000000b
R10: 0000000000000005 R11: 0000000000000246 R12: 00007ffe70ea2df0
R13: 000000000332aa60 R14: 0000000000000000 R15: 00007ffe70ea2df0


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
