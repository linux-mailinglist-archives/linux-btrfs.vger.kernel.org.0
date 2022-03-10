Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1994D510E
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Mar 2022 18:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245194AbiCJR71 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Mar 2022 12:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236272AbiCJR70 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Mar 2022 12:59:26 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38C0E6DA7
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Mar 2022 09:58:24 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id 85so5035246qkm.9
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Mar 2022 09:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=0Pd0yGByMBKF9UCW8sFy1Wlpf1ABipSJTZM3Ilm85ek=;
        b=JkrvfQ3wHhY8nJxHceAT8kheO8z+Oe67qp4dJFcek9XZ13lLsPrsdD88udnuShpCo0
         1sct3n2DF3RHnl/GrDYaDxYl0DNgsEOVo8wA8OgFWP4UWQFqgTJDHlt6xhdubb2BFc+x
         c+SiAkzM38EjbbUpIcubPTYquwW9Zma0zxlF83xsT5Wc3G+WR5IPMe9yvLqUna19oThF
         hZYJPGq8NK4JPf1xRK8kV2MHi4pmdr+zU9e+u3edGzK/Qt9ZTM05If1JbQzQO6geYabQ
         oY5XPy2UZLLEK2lGV/qsGNPfaIpURhN92o2P4dVtVgdDgALL24mh7tMcj91KaOCCWTM9
         qFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Pd0yGByMBKF9UCW8sFy1Wlpf1ABipSJTZM3Ilm85ek=;
        b=V9xcmSNcgdrNF43Pb8/5lk2D/SQRRXs+ZkJioUj5f5Hj0E3ZobeDuTZ92bUnWAE5SU
         P2TcKxJE/L2yqS5JtU/ykzubT/DOhLmlpRxH0WiEkjF5yelwvfm4IQnxk143ofUMBkkr
         /aJ1AdsdT9bETz7Or3ROCJRBAICeK36z7cXTawqdws080kZd/y4P+xH2w9xWN+cc599s
         wM8xFDpepx8F3rCU2OGAtAMquuBCUYgwbdRMNfxUH5IntXDpOsbZSj5+XtKXQWfWTJ4F
         MwPiMIjiVtgyiAYob1Yg/BNCmeblyvoREZDE6qnWCtFMt8raXet7HyUP4q++86M0CPyI
         8ntA==
X-Gm-Message-State: AOAM533/dCJD5nsaIesdAFiGy8SKrz9SeX51HjNIo5vkCcAiLhOfgLlY
        yu0ySsDEmP7f4YyoEFvycZTGBX+BdETJlwUh
X-Google-Smtp-Source: ABdhPJw3fTqgU/V0fOKvmtLHZSchl2+IhvpMc03hBIz3FVoT4cWYslWJG2D0opFITFqzzQLvYrDEKg==
X-Received: by 2002:ae9:f501:0:b0:67b:2d97:93c5 with SMTP id o1-20020ae9f501000000b0067b2d9793c5mr3932282qkg.380.1646935103456;
        Thu, 10 Mar 2022 09:58:23 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a129-20020a376687000000b0067d186d953bsm2611685qkc.121.2022.03.10.09.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 09:58:23 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/3] btrfs: make the bg_reclaim_threshold per-space info
Date:   Thu, 10 Mar 2022 12:58:18 -0500
Message-Id: <5f0232b262e067282b26a4bd26bfbea440f2a329.1646934721.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646934721.git.josef@toxicpanda.com>
References: <cover.1646934721.git.josef@toxicpanda.com>
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

For !zoned file systems it's useful to have the auto reclaim feature,
however there are different use cases for !zoned, for example we may not
want to reclaim metadata chunks ever, only data chunks.  Move this sysfs
flag to per-space_info.  This won't affect current users because this
tunable only ever did anything for zoned, and that is currently hidden
behind BTRFS_CONFIG_DEBUG.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h            |  1 -
 fs/btrfs/disk-io.c          |  1 -
 fs/btrfs/free-space-cache.c |  4 +--
 fs/btrfs/space-info.c       |  9 +++++
 fs/btrfs/space-info.h       |  6 ++++
 fs/btrfs/sysfs.c            | 71 +++++++++++++++++++------------------
 fs/btrfs/zoned.h            |  6 ----
 7 files changed, 53 insertions(+), 45 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 4db17bd05a21..1953ea40755d 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1015,7 +1015,6 @@ struct btrfs_fs_info {
 	/* Reclaim partially filled block groups in the background */
 	struct work_struct reclaim_bgs_work;
 	struct list_head reclaim_bgs;
-	int bg_reclaim_threshold;
 
 	spinlock_t unused_bgs_lock;
 	struct list_head unused_bgs;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 09693ab4fde0..c135b79bf3e3 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3246,7 +3246,6 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	spin_lock_init(&fs_info->swapfile_pins_lock);
 	fs_info->swapfile_pins = RB_ROOT;
 
-	fs_info->bg_reclaim_threshold = BTRFS_DEFAULT_RECLAIM_THRESH;
 	INIT_WORK(&fs_info->reclaim_bgs_work, btrfs_reclaim_bgs_work);
 }
 
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 01a408db5683..01ac1161aec5 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2630,11 +2630,11 @@ int __btrfs_add_free_space(struct btrfs_block_group *block_group,
 static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
 					u64 bytenr, u64 size, bool used)
 {
-	struct btrfs_fs_info *fs_info = block_group->fs_info;
+	struct btrfs_space_info *sinfo = block_group->space_info;
 	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
 	u64 offset = bytenr - block_group->start;
 	u64 to_free, to_unusable;
-	const int bg_reclaim_threshold = READ_ONCE(fs_info->bg_reclaim_threshold);
+	const int bg_reclaim_threshold = READ_ONCE(sinfo->bg_reclaim_threshold);
 	bool initial = (size == block_group->length);
 	u64 reclaimable_unusable;
 
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index b87931a458eb..60d0a58c4644 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -181,6 +181,12 @@ void btrfs_clear_space_info_full(struct btrfs_fs_info *info)
 		found->full = 0;
 }
 
+/*
+ * Block groups with more than this value (percents) of unusable space will be
+ * scheduled for background reclaim.
+ */
+#define BTRFS_DEFAULT_ZONED_RECLAIM_THRESH	75
+
 static int create_space_info(struct btrfs_fs_info *info, u64 flags)
 {
 
@@ -203,6 +209,9 @@ static int create_space_info(struct btrfs_fs_info *info, u64 flags)
 	INIT_LIST_HEAD(&space_info->priority_tickets);
 	space_info->clamp = 1;
 
+	if (btrfs_is_zoned(info))
+		space_info->bg_reclaim_threshold = BTRFS_DEFAULT_ZONED_RECLAIM_THRESH;
+
 	ret = btrfs_sysfs_add_space_info_type(info, space_info);
 	if (ret)
 		return ret;
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index d841fed73492..0c45f539e3cf 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -24,6 +24,12 @@ struct btrfs_space_info {
 				   the space info if we had an ENOSPC in the
 				   allocator. */
 
+	/*
+	 * Once a block group drops below this threshold we'll schedule it for
+	 * reclaim.
+	 */
+	int bg_reclaim_threshold;
+
 	int clamp;		/* Used to scale our threshold for preemptive
 				   flushing. The value is >> clamp, so turns
 				   out to be a 2^clamp divisor. */
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 17389a42a3ab..d11ff1c55394 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -722,6 +722,41 @@ SPACE_INFO_ATTR(bytes_zone_unusable);
 SPACE_INFO_ATTR(disk_used);
 SPACE_INFO_ATTR(disk_total);
 
+static ssize_t btrfs_bg_reclaim_threshold_show(struct kobject *kobj,
+					       struct kobj_attribute *a,
+					       char *buf)
+{
+	struct btrfs_space_info *space_info = to_space_info(kobj);
+	ssize_t ret;
+
+	ret = sysfs_emit(buf, "%d\n", READ_ONCE(space_info->bg_reclaim_threshold));
+
+	return ret;
+}
+
+static ssize_t btrfs_bg_reclaim_threshold_store(struct kobject *kobj,
+						struct kobj_attribute *a,
+						const char *buf, size_t len)
+{
+	struct btrfs_space_info *space_info = to_space_info(kobj);
+	int thresh;
+	int ret;
+
+	ret = kstrtoint(buf, 10, &thresh);
+	if (ret)
+		return ret;
+
+	if (thresh != 0 && (thresh <= 50 || thresh > 100))
+		return -EINVAL;
+
+	WRITE_ONCE(space_info->bg_reclaim_threshold, thresh);
+
+	return len;
+}
+
+BTRFS_ATTR_RW(space_info, bg_reclaim_threshold, btrfs_bg_reclaim_threshold_show,
+	      btrfs_bg_reclaim_threshold_store);
+
 /*
  * Allocation information about block group types.
  *
@@ -738,6 +773,7 @@ static struct attribute *space_info_attrs[] = {
 	BTRFS_ATTR_PTR(space_info, bytes_zone_unusable),
 	BTRFS_ATTR_PTR(space_info, disk_used),
 	BTRFS_ATTR_PTR(space_info, disk_total),
+	BTRFS_ATTR_PTR(space_info, bg_reclaim_threshold),
 	NULL,
 };
 ATTRIBUTE_GROUPS(space_info);
@@ -1021,40 +1057,6 @@ static ssize_t btrfs_read_policy_store(struct kobject *kobj,
 }
 BTRFS_ATTR_RW(, read_policy, btrfs_read_policy_show, btrfs_read_policy_store);
 
-static ssize_t btrfs_bg_reclaim_threshold_show(struct kobject *kobj,
-					       struct kobj_attribute *a,
-					       char *buf)
-{
-	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
-	ssize_t ret;
-
-	ret = sysfs_emit(buf, "%d\n", READ_ONCE(fs_info->bg_reclaim_threshold));
-
-	return ret;
-}
-
-static ssize_t btrfs_bg_reclaim_threshold_store(struct kobject *kobj,
-						struct kobj_attribute *a,
-						const char *buf, size_t len)
-{
-	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
-	int thresh;
-	int ret;
-
-	ret = kstrtoint(buf, 10, &thresh);
-	if (ret)
-		return ret;
-
-	if (thresh != 0 && (thresh <= 50 || thresh > 100))
-		return -EINVAL;
-
-	WRITE_ONCE(fs_info->bg_reclaim_threshold, thresh);
-
-	return len;
-}
-BTRFS_ATTR_RW(, bg_reclaim_threshold, btrfs_bg_reclaim_threshold_show,
-	      btrfs_bg_reclaim_threshold_store);
-
 /*
  * Per-filesystem information and stats.
  *
@@ -1071,7 +1073,6 @@ static const struct attribute *btrfs_attrs[] = {
 	BTRFS_ATTR_PTR(, exclusive_operation),
 	BTRFS_ATTR_PTR(, generation),
 	BTRFS_ATTR_PTR(, read_policy),
-	BTRFS_ATTR_PTR(, bg_reclaim_threshold),
 	NULL,
 };
 
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index cbf016a7bb5d..9075c87a397e 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -10,12 +10,6 @@
 #include "block-group.h"
 #include "btrfs_inode.h"
 
-/*
- * Block groups with more than this value (percents) of unusable space will be
- * scheduled for background reclaim.
- */
-#define BTRFS_DEFAULT_RECLAIM_THRESH		75
-
 struct btrfs_zoned_device_info {
 	/*
 	 * Number of zones, zone size and types of zones if bdev is a
-- 
2.26.3

