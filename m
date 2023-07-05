Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2835E7491CC
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jul 2023 01:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbjGEXXt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jul 2023 19:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbjGEXXX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Jul 2023 19:23:23 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1311BC2
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jul 2023 16:23:17 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 1E6615C0281;
        Wed,  5 Jul 2023 19:23:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 05 Jul 2023 19:23:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1688599397; x=
        1688685797; bh=eP5hdF+YLf/Yxlocn9TVXAugyHMatNQlD2dMek3bOjA=; b=k
        k/+murjv35Q/UkCjOIHzdZU9KkzxlMlv3wztMlEKlQ5VwMo0rkrPRPjXETLtK5M2
        UhmQmoErRCnkgl2fEvcq56zjhOkM9lUNQtE0rlYDW5pG2DwXjGr6mFxG1avw2Y7R
        vJgD4UcEU3hFc/q6SD6aw5ORpmzSiI+mOKOU0Al7f9w27QONcVvOPQOxR/LfPvpS
        YEBr/dkGZA3PN5OsStLqIt3PoAjnGIuAj6RTIOTvTeLgoyUrDj7qoC483/AQpAWI
        q9h5qye6GUTc+xngubbNNRrIsFz6Qx5mcSIR/CpLjKtST0kJyc86+A8HWufNXkoy
        XnQ9uwB34h9YPZSFwgUWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1688599397; x=1688685797; bh=e
        P5hdF+YLf/Yxlocn9TVXAugyHMatNQlD2dMek3bOjA=; b=evxQ2CEFR2xr7to7L
        2B3J4H/BOnvmMMvHcpLGSFFxHLBlzptJq6Au9UFS0lrDYbDZMS8RYZOcyk7CgQi3
        GsxXb9Ef4y6vF0IcB9XpFnmWH7S55oyAfyhomJ3Oh6sqfc78dW4KPflClnBdAO3W
        HR1kwMhpQUum4Tj5HPeZma32+tBuAN455a45nEFWtdmNexyLSv5Hlb49hA/Dmjdc
        XIJ9lLWbOxr1Q472ImXFL+UTy9L8hBYwXHtlrSoyDfw0UbNpJAqe/lkoVSSaEeTA
        jyUqj6FOp/q1Juk0OEkqVDBr24udRB/cSBIXIO7mdvD5SrNW2vlusnxkgnzu632d
        4bkWQ==
X-ME-Sender: <xms:ZPulZMwD-Kc4vwS-UUqiCDdcGPyqZQa2MCOFFr4Uq-DeuXQQB6H6_g>
    <xme:ZPulZAQCCQiK-xgzrpdQ7ZeTb7PPv4vfNtN36jbscU6WMmvEvJKvnY8W9IA6As4Yf
    6rvobY0VZh8j7k8dCc>
X-ME-Received: <xmr:ZPulZOXLtc7Ed3J6gzjXAD66iqt4_dClBE9RoHtnnJaZbGQIm9JBXIfI42DvJUOfRtUEmFClxFItleEoL0jjp6U9RN0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:ZPulZKj6lio2MPqjdWjm1su6RP6WfkELD2ttQcpqoA2AKEF_MR4P6g>
    <xmx:ZPulZOBtn8alxb_dLBj6nQyvWviyDSz-YNPNdgH0EegyTohRkTMX9A>
    <xmx:ZPulZLKk_9kScDsHaaM0BmIv5EeSgL6Yw3Y7n8iuf-oQMVX4-4TDVA>
    <xmx:ZfulZJqgeGqNLY2URdluRYABxV3SjTUUBfwF6c4Q7qpTZ0dXPZKlXg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jul 2023 19:23:16 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 08/18] btrfs: function for recording simple quota deltas
Date:   Wed,  5 Jul 2023 16:20:45 -0700
Message-ID: <17e93036e598545781cb13376abb868dc22d51b2.1688597211.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1688597211.git.boris@bur.io>
References: <cover.1688597211.git.boris@bur.io>
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
 fs/btrfs/qgroup.c | 82 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/qgroup.h | 11 ++++++-
 2 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 8419270f7417..97c00697b475 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -333,6 +333,44 @@ static int del_relation_rb(struct btrfs_fs_info *fs_info,
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
@@ -4531,3 +4569,47 @@ void btrfs_qgroup_destroy_extent_records(struct btrfs_transaction *trans)
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

