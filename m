Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9A778ACEE
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Aug 2023 12:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjH1KoM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Aug 2023 06:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjH1Knl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Aug 2023 06:43:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81312136
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Aug 2023 03:43:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F12332198E
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Aug 2023 10:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1693219390; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=urVw+xMPLQqyqVQg/JT9G2LIckrlxS3nVuYWCSXJoUA=;
        b=slMxXTqDmaJ00MXjPlF2HOkwr6/LCL7ikJLK9IWiI2bGQqgz7DeoMJmZPJQbYpqi3aIgis
        NZ7IldYTahjXt/LtXeEfaTMvtXJfNci6ESYsXrhjY3HtnQU3EDk4Mq9nrGsEx9aMR9z71d
        TAP//WDehBpJ1GqU+2WiyXzyD1NbvbY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 362B513A11
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Aug 2023 10:43:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BWkyHD167GRgWwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Aug 2023 10:43:09 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: qgroup: pre-allocate btrfs_qgroup to reduce GFP_ATOMIC usage
Date:   Mon, 28 Aug 2023 18:42:49 +0800
Message-ID: <e9eab02b82074851f8b76303905ad98f35459026.1693219345.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 fs/btrfs/qgroup.c | 81 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 56 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index b99230db3c82..3cdd768eebc4 100644
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
+			prealloc = kzalloc(sizeof(*prealloc), GFP_NOFS);
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
 
@@ -2906,10 +2932,17 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 	struct btrfs_root *quota_root;
 	struct btrfs_qgroup *srcgroup;
 	struct btrfs_qgroup *dstgroup;
+	struct btrfs_qgroup *prealloc = NULL;
 	bool need_rescan = false;
 	u32 level_size = 0;
 	u64 nums;
 
+	prealloc = kzalloc(sizeof(*prealloc), GFP_NOFS);
+	if (!prealloc) {
+		qgroup_mark_inconsistent(fs_info);
+		return -ENOMEM;
+	}
+
 	/*
 	 * There are only two callers of this function.
 	 *
@@ -2987,11 +3020,8 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 
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
@@ -3102,6 +3132,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 		mutex_unlock(&fs_info->qgroup_ioctl_lock);
 	if (need_rescan)
 		qgroup_mark_inconsistent(fs_info);
+	kfree(prealloc);
 	return ret;
 }
 
-- 
2.41.0

