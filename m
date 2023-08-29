Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A303D78C39B
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Aug 2023 13:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbjH2Ltf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Aug 2023 07:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbjH2LtU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Aug 2023 07:49:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A9B132
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Aug 2023 04:49:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 399571F37E;
        Tue, 29 Aug 2023 11:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1693309756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=xuB8X4lv5IQlwV1zZ4KtjqJck3PXH4liRL6thhV+hrE=;
        b=OVAZXenlHMubUGt7dHF4FCGUbsC8JZGhf8FDVuDI9ij9gny4nZXYhKxoM8+FggEapYamhV
        DwGdspXo4xs/0znxz3cUb4R0VoYlkrLt27rlzFCk0mrbdubtJ7PaKevLFFp2DL3MYeswCQ
        UkGzbXH2H1OrXTF8k7MRhyKbfVYW32M=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 07187138E2;
        Tue, 29 Aug 2023 11:49:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NmzAGDrb7WQ9JgAAMHmgww
        (envelope-from <wqu@suse.com>); Tue, 29 Aug 2023 11:49:14 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v3] btrfs: qgroup: pre-allocate btrfs_qgroup to reduce GFP_ATOMIC usage
Date:   Tue, 29 Aug 2023 19:48:57 +0800
Message-ID: <1299b13041aefa9f6fbe25cae6fe6d0fbe7d4bb3.1693309609.git.wqu@suse.com>
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

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v3:
- Do not set @prealloc to NULL unnecessaryly
  Two call sites do not need cleanups can skip the initialization to
  NULL:

  * btrfs_read_qgroup_config()
    @prealloc is only defined inside an if () branch, and there is no
    cleanup needed for @prealloc.

  * btrfs_qgroup_inherit()
    The variable @prealloc is allocated at the very beginning of the
    function, thus we don't need to initialize it to NULL nor reset it
    to NULL after add_qgroup_rb() call.

- Update the comment for the function add_qgroup_rb()
  As the control on the lifespan of @prealloc is transferred to that
  function, making the allocation/freeing happening at different level.

v2:
- Loose the GFP flag for btrfs_read_qgroup_config()
  At that stage we can go GFP_KERNEL instead of GFP_NOFS.

- Do not mark qgroup inconsistent if memory allocation failed at
  btrfs_qgroup_inherit()
  At the very beginning, if we hit -ENOMEM, we haven't done anything,
  thus qgroup is still consistent.
---
 fs/btrfs/qgroup.c | 85 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 59 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index b99230db3c82..74244b4bb0e9 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -180,30 +180,38 @@ static struct btrfs_qgroup *find_qgroup_rb(struct btrfs_fs_info *fs_info,
 	return NULL;
 }
 
-/* must be called with qgroup_lock held */
+/*
+ * Must be called with qgroup_lock held and @prealloc preallocated.
+ *
+ * The control on the lifespan of @prealloc would be transfered to this
+ * function, thus caller should no longer touch @prealloc.
+ */
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
@@ -434,11 +442,14 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
 			qgroup_mark_inconsistent(fs_info);
 		}
 		if (!qgroup) {
-			qgroup = add_qgroup_rb(fs_info, found_key.offset);
-			if (IS_ERR(qgroup)) {
-				ret = PTR_ERR(qgroup);
+			struct btrfs_qgroup *prealloc;
+
+			prealloc = kzalloc(sizeof(*prealloc), GFP_KERNEL);
+			if (!prealloc) {
+				ret = -ENOMEM;
 				goto out;
 			}
+			qgroup = add_qgroup_rb(fs_info, prealloc, found_key.offset);
 		}
 		ret = btrfs_sysfs_add_one_qgroup(fs_info, qgroup);
 		if (ret < 0)
@@ -959,6 +970,7 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
 	struct btrfs_key key;
 	struct btrfs_key found_key;
 	struct btrfs_qgroup *qgroup = NULL;
+	struct btrfs_qgroup *prealloc = NULL;
 	struct btrfs_trans_handle *trans = NULL;
 	struct ulist *ulist = NULL;
 	int ret = 0;
@@ -1094,6 +1106,15 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
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
@@ -1101,7 +1122,8 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
 				goto out_free_path;
 			}
 
-			qgroup = add_qgroup_rb(fs_info, found_key.offset);
+			qgroup = add_qgroup_rb(fs_info, prealloc, found_key.offset);
+			prealloc = NULL;
 			if (IS_ERR(qgroup)) {
 				ret = PTR_ERR(qgroup);
 				btrfs_abort_transaction(trans, ret);
@@ -1144,12 +1166,14 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
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
@@ -1222,6 +1246,7 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
 	else if (trans)
 		ret = btrfs_end_transaction(trans);
 	ulist_free(ulist);
+	kfree(prealloc);
 	return ret;
 }
 
@@ -1608,6 +1633,7 @@ int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_root *quota_root;
 	struct btrfs_qgroup *qgroup;
+	struct btrfs_qgroup *prealloc = NULL;
 	int ret = 0;
 
 	mutex_lock(&fs_info->qgroup_ioctl_lock);
@@ -1622,21 +1648,25 @@ int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
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
 
@@ -2906,10 +2936,15 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 	struct btrfs_root *quota_root;
 	struct btrfs_qgroup *srcgroup;
 	struct btrfs_qgroup *dstgroup;
+	struct btrfs_qgroup *prealloc;
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
@@ -2987,11 +3022,8 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 
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
@@ -3102,6 +3134,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 		mutex_unlock(&fs_info->qgroup_ioctl_lock);
 	if (need_rescan)
 		qgroup_mark_inconsistent(fs_info);
+	kfree(prealloc);
 	return ret;
 }
 
-- 
2.41.0

