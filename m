Return-Path: <linux-btrfs+bounces-11545-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FB4A3B1ED
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 08:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D7AE1894A3F
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 07:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1541BC077;
	Wed, 19 Feb 2025 07:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="R12W/4Tv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D64286285
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 07:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739948587; cv=none; b=avc9mDnwb5U9PistUBoiwLydOzzKXshY4elov40cfGeZSszVbyR3ttzFzTd+iuHFZljyzkYTJZsUYfeLacOVLmSBgtg4+77qx7ccqDQaCeE+LcXmAPugOMiLp2XrkTTaWizJzVGQCFcbpvny2bY4VMe4c/eCk2LHZifOtYS1I1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739948587; c=relaxed/simple;
	bh=+BNN4avmmHtfAZoJgaFc5EYptdLuuGs11fQMRwl7Rfw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M4JlmqScRjCehmLmCIjMYQ6h/JvaUwudh0MTu9yW4p3NMsfxxKbvIBKiBT/pJp7QZtPWJUEBTaxZXQYsKzMa/L9e2JnfWzXorrX6Ueo6Ba0J7kbckTn1xyaHT++TXpzMKEAi7wSpLsVGSe+mimi7D1pTSKBCD5HtxjeZBDEvG9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=R12W/4Tv; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1739948585; x=1771484585;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+BNN4avmmHtfAZoJgaFc5EYptdLuuGs11fQMRwl7Rfw=;
  b=R12W/4Tva4hyFnfeEOMRKyYNMQmANqh1U8lAVgDUpAElxn1mWKw1wk0i
   OQcAew6DHLWywmRJphnrdwyvuHleKhKbUZxhHBrhP+YZ2KfU2BSQqzuMm
   5I9nMp4rGxlMKStqrkiC3HxwtGkSgo6NsGv3Awig+qcv27vfuZZxY9tL7
   5bSqNO4jWGYOl3PuiM0G3XIIez7GMNhOI6z61S/AVjJo6CGVy+t98QjbS
   RQZJOc5nTX8u/lR1H6ZXbt84Q8UxKNDhkolD2JaxSAhgRyQ/dAkFh/Y7p
   /3ElyvEd+DKW6ksuZ02T/QbrBenKevip7levW4AA19JU5N4+nst1zpk4d
   w==;
X-CSE-ConnectionGUID: MNljp3SgTtaTtfY4ErVidg==
X-CSE-MsgGUID: sPZmT4caQl2gVCTCyzHeWg==
X-IronPort-AV: E=Sophos;i="6.13,298,1732550400"; 
   d="scan'208";a="38657556"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Feb 2025 15:03:04 +0800
IronPort-SDR: 67b5746e_s+Fdf479ZcycsxN80YjkpxCLaGR9rEua8nosetHD+nN7hNb
 3/R7c3QdtzyVMW84cwxWpRiW9jDCCFYvYuOO/Fg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Feb 2025 22:04:30 -0800
WDCIronportException: Internal
Received: from 5cg20343qs.ad.shared (HELO naota-xeon..) ([10.224.109.7])
  by uls-op-cesaip01.wdc.com with ESMTP; 18 Feb 2025 23:03:04 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: wqu@suse.com,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs: zoned: fix extent unlock in cow_file_range()
Date: Wed, 19 Feb 2025 16:02:11 +0900
Message-ID: <baa48c5a32ae079b218613cbdae175f2387cd745.1739948529.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Running generic/751 on the btrfs for-next often results in hung like
below. They are both stack by locking an extent. This suggests someone
forget to unlock an extent.

    INFO: task kworker/u128:1:12 blocked for more than 323 seconds.
          Not tainted 6.13.0-BTRFS-ZNS+ #503
    "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
    task:kworker/u128:1  state:D stack:0     pid:12    tgid:12    ppid:2      flags:0x00004000
    Workqueue: btrfs-fixup btrfs_work_helper [btrfs]
    Call Trace:
     <TASK>
     __schedule+0x534/0xdd0
     schedule+0x39/0x140
     __lock_extent+0x31b/0x380 [btrfs]
     ? __pfx_autoremove_wake_function+0x10/0x10
     btrfs_writepage_fixup_worker+0xf1/0x3a0 [btrfs]
     btrfs_work_helper+0xff/0x480 [btrfs]
     ? lock_release+0x178/0x2c0
     process_one_work+0x1ee/0x570
     ? srso_return_thunk+0x5/0x5f
     worker_thread+0x1d1/0x3b0
     ? __pfx_worker_thread+0x10/0x10
     kthread+0x10b/0x230
     ? __pfx_kthread+0x10/0x10
     ret_from_fork+0x30/0x50
     ? __pfx_kthread+0x10/0x10
     ret_from_fork_asm+0x1a/0x30
     </TASK>
    INFO: task kworker/u134:0:184 blocked for more than 323 seconds.
          Not tainted 6.13.0-BTRFS-ZNS+ #503
    "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
    task:kworker/u134:0  state:D stack:0     pid:184   tgid:184   ppid:2      flags:0x00004000
    Workqueue: writeback wb_workfn (flush-btrfs-4)
    Call Trace:
     <TASK>
     __schedule+0x534/0xdd0
     schedule+0x39/0x140
     __lock_extent+0x31b/0x380 [btrfs]
     ? __pfx_autoremove_wake_function+0x10/0x10
     find_lock_delalloc_range+0xdb/0x260 [btrfs]
     writepage_delalloc+0x12f/0x500 [btrfs]
     ? srso_return_thunk+0x5/0x5f
     extent_write_cache_pages+0x232/0x840 [btrfs]
     btrfs_writepages+0x72/0x130 [btrfs]
     do_writepages+0xe7/0x260
     ? srso_return_thunk+0x5/0x5f
     ? lock_acquire+0xd2/0x300
     ? srso_return_thunk+0x5/0x5f
     ? find_held_lock+0x2b/0x80
     ? wbc_attach_and_unlock_inode.part.0+0x102/0x250
     ? wbc_attach_and_unlock_inode.part.0+0x102/0x250
     __writeback_single_inode+0x5c/0x4b0
     writeback_sb_inodes+0x22d/0x550
     __writeback_inodes_wb+0x4c/0xe0
     wb_writeback+0x2f6/0x3f0
     wb_workfn+0x32a/0x510
     process_one_work+0x1ee/0x570
     ? srso_return_thunk+0x5/0x5f
     worker_thread+0x1d1/0x3b0
     ? __pfx_worker_thread+0x10/0x10
     kthread+0x10b/0x230
     ? __pfx_kthread+0x10/0x10
     ret_from_fork+0x30/0x50
     ? __pfx_kthread+0x10/0x10
     ret_from_fork_asm+0x1a/0x30
     </TASK>

This happens because we have another success path for the zoned mode. When
there is no active zone available, btrfs_reserve_extent() returns
-EAGAIN. In this case, we have two reactions. (1) If the given range is
never allocated, we can only wait for someone to finish a zone, so wait on
BTRFS_FS_NEED_ZONE_FINISH bit and retry afterward. (2) Or, if some
allocations are already done, we must bail out and let the caller to send
IOs for the allocation. This is because these IOs may be necessary to
finish a zone.

The commit 06f364284794 ("btrfs: do proper folio cleanup when
cow_file_range() failed") moved the unlock code from the inside of the loop
to the outside. So, previously, the allocated extents are unlocked just
after the allocation and so before returning from the function. However,
they are no longer unlocked on the case (2) above. That caused the hung
issue.

Fix the issue by modifying the 'end' to the end of the allocated
range. Then, we can exit the loop and the same unlock code can properly
handle the case.

Reported-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Tested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
CC: stable@vger.kernel.org
Fixes: 06f364284794 ("btrfs: do proper folio cleanup when cow_file_range() failed")
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/inode.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 1512eb94b6e5..f80db81fc853 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1378,8 +1378,14 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 				continue;
 			}
 			if (done_offset) {
-				*done_offset = start - 1;
-				return 0;
+				/*
+				 * Move @end to the end of the processed range,
+				 * and exit the loop to unlock the processed
+				 * extents.
+				 */
+				end = start - 1;
+				ret = 0;
+				break;
 			}
 			ret = -ENOSPC;
 		}
-- 
2.48.1


