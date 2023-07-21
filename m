Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D227F75CD10
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jul 2023 18:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbjGUQEb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Jul 2023 12:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbjGUQE3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Jul 2023 12:04:29 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BBD2D50
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jul 2023 09:04:28 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 6EF3F320098E;
        Fri, 21 Jul 2023 12:04:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 21 Jul 2023 12:04:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1689955466; x=
        1690041866; bh=JJ0H+v4Kmi+ad3UHW6tKa+EOnxzqUZcsFy+1TjVgi1k=; b=Z
        LzWrvw+UPuk6FV0pfbjuIaZvRyb1y1JM1xvhhl8Aiijr6JIYafFNqeUB6MRl/HK9
        Y1b571GRoSMS5WZO5OYm1wteW/tV65qnZHmRnEMEm1Egqu2VBxRbqR7XfdVhsFQu
        4WNcwGnvQScFdL9l9o8BihORbdgjaxQcHnOR3kRJNVqIjlZReGtpMmXURUOGVSx+
        ZfmeDmgAFIQbV98957EkhppeCUIijk4dCC3iNtcPzH/pwkClJU+yebtn9peVJUqq
        OMgvS/25WKUbjt9fvxZ7dmfz69zmGkTHIMC4/6XV2XoKUHc5Jw5L6AW3Woh4xQOP
        SQ0I0Ya+mT67KSP0cCTzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1689955466; x=1690041866; bh=J
        J0H+v4Kmi+ad3UHW6tKa+EOnxzqUZcsFy+1TjVgi1k=; b=boUFz2hy+yLGakw5k
        wa6NmrzDpYu6tkqy7FP3+FsDZlsy81EZKWZK1btUxGLwYDujWeMF43ghQNK96bu3
        GCdjzwuXfv45X6ALcmKC/S/MpvgwVuMCoVuwpHZNrFM2KZ52rZ9eWDLxuGemHWuL
        wc3Ia+P+18yXKjDOb8xuHSy3YnofuMU1ZwHlTKVfCtpwYZuAttMN/ze9UeMg8ANY
        a90+evnRv6zrtavQ0WOSLsggySDeyvm4fSvJv6YK7Rk14ka5UFwepqN5BmCkpMVU
        4r3w/kq1qwJPm5vgut2kg4QcET+OHPyArBATbLjggb8xV3I/uQge9BIP1sruTWdj
        92IIA==
X-ME-Sender: <xms:iqy6ZMZLHXD6h-qrsOmKmv8mDF7wmpYq_TsraSHdFyph4ub4TaKjzw>
    <xme:iqy6ZHZDC-VzPBiA9oTzQFdT68xeRhS7i8A0D_LnCJWLt3mnnVwIerWaGj0gtA7yz
    kMZB67o6tizjtmvoEU>
X-ME-Received: <xmr:iqy6ZG8VkCCQVkcNCff-5402MiMBtVeN2A7j8LcMw4iYl0FjROjL22DHtO4BO1NDhHlphxtYQIHTdRd9qEN14QiZF9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedvgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:iqy6ZGpG0pmpyImmvF4EryaVgYYoBQQ35BqaqwZW6IP7BJRkqkpNpQ>
    <xmx:iqy6ZHr7xntjyQJgC0ug9O2TFh8MzH3ZBqwWW-2hqscmioxS4GtKEg>
    <xmx:iqy6ZERLB5ttJpYEP0QuzgmzHjTXcq_BgjydhaXXAaCIJ8-ERjIpsw>
    <xmx:iqy6ZGTROuJ7Fq1Bqs6ADtf90gPuMNcpl33ECqr-EYpW8LOvRUu6Ew>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Jul 2023 12:04:26 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 09/20] btrfs: function for recording simple quota deltas
Date:   Fri, 21 Jul 2023 09:02:14 -0700
Message-ID: <e4817a282ca7b6cb280da027b42c0f540761705c.1689955162.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689955162.git.boris@bur.io>
References: <cover.1689955162.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

