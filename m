Return-Path: <linux-btrfs+bounces-15361-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80876AFDEAD
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 06:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EED5A7AD4FB
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 04:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD6925F986;
	Wed,  9 Jul 2025 04:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="drU82PUN";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="drU82PUN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC301E835D
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 04:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752033981; cv=none; b=K499x5LiqZHF6uDR34L5uwwgBFoePYCjTDPeP8dQB37i1mnKa1R0TG2KwFh6q7vWOV1EkZ06AWAU7QyMeZ3gGbA5Y+mNw4TL7IsaYEwSOqgRnR8UH5K0aFNYGfwkYTIQTCAwpaOZbbMlFPS0tuKFzabvqpNlOk8vmRoxfJ+x5kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752033981; c=relaxed/simple;
	bh=LHRo6bjgvKz8DJAKczyKIj3AutjlMleAkB3HXTu6lsI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lkkBvAwkM4HIzCfMEtze8ejxewQOh51edCwXdaKdtmn4TEmos+jZashDWKyOvWATzZX6vG5UZJpthPe6FFyRfHMWjePB66kzQCHGElRGtYI7ls3KgHOK50v4igbXgBNTz3wmSV98OdAwBoFrSRhoIksWfqmkvLAjRmT1ruuH7k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=drU82PUN; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=drU82PUN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B586A2116D
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 04:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1752033970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cWZeEvmUyxwi0mqHy/zeWiradltnlTQFFb0qjvNauQY=;
	b=drU82PUNsgU1SfvOwTxk5J2h/ySJeLGQDvlON+UnYCgfPMynZ8Pb0LEgxFfBZHQibQeb98
	5HWRtIv6izp4V0JxeJ3/4+LFJZLhNZ/n+BI4L9NCPE3Y25WUK2LAWKZmwoLZcKh3HwJqNf
	LaYGZ6G4L27VnRp5HyhvTApbfpQ93oc=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1752033970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cWZeEvmUyxwi0mqHy/zeWiradltnlTQFFb0qjvNauQY=;
	b=drU82PUNsgU1SfvOwTxk5J2h/ySJeLGQDvlON+UnYCgfPMynZ8Pb0LEgxFfBZHQibQeb98
	5HWRtIv6izp4V0JxeJ3/4+LFJZLhNZ/n+BI4L9NCPE3Y25WUK2LAWKZmwoLZcKh3HwJqNf
	LaYGZ6G4L27VnRp5HyhvTApbfpQ93oc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F2ABC13757
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 04:06:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QM3PLLHqbWiwKgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 09 Jul 2025 04:06:09 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: do not poke into bdev's page cache for super block write
Date: Wed,  9 Jul 2025 13:35:49 +0930
Message-ID: <6b25aeba0d2c1713cb71b9622aa460a72d999b58.1752033203.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1752033203.git.wqu@suse.com>
References: <cover.1752033203.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	URIBL_BLOCKED(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

[EXISTING BEHAVIOR]
Currently btrfs is utilizing block device's page cache to write super
blocks.

This has a long history, dating back to early days when we relies on the
page's flags to determine if the IO is done or failed.

But later commit bc00965dbff7 ("btrfs: count super block write errors in
device instead of tracking folio error state") uses extra atomic to
track how many errors are hit, and we no longer rely on page flags to
determine if the IO is done or failed.

[PROBLEMS]
But such direct usage of block devices' page cache is putting btrfs
responsible to the implementation details of the block device.

In fact this has already caused problem when the block device's page
cache has large folio support enabled, fixed by commit 65f2a3b2323e
("btrfs: remove folio order ASSERT()s in super block writeback path").

This should give us a warning that poking into other layer's
implementation is not a good idea.

[ENHANCEMENT]
Instead of directly using block device's page cache, use the regular bio
interfaces, this involves:

- Introduce extra buffer for all super blocks of a device
  This is needed because we want to submit bios for all super blocks in
  one go, and wait for them all.
  This is to increase concurrency, thus we can not reuse a single super
  block copy, and that's part of the reason we want to use page cache.

  Unfortunately this means we will have extra 12K memory usage for each
  btrfs device.

- Introduce ways to wait for super block writeback
  Previously we rely on the page cache to wait for the IO to finish.
  Now we have an atomic, @sb_write_running, to record how many running
  super block writes are pending.

  And also a wait queue head for waiting.

  This greatly simplify wait_dev_supers(), now we only need to wait for
  the pending ios to finish.

- Simplify btrfs_end_super_write() function
  Now we don't need to bother releasing the folio, we can get rid of the
  bio iteration code.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 76 ++++++++++++++--------------------------------
 fs/btrfs/volumes.c | 13 ++++++++
 fs/btrfs/volumes.h |  6 ++++
 3 files changed, 42 insertions(+), 53 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c4b020187249..c93d7b908f66 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3692,27 +3692,23 @@ ALLOW_ERROR_INJECTION(open_ctree, ERRNO);
 static void btrfs_end_super_write(struct bio *bio)
 {
 	struct btrfs_device *device = bio->bi_private;
-	struct folio_iter fi;
 
-	bio_for_each_folio_all(fi, bio) {
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
-		folio_unlock(fi.folio);
-		folio_put(fi.folio);
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
 	}
-
+	if (atomic_dec_and_test(&device->sb_write_running))
+		wake_up(&device->sb_write_wait);
 	bio_put(bio);
 }
 
@@ -3730,24 +3726,21 @@ static int write_dev_supers(struct btrfs_device *device,
 			    struct btrfs_super_block *sb, int max_mirrors)
 {
 	struct btrfs_fs_info *fs_info = device->fs_info;
-	struct address_space *mapping = device->bdev->bd_mapping;
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	int i;
 	int ret;
 	u64 bytenr, bytenr_orig;
 
 	atomic_set(&device->sb_write_errors, 0);
+	ASSERT(atomic_read(&device->sb_write_running) == 0);
 
 	if (max_mirrors == 0)
 		max_mirrors = BTRFS_SUPER_MIRROR_MAX;
-
+	ASSERT(max_mirrors <= BTRFS_SUPER_MIRROR_MAX);
 	shash->tfm = fs_info->csum_shash;
 
 	for (i = 0; i < max_mirrors; i++) {
-		struct folio *folio;
 		struct bio *bio;
-		struct btrfs_super_block *disk_super;
-		size_t offset;
 
 		bytenr_orig = btrfs_sb_offset(i);
 		ret = btrfs_sb_log_location(device, i, WRITE, &bytenr);
@@ -3769,21 +3762,7 @@ static int write_dev_supers(struct btrfs_device *device,
 		crypto_shash_digest(shash, (const char *)sb + BTRFS_CSUM_SIZE,
 				    BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE,
 				    sb->csum);
-
-		folio = __filemap_get_folio(mapping, bytenr >> PAGE_SHIFT,
-					    FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
-					    GFP_NOFS);
-		if (IS_ERR(folio)) {
-			btrfs_err(device->fs_info,
-			  "couldn't get super block page for bytenr %llu error %ld",
-			  bytenr, PTR_ERR(folio));
-			atomic_inc(&device->sb_write_errors);
-			continue;
-		}
-
-		offset = offset_in_folio(folio, bytenr);
-		disk_super = folio_address(folio) + offset;
-		memcpy(disk_super, sb, BTRFS_SUPER_INFO_SIZE);
+		memcpy(device->sb_write_buf[i], sb, BTRFS_SUPER_INFO_SIZE);
 
 		/*
 		 * Directly use bios here instead of relying on the page cache
@@ -3796,7 +3775,7 @@ static int write_dev_supers(struct btrfs_device *device,
 		bio->bi_iter.bi_sector = bytenr >> SECTOR_SHIFT;
 		bio->bi_private = device;
 		bio->bi_end_io = btrfs_end_super_write;
-		bio_add_folio_nofail(bio, folio, BTRFS_SUPER_INFO_SIZE, offset);
+		bio_add_virt_nofail(bio, device->sb_write_buf[i], BTRFS_SUPER_INFO_SIZE);
 
 		/*
 		 * We FUA only the first super block.  The others we allow to
@@ -3805,6 +3784,7 @@ static int write_dev_supers(struct btrfs_device *device,
 		 */
 		if (i == 0 && !btrfs_test_opt(device->fs_info, NOBARRIER))
 			bio->bi_opf |= REQ_FUA;
+		atomic_inc(&device->sb_write_running);
 		submit_bio(bio);
 
 		if (btrfs_advance_sb_log(device, i))
@@ -3830,10 +3810,10 @@ static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
 
 	if (max_mirrors == 0)
 		max_mirrors = BTRFS_SUPER_MIRROR_MAX;
+	ASSERT(max_mirrors <= BTRFS_SUPER_MIRROR_MAX);
 
+	/* Calculate how many super blocks we really have. */
 	for (i = 0; i < max_mirrors; i++) {
-		struct folio *folio;
-
 		ret = btrfs_sb_log_location(device, i, READ, &bytenr);
 		if (ret == -ENOENT) {
 			break;
@@ -3846,17 +3826,8 @@ static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
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
@@ -3866,7 +3837,6 @@ static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
 			  device->devid);
 		return -1;
 	}
-
 	return errors < i ? 0 : -1;
 }
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 03643c71addf..be638774b9eb 100644
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
@@ -407,6 +408,8 @@ static void btrfs_free_device(struct btrfs_device *device)
 	kfree(rcu_dereference_raw(device->name));
 	btrfs_extent_io_tree_release(&device->alloc_state);
 	btrfs_destroy_dev_zone_info(device);
+	for (int i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++)
+		kfree(device->sb_write_buf[i]);
 	kfree(device);
 }
 
@@ -6893,6 +6896,8 @@ struct btrfs_device *btrfs_alloc_device(struct btrfs_fs_info *fs_info,
 	INIT_LIST_HEAD(&dev->post_commit_list);
 
 	atomic_set(&dev->dev_stats_ccnt, 0);
+	atomic_set(&dev->sb_write_running, 0);
+	init_waitqueue_head(&dev->sb_write_wait);
 	btrfs_device_data_ordered_init(dev);
 	btrfs_extent_io_tree_init(fs_info, &dev->alloc_state, IO_TREE_DEVICE_ALLOC_STATE);
 
@@ -6925,6 +6930,14 @@ struct btrfs_device *btrfs_alloc_device(struct btrfs_fs_info *fs_info,
 		rcu_assign_pointer(dev->name, name);
 	}
 
+	for (int i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
+		dev->sb_write_buf[i] = kmalloc(BTRFS_SUPER_INFO_SIZE, GFP_KERNEL);
+		if (!dev->sb_write_buf[i]) {
+			btrfs_free_device(dev);
+			return ERR_PTR(-ENOMEM);
+		}
+	}
+
 	return dev;
 }
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index bf2e9a5a63ea..830a8383b73b 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -20,6 +20,7 @@
 #include <linux/rbtree.h>
 #include <uapi/linux/btrfs.h>
 #include <uapi/linux/btrfs_tree.h>
+#include "disk-io.h"
 #include "messages.h"
 #include "extent-io-tree.h"
 
@@ -182,6 +183,11 @@ struct btrfs_device {
 	struct bio flush_bio;
 	struct completion flush_wait;
 
+	/* Buffer for each super block. */
+	struct btrfs_super_block *sb_write_buf[BTRFS_SUPER_MIRROR_MAX];
+	atomic_t sb_write_running;
+	wait_queue_head_t sb_write_wait;
+
 	/* per-device scrub information */
 	struct scrub_ctx *scrub_ctx;
 
-- 
2.50.0


