Return-Path: <linux-btrfs+bounces-15408-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AA8AFF426
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 23:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6168F1C44B27
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 21:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C97823B633;
	Wed,  9 Jul 2025 21:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lX3oZX6L";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lX3oZX6L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7332236F2
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 21:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752098075; cv=none; b=czWDbeGX1a+hUYnSrPf+SsDRkfO0ITcmjMZWa/FzhcrwdAdbeY1JHApn7/E0fQW1m+I+E4yxsECS4GdeKktukIPmOZhsTdK1Jq+G7lfzVXO26AtG12lx4T3Ma8u3UMmUJH8CbQaB2r7CeaH8FnddMeMWApR5E8n90lRXkymb3Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752098075; c=relaxed/simple;
	bh=t/30NqF/J5ZisbGiEQaewK9t1/FcjIdQdL50RILBQuI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AAVe80Vs3bmBvJNgpeQcHzZ484fQeI1g9dgUs/6oAnh+wQQCtrNeiWppoQxUvd3i1E85K0fQ9kydKksKLjDUzsefZhz9hb5pmL/rQuueLr7cVAHxfX/OyTlyh1kCtjbDUo4WkY2eZkN8kDIL2zvCl3RUGiXjTrIkWFFdxaONzHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lX3oZX6L; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lX3oZX6L; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 356761F451
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 21:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1752098064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bzzjlF95DRE+XcWtm5fvZIMtGl3JmTl99/NRGEDH1ew=;
	b=lX3oZX6L75rbKIyS/VSuxdq+QdA8XgOY7X2IAQpY43ut19618jTc6aFWmXZPV8PDVEo/cR
	IVgNHuiZYslCNPjb8ntKmaFBonl5CfwIdyyaztEbMfVem/Bq9N/pvWU9xJbDakXUzzfN5H
	vl07Pu3JtefJhvZzQ/vMz0uUhRHbYEw=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1752098064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bzzjlF95DRE+XcWtm5fvZIMtGl3JmTl99/NRGEDH1ew=;
	b=lX3oZX6L75rbKIyS/VSuxdq+QdA8XgOY7X2IAQpY43ut19618jTc6aFWmXZPV8PDVEo/cR
	IVgNHuiZYslCNPjb8ntKmaFBonl5CfwIdyyaztEbMfVem/Bq9N/pvWU9xJbDakXUzzfN5H
	vl07Pu3JtefJhvZzQ/vMz0uUhRHbYEw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 74E9513757
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 21:54:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gJ0uDg/lbmhVbQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 09 Jul 2025 21:54:23 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/2] btrfs: use proper superblock writeback tracing
Date: Thu, 10 Jul 2025 07:24:03 +0930
Message-ID: <ee0c53d5a56dd66fa41dbb5bec3ea02b294cc208.1752097916.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1752097916.git.wqu@suse.com>
References: <cover.1752097916.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

[EXISTING BEHAVIOR]
Btrfs is currently using bdev's page cache to do super block writeback.

However it's doing it in not-so-consistent way:

- The page cache is utilized to store the content to write
  That's fine, we can go that way without using the folio's writeback
  flag to do bio writes.

- But we also use folio lock flag to determine if the IO is finished
  Although we didn't go through the regular folio writeback status
  change (dirty -> locked-> writeback -> clear writeback).

  But we still lock and unlock the folio during the submission, thus
  although it looks weird, it still makes sense.

This has a long history, dating back to early days when we relies on the
page's flags to determine if the IO is done or failed.

[CONCERNS]
But such usage of bdev's page cache has brought some concern, Wilcox is
expressing his concern of the folio flags abuse in the past:

https://lore.kernel.org/all/Yn%2FtxWbij5voeGOB@casper.infradead.org/

Thankfully later commit bc00965dbff7 ("btrfs: count super block write
errors in device instead of tracking folio error state") uses extra
atomic to track how many errors are hit, and we no longer rely on
folio/page flags to determine if the IO is failed.

The only remaining usage is folio locked flag, but we still want the folio
locked for a different reason, to ensure user space signature scanning
tool to get a consistent view of the super block.

Otherwise if we use pure bio without bdev's page cache, our bio writes
can race with user space buffered reads, causing test case like
generic/492 to fail.

[ENHANCEMENT]
- Add a comment on why we want to use and lock the bdev's page cache
  There are two reasons:

  * To make the user space have a consistent view of our super block
    The folio containing our sb is locked during writeback, thus user
    space have to wait until the write is done, thus won't see any
    half-backed contents.

  * To provide different memory for each super block
    As each super block has a slightly different contents from each
    other, and we want to submit them in parallel, we need independent
    memory for each super block.

- Introduce a proper way to wait for super block writeback
  Previously we rely on the page cache to wait for the IO to finish.
  Now we have an atomic, @sb_write_running, to record how many running
  super block writes are pending.

  And also a wait queue head for waiting.

  This greatly simplify wait_dev_supers(), now we only need to wait for
  the pending ios to finish, no need to bother the page cache anymore.

- Slightly refactor btrfs_end_super_write() function
  The error handling doesn't need to be embedded inside the folio
  iteration, extract it out of the iteration loop.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 55 ++++++++++++++++++++++++----------------------
 fs/btrfs/volumes.c |  3 +++
 fs/btrfs/volumes.h |  5 +++++
 3 files changed, 37 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c4b020187249..243b7d8d7709 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3695,24 +3695,26 @@ static void btrfs_end_super_write(struct bio *bio)
 	struct folio_iter fi;
 
 	bio_for_each_folio_all(fi, bio) {
-		if (bio->bi_status) {
-			btrfs_warn_rl(device->fs_info,
-				"lost super block write due to IO error on %s (%d)",
-				btrfs_dev_name(device),
-				blk_status_to_errno(bio->bi_status));
-			btrfs_dev_stat_inc_and_print(device,
-						     BTRFS_DEV_STAT_WRITE_ERRS);
-			/* Ensure failure if the primary sb fails. */
-			if (bio->bi_opf & REQ_FUA)
-				atomic_add(BTRFS_SUPER_PRIMARY_WRITE_ERROR,
-					   &device->sb_write_errors);
-			else
-				atomic_inc(&device->sb_write_errors);
-		}
 		folio_unlock(fi.folio);
 		folio_put(fi.folio);
 	}
 
+	if (bio->bi_status) {
+		btrfs_warn_rl(device->fs_info,
+			"lost super block write due to IO error on %s (%d)",
+			btrfs_dev_name(device),
+			blk_status_to_errno(bio->bi_status));
+		btrfs_dev_stat_inc_and_print(device,
+					     BTRFS_DEV_STAT_WRITE_ERRS);
+		/* Ensure failure if the primary sb fails. */
+		if (bio->bi_opf & REQ_FUA)
+			atomic_add(BTRFS_SUPER_PRIMARY_WRITE_ERROR,
+				   &device->sb_write_errors);
+		else
+			atomic_inc(&device->sb_write_errors);
+	}
+	if (atomic_dec_and_test(&device->sb_write_running))
+		wake_up(&device->sb_write_wait);
 	bio_put(bio);
 }
 
@@ -3737,6 +3739,7 @@ static int write_dev_supers(struct btrfs_device *device,
 	u64 bytenr, bytenr_orig;
 
 	atomic_set(&device->sb_write_errors, 0);
+	ASSERT(atomic_read(&device->sb_write_running) == 0);
 
 	if (max_mirrors == 0)
 		max_mirrors = BTRFS_SUPER_MIRROR_MAX;
@@ -3770,6 +3773,15 @@ static int write_dev_supers(struct btrfs_device *device,
 				    BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE,
 				    sb->csum);
 
+		/*
+		 * Lock the folio covering our super block.
+		 *
+		 * This will prevent user space scanning getting half-backed
+		 * content caused by race between buffered and direct IO.
+		 *
+		 * This also provide different folios for each super block
+		 * which contains slightly different contents.
+		 */
 		folio = __filemap_get_folio(mapping, bytenr >> PAGE_SHIFT,
 					    FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
 					    GFP_NOFS);
@@ -3805,6 +3817,7 @@ static int write_dev_supers(struct btrfs_device *device,
 		 */
 		if (i == 0 && !btrfs_test_opt(device->fs_info, NOBARRIER))
 			bio->bi_opf |= REQ_FUA;
+		atomic_inc(&device->sb_write_running);
 		submit_bio(bio);
 
 		if (btrfs_advance_sb_log(device, i))
@@ -3831,9 +3844,8 @@ static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
 	if (max_mirrors == 0)
 		max_mirrors = BTRFS_SUPER_MIRROR_MAX;
 
+	/* Calculate how many super blocks we really have. */
 	for (i = 0; i < max_mirrors; i++) {
-		struct folio *folio;
-
 		ret = btrfs_sb_log_location(device, i, READ, &bytenr);
 		if (ret == -ENOENT) {
 			break;
@@ -3846,17 +3858,8 @@ static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
 		if (bytenr + BTRFS_SUPER_INFO_SIZE >=
 		    device->commit_total_bytes)
 			break;
-
-		folio = filemap_get_folio(device->bdev->bd_mapping,
-					  bytenr >> PAGE_SHIFT);
-		/* If the folio has been removed, then we know it completed. */
-		if (IS_ERR(folio))
-			continue;
-
-		/* Folio will be unlocked once the write completes. */
-		folio_wait_locked(folio);
-		folio_put(folio);
 	}
+	wait_event(device->sb_write_wait, atomic_read(&device->sb_write_running) == 0);
 
 	errors += atomic_read(&device->sb_write_errors);
 	if (errors >= BTRFS_SUPER_PRIMARY_WRITE_ERROR)
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 5e5b18524d1f..9667ca0374d0 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -400,6 +400,7 @@ static struct btrfs_fs_devices *alloc_fs_devices(const u8 *fsid)
 static void btrfs_free_device(struct btrfs_device *device)
 {
 	WARN_ON(!list_empty(&device->post_commit_list));
+	WARN_ON(atomic_read(&device->sb_write_running) != 0);
 	/*
 	 * No need to call kfree_rcu() nor do RCU lock/unlock, nothing is
 	 * reading the device name.
@@ -6895,6 +6896,8 @@ struct btrfs_device *btrfs_alloc_device(struct btrfs_fs_info *fs_info,
 	INIT_LIST_HEAD(&dev->post_commit_list);
 
 	atomic_set(&dev->dev_stats_ccnt, 0);
+	atomic_set(&dev->sb_write_running, 0);
+	init_waitqueue_head(&dev->sb_write_wait);
 	btrfs_device_data_ordered_init(dev);
 	btrfs_extent_io_tree_init(fs_info, &dev->alloc_state, IO_TREE_DEVICE_ALLOC_STATE);
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index bf2e9a5a63ea..661ac281c065 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -20,6 +20,7 @@
 #include <linux/rbtree.h>
 #include <uapi/linux/btrfs.h>
 #include <uapi/linux/btrfs_tree.h>
+#include "disk-io.h"
 #include "messages.h"
 #include "extent-io-tree.h"
 
@@ -182,6 +183,10 @@ struct btrfs_device {
 	struct bio flush_bio;
 	struct completion flush_wait;
 
+	/* How many super block write bios are running. */
+	atomic_t sb_write_running;
+	wait_queue_head_t sb_write_wait;
+
 	/* per-device scrub information */
 	struct scrub_ctx *scrub_ctx;
 
-- 
2.50.0


