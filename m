Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0115602DEB
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Oct 2022 16:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiJROH1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Oct 2022 10:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiJROHX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Oct 2022 10:07:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AD0D25BA
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Oct 2022 07:06:49 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5C8D2201B2;
        Tue, 18 Oct 2022 14:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666102007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=PCn1ksw4r5nM34t1QTVMhjzkbyVL3p0wPr4q5irIfUY=;
        b=scGu/nDb0eQSZzZVRw9QNuSivgQFMQrUnD9JJBSehAMOCgcl1jW/geBEhcniwwjWfBJSwC
        HXbnt+6QxgRJoY1Ha2ZcMOovN+rSYa+rdEKuKsrC51Rm4OZKida9IOHX/2aVwujy6s1AJ3
        Ka1gG2rmtJX6TmTy/TuFuBwzzmkpoDs=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 51D862C141;
        Tue, 18 Oct 2022 14:06:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E77AEDA79B; Tue, 18 Oct 2022 16:06:38 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: simplify generation check in btrfs_get_dentry
Date:   Tue, 18 Oct 2022 16:06:38 +0200
Message-Id: <20221018140638.4164-1-dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Callers that pass non-zero generation always want to perform the
generation check, we can simply encode that in one parameter and drop
check_generation. Add function documentation.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/export.c | 23 +++++++++++++++++------
 fs/btrfs/export.h |  3 +--
 fs/btrfs/ioctl.c  |  2 +-
 3 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/export.c b/fs/btrfs/export.c
index fab7eb76e53b..a51a5dfa737c 100644
--- a/fs/btrfs/export.c
+++ b/fs/btrfs/export.c
@@ -57,9 +57,20 @@ static int btrfs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
 	return type;
 }
 
+/*
+ * Read dentry of inode with @objectid from filesystem root @root_objectid.
+ *
+ * @sb:             the filesystem super block
+ * @objectid:       inode objectid
+ * @root_objectid:  object id of the subvolume root where to look up the inode
+ * @generation:     optional, if not zero, verify that the found inode
+ *                  generation matches
+ *
+ * Return dentry alias for the inode, otherwise an error. In case the
+ * generation does not match return ESTALE.
+ */
 struct dentry *btrfs_get_dentry(struct super_block *sb, u64 objectid,
-				u64 root_objectid, u64 generation,
-				int check_generation)
+				u64 root_objectid, u64 generation)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
 	struct btrfs_root *root;
@@ -77,7 +88,7 @@ struct dentry *btrfs_get_dentry(struct super_block *sb, u64 objectid,
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
 
-	if (check_generation && generation != inode->i_generation) {
+	if (generation != 0 && generation != inode->i_generation) {
 		iput(inode);
 		return ERR_PTR(-ESTALE);
 	}
@@ -106,7 +117,7 @@ static struct dentry *btrfs_fh_to_parent(struct super_block *sb, struct fid *fh,
 	objectid = fid->parent_objectid;
 	generation = fid->parent_gen;
 
-	return btrfs_get_dentry(sb, objectid, root_objectid, generation, 1);
+	return btrfs_get_dentry(sb, objectid, root_objectid, generation);
 }
 
 static struct dentry *btrfs_fh_to_dentry(struct super_block *sb, struct fid *fh,
@@ -128,7 +139,7 @@ static struct dentry *btrfs_fh_to_dentry(struct super_block *sb, struct fid *fh,
 	root_objectid = fid->root_objectid;
 	generation = fid->gen;
 
-	return btrfs_get_dentry(sb, objectid, root_objectid, generation, 1);
+	return btrfs_get_dentry(sb, objectid, root_objectid, generation);
 }
 
 struct dentry *btrfs_get_parent(struct dentry *child)
@@ -188,7 +199,7 @@ struct dentry *btrfs_get_parent(struct dentry *child)
 
 	if (found_key.type == BTRFS_ROOT_BACKREF_KEY) {
 		return btrfs_get_dentry(fs_info->sb, key.objectid,
-					found_key.offset, 0, 0);
+					found_key.offset, 0);
 	}
 
 	return d_obtain_alias(btrfs_iget(fs_info->sb, key.objectid, root));
diff --git a/fs/btrfs/export.h b/fs/btrfs/export.h
index 5afb7ca42828..eba6bc4f5a61 100644
--- a/fs/btrfs/export.h
+++ b/fs/btrfs/export.h
@@ -19,8 +19,7 @@ struct btrfs_fid {
 } __attribute__ ((packed));
 
 struct dentry *btrfs_get_dentry(struct super_block *sb, u64 objectid,
-				u64 root_objectid, u64 generation,
-				int check_generation);
+				u64 root_objectid, u64 generation);
 struct dentry *btrfs_get_parent(struct dentry *child);
 
 #endif
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index d5dd8bed1488..41a2f499bb97 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3271,7 +3271,7 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 
 			dentry = btrfs_get_dentry(fs_info->sb,
 					BTRFS_FIRST_FREE_OBJECTID,
-					vol_args2->subvolid, 0, 0);
+					vol_args2->subvolid, 0);
 			if (IS_ERR(dentry)) {
 				err = PTR_ERR(dentry);
 				goto out_drop_write;
-- 
2.37.3

