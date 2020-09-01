Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE5F4258EE0
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Sep 2020 15:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgIANHp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Sep 2020 09:07:45 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:49432 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727910AbgIANHW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Sep 2020 09:07:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1598965642; x=1630501642;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=R5vLG+Fer0s+gqhGJKiaYJpQz37GLrwV5ObIf+f9sRc=;
  b=YRzZxTFioRq+ZQpgqlqhkDxyVT9TuO21WCyjTnL0EQCHYN3G+/1Patyc
   lSV/wXyT3ed3ea4wnV1XGZvRnN3xcaTb29pZpAioQ3YC2MqxkhpWKFVfr
   CpE7EdZYyuxdp9CRLm9Rjjh0GyGNCaxWUhF0h9/y9Ki4I5+15nT/z+xsv
   bC8MQYOcZCozeMucU0GFbq7U8vOuNgQ0tP1usC5/4HPrvUpSdrT13WuvZ
   vJ3eUEest3Gs/yDrvp88rP6zn0H8p040W+K1y+Z/C/ayRGREhytfHsPbX
   G2p5A9cuRhEyDTyO06gIzmoTPhQNUy++Gy/fcY8MCj4xyrLLgy9WAdH1w
   Q==;
IronPort-SDR: 0O8acYo+yUa9Y4WfTJgO9gnnMqtKOTkO7nsfsvLBpYy37sNEkFZ0MoxI7vKtYH73hWqunForQZ
 JRt+xZiXil6THB5pn3p3mEzW9zhuw9YjTtn1IyhnRY2UtX+08J9jbxElEQKqBhbiPppnqhkqYh
 +Oj6btIGsHlVTLjCQ3zgeNLhgs3QHOvste1Kx7Rcg9Ldb3xRTnAE4NfIZjhp0TWmv7XZJJwIF7
 4/esEM3+2FXd69rHcmygda55H40aIVBKqMGqEHN34Lh1uQ/CNrK+7dfAJT/f2OF/7bDhguTQoY
 Nks=
X-IronPort-AV: E=Sophos;i="5.76,379,1592841600"; 
   d="scan'208";a="146306336"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 01 Sep 2020 21:06:55 +0800
IronPort-SDR: ujkyuh1Jfpcym6m4YsXSNJj+btJ2MN77Qxw2Mf9iqHAvMNfrNU4ezMyJJmbxa1Wre/RezUvOjj
 RZU6TY5NstxQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 05:54:22 -0700
IronPort-SDR: qHi+4zaFjgyhFybniSpWm9pvKdrdsLy3Ur9p22OFTc8C1e1AlFsOcZw2RnG7lSn2HNTrpm3ugq
 w1RAbvPPt14w==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Sep 2020 06:06:54 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@gmail.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [RFC PATCH] btrfs: don't call btrfs_sync_file from iomap context
Date:   Tue,  1 Sep 2020 22:06:44 +0900
Message-Id: <20200901130644.12655-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fstests generic/113 exposes a deadlock introduced by the switch to iomap
for direct I/O.

[ 18.291293]
[ 18.291532] ============================================
[ 18.292115] WARNING: possible recursive locking detected
[ 18.292723] 5.9.0-rc2+ #746 Not tainted
[ 18.293145] --------------------------------------------
[ 18.293718] aio-stress/922 is trying to acquire lock:
[ 18.294274] ffff888217412010 (&sb->s_type->i_mutex_key#11){++++}-{3:3}, at: btrfs_sync_file+0xf7/0x560 [btrfs]
[ 18.295450]
[ 18.295450] but task is already holding lock:
[ 18.296086] ffff888217412010 (&sb->s_type->i_mutex_key#11){++++}-{3:3}, at: btrfs_file_write_iter+0x6e/0x630 [btrfs]
[ 18.297249]
[ 18.297249] other info that might help us debug this:
[ 18.297960] Possible unsafe locking scenario:
[ 18.297960]
[ 18.298605] CPU0
[ 18.298880] ----
[ 18.299151] lock(&sb->s_type->i_mutex_key#11);
[ 18.299653] lock(&sb->s_type->i_mutex_key#11);
[ 18.300156]
[ 18.300156] *** DEADLOCK ***
[ 18.300156]
[ 18.300802] May be due to missing lock nesting notation
[ 18.300802]
[ 18.301542] 2 locks held by aio-stress/922:
[ 18.302000] #0: ffff888217412010 (&sb->s_type->i_mutex_key#11){++++}-{3:3}, at: btrfs_file_write_iter+0x6e/0x630 [btrfs]
[ 18.303194] #1: ffff888217411ea0 (&ei->dio_sem){++++}-{3:3}, at: btrfs_direct_IO+0x113/0x160 [btrfs]
[ 18.304223]
[ 18.304223] stack backtrace:
[ 18.304695] CPU: 0 PID: 922 Comm: aio-stress Not tainted 5.9.0-rc2+ #746
[ 18.305383] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4-rebuilt.opensuse.org 04/01/2014
[ 18.306532] Call Trace:
[ 18.306796] dump_stack+0x78/0xa0
[ 18.307145] __lock_acquire.cold+0x121/0x29f
[ 18.307613] ? btrfs_dio_iomap_end+0x65/0x130 [btrfs]
[ 18.308140] lock_acquire+0x93/0x3b0
[ 18.308544] ? btrfs_sync_file+0xf7/0x560 [btrfs]
[ 18.309036] down_write+0x33/0x70
[ 18.309402] ? btrfs_sync_file+0xf7/0x560 [btrfs]
[ 18.309912] btrfs_sync_file+0xf7/0x560 [btrfs]
[ 18.310384] iomap_dio_complete+0x10d/0x120
[ 18.310824] iomap_dio_rw+0x3c8/0x520
[ 18.311225] btrfs_direct_IO+0xd3/0x160 [btrfs]
[ 18.311727] btrfs_file_write_iter+0x1fe/0x630 [btrfs]
[ 18.312264] ? find_held_lock+0x2b/0x80
[ 18.312662] aio_write+0xcd/0x180
[ 18.313011] ? __might_fault+0x31/0x80
[ 18.313408] ? find_held_lock+0x2b/0x80
[ 18.313817] ? __might_fault+0x31/0x80
[ 18.314217] io_submit_one+0x4e1/0xb30
[ 18.314606] ? find_held_lock+0x2b/0x80
[ 18.315010] __x64_sys_io_submit+0x71/0x220
[ 18.315449] do_syscall_64+0x33/0x40
[ 18.315829] entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 18.316363] RIP: 0033:0x7f5940881f79
[ 18.316740] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e7 4e 0c 00 f7 d8 64 89 01 48
[ 18.318651] RSP: 002b:00007f5934f51d88 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
[ 18.319428] RAX: ffffffffffffffda RBX: 00007f5934f52680 RCX: 00007f5940881f79
[ 18.320168] RDX: 0000000000b56030 RSI: 0000000000000008 RDI: 00007f593171f000
[ 18.320895] RBP: 00007f593171f000 R08: 0000000000000000 R09: 0000000000b56030
[ 18.321630] R10: 00007fffd599e080 R11: 0000000000000246 R12: 0000000000000008
[ 18.322369] R13: 0000000000000000 R14: 0000000000b56030 R15: 0000000000b56070

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
 fs/btrfs/file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index b62679382799..c75c0f2a5f72 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2023,6 +2023,7 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 		atomic_inc(&BTRFS_I(inode)->sync_writers);
 
 	if (iocb->ki_flags & IOCB_DIRECT) {
+		iocb->ki_flags &= ~IOCB_DSYNC;
 		num_written = __btrfs_direct_write(iocb, from);
 	} else {
 		num_written = btrfs_buffered_write(iocb, from);
@@ -2046,8 +2047,10 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 	if (num_written > 0)
 		num_written = generic_write_sync(iocb, num_written);
 
-	if (sync)
+	if (sync) {
+		iocb->ki_flags |= IOCB_DSYNC;
 		atomic_dec(&BTRFS_I(inode)->sync_writers);
+	}
 out:
 	current->backing_dev_info = NULL;
 	return num_written ? num_written : err;
-- 
2.26.2

