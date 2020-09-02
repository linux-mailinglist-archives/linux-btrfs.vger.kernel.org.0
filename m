Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E225025A985
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Sep 2020 12:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgIBKeK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Sep 2020 06:34:10 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:9570 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgIBKeI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Sep 2020 06:34:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599042848; x=1630578848;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1r3l64X+k1+HSVkZBjpVtSaFgW78XEdHIv9JVny955Q=;
  b=n4TccVawJoLCTe+XEy63ItP1JHHSQt2GwxXoZ/guj4WGKxAd0EV0Bmdt
   Bt63vHpmBY29i0coyVQewBB2jCk3rF3MTKZpFFzmVhOI1OF/Qn+lReMEp
   OD3ivVoBUAW1AOMd9QUBUTA+unKseG4Me7vJgXlFj9GCrck1QDnoojm0C
   wT31u1YPeKwQiS1JOcTYOfaKLnXooD46tWbF7Jq6xgqnkL6bs9bOmSZNR
   UUuT8F59AgHJ0yZUuc95WGfbJsSS3N9DYTAOIo1u1GbnpBgPm2NQf/WMQ
   xqDLX0O1BZX4MrRjAzMGPDaI/UiFC3xYNz90e6g5ftSOV6fTwFpNNnZo0
   w==;
IronPort-SDR: c5Qhw6556Q05fUBXvDgY6DYgQ4Am71gIlVCNeACxjHHfCIJL4poYv934z8pqbJe/bDFx0HX/Ch
 czWBtuxwtN2/P4LQ3364Wqhyr9AYopgpkDD7ws+j9LYIdjiS3nV1gHzxCl64MNsCPMhrnWTXGS
 bgMgLQxFDak4ZgkfazkRjdiuYqDvBAhcne9JNN0bTeyLKanng2fARX0Z8gVRTu/piEyia6KuwA
 d19l6p3wkSQi1O8WllcYZLskuDSs25WyaCc7LeGm0xpOoOx63Qoab/IuF3RFiulOXlR1CX0LgJ
 +sI=
X-IronPort-AV: E=Sophos;i="5.76,381,1592841600"; 
   d="scan'208";a="147622439"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2020 18:33:51 +0800
IronPort-SDR: uUwpTROA098vgktg7CUkfQf2rZnCppl+PnUUlwGivfKxLuoTsM6L4Sl5whlDsPZ63c/vNI5F+Z
 lhkP9ccR2h9w==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2020 03:20:27 -0700
IronPort-SDR: 9igq7qnXbNkkSVswJpPe4CHnpBwqgY8Aq36+/G2yM/5+OyXAEp+MRSK0NDqMl7Ur60ut3nnEq8
 iMEZRK52osoQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Sep 2020 03:33:51 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@gmail.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2] btrfs: don't call btrfs_sync_file from iomap context
Date:   Wed,  2 Sep 2020 19:33:47 +0900
Message-Id: <20200902103347.32255-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fstests generic/113 exposes a deadlock introduced by the switch to iomap
for direct I/O.

 ============================================
 WARNING: possible recursive locking detected
 5.9.0-rc2+ #746 Not tainted
 --------------------------------------------
 aio-stress/922 is trying to acquire lock:
 ffff888217412010 (&sb->s_type->i_mutex_key#11){++++}-{3:3}, at: btrfs_sync_file+0xf7/0x560 [btrfs]

 but task is already holding lock:
 ffff888217412010 (&sb->s_type->i_mutex_key#11){++++}-{3:3}, at: btrfs_file_write_iter+0x6e/0x630 [btrfs]

 other info that might help us debug this:
 Possible unsafe locking scenario:

 CPU0
 ----
 lock(&sb->s_type->i_mutex_key#11);
 lock(&sb->s_type->i_mutex_key#11);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

 2 locks held by aio-stress/922:
 #0: ffff888217412010 (&sb->s_type->i_mutex_key#11){++++}-{3:3}, at: btrfs_file_write_iter+0x6e/0x630 [btrfs]
 #1: ffff888217411ea0 (&ei->dio_sem){++++}-{3:3}, at: btrfs_direct_IO+0x113/0x160 [btrfs]

 stack backtrace:
 CPU: 0 PID: 922 Comm: aio-stress Not tainted 5.9.0-rc2+ #746
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4-rebuilt.opensuse.org 04/01/2014
 Call Trace:
 dump_stack+0x78/0xa0
 __lock_acquire.cold+0x121/0x29f
 ? btrfs_dio_iomap_end+0x65/0x130 [btrfs]
 lock_acquire+0x93/0x3b0
 ? btrfs_sync_file+0xf7/0x560 [btrfs]
 down_write+0x33/0x70
 ? btrfs_sync_file+0xf7/0x560 [btrfs]
 btrfs_sync_file+0xf7/0x560 [btrfs]
 iomap_dio_complete+0x10d/0x120
 iomap_dio_rw+0x3c8/0x520
 btrfs_direct_IO+0xd3/0x160 [btrfs]
 btrfs_file_write_iter+0x1fe/0x630 [btrfs]
 ? find_held_lock+0x2b/0x80
 aio_write+0xcd/0x180
 ? __might_fault+0x31/0x80
 ? find_held_lock+0x2b/0x80
 ? __might_fault+0x31/0x80
 io_submit_one+0x4e1/0xb30
 ? find_held_lock+0x2b/0x80
 __x64_sys_io_submit+0x71/0x220
 do_syscall_64+0x33/0x40
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
 RIP: 0033:0x7f5940881f79
 Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e7 4e 0c 00 f7 d8 64 89 01 48
 RSP: 002b:00007f5934f51d88 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
 RAX: ffffffffffffffda RBX: 00007f5934f52680 RCX: 00007f5940881f79
 RDX: 0000000000b56030 RSI: 0000000000000008 RDI: 00007f593171f000
 RBP: 00007f593171f000 R08: 0000000000000000 R09: 0000000000b56030
 R10: 00007fffd599e080 R11: 0000000000000246 R12: 0000000000000008
 R13: 0000000000000000 R14: 0000000000b56030 R15: 0000000000b56070

This happens because iomap_dio_complete() calls into generic_write_sync()
if we have the data-sync flag set. But as we're still under the
inode_lock() from btrfs_file_write_iter() we will deadlock once
btrfs_sync_file() tries to acquire the inode_lock().

Calling into generic_write_sync() is not needed as __btrfs_direct_write()
already takes care of persisting the data on disk. We can temporarily drop
the IOCB_DSYNC flag before calling into __btrfs_direct_write() so the
iomap code won't try to call into the sync routines as well.

References: https://github.com/btrfs/fstests/issues/12
Fixes: da4d7c1b4c45 ("btrfs: switch to iomap for direct IO")
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

---
Changes to RFC:
- Re-apply IOCB_DSYNC before calling into generic_write_sync (Goldwyn)
---
 fs/btrfs/file.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index b62679382799..a963f80cadf2 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2023,6 +2023,12 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 		atomic_inc(&BTRFS_I(inode)->sync_writers);
 
 	if (iocb->ki_flags & IOCB_DIRECT) {
+		/*
+		 * Temporarily clear to IOCB_DSYNC flag for DIO, as it will
+		 * deadlock in btrfs_sync_file() otherwise. Drop again once we
+		 * have revisited locking around btrfs_sync_file().
+		 */
+		iocb->ki_flags &= ~IOCB_DSYNC;
 		num_written = __btrfs_direct_write(iocb, from);
 	} else {
 		num_written = btrfs_buffered_write(iocb, from);
@@ -2043,6 +2049,10 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 	spin_lock(&BTRFS_I(inode)->lock);
 	BTRFS_I(inode)->last_sub_trans = root->log_transid;
 	spin_unlock(&BTRFS_I(inode)->lock);
+
+	if (sync)
+		iocb->ki_flags |= IOCB_DSYNC;
+
 	if (num_written > 0)
 		num_written = generic_write_sync(iocb, num_written);
 
-- 
2.26.2

