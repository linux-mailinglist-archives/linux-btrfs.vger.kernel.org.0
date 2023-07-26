Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D2D7640A8
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jul 2023 22:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjGZUk6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jul 2023 16:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjGZUk4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jul 2023 16:40:56 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB919EC
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 13:40:55 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 6788C5C0041;
        Wed, 26 Jul 2023 16:40:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 26 Jul 2023 16:40:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1690404055; x=
        1690490455; bh=JJ0H+v4Kmi+ad3UHW6tKa+EOnxzqUZcsFy+1TjVgi1k=; b=F
        SxHI85RqEErGuHmFGEIb8VemNN4oFo3jkwuIGouxzY4qQH6aXcsn+U9mQYxYPIEy
        6qRqKgwLVsMbnL8ZWN5j7Bm/20t0h3yMpRZvWDIm+upHnoKjLkLOvs6t/dXVLCpz
        jEiWwzQg3W4SVzgw7xtisaEuQ3gmPbn5QKTNTN1ojC0ALOduhRRHEUdWQ+Z8mrG8
        +k4uqRZ6GffcDi6Fh8VOYz99/BU0KcW2wj7yxHWLpPhMIKfSwgbPr8gzMMyJj8aP
        /VbvNeY5afuR5DhtXP3iV675CWlL3saXm79SoTPQnkKsFQYhgPnJ49E44HT4CDtX
        +Rc6lUWG1cxAogfYuHtgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1690404055; x=1690490455; bh=J
        J0H+v4Kmi+ad3UHW6tKa+EOnxzqUZcsFy+1TjVgi1k=; b=ALPYY8Pd189ofRS+4
        Zm/8OkBETUxevT7W2srTZPVw/DD1gSJRb7ju7PPHv0CMBF45B7oOMob0CMUzXDRT
        t+4+ioZwS1Nt7YB/Dpnvj6uVwMSegrsuctLcUPcyCKqb1T0TUerOWHs6i/87eIUb
        e1bphBLWd1WsUVZEPZexrAsEwq8es7GzjiU7sUho392D1+4eNkaucUEVi7d01s29
        PO5fBMHhAXPc+Rkg3/YnVlTAlFcjVshWdeQeYzEbVIA5jiAytyfI7iMij0X2e++D
        aSepz+sArVt/S0i4P/Fzbe3zCgnM6cno/B6syUR8AmzOx817TQXXP2J//sif5y+n
        bsjwQ==
X-ME-Sender: <xms:14TBZFyQIZtco3mhDrNLJmKWeqdFqsViVVuF1Tn2fniJycwauXyvzA>
    <xme:14TBZFQ7w1ma_E7bk07twvif0O2ssHY_BZoHvza2WCQx52PUrpgUi7cXuZo2GE-tw
    Nf6HXg1X-uud-7VL_4>
X-ME-Received: <xmr:14TBZPUSPiDTSARwkVpKS18Be7DIkm2OnD_cFIyVkOjy_LKJDNf9G3rt8F5bhUoqfNI4NWSSB2OYLmnsWxMZZUfS2xs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedriedvgddugeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:14TBZHicNbS_COewzdJX_iQH340CwJ51BgUKa6IBVmGKqcD8w0IgHg>
    <xmx:14TBZHAzS3CEiM-g4wbR0-F5vXV54w-onIckVbXKLoMEo--2-cIAnw>
    <xmx:14TBZAIjYmxLh1rcmows2lsJeb5MOhhu7wF5LfYjeKTd5MF28aZpsg>
    <xmx:14TBZKq5fMapzIjmVs2NegAzWIpKcJI-BmsLlSIJki8z7obDptPvrQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Jul 2023 16:40:54 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 07/18] btrfs: function for recording simple quota deltas
Date:   Wed, 26 Jul 2023 13:38:34 -0700
Message-ID: <85ff3dcd358a340f89e93a09eafd02e051944bcd.1690403768.git.boris@bur.io>
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

Rather than re-computing shared/exclusive ownership based on backrefs
and walking roots for implicit backrefs, simple quotas does an increment
when creating an extent and a decrement when deleting it. Add the API
for the extent item code to use to track those events.

Also add a helper function to make collecting parent qgroups in a ulist
easier for functions like this.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/qgroup.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/qgroup.h | 11 ++++++-
 2 files changed, 83 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 8e3a4ced3077..dedc532669f4 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -332,6 +332,35 @@ static int del_relation_rb(struct btrfs_fs_info *fs_info,
 	return -ENOENT;
 }
 
+static int qgroup_collect_parents(struct btrfs_qgroup *qgroup,
+				  struct ulist *ul)
+{
+	struct ulist_iterator uiter;
+	struct ulist_node *unode;
+	struct btrfs_qgroup_list *glist;
+	struct btrfs_qgroup *qg;
+	int ret = 0;
+
+	ulist_reinit(ul);
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
+	return ret;
+}
+
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 int btrfs_verify_qgroup_counts(struct btrfs_fs_info *fs_info, u64 qgroupid,
 			       u64 rfer, u64 excl)
@@ -4535,3 +4564,47 @@ void btrfs_qgroup_destroy_extent_records(struct btrfs_transaction *trans)
 	}
 	*root = RB_ROOT;
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
+		qgroup_dirty(fs_info, qg);
+	}
+
+out:
+	spin_unlock(&fs_info->qgroup_lock);
+	if (!ret && delta->rsv_bytes)
+		btrfs_qgroup_free_refroot(fs_info, root, delta->rsv_bytes, BTRFS_QGROUP_RSV_DATA);
+	return ret;
+}
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index d4c4d039585f..94d85b4fbebd 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -235,6 +235,14 @@ struct btrfs_qgroup {
 	struct kobject kobj;
 };
 
+struct btrfs_simple_quota_delta {
+	u64 root; /* The fstree root this delta counts against */
+	u64 num_bytes; /* The number of bytes in the extent being counted */
+	u64 rsv_bytes; /* The number of bytes reserved for this extent */
+	bool is_inc; /* Whether we are using or freeing the extent */
+	bool is_data; /* Whether the extent is data or metadata */
+};
+
 static inline u64 btrfs_qgroup_subvolid(u64 qgroupid)
 {
 	return (qgroupid & ((1ULL << BTRFS_QGROUP_LEVEL_SHIFT) - 1));
@@ -447,5 +455,6 @@ int btrfs_qgroup_trace_subtree_after_cow(struct btrfs_trans_handle *trans,
 		struct btrfs_root *root, struct extent_buffer *eb);
 void btrfs_qgroup_destroy_extent_records(struct btrfs_transaction *trans);
 bool btrfs_check_quota_leak(struct btrfs_fs_info *fs_info);
-
+int btrfs_record_simple_quota_delta(struct btrfs_fs_info *fs_info,
+				    struct btrfs_simple_quota_delta *delta);
 #endif
-- 
2.41.0

