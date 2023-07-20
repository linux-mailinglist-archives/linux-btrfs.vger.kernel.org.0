Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF7475BADD
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jul 2023 00:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjGTWzL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jul 2023 18:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjGTWzG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jul 2023 18:55:06 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0C719B6
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 15:55:02 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id D02705C01C2;
        Thu, 20 Jul 2023 18:54:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 20 Jul 2023 18:54:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1689893692; x=
        1689980092; bh=uqBltCLB67tj2FmRmVeIGaX0m1MqsF8fSgLuqSw3/N0=; b=L
        aASRnlswvD+mrxTQSJuRKbM0NcbqeOMA8nXSk+amRs0Z+lLp+O2Z1J/X6KoBFNbJ
        0FYfNh9VzgMhw9RJ7l38q3d1vQK4rjMXuq/8Ya4kTmhZzosW0A266Wa95/SwY61Q
        DANpMLRIfrG8oWkhpUXBWHhr43tJhZp75vkAlwEso8lIf/MyTjXStM7ZvD+xfkG2
        D/CYhwDK+U2/Gv4DRYWJAAFFwqAVpDG8oaoGFjqhlQ39yeh1+ReR9tTThcIQatTE
        NzZTvwL8aBGxuWWidevWmVcGHDlLzCa3n+Gglb8t8+KigT6+ve5qcNrEMLeeFXKa
        0DqWgB2vXuiRHznTM4uRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1689893692; x=1689980092; bh=u
        qBltCLB67tj2FmRmVeIGaX0m1MqsF8fSgLuqSw3/N0=; b=JFQyYhtgks0Yo1v+s
        lZgqDbAlax9jTmrTHRtbHdyKPkmE3hcmdemms5fpYtiV2znnZK2V+tbCemvS24Mg
        Tjd3xK89b6oBCGznI5n4ktRrXFIt6cDVBgphLQD+m/NFeBEwv+OZYBbkUvERjmHC
        efLwQXzrFtrzQW+wvkGHIbwKTsLKEUA/sX8VVpm+GjIr0k13jv/758JJSc34R7x2
        k6CEADYdczGoGmy4gZE/TXiVkAtBbdPVZ4ZbXG6y6zpqzk1q8Vk6enktNXKBXRF2
        +qTq6S9Qdw8CwK2q6YK9ZmFoflpusxZd97v87lgW4TPXQQNThXcEwqq40DmjQlbw
        4BJUw==
X-ME-Sender: <xms:PLu5ZOIsqDXXsER165-3jccrZ3-g0w8xwfchgXpxs5AGnf7yY6hfdQ>
    <xme:PLu5ZGJEPJUEaqOEue_M61tG4NYETZTQJ2S_IuAfI84nr_ec1xjxj9ZwhSLUgmkNC
    LMCVy_O30oZhKBp4vo>
X-ME-Received: <xmr:PLu5ZOuB0a3oaRW2r9kgZ0x7RotRvoYACvgVy5bco6wBm2atoewur1AO7WTV_OUrpXblOUyCC_WWNNNJkFbCEtUWCDU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedugdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgepieenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:PLu5ZDbfdBCuWLr-j3je30Uezpm4aV1hrHEg8SmJYSLyhLx7olL7hQ>
    <xmx:PLu5ZFZSWdgbpCupWPGHmPrvzP_3xTEGzNHnU-RdsOFSndLxgSqsIg>
    <xmx:PLu5ZPDuL1rukFyO5fsB01mrh8BFw8C_Idj_JSLcP5-UcZ4DDI3GCA>
    <xmx:PLu5ZGDR9mtqd3AVIrCGkArstfL5zVs92N8ygbfikc6RD1BuIEpnOQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Jul 2023 18:54:52 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 16/20] btrfs: simple quota auto hierarchy for nested subvols
Date:   Thu, 20 Jul 2023 15:52:44 -0700
Message-ID: <a36cee5391c59435e846c9e2512b90c8cac2e6d5.1689893021.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689893021.git.boris@bur.io>
References: <cover.1689893021.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index 71213083f97e..ee535277b922 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1523,13 +1523,14 @@ static int qgroup_account_snapshot(struct btrfs_trans_handle *trans,
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
@@ -1566,7 +1567,7 @@ static int qgroup_account_snapshot(struct btrfs_trans_handle *trans,
 
 	/* Now qgroup are all updated, we can inherit it to new qgroups */
 	ret = btrfs_qgroup_inherit(trans, src->root_key.objectid, dst_objectid,
-				   inherit);
+				   parent->root_key.objectid, inherit);
 	if (ret < 0)
 		goto out;
 
@@ -1833,8 +1834,12 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
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

