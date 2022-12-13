Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17C764B1E9
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 10:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbiLMJKF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 04:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234994AbiLMJJf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 04:09:35 -0500
Received: from mail-il1-x146.google.com (mail-il1-x146.google.com [IPv6:2607:f8b0:4864:20::146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87357164BB
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 01:05:48 -0800 (PST)
Received: by mail-il1-x146.google.com with SMTP id 7-20020a056e0220c700b0030386f0d0e6so7020451ilq.3
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 01:05:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nxB06A+MncPbzfaGZdCSPSEASJ+91KcgNtl0UAzGP/Q=;
        b=OwVSyCvGuMx1lXq6UaGgD+CawVQFHyGQz/8J6cN8Lp8lyKoMTzk8lO6V8JlNCkkm5C
         SnP+HmjO4bRUsAzrydt0icRM5eU1gexFAKhrVpqBu0OZxXHdGCQea0AQ6PcGCeCpeqaA
         HiLbLI/pbbiUGTp0YRhuYryB+5iReF2nrjhKj1cvC49NEvzlqfKrw0gCeCSKq5pX/st0
         JyNXmufH9iM5QjKinE49jchUQZ3tQqy/IUFAmYExzLVqp8zny5PgmVF6yV3DZZjVXcTP
         o2FkBZnVc+s1TCWTfsd3dymiCh0uJQ0f0MARXIUTiCaFGT8BqH8z1keErIEv/JGE7HGu
         otRg==
X-Gm-Message-State: ANoB5pmphsZn/dj0UCQymqW4WP/ZiR6Nkry0OXMOoUNfY35OF14aZ3qf
        MU4gXF00LdK9P3AWFT9yFDcQdP99PFKfxB7NbVWBdVmevhHS
X-Google-Smtp-Source: AA0mqf7q7Hjd6JnE+17QalTj8Tm5GjhKD/VaJ61jEfehLcdxnFN8w+FTS2NQyqKOq04EjiM0rya6DP9O28hnlB8h7+xYlRlrUHZp
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3b4:b0:38a:46d2:18a5 with SMTP id
 z20-20020a05663803b400b0038a46d218a5mr9812280jap.155.1670922279009; Tue, 13
 Dec 2022 01:04:39 -0800 (PST)
Date:   Tue, 13 Dec 2022 01:04:38 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e3439d05efb1e8ee@google.com>
Subject: [syzbot] WARNING in remove_from_free_space_tree
From:   syzbot <syzbot+bd64347b8238595d7db5@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ce19275f0103 Merge tag 'for-linus-2022120801' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17d6ccc7880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4edf421741552bc3
dashboard link: https://syzkaller.appspot.com/bug?extid=bd64347b8238595d7db5
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/363f26ecd8b6/disk-ce19275f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6d5a52210863/vmlinux-ce19275f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bfd5e0fcc504/bzImage-ce19275f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bd64347b8238595d7db5@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 22739 at fs/btrfs/free-space-tree.c:859 remove_from_free_space_tree.cold+0xab/0xff fs/btrfs/free-space-tree.c:859
Modules linked in:
CPU: 1 PID: 22739 Comm: syz-executor.0 Not tainted 6.1.0-rc8-syzkaller-00045-gce19275f0103 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:remove_from_free_space_tree.cold+0xab/0xff fs/btrfs/free-space-tree.c:859
Code: e8 f9 ea fd ff 31 ff 41 89 c5 89 c6 e8 92 ed cb f7 45 84 ed 74 18 e8 18 f1 cb f7 44 89 e6 48 c7 c7 e0 56 96 8a e8 98 e8 f2 ff <0f> 0b eb a5 e8 00 f1 cb f7 66 90 41 bd 01 00 00 00 eb 96 e8 f1 f0
RSP: 0018:ffffc900033cf2a0 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 1ffff92000679e5c RCX: 0000000000000000
RDX: 0000000000040000 RSI: ffffffff8165785c RDI: fffff52000679e46
RBP: ffff88803bdcf150 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000000 R12: 00000000ffffffe4
R13: 00000000ffffff01 R14: ffff8880778708f0 R15: ffff88803bdcf1a0
FS:  00007ff0359fe700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055d525afeb80 CR3: 000000001d40e000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 alloc_reserved_extent+0x4d/0x3c0 fs/btrfs/extent-tree.c:4637
 alloc_reserved_tree_block fs/btrfs/extent-tree.c:4788 [inline]
 run_delayed_tree_ref fs/btrfs/extent-tree.c:1670 [inline]
 run_one_delayed_ref fs/btrfs/extent-tree.c:1699 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1943 [inline]
 __btrfs_run_delayed_refs+0x1d09/0x3760 fs/btrfs/extent-tree.c:2008
 btrfs_run_delayed_refs+0x19a/0x490 fs/btrfs/extent-tree.c:2139
 btrfs_commit_transaction+0x1ea7/0x36e0 fs/btrfs/transaction.c:2123
 insert_balance_item.isra.0+0x11f3/0x1460 fs/btrfs/volumes.c:3467
 btrfs_balance+0xf5f/0x3be0 fs/btrfs/volumes.c:4351
 btrfs_ioctl_balance fs/btrfs/ioctl.c:4484 [inline]
 btrfs_ioctl+0x115d/0x5c40 fs/btrfs/ioctl.c:5515
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7ff03e28c0d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff0359fe168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ff03e3ac050 RCX: 00007ff03e28c0d9
RDX: 0000000020000480 RSI: 00000000c4009420 RDI: 0000000000000009
RBP: 00007ff03e2e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffdc8047f0f R14: 00007ff0359fe300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
