Return-Path: <linux-btrfs+bounces-15780-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D8BB16AF6
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Jul 2025 05:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 615A1561113
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Jul 2025 03:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EC4211A27;
	Thu, 31 Jul 2025 03:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GobJwWDD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD931CAA4
	for <linux-btrfs@vger.kernel.org>; Thu, 31 Jul 2025 03:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753933730; cv=none; b=DshB/ShSkJoczm3wXUr3XI32dWBQQeltA7zK82nE9prlYqrr/2QiJOdpfYq9hjgkj3JB8z27KMLpNtl0IYVlcxmmTZUne8GOn44jpr64hkWs66+3r2B08p2V7UdZpc5Efhsb/sq7Stc8it/c3wbCy9CtaLlY2TwKAguibwR1Gjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753933730; c=relaxed/simple;
	bh=33HAvAkh50reUi8JOC/s+Amu+8x8TvSjVLaB8tdig2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OlJH5Pm73Dj6qzDX8TE4KvsQDxCz8/aKuZSMm1O8i1NHTC5KMH8viPyQXWM9lXqEEvilCI/O4hKFSLqKJY9rOEEp1rqxTH7p6aDEUDcrq9KWA4FrPyRHuR8c2XgahpTqq/rr82A42lMazmS+qidxmh8QrqFQuaUyO3xlXaJ0Ah0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=GobJwWDD; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1753933729; x=1785469729;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=33HAvAkh50reUi8JOC/s+Amu+8x8TvSjVLaB8tdig2Q=;
  b=GobJwWDDXbLUoVcm8eWKtKL/0BTsW8vrEccKVXtSLwG46HMxtBi109XU
   0jho33BPFkOzXcFZabaQgNGjYx7sFW9XsQCrwqT0Yq64NgCM2VkpRdyjx
   4dgg1APdgebQJJ6lGxW0dCI8kaMQx4ubR+NdpitRz/k6I4R7wh6uDI6ZB
   CvBXM1RQ7jvn5ADl+Oai1dpnZ8GQngUtH/PwSZmMgJYHoTKozvlyxkEa/
   9Yf3GvPQpiw1l/8vUuJFPtOo/UXXSXsmKbwqfP7ZHQ9ZSt2QrtHbsyTDD
   LHjaBZIGUr5KS/VmP5GdcYFL0bMDe86SrTGygyrvVBbzxjtU7B/1gjaAC
   Q==;
X-CSE-ConnectionGUID: efdrxhRuQAmIxak5qfg5Ig==
X-CSE-MsgGUID: N8I64QN6QkSWuFlmoKKmkg==
X-IronPort-AV: E=Sophos;i="6.16,353,1744041600"; 
   d="scan'208";a="107207871"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 31 Jul 2025 11:47:39 +0800
IronPort-SDR: 688ad8a1_oF9KfoTT//0xmfzSdtlp8Ig4Ex5ounPb0bvVzyAVk3z0HsU
 oOSulW5uTV3WyYLWq1nXOdIS4nmPEHiGbC9v26w==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jul 2025 19:44:50 -0700
WDCIronportException: Internal
Received: from 5cg2148fr4.ad.shared (HELO naota-xeon) ([10.224.173.92])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Jul 2025 20:47:39 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: wqu@suse.com,
	Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2] btrfs: subpage: keep TOWRITE tag until folio is cleaned
Date: Thu, 31 Jul 2025 12:46:56 +0900
Message-ID: <20250731034656.1386451-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

btrfs_subpage_set_writeback() calls folio_start_writeback() the first time
a folio is written back, and it also clears the PAGECACHE_TAG_TOWRITE tag
even if there are still dirty blocks in the folio. This can break ordering
guarantees, such as those required by btrfs_wait_ordered_extents().

That ordering breakage leads to a real failure. For example, running
generic/464 on a zoned setup will hit the following ASSERT. This happens
because the broken ordering fails to flush existing dirty pages before the
file size is truncated.

   assertion failed: !list_empty(&ordered->list) :: 0, in fs/btrfs/zoned.c:1899
   ------------[ cut here ]------------
   kernel BUG at fs/btrfs/zoned.c:1899!
   Oops: invalid opcode: 0000 [#1] SMP NOPTI
   CPU: 2 UID: 0 PID: 1906169 Comm: kworker/u130:2 Kdump: loaded Not tainted 6.16.0-rc6-BTRFS-ZNS+ #554 PREEMPT(voluntary)
   Hardware name: Supermicro Super Server/H12SSL-NT, BIOS 2.0 02/22/2021
   Workqueue: btrfs-endio-write btrfs_work_helper [btrfs]
   RIP: 0010:btrfs_finish_ordered_zoned.cold+0x50/0x52 [btrfs]
   RSP: 0018:ffffc9002efdbd60 EFLAGS: 00010246
   RAX: 000000000000004c RBX: ffff88811923c4e0 RCX: 0000000000000000
   RDX: 0000000000000000 RSI: ffffffff827e38b1 RDI: 00000000ffffffff
   RBP: ffff88810005d000 R08: 00000000ffffdfff R09: ffffffff831051c8
   R10: ffffffff83055220 R11: 0000000000000000 R12: ffff8881c2458c00
   R13: ffff88811923c540 R14: ffff88811923c5e8 R15: ffff8881c1bd9680
   FS:  0000000000000000(0000) GS:ffff88a04acd0000(0000) knlGS:0000000000000000
   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
   CR2: 00007f907c7a918c CR3: 0000000004024000 CR4: 0000000000350ef0
   Call Trace:
    <TASK>
    ? srso_return_thunk+0x5/0x5f
    btrfs_finish_ordered_io+0x4a/0x60 [btrfs]
    btrfs_work_helper+0xf9/0x490 [btrfs]
    process_one_work+0x204/0x590
    ? srso_return_thunk+0x5/0x5f
    worker_thread+0x1d6/0x3d0
    ? __pfx_worker_thread+0x10/0x10
    kthread+0x118/0x230
    ? __pfx_kthread+0x10/0x10
    ret_from_fork+0x205/0x260
    ? __pfx_kthread+0x10/0x10
    ret_from_fork_asm+0x1a/0x30
    </TASK>

Consider process A calling writepages() with WB_SYNC_NONE. In zoned mode or
for compressed writes, it locks several folios for delalloc and starts
writing them out. Let's call the last locked folio folio X. Suppose the
write range only partially covers folio X, leaving some pages dirty.
Process A calls btrfs_subpage_set_writeback() when building a bio. This
function call clears the TOWRITE tag of folio X, whose size = 8K and
the block size = 4K. It is following state.

   0     4K    8K
   |/////|/////|  (flag: DIRTY, tag: DIRTY)
   <-----> Process A will write this range.

Now suppose process B concurrently calls writepages() with WB_SYNC_ALL. It
calls tag_pages_for_writeback() to tag dirty folios with
PAGECACHE_TAG_TOWRITE. Since folio X is still dirty, it gets tagged. Then,
B collects tagged folios using filemap_get_folios_tag() and must wait for
folio X to be written before returning from writepages().

   0     4K    8K
   |/////|/////|  (flag: DIRTY, tag: DIRTY|TOWRITE)

However, between tagging and collecting, process A may call
btrfs_subpage_set_writeback() and clear folio X’s TOWRITE tag.
   0     4K    8K
   |     |/////|  (flag: DIRTY|WRITEBACK, tag: DIRTY)

As a result, process B won’t see folio X in its batch, and returns without
waiting for it. This breaks the WB_SYNC_ALL ordering requirement.

Fix this by using btrfs_subpage_set_writeback_keepwrite(), which retains
the TOWRITE tag. We now manually clear the tag only after the folio becomes
clean, via the xas operation.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Fixes: 3470da3b7d87 ("btrfs: subpage: introduce helpers for writeback status")
CC: stable@vger.kernel.org # 6.12+
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

---
- v2:
  - Add ASCII chart and real failure example for better description.
  - Change the Fixes tag.
---
 fs/btrfs/subpage.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index c9b3821957f7..67cbf0b15b4a 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -448,8 +448,25 @@ void btrfs_subpage_set_writeback(const struct btrfs_fs_info *fs_info,
 
 	spin_lock_irqsave(&bfs->lock, flags);
 	bitmap_set(bfs->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
+
+	/*
+	 * Don't clear the TOWRITE tag when starting writeback on a still-dirty
+	 * folio. Doing so can cause WB_SYNC_ALL writepages() to overlook it,
+	 * assume writeback is complete, and exit too early — violating sync
+	 * ordering guarantees.
+	 */
 	if (!folio_test_writeback(folio))
-		folio_start_writeback(folio);
+		folio_start_writeback_keepwrite(folio);
+	if (!folio_test_dirty(folio)) {
+		struct address_space *mapping = folio_mapping(folio);
+		XA_STATE(xas, &mapping->i_pages, folio->index);
+		unsigned long flags;
+
+		xas_lock_irqsave(&xas, flags);
+		xas_load(&xas);
+		xas_clear_mark(&xas, PAGECACHE_TAG_TOWRITE);
+		xas_unlock_irqrestore(&xas, flags);
+	}
 	spin_unlock_irqrestore(&bfs->lock, flags);
 }
 
-- 
2.50.1


