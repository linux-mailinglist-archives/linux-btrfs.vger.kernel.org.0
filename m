Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602A87E2F84
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Nov 2023 23:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbjKFWIr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Nov 2023 17:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbjKFWIq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Nov 2023 17:08:46 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA31BD73
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Nov 2023 14:08:40 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3b5aee410f2so537395b6e.1
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Nov 2023 14:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1699308520; x=1699913320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UexHohZT1zGNjOL7yf4hKV+PGAsUG8V/5z9hjR15Oqk=;
        b=krXZnqioVUXUBH/oA9IzT839MnVk148JbEdrCLGFgtFU5G2jBYuVkmQnWWFxaqrBOG
         7N+5RlT6cre9a4c6c4vOHHX0i/JYsHbcMMPWYG69EyYNlgD6+Qns30hs5PDbUzdyDLsF
         2RwrHSgVCcZAabAbvjxBRHbidW1t66eJaxIS2IiyNngTyqAfRJeq5avAGwcs3t0xvsCI
         rYMigHfG4qVrWt5cpIMAlpjakq/3ICd4wQCCD5PWvqWfU1T8lu05tawhoOsc/hdaPo/z
         hZ1wsVfBhE7M1MOaHfl1wVetrS2yb4AXzoUGHTPJB7WyGdHRMdz8UWesFSVxAe9CW766
         OAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699308520; x=1699913320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UexHohZT1zGNjOL7yf4hKV+PGAsUG8V/5z9hjR15Oqk=;
        b=W7zSe3LIlZr2VVHjtk3hx58imTJgXKLUBu714GyQ8Otj0pHXCeL5yri0Os5NBKfMFW
         sI2c7tyWuypOvnV59AqBuMylM850Z8pX4xTvNacIp1yhSzcunQZec+ZfWIT6xxlZrcch
         P9CrBuYJ2lFEGVLAzHKXlCzoWfR3IgflADhM6HquZcOfSDiC3LvSD+FadbUY282CpBwZ
         8oF8gqSkik/hyaKX25pAggQojkU5i2FMSB9HljH2+5GWMJc1/bcss1cxpHEq6vTuXJ/R
         /f/UnN4GLUCqodUw0wuEfNIZWOqOjjeslK5ZwIap9PcoWRDQm1LlSJEhxruQAxe/Yzqx
         P1AQ==
X-Gm-Message-State: AOJu0Yy8iUQEGQiFK8dcchBcRnhj81ZCWqaD/PufYKA4ACnqsQXzOeGl
        p5YYk19/VdtkwvyUDAHPxvkQNTzS0+qPrtboDynVLw==
X-Google-Smtp-Source: AGHT+IEsSkQwqGH/Z2C3WgO1lyNjDiET3eonjemQF3MKYBkI/sWtxgXvCPTVXcEr/xCJAp9Cp+tyDw==
X-Received: by 2002:a54:4592:0:b0:3af:26e3:92e with SMTP id z18-20020a544592000000b003af26e3092emr25756972oib.28.1699308519919;
        Mon, 06 Nov 2023 14:08:39 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id u3-20020a0cb403000000b0064f43efc844sm3904755qve.32.2023.11.06.14.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 14:08:39 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org, brauner@kernel.org
Subject: [PATCH 04/18] btrfs: move space cache settings into open_ctree
Date:   Mon,  6 Nov 2023 17:08:12 -0500
Message-ID: <93c7e11e73d40b30cd086b0b32ad8b7a86060442.1699308010.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1699308010.git.josef@toxicpanda.com>
References: <cover.1699308010.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently we pre-load the space cache settings in btrfs_parse_options,
however when we switch to the new mount API the mount option parsing
will happen before we have the super block loaded.  Add a helper to set
the appropriate options based on the fs settings, this will allow us to
have consistent free space cache settings.

This also folds in the space cache related decisions we make for subpage
sectorsize support, so all of this is done in one place.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c          | 17 +++++---------
 fs/btrfs/free-space-cache.h |  1 +
 fs/btrfs/super.c            | 44 ++++++++++++++++++++++++++-----------
 fs/btrfs/super.h            |  1 +
 4 files changed, 39 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 27bbe0164425..b486cbec492b 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3287,6 +3287,12 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
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
@@ -3298,17 +3304,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
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
diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index 33b4da3271b1..dd0ed730fa7b 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -152,6 +152,7 @@ int btrfs_trim_block_group_bitmaps(struct btrfs_block_group *block_group,
 
 bool btrfs_free_space_cache_v1_active(struct btrfs_fs_info *fs_info);
 int btrfs_set_free_space_cache_v1_active(struct btrfs_fs_info *fs_info, bool active);
+
 /* Support functions for running our sanity tests */
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 int test_add_free_space_entry(struct btrfs_block_group *cache,
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 639601d346d0..aef7e67538a3 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -266,6 +266,31 @@ static bool check_options(struct btrfs_fs_info *info, unsigned long flags)
 	return true;
 }
 
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
@@ -345,18 +370,6 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
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
@@ -649,8 +662,13 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
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

