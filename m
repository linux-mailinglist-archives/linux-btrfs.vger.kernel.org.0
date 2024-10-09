Return-Path: <linux-btrfs+bounces-8735-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6229970F5
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 18:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99D5D284367
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 16:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB511E7C24;
	Wed,  9 Oct 2024 15:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ctvLwk6F"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9D41E1027
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 15:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728489491; cv=none; b=m7DJkqSBS/TzkTvA28X0WLEMslbSPDzb2x21H+leHgnsnqPP+Y2qZJb1sVyvoP2PjspqHwZI2x0Tyh58HWcgZan3hepotEmdz8LVUJ5OzDrW0jqoze4UDs48nOZK5VKxNieuReXyvHndjn24vDbG539uxlEJIVahmZ4uKYmLE9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728489491; c=relaxed/simple;
	bh=oV9nLqNnwpIifdT6P+NpV+2c/Wl3xGGVf1EIgcuk9lc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XeDxsMeUCusw/M4JZxTe17Z3aj9o9UxQqwpQndWwiFjb0oWQosHzUVwUWYc7bhqIN+ykfj6DBoGsN6Xv7yyRvRrbV+yWNpTdGgm+o+S7znKGW3KsU1Vab1ayjmv2YPRKzzoVqEsIN9ADjjkalaJqwWjrgMtZ3T4ysxpzv2yV5D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ctvLwk6F; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1728489488; x=1760025488;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oV9nLqNnwpIifdT6P+NpV+2c/Wl3xGGVf1EIgcuk9lc=;
  b=ctvLwk6FziEGWkVEHtF27ciVWeBPe2nyxPIRXGmki/rNp5yup/PRRFQA
   60UmafaNePQku0O/JmAmLKbxKu7qEdK2v7o+1loHAQM+J+pWpFT4KQxHN
   CP4RRzKSLHbAPFhmmxmss/qIhOF/0/Bod7SPE++q45NTuixW6s0RZU+uA
   +uFJerCQ5pebWDxxujNzPvBfCV3/U6IbTkmhUszAZa0zwjuVPy5h7Nr95
   /9RN17oUIgaxrPu1J7bKLL/YlaY2H3gd4nYyGhsLfhPI0QPVsqWnXFzHR
   FMKxQUPbidFGrhSdI6sR+lKivcdDvZhM5Eso9R7HcJWCYl0ow/QY3obLP
   w==;
X-CSE-ConnectionGUID: pAKC/5VoRXCmU26AGYZdTg==
X-CSE-MsgGUID: Qp8uOq2USfeHs0CyHieo2Q==
X-IronPort-AV: E=Sophos;i="6.11,190,1725292800"; 
   d="scan'208";a="28611348"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Oct 2024 23:58:02 +0800
IronPort-SDR: 670699c1_SQUIhlRdqVa5zU7Idob+YeTeBntHFtX2gq7dSjHl2+nVBAG
 XbuJ034WJQj30Tuzp7ZAgaQOWnV7ApZrMpdbdrw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Oct 2024 07:57:06 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.13])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Oct 2024 08:58:01 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: wqu@suse.com,
	hch@lst.de,
	Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs: fix error propagation of split bios
Date: Thu, 10 Oct 2024 00:57:50 +0900
Message-ID: <db5c272fc27c59ddded5c691373c26458698cb1a.1728489285.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The purpose of btrfs_bbio_propagate_error() shall be propagating an error
of split bio to its original btrfs_bio, and tell the error to the upper
layer. However, it's not working well on some cases.

* Case 1. Immediate (or quick) end_bio with an error

When btrfs sends btrfs_bio to mirrored devices, btrfs calls
btrfs_bio_end_io() when all the mirroring bios are completed. If that
btrfs_bio was split, it is from btrfs_clone_bioset and its end_io function
is btrfs_orig_write_end_io. For this case, btrfs_bbio_propagate_error()
accesses the orig_bbio's bio context to increase the error count.

That works well in most cases. However, if the end_io is called enough
fast, orig_bbio's bio context may not be properly set at that time. Since
the bio context is set when the orig_bbio (the last btrfs_bio) is sent to
devices, that might be too late for earlier split btrfs_bio's completion.
That will result in NULL pointer dereference.

That bug is easily reproducible by running btrfs/146 on zoned devices and
it shows the following trace.

    [   20.923980][   T13] BUG: kernel NULL pointer dereference, address: 0000000000000020
    [   20.925234][   T13] #PF: supervisor read access in kernel mode
    [   20.926122][   T13] #PF: error_code(0x0000) - not-present page
    [   20.927118][   T13] PGD 0 P4D 0
    [   20.927607][   T13] Oops: Oops: 0000 [#1] PREEMPT SMP PTI
    [   20.928424][   T13] CPU: 1 UID: 0 PID: 13 Comm: kworker/u32:1 Not tainted 6.11.0-rc7-BTRFS-ZNS+ #474
    [   20.929740][   T13] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
    [   20.930697][   T13] Workqueue: writeback wb_workfn (flush-btrfs-5)
    [   20.931643][   T13] RIP: 0010:btrfs_bio_end_io+0xae/0xc0 [btrfs]
    [   20.932573][ T1415] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs: wr 2, rd 0, flush 0, corrupt 0, gen 0
    [   20.932871][   T13] Code: ba e1 48 8b 7b 10 e8 f1 f5 f6 ff eb da 48 81 bf 10 01 00 00 40 0c 33 a0 74 09 40 88 b5 f1 00 00 00 eb b8 48 8b 85 18 01 00 00 <48> 8b 40 20 0f b7 50 24 f0 01 50 20 eb a3 0f 1f 40 00 90 90 90 90
    [   20.936623][   T13] RSP: 0018:ffffc9000006f248 EFLAGS: 00010246
    [   20.937543][   T13] RAX: 0000000000000000 RBX: ffff888005a7f080 RCX: ffffc9000006f1dc
    [   20.938788][   T13] RDX: 0000000000000000 RSI: 000000000000000a RDI: ffff888005a7f080
    [   20.940016][   T13] RBP: ffff888011dfc540 R08: 0000000000000000 R09: 0000000000000001
    [   20.941227][   T13] R10: ffffffff82e508e0 R11: 0000000000000005 R12: ffff88800ddfbe58
    [   20.942375][   T13] R13: ffff888005a7f080 R14: ffff888005a7f158 R15: ffff888005a7f158
    [   20.943531][   T13] FS:  0000000000000000(0000) GS:ffff88803ea80000(0000) knlGS:0000000000000000
    [   20.944838][   T13] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    [   20.945811][   T13] CR2: 0000000000000020 CR3: 0000000002e22006 CR4: 0000000000370ef0
    [   20.946984][   T13] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
    [   20.948150][   T13] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
    [   20.949327][   T13] Call Trace:
    [   20.949949][   T13]  <TASK>
    [   20.950374][   T13]  ? __die_body.cold+0x19/0x26
    [   20.951066][   T13]  ? page_fault_oops+0x13e/0x2b0
    [   20.951766][   T13]  ? _printk+0x58/0x73
    [   20.952358][   T13]  ? do_user_addr_fault+0x5f/0x750
    [   20.953120][   T13]  ? exc_page_fault+0x76/0x240
    [   20.953827][   T13]  ? asm_exc_page_fault+0x22/0x30
    [   20.954606][   T13]  ? btrfs_bio_end_io+0xae/0xc0 [btrfs]
    [   20.955616][   T13]  ? btrfs_log_dev_io_error+0x7f/0x90 [btrfs]
    [   20.956682][   T13]  btrfs_orig_write_end_io+0x51/0x90 [btrfs]
    [   20.957769][   T13]  dm_submit_bio+0x5c2/0xa50 [dm_mod]
    [   20.958623][   T13]  ? find_held_lock+0x2b/0x80
    [   20.959339][   T13]  ? blk_try_enter_queue+0x90/0x1e0
    [   20.960228][   T13]  __submit_bio+0xe0/0x130
    [   20.960879][   T13]  ? ktime_get+0x10a/0x160
    [   20.961546][   T13]  ? lockdep_hardirqs_on+0x74/0x100
    [   20.962310][   T13]  submit_bio_noacct_nocheck+0x199/0x410
    [   20.963140][   T13]  btrfs_submit_bio+0x7d/0x150 [btrfs]
    [   20.964089][   T13]  btrfs_submit_chunk+0x1a1/0x6d0 [btrfs]
    [   20.965066][   T13]  ? lockdep_hardirqs_on+0x74/0x100
    [   20.965824][   T13]  ? __folio_start_writeback+0x10/0x2c0
    [   20.966659][   T13]  btrfs_submit_bbio+0x1c/0x40 [btrfs]
    [   20.967617][   T13]  submit_one_bio+0x44/0x60 [btrfs]
    [   20.968536][   T13]  submit_extent_folio+0x13f/0x330 [btrfs]
    [   20.969552][   T13]  ? btrfs_set_range_writeback+0xa3/0xd0 [btrfs]
    [   20.970625][   T13]  extent_writepage_io+0x18b/0x360 [btrfs]
    [   20.971632][   T13]  extent_write_locked_range+0x17c/0x340 [btrfs]
    [   20.972702][   T13]  ? __pfx_end_bbio_data_write+0x10/0x10 [btrfs]
    [   20.973857][   T13]  run_delalloc_cow+0x71/0xd0 [btrfs]
    [   20.974841][   T13]  btrfs_run_delalloc_range+0x176/0x500 [btrfs]
    [   20.975870][   T13]  ? find_lock_delalloc_range+0x119/0x260 [btrfs]
    [   20.976911][   T13]  writepage_delalloc+0x2ab/0x480 [btrfs]
    [   20.977792][   T13]  extent_write_cache_pages+0x236/0x7d0 [btrfs]
    [   20.978728][   T13]  btrfs_writepages+0x72/0x130 [btrfs]
    [   20.979531][   T13]  do_writepages+0xd4/0x240
    [   20.980111][   T13]  ? find_held_lock+0x2b/0x80
    [   20.980695][   T13]  ? wbc_attach_and_unlock_inode+0x12c/0x290
    [   20.981461][   T13]  ? wbc_attach_and_unlock_inode+0x12c/0x290
    [   20.982213][   T13]  __writeback_single_inode+0x5c/0x4c0
    [   20.982859][   T13]  ? do_raw_spin_unlock+0x49/0xb0
    [   20.983439][   T13]  writeback_sb_inodes+0x22c/0x560
    [   20.984079][   T13]  __writeback_inodes_wb+0x4c/0xe0
    [   20.984886][   T13]  wb_writeback+0x1d6/0x3f0
    [   20.985536][   T13]  wb_workfn+0x334/0x520
    [   20.986044][   T13]  process_one_work+0x1ee/0x570
    [   20.986580][   T13]  ? lock_is_held_type+0xc6/0x130
    [   20.987142][   T13]  worker_thread+0x1d1/0x3b0
    [   20.987918][   T13]  ? __pfx_worker_thread+0x10/0x10
    [   20.988690][   T13]  kthread+0xee/0x120
    [   20.989180][   T13]  ? __pfx_kthread+0x10/0x10
    [   20.989915][   T13]  ret_from_fork+0x30/0x50
    [   20.990615][   T13]  ? __pfx_kthread+0x10/0x10
    [   20.991336][   T13]  ret_from_fork_asm+0x1a/0x30
    [   20.992106][   T13]  </TASK>
    [   20.992482][   T13] Modules linked in: dm_mod btrfs blake2b_generic xor raid6_pq rapl
    [   20.993406][   T13] CR2: 0000000000000020
    [   20.993884][   T13] ---[ end trace 0000000000000000 ]---
    [   20.993954][ T1415] BUG: kernel NULL pointer dereference, address: 0000000000000020

* Case 2. Earlier completion of orig_bbio for mirrored btrfs_bios

btrfs_bbio_propagate_error() assumes the end_io function for orig_bbio is
called last among split bios. In that case, btrfs_orig_write_end_io() sets
the bio->bi_status to BLK_STS_IOERR by seeing the bioc->error [1].
Otherwise, the increased orig_bio's bioc->error is not checked by anyone
and return BLK_STS_OK to the upper layer.

[1] Actually, this is not true. Because we only increases orig_bioc->errors
by max_errors, the condition "atomic_read(&bioc->error) > bioc->max_errors"
is still not met if only one split btrfs_bio fails.

* Case 3. Later completion of orig_bbio for un-mirrored btrfs_bios

In contrast to the above case, btrfs_bbio_propagate_error() is not working
well if un-mirrored orig_bbio is completed last. It sets
orig_bbio->bio.bi_status to the btrfs_bio's error. But, that is easily
over-written by orig_bbio's completion status. If the status is BLK_STS_OK,
the upper layer would not know the failure.

* Solution

Considering the above cases, we can only save the error status in the
orig_bbio itself as it is always available. Also, the saved error status
should be propagated when all the split btrfs_bios are finished (i.e,
bbio->pending_ios == 0).

This commit introduces "status" to btrfs_bbio and uses the last saved error
status for bbio->bio.bi_status.

With this commit, btrfs/146 on zoned devices does not hit the NULL pointer
dereference.

Fixes: 852eee62d31a ("btrfs: allow btrfs_submit_bio to split bios")
CC: stable@vger.kernel.org # 6.6+
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/bio.c | 33 +++++++++------------------------
 fs/btrfs/bio.h |  3 +++
 2 files changed, 12 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 056f8a171bba..a43d88bdcae7 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -49,6 +49,7 @@ void btrfs_bio_init(struct btrfs_bio *bbio, struct btrfs_fs_info *fs_info,
 	bbio->end_io = end_io;
 	bbio->private = private;
 	atomic_set(&bbio->pending_ios, 1);
+	atomic_set(&bbio->status, BLK_STS_OK);
 }
 
 /*
@@ -120,41 +121,25 @@ static void __btrfs_bio_end_io(struct btrfs_bio *bbio)
 	}
 }
 
-static void btrfs_orig_write_end_io(struct bio *bio);
-
-static void btrfs_bbio_propagate_error(struct btrfs_bio *bbio,
-				       struct btrfs_bio *orig_bbio)
-{
-	/*
-	 * For writes we tolerate nr_mirrors - 1 write failures, so we can't
-	 * just blindly propagate a write failure here.  Instead increment the
-	 * error count in the original I/O context so that it is guaranteed to
-	 * be larger than the error tolerance.
-	 */
-	if (bbio->bio.bi_end_io == &btrfs_orig_write_end_io) {
-		struct btrfs_io_stripe *orig_stripe = orig_bbio->bio.bi_private;
-		struct btrfs_io_context *orig_bioc = orig_stripe->bioc;
-
-		atomic_add(orig_bioc->max_errors, &orig_bioc->error);
-	} else {
-		orig_bbio->bio.bi_status = bbio->bio.bi_status;
-	}
-}
-
 void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
 {
 	bbio->bio.bi_status = status;
 	if (bbio->bio.bi_pool == &btrfs_clone_bioset) {
 		struct btrfs_bio *orig_bbio = bbio->private;
 
-		if (bbio->bio.bi_status)
-			btrfs_bbio_propagate_error(bbio, orig_bbio);
+		/* Save the last error. */
+		if (bbio->bio.bi_status != BLK_STS_OK)
+			atomic_set(&orig_bbio->status, bbio->bio.bi_status);
 		btrfs_cleanup_bio(bbio);
 		bbio = orig_bbio;
 	}
 
-	if (atomic_dec_and_test(&bbio->pending_ios))
+	if (atomic_dec_and_test(&bbio->pending_ios)) {
+		/* Load split bio's error which might be set above. */
+		if (status == BLK_STS_OK)
+			bbio->bio.bi_status = atomic_read(&bbio->status);
 		__btrfs_bio_end_io(bbio);
+	}
 }
 
 static int next_repair_mirror(struct btrfs_failed_bio *fbio, int cur_mirror)
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index e48612340745..b8f7f6071bc2 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -79,6 +79,9 @@ struct btrfs_bio {
 	/* File system that this I/O operates on. */
 	struct btrfs_fs_info *fs_info;
 
+	/* Set the error status of split bio. */
+	atomic_t status;
+
 	/*
 	 * This member must come last, bio_alloc_bioset will allocate enough
 	 * bytes for entire btrfs_bio but relies on bio being last.
-- 
2.46.2


