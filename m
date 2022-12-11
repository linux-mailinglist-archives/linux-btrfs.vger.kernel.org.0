Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B96649275
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Dec 2022 06:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiLKFSH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 11 Dec 2022 00:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiLKFR6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 11 Dec 2022 00:17:58 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B2E103B
        for <linux-btrfs@vger.kernel.org>; Sat, 10 Dec 2022 21:17:40 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id x10-20020a056e021bca00b00302b6c0a683so2859915ilv.23
        for <linux-btrfs@vger.kernel.org>; Sat, 10 Dec 2022 21:17:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/ihziodggncmxIb1HA3GZJ7Z2yoxCndt5g6/ci9uyk=;
        b=37xeG9STbW23FCU+6prQdHbfDgMuc3fXSe5ro+g9CkGKC1dhkmfpoiEMzA/NsehMI9
         n9c39qCJwoOPle4D/PCfQo5FqgPr8FuVnT78BBGaCikYduXbXi1WhNW4ctCnWkxySU4d
         YtfZjO973fK05OkcABrCbUko3Dhmuc4xHsiafBIqwW84V1K1dy6Urht4LtyYMycMWw6K
         Tv/E7VSY+tV6S6vE8+ERGFBZ36HBx5EMtU94Xp4Qy6NwxV5bkxF7n6pObASo2ZD0f00L
         wu4YDk0BW7ZiMiKcbLDtW267p1njXNn3HDEz4OtUlpb9ps0HhaJDwFfBlMqWdtCoiglb
         62xQ==
X-Gm-Message-State: ANoB5pn+3v5EYOdWYY/MLgtibHyGneIbLbSFAFxVKZ1a4TdNxJ61lGOv
        O8sYu6jr9ofgSK1MLFW3QxhQPaJGG1Q8/RJ26DQchwCtHkvH
X-Google-Smtp-Source: AA0mqf7itXoVg8+wudUIXFPyLwrkS4kg3JfDdxm5I7MLOX7NPd6jn3AfiIVbNigW6CQdapp+fCnbnmkm8zuZkFdeoaD4CTZrzf3k
MIME-Version: 1.0
X-Received: by 2002:a6b:6d0d:0:b0:6c4:ad4d:b23a with SMTP id
 a13-20020a6b6d0d000000b006c4ad4db23amr32397030iod.2.1670735859743; Sat, 10
 Dec 2022 21:17:39 -0800 (PST)
Date:   Sat, 10 Dec 2022 21:17:39 -0800
In-Reply-To: <0000000000000e082305eec34072@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006f049f05ef868103@google.com>
Subject: Re: [syzbot] kernel BUG in set_state_bits
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    296a7b7eb792 Merge tag 'for-linus' of git://git.armlinux.o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16a12ddb880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4edf421741552bc3
dashboard link: https://syzkaller.appspot.com/bug?extid=b9d2e54d2301324657ed
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12ec2ab7880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14dc4613880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c19ef17ae288/disk-296a7b7e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/68d26e4d2868/vmlinux-296a7b7e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/06aad301e7dd/bzImage-296a7b7e.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/5660348a6b33/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b9d2e54d2301324657ed@syzkaller.appspotmail.com

RBP: 00007ffe8b0af640 R08: 0000000000000001 R09: 00007f4094fa0034
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000007
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
------------[ cut here ]------------
kernel BUG at fs/btrfs/extent-io-tree.c:381!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 3627 Comm: syz-executor376 Not tainted 6.1.0-rc8-syzkaller-00154-g296a7b7eb792 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:set_state_bits.isra.0+0x17b/0x1c0 fs/btrfs/extent-io-tree.c:381
Code: 38 d0 7c 04 84 d2 75 31 44 8b 73 7c e8 0e cd fb fd 44 89 e0 44 09 f0 89 43 7c 5b 5d 41 5c 41 5d 41 5e 41 5f c3 e8 f5 cc fb fd <0f> 0b 4c 89 ef e8 fb a6 48 fe e9 e6 fe ff ff 4c 89 ef e8 ee a6 48
RSP: 0018:ffffc90003baf860 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff8880790a2840 RCX: 0000000000000000
RDX: ffff888022638000 RSI: ffffffff8384510b RDI: 0000000000000005
RBP: 00000000fffffff4 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000fffffff4 R11: 0000000000000000 R12: 0000000000001000
R13: ffff8880790a28bc R14: 0000000000000fff R15: 0000000000000000
FS:  0000555555779300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff787f16e8 CR3: 0000000072e1e000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 insert_state_fast fs/btrfs/extent-io-tree.c:439 [inline]
 __set_extent_bit+0xd09/0x1430 fs/btrfs/extent-io-tree.c:997
 set_record_extent_bits+0x5e/0x70 fs/btrfs/extent-io-tree.c:1601
 qgroup_reserve_data+0x239/0xbc0 fs/btrfs/qgroup.c:3739
 btrfs_qgroup_reserve_data+0x2f/0xd0 fs/btrfs/qgroup.c:3782
 btrfs_check_data_free_space+0x111/0x280 fs/btrfs/delalloc-space.c:152
 btrfs_buffered_write+0x4f1/0x1330 fs/btrfs/file.c:1559
 btrfs_direct_write fs/btrfs/file.c:1899 [inline]
 btrfs_do_write_iter+0xece/0x1450 fs/btrfs/file.c:1980
 call_write_iter include/linux/fs.h:2199 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x9ed/0xdd0 fs/read_write.c:584
 ksys_write+0x12b/0x250 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f4094fe1cf9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe8b0af638 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f4094fe1cf9
RDX: 0000000000000049 RSI: 0000000020000180 RDI: 0000000000000005
RBP: 00007ffe8b0af640 R08: 0000000000000001 R09: 00007f4094fa0034
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000007
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:set_state_bits.isra.0+0x17b/0x1c0 fs/btrfs/extent-io-tree.c:381
Code: 38 d0 7c 04 84 d2 75 31 44 8b 73 7c e8 0e cd fb fd 44 89 e0 44 09 f0 89 43 7c 5b 5d 41 5c 41 5d 41 5e 41 5f c3 e8 f5 cc fb fd <0f> 0b 4c 89 ef e8 fb a6 48 fe e9 e6 fe ff ff 4c 89 ef e8 ee a6 48
RSP: 0018:ffffc90003baf860 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff8880790a2840 RCX: 0000000000000000
RDX: ffff888022638000 RSI: ffffffff8384510b RDI: 0000000000000005
RBP: 00000000fffffff4 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000fffffff4 R11: 0000000000000000 R12: 0000000000001000
R13: ffff8880790a28bc R14: 0000000000000fff R15: 0000000000000000
FS:  0000555555779300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff787f16e8 CR3: 0000000072e1e000 CR4: 0000000000350ee0

