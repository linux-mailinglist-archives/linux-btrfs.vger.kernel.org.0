Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D3C271871
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 00:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgITWmV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 20 Sep 2020 18:42:21 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:37671 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgITWmV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 20 Sep 2020 18:42:21 -0400
Received: by mail-il1-f197.google.com with SMTP id c66so9657044ilf.4
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Sep 2020 15:42:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=H8iW92ujtgUgPXmkcxERXfVbVqmUrXppy9oOwBajsLw=;
        b=QB0s3w1cxBCh9OjavWA8e2dP6QG2rfsTie3cpHLn1EwnKvqttOWs6XvqG2BGZw+Bkl
         1zt04FohQq7kM/x2QoOs1PkSi6sOEjXSzO1hD4FV5UqoR11IwAxhqImV5FmBogDFa7ul
         JzkOqKgl2PIp/NtS2RAiI3LiwkweOLgsUlrYpVo3XG2cxVdfsvl0jpqpFnVxPSdAzM4o
         /pnhyQUdct4r/kZVBdF2rzUvJlG84H3Ul7WFsPK61CHxeL7OGduJ6iBA4RM4Ec5h8sjB
         qwA50pBGYTxy7V1PhSIIWf/Bbcf1vsYqpdVSZ5up3UV0K+ZI2xtI1EzElFNFxL0VEBqo
         bbOA==
X-Gm-Message-State: AOAM532/G5kEgOIqnL60t4x0bk3PQPCdbJJoakMlabZS0K+xM5ul7I+7
        txLjd9JGonf90rKQd8psNIRcXHa4AAfwfyN+hn7pjlWFibrA
X-Google-Smtp-Source: ABdhPJyTiGqe99EzTSz6Fh4ToweZBJHR9QyO//vhW/noPTAvKr2fh+qZqWVwHC8pkV+wEXy1kNP/MBul8QVKvAZCNpu4k27SJR3G
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:f87:: with SMTP id v7mr4578614ilo.212.1600641740472;
 Sun, 20 Sep 2020 15:42:20 -0700 (PDT)
Date:   Sun, 20 Sep 2020 15:42:20 -0700
In-Reply-To: <0000000000008fbadb05af94b61e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005a890b05afc67285@google.com>
Subject: Re: WARNING in close_fs_devices (2)
From:   syzbot <syzbot+4cfe71a4da060be47502@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, dsterba@suse.cz,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    b652d2a5 Add linux-next specific files for 20200918
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17e84b07900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3cf0782933432b43
dashboard link: https://syzkaller.appspot.com/bug?extid=4cfe71a4da060be47502
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=112425d9900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1486929b900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4cfe71a4da060be47502@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 6972 at fs/btrfs/volumes.c:1172 close_fs_devices+0x715/0x930 fs/btrfs/volumes.c:1172
Modules linked in:
CPU: 1 PID: 6972 Comm: syz-executor044 Not tainted 5.9.0-rc5-next-20200918-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:close_fs_devices+0x715/0x930 fs/btrfs/volumes.c:1172
Code: e8 00 b8 4c fe 85 db 0f 85 65 f9 ff ff e8 93 bb 4c fe 0f 0b e9 59 f9 ff ff e8 87 bb 4c fe 0f 0b e9 c0 fe ff ff e8 7b bb 4c fe <0f> 0b e9 f9 fe ff ff 48 c7 c7 fc a1 8f 8b e8 e8 0b 8e fe e9 19 f9
RSP: 0018:ffffc900061b7758 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffffffffffffff RCX: ffffffff83285c2c
RDX: ffff8880a6bbe4c0 RSI: ffffffff83285d35 RDI: 0000000000000007
RBP: dffffc0000000000 R08: 0000000000000000 R09: ffff8880a2be1133
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880a2be1130
R13: ffff8880a2be11ec R14: ffff888093ab0508 R15: ffff8880a2be1050
FS:  000000000208a880(0000) GS:ffff8880ae500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004babec CR3: 00000000a7bc7000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 btrfs_close_devices+0x8e/0x4b0 fs/btrfs/volumes.c:1184
 open_ctree+0x492a/0x49cf fs/btrfs/disk-io.c:3381
 btrfs_fill_super fs/btrfs/super.c:1316 [inline]
 btrfs_mount_root.cold+0x14/0x165 fs/btrfs/super.c:1672
 legacy_get_tree+0x105/0x220 fs/fs_context.c:592
 vfs_get_tree+0x89/0x2f0 fs/super.c:1547
 fc_mount fs/namespace.c:983 [inline]
 vfs_kern_mount.part.0+0xd3/0x170 fs/namespace.c:1013
 vfs_kern_mount+0x3c/0x60 fs/namespace.c:1000
 btrfs_mount+0x234/0xaa0 fs/btrfs/super.c:1732
 legacy_get_tree+0x105/0x220 fs/fs_context.c:592
 vfs_get_tree+0x89/0x2f0 fs/super.c:1547
 do_new_mount fs/namespace.c:2896 [inline]
 path_mount+0x12ae/0x1e70 fs/namespace.c:3216
 do_mount fs/namespace.c:3229 [inline]
 __do_sys_mount fs/namespace.c:3437 [inline]
 __se_sys_mount fs/namespace.c:3414 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3414
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x44851a
Code: b8 08 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 cd a2 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 aa a2 fb ff c3 66 0f 1f 84 00 00 00 00 00
RSP: 002b:00007ffcb26bce08 EFLAGS: 00000293 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 000000000044851a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffcb26bce50
RBP: 00007ffcb26bce90 R08: 00007ffcb26bce90 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
R13: 00007ffcb26bce50 R14: 0000000000000003 R15: 0000000000000001

