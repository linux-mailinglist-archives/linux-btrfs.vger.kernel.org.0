Return-Path: <linux-btrfs+bounces-20359-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A8ED0C8F9
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Jan 2026 00:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A52F43010646
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jan 2026 23:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5879433CE9D;
	Fri,  9 Jan 2026 23:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lq3htuyJ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lq3htuyJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1865C257821
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Jan 2026 23:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768001930; cv=none; b=XwL2yCx8Rc7tlf56CP+xYHsqd3Kym/UO5kStJss6lN4zfd5AITG7YohebGAyyiE+yLOyWDI156IcYCDBQte4BjCn2ziqnyA05YkuSsm+EIBP0kEthxK+GfJIWIY/uXqZBgxsnUAkuyW0IlNjiYkEdaOOl25QhkJ1sAUy7OESt0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768001930; c=relaxed/simple;
	bh=WlfoLQ3WnykL2Hvs/r69xyuI7wB1DFF1w414r5iPp20=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=aWta3WGKhwebmzvsbb6Ojt/E4I42xTx9fX9vVs9r8Etc/63t8TJXJTm8VHgepQ1b90RZOAdpmvs2UI1x1WoJw4g1hs6f8Bxo5vHeYwNOWG8v9H0j4EqAGsT9z478NJiDq5qDgC4ixeLwDXhgfm4oTNAMGXzEp+h1lDyGZCQuR3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lq3htuyJ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lq3htuyJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 28A9A5BCE4
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Jan 2026 23:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1768001927; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NgHv0O6iUuW+R0WhjnVc1y93BjLK+imJpTf+r/qtHss=;
	b=lq3htuyJ0gGevVykqIKMN3SaBIR/XoN2de7aGxYQ9OrHuisVpfH/cM4ShUQroDNs667z4S
	yRvZLMRg5cuj/FlnTFqwrbtFoyqR4/s8ygvff6k1oTDQn5Ir+/AeOlgP618oLUeGlcENUk
	sMYRQl4YIlQgvpOwbq8iMZeru+XrcGc=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=lq3htuyJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1768001927; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NgHv0O6iUuW+R0WhjnVc1y93BjLK+imJpTf+r/qtHss=;
	b=lq3htuyJ0gGevVykqIKMN3SaBIR/XoN2de7aGxYQ9OrHuisVpfH/cM4ShUQroDNs667z4S
	yRvZLMRg5cuj/FlnTFqwrbtFoyqR4/s8ygvff6k1oTDQn5Ir+/AeOlgP618oLUeGlcENUk
	sMYRQl4YIlQgvpOwbq8iMZeru+XrcGc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 633CA3EA63
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Jan 2026 23:38:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id S6A5CYaRYWn9OwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 09 Jan 2026 23:38:46 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: shrink the size of btrfs_device
Date: Sat, 10 Jan 2026 10:08:28 +1030
Message-ID: <aa926a3bc890eb51796e6fbc9ca069fc9a4ad57d.1768001871.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:dkim,suse.com:email];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: 28A9A5BCE4
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

There are two main causes of holes inside btrfs_device:

- The single bytes member of last_flush_error
  Not only it's a single byte member, but we never really care about the
  exact error number.

- The @devt member
  Which is put between two u64 members.

Shrink the size of btrfs_device by:

- Use a single bit flag for flush error
  Use BTRFS_DEV_STATE_FLUSH_FAILED so that we no longer need that
  dedicated member.

- Move @devt to the hole after dev_stat_values[]

This reduces the size of btrfs_device from 528 to exact 512 bytes for
x86_64.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c |  6 +++---
 fs/btrfs/volumes.c |  4 ++--
 fs/btrfs/volumes.h | 13 +++++++------
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index cecb81d0f9e0..7ce7afe2bdaf 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3839,7 +3839,7 @@ static void write_dev_flush(struct btrfs_device *device)
 {
 	struct bio *bio = &device->flush_bio;
 
-	device->last_flush_error = BLK_STS_OK;
+	clear_bit(BTRFS_DEV_STATE_FLUSH_FAILED, &device->dev_state);
 
 	bio_init(bio, device->bdev, NULL, 0,
 		 REQ_OP_WRITE | REQ_SYNC | REQ_PREFLUSH);
@@ -3864,7 +3864,7 @@ static bool wait_dev_flush(struct btrfs_device *device)
 	wait_for_completion_io(&device->flush_wait);
 
 	if (bio->bi_status) {
-		device->last_flush_error = bio->bi_status;
+		set_bit(BTRFS_DEV_STATE_FLUSH_FAILED, &device->dev_state);
 		btrfs_dev_stat_inc_and_print(device, BTRFS_DEV_STAT_FLUSH_ERRS);
 		return true;
 	}
@@ -3914,7 +3914,7 @@ static int barrier_all_devices(struct btrfs_fs_info *info)
 	}
 
 	/*
-	 * Checks last_flush_error of disks in order to determine the device
+	 * Checks flush failure of disks in order to determine the device
 	 * state.
 	 */
 	if (unlikely(errors_wait && !btrfs_check_rw_degradable(info, NULL)))
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 2c709cf18476..908a89eaeabf 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1169,7 +1169,7 @@ static void btrfs_close_one_device(struct btrfs_device *device)
 	 * any transaction and set the error state, guaranteeing no commits of
 	 * unsafe super blocks.
 	 */
-	device->last_flush_error = 0;
+	clear_bit(BTRFS_DEV_STATE_FLUSH_FAILED, &device->dev_state);
 
 	/* Verify the device is back in a pristine state  */
 	WARN_ON(test_bit(BTRFS_DEV_STATE_FLUSH_SENT, &device->dev_state));
@@ -7374,7 +7374,7 @@ bool btrfs_check_rw_degradable(struct btrfs_fs_info *fs_info,
 
 			if (!dev || !dev->bdev ||
 			    test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state) ||
-			    dev->last_flush_error)
+			    test_bit(BTRFS_DEV_STATE_FLUSH_FAILED, &dev->dev_state))
 				missing++;
 			else if (failing_dev && failing_dev == dev)
 				missing++;
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 4979a7351905..93f45410931e 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -99,6 +99,7 @@ enum btrfs_raid_types {
 #define BTRFS_DEV_STATE_REPLACE_TGT	(3)
 #define BTRFS_DEV_STATE_FLUSH_SENT	(4)
 #define BTRFS_DEV_STATE_NO_READA	(5)
+#define BTRFS_DEV_STATE_FLUSH_FAILED	(6)
 
 /* Special value encoding failure to write primary super block. */
 #define BTRFS_SUPER_PRIMARY_WRITE_ERROR		(INT_MAX / 2)
@@ -122,13 +123,7 @@ struct btrfs_device {
 
 	struct btrfs_zoned_device_info *zone_info;
 
-	/*
-	 * Device's major-minor number. Must be set even if the device is not
-	 * opened (bdev == NULL), unless the device is missing.
-	 */
-	dev_t devt;
 	unsigned long dev_state;
-	blk_status_t last_flush_error;
 
 #ifdef __BTRFS_NEED_DEVICE_DATA_ORDERED
 	seqcount_t data_seqcount;
@@ -192,6 +187,12 @@ struct btrfs_device {
 	atomic_t dev_stats_ccnt;
 	atomic_t dev_stat_values[BTRFS_DEV_STAT_VALUES_MAX];
 
+	/*
+	 * Device's major-minor number. Must be set even if the device is not
+	 * opened (bdev == NULL), unless the device is missing.
+	 */
+	dev_t devt;
+
 	struct extent_io_tree alloc_state;
 
 	struct completion kobj_unregister;
-- 
2.52.0


