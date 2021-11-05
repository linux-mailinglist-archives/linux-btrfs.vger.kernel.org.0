Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3BD0446A21
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233851AbhKEUwa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbhKEUw3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:52:29 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93493C061714
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:49:49 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id w4so7255506qtn.2
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=n3NtVobSpmsH1i/cX06W8Iyta/5tBVgsfEezCkVkl1o=;
        b=8D1KA0FwhYlmpclNtEeFekt5tKb36luab/NSs7ietXFlb44jqCGrhqPo77SasiLrKA
         +f/ND9hk/UqIuVi/IWKJLQpvQGcgwLJcAj1lo9FfOXsGLBIcc+xLdGTds+OsjYtgLzUU
         ppM/bfh5V2BFHWT/XFDSdyOabHIwoAyO/mkLqoF+mKozliKv+osyODr+d8e18vUuZN+3
         Mux+yb3bIndrVufW7KLlKyLhb23zmzFYRgOrn2gqGy8ruvrJyDi6+1PmjDRadE1snBwa
         edRWpwkX594tKXcK8Nv0DSy2uY7t0Ik12jZOPNLOBv5H/SStpD64/BRkWotZdVNuzWXn
         CmDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n3NtVobSpmsH1i/cX06W8Iyta/5tBVgsfEezCkVkl1o=;
        b=3euZudGqfDzMY7XbipKuo64bZ3DiSuw926kqwLhraDe7OAScCrvxlVPPwi35THCSTV
         sYUpRAjbTJA1D5Krq2yPIbIXH5zCxyRbLUDS+1/ddvKCfhZEbbfqPKIUHRYPxJqsFDmQ
         yJvJEWaZKs/tMPTfD0t6rEeB9KZj2NiWWbCZFBvLAhnNCoYl4KBBwyoOK6st4CWAUcRQ
         GoZ/G6MvWTynuR78mNG7DPcsgxV2Z4aE+tC3mKCSs5tJj2CAWfNgavUso6GRbp8n0zaT
         YeB7cx7/nMXjpQdOJ0Z1BzE/rDveKWvVWXyYDhVW/hnxhmOe8GerG989bc2+iZe0iwyB
         XzNg==
X-Gm-Message-State: AOAM533GXN3uGDuLKDvsfzRwXasUkkGVk457csoq2c3p19YvjldvGbjL
        RfvnVXBBi6f2D0Cjhr8uGgwC0f/p7LQnZA==
X-Google-Smtp-Source: ABdhPJxrC9H9km/cBKyj3DkL0gpzdOYmN/q4/UI05nKHpxP0hB9wVZB8OIR6lyOVNkGv7JjZ3NA49w==
X-Received: by 2002:a05:622a:52:: with SMTP id y18mr52219316qtw.177.1636145388499;
        Fri, 05 Nov 2021 13:49:48 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t64sm5970582qkd.71.2021.11.05.13.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:49:48 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/8] btrfs: add definition for EXTENT_TREE_V2
Date:   Fri,  5 Nov 2021 16:49:38 -0400
Message-Id: <42ddabba00246b7264e6c0bebc25b227e00e4bfb.1636145221.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636145221.git.josef@toxicpanda.com>
References: <cover.1636145221.git.josef@toxicpanda.com>
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
index d32aa0fe1415..8ec2f068a1c2 100644
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
index f9eff3b0f77c..36f545ae1264 100644
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
index c1a665d87f61..bd29869448e3 100644
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

