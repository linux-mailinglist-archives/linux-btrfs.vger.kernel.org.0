Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE2E147637D
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 21:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236265AbhLOUkN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 15:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236226AbhLOUkM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 15:40:12 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B688C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:40:12 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id fo11so202344qvb.4
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yTNA0OIzPc37SEY6xlXgJktzmw/N+3Pno+ph3U1hc3o=;
        b=2zFYHreCgvp/njjgt/sQrA6/R2cG8nVM7T1ZetA/oFGeCP3qPvyBieZ9g71D+A1tXv
         MzbOavOfDfrbWln6S2KAsIGfikJhXudVIc1rNbUmXyfte/IWdJmMYduIMI5IdyB/mVO2
         gW+65UBAhjALD9UYK9on+YcI5PZ0BOq+mE+JEc4u7c4mg498RMCvXub0j+acZdnVxGHl
         kXeAF1nHBxiqQJhCAtT9kwivR08XAU3cKAwwOPh8lc07pLu2xWaO/Mor+ms7SturR6Kc
         R9zljPIXOGRIpvcJdHQIhygFbYL/yyCABAYkTrSNOq5eyt5HwwWMZTOzp28OdPNVJvek
         mT4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yTNA0OIzPc37SEY6xlXgJktzmw/N+3Pno+ph3U1hc3o=;
        b=hvf3o7FkIrWjm3enP41URZd0AkUH4ZpBIXY+gkogRiph7+KYfUhBEENpSZtVMTeiz2
         UmZHiaUF1B2fUC5mK1ApUEkgiuyxIwvApIhWphtIWN0Wo3WKXR1cJQcl6ZHq8WZ2xcIK
         l2HVzn4MWPZtJNJawuroa8c0jP8rRPGf0vpvA2JIrNXxW0fBCpflcm133Bf3rOZYJyo8
         Z/HNijYGVtzLYtEzQQTG4ycBWf+NJ3TxV5V+caVDsNapCfS02I4lBUtpFuZYUGJx0Yk7
         Gjl1ojjdB8/7IFpw7yOvHx+uQW2K0U4joe6EQBNNpO5QvKNycGaLrE6D+4MEtpjH7u47
         n4aw==
X-Gm-Message-State: AOAM533gXgxDnS4qljSuJPXTRanR53ND762SrO2WpTbbcbDP75iMIi2b
        jh3m2H6DeKsiURdOc7GCxgOAXY52vnyPgg==
X-Google-Smtp-Source: ABdhPJxJ8xtPXrsm//kMF7XmV3Om03CcSiE9bihEBeHXmz2SM5T8+2bWZqd/uIhSKfNJjKaV7XDX9w==
X-Received: by 2002:a05:6214:76b:: with SMTP id f11mr12962411qvz.114.1639600810846;
        Wed, 15 Dec 2021 12:40:10 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d17sm2199852qtx.96.2021.12.15.12.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:40:10 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 01/11] btrfs: add definition for EXTENT_TREE_V2
Date:   Wed, 15 Dec 2021 15:39:58 -0500
Message-Id: <a7b9b688946364452d07dfaf76fb7a14fb88e414.1639600719.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1639600719.git.josef@toxicpanda.com>
References: <cover.1639600719.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This adds the initial definition of the EXTENT_TREE_V2 incompat feature
flag.  This also hides the support behind CONFIG_BTRFS_DEBUG.

THIS IS A IN DEVELOPMENT FORMAT CHANGE, DO NOT USE UNLESS YOU ARE A
DEVELOPER OR A TESTER.

The format is in flux and will be added in stages, any fs will need to
be re-made between updates to the format.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h           | 18 ++++++++++++++++++
 fs/btrfs/sysfs.c           |  5 ++++-
 include/uapi/linux/btrfs.h |  1 +
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 02f06ee02e4e..f70b6772b3ad 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -297,6 +297,23 @@ static_assert(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);
 #define BTRFS_FEATURE_COMPAT_RO_SAFE_SET	0ULL
 #define BTRFS_FEATURE_COMPAT_RO_SAFE_CLEAR	0ULL
 
+#ifdef CONFIG_BTRFS_DEBUG
+#define BTRFS_FEATURE_INCOMPAT_SUPP			\
+	(BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF |		\
+	 BTRFS_FEATURE_INCOMPAT_DEFAULT_SUBVOL |	\
+	 BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS |		\
+	 BTRFS_FEATURE_INCOMPAT_BIG_METADATA |		\
+	 BTRFS_FEATURE_INCOMPAT_COMPRESS_LZO |		\
+	 BTRFS_FEATURE_INCOMPAT_COMPRESS_ZSTD |		\
+	 BTRFS_FEATURE_INCOMPAT_RAID56 |		\
+	 BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF |		\
+	 BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA |	\
+	 BTRFS_FEATURE_INCOMPAT_NO_HOLES	|	\
+	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID	|	\
+	 BTRFS_FEATURE_INCOMPAT_RAID1C34	|	\
+	 BTRFS_FEATURE_INCOMPAT_ZONED		|	\
+	 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2)
+#else
 #define BTRFS_FEATURE_INCOMPAT_SUPP			\
 	(BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF |		\
 	 BTRFS_FEATURE_INCOMPAT_DEFAULT_SUBVOL |	\
@@ -311,6 +328,7 @@ static_assert(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);
 	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID	|	\
 	 BTRFS_FEATURE_INCOMPAT_RAID1C34	|	\
 	 BTRFS_FEATURE_INCOMPAT_ZONED)
+#endif
 
 #define BTRFS_FEATURE_INCOMPAT_SAFE_SET			\
 	(BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF)
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index beb7f72d50b8..5f4812fd8b50 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -283,9 +283,11 @@ BTRFS_FEAT_ATTR_INCOMPAT(no_holes, NO_HOLES);
 BTRFS_FEAT_ATTR_INCOMPAT(metadata_uuid, METADATA_UUID);
 BTRFS_FEAT_ATTR_COMPAT_RO(free_space_tree, FREE_SPACE_TREE);
 BTRFS_FEAT_ATTR_INCOMPAT(raid1c34, RAID1C34);
-/* Remove once support for zoned allocation is feature complete */
 #ifdef CONFIG_BTRFS_DEBUG
+/* Remove once support for zoned allocation is feature complete */
 BTRFS_FEAT_ATTR_INCOMPAT(zoned, ZONED);
+/* Remove once support for extent tree v2 is feature complete */
+BTRFS_FEAT_ATTR_INCOMPAT(extent_tree_v2, EXTENT_TREE_V2);
 #endif
 #ifdef CONFIG_FS_VERITY
 BTRFS_FEAT_ATTR_COMPAT_RO(verity, VERITY);
@@ -314,6 +316,7 @@ static struct attribute *btrfs_supported_feature_attrs[] = {
 	BTRFS_FEAT_ATTR_PTR(raid1c34),
 #ifdef CONFIG_BTRFS_DEBUG
 	BTRFS_FEAT_ATTR_PTR(zoned),
+	BTRFS_FEAT_ATTR_PTR(extent_tree_v2),
 #endif
 #ifdef CONFIG_FS_VERITY
 	BTRFS_FEAT_ATTR_PTR(verity),
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index 738619994e26..1cb1a3860f1d 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -309,6 +309,7 @@ struct btrfs_ioctl_fs_info_args {
 #define BTRFS_FEATURE_INCOMPAT_METADATA_UUID	(1ULL << 10)
 #define BTRFS_FEATURE_INCOMPAT_RAID1C34		(1ULL << 11)
 #define BTRFS_FEATURE_INCOMPAT_ZONED		(1ULL << 12)
+#define BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2	(1ULL << 13)
 
 struct btrfs_ioctl_feature_flags {
 	__u64 compat_flags;
-- 
2.26.3

