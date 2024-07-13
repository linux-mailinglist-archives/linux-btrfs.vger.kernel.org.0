Return-Path: <linux-btrfs+bounces-6439-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D11BB9304EF
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Jul 2024 12:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43015B211B5
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Jul 2024 10:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8485FDA5;
	Sat, 13 Jul 2024 10:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TeVCbyLE";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TeVCbyLE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9720D3B782
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Jul 2024 10:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720865721; cv=none; b=KU636OR0KRMozamxFhoznbD5Br/kIhFmmiwGteAje5jBhW1dorpBMJBsgzP+ui2YAQIGiF+mbPr1USClorVy8m/nOTSFv44SgGkE1MmM4WGnKTyfwtZ+0a6QoSPBK8UPVI11F2JvikKFh0JSzipbGcZKBt6QR55/JpwNSN0IEo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720865721; c=relaxed/simple;
	bh=lTJWqhI7jNHxq6kYkMa5uXCxPFtl3anld/PfrUCUGkk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=d0MVzhRpXAs6rHSntvuu1qFje8VchI6+Fkuwmzb9FTYVG54xdg44dlkfJSNRGSnTkKt/+GhcTJmmy9R+8zdCWtQiT7NAYTPgrs9kWC+gPN9+hSctbg1LFiXuMo6/hsHbXZeOk1QTinJEVfYIRAQff7bdPpt/5yusIXhJ6SUemy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TeVCbyLE; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TeVCbyLE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A2A9121AFE
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Jul 2024 10:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1720865717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=96ms7d2C0izBdkhmuWRueLF6+rm+FQkcWsZ1QKUUz3U=;
	b=TeVCbyLEcRn5MwKrlM57N+qXQa0qksEJAyUpiqJyCJ8mKWkfsy+tYrz308QVV9tceJWOmv
	8AZcjSWvJOFNzSO08zULcCG1ryZgWQNIDumkgk05YHNPbUHEDJc3d6/23NHQyLApsCrDoY
	4P5ZMhiZq0XUxBBe0Q5P4M7UZ8G3IsA=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=TeVCbyLE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1720865717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=96ms7d2C0izBdkhmuWRueLF6+rm+FQkcWsZ1QKUUz3U=;
	b=TeVCbyLEcRn5MwKrlM57N+qXQa0qksEJAyUpiqJyCJ8mKWkfsy+tYrz308QVV9tceJWOmv
	8AZcjSWvJOFNzSO08zULcCG1ryZgWQNIDumkgk05YHNPbUHEDJc3d6/23NHQyLApsCrDoY
	4P5ZMhiZq0XUxBBe0Q5P4M7UZ8G3IsA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9FDF6134AB
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Jul 2024 10:15:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IVkuFrRTkmbXEQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Jul 2024 10:15:16 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: change BTRFS_MOUNT_* flags to 64bits
Date: Sat, 13 Jul 2024 19:45:08 +0930
Message-ID: <0955d2c5675a7fe3146292aaa766755f22bcd94b.1720865683.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A2A9121AFE
X-Spam-Flag: NO
X-Spam-Score: 0.99
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.99 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Level: 
X-Spamd-Bar: /

Currently the BTRFS_MOUNT_* flags is already reaching 32 bits, and with
the incoming new rescue options, we're going beyond the width of 32
bits.

This is going to cause problems as for quite some 32 bit systems,
1ULL << 32 would overflow the width of unsigned long.

Fix the problem by:

- Migrate all existing BTRFS_MOUNT_* flags to unsigned long long
- Migrate all mount option related variables to unsigned long long
  * btrfs_fs_info::mount_opt
  * btrfs_fs_context::mount_opt
  * mount_opt parameter of btrfs_check_options()
  * old_opts parameter of btrfs_remount_begin()
  * old_opts parameter of btrfs_remount_cleanup()
  * mount_opt parameter of btrfs_check_mountopts_zoned()
  * mount_opt and opt parameters of check_ro_option()

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
The current patch is still based on the latest for-next branch.

But during merge time I will move this before the new rescue options.

Changelog:
v2:
- Also fix the parameters of mount options
  Or 32bit systems would still fail to compile.
---
 fs/btrfs/fs.h    | 66 ++++++++++++++++++++++++------------------------
 fs/btrfs/super.c | 11 ++++----
 fs/btrfs/super.h |  3 ++-
 fs/btrfs/zoned.c |  3 ++-
 fs/btrfs/zoned.h |  5 ++--
 5 files changed, 46 insertions(+), 42 deletions(-)

diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index e911e0a838a2..103f0b3813b2 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -195,38 +195,38 @@ enum {
  * Note: don't forget to add new options to btrfs_show_options()
  */
 enum {
-	BTRFS_MOUNT_NODATASUM			= (1UL << 0),
-	BTRFS_MOUNT_NODATACOW			= (1UL << 1),
-	BTRFS_MOUNT_NOBARRIER			= (1UL << 2),
-	BTRFS_MOUNT_SSD				= (1UL << 3),
-	BTRFS_MOUNT_DEGRADED			= (1UL << 4),
-	BTRFS_MOUNT_COMPRESS			= (1UL << 5),
-	BTRFS_MOUNT_NOTREELOG   		= (1UL << 6),
-	BTRFS_MOUNT_FLUSHONCOMMIT		= (1UL << 7),
-	BTRFS_MOUNT_SSD_SPREAD			= (1UL << 8),
-	BTRFS_MOUNT_NOSSD			= (1UL << 9),
-	BTRFS_MOUNT_DISCARD_SYNC		= (1UL << 10),
-	BTRFS_MOUNT_FORCE_COMPRESS      	= (1UL << 11),
-	BTRFS_MOUNT_SPACE_CACHE			= (1UL << 12),
-	BTRFS_MOUNT_CLEAR_CACHE			= (1UL << 13),
-	BTRFS_MOUNT_USER_SUBVOL_RM_ALLOWED	= (1UL << 14),
-	BTRFS_MOUNT_ENOSPC_DEBUG		= (1UL << 15),
-	BTRFS_MOUNT_AUTO_DEFRAG			= (1UL << 16),
-	BTRFS_MOUNT_USEBACKUPROOT		= (1UL << 17),
-	BTRFS_MOUNT_SKIP_BALANCE		= (1UL << 18),
-	BTRFS_MOUNT_PANIC_ON_FATAL_ERROR	= (1UL << 19),
-	BTRFS_MOUNT_RESCAN_UUID_TREE		= (1UL << 20),
-	BTRFS_MOUNT_FRAGMENT_DATA		= (1UL << 21),
-	BTRFS_MOUNT_FRAGMENT_METADATA		= (1UL << 22),
-	BTRFS_MOUNT_FREE_SPACE_TREE		= (1UL << 23),
-	BTRFS_MOUNT_NOLOGREPLAY			= (1UL << 24),
-	BTRFS_MOUNT_REF_VERIFY			= (1UL << 25),
-	BTRFS_MOUNT_DISCARD_ASYNC		= (1UL << 26),
-	BTRFS_MOUNT_IGNOREBADROOTS		= (1UL << 27),
-	BTRFS_MOUNT_IGNOREDATACSUMS		= (1UL << 28),
-	BTRFS_MOUNT_NODISCARD			= (1UL << 29),
-	BTRFS_MOUNT_NOSPACECACHE		= (1UL << 30),
-	BTRFS_MOUNT_IGNOREMETACSUMS		= (1UL << 31),
+	BTRFS_MOUNT_NODATASUM			= (1ULL << 0),
+	BTRFS_MOUNT_NODATACOW			= (1ULL << 1),
+	BTRFS_MOUNT_NOBARRIER			= (1ULL << 2),
+	BTRFS_MOUNT_SSD				= (1ULL << 3),
+	BTRFS_MOUNT_DEGRADED			= (1ULL << 4),
+	BTRFS_MOUNT_COMPRESS			= (1ULL << 5),
+	BTRFS_MOUNT_NOTREELOG			= (1ULL << 6),
+	BTRFS_MOUNT_FLUSHONCOMMIT		= (1ULL << 7),
+	BTRFS_MOUNT_SSD_SPREAD			= (1ULL << 8),
+	BTRFS_MOUNT_NOSSD			= (1ULL << 9),
+	BTRFS_MOUNT_DISCARD_SYNC		= (1ULL << 10),
+	BTRFS_MOUNT_FORCE_COMPRESS		= (1ULL << 11),
+	BTRFS_MOUNT_SPACE_CACHE			= (1ULL << 12),
+	BTRFS_MOUNT_CLEAR_CACHE			= (1ULL << 13),
+	BTRFS_MOUNT_USER_SUBVOL_RM_ALLOWED	= (1ULL << 14),
+	BTRFS_MOUNT_ENOSPC_DEBUG		= (1ULL << 15),
+	BTRFS_MOUNT_AUTO_DEFRAG			= (1ULL << 16),
+	BTRFS_MOUNT_USEBACKUPROOT		= (1ULL << 17),
+	BTRFS_MOUNT_SKIP_BALANCE		= (1ULL << 18),
+	BTRFS_MOUNT_PANIC_ON_FATAL_ERROR	= (1ULL << 19),
+	BTRFS_MOUNT_RESCAN_UUID_TREE		= (1ULL << 20),
+	BTRFS_MOUNT_FRAGMENT_DATA		= (1ULL << 21),
+	BTRFS_MOUNT_FRAGMENT_METADATA		= (1ULL << 22),
+	BTRFS_MOUNT_FREE_SPACE_TREE		= (1ULL << 23),
+	BTRFS_MOUNT_NOLOGREPLAY			= (1ULL << 24),
+	BTRFS_MOUNT_REF_VERIFY			= (1ULL << 25),
+	BTRFS_MOUNT_DISCARD_ASYNC		= (1ULL << 26),
+	BTRFS_MOUNT_IGNOREBADROOTS		= (1ULL << 27),
+	BTRFS_MOUNT_IGNOREDATACSUMS		= (1ULL << 28),
+	BTRFS_MOUNT_NODISCARD			= (1ULL << 29),
+	BTRFS_MOUNT_NOSPACECACHE		= (1ULL << 30),
+	BTRFS_MOUNT_IGNOREMETACSUMS		= (1ULL << 31),
 	BTRFS_MOUNT_IGNORESUPERFLAGS		= (1ULL << 32),
 };
 
@@ -481,7 +481,7 @@ struct btrfs_fs_info {
 	 * required instead of the faster short fsync log commits
 	 */
 	u64 last_trans_log_full_commit;
-	unsigned long mount_opt;
+	unsigned long long mount_opt;
 
 	unsigned long compress_type:4;
 	unsigned int compress_level;
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 0eda8c21d861..08d33cb372fb 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -82,7 +82,7 @@ struct btrfs_fs_context {
 	u32 commit_interval;
 	u32 metadata_ratio;
 	u32 thread_pool_size;
-	unsigned long mount_opt;
+	unsigned long long mount_opt;
 	unsigned long compress_type:4;
 	unsigned int compress_level;
 	refcount_t refs;
@@ -642,7 +642,7 @@ static void btrfs_clear_oneshot_options(struct btrfs_fs_info *fs_info)
 }
 
 static bool check_ro_option(const struct btrfs_fs_info *fs_info,
-			    unsigned long mount_opt, unsigned long opt,
+			    unsigned long long mount_opt, unsigned long long opt,
 			    const char *opt_name)
 {
 	if (mount_opt & opt) {
@@ -653,7 +653,8 @@ static bool check_ro_option(const struct btrfs_fs_info *fs_info,
 	return false;
 }
 
-bool btrfs_check_options(const struct btrfs_fs_info *info, unsigned long *mount_opt,
+bool btrfs_check_options(const struct btrfs_fs_info *info,
+			 unsigned long long *mount_opt,
 			 unsigned long flags)
 {
 	bool ret = true;
@@ -1231,7 +1232,7 @@ static void btrfs_resize_thread_pool(struct btrfs_fs_info *fs_info,
 }
 
 static inline void btrfs_remount_begin(struct btrfs_fs_info *fs_info,
-				       unsigned long old_opts, int flags)
+				       unsigned long long old_opts, int flags)
 {
 	if (btrfs_raw_test_opt(old_opts, AUTO_DEFRAG) &&
 	    (!btrfs_raw_test_opt(fs_info->mount_opt, AUTO_DEFRAG) ||
@@ -1245,7 +1246,7 @@ static inline void btrfs_remount_begin(struct btrfs_fs_info *fs_info,
 }
 
 static inline void btrfs_remount_cleanup(struct btrfs_fs_info *fs_info,
-					 unsigned long old_opts)
+					 unsigned long long old_opts)
 {
 	const bool cache_opt = btrfs_test_opt(fs_info, SPACE_CACHE);
 
diff --git a/fs/btrfs/super.h b/fs/btrfs/super.h
index d2b8ebb46bc6..d80a86acfbbe 100644
--- a/fs/btrfs/super.h
+++ b/fs/btrfs/super.h
@@ -10,7 +10,8 @@
 struct super_block;
 struct btrfs_fs_info;
 
-bool btrfs_check_options(const struct btrfs_fs_info *info, unsigned long *mount_opt,
+bool btrfs_check_options(const struct btrfs_fs_info *info,
+			 unsigned long long *mount_opt,
 			 unsigned long flags);
 int btrfs_sync_fs(struct super_block *sb, int wait);
 char *btrfs_get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index df7733044f7e..66f63e82af79 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -767,7 +767,8 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 	return 0;
 }
 
-int btrfs_check_mountopts_zoned(const struct btrfs_fs_info *info, unsigned long *mount_opt)
+int btrfs_check_mountopts_zoned(const struct btrfs_fs_info *info,
+				unsigned long long *mount_opt)
 {
 	if (!btrfs_is_zoned(info))
 		return 0;
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index d66d00c08001..30b2e48a1cec 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -58,7 +58,8 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache);
 void btrfs_destroy_dev_zone_info(struct btrfs_device *device);
 struct btrfs_zoned_device_info *btrfs_clone_dev_zone_info(struct btrfs_device *orig_dev);
 int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info);
-int btrfs_check_mountopts_zoned(const struct btrfs_fs_info *info, unsigned long *mount_opt);
+int btrfs_check_mountopts_zoned(const struct btrfs_fs_info *info,
+				unsigned long long *mount_opt);
 int btrfs_sb_log_location_bdev(struct block_device *bdev, int mirror, int rw,
 			       u64 *bytenr_ret);
 int btrfs_sb_log_location(struct btrfs_device *device, int mirror, int rw,
@@ -130,7 +131,7 @@ static inline int btrfs_check_zoned_mode(const struct btrfs_fs_info *fs_info)
 }
 
 static inline int btrfs_check_mountopts_zoned(const struct btrfs_fs_info *info,
-					      unsigned long *mount_opt)
+					      unsigned long long *mount_opt)
 {
 	return 0;
 }
-- 
2.45.2


