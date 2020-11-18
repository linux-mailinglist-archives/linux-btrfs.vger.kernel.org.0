Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB562B8817
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Nov 2020 00:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgKRXG1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Nov 2020 18:06:27 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:36591 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725822AbgKRXG1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Nov 2020 18:06:27 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 707484B0;
        Wed, 18 Nov 2020 18:06:43 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 18 Nov 2020 18:06:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=fm2; bh=XuPXao7xtTc6Kw3ODPI/9dnM+8
        PgN19JmP/ITb5P44M=; b=OsjK0nIZfkfAKOHUVeTkDpfBFUu2lHC3xSbfvpVwOo
        SQGAi8ckko/Ar0v7TfrRZxQVZVnjQoilYlXz6OjvK4tAXJGvwyKZjRpVfn6REzhC
        k8Y7DGbWT7VANFV1gi796nkfXRN6RPgrv7I9YutOPZGrPTChRn3RaIk97L27xQzm
        uXYP/kcexh2y8rkMNck/NLDrfwmCEeP4fKQnaOwRMH6o/MNqhL7SzrAyQHGmtMY+
        wq8PwcH5p0l6KAkA7HsN4jdVyZ9PhiXoLqxQOUcxcITbYBwpHAuaJFvHQrhBbK6t
        cghVeGCMmuODGcAgAtMFNqhararqJtaYtcjvZQeSxwNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=XuPXao7xtTc6Kw3ODPI/9dnM+8PgN19JmP/ITb5P44M=; b=k+bjQ5BM
        MpgaZdD6OMchEOiTNgsBCMBCxzwP7jTilFWjX7pWfG7GTsqR+roT9RTLtq721OMb
        EDN46/1bc2T+vCo04TKS6TEPYCkMQjt05EYXKB2H+Ma8N0JX4GYBALiN+yE++1Q7
        2Vopf9G1PuBJqz6urfO3xWKN7576eX2CN4rw8Z8eUqvc/vnPwerKPudBCPb3NECM
        UxkhN+MLA3oX0lznALgRl98tad6CpbfoZhxJCA6HrGFaJoG+SOpwKz9FToBm/55l
        FPKX68C3cpfeUZgfNwkAoh9mr/fAfqzqz3I/MVk4qVcOjhwocIA1T/4vTNGTHNEI
        xBjQ15NBFZhgGg==
X-ME-Sender: <xms:Aqm1X3t0_YTubc2JGN65Sl5RE4gt0whEd1FjvqpZVrtd3I9G_0Y64g>
    <xme:Aqm1X4c266ktengplbDVwUgNNm3Pfqb1jKA00NY4jLL0uvwteAqGdNREP4d93Zbxn
    uM38D8swQ3bK0JKadE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudefiedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucfkphepudeifedruddugedrudefvddrfeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhioh
X-ME-Proxy: <xmx:A6m1X6zZ9_lZhvW3gaFKcdc2fPCIUXR2pNpMFglj-7RGxfJVTxCckA>
    <xmx:A6m1X2OiizMDpzuSx81dn-jrFY-niPZuHnlEsrrHVs2KPvYlcWKs9Q>
    <xmx:A6m1X3_a4C-vmFus2uwy8jk8nsOFxUSGjWjd16taLeRVLw5iV7hXwg>
    <xmx:A6m1X0ITdyhNpviwOmXtNEdKW6eGbqLtS4tCZi7x6gS2iVm3DH_haw>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 57E3A3064AB4;
        Wed, 18 Nov 2020 18:06:42 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v7 01/12] btrfs: lift rw mount setup from mount and remount
Date:   Wed, 18 Nov 2020 15:06:16 -0800
Message-Id: <ac259f3ceafae5a8bb9b6c554375588705aa55b2.1605736355.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1605736355.git.boris@bur.io>
References: <cover.1605736355.git.boris@bur.io>
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
index 8c87a1caefff..3e0de4986dbc 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2884,6 +2884,53 @@ static int btrfs_check_uuid_tree(struct btrfs_fs_info *fs_info)
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
@@ -3290,22 +3337,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
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
@@ -3358,35 +3389,17 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
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
index e75ea6092942..945914d1747f 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -50,6 +50,7 @@ struct extent_buffer *btrfs_find_create_tree_block(
 						u64 bytenr, u64 owner_root,
 						int level);
 void btrfs_clean_tree_block(struct extent_buffer *buf);
+int btrfs_mount_rw(struct btrfs_fs_info *fs_info);
 int __cold open_ctree(struct super_block *sb,
 	       struct btrfs_fs_devices *fs_devices,
 	       char *options);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 6693cfc14dfd..ad5a78970389 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1878,7 +1878,6 @@ static inline void btrfs_remount_cleanup(struct btrfs_fs_info *fs_info,
 static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
-	struct btrfs_root *root = fs_info->tree_root;
 	unsigned old_flags = sb->s_flags;
 	unsigned long old_opts = fs_info->mount_opt;
 	unsigned long old_compress_type = fs_info->compress_type;
@@ -1971,39 +1970,15 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
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

