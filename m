Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB48675CD0D
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jul 2023 18:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbjGUQEZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Jul 2023 12:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232385AbjGUQEX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Jul 2023 12:04:23 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E192D7C
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jul 2023 09:04:22 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 016E6320098E;
        Fri, 21 Jul 2023 12:04:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 21 Jul 2023 12:04:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1689955461; x=
        1690041861; bh=M10GRgW8Oo/CA1itNOSle6w3dntzCKyqXOPnbe/r0Ao=; b=M
        OTH5gO7TU+qVTvxf9QgZ+9zSC7LVD1G2BYW7bC3T+XuRGM1FIHo8jbJRTD32FiWu
        Bjwp0Nzj6YtabC9dM0x1f6AKOPWA6mUdUCHpx/i+4AxqhVjN55WWl73k2H/kXiJt
        URYJnC7nbFAL8W2CjSVCgosfJiV7dSxAFx5x2myp/4/N9t5W2wRzIMYOjurcZvmn
        9RC/POXRFw9KilEBFuI2D7AgqlPFeZrfE7mSKClYhnAldhoSSF0mm5LApaqMS2B3
        SHrsTHu+NLnR9leJ/Pa/7QYhO8h5zJyGoq9SaEjlR56qI9jdKBJl1bMW+pBL6GJH
        5olVza9HVov7CWQX3bMvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1689955461; x=1690041861; bh=M
        10GRgW8Oo/CA1itNOSle6w3dntzCKyqXOPnbe/r0Ao=; b=hnXY44C0DN+ymeWkl
        JmdBxaMweLn9yxYVwyT58e3vV0pIfwszqvQJhQR9K61K2HYZJNtRVHJ9AV/TDXS/
        ybdeQDS8uNXIK+1bOJ+idh4rRJ8o9hGVfdV1+hak6FRfLfFMYNV8Jmf0IwEXwGii
        F3WVG1hdVXSeMgC9Ad/lgbdp+U5v9WG2FDgDjvYunie4pQcAS3tqB3+k3N/B0PZ+
        MrnatdRJVsZ09SVtc0nZwLmi0rvUvTw2e1yhlqPlj9GtgTh+QsoaRyVDM7oDywoF
        xSN7ACcLrzg+bjlwL9imJ98ufVnL3uGDajgBcdHF5uMqlTr+4Rc30CyggtfYIAyZ
        98FYw==
X-ME-Sender: <xms:hay6ZOhI0crpxKqSYO5g_6N1q5eeSYTK60dwXWLFOuqKN6IhVjk3wg>
    <xme:hay6ZPCWchBDbantPBiOPirtOF-F48M11XMcfPMbL2SUkdx6VGOdkaH-g8qQsX6hN
    ZKqEHZE5ZvmMR2GT9k>
X-ME-Received: <xmr:hay6ZGE8BjF5ogvR34439MudWRkVC_cNbtK2lcVbYNYLYEzItCeBSnc0-LNUoTG531HldRDKlMwpELYTbZMyf4WLKGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedvgdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:hay6ZHRHNobqhCXUhQdwMjaLEMgpMEbuapE68R1FEPyAw__LttQmvg>
    <xmx:hay6ZLxogpwMe4xnk91xMiVqNRkRFpv_MiZoSe07zMLlJuIkyi3IRA>
    <xmx:hay6ZF4c1uM7PaRaNtJhqwUSe2GT1uWXeKM8CjRM4-KL6AS1wA52pw>
    <xmx:hay6ZJYkoFJwseuuY9MqY5L3aQyKRpkjo555rgrlBkpTF5uqMxRTBw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Jul 2023 12:04:20 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 07/20] btrfs: flush reservations during quota disable
Date:   Fri, 21 Jul 2023 09:02:12 -0700
Message-ID: <dcd72a95aa5054adfa33643de70d05e49fdf5290.1689955162.git.boris@bur.io>
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

The following sequence:
enable simple quotas
do some writes
    reserve space
    create ordered_extent
        release rsv (store rsv_bytes in OE, mark QGROUP_RESERVED bits)
disable quotas
enable simple quotas
    set qgroup rsv to 0 on all subvols
ordered_extent finishes
    create delayed ref with rsv_bytes from before
run delayed ref
    record_simple_quota_delta
        free rsv_bytes (0 -> -rsv_delta)

results in us reliably underflowing the subvolume's qgroup rsv counter,
because disabling/re-enabling quotas toggles reservation counters down
to 0, but does not remove other file system state which represents
successful acquisition of qgroup rsv space. Specifically metadata rsv
counters on the root object and rsv_bytes on ordered_extent objects that
have released their reservation as well as the corresponding
QGROUP_RESERVED extent bits.

Normal qgroups gets away with this, I believe because it forces more
work to happen on transaction commit, but I am not certain it is totally
safe from the ordered_extent/leaked extent bit variant. Simple quotas
hits this reliably.

The intent of the fix is to make disable take the time to clear that
external to qgroups state as well: after flipping off the quota bit on
fs_info, flush delalloc and ordered extents, clearing the extent bits
along the way. This makes it so there are no ordered extents or meta
prealloc hanging around from the first enablement period during the second.

Signed-off-by: Boris Burkov <boris@bur.io>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/qgroup.c | 47 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 558f66994667..18f521716e8d 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1248,6 +1248,40 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
+/*
+ * It is possible to have outstanding ordered extents
+ * which reserved bytes before we disabled. We need to fully flush
+ * delalloc, ordered extents, and a commit to ensure that
+ * we don't leak such reservations, only to have them come back
+ * if we re-enable.
+ *
+ * i.e.:
+ * enable simple quotas
+ * reserve space
+ * release it, store rsv_bytes in OE
+ * disable quotas
+ * enable simple quotas (qgroup rsv are all 0)
+ * OE finishes
+ * run delayed refs
+ * free rsv_bytes, resulting in miscounting or even underflow
+ */
+static int flush_reservations(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_trans_handle *trans;
+	int ret;
+
+	ret = btrfs_start_delalloc_roots(fs_info, LONG_MAX, false);
+	if (ret)
+		return ret;
+	btrfs_wait_ordered_roots(fs_info, U64_MAX, 0, (u64)-1);
+	trans = btrfs_join_transaction(fs_info->tree_root);
+	if (IS_ERR(trans))
+		return PTR_ERR(trans);
+	btrfs_commit_transaction(trans);
+
+	return ret;
+}
+
 int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_root *quota_root;
@@ -1292,6 +1326,10 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 	clear_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags);
 	btrfs_qgroup_wait_for_completion(fs_info, false);
 
+	ret = flush_reservations(fs_info);
+	if (ret)
+		goto out;
+
 	/*
 	 * 1 For the root item
 	 *
@@ -1353,7 +1391,7 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 	if (ret && trans)
 		btrfs_end_transaction(trans);
 	else if (trans)
-		ret = btrfs_end_transaction(trans);
+		ret = btrfs_commit_transaction(trans);
 	mutex_unlock(&fs_info->cleaner_mutex);
 
 	return ret;
@@ -3957,8 +3995,11 @@ static int __btrfs_qgroup_release_data(struct btrfs_inode *inode,
 	int trace_op = QGROUP_RELEASE;
 	int ret;
 
-	if (btrfs_qgroup_mode(inode->root->fs_info) == BTRFS_QGROUP_MODE_DISABLED)
-		return 0;
+	if (btrfs_qgroup_mode(inode->root->fs_info) == BTRFS_QGROUP_MODE_DISABLED) {
+		extent_changeset_init(&changeset);
+		return clear_record_extent_bits(&inode->io_tree, start, start + len - 1,
+				       EXTENT_QGROUP_RESERVED, &changeset);
+	}
 
 	/* In release case, we shouldn't have @reserved */
 	WARN_ON(!free && reserved);
-- 
2.41.0

