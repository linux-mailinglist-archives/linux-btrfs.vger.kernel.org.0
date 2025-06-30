Return-Path: <linux-btrfs+bounces-15082-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFE8AED3D8
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 07:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C05E23B49DA
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 05:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66051A76DE;
	Mon, 30 Jun 2025 05:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nWOKUGmp";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nWOKUGmp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4035F1E502
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 05:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751261419; cv=none; b=dPNepvQ0zEUvvZzkvOCGD/H8hUj75cy6uVS4i8XKTVS7CZoGKn0E4B/fLt2aEh1kzr5euUI8qwyk1qmUA+INGZcCyjZIqE4Rchc/0W+mFvDERfr0F+7HwqwPX9ku+hmnkCvZVFxj1hz5NlgDONGEiL1WAVL0+hYNQZcwPcnClzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751261419; c=relaxed/simple;
	bh=P3yHABWFWVjBxCDkLhMBOffneBMirvwREZ+1J1/O4bg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qpq+nwSui/zr7tdMg5CXMotV4hLyQCf+Z0imjG4AseKZxwMdDDPcsUrgfB7d5SXZgvBObOjlxtcvIc6b+ZNt10w228rYTEMZNgUcTdFNk1PC+rN/wW11MpIF9UmPD5ybTXppHnE5lUA9yPnu/2TZgP3hlST4noqeNcLQBzMd5jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nWOKUGmp; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nWOKUGmp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 212FF21166
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 05:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751261381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b/iaORB1bSwb4h9NqpRu2P5wT9OcbjOdPj7Oa/pfUgg=;
	b=nWOKUGmpBXvJWnM5tI2DBQFdiSrdvwtrA3Tmg2a/Cfx1RBvEqAFTCPCiR8cq66Omib2Jr3
	AL0SN/DOMx9riTd/imKXsT7tzqjRCiSans6y/9nuFs9s+sLjCsd3aQVIhSPHlbLNd5sG0D
	Abs5L3z7IxZpDdNkttS+l6HYvsz7Yas=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=nWOKUGmp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751261381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b/iaORB1bSwb4h9NqpRu2P5wT9OcbjOdPj7Oa/pfUgg=;
	b=nWOKUGmpBXvJWnM5tI2DBQFdiSrdvwtrA3Tmg2a/Cfx1RBvEqAFTCPCiR8cq66Omib2Jr3
	AL0SN/DOMx9riTd/imKXsT7tzqjRCiSans6y/9nuFs9s+sLjCsd3aQVIhSPHlbLNd5sG0D
	Abs5L3z7IxZpDdNkttS+l6HYvsz7Yas=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4CE6E139D4
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 05:29:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wNY8BMQgYmi4SAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 05:29:40 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v6 6/8] btrfs: delay btrfs_open_devices() until super block is created
Date: Mon, 30 Jun 2025 14:59:10 +0930
Message-ID: <5705ec18c594287ff879d7f3bab226d88d744f80.1751261286.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751261286.git.wqu@suse.com>
References: <cover.1751261286.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 212FF21166
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -3.01
X-Spam-Level: 

Currently btrfs always calls btrfs_open_devices() before creating the
super block.

It's fine for now because:

- No blk_holder_ops is provided
- btrfs_fs_type is used as a holder

This means no matter who wins the device opening race, the holder will be
the same thus not affecting the later sget_fc() race.

And since no blk_holder_ops is provided, no bdev operation is depending on
the holder.

But this will no longer be true if we want to implement a proper
blk_holder_ops using fs_holder_ops.
This means we will need a proper super block as the bdev holder.

To prepare for such change:

- Add btrfs_fs_devices::holding member
  This will prevent btrfs_free_stale_devices() and btrfs_close_device()
  from deleting the fs_devices when there is another process trying to
  mount the fs.

  Along with the new member, here comes two helpers,
  btrfs_fs_devices_inc_holding() and btrfs_fs_devices_dec_holding().

  This will allow us to hold an fs_devices without opening it.

  This is needed because we can not hold uuid_mutex while calling
  sget_fc(), this will reverse the lock sequence with s_umount, causing
  a lockdep warning.

- Delay btrfs_open_devices() until a super block is returned
  This means we have to hold the initial fs_devices first, then unlock
  uuid_mutex, call sget_fc(), then re-lock uuid_mutex, and decrease the
  holding number.

  For new super block case, we continue to btrfs_open_devices() with
  uuid_mutex hold.
  For existing super block case, we can unlock uuid_mutex and continue.

  Although this means a more complex error handling path, as if we
  didn't call btrfs_open_devices() (either got an existing sb, or
  sget_fc() failed), we can not let btrfs_put_fs_info() to cleanup the
  fs_devices, as it can be freed at any time after we decrease the hold
  on fs_devices and unlock uuid_mutex.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/super.c   | 60 +++++++++++++++++++++++++++++++++++-----------
 fs/btrfs/volumes.c |  5 ++--
 fs/btrfs/volumes.h | 25 +++++++++++++++++++
 3 files changed, 74 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index cc15939080e6..23105f91f6d2 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1841,7 +1841,6 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 	struct btrfs_fs_info *fs_info = fc->s_fs_info;
 	struct btrfs_fs_context *ctx = fc->fs_private;
 	struct btrfs_fs_devices *fs_devices = NULL;
-	struct block_device *bdev;
 	struct btrfs_device *device;
 	struct super_block *sb;
 	blk_mode_t mode = btrfs_open_mode(fc);
@@ -1860,23 +1859,38 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 		mutex_unlock(&uuid_mutex);
 		return PTR_ERR(device);
 	}
-
 	fs_devices = device->fs_devices;
+	/*
+	 * We can not hold uuid_mutex calling sget_fc(), it will lead to a
+	 * locking order reversal with s_umount.
+	 *
+	 * So here we increase the holding number of fs_devices, this will ensure
+	 * the fs_devices itself won't be freed.
+	 */
+	btrfs_fs_devices_inc_holding(fs_devices);
 	fs_info->fs_devices = fs_devices;
-
-	ret = btrfs_open_devices(fs_devices, mode, &btrfs_fs_type);
 	mutex_unlock(&uuid_mutex);
-	if (ret)
-		return ret;
 
-	if (!(fc->sb_flags & SB_RDONLY) && fs_devices->rw_devices == 0)
-		return -EACCES;
-
-	bdev = fs_devices->latest_dev->bdev;
 
 	sb = sget_fc(fc, btrfs_fc_test_super, set_anon_super_fc);
-	if (IS_ERR(sb))
+	if (IS_ERR(sb)) {
+		mutex_lock(&uuid_mutex);
+		btrfs_fs_devices_dec_holding(fs_devices);
+		/*
+		 * Since the fs_devices is not opened, it can be freed at any
+		 * time after unlocking uuid_mutex.
+		 * We do not want to double free such dangling fs_devices through
+		 * put_fs_context()->btrfs_free_fs_info().
+		 * So here we reset fs_info->fs_devices to NULL, and let the
+		 * regular fs_devices reclaim path to handle it.
+		 *
+		 * This applies to all later branches where no fs_devices is
+		 * opened.
+		 */
+		fs_info->fs_devices = NULL;
+		mutex_unlock(&uuid_mutex);
 		return PTR_ERR(sb);
+	}
 
 	set_device_specific_options(fs_info);
 
@@ -1888,12 +1902,13 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 		 *
 		 * fc->s_fs_info is not touched and will be later freed by
 		 * put_fs_context() through btrfs_free_fs_context().
-		 *
-		 * And the fs_info->fs_devices will also be closed by
-		 * btrfs_free_fs_context().
 		 */
 		ASSERT(fc->s_fs_info == fs_info);
 
+		mutex_lock(&uuid_mutex);
+		btrfs_fs_devices_dec_holding(fs_devices);
+		fs_info->fs_devices = NULL;
+		mutex_unlock(&uuid_mutex);
 		/*
 		 * At this stage we may have RO flag mismatch between
 		 * fc->sb_flags and sb->s_flags.  Caller should detect such
@@ -1901,6 +1916,8 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 		 * needed.
 		 */
 	} else {
+		struct block_device *bdev;
+
 		/*
 		 * The first mount of the fs thus a new superblock, fc->s_fs_info
 		 * should be NULL, and the owner ship of our fs_info and fs_devices is
@@ -1908,6 +1925,21 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 		 */
 		ASSERT(fc->s_fs_info == NULL);
 
+		mutex_lock(&uuid_mutex);
+		btrfs_fs_devices_dec_holding(fs_devices);
+		ret = btrfs_open_devices(fs_devices, mode, &btrfs_fs_type);
+		if (ret < 0)
+			fs_info->fs_devices = NULL;
+		mutex_unlock(&uuid_mutex);
+		if (ret < 0) {
+			deactivate_locked_super(sb);
+			return ret;
+		}
+		if (!(fc->sb_flags & SB_RDONLY) && fs_devices->rw_devices == 0) {
+			deactivate_locked_super(sb);
+			return -EACCES;
+		}
+		bdev = fs_devices->latest_dev->bdev;
 		snprintf(sb->s_id, sizeof(sb->s_id), "%pg", bdev);
 		shrinker_debugfs_rename(sb->s_shrink, "sb-btrfs:%s", sb->s_id);
 		btrfs_sb(sb)->bdev_holder = &btrfs_fs_type;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index f51c81c1682c..309f9c182e6f 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -415,6 +415,7 @@ static void free_fs_devices(struct btrfs_fs_devices *fs_devices)
 	struct btrfs_device *device;
 
 	WARN_ON(fs_devices->opened);
+	WARN_ON(fs_devices->holding);
 	while (!list_empty(&fs_devices->devices)) {
 		device = list_first_entry(&fs_devices->devices,
 					  struct btrfs_device, dev_list);
@@ -542,7 +543,7 @@ static int btrfs_free_stale_devices(dev_t devt, struct btrfs_device *skip_device
 				continue;
 			if (devt && devt != device->devt)
 				continue;
-			if (fs_devices->opened) {
+			if (fs_devices->opened || fs_devices->holding) {
 				if (devt)
 					ret = -EBUSY;
 				break;
@@ -1198,7 +1199,7 @@ void btrfs_close_devices(struct btrfs_fs_devices *fs_devices)
 
 	mutex_lock(&uuid_mutex);
 	close_fs_devices(fs_devices);
-	if (!fs_devices->opened) {
+	if (!fs_devices->opened && !fs_devices->holding) {
 		list_splice_init(&fs_devices->seed_list, &list);
 
 		/*
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index afa71d315c46..6acb154ccf87 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -422,6 +422,17 @@ struct btrfs_fs_devices {
 	/* Count fs-devices opened. */
 	int opened;
 
+	/*
+	 * Counter of the processes that are holding this fs_devices but not
+	 * yet opened.
+	 * This is for mounting handling, as we can only open the fs_devices
+	 * after a super block is created.
+	 * But we can not hold uuid_mutex during sget_fc(), thus we have to
+	 * hold the fs_devices (meaning it can not be released) until a super
+	 * block is returned.
+	 */
+	int holding;
+
 	/* Set when we find or add a device that doesn't have the nonrot flag set. */
 	bool rotating;
 	/* Devices support TRIM/discard commands. */
@@ -854,6 +865,20 @@ static inline void btrfs_warn_unknown_chunk_allocation(enum btrfs_chunk_allocati
 	WARN_ONCE(1, "unknown allocation policy %d, fallback to regular", pol);
 }
 
+static inline void btrfs_fs_devices_inc_holding(struct btrfs_fs_devices *fs_devices)
+{
+	lockdep_assert_held(&uuid_mutex);
+	ASSERT(fs_devices->holding >= 0);
+	fs_devices->holding++;
+}
+
+static inline void btrfs_fs_devices_dec_holding(struct btrfs_fs_devices *fs_devices)
+{
+	lockdep_assert_held(&uuid_mutex);
+	ASSERT(fs_devices->holding > 0);
+	fs_devices->holding--;
+}
+
 void btrfs_commit_device_sizes(struct btrfs_transaction *trans);
 
 struct list_head * __attribute_const__ btrfs_get_fs_uuids(void);
-- 
2.50.0


