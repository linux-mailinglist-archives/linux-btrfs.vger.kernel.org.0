Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B195F765F13
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jul 2023 00:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbjG0WPW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jul 2023 18:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjG0WPV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jul 2023 18:15:21 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C5913E
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 15:15:20 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id F0DFA3200319;
        Thu, 27 Jul 2023 18:15:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 27 Jul 2023 18:15:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1690496119; x=
        1690582519; bh=JJ0H+v4Kmi+ad3UHW6tKa+EOnxzqUZcsFy+1TjVgi1k=; b=h
        aPdgvw0gcLmbuxHoXGrIcBdAwCP/ibdOLnJ/umXL7PTS6GOg8wRNReqTtxvJSIGl
        7jFIoU+KHP3AzXThAHkeCqk89GliqSvVbzWuamGAwJOxcclevWyX2Vx5UO951qO7
        SAltGrRX31ehNBLlMrzJp/njZqZTJvMNB0b2q2rrCaVD8mfuiH5Wn7cMAfjb8rD6
        45I83n6PXzxedewvJ4GS/cQXfzb+vrZXfN2jJNDeiTWdUyaCZ5zvsgVldetWUO9T
        ax4XU5Sw0el8Vfa2cM/FI3NZ+pJS8UAM0XkNzjtO+J6zvBg60CG9nzYNbP78qza3
        zin0XJl+Wasc7DpGuVsfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1690496119; x=1690582519; bh=J
        J0H+v4Kmi+ad3UHW6tKa+EOnxzqUZcsFy+1TjVgi1k=; b=JZNF4dlIehYJFOaMf
        /HOLUMqZ9nmmGXbpVersNvww0FlvxIJvovFThmswf8Z7B2HZMqE44owJMyDneoaY
        jHDtn4IWb8cVZtz9KU6Agwo8OCdxgeoBaTy2Xma0Y0zUoSFH/fxPXQ4KhGQMvYcm
        x+NcnKWwPMsLy9l60YY4fn3MbaThtfmMrULTfKvQQ4PkojlBuRLjNvjh2whxHPdW
        t+Pg4XXG51/ivyKLOji9gAVblokfPH1kGhsiE3F65DkrCz943j5pA1AXYberL+Et
        zGTnL64S3tfRP/JO9MFc9FGeESKS3GIH4cnXmlHAKNMLazVEyqIVT03NvIPDYOG+
        MSBBQ==
X-ME-Sender: <xms:d-zCZMc2p6G0jc8_-Wlf8x5tlVPdgLXyrxZ1VY3V0jeoxWLYm8X2Jg>
    <xme:d-zCZOM402iCqkEgHyJWJAYHMVRUXDTbuF0nkRBiovMx-W9YVqYwn_yyOHCxOptlT
    7Iy5DYI_0XB6UOhTmI>
X-ME-Received: <xmr:d-zCZNiCr6mqaMejxsVoY4vj_nNkvcVNl5T0-rjrIR7pzIp_Rkg_xZlRHn_zbYxBwqjxrTPoiwHBVGxDaZM043656Mc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrieehgddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:d-zCZB8yTCPHiHXN5UcVOoyK5YPNFb1AcdO8Hp3sDoiPtJFjCEIy6g>
    <xmx:d-zCZIv1UM_tAXpBFnTJcPtEoTMnSab3liE7RxOctz9xk_NPC45liw>
    <xmx:d-zCZIEKHmmAYLY_QfW5v50iVGFTwrJ1cXq-JnOxGjH_3Ex0ZmJNEQ>
    <xmx:d-zCZO0iaRsyziKoJOYsCoptjwokFl73aAoacdDyEhMlAnJHTA0Ong>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Jul 2023 18:15:18 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 07/18] btrfs: function for recording simple quota deltas
Date:   Thu, 27 Jul 2023 15:12:54 -0700
Message-ID: <85ff3dcd358a340f89e93a09eafd02e051944bcd.1690495785.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690495785.git.boris@bur.io>
References: <cover.1690495785.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

