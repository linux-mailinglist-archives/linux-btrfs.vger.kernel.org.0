Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9AA79DD0E
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Sep 2023 02:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237919AbjIMANY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Sep 2023 20:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237899AbjIMANY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Sep 2023 20:13:24 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554A710F2
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Sep 2023 17:13:20 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 9A6B532005D8;
        Tue, 12 Sep 2023 20:13:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 12 Sep 2023 20:13:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1694563999; x=
        1694650399; bh=gJ6Hd1hTQfz73DLfp6p3BrC9gFTFYIBvVY6l7VnWDH4=; b=I
        yI8WtQBJxDPTjKjGyzZGCqk3wLGDvbB22x0sLMcqStKqsAIvrHHuv4K7/u8Ej9uw
        cs9IIApNKQjFYyZwAzebHwfn4hJp/Q5uwituNe6bpyiTK9DD7J9949/N5Ce931eC
        yRxud3vzANxvaoovmG+DbZvAFnmn1ZB+wicOnWVOcTAWGyqdwwaUlyIZLHnwOrcj
        Q25ZLqK5ykvSXL769swt+l8AkSdPACB0txfTrLVTJiE4+mqDjM+dVAiqwmFQdKSJ
        c2ggcDmenpXbwlLGSFK9gPSU6LyWCNMxrTIrOCLD6qCxfejeyg8+DR+JAYQ8E1rd
        nJOsOY4dUlukH8LG+eaVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1694563999; x=1694650399; bh=g
        J6Hd1hTQfz73DLfp6p3BrC9gFTFYIBvVY6l7VnWDH4=; b=hWk9dRkFgxFSyhA6w
        eUPEe6lGTjXVBeDC5wo6SPRHaWzaYkZhGZnZoQtG/JsVRiU0HPBCDzX1Fz2n9/4P
        cGrKQwIxAemBklxp1Y8HfaWAGVGnDhHgPfgtgfYqcTYhtluu1eSLkXaNZ2fi3JGR
        a60mPNTqqsFfAM7LV0AVz7Ehn3l+bBmG+Npp2S4snLJ8NW6kdyUfw1J6Tpghpy1B
        gJ0bBJ6AcaAgk33ZEcXQcqDyqCDdWJ9odSoZJI3SPpLvu0T7eD5ZKnQ6QalPM55q
        SUo0au4df5hRPRcWYadBO/MzPcMNzXXR2NQ6JwwyfN9Jx5bFakVF2c+hQqVH+T86
        QAvPA==
X-ME-Sender: <xms:nv4AZSk417LKrq0ht3U7sKf38aU1p5--WyeJI0HPRGjQkJ95zj59Mg>
    <xme:nv4AZZ3b2R3mbsIhUc2wEb-kzSTpIk1kGfNjSLW3qe7cz6PLqDtafnUoXnamMvx3K
    7uLSiEV7iwSj5Qy0Cg>
X-ME-Received: <xmr:nv4AZQroLQMHHgeYDHb6hUX3w9GHju6namMuEKqasyl-0PiA3M6B7yKULovC0hawIRfYK450ZVGTL9L9vCmvDB7VZdY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeijedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:n_4AZWk0IHNFbBu1Pz7ystVMkyOE7-6Jh1i5z7bVmZL94yJ2lA-9KQ>
    <xmx:n_4AZQ1r3I5_ICeB3ys0PPmzQbb18Y1Fi0xfZDxgiV-mid3CEVmW7A>
    <xmx:n_4AZdve6VKp9AlQLfrobeT3sHoBtRSI4snsmCz3Wgyuo_VYzeyWUA>
    <xmx:n_4AZV88yNOK_uJNlmC0wJf2EA-qReUfeQC1Lkw3eDAbwyK54yK-HA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Sep 2023 20:13:18 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 14/18] btrfs: simple quota auto hierarchy for nested subvols
Date:   Tue, 12 Sep 2023 17:13:25 -0700
Message-ID: <76f7eec4fb236001c18c9d5263ef141d70bdaabd.1694563454.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694563454.git.boris@bur.io>
References: <cover.1694563454.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Consider the following sequence:
- enable quotas
- create subvol S id 256 at dir outer/
- create a qgroup 1/100
- add 0/256 (S's auto qgroup) to 1/100
- create subvol T id 257 at dir outer/inner/

With full qgroups, there is no relationship between 0/257 and either of
0/256 or 1/100. There is an inherit feature that the creator of inner/
can use to specify it ought to be in 1/100.

Simple quotas are targeted at container isolation, where such automatic
inheritance for not necessarily trusted/controlled nested subvol
creation would be quite helpful. Therefore, add a new default behavior
for simple quotas: when you create a nested subvol, automatically
inherit as parents any parents of the qgroup of the subvol the new inode
is going in.

In our example, 257/0 would also be under 1/100, allowing easy control
of a total quota over an arbitrary hierarchy of subvolumes.

I think this _might_ be a generally useful behavior, so it could be
interesting to put it behind a new inheritance flag that simple quotas
always use while traditional quotas let the user specify, but this is a
minimally intrusive change to start.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/ioctl.c       |  2 +-
 fs/btrfs/qgroup.c      | 57 +++++++++++++++++++++++++++++++++++++++---
 fs/btrfs/qgroup.h      |  6 ++---
 fs/btrfs/transaction.c | 12 ++++++---
 4 files changed, 66 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 6211bce7f146..59fcb7424d93 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -652,7 +652,7 @@ static noinline int create_subvol(struct mnt_idmap *idmap,
 	/* Tree log can't currently deal with an inode which is a new root. */
 	btrfs_set_log_full_commit(trans);
 
-	ret = btrfs_qgroup_inherit(trans, 0, objectid, inherit);
+	ret = btrfs_qgroup_inherit(trans, 0, objectid, root->root_key.objectid, inherit);
 	if (ret)
 		goto out;
 
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 86d3a46ee33f..1b41686f934f 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1560,8 +1560,7 @@ static int quick_update_accounting(struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
-int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
-			      u64 dst)
+int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src, u64 dst)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_qgroup *parent;
@@ -3030,6 +3029,47 @@ int btrfs_run_qgroups(struct btrfs_trans_handle *trans)
 	return ret;
 }
 
+static int qgroup_auto_inherit(struct btrfs_fs_info *fs_info,
+			       u64 inode_rootid,
+			       struct btrfs_qgroup_inherit **inherit)
+{
+	int i = 0;
+	u64 num_qgroups = 0;
+	struct btrfs_qgroup *inode_qg;
+	struct btrfs_qgroup_list *qg_list;
+	struct btrfs_qgroup_inherit *res;
+	size_t struct_sz;
+	u64 *qgids;
+
+	if (*inherit)
+		return -EEXIST;
+
+	inode_qg = find_qgroup_rb(fs_info, inode_rootid);
+	if (!inode_qg)
+		return -ENOENT;
+
+	num_qgroups = list_count_nodes(&inode_qg->groups);
+
+	if (!num_qgroups)
+		return 0;
+
+	struct_sz = struct_size(res, qgroups, num_qgroups);
+	if (struct_sz == SIZE_MAX)
+		return -ERANGE;
+
+	res = kzalloc(struct_sz, GFP_NOFS);
+	if (!res)
+		return -ENOMEM;
+	res->num_qgroups = num_qgroups;
+	qgids = res->qgroups;
+
+	list_for_each_entry(qg_list, &inode_qg->groups, next_group)
+		qgids[i] = qg_list->group->qgroupid;
+
+	*inherit = res;
+	return 0;
+}
+
 /*
  * Copy the accounting information between qgroups. This is necessary
  * when a snapshot or a subvolume is created. Throwing an error will
@@ -3037,7 +3077,8 @@ int btrfs_run_qgroups(struct btrfs_trans_handle *trans)
  * when a readonly fs is a reasonable outcome.
  */
 int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
-			 u64 objectid, struct btrfs_qgroup_inherit *inherit)
+			 u64 objectid, u64 inode_rootid,
+			 struct btrfs_qgroup_inherit *inherit)
 {
 	int ret = 0;
 	int i;
@@ -3049,6 +3090,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 	struct btrfs_qgroup *dstgroup;
 	struct btrfs_qgroup *prealloc;
 	struct btrfs_qgroup_list **qlist_prealloc = NULL;
+	bool free_inherit = false;
 	bool need_rescan = false;
 	u32 level_size = 0;
 	u64 nums;
@@ -3085,6 +3127,13 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 		goto out;
 	}
 
+	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE && !inherit) {
+		ret = qgroup_auto_inherit(fs_info, inode_rootid, &inherit);
+		if (ret)
+			goto out;
+		free_inherit = true;
+	}
+
 	if (inherit) {
 		i_qgroups = (u64 *)(inherit + 1);
 		nums = inherit->num_qgroups + 2 * inherit->num_ref_copies +
@@ -3263,6 +3312,8 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 		mutex_unlock(&fs_info->qgroup_ioctl_lock);
 	if (need_rescan)
 		qgroup_mark_inconsistent(fs_info);
+	if (free_inherit)
+		kfree(inherit);
 	if (qlist_prealloc) {
 		for (int i = 0; i < inherit->num_qgroups; i++)
 			kfree(qlist_prealloc[i]);
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index 5eabd944c782..126a599c7349 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -312,8 +312,7 @@ int btrfs_qgroup_rescan(struct btrfs_fs_info *fs_info);
 void btrfs_qgroup_rescan_resume(struct btrfs_fs_info *fs_info);
 int btrfs_qgroup_wait_for_completion(struct btrfs_fs_info *fs_info,
 				     bool interruptible);
-int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
-			      u64 dst);
+int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src, u64 dst);
 int btrfs_del_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
 			      u64 dst);
 int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid);
@@ -343,7 +342,8 @@ int btrfs_qgroup_account_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 int btrfs_qgroup_account_extents(struct btrfs_trans_handle *trans);
 int btrfs_run_qgroups(struct btrfs_trans_handle *trans);
 int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
-			 u64 objectid, struct btrfs_qgroup_inherit *inherit);
+			 u64 objectid, u64 inode_rootid,
+			 struct btrfs_qgroup_inherit *inherit);
 void btrfs_qgroup_free_refroot(struct btrfs_fs_info *fs_info,
 			       u64 ref_root, u64 num_bytes,
 			       enum btrfs_qgroup_rsv_type type);
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index eb649860ecfb..645646e587d5 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1620,7 +1620,7 @@ static int qgroup_account_snapshot(struct btrfs_trans_handle *trans,
 	int ret;
 
 	/*
-	 * Save some performance in the case that full qgroups are not
+	 * Save some performance in the case that qgroups are not
 	 * enabled. If this check races with the ioctl, rescan will
 	 * kick in anyway.
 	 */
@@ -1663,7 +1663,7 @@ static int qgroup_account_snapshot(struct btrfs_trans_handle *trans,
 
 	/* Now qgroup are all updated, we can inherit it to new qgroups */
 	ret = btrfs_qgroup_inherit(trans, src->root_key.objectid, dst_objectid,
-				   inherit);
+				   parent->root_key.objectid, inherit);
 	if (ret < 0)
 		goto out;
 
@@ -1930,8 +1930,12 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 	 * To co-operate with that hack, we do hack again.
 	 * Or snapshot will be greatly slowed down by a subtree qgroup rescan
 	 */
-	ret = qgroup_account_snapshot(trans, root, parent_root,
-				      pending->inherit, objectid);
+	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_FULL)
+		ret = qgroup_account_snapshot(trans, root, parent_root,
+					      pending->inherit, objectid);
+	else if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE)
+		ret = btrfs_qgroup_inherit(trans, root->root_key.objectid, objectid,
+					   parent_root->root_key.objectid, pending->inherit);
 	if (ret < 0)
 		goto fail;
 
-- 
2.41.0

