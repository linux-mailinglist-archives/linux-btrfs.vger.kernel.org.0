Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB23775BAD8
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jul 2023 00:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjGTWzG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jul 2023 18:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjGTWzE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jul 2023 18:55:04 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FE82D4D
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 15:54:51 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 1EB975C01A3;
        Thu, 20 Jul 2023 18:54:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 20 Jul 2023 18:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1689893681; x=
        1689980081; bh=JJ0H+v4Kmi+ad3UHW6tKa+EOnxzqUZcsFy+1TjVgi1k=; b=a
        G11KmJjiXgqaP08bHFl2EnYqku5/TQiLf0Q8Hsr3cweGU/KE+oIAEG5dHcVsPgq0
        DiQaBOwEys8n+CW02r/joZp4Z8wQP6Y4SIhru768xh5pBx4J7I3FEnVP115zM47/
        EBMTyQmr1dxfGhdz7LuZOlFpiUbAFHqGh8VE6IfwWwLRd27vWtR1imWTyPxAIypN
        AlkCroM5vNOxMMol4ReaF27dqyTEVcr6PdFxkOSST464drQtnQkZO+pSj/mP+qZC
        ShwQgCCh1hcuoTlEyVNVGMu4XQioYMvMKSwIAEwiw24anOpZXWqNZ92+gBJ3KNEJ
        0eIwz4WqLJ0vx//dTqFDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1689893681; x=1689980081; bh=J
        J0H+v4Kmi+ad3UHW6tKa+EOnxzqUZcsFy+1TjVgi1k=; b=P3nV6l7PP/U08+iZW
        Op816BjHW5D9x1Ok/oCXepUiqJsz8DjiTMNNJttaZ40ajBIGsQ2NTBTNSZ2xOZXU
        UCBkeze7Kccy4FkOKDSP3dGISGqCd2Q8h2NIubwaVtDdEIBh1eoRg7nA9ytPhQuy
        bt5olSZr0tj9tHzwWJj2pA8l4EW1FaxBO/jpF+P8FI+hPYrdgHcULl6+AUKZmKNB
        BNUANb1Ni5QUATFAuBp6+p6uR/VijrEdZrn9y6R3LKXiIXGEZWyMosXgjEDWoaZj
        rlgJIGgHDh0zzUn55HDXFfOX2B4uDCaw0cTJ6tiDhcJF56bSwmGHxYAl2Z8dnWIJ
        l+QcQ==
X-ME-Sender: <xms:MLu5ZCp_OVOX-wkZF03ECX8_yVComfZFRRCldJ6f72CzVd-CfZPz2Q>
    <xme:MLu5ZAr9aAaWfQ1c8gb2aiEbU_cjGz7QnQcpM6C4hX8jewKPKxxpyEkeGv4azreF-
    uoqHNGsQx2kdG1aRxM>
X-ME-Received: <xmr:MLu5ZHMRo_Z63IDlZr0n5oCUfobvdJJJKgL6RwkwlhjjUVKAoMJ8-FnJqBU-_aCs_p56x195qEqAb7uKWvLsfvO4Uck>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedugdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:MLu5ZB4sA5qhrSR-xAbAPKKKQjokLhlKjSLvEaXi5D5uyI3N0qJ5oA>
    <xmx:MLu5ZB6B6FgoIDziCfKPsHVvvA9xWdvazC3qUdrbiZ0nYaxoutg23g>
    <xmx:MLu5ZBiKjkuFwFQKcEsyQjI3N6b4CzV55-icU2oBMczFuzdgU3ebaQ>
    <xmx:Mbu5ZOjJxy2Aa7KFAckoBDuc4K0j_zo07VL9ZD5af8x_f7i8w3EKSA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Jul 2023 18:54:40 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 09/20] btrfs: function for recording simple quota deltas
Date:   Thu, 20 Jul 2023 15:52:37 -0700
Message-ID: <e4817a282ca7b6cb280da027b42c0f540761705c.1689893021.git.boris@bur.io>
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

