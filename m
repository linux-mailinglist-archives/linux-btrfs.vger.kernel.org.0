Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2F24CCD5B
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Mar 2022 06:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235046AbiCDFlB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Mar 2022 00:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232385AbiCDFlA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Mar 2022 00:41:00 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3017151C43
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Mar 2022 21:40:12 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id m3-20020a056e02158300b002b6e3d1f97cso4865954ilu.19
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Mar 2022 21:40:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=jyPn5kXEJqHnfMjwujNltAg3yZ6XHKIa+M0KGtElG/c=;
        b=zNVCak5fENpNFrbgRDVgFTWlj56nrkMe5gb8Jr/Cp6L2G7Z7JG450O4Dild3Ip5I6E
         o+rGMuXtq0hi07F/FYv4Wj98pTvBgAgaUWS+6TiM95g1onuGVorSx2wz2YujnYcB4pPD
         OSrzTpqs5zfUjX09Gmz+X3+hpsmayCZ5LdwlIsxIx51+o1uVj255zASdAnXIzBrujy+b
         3Y1UJB57w4Fi+vMEGft+/Ffr9XFI74g2FsHlE1hZVDmZLUVNxY/gD1ZsaK23WWHJHgDH
         nSUyUiwq0zu3wc8W1hRd/e+MnkD9OvODtFUyv6ocIMRL5Ay9ACuqCg0y2MDX+HR3kekp
         DNjw==
X-Gm-Message-State: AOAM533GnWTTVSaoouhez7akbj/mFFV5j35bcjZLArB4ZBeNmEsKetTn
        7nz/PRDm7rD50H/fSwlGEOx/0MtlnAF7b9FVbxQ5Zdj1aDeX
X-Google-Smtp-Source: ABdhPJxt6GBzL8AEslBxqB6huDaofgg7OjeITtQV6VwjO3kEGXQic6a3e0oB9GF1e4Ll1Zg453Eq8eu7IMpuskLHLtH+oXGUEuQd
MIME-Version: 1.0
X-Received: by 2002:a02:844d:0:b0:317:397b:1765 with SMTP id
 l13-20020a02844d000000b00317397b1765mr19618297jah.67.1646372412368; Thu, 03
 Mar 2022 21:40:12 -0800 (PST)
Date:   Thu, 03 Mar 2022 21:40:12 -0800
In-Reply-To: <20220304052236.2562-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ceac2e05d95df26a@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in btrfs_scan_one_device (2)
From:   syzbot <syzbot+82650a4e0ed38f218363@syzkaller.appspotmail.com>
To:     anand.jain@oracle.com, dsterba@suse.com, hdanton@sina.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
general protection fault in btrfs_iget

general protection fault, probably for non-canonical address 0xdffffc000000003e: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x00000000000001f0-0x00000000000001f7]
CPU: 0 PID: 3975 Comm: syz-executor324 Not tainted 5.17.0-rc5-syzkaller-00306-g2293be58d6a1-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
RIP: 0010:btrfs_inode_hash fs/btrfs/btrfs_inode.h:258 [inline]
RIP: 0010:btrfs_iget_locked fs/btrfs/inode.c:5503 [inline]
RIP: 0010:btrfs_iget_path fs/btrfs/inode.c:5525 [inline]
RIP: 0010:btrfs_iget+0x7a/0x210 fs/btrfs/inode.c:5554
Code: f3 65 48 8b 04 25 28 00 00 00 48 89 44 24 58 31 c0 e8 3a 5f 33 fe 49 8d be f7 01 00 00 48 89 f8 48 89 fe 48 c1 e8 03 83 e6 07 <42> 0f b6 14 20 49 8d 86 fe 01 00 00 48 89 c1 48 c1 e9 03 42 0f b6
RSP: 0018:ffffc900029ef940 EFLAGS: 00010202

RAX: 000000000000003e RBX: 1ffff9200053df28 RCX: 0000000000000000
RDX: ffff88801c40e2c0 RSI: 0000000000000007 RDI: 00000000000001f7
RBP: ffff888023dce000 R08: 0000000000000000 R09: ffffc900029ef6f7
R10: ffffffff8912a851 R11: 0000000000000001 R12: dffffc0000000000
R13: 0000000000000100 R14: 0000000000000000 R15: 0000000000000000
FS:  00007fec6fcc0700(0000) GS:ffff88802ca00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000563567f04618 CR3: 0000000026c41000 CR4: 0000000000150ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_fill_super fs/btrfs/super.c:1364 [inline]
 btrfs_mount_root.cold+0x93/0x1a2 fs/btrfs/super.c:1726
 legacy_get_tree+0x105/0x220 fs/fs_context.c:610
 vfs_get_tree+0x89/0x2f0 fs/super.c:1497
 fc_mount fs/namespace.c:1030 [inline]
 vfs_kern_mount.part.0+0xd3/0x170 fs/namespace.c:1060
 vfs_kern_mount+0x3c/0x60 fs/namespace.c:1047
 btrfs_mount+0x234/0xa60 fs/btrfs/super.c:1788
 legacy_get_tree+0x105/0x220 fs/fs_context.c:610
 vfs_get_tree+0x89/0x2f0 fs/super.c:1497
 do_new_mount fs/namespace.c:3024 [inline]
 path_mount+0x1320/0x1fa0 fs/namespace.c:3354
 do_mount fs/namespace.c:3367 [inline]
 __do_sys_mount fs/namespace.c:3575 [inline]
 __se_sys_mount fs/namespace.c:3552 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3552
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fec6fd142a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fec6fcc02f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fec6fd993e0 RCX: 00007fec6fd142a9
RDX: 0000000020000140 RSI: 0000000020000100 RDI: 0000000020000080
RBP: 0030656c69662f2e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000003 R11: 0000000000000246 R12: 00007fec6fd65478
R13: 00007fec6fd651f0 R14: 00007fec6fd650a8 R15: 00007fec6fd993e8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:btrfs_inode_hash fs/btrfs/btrfs_inode.h:258 [inline]
RIP: 0010:btrfs_iget_locked fs/btrfs/inode.c:5503 [inline]
RIP: 0010:btrfs_iget_path fs/btrfs/inode.c:5525 [inline]
RIP: 0010:btrfs_iget+0x7a/0x210 fs/btrfs/inode.c:5554
Code: f3 65 48 8b 04 25 28 00 00 00 48 89 44 24 58 31 c0 e8 3a 5f 33 fe 49 8d be f7 01 00 00 48 89 f8 48 89 fe 48 c1 e8 03 83 e6 07 <42> 0f b6 14 20 49 8d 86 fe 01 00 00 48 89 c1 48 c1 e9 03 42 0f b6
RSP: 0018:ffffc900029ef940 EFLAGS: 00010202
RAX: 000000000000003e RBX: 1ffff9200053df28 RCX: 0000000000000000
RDX: ffff88801c40e2c0 RSI: 0000000000000007 RDI: 00000000000001f7
RBP: ffff888023dce000 R08: 0000000000000000 R09: ffffc900029ef6f7
R10: ffffffff8912a851 R11: 0000000000000001 R12: dffffc0000000000
R13: 0000000000000100 R14: 0000000000000000 R15: 0000000000000000
FS:  00007fec6fcc0700(0000) GS:ffff88802ca00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000563567f04618 CR3: 0000000026c41000 CR4: 0000000000150ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	f3 65 48 8b 04 25 28 	repz mov %gs:0x28,%rax
   7:	00 00 00
   a:	48 89 44 24 58       	mov    %rax,0x58(%rsp)
   f:	31 c0                	xor    %eax,%eax
  11:	e8 3a 5f 33 fe       	callq  0xfe335f50
  16:	49 8d be f7 01 00 00 	lea    0x1f7(%r14),%rdi
  1d:	48 89 f8             	mov    %rdi,%rax
  20:	48 89 fe             	mov    %rdi,%rsi
  23:	48 c1 e8 03          	shr    $0x3,%rax
  27:	83 e6 07             	and    $0x7,%esi
* 2a:	42 0f b6 14 20       	movzbl (%rax,%r12,1),%edx <-- trapping instruction
  2f:	49 8d 86 fe 01 00 00 	lea    0x1fe(%r14),%rax
  36:	48 89 c1             	mov    %rax,%rcx
  39:	48 c1 e9 03          	shr    $0x3,%rcx
  3d:	42                   	rex.X
  3e:	0f                   	.byte 0xf
  3f:	b6                   	.byte 0xb6


Tested on:

commit:         2293be58 Merge tag 'trace-v5.17-rc4' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
console output: https://syzkaller.appspot.com/x/log.txt?x=112736d6700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5f28851401b410e5
dashboard link: https://syzkaller.appspot.com/bug?extid=82650a4e0ed38f218363
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11de2ad6700000

