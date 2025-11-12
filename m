Return-Path: <linux-btrfs+bounces-18916-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 34047C54504
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 21:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 448E44FD5CE
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 19:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2B134DCF9;
	Wed, 12 Nov 2025 19:37:14 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AF83557EB
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Nov 2025 19:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762976233; cv=none; b=TMnarckBvplGTdlbgXfG2vIJ0Z1GCfusnuhJNx8Y0Si2BSpZg5Txwmtxyt2CEbSwkD3b9EPnk4B670ODkls8vAqaLzMf57egtB36GgQR6zlnpOv9AJwFOpQA1gI5VmdoM2yICQ7MY6oB1yaRh1vJOZH/C8WcnQRaGSCu2CdJv10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762976233; c=relaxed/simple;
	bh=4uUxavDDm1MyVNq8AVQrYfBBwqALCkU5jsIrs/D2RT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ByWg1fwiluQ2ZA6HYfx4pmnrR/PPyTlyZdfqsa/94wSfHgvykf3ju7NP+13W8TU4+kco6Yu7pURMm/q7ge8AJmHS/yB4PuF5JEPqkDZy8bJyw//4aIi19+MUPi5X3SZV9B7XPTWYMjbY1c4YE0tcVKSchfJZtZJ2uz0gAJG0xCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 78EA921B67;
	Wed, 12 Nov 2025 19:36:44 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 62E723EA61;
	Wed, 12 Nov 2025 19:36:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6K6SF8zhFGm+YgAAD6G6ig
	(envelope-from <neelx@suse.com>); Wed, 12 Nov 2025 19:36:44 +0000
From: Daniel Vacek <neelx@suse.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: Daniel Vacek <neelx@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 8/8] btrfs: set the appropriate free space settings in reconfigure
Date: Wed, 12 Nov 2025 20:36:08 +0100
Message-ID: <20251112193611.2536093-9-neelx@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251112193611.2536093-1-neelx@suse.com>
References: <20251112193611.2536093-1-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 78EA921B67
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00

From: Josef Bacik <josef@toxicpanda.com>

btrfs/330 uncovered a problem where we were accidentally turning off the
free space tree when we do the transition from ro->rw.  This happens
because we don't update

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
Since v5 just a rebase conflict with changing API of mount_opt flags
being 64bit now.
---
 fs/btrfs/disk-io.c |  2 +-
 fs/btrfs/super.c   | 28 +++++++++++++++-------------
 fs/btrfs/super.h   |  3 ++-
 3 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 6a1fa3b08b3f..3bc7a773b900 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3399,7 +3399,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	 * Handle the space caching options appropriately now that we have the
 	 * super block loaded and validated.
 	 */
-	btrfs_set_free_space_cache_settings(fs_info);
+	btrfs_set_free_space_cache_settings(fs_info, &fs_info->mount_opt);
 
 	if (!btrfs_check_options(fs_info, &fs_info->mount_opt, sb->s_flags)) {
 		ret = -EINVAL;
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 4ffd7059e27a..f8759b856174 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -723,10 +723,10 @@ bool btrfs_check_options(const struct btrfs_fs_info *info,
 }
 
 /*
- * This is subtle, we only call this during open_ctree().  We need to pre-load
- * the mount options with the on-disk settings.  Before the new mount API took
- * effect we would do this on mount and remount.  With the new mount API we'll
- * only do this on the initial mount.
+ * Because we have an odd set of behavior with turning on and off the space cache
+ * and free space tree we have to call this before we start the mount operation
+ * after we load the super, or before we start remount.  This is to make sure we
+ * have the proper free space settings in place if the user didn't specify any.
  *
  * This isn't a change in behavior, because we're using the current state of the
  * file system to set the current mount options.  If you mounted with special
@@ -734,15 +734,16 @@ bool btrfs_check_options(const struct btrfs_fs_info *info,
  * settings, because mounting without these features cleared the on-disk
  * settings, so this being called on re-mount is not needed.
  */
-void btrfs_set_free_space_cache_settings(struct btrfs_fs_info *fs_info)
+void btrfs_set_free_space_cache_settings(struct btrfs_fs_info *fs_info,
+					 unsigned long long *mount_opt)
 {
 	if (fs_info->sectorsize < PAGE_SIZE) {
-		btrfs_clear_opt(fs_info->mount_opt, SPACE_CACHE);
-		if (!btrfs_test_opt(fs_info, FREE_SPACE_TREE)) {
+		btrfs_clear_opt(*mount_opt, SPACE_CACHE);
+		if (!btrfs_raw_test_opt(*mount_opt, FREE_SPACE_TREE)) {
 			btrfs_info(fs_info,
 				   "forcing free space tree for sector size %u with page size %lu",
 				   fs_info->sectorsize, PAGE_SIZE);
-			btrfs_set_opt(fs_info->mount_opt, FREE_SPACE_TREE);
+			btrfs_set_opt(*mount_opt, FREE_SPACE_TREE);
 		}
 	}
 
@@ -750,7 +751,7 @@ void btrfs_set_free_space_cache_settings(struct btrfs_fs_info *fs_info)
 	 * At this point our mount options are populated, so we only mess with
 	 * these settings if we don't have any settings already.
 	 */
-	if (btrfs_test_opt(fs_info, FREE_SPACE_TREE))
+	if (btrfs_raw_test_opt(*mount_opt, FREE_SPACE_TREE))
 		return;
 
 	if (btrfs_is_zoned(fs_info) &&
@@ -760,10 +761,10 @@ void btrfs_set_free_space_cache_settings(struct btrfs_fs_info *fs_info)
 		return;
 	}
 
-	if (btrfs_test_opt(fs_info, SPACE_CACHE))
+	if (btrfs_raw_test_opt(*mount_opt, SPACE_CACHE))
 		return;
 
-	if (btrfs_test_opt(fs_info, NOSPACECACHE))
+	if (btrfs_raw_test_opt(*mount_opt, NOSPACECACHE))
 		return;
 
 	/*
@@ -771,9 +772,9 @@ void btrfs_set_free_space_cache_settings(struct btrfs_fs_info *fs_info)
 	 * them ourselves based on the state of the file system.
 	 */
 	if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE))
-		btrfs_set_opt(fs_info->mount_opt, FREE_SPACE_TREE);
+		btrfs_set_opt(*mount_opt, FREE_SPACE_TREE);
 	else if (btrfs_free_space_cache_v1_active(fs_info))
-		btrfs_set_opt(fs_info->mount_opt, SPACE_CACHE);
+		btrfs_set_opt(*mount_opt, SPACE_CACHE);
 }
 
 static void set_device_specific_options(struct btrfs_fs_info *fs_info)
@@ -1523,6 +1524,7 @@ static int btrfs_reconfigure(struct fs_context *fc)
 
 	sync_filesystem(sb);
 	set_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state);
+	btrfs_set_free_space_cache_settings(fs_info, &ctx->mount_opt);
 
 	if (!btrfs_check_options(fs_info, &ctx->mount_opt, fc->sb_flags))
 		return -EINVAL;
diff --git a/fs/btrfs/super.h b/fs/btrfs/super.h
index d80a86acfbbe..584f428d36e2 100644
--- a/fs/btrfs/super.h
+++ b/fs/btrfs/super.h
@@ -16,7 +16,8 @@ bool btrfs_check_options(const struct btrfs_fs_info *info,
 int btrfs_sync_fs(struct super_block *sb, int wait);
 char *btrfs_get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
 					  u64 subvol_objectid);
-void btrfs_set_free_space_cache_settings(struct btrfs_fs_info *fs_info);
+void btrfs_set_free_space_cache_settings(struct btrfs_fs_info *fs_info,
+					 unsigned long long *mount_opt);
 
 static inline struct btrfs_fs_info *btrfs_sb(struct super_block *sb)
 {
-- 
2.51.0


