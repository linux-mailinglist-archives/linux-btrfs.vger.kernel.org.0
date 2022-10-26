Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB3D60E8BA
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Oct 2022 21:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234970AbiJZTLv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Oct 2022 15:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234962AbiJZTLb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Oct 2022 15:11:31 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C6A13B518
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 12:08:56 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id g11so10726684qts.1
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 12:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tf99lVatDna5AlDGK0Y0ExPBnnI+IjtPpOsCTa80Lso=;
        b=ArFN6oFmnWY/vtypWq5EBN6KrwFLD2j8KmKeavP6SGfeb5WvV2l/BunLDGnt+OJeAG
         FajWv4qw+hFiCN7n0qaBuYJs3kgyCCtIJx5JO8Oxr0totcSxNe2bZI7ynOaLhVRkt0BP
         fdF1xtkLotC58aJVlez9w8OVmuNYkQ/wTmq1NPwXYj+33OQn1YfK2rUQEtbsejzR8cqr
         Et6FqkvuvS3FWwwbGSTwKjtNo21BfAkbsTcGGVzUfGXQr+GCGtwfSXQziQSWb8mRZdO4
         lEaEIH20Xutv4Vbj1GzlcXjpDtb58aA//NZ2YDKeLfom6ui6zGIE+7YUpyKHiAv+ZZpj
         ePvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tf99lVatDna5AlDGK0Y0ExPBnnI+IjtPpOsCTa80Lso=;
        b=dOQf4oNgmmVhm90O2HZpAvzMKoF9Nq6cndo17cCE90U90GTM9VSyitW/vwZ+Tg7tvo
         WstnD+sFIv2VILV5RWDMolI2q+MfQkOOI76XzmTngoG7J/L+uHt1qlQq6ndnk5Lbr3Xq
         XF4g0m/F3LMuuQ+b5VzYLZiKUiBGl1joQC+HCD1pCFL8dYa/1q57ZJGpG+Q5kbucMUb6
         Vua458AYbJi6cei/EXRAI5z2vRr8l5BUVJj+0Y9/pry7pYhSXXM5ye80jDyP0M8QRHpl
         cX5d6UEu5bLOpUk3F9JfvDGeQli6iM6RNc3I19z/9oClyaQJppSogse2s6xxPImlP9et
         vcKw==
X-Gm-Message-State: ACrzQf2O7aYRueNWQ2y+GqzDjtccx591m1+8QXB2ccR+vzf3K4qPsoAY
        DutwIVEqM4Exl53hQymW1SKPrxOB5ST/Xw==
X-Google-Smtp-Source: AMsMyM5nRJOtXDW7M8L3EvJhP9ovtRAjHmvWJN+VLpgJYDK+z1w8iiIV45j06U4LCEE+AvWnAaaseQ==
X-Received: by 2002:ac8:5d8e:0:b0:39d:457:6b6e with SMTP id d14-20020ac85d8e000000b0039d04576b6emr32761017qtx.473.1666811334750;
        Wed, 26 Oct 2022 12:08:54 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id d18-20020ac84e32000000b003431446588fsm3643738qtw.5.2022.10.26.12.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 12:08:54 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 08/26] btrfs: move the auto defrag code to defrag.c
Date:   Wed, 26 Oct 2022 15:08:23 -0400
Message-Id: <dfbb9bb69b5c921607763fa7cd714bb68f52d886.1666811038.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1666811038.git.josef@toxicpanda.com>
References: <cover.1666811038.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This currently exists in file.c, move it to the more natural location in
defrag.c.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/defrag.c | 340 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/file.c   | 340 ----------------------------------------------
 2 files changed, 340 insertions(+), 340 deletions(-)

diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 5df604846de6..7da3f7039dcd 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -11,6 +11,329 @@
 #include "locking.h"
 #include "accessors.h"
 
+static struct kmem_cache *btrfs_inode_defrag_cachep;
+/*
+ * when auto defrag is enabled we
+ * queue up these defrag structs to remember which
+ * inodes need defragging passes
+ */
+struct inode_defrag {
+	struct rb_node rb_node;
+	/* objectid */
+	u64 ino;
+	/*
+	 * transid where the defrag was added, we search for
+	 * extents newer than this
+	 */
+	u64 transid;
+
+	/* root objectid */
+	u64 root;
+
+	/*
+	 * The extent size threshold for autodefrag.
+	 *
+	 * This value is different for compressed/non-compressed extents,
+	 * thus needs to be passed from higher layer.
+	 * (aka, inode_should_defrag())
+	 */
+	u32 extent_thresh;
+};
+
+static int __compare_inode_defrag(struct inode_defrag *defrag1,
+				  struct inode_defrag *defrag2)
+{
+	if (defrag1->root > defrag2->root)
+		return 1;
+	else if (defrag1->root < defrag2->root)
+		return -1;
+	else if (defrag1->ino > defrag2->ino)
+		return 1;
+	else if (defrag1->ino < defrag2->ino)
+		return -1;
+	else
+		return 0;
+}
+
+/* pop a record for an inode into the defrag tree.  The lock
+ * must be held already
+ *
+ * If you're inserting a record for an older transid than an
+ * existing record, the transid already in the tree is lowered
+ *
+ * If an existing record is found the defrag item you
+ * pass in is freed
+ */
+static int __btrfs_add_inode_defrag(struct btrfs_inode *inode,
+				    struct inode_defrag *defrag)
+{
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	struct inode_defrag *entry;
+	struct rb_node **p;
+	struct rb_node *parent = NULL;
+	int ret;
+
+	p = &fs_info->defrag_inodes.rb_node;
+	while (*p) {
+		parent = *p;
+		entry = rb_entry(parent, struct inode_defrag, rb_node);
+
+		ret = __compare_inode_defrag(defrag, entry);
+		if (ret < 0)
+			p = &parent->rb_left;
+		else if (ret > 0)
+			p = &parent->rb_right;
+		else {
+			/* if we're reinserting an entry for
+			 * an old defrag run, make sure to
+			 * lower the transid of our existing record
+			 */
+			if (defrag->transid < entry->transid)
+				entry->transid = defrag->transid;
+			entry->extent_thresh = min(defrag->extent_thresh,
+						   entry->extent_thresh);
+			return -EEXIST;
+		}
+	}
+	set_bit(BTRFS_INODE_IN_DEFRAG, &inode->runtime_flags);
+	rb_link_node(&defrag->rb_node, parent, p);
+	rb_insert_color(&defrag->rb_node, &fs_info->defrag_inodes);
+	return 0;
+}
+
+static inline int __need_auto_defrag(struct btrfs_fs_info *fs_info)
+{
+	if (!btrfs_test_opt(fs_info, AUTO_DEFRAG))
+		return 0;
+
+	if (btrfs_fs_closing(fs_info))
+		return 0;
+
+	return 1;
+}
+
+/*
+ * insert a defrag record for this inode if auto defrag is
+ * enabled
+ */
+int btrfs_add_inode_defrag(struct btrfs_trans_handle *trans,
+			   struct btrfs_inode *inode, u32 extent_thresh)
+{
+	struct btrfs_root *root = inode->root;
+	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct inode_defrag *defrag;
+	u64 transid;
+	int ret;
+
+	if (!__need_auto_defrag(fs_info))
+		return 0;
+
+	if (test_bit(BTRFS_INODE_IN_DEFRAG, &inode->runtime_flags))
+		return 0;
+
+	if (trans)
+		transid = trans->transid;
+	else
+		transid = inode->root->last_trans;
+
+	defrag = kmem_cache_zalloc(btrfs_inode_defrag_cachep, GFP_NOFS);
+	if (!defrag)
+		return -ENOMEM;
+
+	defrag->ino = btrfs_ino(inode);
+	defrag->transid = transid;
+	defrag->root = root->root_key.objectid;
+	defrag->extent_thresh = extent_thresh;
+
+	spin_lock(&fs_info->defrag_inodes_lock);
+	if (!test_bit(BTRFS_INODE_IN_DEFRAG, &inode->runtime_flags)) {
+		/*
+		 * If we set IN_DEFRAG flag and evict the inode from memory,
+		 * and then re-read this inode, this new inode doesn't have
+		 * IN_DEFRAG flag. At the case, we may find the existed defrag.
+		 */
+		ret = __btrfs_add_inode_defrag(inode, defrag);
+		if (ret)
+			kmem_cache_free(btrfs_inode_defrag_cachep, defrag);
+	} else {
+		kmem_cache_free(btrfs_inode_defrag_cachep, defrag);
+	}
+	spin_unlock(&fs_info->defrag_inodes_lock);
+	return 0;
+}
+
+/*
+ * pick the defragable inode that we want, if it doesn't exist, we will get
+ * the next one.
+ */
+static struct inode_defrag *
+btrfs_pick_defrag_inode(struct btrfs_fs_info *fs_info, u64 root, u64 ino)
+{
+	struct inode_defrag *entry = NULL;
+	struct inode_defrag tmp;
+	struct rb_node *p;
+	struct rb_node *parent = NULL;
+	int ret;
+
+	tmp.ino = ino;
+	tmp.root = root;
+
+	spin_lock(&fs_info->defrag_inodes_lock);
+	p = fs_info->defrag_inodes.rb_node;
+	while (p) {
+		parent = p;
+		entry = rb_entry(parent, struct inode_defrag, rb_node);
+
+		ret = __compare_inode_defrag(&tmp, entry);
+		if (ret < 0)
+			p = parent->rb_left;
+		else if (ret > 0)
+			p = parent->rb_right;
+		else
+			goto out;
+	}
+
+	if (parent && __compare_inode_defrag(&tmp, entry) > 0) {
+		parent = rb_next(parent);
+		if (parent)
+			entry = rb_entry(parent, struct inode_defrag, rb_node);
+		else
+			entry = NULL;
+	}
+out:
+	if (entry)
+		rb_erase(parent, &fs_info->defrag_inodes);
+	spin_unlock(&fs_info->defrag_inodes_lock);
+	return entry;
+}
+
+void btrfs_cleanup_defrag_inodes(struct btrfs_fs_info *fs_info)
+{
+	struct inode_defrag *defrag;
+	struct rb_node *node;
+
+	spin_lock(&fs_info->defrag_inodes_lock);
+	node = rb_first(&fs_info->defrag_inodes);
+	while (node) {
+		rb_erase(node, &fs_info->defrag_inodes);
+		defrag = rb_entry(node, struct inode_defrag, rb_node);
+		kmem_cache_free(btrfs_inode_defrag_cachep, defrag);
+
+		cond_resched_lock(&fs_info->defrag_inodes_lock);
+
+		node = rb_first(&fs_info->defrag_inodes);
+	}
+	spin_unlock(&fs_info->defrag_inodes_lock);
+}
+
+#define BTRFS_DEFRAG_BATCH	1024
+
+static int __btrfs_run_defrag_inode(struct btrfs_fs_info *fs_info,
+				    struct inode_defrag *defrag)
+{
+	struct btrfs_root *inode_root;
+	struct inode *inode;
+	struct btrfs_ioctl_defrag_range_args range;
+	int ret = 0;
+	u64 cur = 0;
+
+again:
+	if (test_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state))
+		goto cleanup;
+	if (!__need_auto_defrag(fs_info))
+		goto cleanup;
+
+	/* get the inode */
+	inode_root = btrfs_get_fs_root(fs_info, defrag->root, true);
+	if (IS_ERR(inode_root)) {
+		ret = PTR_ERR(inode_root);
+		goto cleanup;
+	}
+
+	inode = btrfs_iget(fs_info->sb, defrag->ino, inode_root);
+	btrfs_put_root(inode_root);
+	if (IS_ERR(inode)) {
+		ret = PTR_ERR(inode);
+		goto cleanup;
+	}
+
+	if (cur >= i_size_read(inode)) {
+		iput(inode);
+		goto cleanup;
+	}
+
+	/* do a chunk of defrag */
+	clear_bit(BTRFS_INODE_IN_DEFRAG, &BTRFS_I(inode)->runtime_flags);
+	memset(&range, 0, sizeof(range));
+	range.len = (u64)-1;
+	range.start = cur;
+	range.extent_thresh = defrag->extent_thresh;
+
+	sb_start_write(fs_info->sb);
+	ret = btrfs_defrag_file(inode, NULL, &range, defrag->transid,
+				       BTRFS_DEFRAG_BATCH);
+	sb_end_write(fs_info->sb);
+	iput(inode);
+
+	if (ret < 0)
+		goto cleanup;
+
+	cur = max(cur + fs_info->sectorsize, range.start);
+	goto again;
+
+cleanup:
+	kmem_cache_free(btrfs_inode_defrag_cachep, defrag);
+	return ret;
+}
+
+/*
+ * run through the list of inodes in the FS that need
+ * defragging
+ */
+int btrfs_run_defrag_inodes(struct btrfs_fs_info *fs_info)
+{
+	struct inode_defrag *defrag;
+	u64 first_ino = 0;
+	u64 root_objectid = 0;
+
+	atomic_inc(&fs_info->defrag_running);
+	while (1) {
+		/* Pause the auto defragger. */
+		if (test_bit(BTRFS_FS_STATE_REMOUNTING,
+			     &fs_info->fs_state))
+			break;
+
+		if (!__need_auto_defrag(fs_info))
+			break;
+
+		/* find an inode to defrag */
+		defrag = btrfs_pick_defrag_inode(fs_info, root_objectid,
+						 first_ino);
+		if (!defrag) {
+			if (root_objectid || first_ino) {
+				root_objectid = 0;
+				first_ino = 0;
+				continue;
+			} else {
+				break;
+			}
+		}
+
+		first_ino = defrag->ino + 1;
+		root_objectid = defrag->root;
+
+		__btrfs_run_defrag_inode(fs_info, defrag);
+	}
+	atomic_dec(&fs_info->defrag_running);
+
+	/*
+	 * during unmount, we use the transaction_wait queue to
+	 * wait for the defragger to stop
+	 */
+	wake_up(&fs_info->transaction_wait);
+	return 0;
+}
+
 /*
  * Defrag all the leaves in a given btree.
  * Read all the leaves and try to get key order to
@@ -131,3 +454,20 @@ int btrfs_defrag_leaves(struct btrfs_trans_handle *trans,
 
 	return ret;
 }
+
+void __cold btrfs_auto_defrag_exit(void)
+{
+	kmem_cache_destroy(btrfs_inode_defrag_cachep);
+}
+
+int __init btrfs_auto_defrag_init(void)
+{
+	btrfs_inode_defrag_cachep = kmem_cache_create("btrfs_inode_defrag",
+					sizeof(struct inode_defrag), 0,
+					SLAB_MEM_SPREAD,
+					NULL);
+	if (!btrfs_inode_defrag_cachep)
+		return -ENOMEM;
+
+	return 0;
+}
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 5ef8ad4b6262..0b52f4aae966 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -34,329 +34,6 @@
 #include "accessors.h"
 #include "extent-tree.h"
 
-static struct kmem_cache *btrfs_inode_defrag_cachep;
-/*
- * when auto defrag is enabled we
- * queue up these defrag structs to remember which
- * inodes need defragging passes
- */
-struct inode_defrag {
-	struct rb_node rb_node;
-	/* objectid */
-	u64 ino;
-	/*
-	 * transid where the defrag was added, we search for
-	 * extents newer than this
-	 */
-	u64 transid;
-
-	/* root objectid */
-	u64 root;
-
-	/*
-	 * The extent size threshold for autodefrag.
-	 *
-	 * This value is different for compressed/non-compressed extents,
-	 * thus needs to be passed from higher layer.
-	 * (aka, inode_should_defrag())
-	 */
-	u32 extent_thresh;
-};
-
-static int __compare_inode_defrag(struct inode_defrag *defrag1,
-				  struct inode_defrag *defrag2)
-{
-	if (defrag1->root > defrag2->root)
-		return 1;
-	else if (defrag1->root < defrag2->root)
-		return -1;
-	else if (defrag1->ino > defrag2->ino)
-		return 1;
-	else if (defrag1->ino < defrag2->ino)
-		return -1;
-	else
-		return 0;
-}
-
-/* pop a record for an inode into the defrag tree.  The lock
- * must be held already
- *
- * If you're inserting a record for an older transid than an
- * existing record, the transid already in the tree is lowered
- *
- * If an existing record is found the defrag item you
- * pass in is freed
- */
-static int __btrfs_add_inode_defrag(struct btrfs_inode *inode,
-				    struct inode_defrag *defrag)
-{
-	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	struct inode_defrag *entry;
-	struct rb_node **p;
-	struct rb_node *parent = NULL;
-	int ret;
-
-	p = &fs_info->defrag_inodes.rb_node;
-	while (*p) {
-		parent = *p;
-		entry = rb_entry(parent, struct inode_defrag, rb_node);
-
-		ret = __compare_inode_defrag(defrag, entry);
-		if (ret < 0)
-			p = &parent->rb_left;
-		else if (ret > 0)
-			p = &parent->rb_right;
-		else {
-			/* if we're reinserting an entry for
-			 * an old defrag run, make sure to
-			 * lower the transid of our existing record
-			 */
-			if (defrag->transid < entry->transid)
-				entry->transid = defrag->transid;
-			entry->extent_thresh = min(defrag->extent_thresh,
-						   entry->extent_thresh);
-			return -EEXIST;
-		}
-	}
-	set_bit(BTRFS_INODE_IN_DEFRAG, &inode->runtime_flags);
-	rb_link_node(&defrag->rb_node, parent, p);
-	rb_insert_color(&defrag->rb_node, &fs_info->defrag_inodes);
-	return 0;
-}
-
-static inline int __need_auto_defrag(struct btrfs_fs_info *fs_info)
-{
-	if (!btrfs_test_opt(fs_info, AUTO_DEFRAG))
-		return 0;
-
-	if (btrfs_fs_closing(fs_info))
-		return 0;
-
-	return 1;
-}
-
-/*
- * insert a defrag record for this inode if auto defrag is
- * enabled
- */
-int btrfs_add_inode_defrag(struct btrfs_trans_handle *trans,
-			   struct btrfs_inode *inode, u32 extent_thresh)
-{
-	struct btrfs_root *root = inode->root;
-	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct inode_defrag *defrag;
-	u64 transid;
-	int ret;
-
-	if (!__need_auto_defrag(fs_info))
-		return 0;
-
-	if (test_bit(BTRFS_INODE_IN_DEFRAG, &inode->runtime_flags))
-		return 0;
-
-	if (trans)
-		transid = trans->transid;
-	else
-		transid = inode->root->last_trans;
-
-	defrag = kmem_cache_zalloc(btrfs_inode_defrag_cachep, GFP_NOFS);
-	if (!defrag)
-		return -ENOMEM;
-
-	defrag->ino = btrfs_ino(inode);
-	defrag->transid = transid;
-	defrag->root = root->root_key.objectid;
-	defrag->extent_thresh = extent_thresh;
-
-	spin_lock(&fs_info->defrag_inodes_lock);
-	if (!test_bit(BTRFS_INODE_IN_DEFRAG, &inode->runtime_flags)) {
-		/*
-		 * If we set IN_DEFRAG flag and evict the inode from memory,
-		 * and then re-read this inode, this new inode doesn't have
-		 * IN_DEFRAG flag. At the case, we may find the existed defrag.
-		 */
-		ret = __btrfs_add_inode_defrag(inode, defrag);
-		if (ret)
-			kmem_cache_free(btrfs_inode_defrag_cachep, defrag);
-	} else {
-		kmem_cache_free(btrfs_inode_defrag_cachep, defrag);
-	}
-	spin_unlock(&fs_info->defrag_inodes_lock);
-	return 0;
-}
-
-/*
- * pick the defragable inode that we want, if it doesn't exist, we will get
- * the next one.
- */
-static struct inode_defrag *
-btrfs_pick_defrag_inode(struct btrfs_fs_info *fs_info, u64 root, u64 ino)
-{
-	struct inode_defrag *entry = NULL;
-	struct inode_defrag tmp;
-	struct rb_node *p;
-	struct rb_node *parent = NULL;
-	int ret;
-
-	tmp.ino = ino;
-	tmp.root = root;
-
-	spin_lock(&fs_info->defrag_inodes_lock);
-	p = fs_info->defrag_inodes.rb_node;
-	while (p) {
-		parent = p;
-		entry = rb_entry(parent, struct inode_defrag, rb_node);
-
-		ret = __compare_inode_defrag(&tmp, entry);
-		if (ret < 0)
-			p = parent->rb_left;
-		else if (ret > 0)
-			p = parent->rb_right;
-		else
-			goto out;
-	}
-
-	if (parent && __compare_inode_defrag(&tmp, entry) > 0) {
-		parent = rb_next(parent);
-		if (parent)
-			entry = rb_entry(parent, struct inode_defrag, rb_node);
-		else
-			entry = NULL;
-	}
-out:
-	if (entry)
-		rb_erase(parent, &fs_info->defrag_inodes);
-	spin_unlock(&fs_info->defrag_inodes_lock);
-	return entry;
-}
-
-void btrfs_cleanup_defrag_inodes(struct btrfs_fs_info *fs_info)
-{
-	struct inode_defrag *defrag;
-	struct rb_node *node;
-
-	spin_lock(&fs_info->defrag_inodes_lock);
-	node = rb_first(&fs_info->defrag_inodes);
-	while (node) {
-		rb_erase(node, &fs_info->defrag_inodes);
-		defrag = rb_entry(node, struct inode_defrag, rb_node);
-		kmem_cache_free(btrfs_inode_defrag_cachep, defrag);
-
-		cond_resched_lock(&fs_info->defrag_inodes_lock);
-
-		node = rb_first(&fs_info->defrag_inodes);
-	}
-	spin_unlock(&fs_info->defrag_inodes_lock);
-}
-
-#define BTRFS_DEFRAG_BATCH	1024
-
-static int __btrfs_run_defrag_inode(struct btrfs_fs_info *fs_info,
-				    struct inode_defrag *defrag)
-{
-	struct btrfs_root *inode_root;
-	struct inode *inode;
-	struct btrfs_ioctl_defrag_range_args range;
-	int ret = 0;
-	u64 cur = 0;
-
-again:
-	if (test_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state))
-		goto cleanup;
-	if (!__need_auto_defrag(fs_info))
-		goto cleanup;
-
-	/* get the inode */
-	inode_root = btrfs_get_fs_root(fs_info, defrag->root, true);
-	if (IS_ERR(inode_root)) {
-		ret = PTR_ERR(inode_root);
-		goto cleanup;
-	}
-
-	inode = btrfs_iget(fs_info->sb, defrag->ino, inode_root);
-	btrfs_put_root(inode_root);
-	if (IS_ERR(inode)) {
-		ret = PTR_ERR(inode);
-		goto cleanup;
-	}
-
-	if (cur >= i_size_read(inode)) {
-		iput(inode);
-		goto cleanup;
-	}
-
-	/* do a chunk of defrag */
-	clear_bit(BTRFS_INODE_IN_DEFRAG, &BTRFS_I(inode)->runtime_flags);
-	memset(&range, 0, sizeof(range));
-	range.len = (u64)-1;
-	range.start = cur;
-	range.extent_thresh = defrag->extent_thresh;
-
-	sb_start_write(fs_info->sb);
-	ret = btrfs_defrag_file(inode, NULL, &range, defrag->transid,
-				       BTRFS_DEFRAG_BATCH);
-	sb_end_write(fs_info->sb);
-	iput(inode);
-
-	if (ret < 0)
-		goto cleanup;
-
-	cur = max(cur + fs_info->sectorsize, range.start);
-	goto again;
-
-cleanup:
-	kmem_cache_free(btrfs_inode_defrag_cachep, defrag);
-	return ret;
-}
-
-/*
- * run through the list of inodes in the FS that need
- * defragging
- */
-int btrfs_run_defrag_inodes(struct btrfs_fs_info *fs_info)
-{
-	struct inode_defrag *defrag;
-	u64 first_ino = 0;
-	u64 root_objectid = 0;
-
-	atomic_inc(&fs_info->defrag_running);
-	while (1) {
-		/* Pause the auto defragger. */
-		if (test_bit(BTRFS_FS_STATE_REMOUNTING,
-			     &fs_info->fs_state))
-			break;
-
-		if (!__need_auto_defrag(fs_info))
-			break;
-
-		/* find an inode to defrag */
-		defrag = btrfs_pick_defrag_inode(fs_info, root_objectid,
-						 first_ino);
-		if (!defrag) {
-			if (root_objectid || first_ino) {
-				root_objectid = 0;
-				first_ino = 0;
-				continue;
-			} else {
-				break;
-			}
-		}
-
-		first_ino = defrag->ino + 1;
-		root_objectid = defrag->root;
-
-		__btrfs_run_defrag_inode(fs_info, defrag);
-	}
-	atomic_dec(&fs_info->defrag_running);
-
-	/*
-	 * during unmount, we use the transaction_wait queue to
-	 * wait for the defragger to stop
-	 */
-	wake_up(&fs_info->transaction_wait);
-	return 0;
-}
-
 /* simple helper to fault in pages and copy.  This should go away
  * and be replaced with calls into generic code.
  */
@@ -4138,23 +3815,6 @@ const struct file_operations btrfs_file_operations = {
 	.remap_file_range = btrfs_remap_file_range,
 };
 
-void __cold btrfs_auto_defrag_exit(void)
-{
-	kmem_cache_destroy(btrfs_inode_defrag_cachep);
-}
-
-int __init btrfs_auto_defrag_init(void)
-{
-	btrfs_inode_defrag_cachep = kmem_cache_create("btrfs_inode_defrag",
-					sizeof(struct inode_defrag), 0,
-					SLAB_MEM_SPREAD,
-					NULL);
-	if (!btrfs_inode_defrag_cachep)
-		return -ENOMEM;
-
-	return 0;
-}
-
 int btrfs_fdatawrite_range(struct inode *inode, loff_t start, loff_t end)
 {
 	int ret;
-- 
2.26.3

