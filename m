Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198347491CA
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jul 2023 01:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbjGEXXW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jul 2023 19:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbjGEXXV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Jul 2023 19:23:21 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534BC19A2
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jul 2023 16:23:14 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id BBAEA5C028D;
        Wed,  5 Jul 2023 19:23:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 05 Jul 2023 19:23:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1688599393; x=
        1688685793; bh=uNlVzaj79FB13LsG46M6m1r7LNzmwMdgDvsVer4X68c=; b=O
        IPEgzaTghm7wyFJe2idJhnsthP213ib27cNGyovTAWSzh4RkpEFyioLfv0o9AO+7
        6FXsmexUhGVzIOR2L0gA5Beh6T8HYR7B59FrVj5f6FFAyB9iQhxsOLkoGpVvG/Jt
        dSnO2Jn8kTBoXKK66ju51U3fJL6CGFrd5YNq4VOMg4yiDinYiUN9uWHc5WpA/DF7
        z/7iRCpGxm2FkpAUVMoDaxQqH/1sMhBlRoXi7cRPPByYpF7pmPwzDP5OhIZeiG46
        p9bh7G6pkKmt5pXrIvKpnj3W8lvT2W2cai1TBZwoAotydsvtHE2/+efKlpE1tVdp
        R2tl6h1amrPtny2SDh+SQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1688599393; x=1688685793; bh=u
        NlVzaj79FB13LsG46M6m1r7LNzmwMdgDvsVer4X68c=; b=HnNl44r45EbFAvw32
        ZAmP8GmoARZhO1j9dfWN5vPo3c8GKbPa0xK9y+Imy2m+zEJ2ZcXnZK38qKa9NOZx
        1pRmf8hajR7V01HPyE5BeboJK2CIdUxW280dVD+QRTGfJDnDY6SM/abBkn08Ay0v
        S+VaVk8r1MLmasaX8KVGMChHMvmdYUoDhaEkQIcdEbYi12eaClE5BIzul06jglin
        fsxDktsYr9Zhiwl52mmxCXTBTIKliLCxnf+ONP/T0O/3igYFFRxj9qvCBGfcB4p3
        eeGF5d1XJ+qcHfeL4NK8sHdzDNTXK9rTsPtrOJdvdnOsNup8G1gsEqsk3n89uNEF
        RoozA==
X-ME-Sender: <xms:YfulZNy4MFI-S06pnfRbfAbWKu6SQnf4FZ_PievlUdwGsYIHSui2og>
    <xme:YfulZNR5mj_hUCP168xcuTy9tnHePgZmsAboE2LLXxrpsgAn5L6QB0SBjL0Rv3dvx
    mlML-GNhXNeF0i5uOY>
X-ME-Received: <xmr:YfulZHWvCv2hIWYGoy1Jux3mit5z7KEjdIWreXuasWDfbdbsKlaaQVXTDtG5CeRF7U8PhR427tM2wSoDWiaC4zaFtmE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:YfulZPg-79FLv4NKd_lf1h-jccOqHk4qghfUdQzJd3SPxiskuQenbg>
    <xmx:YfulZPBjVK4i9cixbJlMcoSJK_1koFfOwGgj9323Ay6YLL4cUa9loA>
    <xmx:YfulZILJ3s2YXNmqLoqAHKFr0T8PgPoK9wgio3Wx6SlwjjbStNsBMg>
    <xmx:YfulZCpmkHAcMGP6Jh8pvUpcACZNRCCh9K-NJ0GnAt14VhDs8PSDiQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jul 2023 19:23:13 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 06/18] btrfs: flush reservations during quota disable
Date:   Wed,  5 Jul 2023 16:20:43 -0700
Message-ID: <0886b85983e4c7ab74574665fb25c9f2f81542bf.1688597211.git.boris@bur.io>
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
---
 fs/btrfs/qgroup.c | 47 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 80c1f500b6cc..75afd8212bc0 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1247,6 +1247,40 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info,
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
@@ -1291,6 +1325,10 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 	clear_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags);
 	btrfs_qgroup_wait_for_completion(fs_info, false);
 
+	ret = flush_reservations(fs_info);
+	if (ret)
+		goto out;
+
 	/*
 	 * 1 For the root item
 	 *
@@ -1351,7 +1389,7 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 	if (ret && trans)
 		btrfs_end_transaction(trans);
 	else if (trans)
-		ret = btrfs_end_transaction(trans);
+		ret = btrfs_commit_transaction(trans);
 	mutex_unlock(&fs_info->cleaner_mutex);
 
 	return ret;
@@ -3954,8 +3992,11 @@ static int __btrfs_qgroup_release_data(struct btrfs_inode *inode,
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

