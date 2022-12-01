Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505F363F055
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Dec 2022 13:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbiLAMUw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Dec 2022 07:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbiLAMUs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Dec 2022 07:20:48 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AF3AC18D
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Dec 2022 04:20:44 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id d19-20020a056e020c1300b00300b5a12c44so1766048ile.15
        for <linux-btrfs@vger.kernel.org>; Thu, 01 Dec 2022 04:20:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wMT1KljzfUd/pV0qhTXXgm88SnIIs2YbbL99g3bYbhg=;
        b=oYGZhlSqeD4vi4jWbOZYHwSzXLrJklcoWH1o0N+DVA/FhDLuRDLH+GKqwe4huY0pZ8
         mQbuhNHyPpCoJHgSXUwvsA0msuM5Xs0CcG+4WJ6SrrwkxijIP2toPismWp8EsMpIrNol
         1WLaX/5VfHous2RmmBTbeyrz8cHtoPwsYDD5LQqq4k5kro9DMmGB35cOkMHo8CUC3xut
         WsSv27uyYxNXWByHpojyCd3RdHqSVyeieG4aZzyimn/Wye4h7Zl6wZ9NimwBJednJ1Ep
         AKVhbKMjXRhvK5ra+u/hX8s4ftUP/fM1ECJDyo6adRo3U91j3uRXs8lKVkF2sdpDEx11
         8NdQ==
X-Gm-Message-State: ANoB5pn/9oJ/k6OhlM4e9sWRGrCrvpk3C6+3bEoUBYHnF2oN7sakGMz5
        1wPnQ02gyxvrrF6nAZ05ir0b0ujmneuEraHyPViWeZGOI0x2
X-Google-Smtp-Source: AA0mqf46vKUcLWoQ78pEiRV1qjCJa+7ueoHfG2lW86B9dVYjaaM3J76BJY6Bn6TzkFcBhYwSV3n2HpoJl1QwVdy9iEjIvcxG4jth
MIME-Version: 1.0
X-Received: by 2002:a5d:980d:0:b0:6a0:ee21:53fb with SMTP id
 a13-20020a5d980d000000b006a0ee2153fbmr22229567iol.190.1669897244240; Thu, 01
 Dec 2022 04:20:44 -0800 (PST)
Date:   Thu, 01 Dec 2022 04:20:44 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000e082305eec34072@google.com>
Subject: [syzbot] kernel BUG in set_state_bits
From:   syzbot <syzbot+b9d2e54d2301324657ed@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    04aa64375f48 drm/i915: fix TLB invalidation for Gen12 vide..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10eaf7fd880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cc4b2e0a8e8a8366
dashboard link: https://syzkaller.appspot.com/bug?extid=b9d2e54d2301324657ed
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/eb15d8caa706/disk-04aa6437.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/34b02819c252/vmlinux-04aa6437.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fce6b0f68514/bzImage-04aa6437.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b9d2e54d2301324657ed@syzkaller.appspotmail.com

Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd13eafe168 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 00007fd13dfabf80 RCX: 00007fd13de8c0d9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 00007fd13eafe1d0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000280404 R11: 0000000000000246 R12: 0000000000000002
R13: 00007fff8d69463f R14: 00007fd13eafe300 R15: 0000000000022000
 </TASK>
------------[ cut here ]------------
kernel BUG at fs/btrfs/extent-io-tree.c:381!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 21793 Comm: syz-executor.2 Not tainted 6.1.0-rc7-syzkaller-00102-g04aa64375f48 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:set_state_bits.isra.0+0x17b/0x1c0 fs/btrfs/extent-io-tree.c:381
Code: 38 d0 7c 04 84 d2 75 31 44 8b 73 7c e8 fe df fb fd 44 89 e0 44 09 f0 89 43 7c 5b 5d 41 5c 41 5d 41 5e 41 5f c3 e8 e5 df fb fd <0f> 0b 4c 89 ef e8 7b b2 48 fe e9 e6 fe ff ff 4c 89 ef e8 6e b2 48
RSP: 0018:ffffc9000bb77a90 EFLAGS: 00010246
RAX: 0000000000040000 RBX: ffff88801917c240 RCX: ffffc900043b3000
RDX: 0000000000040000 RSI: ffffffff8384393b RDI: 0000000000000005
RBP: 00000000fffffff4 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000fffffff4 R11: 0000000000000000 R12: 0000000000001000
R13: ffff88801917c2bc R14: 0000000000280fff R15: 0000000000000000
FS:  00007fd13eafe700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b30a31000 CR3: 000000007c091000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 __set_extent_bit+0x79d/0x1430 fs/btrfs/extent-io-tree.c:1019
 set_record_extent_bits+0x5e/0x70 fs/btrfs/extent-io-tree.c:1601
 qgroup_reserve_data+0x239/0xbc0 fs/btrfs/qgroup.c:3739
 btrfs_qgroup_reserve_data+0x2f/0xd0 fs/btrfs/qgroup.c:3782
 btrfs_fallocate+0x7fd/0x27c0 fs/btrfs/file.c:3451
 vfs_fallocate+0x48b/0xe00 fs/open.c:323
 ksys_fallocate fs/open.c:346 [inline]
 __do_sys_fallocate fs/open.c:354 [inline]
 __se_sys_fallocate fs/open.c:352 [inline]
 __x64_sys_fallocate+0xd3/0x140 fs/open.c:352
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fd13de8c0d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd13eafe168 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 00007fd13dfabf80 RCX: 00007fd13de8c0d9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 00007fd13eafe1d0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000280404 R11: 0000000000000246 R12: 0000000000000002
R13: 00007fff8d69463f R14: 00007fd13eafe300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:set_state_bits.isra.0+0x17b/0x1c0 fs/btrfs/extent-io-tree.c:381
Code: 38 d0 7c 04 84 d2 75 31 44 8b 73 7c e8 fe df fb fd 44 89 e0 44 09 f0 89 43 7c 5b 5d 41 5c 41 5d 41 5e 41 5f c3 e8 e5 df fb fd <0f> 0b 4c 89 ef e8 7b b2 48 fe e9 e6 fe ff ff 4c 89 ef e8 6e b2 48
RSP: 0018:ffffc9000bb77a90 EFLAGS: 00010246
RAX: 0000000000040000 RBX: ffff88801917c240 RCX: ffffc900043b3000
RDX: 0000000000040000 RSI: ffffffff8384393b RDI: 0000000000000005
RBP: 00000000fffffff4 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000fffffff4 R11: 0000000000000000 R12: 0000000000001000
R13: ffff88801917c2bc R14: 0000000000280fff R15: 0000000000000000
FS:  00007fd13eafe700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b30a31000 CR3: 000000007c091000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess):
   0:	28 00                	sub    %al,(%rax)
   2:	00 00                	add    %al,(%rax)
   4:	75 05                	jne    0xb
   6:	48 83 c4 28          	add    $0x28,%rsp
   a:	c3                   	retq
   b:	e8 f1 19 00 00       	callq  0x1a01
  10:	90                   	nop
  11:	48 89 f8             	mov    %rdi,%rax
  14:	48 89 f7             	mov    %rsi,%rdi
  17:	48 89 d6             	mov    %rdx,%rsi
  1a:	48 89 ca             	mov    %rcx,%rdx
  1d:	4d 89 c2             	mov    %r8,%r10
  20:	4d 89 c8             	mov    %r9,%r8
  23:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
  28:	0f 05                	syscall
* 2a:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax <-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	retq
  33:	48 c7 c1 b8 ff ff ff 	mov    $0xffffffffffffffb8,%rcx
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
