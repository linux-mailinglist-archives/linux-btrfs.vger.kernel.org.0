Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A964E611CB2
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Oct 2022 23:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiJ1Vun (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Oct 2022 17:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiJ1Vuk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Oct 2022 17:50:40 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E935220C9B5
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Oct 2022 14:50:37 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id a6-20020a056602208600b006bff2e56943so5202219ioa.11
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Oct 2022 14:50:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qTT5yVHbI3cRvy7cj7RM85ugbVqlsjULyFzBJneDTsQ=;
        b=SuYgI4IetPxZTirTppRqUj1Slyb6Ut1zNsj2WWRYhOOyCC8tVJHN9LHutZaKi+8Edw
         2TA7+qwsUKA7YvFxynooy3NKHjMeizuT2lv9aUkccZY/vPFh3FX+LP/z1Sx9F8rezpAG
         zSngQb+NmlrHAHgvV718AdCDN8L+pX2Devb4ofD11YiXwHrZC5NvpqCtBjKX0n80QQdc
         zV6bRM1pacvX87fox8pp3WsdjzzSzZk9caM4WzkT11okUvr0mV3yc8pjqhHesXKgCxi5
         kfzC3oE96LL8HZegdKbO3UE5glBau16BuHAIGR5A81kBYbN/JlMVCh7sL/8ce7ULo5lk
         XCmg==
X-Gm-Message-State: ACrzQf03IWjPeld+wHajkdKpHD6rCx+SUtu4gXpQVYampHisc9mszNmR
        BdTjBa7eGig07tbjGKLv0GILoaQPxHDEaPRz2GuSIGfw+B1k
X-Google-Smtp-Source: AMsMyM4CqM4wTKB8EY7iDLrJHptNnEglkyhWl/77ILewUSD5YGIf1Ft6WnOOLlYythZCEjRa+WdefD2nlpGl0Z2Xzoty0yxIMpAE
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1688:b0:2fc:50d7:6961 with SMTP id
 f8-20020a056e02168800b002fc50d76961mr694493ila.230.1666993837040; Fri, 28 Oct
 2022 14:50:37 -0700 (PDT)
Date:   Fri, 28 Oct 2022 14:50:37 -0700
In-Reply-To: <00000000000095ab2705eb49b484@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007ff3e705ec1f3f90@google.com>
Subject: Re: [syzbot] WARNING in btrfs_add_link
From:   syzbot <syzbot+b531e31d583db14070d4@syzkaller.appspotmail.com>
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    b229b6ca5abb Merge tag 'perf-tools-fixes-for-v6.1-2022-10-..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11afbf6a880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d3548a4365ba17d
dashboard link: https://syzkaller.appspot.com/bug?extid=b531e31d583db14070d4
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=124ae5f6880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1008c991880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/24728b72a896/disk-b229b6ca.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/10a3c40c60e1/vmlinux-b229b6ca.xz
kernel image: https://storage.googleapis.com/syzbot-assets/69f963b02b7e/bzImage-b229b6ca.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/fefdce45ff1c/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b531e31d583db14070d4@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 3605 at fs/btrfs/inode.c:6568 btrfs_add_link+0x862/0xca0 fs/btrfs/inode.c:6568
Modules linked in:
CPU: 0 PID: 3605 Comm: syz-executor377 Not tainted 6.1.0-rc2-syzkaller-00105-gb229b6ca5abb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
RIP: 0010:btrfs_add_link+0x862/0xca0 fs/btrfs/inode.c:6568
Code: 40 f8 da 8a 8b 54 24 08 31 c0 e8 7b 50 a7 06 e9 21 ff ff ff e8 8f 55 fd fd 48 c7 c7 40 f7 da 8a 44 89 e6 31 c0 e8 de f3 c4 fd <0f> 0b 41 b4 01 45 0f b6 c4 48 89 df 48 c7 c6 00 ff da 8a ba a8 19
RSP: 0018:ffffc90003cff460 EFLAGS: 00010246
RAX: ade94f10cf44a400 RBX: ffff888072095150 RCX: ffff888024b7ba80
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc90003cff588 R08: ffffffff816b8dfd R09: ffffed1017364f13
R10: ffffed1017364f13 R11: 1ffff11017364f12 R12: 00000000fffffff4
R13: 00000000fffffff4 R14: ffff8880720951a0 R15: 1ffff1100e412a34
FS:  0000555556786300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000557c351539e0 CR3: 0000000076ed0000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_create_new_inode+0x1778/0x2270 fs/btrfs/inode.c:6504
 btrfs_create_common+0x2eb/0x420 fs/btrfs/inode.c:6639
 lookup_open fs/namei.c:3413 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x12d0/0x2df0 fs/namei.c:3710
 do_filp_open+0x264/0x4f0 fs/namei.c:3740
 do_sys_openat2+0x124/0x4e0 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_openat fs/open.c:1342 [inline]
 __se_sys_openat fs/open.c:1337 [inline]
 __x64_sys_openat+0x243/0x290 fs/open.c:1337
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0d1504bdd9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff9971cc08 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f0d1504bdd9
RDX: 000000000000275a RSI: 00000000200001c0 RDI: 00000000ffffff9c
RBP: 00007fff9971cc40 R08: 0000000000000002 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
R13: 00007f0d1508bf00 R14: 00007fff9971cc90 R15: 0000000000000001
 </TASK>

