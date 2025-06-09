Return-Path: <linux-btrfs+bounces-14568-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D93AD24CB
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jun 2025 19:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5BCE7A85E0
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jun 2025 17:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07B821CA03;
	Mon,  9 Jun 2025 17:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZPDOtYU0";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZPDOtYU0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5771821C189
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Jun 2025 17:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749489001; cv=none; b=XAqdWWDCpma5JLIgg5enrlmG8qlTKznBHM5PHUL6W+1urb4cAJgFp+SJOA+zW1ZH2tZkPC1/ZSD6SmDVYn52myQn8kHAyIo1/LGLAtDMoavjBxPu3bBPd3TPRQoYMaXlz2hQ+FxqDhYyzUpSyd2UpRriGga+tW9heWzpI0maH54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749489001; c=relaxed/simple;
	bh=zLbm1mRHgjbTfvc0qaZFbIhxYhp0i1gq4JxKXN3eTwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Opf8+weWpFxGxJYRGeauupHeQ1+ImnERiVAYANwOUldcsr5aYGUDA3uOdupRibFx4JM113kJP2BCoTGYKg3jOo6XyrMkmsT/rSxz58nkHHN+AaiSNZY+7q82kJ5mDHgxmTJ0S48ODu31mYPFRdHGSGw3Lsc902RLF2P0zAEctc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZPDOtYU0; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZPDOtYU0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8F5AF1F78B;
	Mon,  9 Jun 2025 17:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749488985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rBrl3J74PEVN/OqZVou6no9Ah8GUW70wqCaj4bamVLE=;
	b=ZPDOtYU0BFOutjwtRT7bE9qUzSbLu9Q+7KdWWbR4SidTdrq0Rx6kgMyE2g7maCnJ6X//41
	8hr17Z1zlQnyZ0KG6azovLwNcg84lEol1i+Ge7zgPeJQ9tUNbVvE5DBfrFU0MhEWXD1VpO
	jK3qtee23lMXOvbDnLXsSdD7F2EpCys=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=ZPDOtYU0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749488985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rBrl3J74PEVN/OqZVou6no9Ah8GUW70wqCaj4bamVLE=;
	b=ZPDOtYU0BFOutjwtRT7bE9qUzSbLu9Q+7KdWWbR4SidTdrq0Rx6kgMyE2g7maCnJ6X//41
	8hr17Z1zlQnyZ0KG6azovLwNcg84lEol1i+Ge7zgPeJQ9tUNbVvE5DBfrFU0MhEWXD1VpO
	jK3qtee23lMXOvbDnLXsSdD7F2EpCys=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 87F4D137FE;
	Mon,  9 Jun 2025 17:09:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vPwuIVkVR2iSHAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 09 Jun 2025 17:09:45 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 05/11] btrfs: switch RCU helper versions to btrfs_err()
Date: Mon,  9 Jun 2025 19:09:25 +0200
Message-ID: <1afa8ec8e5e9aabff273b5901f38c27206675c89.1749488829.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749488829.git.dsterba@suse.com>
References: <cover.1749488829.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 8F5AF1F78B
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.01
X-Spam-Level: 

The RCU protection is now done in the plain helpers, we can remove the
"_in_rcu" and "_rl_in_rcu".

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/dev-replace.c |  2 +-
 fs/btrfs/messages.h    |  4 ----
 fs/btrfs/scrub.c       | 10 +++++-----
 fs/btrfs/volumes.c     |  2 +-
 fs/btrfs/zoned.c       | 22 +++++++++++-----------
 5 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 2decb9fff44519..0e9acedd7bb467 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -943,7 +943,7 @@ static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
 								tgt_device);
 	} else {
 		if (scrub_ret != -ECANCELED)
-			btrfs_err_in_rcu(fs_info,
+			btrfs_err(fs_info,
 				 "btrfs_scrub_dev(%s, %llu, %s) failed %d",
 				 btrfs_dev_name(src_device),
 				 src_device->devid,
diff --git a/fs/btrfs/messages.h b/fs/btrfs/messages.h
index fe9a92da6b1439..f9f68a2a769792 100644
--- a/fs/btrfs/messages.h
+++ b/fs/btrfs/messages.h
@@ -54,8 +54,6 @@ void _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...);
  */
 #define btrfs_crit_in_rcu(fs_info, fmt, args...) \
 	btrfs_printk_in_rcu(fs_info, KERN_CRIT fmt, ##args)
-#define btrfs_err_in_rcu(fs_info, fmt, args...) \
-	btrfs_printk_in_rcu(fs_info, KERN_ERR fmt, ##args)
 #define btrfs_warn_in_rcu(fs_info, fmt, args...) \
 	btrfs_printk_in_rcu(fs_info, KERN_WARNING fmt, ##args)
 #define btrfs_info_in_rcu(fs_info, fmt, args...) \
@@ -66,8 +64,6 @@ void _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...);
  */
 #define btrfs_crit_rl_in_rcu(fs_info, fmt, args...) \
 	btrfs_printk_rl_in_rcu(fs_info, KERN_CRIT fmt, ##args)
-#define btrfs_err_rl_in_rcu(fs_info, fmt, args...) \
-	btrfs_printk_rl_in_rcu(fs_info, KERN_ERR fmt, ##args)
 #define btrfs_warn_rl_in_rcu(fs_info, fmt, args...) \
 	btrfs_printk_rl_in_rcu(fs_info, KERN_WARNING fmt, ##args)
 #define btrfs_info_rl_in_rcu(fs_info, fmt, args...) \
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index e8fa2775456376..04c43f05afc9fa 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1045,12 +1045,12 @@ static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
 		 */
 		if (repaired) {
 			if (dev) {
-				btrfs_err_rl_in_rcu(fs_info,
+				btrfs_err_rl(fs_info,
 		"scrub: fixed up error at logical %llu on dev %s physical %llu",
 					    stripe->logical, btrfs_dev_name(dev),
 					    physical);
 			} else {
-				btrfs_err_rl_in_rcu(fs_info,
+				btrfs_err_rl(fs_info,
 			   "scrub: fixed up error at logical %llu on mirror %u",
 					    stripe->logical, stripe->mirror_num);
 			}
@@ -1059,12 +1059,12 @@ static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
 
 		/* The remaining are all for unrepaired. */
 		if (dev) {
-			btrfs_err_rl_in_rcu(fs_info,
+			btrfs_err_rl(fs_info,
 "scrub: unable to fixup (regular) error at logical %llu on dev %s physical %llu",
 					    stripe->logical, btrfs_dev_name(dev),
 					    physical);
 		} else {
-			btrfs_err_rl_in_rcu(fs_info,
+			btrfs_err_rl(fs_info,
 	  "scrub: unable to fixup (regular) error at logical %llu on mirror %u",
 					    stripe->logical, stripe->mirror_num);
 		}
@@ -3057,7 +3057,7 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 	if (!is_dev_replace && !readonly &&
 	    !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state)) {
 		mutex_unlock(&fs_info->fs_devices->device_list_mutex);
-		btrfs_err_in_rcu(fs_info,
+		btrfs_err(fs_info,
 			"scrub: devid %llu: filesystem on %s is not writable",
 				 devid, btrfs_dev_name(dev));
 		ret = -EROFS;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 70821a46bfb358..9c5625a06e0b12 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7796,7 +7796,7 @@ void btrfs_dev_stat_inc_and_print(struct btrfs_device *dev, int index)
 
 	if (!dev->dev_stats_valid)
 		return;
-	btrfs_err_rl_in_rcu(dev->fs_info,
+	btrfs_err_rl(dev->fs_info,
 		"bdev %s errs: wr %u, rd %u, flush %u, corrupt %u, gen %u",
 			   btrfs_dev_name(dev),
 			   btrfs_dev_stat_read(dev, BTRFS_DEV_STAT_WRITE_ERRS),
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index d416df1e0d2c92..18848a9756d142 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -263,7 +263,7 @@ static int btrfs_get_dev_zones(struct btrfs_device *device, u64 pos,
 	ret = blkdev_report_zones(device->bdev, pos >> SECTOR_SHIFT, *nr_zones,
 				  copy_zone_info_cb, zones);
 	if (ret < 0) {
-		btrfs_err_in_rcu(device->fs_info,
+		btrfs_err(device->fs_info,
 				 "zoned: failed to read zone %llu on %s (devid %llu)",
 				 pos, rcu_str_deref(device->name),
 				 device->devid);
@@ -395,14 +395,14 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 
 	/* We reject devices with a zone size larger than 8GB */
 	if (zone_info->zone_size > BTRFS_MAX_ZONE_SIZE) {
-		btrfs_err_in_rcu(fs_info,
+		btrfs_err(fs_info,
 		"zoned: %s: zone size %llu larger than supported maximum %llu",
 				 rcu_str_deref(device->name),
 				 zone_info->zone_size, BTRFS_MAX_ZONE_SIZE);
 		ret = -EINVAL;
 		goto out;
 	} else if (zone_info->zone_size < BTRFS_MIN_ZONE_SIZE) {
-		btrfs_err_in_rcu(fs_info,
+		btrfs_err(fs_info,
 		"zoned: %s: zone size %llu smaller than supported minimum %u",
 				 rcu_str_deref(device->name),
 				 zone_info->zone_size, BTRFS_MIN_ZONE_SIZE);
@@ -418,7 +418,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 
 	max_active_zones = bdev_max_active_zones(bdev);
 	if (max_active_zones && max_active_zones < BTRFS_MIN_ACTIVE_ZONES) {
-		btrfs_err_in_rcu(fs_info,
+		btrfs_err(fs_info,
 "zoned: %s: max active zones %u is too small, need at least %u active zones",
 				 rcu_str_deref(device->name), max_active_zones,
 				 BTRFS_MIN_ACTIVE_ZONES);
@@ -460,7 +460,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 		zone_info->zone_cache = vcalloc(zone_info->nr_zones,
 						sizeof(struct blk_zone));
 		if (!zone_info->zone_cache) {
-			btrfs_err_in_rcu(device->fs_info,
+			btrfs_err(device->fs_info,
 				"zoned: failed to allocate zone cache for %s",
 				rcu_str_deref(device->name));
 			ret = -ENOMEM;
@@ -497,7 +497,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 	}
 
 	if (nreported != zone_info->nr_zones) {
-		btrfs_err_in_rcu(device->fs_info,
+		btrfs_err(device->fs_info,
 				 "inconsistent number of zones on %s (%u/%u)",
 				 rcu_str_deref(device->name), nreported,
 				 zone_info->nr_zones);
@@ -507,7 +507,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 
 	if (max_active_zones) {
 		if (nactive > max_active_zones) {
-			btrfs_err_in_rcu(device->fs_info,
+			btrfs_err(device->fs_info,
 			"zoned: %u active zones on %s exceeds max_active_zones %u",
 					 nactive, rcu_str_deref(device->name),
 					 max_active_zones);
@@ -538,7 +538,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 			goto out;
 
 		if (nr_zones != BTRFS_NR_SB_LOG_ZONES) {
-			btrfs_err_in_rcu(device->fs_info,
+			btrfs_err(device->fs_info,
 	"zoned: failed to read super block log zone info at devid %llu zone %u",
 					 device->devid, sb_zone);
 			ret = -EUCLEAN;
@@ -556,7 +556,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 		ret = sb_write_pointer(device->bdev,
 				       &zone_info->sb_zones[sb_pos], &sb_wp);
 		if (ret != -ENOENT && ret) {
-			btrfs_err_in_rcu(device->fs_info,
+			btrfs_err(device->fs_info,
 			"zoned: super block log zone corrupted devid %llu zone %u",
 					 device->devid, sb_zone);
 			ret = -EUCLEAN;
@@ -1345,7 +1345,7 @@ static int btrfs_load_zone_info(struct btrfs_fs_info *fs_info, int zone_idx,
 	}
 
 	if (zone.type == BLK_ZONE_TYPE_CONVENTIONAL) {
-		btrfs_err_in_rcu(fs_info,
+		btrfs_err(fs_info,
 		"zoned: unexpected conventional zone %llu on device %s (devid %llu)",
 			zone.start << SECTOR_SHIFT, rcu_str_deref(device->name),
 			device->devid);
@@ -1358,7 +1358,7 @@ static int btrfs_load_zone_info(struct btrfs_fs_info *fs_info, int zone_idx,
 	switch (zone.cond) {
 	case BLK_ZONE_COND_OFFLINE:
 	case BLK_ZONE_COND_READONLY:
-		btrfs_err_in_rcu(fs_info,
+		btrfs_err(fs_info,
 		"zoned: offline/readonly zone %llu on device %s (devid %llu)",
 			  (info->physical >> device->zone_info->zone_size_shift),
 			  rcu_str_deref(device->name), device->devid);
-- 
2.49.0


