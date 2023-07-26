Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE6A7640AF
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jul 2023 22:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjGZUlK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jul 2023 16:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbjGZUlJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jul 2023 16:41:09 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23758211C
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 13:41:08 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 9395A5C00DD;
        Wed, 26 Jul 2023 16:41:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 26 Jul 2023 16:41:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1690404067; x=
        1690490467; bh=D8HvC2TDD8NemS0pV7p21LpSwVu1Gmgf5ol6sq+qMEU=; b=j
        rGHMYtnDhjSu7FpbeCYn+lgynL2h+dheam9USeAPvCVALZZct46c6S/b5uPLGF9l
        gp6GBSzMmXcSuSrgVIL6e8aGG5zCCx6OtX+xv2iB2G2BLgKF1/o7+jNwY01VpzRB
        uPJ7U66/EYCdpCsjh3DE4PTXkGig06dBK3JlWnC82LQQrQct9xFc/Aa13GozHlnL
        U+WQhO+r0GawpngiRtyb0sd0+TCZd0ZHfmltMYOe0RdmHTeHzhMCMjaJuGJ9IR4y
        NvNk5IGQi5Okbe3nP0GiOvHlPihjoy4SM6a0g+IpmvFQZJXMtIQSgrwdymDtEwnX
        OMoO96gZvcDkljgF0y62Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1690404067; x=1690490467; bh=D
        8HvC2TDD8NemS0pV7p21LpSwVu1Gmgf5ol6sq+qMEU=; b=suHSCJ9n1bdnVSyud
        KKrtHzApxABaqUCcjKrs8pRuUDx9qe+Tbo0LjNWgXfhChkqs4uxigE3kUCepyp6d
        VokwX+n0O81dvl/nebzYkGP60vMsse/a9gct0eTSV37KMmRDdtPJSSbUwPO4LiA+
        dQQa0IL4+crZeEnv1gzqT43PssyzXj8+bMshNTJmHuDKlXCHja9lZxKY+hNoRcM2
        vY952+uG8LFpzVsCTbWk5wrHs4/rCqctrYo5qu8jIFNSTcXRVnBkBxM41/zFe4cy
        Spey+HnSvHCjIQxq1/cPC+H0hipqFsXSLrmv1qEL96pctEc0IG7z6T/B3Fecb1zW
        bN8Bg==
X-ME-Sender: <xms:44TBZHEQ_RTwMxe38xp0zMxsLP10ntMb7vPIAnFw4s4L5qn-lzNRqQ>
    <xme:44TBZEWip7pzn6Wwhcn8hWw3bfSvsl961S8Oyqjylr563XR2xeMRS66TGdDl7OpzS
    mIL5Q530mecV-Qrtu8>
X-ME-Received: <xmr:44TBZJJtJnqOz5OCdfXUwGA0kBpo9QvEnKWD085OfLwKvIL6PlZNYCezyfuQzFSf52udVbwS1igQ2bFUOsbajZZ-caw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedriedvgdduhedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:44TBZFE_SWxt2wgirGCe_K-LYqMBZkVir3OHMVADXyuprBSDnuvMmQ>
    <xmx:44TBZNV_AsOjqMeZu9PkUsIEKqO31XwbrM5N4IcDTowb4u1YfGogmA>
    <xmx:44TBZANoLFbZoEvju_-iXlDjvZ1ajQ95mlxrPiw8XEiPU0MLu5EOKw>
    <xmx:44TBZOfqaEnKzgkHvwyiSe8GSkhoQSspykmqlbpBo7AuZiEQ_NTr-Q>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Jul 2023 16:41:07 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 14/18] btrfs: simple quota auto hierarchy for nested subvols
Date:   Wed, 26 Jul 2023 13:38:41 -0700
Message-ID: <23508aed837267ae8fc633f2f60e6d3402910d24.1690403768.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690403768.git.boris@bur.io>
References: <cover.1690403768.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 fs/btrfs/qgroup.c      | 44 +++++++++++++++++++++++++++++++++++++++---
 fs/btrfs/qgroup.h      |  6 +++---
 fs/btrfs/transaction.c | 13 +++++++++----
 4 files changed, 54 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 9b61bc62e439..c9b069077fd0 100644
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
index dedc532669f4..58e9ed0deedd 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1550,8 +1550,7 @@ static int quick_update_accounting(struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
-int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
-			      u64 dst)
+int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src, u64 dst)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_qgroup *parent;
@@ -2991,6 +2990,40 @@ int btrfs_run_qgroups(struct btrfs_trans_handle *trans)
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
+	*inherit = kzalloc(sizeof(**inherit) + num_qgroups * sizeof(u64), GFP_NOFS);
+	if (!*inherit)
+		return -ENOMEM;
+	(*inherit)->num_qgroups = num_qgroups;
+
+	list_for_each_entry(qg_list, &inode_qg->groups, next_group) {
+		u64 qg_id = qg_list->group->qgroupid;
+		*((u64 *)((*inherit)+1) + i) = qg_id;
+	}
+
+	return 0;
+}
+
 /*
  * Copy the accounting information between qgroups. This is necessary
  * when a snapshot or a subvolume is created. Throwing an error will
@@ -2998,7 +3031,8 @@ int btrfs_run_qgroups(struct btrfs_trans_handle *trans)
  * when a readonly fs is a reasonable outcome.
  */
 int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
-			 u64 objectid, struct btrfs_qgroup_inherit *inherit)
+			 u64 objectid, u64 inode_rootid,
+			 struct btrfs_qgroup_inherit *inherit)
 {
 	int ret = 0;
 	int i;
@@ -3040,6 +3074,9 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 		goto out;
 	}
 
+	if (!inherit && btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE)
+		qgroup_auto_inherit(fs_info, inode_rootid, &inherit);
+
 	if (inherit) {
 		i_qgroups = (u64 *)(inherit + 1);
 		nums = inherit->num_qgroups + 2 * inherit->num_ref_copies +
@@ -3066,6 +3103,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 	if (ret)
 		goto out;
 
+
 	/*
 	 * add qgroup to all inherited groups
 	 */
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index 94d85b4fbebd..ce6fa8694ca7 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -271,8 +271,7 @@ int btrfs_qgroup_rescan(struct btrfs_fs_info *fs_info);
 void btrfs_qgroup_rescan_resume(struct btrfs_fs_info *fs_info);
 int btrfs_qgroup_wait_for_completion(struct btrfs_fs_info *fs_info,
 				     bool interruptible);
-int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
-			      u64 dst);
+int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src, u64 dst);
 int btrfs_del_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
 			      u64 dst);
 int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid);
@@ -366,7 +365,8 @@ int btrfs_qgroup_account_extent(struct btrfs_trans_handle *trans, u64 bytenr,
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
index 25217888e897..fb857147df57 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1529,13 +1529,14 @@ static int qgroup_account_snapshot(struct btrfs_trans_handle *trans,
 	int ret;
 
 	/*
-	 * Save some performance in the case that full qgroups are not
+	 * Save some performance in the case that qgroups are not
 	 * enabled. If this check races with the ioctl, rescan will
 	 * kick in anyway.
 	 */
 	if (btrfs_qgroup_mode(fs_info) != BTRFS_QGROUP_MODE_FULL)
 		return 0;
 
+
 	/*
 	 * Ensure dirty @src will be committed.  Or, after coming
 	 * commit_fs_roots() and switch_commit_roots(), any dirty but not
@@ -1572,7 +1573,7 @@ static int qgroup_account_snapshot(struct btrfs_trans_handle *trans,
 
 	/* Now qgroup are all updated, we can inherit it to new qgroups */
 	ret = btrfs_qgroup_inherit(trans, src->root_key.objectid, dst_objectid,
-				   inherit);
+				   parent->root_key.objectid, inherit);
 	if (ret < 0)
 		goto out;
 
@@ -1839,8 +1840,12 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
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

