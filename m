Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94AF6F4E43
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 03:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjECA77 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 May 2023 20:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjECA75 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 May 2023 20:59:57 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6692D358E
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 17:59:56 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id D6C3C5C0311;
        Tue,  2 May 2023 20:59:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 02 May 2023 20:59:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1683075595; x=
        1683161995; bh=B4QVcOh1n1iRTg3zT022aoBauHMxFlmaxBHP1x45Oqk=; b=h
        L0VigQbHODUY13nrzpDaS+jzaesqNaZkBV9zbrtC4mgCVUYiEGEO2FS4mW2ZZcMb
        WSoSEMQvrUHxvEgmFnYpgu3KINGng4/BCrOS2dDi9Xj1fbpMY8xpj9wWwYKWJyAE
        Cx6EqIYnHDNMbIUCZUQScqA4JYMdewSy/SbCAXcRzFwPMTTcJtXzA6fOPO9CUZyF
        wlbyd87GOoOkKORGW4c5RXFcM4pJ7LLRmNUm+//Ax5yFYYvbSWIhWgi7AWkSwBm7
        fh3ugqdAnMJMq0mmuD22+AwZV3aoFmnOnY1uRihbloJapH32ChrRJ3lbRGR0+Fxz
        a3ZGPmdwESvo/IAKdjOpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1683075595; x=1683161995; bh=B
        4QVcOh1n1iRTg3zT022aoBauHMxFlmaxBHP1x45Oqk=; b=PLDr824L8aRbcFmTp
        oVLuPbh3PVpWA6vJOHJCSJ85De9wB0LuYs9I3p87PaNbHVBlL6mahZAUwXhtNffT
        R9B3g30CctH7DQ8wGxQpyZIOnMIEULnZwJROcj7E7N1N9yy4aF1YFd2YGbNU/YKC
        g8heDYRRpwlVYWBPfNm7K8Vb96Ez8wN8oLGmcxomq4BlTAvsNUjCQI06KjeGXRPC
        BB/gcsSU0WNw+Gnhog9usJCpqxdiLIZTqpvxVgz328J1h83njUoWxwCZDK4+JOYY
        Fe4v/e3zz/C2fGgOOZG0ft0MBwc5HFVxsyGLlpFJQtwNycxZHYCLjqdZIGLeDk+V
        QYUPw==
X-ME-Sender: <xms:C7JRZA7f-e9J0kG9cQ4KmW5O8BvjDPlOcibjl7OqDXeuv_ssluIIRQ>
    <xme:C7JRZB6pqLhvgTtiDPQZEACvkXU9OBnwFuBmZGGNxifVilw7olGt4QrGM99QEMQEI
    63rAqKsBAzPhfcvsVI>
X-ME-Received: <xmr:C7JRZPdNyQrfFDD5V_8Ogm6Ee2rwndOyn16sTYaqCdP1icPP5wsblb9W>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvjedggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:C7JRZFKIWcqHPzcsO1VYLMSVUXghcpaZrBkF109UpwY7TXQT4aJldg>
    <xmx:C7JRZEJ7dJxXEHzB46YpBtd07-rx-9gBbjkRqvRefHiE6_cbCZ5FUA>
    <xmx:C7JRZGxjFKIJAfwO4Uw6fmywnB6F-vZoedCD1728GhYOd_TwZktIeg>
    <xmx:C7JRZOySX0HEc8JvL1o3ouA9Hw15wok-dlNXDydCP2XKsGKzl38GRA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 May 2023 20:59:55 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 6/9] btrfs: auto hierarchy for simple qgroups of nested subvols
Date:   Tue,  2 May 2023 17:59:27 -0700
Message-Id: <b311f17d76094253b5b38be3ea845438628f17ad.1683075170.git.boris@bur.io>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1683075170.git.boris@bur.io>
References: <cover.1683075170.git.boris@bur.io>
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
 fs/btrfs/qgroup.c      | 46 +++++++++++++++++++++++++++++++++++++++---
 fs/btrfs/qgroup.h      |  6 +++---
 fs/btrfs/transaction.c |  2 +-
 4 files changed, 48 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index ca7d2ef739c8..4d6d28feb5c6 100644
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
index e3d0630fef0c..6816e01f00b5 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1504,8 +1504,7 @@ static int quick_update_accounting(struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
-int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
-			      u64 dst)
+int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src, u64 dst)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_qgroup *parent;
@@ -2945,6 +2944,42 @@ int btrfs_run_qgroups(struct btrfs_trans_handle *trans)
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
+	list_for_each_entry(qg_list, &inode_qg->groups, next_group) {
+		++num_qgroups;
+	}
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
@@ -2952,7 +2987,8 @@ int btrfs_run_qgroups(struct btrfs_trans_handle *trans)
  * when a readonly fs is a reasonable outcome.
  */
 int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
-			 u64 objectid, struct btrfs_qgroup_inherit *inherit)
+			 u64 objectid, u64 inode_rootid,
+			 struct btrfs_qgroup_inherit *inherit)
 {
 	int ret = 0;
 	int i;
@@ -2994,6 +3030,9 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 		goto out;
 	}
 
+	if (!inherit && btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE)
+		qgroup_auto_inherit(fs_info, inode_rootid, &inherit);
+
 	if (inherit) {
 		i_qgroups = (u64 *)(inherit + 1);
 		nums = inherit->num_qgroups + 2 * inherit->num_ref_copies +
@@ -3020,6 +3059,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 	if (ret)
 		goto out;
 
+
 	/*
 	 * add qgroup to all inherited groups
 	 */
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index b300998dcbc7..aecebe9d0d62 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -272,8 +272,7 @@ int btrfs_qgroup_rescan(struct btrfs_fs_info *fs_info);
 void btrfs_qgroup_rescan_resume(struct btrfs_fs_info *fs_info);
 int btrfs_qgroup_wait_for_completion(struct btrfs_fs_info *fs_info,
 				     bool interruptible);
-int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
-			      u64 dst);
+int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src, u64 dst);
 int btrfs_del_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
 			      u64 dst);
 int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid);
@@ -367,7 +366,8 @@ int btrfs_qgroup_account_extent(struct btrfs_trans_handle *trans, u64 bytenr,
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
index 0edfb58afd80..6befcf1b4b1f 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1557,7 +1557,7 @@ static int qgroup_account_snapshot(struct btrfs_trans_handle *trans,
 
 	/* Now qgroup are all updated, we can inherit it to new qgroups */
 	ret = btrfs_qgroup_inherit(trans, src->root_key.objectid, dst_objectid,
-				   inherit);
+				   parent->root_key.objectid, inherit);
 	if (ret < 0)
 		goto out;
 
-- 
2.40.0

