Return-Path: <linux-btrfs+bounces-6590-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F42339376B4
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 12:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 314E51C21703
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 10:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEB7839EB;
	Fri, 19 Jul 2024 10:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGjia7ad"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58949C147;
	Fri, 19 Jul 2024 10:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721385440; cv=none; b=N2r3hSyvIRh7+Xu3vHYGpJ73sjnhgNuxN1e9LTcFNG63e9H5E7MsKLj32VdbNmKjx8ZFgG7JmLlxkLCLlXIlaMLkEm5OtusLCGYz9wcsaDgpVYmz+tb9tT7FaFhwqsBKkaWy4jut6nXKh7eTaw7gPiPY80cQOAxm2stx3OATW/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721385440; c=relaxed/simple;
	bh=CDdBLp0TuwU0W0IpZjdDO83n/+Ak65R0sjY7wZeSO4c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aZOmwwjqddM/OzzIzVV9uua23gnILyx+ONqnjdRcNNmASkns9BbaCAVs8lQ20IQR2LRYoEXcJfHYDxXCGBFLHe0z9tHXv3/3Q75yuEZspB+V5Q73t4wT6j5ap44bcYP8Au5fdqWwlAIGADdrKyKZuQYDrFRaEFdqSviYVwJA9mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGjia7ad; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E125C32782;
	Fri, 19 Jul 2024 10:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721385440;
	bh=CDdBLp0TuwU0W0IpZjdDO83n/+Ak65R0sjY7wZeSO4c=;
	h=From:To:Cc:Subject:Date:From;
	b=gGjia7adp4WT2sTWe0P/MwUbNV1GtSzpxgpg9zyg+ecuGRZm+vtu90QQUuZmNGoe2
	 XQ42FzP25AGegnCK6tIT/jnYLyC/PwLB4RXVNUz9GN73Dc61MpqiL5LO97IcjfyPm+
	 +UTqD6J4dI3cD1R5Zp/m3wBVqxJLkf9060Ex/N0qBEOnLv7w3EWtRHl3f9K37oeDbT
	 8OlzLsIFlvMBz1JcGM9I4cOV9iCfIjfSaiziYh+KG7UXwJRxEl3eJyfP+75s68Zp2C
	 IWPr4p7PbieT8OQB3JTZiVXIFBZeHbVU4/suG3DIwS95Q1+GGmKMjLpaRq/oV5yEO5
	 JUhihSSiOrZcQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Qu Wenruo <wqu@suse.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Anand Jain <anand.jain@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: change mount_opt to u64
Date: Fri, 19 Jul 2024 12:37:06 +0200
Message-Id: <20240719103714.1217249-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The newly added BTRFS_MOUNT_IGNORESUPERFLAGS flag does not fit into a 32-bit
flags word, as shown by this warning on 32-bit architectures:

fs/btrfs/super.c: In function 'btrfs_check_options':
fs/btrfs/super.c:666:48: error: conversion from 'enum <anonymous>' to 'long unsigned int' changes value from '4294967296' to '0' [-Werror=overflow]
  666 |              check_ro_option(info, *mount_opt, BTRFS_MOUNT_IGNORESUPERFLAGS, "ignoresuperflags")))
      |                                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~

Change all interfaces that deal with mount flags to use a 64-bit type
on all architectures instead.

Fixes: 32e6216512b4 ("btrfs: introduce new "rescue=ignoresuperflags" mount option")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
----
Please double-check that I got all the instances. I only looked at where the
obvious users are, but did not actually try to run this on a 32-bit target
---
 fs/btrfs/fs.h    | 2 +-
 fs/btrfs/super.c | 6 +++---
 fs/btrfs/super.h | 2 +-
 fs/btrfs/zoned.c | 2 +-
 fs/btrfs/zoned.h | 4 ++--
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 1b2a7aa0af36..20900c7cc35d 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -481,7 +481,7 @@ struct btrfs_fs_info {
 	 * required instead of the faster short fsync log commits
 	 */
 	u64 last_trans_log_full_commit;
-	unsigned long mount_opt;
+	u64 mount_opt;
 
 	unsigned long compress_type:4;
 	unsigned int compress_level;
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 43052acd7a48..ea7141330e87 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -82,7 +82,7 @@ struct btrfs_fs_context {
 	u32 commit_interval;
 	u32 metadata_ratio;
 	u32 thread_pool_size;
-	unsigned long mount_opt;
+	u64 mount_opt;
 	unsigned long compress_type:4;
 	unsigned int compress_level;
 	refcount_t refs;
@@ -642,7 +642,7 @@ static void btrfs_clear_oneshot_options(struct btrfs_fs_info *fs_info)
 }
 
 static bool check_ro_option(const struct btrfs_fs_info *fs_info,
-			    unsigned long mount_opt, unsigned long opt,
+			    u64 mount_opt, u64 opt,
 			    const char *opt_name)
 {
 	if (mount_opt & opt) {
@@ -653,7 +653,7 @@ static bool check_ro_option(const struct btrfs_fs_info *fs_info,
 	return false;
 }
 
-bool btrfs_check_options(const struct btrfs_fs_info *info, unsigned long *mount_opt,
+bool btrfs_check_options(const struct btrfs_fs_info *info, u64 *mount_opt,
 			 unsigned long flags)
 {
 	bool ret = true;
diff --git a/fs/btrfs/super.h b/fs/btrfs/super.h
index d2b8ebb46bc6..98e2444c0d82 100644
--- a/fs/btrfs/super.h
+++ b/fs/btrfs/super.h
@@ -10,7 +10,7 @@
 struct super_block;
 struct btrfs_fs_info;
 
-bool btrfs_check_options(const struct btrfs_fs_info *info, unsigned long *mount_opt,
+bool btrfs_check_options(const struct btrfs_fs_info *info, u64 *mount_opt,
 			 unsigned long flags);
 int btrfs_sync_fs(struct super_block *sb, int wait);
 char *btrfs_get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index df7733044f7e..debab1ab9e71 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -767,7 +767,7 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 	return 0;
 }
 
-int btrfs_check_mountopts_zoned(const struct btrfs_fs_info *info, unsigned long *mount_opt)
+int btrfs_check_mountopts_zoned(const struct btrfs_fs_info *info, u64 *mount_opt)
 {
 	if (!btrfs_is_zoned(info))
 		return 0;
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index d66d00c08001..037697878b2a 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -58,7 +58,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache);
 void btrfs_destroy_dev_zone_info(struct btrfs_device *device);
 struct btrfs_zoned_device_info *btrfs_clone_dev_zone_info(struct btrfs_device *orig_dev);
 int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info);
-int btrfs_check_mountopts_zoned(const struct btrfs_fs_info *info, unsigned long *mount_opt);
+int btrfs_check_mountopts_zoned(const struct btrfs_fs_info *info, u64 *mount_opt);
 int btrfs_sb_log_location_bdev(struct block_device *bdev, int mirror, int rw,
 			       u64 *bytenr_ret);
 int btrfs_sb_log_location(struct btrfs_device *device, int mirror, int rw,
@@ -130,7 +130,7 @@ static inline int btrfs_check_zoned_mode(const struct btrfs_fs_info *fs_info)
 }
 
 static inline int btrfs_check_mountopts_zoned(const struct btrfs_fs_info *info,
-					      unsigned long *mount_opt)
+					      u64 *mount_opt)
 {
 	return 0;
 }
-- 
2.39.2


