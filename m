Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA1B929F94D
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Oct 2020 00:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbgJ2X6G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 19:58:06 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:40221 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725372AbgJ2X6G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 19:58:06 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id B0C885C00AE;
        Thu, 29 Oct 2020 19:58:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 29 Oct 2020 19:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=fm2; bh=ZuO/DuznAXTj6dUlvuHz0gK2qR
        fZJCIo5KHjwpqzhoE=; b=OwInHmBDt8339JjLXaLL0gdlrXq8t0jkb59b8CXBfV
        LSM16e5Eq/yWpBcTSHr5qrIeBotGVftuBSqWfQ0x+3KKY1Cvh0XO3Li2ColBHbPU
        iNXivTfzVRixWiW0lKfr5xFEtXPKLJQvXw65YqZxD93W13cAtnEtr10ojmZlf23A
        GSbS7FhdTJy8hxmgav1+xBX7rr4PzAgJ+5jvaH8ueyBn2GUMjsDLYkh5q55WnL94
        fu+pC9gybVqFR6WReUMpOW8ozTFqp5u38I9bmwE+gb0RPxi729F9IU0vRwcQUIER
        e/khU6OoKj6GDU56/XWkslKD4a3OhPtWIWjkpfDYE42A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=ZuO/DuznAXTj6dUlvuHz0gK2qRfZJCIo5KHjwpqzhoE=; b=F+XiRsE6
        G2Ch3ifvx1WK1sCNFoW2OreKLx502aD0FnR6bT78EPj3BP111lFj75PancZxEQMM
        f9gfTsTwpOpyGCvsy4EmGDwFVWbR2WtwQjBzSG+Lxnd40gb3tOAcjMD4NGu6Nen2
        heRczwudLXyFgpjYo+UAtELNMCAI4fQ/3oS83tcqYFEnUiImoWz8TFwNejD5zdv0
        Bx70zMp1fAGMVojqcfxwInJFGNcsME3aQzHVMNh3N0xe+9IJhyHUabxgLDhtqV9O
        QACdvr2Ahbznv6b320UjphRgZqOYjCHsIARkJIhCxvEqyHqEYgaiIsswCeUKTHxM
        PfGLm0UgfUPRJg==
X-ME-Sender: <xms:DFebXwa3aegL58MJUPDi1zAugLNntIZOv7GDOD3dEGb82YcyrzZjzA>
    <xme:DFebX7Zt8CQmPwWTVXHihjAl3aqFXRSvY67pJGaxibKVxRZoQynqP6gNsZeooWcJW
    U-Vd6yJyQX5bYl82kI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrleeggdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecukfhppeduieefrdduudegrddufedvrdefnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurh
    drihho
X-ME-Proxy: <xmx:DFebX6-SGKxouR3xCMwUxyR6BNIL6aI52cEjN0a-uOC5G_xUzVsAhg>
    <xmx:DFebX6oad5qOeRHXzMHK5LSvOrqc5hdhhGnnEpjcu638-7l4K44Y_w>
    <xmx:DFebX7rapgNAhHr9tSpnNOJRbsdEmHAbljtzh86ziMkzrONcyzeRiA>
    <xmx:DFebX1FhNGwksAQk7bnevoC_OU2eDpHgaBS9y_9rgUWEysZkitc6hw>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id EF4103064682;
        Thu, 29 Oct 2020 19:58:03 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 01/10] btrfs: lift rw mount setup from mount and remount
Date:   Thu, 29 Oct 2020 16:57:48 -0700
Message-Id: <30c4efc1374a7e894e25fafb2de5781d3093519f.1604015464.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1604015464.git.boris@bur.io>
References: <cover.1604015464.git.boris@bur.io>
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
 fs/btrfs/disk-io.c | 91 ++++++++++++++++++++++++++--------------------
 fs/btrfs/disk-io.h |  1 +
 fs/btrfs/super.c   | 37 +++----------------
 3 files changed, 59 insertions(+), 70 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 601a7ab2adb4..b741a711bad5 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2894,6 +2894,53 @@ static int btrfs_check_uuid_tree(struct btrfs_fs_info *fs_info)
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
@@ -3298,22 +3345,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
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
@@ -3366,35 +3397,17 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
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
+	ret = btrfs_mount_rw(fs_info);
 	if (ret) {
-		btrfs_warn(fs_info, "failed to resume device replace: %d", ret);
 		close_ctree(fs_info);
 		return ret;
 	}
-
-	btrfs_qgroup_rescan_resume(fs_info);
 	btrfs_discard_resume(fs_info);
 
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
index 182540bdcea0..a4e6cdbe3a48 100644
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
index 1ffa50bae1dd..22299fc13b6d 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1880,7 +1880,6 @@ static inline void btrfs_remount_cleanup(struct btrfs_fs_info *fs_info,
 static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
-	struct btrfs_root *root = fs_info->tree_root;
 	unsigned old_flags = sb->s_flags;
 	unsigned long old_opts = fs_info->mount_opt;
 	unsigned long old_compress_type = fs_info->compress_type;
@@ -1973,39 +1972,15 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
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

