Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7854767B2F8
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jan 2023 14:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235557AbjAYNG6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Jan 2023 08:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235540AbjAYNG4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Jan 2023 08:06:56 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AE258283
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Jan 2023 05:06:45 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id n18-20020a056e02101200b0030f2b79c2ffso12564582ilj.20
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Jan 2023 05:06:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LuTSqo617XSrdp8KTYdn2x6SJRlcbMB29Krz/ReNwwI=;
        b=WUuNsTM9JZ8s/lDdBQWySRO42uCWcPpcOqGnrx0MY/2nKFg8NWq0fIF+2e/byPfZ3z
         v+uyScBZJ9lsRMqNMOlWekJZkiNJdOwMvoOl4o18htL8rhb5h9cHGCwPatPjrRYrwbYz
         7fNawMmqI6MkyQMJECuZ4+MstHbNWUG5pEhpTPP2OK+LkLFcgFCWs1+m7Au/E8G4shqa
         oKyNrYqkQzMhP9O608jxe47oJ4Vq5LkxGN/dLDyymZe8qWEPN1OHQKEjkMinAcv0Hcoh
         lOkJlV93dOz76lqO9m9XvRDxA1gDQ9P+yFS+kp1C8KUNnVA8e28sNHH512g9yyUhSqAg
         FqvQ==
X-Gm-Message-State: AO0yUKVBblYqAn/k5cT2B1Dzs+P2WdTfC80hcHKBEa4h7y0kfjJuYCe1
        l+HfyPFe3bMyv+p3Wct6pUW1yKZ4Iuujeju0EFysSj4hLuqK
X-Google-Smtp-Source: AK7set+DXb6Z8Gv0MQHpZxz6gfOlcEb0EwWwK8w/phv3KXT9qZMMDWqVUnOg181Bcpn7PK+rr2tSsnGxIJnPZE240v4H6DcMm6hs
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1006:b0:30f:8a37:ef1a with SMTP id
 n6-20020a056e02100600b0030f8a37ef1amr1070905ilj.187.1674652004685; Wed, 25
 Jan 2023 05:06:44 -0800 (PST)
Date:   Wed, 25 Jan 2023 05:06:44 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dca1ae05f3164d2f@google.com>
Subject: [syzbot] [btrfs?] kernel BUG in btrfs_csum_one_bio
From:   syzbot <syzbot+d8941552e21eac774778@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, fdmanana@suse.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f883675bf652 Merge tag 'gpio-fixes-for-v6.2-rc5' of git://..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=114f4b71480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d24faf5fc10540ae
dashboard link: https://syzkaller.appspot.com/bug?extid=d8941552e21eac774778
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=157373de480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=153fd539480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a81ede383e7d/disk-f883675b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/510567d86f5c/vmlinux-f883675b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0fc2746533ba/bzImage-f883675b.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/40fdc0e77810/mount_0.gz

The issue was bisected to:

commit 2c8f5e8cdf0f77670b1a9f72156ad4e82ed323d1
Author: Filipe Manana <fdmanana@suse.com>
Date:   Fri Nov 11 11:50:27 2022 +0000

    btrfs: remove leftover setting of EXTENT_UPTODATE state in an inode's io_tree

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14c1e256480000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16c1e256480000
console output: https://syzkaller.appspot.com/x/log.txt?x=12c1e256480000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d8941552e21eac774778@syzkaller.appspotmail.com
Fixes: 2c8f5e8cdf0f ("btrfs: remove leftover setting of EXTENT_UPTODATE state in an inode's io_tree")

RSP: 002b:00007ffc233556b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f5e11d88ab9
RDX: 000000000000fea7 RSI: 00000000200001c0 RDI: 0000000000000004
RBP: 00007ffc233556e0 R08: 0000000000000002 R09: 00007ffc233556f0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000006
R13: 00007ffc23355720 R14: 00007ffc23355700 R15: 000000000000000a
 </TASK>
------------[ cut here ]------------
kernel BUG at fs/btrfs/file-item.c:871!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5275 Comm: syz-executor267 Not tainted 6.2.0-rc4-syzkaller-00379-gf883675bf652 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
RIP: 0010:btrfs_csum_one_bio+0x11bd/0x1210 fs/btrfs/file-item.c:871
Code: 8b 5c 24 20 e9 85 f2 ff ff e8 0f fa 02 fe 48 c7 c7 e0 88 84 8d 4c 89 f6 48 89 da e8 9d 83 f7 00 e9 4b f0 ff ff e8 f3 f9 02 fe <0f> 0b 44 89 f9 80 e1 07 38 c1 0f 8c 89 fd ff ff be 08 00 00 00 4c
RSP: 0018:ffffc90004a2f120 EFLAGS: 00010293
RAX: ffffffff8388e1fd RBX: 0000000000400140 RCX: ffff88801fd43a80
RDX: 0000000000000000 RSI: 1ffff11003fa8755 RDI: ffff88801fd43aac
RBP: ffffc90004a2f458 R08: ffffffff81c50a8e R09: 00000000ffffffff
R10: fffffbfff1a83333 R11: 1ffffffff1a83332 R12: 1ffff1100fba540c
R13: dffffc0000000000 R14: 000000000000005c R15: 000000000000f000
FS:  0000555556645300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055a1244ffb38 CR3: 0000000021b63000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_submit_data_write_bio+0x339/0x4a0 fs/btrfs/inode.c:2755
 submit_one_bio+0x353/0x490 fs/btrfs/extent_io.c:158
 submit_write_bio fs/btrfs/extent_io.c:184 [inline]
 extent_writepages+0x306/0x540 fs/btrfs/extent_io.c:3212
 do_writepages+0x3c3/0x680 mm/page-writeback.c:2581
 filemap_fdatawrite_wbc+0x11e/0x170 mm/filemap.c:388
 __filemap_fdatawrite_range mm/filemap.c:421 [inline]
 filemap_fdatawrite_range+0x175/0x200 mm/filemap.c:439
 btrfs_fdatawrite_range fs/btrfs/file.c:3857 [inline]
 start_ordered_ops fs/btrfs/file.c:1737 [inline]
 btrfs_sync_file+0x383/0x1190 fs/btrfs/file.c:1813
 generic_write_sync include/linux/fs.h:2885 [inline]
 btrfs_do_write_iter+0xcd3/0x1280 fs/btrfs/file.c:1684
 call_write_iter include/linux/fs.h:2189 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x7dc/0xc50 fs/read_write.c:584
 ksys_write+0x177/0x2a0 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f5e11d88ab9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc233556b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f5e11d88ab9
RDX: 000000000000fea7 RSI: 00000000200001c0 RDI: 0000000000000004
RBP: 00007ffc233556e0 R08: 0000000000000002 R09: 00007ffc233556f0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000006
R13: 00007ffc23355720 R14: 00007ffc23355700 R15: 000000000000000a
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:btrfs_csum_one_bio+0x11bd/0x1210 fs/btrfs/file-item.c:871
Code: 8b 5c 24 20 e9 85 f2 ff ff e8 0f fa 02 fe 48 c7 c7 e0 88 84 8d 4c 89 f6 48 89 da e8 9d 83 f7 00 e9 4b f0 ff ff e8 f3 f9 02 fe <0f> 0b 44 89 f9 80 e1 07 38 c1 0f 8c 89 fd ff ff be 08 00 00 00 4c
RSP: 0018:ffffc90004a2f120 EFLAGS: 00010293
RAX: ffffffff8388e1fd RBX: 0000000000400140 RCX: ffff88801fd43a80
RDX: 0000000000000000 RSI: 1ffff11003fa8755 RDI: ffff88801fd43aac
RBP: ffffc90004a2f458 R08: ffffffff81c50a8e R09: 00000000ffffffff
R10: fffffbfff1a83333 R11: 1ffffffff1a83332 R12: 1ffff1100fba540c
R13: dffffc0000000000 R14: 000000000000005c R15: 000000000000f000
FS:  0000555556645300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055cbc1e980c8 CR3: 0000000021b63000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
