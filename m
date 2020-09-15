Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABCF826A78B
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Sep 2020 16:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgIOOvK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Sep 2020 10:51:10 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:47849 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbgIOOut (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Sep 2020 10:50:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600181449; x=1631717449;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FuY2sjxrHPg1EmZiX5672xhk2sR05qwXLjXu5WrEQnA=;
  b=W3qK/O9PynCNTG/UiiAu6+09irXYyylLO2v9w5qKG5ZHHqxEjMKFhWOz
   8ketmMSCkxDtRtEc3It9aXuudd/UD+cr4eoo+eoPIEVLlS4zpZNcxzDME
   wEDRMEwfjJxoNTHsronyoCNiqMI1XR6LDJMSSC2wSDCG25siwswLXeXQS
   SKbczUUzLaMZBb1+ZyOmCQDOdHjxJL8Pn0ajtWBu1ycQxdPw8tj9s+noT
   7yT4xZctFn0fbrOsFBSpT/fT94om5VFtlU5hOZ0L4g7fPUgDrz2m6qIa+
   qpbf04erD5v9af/XpKYHuP2KK1IOvCGgEQocaVuUVqkFl7acWQcBCUiNN
   g==;
IronPort-SDR: +QYbdY9yv5aSge23PB6/BT1jF8gqBg/P3+8/pRaTgo8YZAO1PFChEZTZ+DEU8WPtL5QdgbEJ0a
 cw10f6i6NmqTEHUPm2xhLgV5xhRqsLZAbGBhMPbZtD5ir/LzcUgFD4JOG8q9Mrqqv2/e5hKT/S
 cUkyeQvI6OiH23b68MQLXGIUqiQNJ6l58TwgA05fNAR59meLn1lnFJfy0yP5OW7ppo0zkC8jw6
 6NNYmHon5ql0TyMtI6bPoHfFTtm9Pbhbsu+FEBVmh9/lB9ASHviFupeREdj53r7vXkrpxFmM2l
 k1I=
X-IronPort-AV: E=Sophos;i="5.76,430,1592841600"; 
   d="scan'208";a="148660847"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2020 22:50:40 +0800
IronPort-SDR: 0RG825jPrmuEXKTeMkhggqDo1rgH6DH+sCryyRnOeMTi+muP4zVdgdb9iJ64ZvxEcpm5lq4SYI
 sW8fsuWDi1/w==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 07:37:50 -0700
IronPort-SDR: IeTziHuYD0Q2YLO7fXDUL61kHjuQ5EVTXdiE4O7JIxoafuvCH0ZTheFdmI4jiBx+fK5mwyPFNg
 0yaanylnycFA==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Sep 2020 07:50:39 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        syzbot+e864a35d361e1d4e29a5@syzkaller.appspotmail.com
Subject: [PATCH] btrfs: fix overflow when copying corrupt csums
Date:   Tue, 15 Sep 2020 23:49:31 +0900
Message-Id: <20200915144931.24555-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Syzkaller reported a buffer overflow in btree_readpage_end_io_hook() when
loop mounting a crafted image:

detected buffer overflow in memcpy
------------[ cut here ]------------
kernel BUG at lib/string.c:1129!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 26 Comm: kworker/u4:2 Not tainted 5.9.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: btrfs-endio-meta btrfs_work_helper
RIP: 0010:fortify_panic+0xf/0x20 lib/string.c:1129
Code: 89 c7 48 89 74 24 08 48 89 04 24 e8 ab 39 00 fe 48 8b 74 24 08 48 8b 04 24 eb d5 48 89 fe 48 c7 c7 40 22 97 88 e8 b0 8c a9 fd <0f> 0b cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 41 57 41 56 41
RSP: 0018:ffffc90000e27980 EFLAGS: 00010286
RAX: 0000000000000022 RBX: ffff8880a80dca64 RCX: 0000000000000000
RDX: ffff8880a90860c0 RSI: ffffffff815dba07 RDI: fffff520001c4f22
RBP: ffff8880a80dca00 R08: 0000000000000022 R09: ffff8880ae7318e7
R10: 0000000000000000 R11: 0000000000077578 R12: 00000000ffffff6e
R13: 0000000000000008 R14: ffffc90000e27a40 R15: 1ffff920001c4f3c
FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000557335f440d0 CR3: 000000009647d000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 memcpy include/linux/string.h:405 [inline]
 btree_readpage_end_io_hook.cold+0x206/0x221 fs/btrfs/disk-io.c:642
 end_bio_extent_readpage+0x4de/0x10c0 fs/btrfs/extent_io.c:2854
 bio_endio+0x3cf/0x7f0 block/bio.c:1449
 end_workqueue_fn+0x114/0x170 fs/btrfs/disk-io.c:1695
 btrfs_work_helper+0x221/0xe20 fs/btrfs/async-thread.c:318
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
Modules linked in:
---[ end trace b68924293169feef ]---
RIP: 0010:fortify_panic+0xf/0x20 lib/string.c:1129
Code: 89 c7 48 89 74 24 08 48 89 04 24 e8 ab 39 00 fe 48 8b 74 24 08 48 8b 04 24 eb d5 48 89 fe 48 c7 c7 40 22 97 88 e8 b0 8c a9 fd <0f> 0b cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 41 57 41 56 41
RSP: 0018:ffffc90000e27980 EFLAGS: 00010286
RAX: 0000000000000022 RBX: ffff8880a80dca64 RCX: 0000000000000000
RDX: ffff8880a90860c0 RSI: ffffffff815dba07 RDI: fffff520001c4f22
RBP: ffff8880a80dca00 R08: 0000000000000022 R09: ffff8880ae7318e7
R10: 0000000000000000 R11: 0000000000077578 R12: 00000000ffffff6e
R13: 0000000000000008 R14: ffffc90000e27a40 R15: 1ffff920001c4f3c
FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f95b7c4d008 CR3: 000000009647d000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

The overflow happens, because in btree_readpage_end_io_hook() we assume that
we have found a 4 byte checksum instead of the real possible 32 bytes we
have for the checksums.

With the fix applied:

BTRFS: device fsid 815caf9a-dc43-4d2a-ac54-764b8333d765 devid 1 transid 5 /dev/loop0 scanned by syz-repro (214)
BTRFS info (device loop0): disk space caching is enabled
BTRFS info (device loop0): has skinny extents
BTRFS warning (device loop0): loop0 checksum verify failed on 1052672 wanted fc35c0f9 found 4b0bbc71 level 0
BTRFS error (device loop0): failed to read chunk root
BTRFS error (device loop0): open_ctree failed

Fixes: d5178578bcd4 ("btrfs: directly call into crypto framework for checksumming")
Reported-by: syzbot+e864a35d361e1d4e29a5@syzkaller.appspotmail.com
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/disk-io.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 160b485d2cc0..28b962840972 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -587,15 +587,15 @@ static int btree_readpage_end_io_hook(struct btrfs_io_bio *io_bio,
 
 	if (memcmp_extent_buffer(eb, result, 0, csum_size)) {
 		u32 val;
-		u32 found = 0;
+		u8 found[BTRFS_CSUM_SIZE] = { };
 
 		memcpy(&found, result, csum_size);
 
 		read_extent_buffer(eb, &val, 0, csum_size);
 		btrfs_warn_rl(fs_info,
-		"%s checksum verify failed on %llu wanted %x found %x level %d",
+		"%s checksum verify failed on %llu wanted %x found %*pH level %d",
 			      fs_info->sb->s_id, eb->start,
-			      val, found, btrfs_header_level(eb));
+			      val, csum_size, found, btrfs_header_level(eb));
 		ret = -EUCLEAN;
 		goto err;
 	}
-- 
2.26.2

