Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C38C29CAEF
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Oct 2020 22:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505132AbgJ0VIZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Oct 2020 17:08:25 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:36205 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2444432AbgJ0VIY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Oct 2020 17:08:24 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 9BF295C00C2;
        Tue, 27 Oct 2020 17:08:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 27 Oct 2020 17:08:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=bdG9zCvWQfP6R
        oOXDcCaOlaQgWijIm5uHnUYLgOe5Qg=; b=b8UY2XEdwlCPfMlqy8LhbjUDM5w7c
        sWuFnCqEabxc5AZrU0N0cL5qm11/TwFMME9+ll0YIEhMh6hGkSWqZTqSOMgy6nwN
        HydLFobFEdrGOXL/71+yqgVIxdWSKLWCYUEPrHWgfpLLGzNrKz7eNYYFDn/0VyZF
        ZpFH7IhAtSg4ghb5LQRZ7FtyVB/xYEp9enpYcht07gmgEJTZgsKsDn7G72JQKkPy
        RwTk9yoIp6919RlbZVszBwm8Cxb49SFksG/yawa442LznqM9wDg2R0pIv1l7eue8
        ZiWHP8AxHWN4O8np7xBja6/Q+nj/stHS/axnTgySZVde2eyIbYsnCyGSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=bdG9zCvWQfP6RoOXDcCaOlaQgWijIm5uHnUYLgOe5Qg=; b=qnNLTEwK
        rzqzxWIjJIMP9d6LeiWTHFssuxgxWaqXBSC8n/RdmDprLKgmihL8Q3yRbdRHJIIp
        n88hnS2xYEPoIP96jNGgr8sFfaffbMHtZza2kvvUMizUaauAMxuKGJ5IZK/7ojwA
        hF+3xwaXMNfvQdoVz7et0V+DLjYcumaLIkq4P8bubJEW8aMJsdTN1dY/5r+AxbB2
        uOFG1hu2Fld1TQCfbaZSYCP4tRQzWzBzRpHeR5lscF2BKLXqBQxMsYP3Simz8j9n
        5MXW5Hv7Pbk6cBYHaHxJ1dVkzKMSlWPveMxcZ7i1BGUlK0B9qe29L3/un9BKqpFV
        3hqSgogyLqcQiA==
X-ME-Sender: <xms:RoyYX-NkOXxFtUsCv_hvbOiIBilsu6Rx7w1ES_dSIGKt5MQHFgSkXA>
    <xme:RoyYX88CTpjh9F5Wy8uUClNxZ2rwpnT7zr-OPx3bwEb94y_v03jBWWnt6VSIT2TwN
    BHQWeu0ssj5xs3DE38>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeelgddugeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucfkphepudeifedruddugedrudefvddrfeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhioh
X-ME-Proxy: <xmx:RoyYX1SE8f_RUBUsrbufcRT76CxVIOrVe4oVq_5J8y4PkTA5XWoTPA>
    <xmx:RoyYX-s7DBEMUcwV0s4AonF7-EFkJcCZKoYgwM4XnErMomPV6MWoIw>
    <xmx:RoyYX2dp8oLB8nhWX76E4rYfP-Jfezvziw84RftBBW_9PtAxq_ExBw>
    <xmx:RoyYX-lXw3PdtFRA_Bt2H92abY_BBRzmNQ2J43-QG1D_JIQ_LJlD_w>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id BE8363280059;
        Tue, 27 Oct 2020 17:08:21 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Boris Burkov <boris@bur.io>
Subject: [PATCH v5 01/10] btrfs: lift rw mount setup from mount and remount
Date:   Tue, 27 Oct 2020 14:07:55 -0700
Message-Id: <a8e439ad35a37fdd1a245299aa261bc49dcc4aa9.1603828718.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1603828718.git.boris@bur.io>
References: <cover.1603828718.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Mounting rw and remounting from ro to rw naturally share invariants and
functionality which result in a correctly setup rw filesystem. Luckily,
there is even a strong unity in the code which implements them. In
mount's open_ctree, these operations mostly happen after an early return
for ro file systems, and in remount, they happen in a section devoted to
remounting ro->rw, after some remount specific validation passes.

However, there are unfortunately a few differences. There are small
deviations in the order of some of the operations, remount does not
cleanup orphan inodes in root_tree or fs_tree, remount does not create
the free space tree, and remount does not handle "one-shot" mount
options like clear_cache and uuid tree rescan.

Since we want to add building the free space tree to remount, and since
it is possible to leak orphans on a filesystem mounted as ro then
remounted rw (common for the root filesystem when booting), we would
benefit from unifying the logic between the two codepaths.

This patch only lifts the existing common functionality, and leaves a
natural path for fixing the discrepancies.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/disk-io.c | 93 ++++++++++++++++++++++++++--------------------
 fs/btrfs/disk-io.h |  1 +
 fs/btrfs/super.c   | 37 +++---------------
 3 files changed, 60 insertions(+), 71 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 3d39f5d47ad3..bff7a3a7be18 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2814,6 +2814,53 @@ static int btrfs_check_uuid_tree(struct btrfs_fs_info *fs_info)
 	return 0;
 }
 
+/*
+ * Mounting logic specific to read-write file systems. Shared by open_ctree
+ * and btrfs_remount when remounting from read-only to read-write.
+ */
+int btrfs_mount_rw(struct btrfs_fs_info *fs_info)
+{
+	int ret;
+
+	ret = btrfs_cleanup_fs_roots(fs_info);
+	if (ret)
+		goto out;
+
+	mutex_lock(&fs_info->cleaner_mutex);
+	ret = btrfs_recover_relocation(fs_info->tree_root);
+	mutex_unlock(&fs_info->cleaner_mutex);
+	if (ret < 0) {
+		btrfs_warn(fs_info, "failed to recover relocation: %d", ret);
+		goto out;
+	}
+
+	ret = btrfs_resume_balance_async(fs_info);
+	if (ret)
+		goto out;
+
+	ret = btrfs_resume_dev_replace_async(fs_info);
+	if (ret) {
+		btrfs_warn(fs_info, "failed to resume dev_replace");
+		goto out;
+	}
+
+	btrfs_qgroup_rescan_resume(fs_info);
+
+	if (!fs_info->uuid_root) {
+		btrfs_info(fs_info, "creating UUID tree");
+		ret = btrfs_create_uuid_tree(fs_info);
+		if (ret) {
+			btrfs_warn(fs_info,
+				   "failed to create the UUID tree %d",
+				   ret);
+			goto out;
+		}
+	}
+
+out:
+	return ret;
+}
+
 int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_devices,
 		      char *options)
 {
@@ -3218,22 +3265,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	if (ret)
 		goto fail_qgroup;
 
-	if (!sb_rdonly(sb)) {
-		ret = btrfs_cleanup_fs_roots(fs_info);
-		if (ret)
-			goto fail_qgroup;
-
-		mutex_lock(&fs_info->cleaner_mutex);
-		ret = btrfs_recover_relocation(tree_root);
-		mutex_unlock(&fs_info->cleaner_mutex);
-		if (ret < 0) {
-			btrfs_warn(fs_info, "failed to recover relocation: %d",
-					ret);
-			err = -EINVAL;
-			goto fail_qgroup;
-		}
-	}
-
 	fs_info->fs_root = btrfs_get_fs_root(fs_info, BTRFS_FS_TREE_OBJECTID, true);
 	if (IS_ERR(fs_info->fs_root)) {
 		err = PTR_ERR(fs_info->fs_root);
@@ -3286,35 +3317,17 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	}
 	up_read(&fs_info->cleanup_work_sem);
 
-	ret = btrfs_resume_balance_async(fs_info);
-	if (ret) {
-		btrfs_warn(fs_info, "failed to resume balance: %d", ret);
-		close_ctree(fs_info);
-		return ret;
-	}
-
-	ret = btrfs_resume_dev_replace_async(fs_info);
+	btrfs_discard_resume(fs_info);
+	ret = btrfs_mount_rw(fs_info);
 	if (ret) {
-		btrfs_warn(fs_info, "failed to resume device replace: %d", ret);
 		close_ctree(fs_info);
 		return ret;
 	}
 
-	btrfs_qgroup_rescan_resume(fs_info);
-	btrfs_discard_resume(fs_info);
-
-	if (!fs_info->uuid_root) {
-		btrfs_info(fs_info, "creating UUID tree");
-		ret = btrfs_create_uuid_tree(fs_info);
-		if (ret) {
-			btrfs_warn(fs_info,
-				"failed to create the UUID tree: %d", ret);
-			close_ctree(fs_info);
-			return ret;
-		}
-	} else if (btrfs_test_opt(fs_info, RESCAN_UUID_TREE) ||
-		   fs_info->generation !=
-				btrfs_super_uuid_tree_generation(disk_super)) {
+	if (fs_info->uuid_root &&
+	    (btrfs_test_opt(fs_info, RESCAN_UUID_TREE) ||
+	     fs_info->generation !=
+			btrfs_super_uuid_tree_generation(disk_super))) {
 		btrfs_info(fs_info, "checking UUID tree");
 		ret = btrfs_check_uuid_tree(fs_info);
 		if (ret) {
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index fee69ced58b4..b3ee9c19be0c 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -50,6 +50,7 @@ struct extent_buffer *btrfs_find_create_tree_block(
 						struct btrfs_fs_info *fs_info,
 						u64 bytenr);
 void btrfs_clean_tree_block(struct extent_buffer *buf);
+int btrfs_mount_rw(struct btrfs_fs_info *fs_info);
 int __cold open_ctree(struct super_block *sb,
 	       struct btrfs_fs_devices *fs_devices,
 	       char *options);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 8840a4fa81eb..56bfa23bc52f 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1831,7 +1831,6 @@ static inline void btrfs_remount_cleanup(struct btrfs_fs_info *fs_info,
 static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
-	struct btrfs_root *root = fs_info->tree_root;
 	unsigned old_flags = sb->s_flags;
 	unsigned long old_opts = fs_info->mount_opt;
 	unsigned long old_compress_type = fs_info->compress_type;
@@ -1924,39 +1923,15 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 			goto restore;
 		}
 
-		ret = btrfs_cleanup_fs_roots(fs_info);
-		if (ret)
-			goto restore;
-
-		/* recover relocation */
-		mutex_lock(&fs_info->cleaner_mutex);
-		ret = btrfs_recover_relocation(root);
-		mutex_unlock(&fs_info->cleaner_mutex);
-		if (ret)
-			goto restore;
-
-		ret = btrfs_resume_balance_async(fs_info);
+		/*
+		 * NOTE: when remounting with a change that does writes, don't
+		 * put it anywhere above this point, as we are not sure to be
+		 * safe to write until we pass the above checks.
+		 */
+		ret = btrfs_mount_rw(fs_info);
 		if (ret)
 			goto restore;
 
-		ret = btrfs_resume_dev_replace_async(fs_info);
-		if (ret) {
-			btrfs_warn(fs_info, "failed to resume dev_replace");
-			goto restore;
-		}
-
-		btrfs_qgroup_rescan_resume(fs_info);
-
-		if (!fs_info->uuid_root) {
-			btrfs_info(fs_info, "creating UUID tree");
-			ret = btrfs_create_uuid_tree(fs_info);
-			if (ret) {
-				btrfs_warn(fs_info,
-					   "failed to create the UUID tree %d",
-					   ret);
-				goto restore;
-			}
-		}
 		sb->s_flags &= ~SB_RDONLY;
 
 		set_bit(BTRFS_FS_OPEN, &fs_info->flags);
-- 
2.24.1

