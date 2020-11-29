Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 328F52C797D
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Nov 2020 15:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgK2OAI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Nov 2020 09:00:08 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:38714 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgK2OAI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Nov 2020 09:00:08 -0500
Received: by mail-il1-f200.google.com with SMTP id e10so7965174ils.5
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Nov 2020 05:59:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=qFs6FYo+H+YFhPsOuxUBwMYzZnWNGRVAlggDZwH5X6k=;
        b=pkRDKpAv51u6NroZnwQU+4eoV8ezdjToSRB55mkGh4loitrwEjHOPCOJFNhIvuz3xl
         6IqTfWAZfmDJaPAEJI47gknjF53ek6RgTCuBzdbtA4FjCEeFp+OlmbqiiyAZw+ZG7B0E
         CYHJq7uqqNimNfs81ZeouZplBXkXPT1f/S+HBMQkIM2L798psZNhyCBgMffj4PExHOrH
         3uyVD8snC46YJlzRq+efDnG5lGJN1u+JnAvZIM8hnZXD+nwg+EJTsH0MxdtPc3WkiT3I
         WnbdZELsaxYhmVYZa9zFDLUXQ6nHCiiBdQEDELk1VZrIV/DqTJ65sSECZ5Au6kf9zFgE
         QZcA==
X-Gm-Message-State: AOAM530sQVfseVyVz6uNKQtyPeSga8VazLCmMaE5FkgrVBDn+H4fU5Dc
        8wCd8cuYwixPPLetwNQSObuucpl7k1UUjWTlGXYSow8vSIdb
X-Google-Smtp-Source: ABdhPJxX9S3rerREKHuIGWNy0kzTElBztJ2MQWQYExfQy4fri5gfYrhHO6Ke6zoGvXOoVsvjHNK1FGA7/Zv4HNdnHXgsHBWWMxm+
MIME-Version: 1.0
X-Received: by 2002:a92:3f14:: with SMTP id m20mr15012681ila.240.1606658359722;
 Sun, 29 Nov 2020 05:59:19 -0800 (PST)
Date:   Sun, 29 Nov 2020 05:59:19 -0800
In-Reply-To: <0000000000007e15b505b530766d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ce88b105b53f4c6d@google.com>
Subject: Re: WARNING in close_fs_devices (3)
From:   syzbot <syzbot+a70e2ad0879f160b9217@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    6174f052 Add linux-next specific files for 20201127
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=141c9553500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79c69cf2521bef9c
dashboard link: https://syzkaller.appspot.com/bug?extid=a70e2ad0879f160b9217
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11727795500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1793dcc9500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a70e2ad0879f160b9217@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 8537 at fs/btrfs/volumes.c:1174 close_fs_devices+0x71d/0x930 fs/btrfs/volumes.c:1174
Modules linked in:
CPU: 1 PID: 8537 Comm: syz-executor956 Not tainted 5.10.0-rc5-next-20201127-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:close_fs_devices+0x71d/0x930 fs/btrfs/volumes.c:1174
Code: e8 88 2f 42 fe 85 db 0f 85 5d f9 ff ff e8 9b 27 42 fe 0f 0b e9 51 f9 ff ff e8 8f 27 42 fe 0f 0b e9 c0 fe ff ff e8 83 27 42 fe <0f> 0b e9 f9 fe ff ff 48 c7 c7 1c 80 ee 8c e8 40 fb 84 fe e9 11 f9
RSP: 0018:ffffc9000183f750 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff88801e07b580 RSI: ffffffff832e99dd RDI: 0000000000000003
RBP: dffffc0000000000 R08: 0000000000000000 R09: ffff88801a17b93b
R10: ffffffff832e98d4 R11: 0000000000000000 R12: ffff88801a17b938
R13: ffff88801a17b9f4 R14: ffff888013e1c908 R15: ffff88801a17b850
FS:  00000000025a7880(0000) GS:ffff8880b9f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f674003e048 CR3: 0000000012337000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 btrfs_close_devices+0x8e/0x4b0 fs/btrfs/volumes.c:1186
 open_ctree+0x3f90/0x4035 fs/btrfs/disk-io.c:3484
 btrfs_fill_super fs/btrfs/super.c:1362 [inline]
 btrfs_mount_root.cold+0x14/0x165 fs/btrfs/super.c:1731
 legacy_get_tree+0x105/0x220 fs/fs_context.c:592
 vfs_get_tree+0x89/0x2f0 fs/super.c:1549
 fc_mount fs/namespace.c:983 [inline]
 vfs_kern_mount.part.0+0xd3/0x170 fs/namespace.c:1013
 vfs_kern_mount+0x3c/0x60 fs/namespace.c:1000
 btrfs_mount+0x234/0xa20 fs/btrfs/super.c:1791
 legacy_get_tree+0x105/0x220 fs/fs_context.c:592
 vfs_get_tree+0x89/0x2f0 fs/super.c:1549
 do_new_mount fs/namespace.c:2896 [inline]
 path_mount+0x12ae/0x1e70 fs/namespace.c:3227
 do_mount fs/namespace.c:3240 [inline]
 __do_sys_mount fs/namespace.c:3448 [inline]
 __se_sys_mount fs/namespace.c:3425 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3425
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x4492fa
Code: b8 08 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 cd a2 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 aa a2 fb ff c3 66 0f 1f 84 00 00 00 00 00
RSP: 002b:00007ffe66329388 EFLAGS: 00000293 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00000000004492fa
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffe663293d0
RBP: 00007ffe66329410 R08: 00007ffe66329410 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
R13: 00007ffe663293d0 R14: 0000000000000003 R15: 0000000000000005

