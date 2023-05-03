Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC926F4E47
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 03:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjECA7y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 May 2023 20:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjECA7w (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 May 2023 20:59:52 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62312D61
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 17:59:49 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 306825C030C;
        Tue,  2 May 2023 20:59:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 02 May 2023 20:59:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1683075589; x=
        1683161989; bh=gOBp4vpA3+LJF4Cto8NWnS6ULz/n7HkBuk3VUY0eR+E=; b=r
        XMKOPVluq+soPU/cyshT3EIfb+xlYWMEjX/gmxk8gEqT8/Z+J00BAS39ACoQg4A9
        VdtJovQG+17WToDdctR/A3Tte7FvBOjEozYWjd0oSAq0m17f1Rckoe9LfWtmk4n1
        nYmw3nIuQxp749sAr5Vr3QHAGhM9H/A7EEQVY8mWrFCerzPsD3IyffwMz2dilDZq
        PhuQeFv6AEQbDRk9eKKPO95OBsqm02752g2366NFhFGdMReGWdY3Rr9i0yhH62vQ
        WdwAamDegEMbLdOy6MzeXsn8JqIm8CmE9f0Yjy0JHOv+Fo4jjGJlPEB9PNhnwbkr
        cknjEzUTmC3kjqnt8Oyrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1683075589; x=1683161989; bh=g
        OBp4vpA3+LJF4Cto8NWnS6ULz/n7HkBuk3VUY0eR+E=; b=akHAuBiSb8IS9p58J
        3fc663t1aIBryr+LSJfIinVWASNfZXpmRBkPNFgQLRBg2I/w3hYPsddRyfrkrR5a
        dyT6ygL/k7YRnZUKG5BUxXDsdEsyfr6DnGjHDexDrbO4BGUWB4CKvfZGnKoTRVfz
        PJ0rvw6rKv6mO6QkByw94gE9KhqvX2nAACGRnVtkyGfAtmz4mxi5ezNIzj3DeS3N
        88PaOmdOV8FGbwrMM0ZFJCJMftjqy0mY+unfjxkMr0FNyJW+56M8EkMvXhiLRwlj
        gwEGgPcMJwwvyVLui5h8TH08TCITTziyn4DHkTfck/Jbjc5lLFcI3MsiTocZzel3
        ly/ug==
X-ME-Sender: <xms:BbJRZNtuYAijsUPUYedRNAyAa2Py4swryU2OzS0Ls9m81yBbGziGSg>
    <xme:BbJRZGcRgpij6IrKSJCeoXP7e451S1qpF1FArgAd4VmiHArfi7AD2VSNq6NKNfwLT
    1n6zdLLpq3tU6sxqt8>
X-ME-Received: <xmr:BbJRZAxLWB9aFoSsGRbtdo9o2fEgIWhQxgXxynNkVOhrow0aPBe0lA-f>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvjedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:BbJRZEMo-Ie62tR8FXc24KCE2lOLRbICw5ewif-OsM_Xo-Korr9mvQ>
    <xmx:BbJRZN8a3Uy2v8-LKtQZ0oLjku_9w76dD-XMiGQD0x1bXUJ2XYFu7A>
    <xmx:BbJRZEVnwwjhotQNlm5uK8t89zQpEatyKKsaOmCvVNQyeFRVxPyITQ>
    <xmx:BbJRZKE9B1Z4pw_d1LCoZRZ7a9lS_aMMnV_5scMusDBhDWTm_755XA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 May 2023 20:59:48 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/9] btrfs: new function for recording simple quota usage
Date:   Tue,  2 May 2023 17:59:23 -0700
Message-Id: <33e6475ff008fb21ece6eb288c8b78fcacb4d478.1683075170.git.boris@bur.io>
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

Rather than re-computing shared/exclusive ownership based on backrefs
and walking roots for implicit backrefs, simple quotas does an increment
when creating an extent and a decrement when deleting it. Add the API
for the extent item code to use to track those events.

Also add a helper function to make collecting parent qgroups in a ulist
easier for functions like this.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/qgroup.c | 85 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/qgroup.h | 10 +++++-
 2 files changed, 94 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 3c8b296215ee..8982b76ae9e5 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -332,6 +332,44 @@ static int del_relation_rb(struct btrfs_fs_info *fs_info,
 	return -ENOENT;
 }
 
+static int qgroup_collect_parents(struct btrfs_qgroup *qgroup,
+				  struct ulist *ul)
+{
+	struct ulist_iterator uiter;
+	struct ulist_node *unode;
+	struct btrfs_qgroup_list *glist;
+	struct btrfs_qgroup *qg;
+	bool err_free = false;
+	int ret = 0;
+
+	if (!ul) {
+		ul = ulist_alloc(GFP_KERNEL);
+		err_free = true;
+	} else {
+		ulist_reinit(ul);
+	}
+
+	ret = ulist_add(ul, qgroup->qgroupid,
+			qgroup_to_aux(qgroup), GFP_ATOMIC);
+	if (ret < 0)
+		goto out;
+	ULIST_ITER_INIT(&uiter);
+	while ((unode = ulist_next(ul, &uiter))) {
+		qg = unode_aux_to_qgroup(unode);
+		list_for_each_entry(glist, &qg->groups, next_group) {
+			ret = ulist_add(ul, glist->group->qgroupid,
+					qgroup_to_aux(glist->group), GFP_ATOMIC);
+			if (ret < 0)
+				goto out;
+		}
+	}
+	ret = 0;
+out:
+	if (ret && err_free)
+		ulist_free(ul);
+	return ret;
+}
+
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 int btrfs_verify_qgroup_counts(struct btrfs_fs_info *fs_info, u64 qgroupid,
 			       u64 rfer, u64 excl)
@@ -4472,3 +4510,50 @@ void btrfs_qgroup_destroy_extent_records(struct btrfs_transaction *trans)
 		kfree(entry);
 	}
 }
+
+int btrfs_record_simple_quota_delta(struct btrfs_fs_info *fs_info,
+				    struct btrfs_simple_quota_delta *delta)
+{
+	int ret;
+	struct ulist *ul = fs_info->qgroup_ulist;
+	struct btrfs_qgroup *qgroup;
+	struct ulist_iterator uiter;
+	struct ulist_node *unode;
+	struct btrfs_qgroup *qg;
+	bool drop_rsv = false;
+	u64 root = delta->root;
+	u64 num_bytes = delta->num_bytes;
+	int sign = delta->is_inc ? 1 : -1;
+
+	if (btrfs_qgroup_mode(fs_info) != BTRFS_QGROUP_MODE_SIMPLE)
+		return 0;
+
+	if (!is_fstree(root))
+		return 0;
+
+	spin_lock(&fs_info->qgroup_lock);
+	qgroup = find_qgroup_rb(fs_info, root);
+	if (!qgroup) {
+		ret = -ENOENT;
+		goto out;
+	}
+	ret = qgroup_collect_parents(qgroup, ul);
+	if (ret)
+		goto out;
+
+	ULIST_ITER_INIT(&uiter);
+	while ((unode = ulist_next(ul, &uiter))) {
+		qg = unode_aux_to_qgroup(unode);
+		qg->excl += num_bytes * sign;
+		qg->rfer += num_bytes * sign;
+		if (delta->is_inc && delta->is_data)
+			drop_rsv = true;
+		qgroup_dirty(fs_info, qg);
+	}
+
+out:
+	spin_unlock(&fs_info->qgroup_lock);
+	if (!ret && drop_rsv)
+		btrfs_qgroup_free_refroot(fs_info, root, num_bytes, BTRFS_QGROUP_RSV_DATA);
+	return ret;
+}
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index d4c4d039585f..0d627a871900 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -235,6 +235,13 @@ struct btrfs_qgroup {
 	struct kobject kobj;
 };
 
+struct btrfs_simple_quota_delta {
+	u64 root; /* The fstree root this delta counts against */
+	u64 num_bytes; /* The number of bytes in the extent being counted */
+	bool is_inc; /* Whether we are using or freeing the extent */
+	bool is_data; /* Whether the extent is data or metadata */
+};
+
 static inline u64 btrfs_qgroup_subvolid(u64 qgroupid)
 {
 	return (qgroupid & ((1ULL << BTRFS_QGROUP_LEVEL_SHIFT) - 1));
@@ -447,5 +454,6 @@ int btrfs_qgroup_trace_subtree_after_cow(struct btrfs_trans_handle *trans,
 		struct btrfs_root *root, struct extent_buffer *eb);
 void btrfs_qgroup_destroy_extent_records(struct btrfs_transaction *trans);
 bool btrfs_check_quota_leak(struct btrfs_fs_info *fs_info);
-
+int btrfs_record_simple_quota_delta(struct btrfs_fs_info *fs_info,
+				    struct btrfs_simple_quota_delta *delta);
 #endif
-- 
2.40.0

