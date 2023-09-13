Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A30E79DD07
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Sep 2023 02:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237605AbjIMANG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Sep 2023 20:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236262AbjIMANF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Sep 2023 20:13:05 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A0E1706
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Sep 2023 17:13:01 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 17D6E320093C;
        Tue, 12 Sep 2023 20:13:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 12 Sep 2023 20:13:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1694563980; x=
        1694650380; bh=EyihdLC6f5fcFnSYV+3SyrA2LL3gKkYGzp6vnGpbX3k=; b=B
        9QLgq+Dh83rvND8ypSFJ+T61odXN9SKmxX41A7Aagcx3LJFuMgzHH6CD483tJp1h
        y0O1oXSWnd2vdmlv8mlSZLvMHYH7+cHOvt7wlcOMxHZxsiNvLkHGdfCFLiSaIATZ
        GSctVAAZEQ4NIkgZwGWtuYny366hQXFQIbyJ2apd35I6AvKRvXWZH7al8y6FE3g2
        pe/6Ck6QFAbqQBvzAfs1qOatkUMpZoOjHjGondSMuOPFhbYiAmnm4cmDX2i8IzXQ
        2XnuOveX1yN1YIhc3so4DVhUxoKKBCQI8OMNgWPDVHwQ557v2+Exa2GyrYCQUo9t
        xSrLyN37UT7gS/v1mtxVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1694563980; x=1694650380; bh=E
        yihdLC6f5fcFnSYV+3SyrA2LL3gKkYGzp6vnGpbX3k=; b=wdmbAYyTndzzuvtxQ
        Un+gNZoudxEFBKe8smePwRBeca48cE7/B3+KGwZPf8HSW6GSbrvOyg6rMfj+n5Zm
        hdurKjwLP98HxNjolgGcW2jNB4mvZYLcZZQ8IHX4Fyssg7K5tijnnqQl0up+RVCQ
        0CT/PTu+eyshDN4t1wAWeOQKHBWCUZ+kS9RMJTrkCz8Yare910vf4EdyhC1kUpf2
        IWqsxAorgRSjli8bCU01INSshtWv5cs6N7fiZCIBJ1JJz890eOcGx6TMZyh14Oai
        z9yH9vPnKzXlHoyJJdFCYXpjOQGfU+DNYjBOeLWpLDfI016exVnl8ks0vRjNwjkX
        qjuMQ==
X-ME-Sender: <xms:jP4AZXO_7K2cHWTtvFTncbChqWLbojB5oVZj1azHqRxffNo9hx2jaA>
    <xme:jP4AZR_yyEGhRPHtC0x3m6hyiHerv1nXReXU6h0tu2wMKgjCm6AuzSlcaQzOAOQW1
    zFcYQ_htckz67JPF40>
X-ME-Received: <xmr:jP4AZWRJC5omzlBSNPzv4YehYE6t79ybPQl_z6uB1nEFHG5AIIL0nBZBS6nyc_ZI_xs9YdTfM2rsm0sq7tMYnrtoC4o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeijedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:jP4AZbuD0V-_MMFGj5-6vWOzsjmGnq6RbiJTE2Ct46s0Nvp00OBWxQ>
    <xmx:jP4AZffcNt9ZiMx5JfLZVbpZ_RAOGEvdlK3h9vAT4BYaPB7WHJyqJQ>
    <xmx:jP4AZX2bfLuyqaRJ9tpn-Ph5Cbr16yXWQtnXGGj-1YIqOliHl4XbnA>
    <xmx:jP4AZfmuyr18vtd0HCAqiyb7MbLOD8tqafKAXIfUD_aW2bRAAo3bYQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Sep 2023 20:13:00 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 07/18] btrfs: function for recording simple quota deltas
Date:   Tue, 12 Sep 2023 17:13:18 -0700
Message-ID: <98756e1ee7ffe6acf2743e88e9c53fd7836a8f6d.1694563454.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694563454.git.boris@bur.io>
References: <cover.1694563454.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Rather than re-computing shared/exclusive ownership based on backrefs
and walking roots for implicit backrefs, simple quotas does an increment
when creating an extent and a decrement when deleting it. Add the API
for the extent item code to use to track those events.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/qgroup.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/qgroup.h | 15 +++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index ae6ccf1eb0e4..86d3a46ee33f 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -4597,3 +4597,48 @@ void btrfs_qgroup_destroy_extent_records(struct btrfs_transaction *trans)
 	}
 	*root = RB_ROOT;
 }
+
+int btrfs_record_squota_delta(struct btrfs_fs_info *fs_info,
+			      struct btrfs_squota_delta *delta)
+{
+	int ret;
+	struct btrfs_qgroup *qgroup;
+	struct btrfs_qgroup *qg;
+	LIST_HEAD(qgroup_list);
+	u64 root = delta->root;
+	u64 num_bytes = delta->num_bytes;
+	int sign = (delta->is_inc ? 1 : -1);
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
+
+	ret = 0;
+	qgroup_iterator_add(&qgroup_list, qgroup);
+	list_for_each_entry(qg, &qgroup_list, iterator) {
+		struct btrfs_qgroup_list *glist;
+
+		qg->excl += num_bytes * sign;
+		qg->rfer += num_bytes * sign;
+		qgroup_dirty(fs_info, qg);
+
+		list_for_each_entry(glist, &qg->groups, next_group)
+			qgroup_iterator_add(&qgroup_list, glist->group);
+	}
+	qgroup_iterator_clean(&qgroup_list);
+
+out:
+	spin_unlock(&fs_info->qgroup_lock);
+	if (!ret && delta->rsv_bytes)
+		btrfs_qgroup_free_refroot(fs_info, root, delta->rsv_bytes, BTRFS_QGROUP_RSV_DATA);
+	return ret;
+}
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index 7fc64d665353..5eabd944c782 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -269,6 +269,19 @@ struct btrfs_qgroup {
 	struct kobject kobj;
 };
 
+struct btrfs_squota_delta {
+	/* The fstree root this delta counts against */
+	u64 root;
+	/* The number of bytes in the extent being counted */
+	u64 num_bytes;
+	/* The number of bytes reserved for this extent */
+	u64 rsv_bytes;
+	/* Whether we are using or freeing the extent */
+	bool is_inc;
+	/* Whether the extent is data or metadata */
+	bool is_data;
+};
+
 static inline u64 btrfs_qgroup_subvolid(u64 qgroupid)
 {
 	return (qgroupid & ((1ULL << BTRFS_QGROUP_LEVEL_SHIFT) - 1));
@@ -407,5 +420,7 @@ int btrfs_qgroup_trace_subtree_after_cow(struct btrfs_trans_handle *trans,
 		struct btrfs_root *root, struct extent_buffer *eb);
 void btrfs_qgroup_destroy_extent_records(struct btrfs_transaction *trans);
 bool btrfs_check_quota_leak(struct btrfs_fs_info *fs_info);
+int btrfs_record_squota_delta(struct btrfs_fs_info *fs_info,
+				    struct btrfs_squota_delta *delta);
 
 #endif
-- 
2.41.0

