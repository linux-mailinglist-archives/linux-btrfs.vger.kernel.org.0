Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8213478BC59
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Aug 2023 03:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbjH2BJF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Aug 2023 21:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234786AbjH2BIc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Aug 2023 21:08:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8917212D
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Aug 2023 18:08:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 35D8B1F897
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Aug 2023 01:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1693271307; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=txifzxVF5SucDQdzsqu+jvbpOWv4Jz+20jNgesBUJII=;
        b=jrK3Dd8ivvwNmqPZxd1G4e7M0mz4dqNOhJQ6bTNC2lAglTXkqeKBGIj4KFCTUUOPNdYsrz
        PguLl5SZAcOo38nS1RtUg3yMjSDOz1UsEyIJ4RvUA+yJCKDW8oR1Hnc5B2JcZmsfbiQ8LQ
        0xCpBq/uO4F1b2aidqxTFfJEpvzZB7I=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9219013593
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Aug 2023 01:08:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yHGrFwpF7WQKfQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Aug 2023 01:08:26 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: qgroup: pre-allocate btrfs_qgroup to reduce GFP_ATOMIC usage
Date:   Tue, 29 Aug 2023 09:08:08 +0800
Message-ID: <44e189b505bff8ae9d281a7765141563d6dee3bb.1693271263.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Qgroup is the heaviest user of GFP_ATOMIC, but one call site does not
really need GFP_ATOMIC, that is add_qgroup_rb().

That function only search the rb tree to find if we already have such
tree.
If there is no such tree, then it would try to allocate memory for it.

This means we can afford to pre-allocate such structure unconditionally,
then free the memory if it's not needed.

Considering this function is not a hot path, only utilized by the
following functions:

- btrfs_qgroup_inherit()
  For "btrfs subvolume snapshot -i" option.

- btrfs_read_qgroup_config()
  At mount time, and we're ensured there would be no existing rb tree
  entry for each qgroup.

- btrfs_create_qgroup()

Thus we're completely safe to pre-allocate the extra memory for btrfs_qgroup
structure, and reduce unnecessary GFP_ATOMIC usage.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Loose the GFP flag for btrfs_read_qgroup_config()
  At that stage we can go GFP_KERNEL instead of GFP_NOFS.

- Do not mark qgroup inconsistent if memory allocation failed at
  btrfs_qgroup_inherit()
  At the very beginning, if we hit -ENOMEM, we haven't done anything,
  thus qgroup is still consistent.
---
 fs/btrfs/qgroup.c | 79 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 54 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index b99230db3c82..2a3da93fd266 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -182,28 +182,31 @@ static struct btrfs_qgroup *find_qgroup_rb(struct btrfs_fs_info *fs_info,
 
 /* must be called with qgroup_lock held */
 static struct btrfs_qgroup *add_qgroup_rb(struct btrfs_fs_info *fs_info,
+					  struct btrfs_qgroup *prealloc,
 					  u64 qgroupid)
 {
 	struct rb_node **p = &fs_info->qgroup_tree.rb_node;
 	struct rb_node *parent = NULL;
 	struct btrfs_qgroup *qgroup;
 
+	/* Caller must have pre-allocated @prealloc. */
+	ASSERT(prealloc);
+
 	while (*p) {
 		parent = *p;
 		qgroup = rb_entry(parent, struct btrfs_qgroup, node);
 
-		if (qgroup->qgroupid < qgroupid)
+		if (qgroup->qgroupid < qgroupid) {
 			p = &(*p)->rb_left;
-		else if (qgroup->qgroupid > qgroupid)
+		} else if (qgroup->qgroupid > qgroupid) {
 			p = &(*p)->rb_right;
-		else
+		} else {
+			kfree(prealloc);
 			return qgroup;
+		}
 	}
 
-	qgroup = kzalloc(sizeof(*qgroup), GFP_ATOMIC);
-	if (!qgroup)
-		return ERR_PTR(-ENOMEM);
-
+	qgroup = prealloc;
 	qgroup->qgroupid = qgroupid;
 	INIT_LIST_HEAD(&qgroup->groups);
 	INIT_LIST_HEAD(&qgroup->members);
@@ -434,11 +437,15 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
 			qgroup_mark_inconsistent(fs_info);
 		}
 		if (!qgroup) {
-			qgroup = add_qgroup_rb(fs_info, found_key.offset);
-			if (IS_ERR(qgroup)) {
-				ret = PTR_ERR(qgroup);
+			struct btrfs_qgroup *prealloc = NULL;
+
+			prealloc = kzalloc(sizeof(*prealloc), GFP_KERNEL);
+			if (!prealloc) {
+				ret = -ENOMEM;
 				goto out;
 			}
+			qgroup = add_qgroup_rb(fs_info, prealloc, found_key.offset);
+			prealloc = NULL;
 		}
 		ret = btrfs_sysfs_add_one_qgroup(fs_info, qgroup);
 		if (ret < 0)
@@ -959,6 +966,7 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
 	struct btrfs_key key;
 	struct btrfs_key found_key;
 	struct btrfs_qgroup *qgroup = NULL;
+	struct btrfs_qgroup *prealloc = NULL;
 	struct btrfs_trans_handle *trans = NULL;
 	struct ulist *ulist = NULL;
 	int ret = 0;
@@ -1094,6 +1102,15 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
 			/* Release locks on tree_root before we access quota_root */
 			btrfs_release_path(path);
 
+			/* We should not have a stray @prealloc pointer. */
+			ASSERT(prealloc == NULL);
+			prealloc = kzalloc(sizeof(*prealloc), GFP_NOFS);
+			if (!prealloc) {
+				ret = -ENOMEM;
+				btrfs_abort_transaction(trans, ret);
+				goto out_free_path;
+			}
+
 			ret = add_qgroup_item(trans, quota_root,
 					      found_key.offset);
 			if (ret) {
@@ -1101,7 +1118,8 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
 				goto out_free_path;
 			}
 
-			qgroup = add_qgroup_rb(fs_info, found_key.offset);
+			qgroup = add_qgroup_rb(fs_info, prealloc, found_key.offset);
+			prealloc = NULL;
 			if (IS_ERR(qgroup)) {
 				ret = PTR_ERR(qgroup);
 				btrfs_abort_transaction(trans, ret);
@@ -1144,12 +1162,14 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
 		goto out_free_path;
 	}
 
-	qgroup = add_qgroup_rb(fs_info, BTRFS_FS_TREE_OBJECTID);
-	if (IS_ERR(qgroup)) {
-		ret = PTR_ERR(qgroup);
-		btrfs_abort_transaction(trans, ret);
+	ASSERT(prealloc == NULL);
+	prealloc = kzalloc(sizeof(*prealloc), GFP_NOFS);
+	if (!prealloc) {
+		ret = -ENOMEM;
 		goto out_free_path;
 	}
+	qgroup = add_qgroup_rb(fs_info, prealloc, BTRFS_FS_TREE_OBJECTID);
+	prealloc = NULL;
 	ret = btrfs_sysfs_add_one_qgroup(fs_info, qgroup);
 	if (ret < 0) {
 		btrfs_abort_transaction(trans, ret);
@@ -1222,6 +1242,7 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
 	else if (trans)
 		ret = btrfs_end_transaction(trans);
 	ulist_free(ulist);
+	kfree(prealloc);
 	return ret;
 }
 
@@ -1608,6 +1629,7 @@ int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_root *quota_root;
 	struct btrfs_qgroup *qgroup;
+	struct btrfs_qgroup *prealloc = NULL;
 	int ret = 0;
 
 	mutex_lock(&fs_info->qgroup_ioctl_lock);
@@ -1622,21 +1644,25 @@ int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 		goto out;
 	}
 
+	prealloc = kzalloc(sizeof(*prealloc), GFP_NOFS);
+	if (!prealloc) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
 	ret = add_qgroup_item(trans, quota_root, qgroupid);
 	if (ret)
 		goto out;
 
 	spin_lock(&fs_info->qgroup_lock);
-	qgroup = add_qgroup_rb(fs_info, qgroupid);
+	qgroup = add_qgroup_rb(fs_info, prealloc, qgroupid);
 	spin_unlock(&fs_info->qgroup_lock);
+	prealloc = NULL;
 
-	if (IS_ERR(qgroup)) {
-		ret = PTR_ERR(qgroup);
-		goto out;
-	}
 	ret = btrfs_sysfs_add_one_qgroup(fs_info, qgroup);
 out:
 	mutex_unlock(&fs_info->qgroup_ioctl_lock);
+	kfree(prealloc);
 	return ret;
 }
 
@@ -2906,10 +2932,15 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 	struct btrfs_root *quota_root;
 	struct btrfs_qgroup *srcgroup;
 	struct btrfs_qgroup *dstgroup;
+	struct btrfs_qgroup *prealloc = NULL;
 	bool need_rescan = false;
 	u32 level_size = 0;
 	u64 nums;
 
+	prealloc = kzalloc(sizeof(*prealloc), GFP_NOFS);
+	if (!prealloc)
+		return -ENOMEM;
+
 	/*
 	 * There are only two callers of this function.
 	 *
@@ -2987,11 +3018,8 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 
 	spin_lock(&fs_info->qgroup_lock);
 
-	dstgroup = add_qgroup_rb(fs_info, objectid);
-	if (IS_ERR(dstgroup)) {
-		ret = PTR_ERR(dstgroup);
-		goto unlock;
-	}
+	dstgroup = add_qgroup_rb(fs_info, prealloc, objectid);
+	prealloc = NULL;
 
 	if (inherit && inherit->flags & BTRFS_QGROUP_INHERIT_SET_LIMITS) {
 		dstgroup->lim_flags = inherit->lim.flags;
@@ -3102,6 +3130,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 		mutex_unlock(&fs_info->qgroup_ioctl_lock);
 	if (need_rescan)
 		qgroup_mark_inconsistent(fs_info);
+	kfree(prealloc);
 	return ret;
 }
 
-- 
2.41.0

