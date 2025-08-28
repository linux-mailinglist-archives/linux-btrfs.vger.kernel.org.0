Return-Path: <linux-btrfs+bounces-16474-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E69B3927F
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Aug 2025 06:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 517F69817CD
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Aug 2025 04:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B1F1CD208;
	Thu, 28 Aug 2025 04:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="W1+PRCGf";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="W1+PRCGf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E7A258A
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Aug 2025 04:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756354619; cv=none; b=gnvM+Hf8DK6jBY1h3QgB5QTy3WxbrNAoL3B/SmSclJtl+a8qyUn03KadsIU5AUKIyJpV5aN//mytAE/fvEXYNx4+z0me70Je6RruifByGk9bh1dX5c4WhxmptztwyH7Aa4nk9rg4SzdFntMWCV502GR/6n1/+wJO7Hj/7MKSNSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756354619; c=relaxed/simple;
	bh=97c+PmOf+hclCbq/y8uBuwMAjOtW+ra1DdCs4tbP/yk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EOCpwt+efgCA/VJz5EnB4PCchQcd2NhIt2AadEaZxN09+fL5GoWWa1QbOQB/te/tlMXzx3Ww9L5ceUBCEKrh87rNPL4JqO8w6Om8KxmLV/yYaGRWkbDfWU+5yz9MsS95jZO7GdB0JTUgSIJ3cQrhIRks2VH1Hv3HYU82Ooognjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=W1+PRCGf; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=W1+PRCGf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3875F20937
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Aug 2025 04:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756354609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hEJTSmap6wg+EcB0UGiPCn/KD9bTJiudke6j16egoTk=;
	b=W1+PRCGf7ne/CONoOD6VS+Je+Gxbe1X67+v+6rgeB7EVGIGdApnNhJsKmAns7CZJXFDkMo
	7YTXA5NkIaNrD3vRiS+vKN+0QZsNVzZNoW1fY3Kn04nCzCgm90avKrqZF3l05eP91RAF9g
	ThPjS22JMl4Z/78I7XpqgCJDPPSJzvE=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=W1+PRCGf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756354609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hEJTSmap6wg+EcB0UGiPCn/KD9bTJiudke6j16egoTk=;
	b=W1+PRCGf7ne/CONoOD6VS+Je+Gxbe1X67+v+6rgeB7EVGIGdApnNhJsKmAns7CZJXFDkMo
	7YTXA5NkIaNrD3vRiS+vKN+0QZsNVzZNoW1fY3Kn04nCzCgm90avKrqZF3l05eP91RAF9g
	ThPjS22JMl4Z/78I7XpqgCJDPPSJzvE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 75C9F13680
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Aug 2025 04:16:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eMIvDjDYr2hhYQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Aug 2025 04:16:48 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/4] btrfs: enhance primary super block write error detection
Date: Thu, 28 Aug 2025 13:46:22 +0930
Message-ID: <769afc98a99799a798f7e47db2ca4321a5736ee5.1756353444.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1756353444.git.wqu@suse.com>
References: <cover.1756353444.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 3875F20937
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -3.01

Currently btrfs has two functions handling super blocks writeback,
write_dev_super() and wait_dev_super().

However there are some inconsistency and missing corner cases:

- Primary super block writeback can be skipped for tiny devices
  Although such small devices shouldn't be added in the first place, we
  lack the proper checks inside btrfs_init_new_device().

  E.g. a device with only 64K bytes can be added to btrfs, and the
  primary super block writeback will be skipped, causing future mounts
  to fail, as there will be no way to find that never-to-be-written super
  block.

- Inconsistency between write_dev_super() and wait_dev_super()
  write_dev_super() will not report error as long as one super block
  is submitted.

  However wait_dev_super() will report error as long as the primary one
  failed.

Enhance the primary super block error detection by:

- Use a device state flag to indicate failed primary super block error
  So that we save an atomic_t.

- Always try to submit the primary super block
  If the device can not hold the primary super block, treat it as an
  error.

  This applies to both write_dev_super() and wait_dev_super().

- Return error if the primary super block write/wait failed
  This mostly affects write_dev_super(), as wait_dev_super() is already
  doing this behavior.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 50 ++++++++++++++++++++++++++++------------------
 fs/btrfs/volumes.h |  7 +------
 2 files changed, 32 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 7b06bbc40898..90577fc73b3b 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3690,10 +3690,7 @@ static void btrfs_end_super_write(struct bio *bio)
 						     BTRFS_DEV_STAT_WRITE_ERRS);
 			/* Ensure failure if the primary sb fails. */
 			if (bio->bi_opf & REQ_FUA)
-				atomic_add(BTRFS_SUPER_PRIMARY_WRITE_ERROR,
-					   &device->sb_write_errors);
-			else
-				atomic_inc(&device->sb_write_errors);
+				set_bit(BTRFS_DEV_STATE_SB_WRITE_ERROR, &device->dev_state);
 		}
 		folio_unlock(fi.folio);
 		folio_put(fi.folio);
@@ -3718,11 +3715,12 @@ static int write_dev_supers(struct btrfs_device *device,
 	struct btrfs_fs_info *fs_info = device->fs_info;
 	struct address_space *mapping = device->bdev->bd_mapping;
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
+	bool primary_failed = false;
 	int i;
 	int ret;
 	u64 bytenr, bytenr_orig;
 
-	atomic_set(&device->sb_write_errors, 0);
+	clear_bit(BTRFS_DEV_STATE_SB_WRITE_ERROR, &device->dev_state);
 
 	if (max_mirrors == 0)
 		max_mirrors = BTRFS_SUPER_MIRROR_MAX;
@@ -3738,17 +3736,26 @@ static int write_dev_supers(struct btrfs_device *device,
 		bytenr_orig = btrfs_sb_offset(i);
 		ret = btrfs_sb_log_location(device, i, WRITE, &bytenr);
 		if (ret == -ENOENT) {
+			if (i == 0)
+				primary_failed = true;
 			continue;
 		} else if (ret < 0) {
 			btrfs_err(device->fs_info,
 			  "couldn't get super block location for mirror %d error %d",
 			  i, ret);
-			atomic_inc(&device->sb_write_errors);
+			if (i == 0) {
+				set_bit(BTRFS_DEV_STATE_SB_WRITE_ERROR,
+					&device->dev_state);
+				primary_failed = true;
+			}
 			continue;
 		}
 		if (bytenr + BTRFS_SUPER_INFO_SIZE >=
-		    device->commit_total_bytes)
+		    device->commit_total_bytes) {
+			if (i == 0)
+				primary_failed = true;
 			break;
+		}
 
 		btrfs_set_super_bytenr(sb, bytenr_orig);
 
@@ -3763,7 +3770,11 @@ static int write_dev_supers(struct btrfs_device *device,
 			btrfs_err(device->fs_info,
 			  "couldn't get super block page for bytenr %llu error %ld",
 			  bytenr, PTR_ERR(folio));
-			atomic_inc(&device->sb_write_errors);
+			if (i == 0) {
+				set_bit(BTRFS_DEV_STATE_SB_WRITE_ERROR,
+					&device->dev_state);
+				primary_failed = true;
+			}
 			continue;
 		}
 
@@ -3793,10 +3804,11 @@ static int write_dev_supers(struct btrfs_device *device,
 			bio->bi_opf |= REQ_FUA;
 		submit_bio(bio);
 
-		if (btrfs_advance_sb_log(device, i))
-			atomic_inc(&device->sb_write_errors);
+		btrfs_advance_sb_log(device, i);
 	}
-	return atomic_read(&device->sb_write_errors) < i ? 0 : -1;
+	if (primary_failed)
+		return -1;
+	return 0;
 }
 
 /*
@@ -3809,7 +3821,6 @@ static int write_dev_supers(struct btrfs_device *device,
 static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
 {
 	int i;
-	int errors = 0;
 	bool primary_failed = false;
 	int ret;
 	u64 bytenr;
@@ -3824,14 +3835,16 @@ static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
 		if (ret == -ENOENT) {
 			break;
 		} else if (ret < 0) {
-			errors++;
 			if (i == 0)
 				primary_failed = true;
 			continue;
 		}
 		if (bytenr + BTRFS_SUPER_INFO_SIZE >=
-		    device->commit_total_bytes)
+		    device->commit_total_bytes) {
+			if (i == 0)
+				primary_failed = true;
 			break;
+		}
 
 		folio = filemap_get_folio(device->bdev->bd_mapping,
 					  bytenr >> PAGE_SHIFT);
@@ -3844,16 +3857,15 @@ static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
 		folio_put(folio);
 	}
 
-	errors += atomic_read(&device->sb_write_errors);
-	if (errors >= BTRFS_SUPER_PRIMARY_WRITE_ERROR)
-		primary_failed = true;
+	if (!primary_failed)
+		primary_failed = test_bit(BTRFS_DEV_STATE_SB_WRITE_ERROR,
+					  &device->dev_state);
 	if (primary_failed) {
 		btrfs_err(device->fs_info, "error writing primary super block to device %llu",
 			  device->devid);
 		return -1;
 	}
-
-	return errors < i ? 0 : -1;
+	return 0;
 }
 
 /*
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 2cbf8080eade..f69bc72680fb 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -100,6 +100,7 @@ enum btrfs_raid_types {
 #define BTRFS_DEV_STATE_REPLACE_TGT	(3)
 #define BTRFS_DEV_STATE_FLUSH_SENT	(4)
 #define BTRFS_DEV_STATE_NO_READA	(5)
+#define BTRFS_DEV_STATE_SB_WRITE_ERROR	(6)
 
 /* Special value encoding failure to write primary super block. */
 #define BTRFS_SUPER_PRIMARY_WRITE_ERROR		(INT_MAX / 2)
@@ -155,12 +156,6 @@ struct btrfs_device {
 	/* type and info about this device */
 	u64 type;
 
-	/*
-	 * Counter of super block write errors, values larger than
-	 * BTRFS_SUPER_PRIMARY_WRITE_ERROR encode primary super block write failure.
-	 */
-	atomic_t sb_write_errors;
-
 	/* minimal io size for this device */
 	u32 sector_size;
 
-- 
2.50.1


