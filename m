Return-Path: <linux-btrfs+bounces-297-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D56B77F4E18
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 18:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 891CF281442
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 17:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747A758AB0;
	Wed, 22 Nov 2023 17:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="v8O6Y+L1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC2E11F
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 09:18:08 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-dae7cc31151so6444766276.3
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 09:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1700673487; x=1701278287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gm2U8+AV3HIKEIZ5eySC82y23sckawCACxIpTjlXRdc=;
        b=v8O6Y+L1kr95Ka4eJyxUrE2+16q+L8BTuaz9QDWwO9Qj6LmIDVHLGR8BtOqPKbbJ2e
         h7+IUJBsNsLdH3GPP3aYhMwkAMLzMn6Hgz+eHrxC8OZhCHwuYe6OpPFAyBecB2PjwwNc
         b7/p/3rUWoBgNhHine4inC4gsJ4V/68NojVSoooezt9cq1d1kfuL3H0Hvb8DQmEEk+l1
         SEgkOy0J3cSi6ZSEfGYZjk71ipYs6e0DebpueRP9AUS/SUqMemuIL6IrLj3O4rIpuWJS
         n4A7kcgxEiCfBK/C7wS1ItApV+FDF6lob/M/cyzLY+fE6aNUKCx9uXsc8Y5Cl5OBnrFM
         kG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700673487; x=1701278287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gm2U8+AV3HIKEIZ5eySC82y23sckawCACxIpTjlXRdc=;
        b=MPfxNEVbD4WvOg+aO7oblCHnKJv1FronoqmIyG/OK+p6PZAh1UsYi5YZ8s808aYfF3
         MRYL7Tc2g6U4O0F2fPzpsylqJ7YOr6IL5SYcHoteHgUr4ZGxkJCyAeP0b4hGtB5+4NHY
         Ym9a9K0cgZ+tnLHV+EyO3xIo59yuYmZcTttZDYdGgSmyDTgtcSUi0q3aFgVIeqHn0lwW
         5374mY4sswXb4ErxH/LYTVnVDYw+qOBRuoAira/wdBn2nn/9ix9/f08aQlLS1RodEVIM
         pQxhgbx4G1prLsoDoZ1SeOybSrMaI+V12+t2Yj2ZZY1dbamrIUR7ZAK5oHDKEh2FQ0A2
         bftw==
X-Gm-Message-State: AOJu0YxgYfRYV4z1+HU5aaHyHjOTLik1RqZtR2bv8gFVFB+FJPd/0hK9
	0B80zYSjZ3BIXbEm8c/g2rzfCLpA5+cZktn4fMZ8VJKG
X-Google-Smtp-Source: AGHT+IFMWJ12RGBl7S1GbUGaaOg29NnqXkb/RbzoFA9to3rCAADWrsLqQpWS8HBOHnIDoJmykGQ6fw==
X-Received: by 2002:a25:820d:0:b0:da0:365d:9e21 with SMTP id q13-20020a25820d000000b00da0365d9e21mr3078318ybk.22.1700673487278;
        Wed, 22 Nov 2023 09:18:07 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id v17-20020a056902029100b00d7f06aa25c5sm1434428ybh.58.2023.11.22.09.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 09:18:06 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 04/19] btrfs: move space cache settings into open_ctree
Date: Wed, 22 Nov 2023 12:17:40 -0500
Message-ID: <8d52b2058f4fca311f8358191b6b0da60fce663b.1700673401.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1700673401.git.josef@toxicpanda.com>
References: <cover.1700673401.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently we pre-load the space cache settings in btrfs_parse_options,
however when we switch to the new mount API the mount option parsing
will happen before we have the super block loaded.  Add a helper to set
the appropriate options based on the fs settings, this will allow us to
have consistent free space cache settings.

This also folds in the space cache related decisions we make for subpage
sectorsize support, so all of this is done in one place.

Since this was being called by parse options it looks like we're
changing the behavior of remount, but in fact we aren't.  The
pre-loading of the free space cache settings is done because we want to
handle the case of users not using any space_cache options, we'll derive
the appropriate mount option based on the on disk state.  On remount
this wouldn't reset anything as we'll have cleared the v1 cache
generation if we mounted -o nospace_cache.  Similarly it's impossible to
turn off the free space tree without specifically saying -o
nospace_cache,clear_cache, which will delete the free space tree and
clear the compat_ro option.  Again in this case calling this code in
remount wouldn't result in any change.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 17 +++++---------
 fs/btrfs/super.c   | 56 +++++++++++++++++++++++++++++++++++-----------
 fs/btrfs/super.h   |  1 +
 3 files changed, 50 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 347a89f51bfc..065a2e3831d0 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3297,6 +3297,12 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	fs_info->csums_per_leaf = BTRFS_MAX_ITEM_SIZE(fs_info) / fs_info->csum_size;
 	fs_info->stripesize = stripesize;
 
+	/*
+	 * Handle the space caching options appropriately now that we have the
+	 * super loaded and validated.
+	 */
+	btrfs_set_free_space_cache_settings(fs_info);
+
 	ret = btrfs_parse_options(fs_info, options, sb->s_flags);
 	if (ret)
 		goto fail_alloc;
@@ -3308,17 +3314,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	if (sectorsize < PAGE_SIZE) {
 		struct btrfs_subpage_info *subpage_info;
 
-		/*
-		 * V1 space cache has some hardcoded PAGE_SIZE usage, and is
-		 * going to be deprecated.
-		 *
-		 * Force to use v2 cache for subpage case.
-		 */
-		btrfs_clear_opt(fs_info->mount_opt, SPACE_CACHE);
-		btrfs_set_and_info(fs_info, FREE_SPACE_TREE,
-			"forcing free space tree for sector size %u with page size %lu",
-			sectorsize, PAGE_SIZE);
-
 		btrfs_warn(fs_info,
 		"read-write for sector size %u with page size %lu is experimental",
 			   sectorsize, PAGE_SIZE);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 008e027fea15..d3b66e9c2679 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -271,6 +271,43 @@ static bool check_options(struct btrfs_fs_info *info, unsigned long flags)
 	return ret;
 }
 
+/*
+ * This is subtle, we only call this during open_ctree().  We need to pre-load
+ * the mount options with the on-disk settings.  Before the new mount API took
+ * effect we would do this on mount and remount.  With the new mount API we'll
+ * only do this on the initial mount.
+ *
+ * This isn't a change in behavior, because we're using the current state of the
+ * file system to set the current mount options.  If you mounted with special
+ * options to disable these features and then remounted we wouldn't revert the
+ * settings, because mounting without these features cleared the on-disk
+ * settings, so this being called on re-mount is not needed.
+ */
+void btrfs_set_free_space_cache_settings(struct btrfs_fs_info *fs_info)
+{
+	if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE))
+		btrfs_set_opt(fs_info->mount_opt, FREE_SPACE_TREE);
+	else if (btrfs_free_space_cache_v1_active(fs_info)) {
+		if (btrfs_is_zoned(fs_info)) {
+			btrfs_info(fs_info,
+			"zoned: clearing existing space cache");
+			btrfs_set_super_cache_generation(fs_info->super_copy, 0);
+		} else {
+			btrfs_set_opt(fs_info->mount_opt, SPACE_CACHE);
+		}
+	}
+
+	if (fs_info->sectorsize < PAGE_SIZE) {
+		btrfs_clear_opt(fs_info->mount_opt, SPACE_CACHE);
+		if (!btrfs_test_opt(fs_info, FREE_SPACE_TREE)) {
+			btrfs_info(fs_info,
+				   "forcing free space tree for sector size %u with page size %lu",
+				   fs_info->sectorsize, PAGE_SIZE);
+			btrfs_set_opt(fs_info->mount_opt, FREE_SPACE_TREE);
+		}
+	}
+}
+
 static int parse_rescue_options(struct btrfs_fs_info *info, const char *options)
 {
 	char *opts;
@@ -350,18 +387,6 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 	bool saved_compress_force;
 	int no_compress = 0;
 
-	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE))
-		btrfs_set_opt(info->mount_opt, FREE_SPACE_TREE);
-	else if (btrfs_free_space_cache_v1_active(info)) {
-		if (btrfs_is_zoned(info)) {
-			btrfs_info(info,
-			"zoned: clearing existing space cache");
-			btrfs_set_super_cache_generation(info->super_copy, 0);
-		} else {
-			btrfs_set_opt(info->mount_opt, SPACE_CACHE);
-		}
-	}
-
 	/*
 	 * Even the options are empty, we still need to do extra check
 	 * against new flags
@@ -654,8 +679,13 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 			 * compat_ro(FREE_SPACE_TREE) set, and we aren't going
 			 * to allow v1 to be set for extent tree v2, simply
 			 * ignore this setting if we're extent tree v2.
+			 *
+			 * For subpage blocksize we don't allow space cache v1,
+			 * and we'll turn on v2, so we can skip the settings
+			 * here as well.
 			 */
-			if (btrfs_fs_incompat(info, EXTENT_TREE_V2))
+			if (btrfs_fs_incompat(info, EXTENT_TREE_V2) ||
+			    info->sectorsize < PAGE_SIZE)
 				break;
 			if (token == Opt_space_cache ||
 			    strcmp(args[0].from, "v1") == 0) {
diff --git a/fs/btrfs/super.h b/fs/btrfs/super.h
index 8dbb909b364f..7c1cd7527e76 100644
--- a/fs/btrfs/super.h
+++ b/fs/btrfs/super.h
@@ -8,6 +8,7 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 int btrfs_sync_fs(struct super_block *sb, int wait);
 char *btrfs_get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
 					  u64 subvol_objectid);
+void btrfs_set_free_space_cache_settings(struct btrfs_fs_info *fs_info);
 
 static inline struct btrfs_fs_info *btrfs_sb(struct super_block *sb)
 {
-- 
2.41.0


