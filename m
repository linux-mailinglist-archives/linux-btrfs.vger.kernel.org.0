Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F281A295502
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Oct 2020 01:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507016AbgJUXHG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 19:07:06 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:57305 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2507008AbgJUXHF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 19:07:05 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 665F712A1;
        Wed, 21 Oct 2020 19:07:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 21 Oct 2020 19:07:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=bdG9zCvWQfP6R
        oOXDcCaOlaQgWijIm5uHnUYLgOe5Qg=; b=IzVaxHa1CWBTAYHvGyXU4pqo41/bF
        yqGBRyROuUJT4ICZ3ALo+JpzRdPe4cFi8aHhTXx5cYtKlVsN6oOj1gN/67U0me4X
        6uE25hhwPJDoCLIF3jzrgw4wu3VuKvc5xkI4jYISYIdwvrtMt+7+xZPxjBAJLQMZ
        Ub0sakS+uAlmXEQMMmZG2Ha7mq6rIFeqa9ZrSdGUK4YLU4fSOX3yE7BRHUyE6btz
        UQ2FVz9RcxlDAf3TA5E3DkwUV0j4W7vad+Er0M1ip1sdxb8G7t1Qabiz7tDMMI9o
        3gqXpmllh/SPTKsGQOR4l1jgoQbFPrFIXZx81XnRjQyqYTQrNstXUm3/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=bdG9zCvWQfP6RoOXDcCaOlaQgWijIm5uHnUYLgOe5Qg=; b=n3CCLnZE
        vgdYXV70ayMdYDTuBxA5LjEU5Tpcqs3Ba6ghP0p6ry3E3miQgBo8WVG01IXyNDPK
        k6yE4QzV3TjNfl4h+3Xbd9Ly8ZRyKMePr/FZF440TnfkEEtDia/Q4EFbQRPWlMKK
        3cQmDYyWI5JVd8DaONH3lWFr04zOOlDBp9RPCkHffWEiIobgOMUMWJCvkl/YFPs8
        OOmnrWMGBtSVE/VOY58K98gg3/8AkpOR30SLvFnTWicAnGAi/oH7nShy0cbVS6fL
        h/4GMV5sidGdNuqh8KgXpj8120NbInfvsLdHaIpzA5OwbmohljMr8BRcfnTLocUo
        jNBhshFng7BsEQ==
X-ME-Sender: <xms:Fr-QX3Ch69t-MMGqPfy_uot4Hu2pYrQn74j8Ldv3ttvHucM1lZYuSw>
    <xme:Fr-QX9h4lJER7lpMqTa_EJaU5IZ6ZnoW3iA7XAR7bkNG3Kvhhd5b55zuid48PwmCI
    Af0zYKNBdKiAUxP8xU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjeeigdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecukfhppeduieefrdduudegrddufedvrdefnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurh
    drihho
X-ME-Proxy: <xmx:Fr-QXyncSQ801yCFejnTKsAUcuqXUelsQfsR9ioRoyBIsFKwTmtq6A>
    <xmx:Fr-QX5z_7qbkcH8Fl0PqPNva50AXU48PSnJkHSv7EbOFVca7I1YhFQ>
    <xmx:Fr-QX8TBfPVMDxygX5QUdcs14rp7GKbUK_SUJlGVIG4dhqgRg_-Saw>
    <xmx:F7-QX171fEnM1z2ZORc_iR-oEy1Z5UCoHM4zpeT2o_N9ENxhcweo9Q>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 685853280063;
        Wed, 21 Oct 2020 19:07:02 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Boris Burkov <boris@bur.io>
Subject: [PATCH v4 1/8] btrfs: lift rw mount setup from mount and remount
Date:   Wed, 21 Oct 2020 16:06:29 -0700
Message-Id: <a8e439ad35a37fdd1a245299aa261bc49dcc4aa9.1603318242.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1603318242.git.boris@bur.io>
References: <cover.1603318242.git.boris@bur.io>
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

