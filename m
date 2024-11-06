Return-Path: <linux-btrfs+bounces-9345-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBB69BDBE1
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Nov 2024 03:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE4611C22E6A
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Nov 2024 02:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D7418FDBA;
	Wed,  6 Nov 2024 02:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NaY/q0bA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DFF18FDB2;
	Wed,  6 Nov 2024 02:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730858940; cv=none; b=F3N0wzW7g4Xlm6svSvwQkDQswS6Zhc3VKTrSK10p7ptCxjbPMsY/gM7Uf2YQNtsG8hDeuBlt5CWwuxnl6jNXtEnpMks3rCbQ/re1G0zylxjLNetyAjNP5VpThuPSWHfXgSCVrS5to5fuJsAFuJhnPNvRJy/LnwgmO8bYo3vpApU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730858940; c=relaxed/simple;
	bh=op6QI+fsYV8w5cPICVAzlKeUzGRqLXvjFmRyKCwaxJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=erUD+nHuo5aFjVbB8/RQjFanYhloZYYkqIj8y/LyGwuETqkgVDdbtkjusoees4e1mfQoFNmU7ZyIlI6ZDkeFR0ScSZl9P3w+ZAh6Yq7eH7rYYP+UeZnOejzL1GQQOWOi1HhGq4w2pmdnFm+rm/oJ0YLH9/wVLPnpaMURKhKz1Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NaY/q0bA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 338F0C4CECF;
	Wed,  6 Nov 2024 02:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730858940;
	bh=op6QI+fsYV8w5cPICVAzlKeUzGRqLXvjFmRyKCwaxJ0=;
	h=From:To:Cc:Subject:Date:From;
	b=NaY/q0bAgrSDQdS8040x7eNMYDkeinYMpVpQKme2XCwNw5bsoL3oKFMZcMbdIKVSu
	 6d8iOQwz63uLuN0zE00OwwgBLO1i4kMPzGgax2A1oaldp1tQFHob/6VGCuIjBmNEDj
	 HoYKdn29AlEORUqX1f+YF3nwMOhOU1x7iEwMNIFjTwrK0cvfAvDR/CS77zAb8ELhKr
	 sqnPn9puZ8XkyahJnSDawLBgSH6/qKwwuZMszjeHhpzA4btfn6/GW3zrYc1C7vwkqh
	 Bw2VE8p/wE2xxkcl1o1Dv8emIZUYLJxZxYRJidrPqZwy0ybE13/tthwowdHgyQBbIS
	 QIEIH4FpV9wEQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	naohiro.aota@wdc.com
Cc: Qu Wenruo <wqu@suse.com>,
	Christoph Hellwig <hch@lst.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "btrfs: fix error propagation of split bios" failed to apply to v6.6-stable tree
Date: Tue,  5 Nov 2024 21:08:56 -0500
Message-ID: <20241106020857.164572-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the v6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From d48e1dea3931de64c26717adc2b89743c7ab6594 Mon Sep 17 00:00:00 2001
From: Naohiro Aota <naohiro.aota@wdc.com>
Date: Wed, 9 Oct 2024 22:52:06 +0900
Subject: [PATCH] btrfs: fix error propagation of split bios

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
fast, orig_bbio's (remaining part after split) bio context may not be
properly set at that time. Since the bio context is set when the orig_bbio
(the last btrfs_bio) is sent to devices, that might be too late for earlier
split btrfs_bio's completion.  That will result in NULL pointer
dereference.

That bug is easily reproducible by running btrfs/146 on zoned devices [1]
and it shows the following trace.

[1] You need raid-stripe-tree feature as it create "-d raid0 -m raid1" FS.

  BUG: kernel NULL pointer dereference, address: 0000000000000020
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 0 P4D 0
  Oops: Oops: 0000 [#1] PREEMPT SMP PTI
  CPU: 1 UID: 0 PID: 13 Comm: kworker/u32:1 Not tainted 6.11.0-rc7-BTRFS-ZNS+ #474
  Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
  Workqueue: writeback wb_workfn (flush-btrfs-5)
  RIP: 0010:btrfs_bio_end_io+0xae/0xc0 [btrfs]
  BTRFS error (device dm-0): bdev /dev/mapper/error-test errs: wr 2, rd 0, flush 0, corrupt 0, gen 0
  RSP: 0018:ffffc9000006f248 EFLAGS: 00010246
  RAX: 0000000000000000 RBX: ffff888005a7f080 RCX: ffffc9000006f1dc
  RDX: 0000000000000000 RSI: 000000000000000a RDI: ffff888005a7f080
  RBP: ffff888011dfc540 R08: 0000000000000000 R09: 0000000000000001
  R10: ffffffff82e508e0 R11: 0000000000000005 R12: ffff88800ddfbe58
  R13: ffff888005a7f080 R14: ffff888005a7f158 R15: ffff888005a7f158
  FS:  0000000000000000(0000) GS:ffff88803ea80000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000000000020 CR3: 0000000002e22006 CR4: 0000000000370ef0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  Call Trace:
   <TASK>
   ? __die_body.cold+0x19/0x26
   ? page_fault_oops+0x13e/0x2b0
   ? _printk+0x58/0x73
   ? do_user_addr_fault+0x5f/0x750
   ? exc_page_fault+0x76/0x240
   ? asm_exc_page_fault+0x22/0x30
   ? btrfs_bio_end_io+0xae/0xc0 [btrfs]
   ? btrfs_log_dev_io_error+0x7f/0x90 [btrfs]
   btrfs_orig_write_end_io+0x51/0x90 [btrfs]
   dm_submit_bio+0x5c2/0xa50 [dm_mod]
   ? find_held_lock+0x2b/0x80
   ? blk_try_enter_queue+0x90/0x1e0
   __submit_bio+0xe0/0x130
   ? ktime_get+0x10a/0x160
   ? lockdep_hardirqs_on+0x74/0x100
   submit_bio_noacct_nocheck+0x199/0x410
   btrfs_submit_bio+0x7d/0x150 [btrfs]
   btrfs_submit_chunk+0x1a1/0x6d0 [btrfs]
   ? lockdep_hardirqs_on+0x74/0x100
   ? __folio_start_writeback+0x10/0x2c0
   btrfs_submit_bbio+0x1c/0x40 [btrfs]
   submit_one_bio+0x44/0x60 [btrfs]
   submit_extent_folio+0x13f/0x330 [btrfs]
   ? btrfs_set_range_writeback+0xa3/0xd0 [btrfs]
   extent_writepage_io+0x18b/0x360 [btrfs]
   extent_write_locked_range+0x17c/0x340 [btrfs]
   ? __pfx_end_bbio_data_write+0x10/0x10 [btrfs]
   run_delalloc_cow+0x71/0xd0 [btrfs]
   btrfs_run_delalloc_range+0x176/0x500 [btrfs]
   ? find_lock_delalloc_range+0x119/0x260 [btrfs]
   writepage_delalloc+0x2ab/0x480 [btrfs]
   extent_write_cache_pages+0x236/0x7d0 [btrfs]
   btrfs_writepages+0x72/0x130 [btrfs]
   do_writepages+0xd4/0x240
   ? find_held_lock+0x2b/0x80
   ? wbc_attach_and_unlock_inode+0x12c/0x290
   ? wbc_attach_and_unlock_inode+0x12c/0x290
   __writeback_single_inode+0x5c/0x4c0
   ? do_raw_spin_unlock+0x49/0xb0
   writeback_sb_inodes+0x22c/0x560
   __writeback_inodes_wb+0x4c/0xe0
   wb_writeback+0x1d6/0x3f0
   wb_workfn+0x334/0x520
   process_one_work+0x1ee/0x570
   ? lock_is_held_type+0xc6/0x130
   worker_thread+0x1d1/0x3b0
   ? __pfx_worker_thread+0x10/0x10
   kthread+0xee/0x120
   ? __pfx_kthread+0x10/0x10
   ret_from_fork+0x30/0x50
   ? __pfx_kthread+0x10/0x10
   ret_from_fork_asm+0x1a/0x30
   </TASK>
  Modules linked in: dm_mod btrfs blake2b_generic xor raid6_pq rapl
  CR2: 0000000000000020

* Case 2. Earlier completion of orig_bbio for mirrored btrfs_bios

btrfs_bbio_propagate_error() assumes the end_io function for orig_bbio is
called last among split bios. In that case, btrfs_orig_write_end_io() sets
the bio->bi_status to BLK_STS_IOERR by seeing the bioc->error [2].
Otherwise, the increased orig_bio's bioc->error is not checked by anyone
and return BLK_STS_OK to the upper layer.

[2] Actually, this is not true. Because we only increases orig_bioc->errors
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
orig_bbio (remaining part after split) itself as it is always
available. Also, the saved error status should be propagated when all the
split btrfs_bios are finished (i.e, bbio->pending_ios == 0).

This commit introduces "status" to btrfs_bbio and saves the first error of
split bios to original btrfs_bio's "status" variable. When all the split
bios are finished, the saved status is loaded into original btrfs_bio's
status.

With this commit, btrfs/146 on zoned devices does not hit the NULL pointer
dereference anymore.

Fixes: 852eee62d31a ("btrfs: allow btrfs_submit_bio to split bios")
CC: stable@vger.kernel.org # 6.6+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/bio.c | 37 +++++++++++++------------------------
 fs/btrfs/bio.h |  3 +++
 2 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index ce13416bc10f0..f83ec5a1baa60 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -49,6 +49,7 @@ void btrfs_bio_init(struct btrfs_bio *bbio, struct btrfs_fs_info *fs_info,
 	bbio->end_io = end_io;
 	bbio->private = private;
 	atomic_set(&bbio->pending_ios, 1);
+	WRITE_ONCE(bbio->status, BLK_STS_OK);
 }
 
 /*
@@ -120,41 +121,29 @@ static void __btrfs_bio_end_io(struct btrfs_bio *bbio)
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
 		btrfs_cleanup_bio(bbio);
 		bbio = orig_bbio;
 	}
 
-	if (atomic_dec_and_test(&bbio->pending_ios))
+	/*
+	 * At this point, bbio always points to the original btrfs_bio. Save
+	 * the first error in it.
+	 */
+	if (status != BLK_STS_OK)
+		cmpxchg(&bbio->status, BLK_STS_OK, status);
+
+	if (atomic_dec_and_test(&bbio->pending_ios)) {
+		/* Load split bio's error which might be set above. */
+		if (status == BLK_STS_OK)
+			bbio->bio.bi_status = READ_ONCE(bbio->status);
 		__btrfs_bio_end_io(bbio);
+	}
 }
 
 static int next_repair_mirror(struct btrfs_failed_bio *fbio, int cur_mirror)
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index e486123407458..e2fe16074ad65 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -79,6 +79,9 @@ struct btrfs_bio {
 	/* File system that this I/O operates on. */
 	struct btrfs_fs_info *fs_info;
 
+	/* Save the first error status of split bio. */
+	blk_status_t status;
+
 	/*
 	 * This member must come last, bio_alloc_bioset will allocate enough
 	 * bytes for entire btrfs_bio but relies on bio being last.
-- 
2.43.0





