Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACD404762F2
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 21:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235369AbhLOUPP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 15:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235337AbhLOUPO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 15:15:14 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51631C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:15:14 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id p3so21329499qvj.9
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JKDUzy6wGrO8q6B1WfllvjBEwY9O9kR/setUdNVwxhs=;
        b=xtU0bejt3YSLIyvRp2Nxmqb0BYFpjjTFFOCKaV6YPcmiM587JxowRG1wkzWeC9y9Oc
         3MGsx5EL6x4l6CiD2P8bbxqlFGrZoRL9UZFsfZlm7TChH8jI051hNewNeUraiC+6GLVw
         rJMSUmbxuO+pazvw5UmX/y1sRPZgT3W35r2OqyZiZIhPfksAc8bajExiFsatXUVbjam/
         7s8C93wouB23Ms+riIIpYT5UynIqfPKDhNygAasq1R80eOZMDwj6xUuV0Rix6OghXgfT
         DPUiWz+1kKF6j8MemxE6ZGOJv7jkZUCdriRu+LVRz6B/laBpZnwNelO6oIIh/7oChZ9D
         c4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JKDUzy6wGrO8q6B1WfllvjBEwY9O9kR/setUdNVwxhs=;
        b=rOsUH2d4W2DW3xHRUuse7NsGIgQnhARF6iCLkheO938hjpd73l8+eDk7qce1ECOQA1
         vRdo76uTNSPYhybR/DJDSVLwx1VM2//5ARI6SpS3j5f2d61vl9w8Skgu8o7B3reEw8Ts
         mR2/0CbvnwxUd9kWzuwZ4yY2DyIxsmzh57kU4YPiEqndqjWJM2frIHSgT/D4yUEM+78T
         e6fKotOlQECjj+sDx8F5n/o3w+Lf+gbYVqJARZcu+lpLyRZTBMeUZ/vu0Qk8B8cn2HhP
         koo6ZrxmDF7G1jkrjFqqUtSG4Q//Xk4UG3mSNsmKxNmASle5ADonNqMG+BBvYmFdxz8j
         +VSw==
X-Gm-Message-State: AOAM532gBAjuFLYobIna6PVEujtaLwlYHdgDvZj2Aw+fUbE79wsnpOQf
        8jq42y2vuVNXt6l2XRh6HWjfptNqujIV4w==
X-Google-Smtp-Source: ABdhPJxYq0iM7H8AlRNwTpKEB4yzx2B0Fss1zlFuO+iYhcJpeH20mv4NZDJ7G+Teb6vCKLB1Kqtm+g==
X-Received: by 2002:a05:6214:260e:: with SMTP id gu14mr12938313qvb.84.1639599313181;
        Wed, 15 Dec 2021 12:15:13 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t15sm2320751qta.45.2021.12.15.12.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:15:12 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 13/15] btrfs-progs: add on-disk items and read support for the gc tree
Date:   Wed, 15 Dec 2021 15:14:51 -0500
Message-Id: <a16f34b77f05bad6e9bb56b3c6b2f25b89563a37.1639598612.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1639598612.git.josef@toxicpanda.com>
References: <cover.1639598612.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This add's the necessary on disk structures for the initial garbage
collection tree.  At first we're going to just add orphan item support,
and then add other items as the support lands for those new operations.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/ctree.h      | 6 ++++++
 kernel-shared/disk-io.c    | 5 +++++
 kernel-shared/print-tree.c | 4 ++++
 3 files changed, 15 insertions(+)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 82a4a2eb..bfb59fa3 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -88,6 +88,9 @@ struct btrfs_free_space_ctl;
 /* hold the block group items. */
 #define BTRFS_BLOCK_GROUP_TREE_OBJECTID 11ULL
 
+/* hold the garbage collection items. */
+#define BTRFS_GC_TREE_OBJECTID 12ULL
+
 /* device stats in the device tree */
 #define BTRFS_DEV_STATS_OBJECTID 0ULL
 
@@ -1356,6 +1359,9 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
 #define BTRFS_XATTR_ITEM_KEY		24
 #define BTRFS_ORPHAN_ITEM_KEY		48
 
+/* Garbage collection items. */
+#define BTRFS_GC_INODE_ITEM_KEY		49
+
 #define BTRFS_DIR_LOG_ITEM_KEY  60
 #define BTRFS_DIR_LOG_INDEX_KEY 72
 /*
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 40097930..ec838221 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -1158,6 +1158,11 @@ static int load_global_roots(struct btrfs_fs_info *fs_info, unsigned flags)
 	ret = load_global_roots_objectid(fs_info, path,
 					 BTRFS_FREE_SPACE_TREE_OBJECTID, flags,
 					 "free space");
+	if (ret)
+		goto out;
+	ret = load_global_roots_objectid(fs_info, path,
+					 BTRFS_GC_TREE_OBJECTID, flags,
+					 "garbage collection");
 out:
 	btrfs_free_path(path);
 	return ret;
diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index a612c3d9..9d0d9cea 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -678,6 +678,7 @@ void print_key_type(FILE *stream, u64 objectid, u8 type)
 		[BTRFS_PERSISTENT_ITEM_KEY]	= "PERSISTENT_ITEM",
 		[BTRFS_UUID_KEY_SUBVOL]		= "UUID_KEY_SUBVOL",
 		[BTRFS_UUID_KEY_RECEIVED_SUBVOL] = "UUID_KEY_RECEIVED_SUBVOL",
+		[BTRFS_GC_INODE_ITEM_KEY]	= "GC_INODE_ITEM_KEY",
 	};
 
 	if (type == 0 && objectid == BTRFS_FREE_SPACE_OBJECTID) {
@@ -787,6 +788,9 @@ void print_objectid(FILE *stream, u64 objectid, u8 type)
 	case BTRFS_BLOCK_GROUP_TREE_OBJECTID:
 		fprintf(stream, "BLOCK_GROUP_TREE");
 		break;
+	case BTRFS_GC_TREE_OBJECTID:
+		fprintf(stream, "GC_TREE");
+		break;
 	case (u64)-1:
 		fprintf(stream, "-1");
 		break;
-- 
2.26.3

