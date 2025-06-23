Return-Path: <linux-btrfs+bounces-14859-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0D2AE3D33
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Jun 2025 12:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 336513A8CC8
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Jun 2025 10:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D636823AE62;
	Mon, 23 Jun 2025 10:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bywFB4M0";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bywFB4M0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B7619C54E
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Jun 2025 10:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750675638; cv=none; b=dKRXNxKsGh7UGcfd8mTJmAXznCUyw05UUB0X/QqG/j5UCIzm/kElan9+MovkDBjDzML9VYOdTNgpLUTDaJyiIrVLL9ZSxqeYd6CO7xyJ4Vfm8MQz+mzA1Hh6eCHXRVUxApniOdh81zwPTVI0z3HuIT/KK3eAFD35tQ/zHeQ/RTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750675638; c=relaxed/simple;
	bh=hVXffosSWVA4AQKX1TkVVdoxPWEtPJRGS+o9RhviptY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OQPNP7JosZGES69fe70TMKzN5G2oYJwEeEur6cf+k0WO8si6BXljjcE4exr4IuN5EjeUM7j4uG8cqfH5CfQpf0o+sLNqRGAqrBwecbJPo9lFPMlWWL/BB5GahCI1A7cVvN2xZNzYzTg5orq4L3TJWayouPpjBTNpTJm31ffuBcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bywFB4M0; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bywFB4M0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8FF5A1F391
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Jun 2025 10:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750675624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9XvCPUoZK3zR/2uaizL8s2XAkQyk+RZ9wiCPOxxWv0A=;
	b=bywFB4M08IzgUtfxOvfPTM0ipfh8IBH2LElEuFcUbYipwv5ESixc+jHAktw3/I/uitNmeh
	F+kTA9Nzd50Wp/XBs8HtVWIbT+PivsfAScLt1fcutXIWMOqJd1m/j0BSo2U5sZ7LHnY3/s
	QrimbhFbJgoaUMulYmZTwJmt6sN/0Ig=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=bywFB4M0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750675624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9XvCPUoZK3zR/2uaizL8s2XAkQyk+RZ9wiCPOxxWv0A=;
	b=bywFB4M08IzgUtfxOvfPTM0ipfh8IBH2LElEuFcUbYipwv5ESixc+jHAktw3/I/uitNmeh
	F+kTA9Nzd50Wp/XBs8HtVWIbT+PivsfAScLt1fcutXIWMOqJd1m/j0BSo2U5sZ7LHnY3/s
	QrimbhFbJgoaUMulYmZTwJmt6sN/0Ig=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D02CA13485
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Jun 2025 10:47:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wA+sJKcwWWgeJAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Jun 2025 10:47:03 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v4 6/8] btrfs: delay btrfs_open_devices() until super block is created
Date: Mon, 23 Jun 2025 20:16:50 +0930
Message-ID: <1c96eef7e58475eed7a0cad0a6463696919c173e.1750674924.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750674924.git.wqu@suse.com>
References: <cover.1750674924.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	URIBL_BLOCKED(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 8FF5A1F391
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -3.01

Currently btrfs always call btrfs_open_devices() before creating the
super block.

It's fine for now because:

- No blk_holder_ops is provided
- btrfs_fs_type is used as a holder

This means no matter who wins the device opening race, the holder will be
the same thus not affecting the later sget_fc() race.

And since no blk_holder_ops is provided, no bdev operation is depending on
the holder.

But this will no longer be true if we want to (we indeed want) implement
a proper blk_holder_ops using fs_holder_ops.

This means we will need a proper super block as the bdev holder.

To prepare for such change:

- Add btrfs_fs_devices::holding member
  This will prevent btrfs_free_stale_devices() and btrfS_close_device()
  from deleting the fs_devices when there is another process trying to
  mount the fs.

  Along with the new member, here comes two helpers,
  btrfs_fs_devices_inc_holding() and btrfs_fs_devices_dec_holding().

  This will allow us to hold an fs_devices without opening it.

  We can not hold uuid_mutex while calling sget_fc(), this will reverse
  the lock sequence with s_umount, causing a lockdep warning.

- Delay btrfs_open_devices() until a super block is returned
  This means we have to hold the initial fs_devices first, then unlock
  uuid_mutex, call sget_fc(), then re-lock uuid_mutex, and decrease the
  holding number.

  For new super block case, we continue to btrfs_open_devices() with
  uuid_mutex hold.
  For existing super block case, we can unlock uuid_mutex and continue.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/super.c   | 55 ++++++++++++++++++++++++++++++++--------------
 fs/btrfs/volumes.c |  5 +++--
 fs/btrfs/volumes.h | 25 +++++++++++++++++++++
 3 files changed, 67 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 41c824d216fc..b430631da647 100644
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
@@ -1860,23 +1859,26 @@ static int btrfs_get_tree_super(struct fs_context *fc)
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
+	mutex_unlock(&uuid_mutex);
+
 	fs_info->fs_devices = fs_devices;
 
-	ret = btrfs_open_devices(fs_devices, mode, &btrfs_fs_type);
-	mutex_unlock(&uuid_mutex);
-	if (ret)
-		return ret;
-
-	if (!(fc->sb_flags & SB_RDONLY) && fs_devices->rw_devices == 0)
-		return -EACCES;
-
-	bdev = fs_devices->latest_dev->bdev;
-
 	sb = sget_fc(fc, btrfs_fc_test_super, set_anon_super_fc);
-	if (IS_ERR(sb))
+	if (IS_ERR(sb)) {
+		mutex_lock(&uuid_mutex);
+		btrfs_fs_devices_dec_holding(fs_devices);
+		mutex_unlock(&uuid_mutex);
 		return PTR_ERR(sb);
+	}
 
 	set_device_specific_options(fs_info);
 
@@ -1888,12 +1890,18 @@ static int btrfs_get_tree_super(struct fs_context *fc)
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
+		mutex_unlock(&uuid_mutex);
+		/*
+		 * But the fs_info->fs_devices is not opened, we should not let
+		 * btrfs_free_fs_context() to close them.
+		 */
+		fs_info->fs_devices = NULL;
+
 		/*
 		 * At this stage we may have RO flag mismatch between
 		 * fc->sb_flags and sb->s_flags.  Caller should detect such
@@ -1901,6 +1909,8 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 		 * needed.
 		 */
 	} else {
+		struct block_device *bdev;
+
 		/*
 		 * The first mount of the fs thus a new superblock, fc->s_fs_info
 		 * should be NULL, and the owner ship of our fs_info and fs_devices is
@@ -1908,6 +1918,19 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 		 */
 		ASSERT(fc->s_fs_info == NULL);
 
+		mutex_lock(&uuid_mutex);
+		btrfs_fs_devices_dec_holding(fs_devices);
+		ret = btrfs_open_devices(fs_devices, mode, &btrfs_fs_type);
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
index 3e701790dde9..f02551f65366 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -414,6 +414,7 @@ static void free_fs_devices(struct btrfs_fs_devices *fs_devices)
 	struct btrfs_device *device;
 
 	WARN_ON(fs_devices->opened);
+	WARN_ON(fs_devices->holding);
 	while (!list_empty(&fs_devices->devices)) {
 		device = list_first_entry(&fs_devices->devices,
 					  struct btrfs_device, dev_list);
@@ -541,7 +542,7 @@ static int btrfs_free_stale_devices(dev_t devt, struct btrfs_device *skip_device
 				continue;
 			if (devt && devt != device->devt)
 				continue;
-			if (fs_devices->opened) {
+			if (fs_devices->opened || fs_devices->holding) {
 				if (devt)
 					ret = -EBUSY;
 				break;
@@ -1197,7 +1198,7 @@ void btrfs_close_devices(struct btrfs_fs_devices *fs_devices)
 
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
2.49.0


