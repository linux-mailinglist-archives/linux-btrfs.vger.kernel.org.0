Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F60B272712
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 16:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgIUOcW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 10:32:22 -0400
Received: from mail-il1-f207.google.com ([209.85.166.207]:35342 "EHLO
        mail-il1-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgIUOcW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 10:32:22 -0400
Received: by mail-il1-f207.google.com with SMTP id e16so11221649ilq.2
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Sep 2020 07:32:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=NWGruP60rl9r3pTkX1fQRkp0VOki59G8bmOunB0fjsU=;
        b=kdEinhP7lT7I8eUMpF5n5viYtF2kwaZ5VGmXK81yJ/C7+UGHhdZu4H9Gv/Nxk3rda/
         lYJHBIVV3GVSxLjw2BClqRwtVLLR1JykHI0Tr2szd/Iqh8x7TO7Jk7o2g5ZeYM2K/gxQ
         GAUpJ9BB2NA92Xzw1ovGyMfmIeUX9+pvr/ODUus1+L62Vp4WiCcmitSAWo67YO2B+63n
         wDwL+RTXstsdEJS0ujXoXeD1fFwBQIFyr6Vf+k6uMOvWP5XMEz7tpfVmBLF1i3zPf9BL
         n99MoaL3wzNgcWgNytcJKeGRnSGoSlFOYRNFlpdBBrB5Cm3wwTqm/fXSXqgxvNNNT8Y+
         lCtg==
X-Gm-Message-State: AOAM531hOD4+1groCdD5ZUqk8+IqCSHeKGWEAqIO92qEanbZlz6AdRWV
        VLBT1At4J9Tig1vuJ9FnzYbko8UvjralZsKNs9PsSq1p4B+t
X-Google-Smtp-Source: ABdhPJwZFezxiQaDkb74Us5Iq7oF3BGB9ZOM810V0t50g7NuA5ZqfnElD4SYYJP88XhP1mvSbRK6f7nBOYQxvOl7xi7ZC34md4vR
MIME-Version: 1.0
X-Received: by 2002:a6b:8dcc:: with SMTP id p195mr36051382iod.39.1600698741367;
 Mon, 21 Sep 2020 07:32:21 -0700 (PDT)
Date:   Mon, 21 Sep 2020 07:32:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000df277105afd3b70e@google.com>
Subject: KASAN: stack-out-of-bounds Write in read_extent_buffer
From:   syzbot <syzbot+1d393803acac53c985a0@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    860461e4 Add linux-next specific files for 20200917
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=141fc5d9900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f2392812d6c63d5c
dashboard link: https://syzkaller.appspot.com/bug?extid=1d393803acac53c985a0
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16778b07900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1216f8ad900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1d393803acac53c985a0@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: stack-out-of-bounds in memcpy include/linux/string.h:399 [inline]
BUG: KASAN: stack-out-of-bounds in read_extent_buffer+0x114/0x150 fs/btrfs/extent_io.c:5674
Write of size 8 at addr ffffc90000dd79f0 by task kworker/u4:1/21

CPU: 1 PID: 21 Comm: kworker/u4:1 Not tainted 5.9.0-rc5-next-20200917-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: btrfs-endio-meta btrfs_work_helper
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fb lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0x5/0x497 mm/kasan/report.c:385
 __kasan_report mm/kasan/report.c:545 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:562
 check_memory_region_inline mm/kasan/generic.c:186 [inline]
 check_memory_region+0x13d/0x180 mm/kasan/generic.c:192
 memcpy+0x39/0x60 mm/kasan/common.c:106
 memcpy include/linux/string.h:399 [inline]
 read_extent_buffer+0x114/0x150 fs/btrfs/extent_io.c:5674
 btree_readpage_end_io_hook+0x7de/0x950 fs/btrfs/disk-io.c:641
 end_bio_extent_readpage+0x4de/0x10c0 fs/btrfs/extent_io.c:2854
 bio_endio+0x3d3/0x7a0 block/bio.c:1449
 end_workqueue_fn+0x114/0x170 fs/btrfs/disk-io.c:1696
 btrfs_work_helper+0x20a/0xd20 fs/btrfs/async-thread.c:318
 process_one_work+0x933/0x15a0 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3af/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296


addr ffffc90000dd79f0 is located in stack of task kworker/u4:1/21 at offset 48 in frame:
 btree_readpage_end_io_hook+0x0/0x950 fs/btrfs/disk-io.c:201

this frame has 4 objects:
 [48, 52) 'val'
 [64, 80) 'fsid'
 [96, 128) 'result'
 [160, 192) 'found'

Memory state around the buggy address:
 ffffc90000dd7880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc90000dd7900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc90000dd7980: 00 00 00 00 00 00 00 00 f1 f1 f1 f1 f1 f1 04 f2
                                                             ^
 ffffc90000dd7a00: 00 00 f2 f2 00 00 00 00 f2 f2 f2 f2 00 00 00 00
 ffffc90000dd7a80: f3 f3 f3 f3 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
