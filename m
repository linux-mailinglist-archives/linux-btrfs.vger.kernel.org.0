Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1FE79DD05
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Sep 2023 02:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237004AbjIMANB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Sep 2023 20:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236262AbjIMANA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Sep 2023 20:13:00 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C691706
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Sep 2023 17:12:56 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id C178132005D8;
        Tue, 12 Sep 2023 20:12:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 12 Sep 2023 20:12:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1694563975; x=
        1694650375; bh=SkaZ5QzY4Lty86iONX1xzAe7sEvlPAOjV/TrGBs9kiY=; b=f
        5KxP/oZrah/RibborGcr9+2jYh6s9FZRx8bvmZTq4BcPRAn0nQk/DZxQQOjJicWE
        UplyBYtLzEdZlOgJZMqd+H7BCTJBV7srOCkiMGMkoIPAuLMX153LB4sWU26VBCHp
        rpbi+u3uAVUHCX2f1c6wJf6PHjcPCJhquKMelXsorJhP2xCVdxbt2rD2wsUBLUx2
        ueNXzxUVg4hnxtQ1OCMEJ6jcgnmLOIWHdCaVfQA5jIE7eAryLOI/Rk9Lsj7JSSIS
        0v5FCwnocdat4LWTQLYpb15gRCWTwsrIZCFx7HBE7/Cqw29nIfW02hup5InOFXA5
        LTtZyXqv6YWn/2K23qZjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1694563975; x=1694650375; bh=S
        kaZ5QzY4Lty86iONX1xzAe7sEvlPAOjV/TrGBs9kiY=; b=qVfIKAVHj7cb1SdIX
        xI4TLue5/Y402PvOesacOxLoNqQQrSIi4Zt3P9o4WCwiV6QAbMzx9yRC2aBXnOl9
        EcEyopf21uWUeopHDWREgb01Dzp6JE4W0BVzzOxYW91rdVa41b+mHdpFTHMhFL4c
        1SW/8qhuyeLJ+I9wrdvso31tqG/shY3/T5jVWC2M4+RnUs3wf/u1qA2FGaPyvJAR
        7Y69aDbdeKme22SI33BoKRoo67v38qjmYclAbuyWpUalbgpjlqfFl8l5P8MhuF8j
        9v9jdJmP3sWVHoLYVG6HjwCzFkUIvAVvPsTlJYTTEBB/fFCOhcWAoh0ZIrx7er0k
        N+3jg==
X-ME-Sender: <xms:h_4AZbeJh8Q2j4ng4toG_erbBwiA6s8fFb0tO-yKHkYohGJ2PR8F7g>
    <xme:h_4AZRMpGmKAis0ofhdTb76rxdwLufznJRc-RsTRRjEORGnfhbWoAKB994AxNImTI
    JS-RScdIjAQE1QWJRs>
X-ME-Received: <xmr:h_4AZUjn7pQgmBkZBiEMf-9grGS4BuFtIMM5LzuxQ4Pob1GKMiIvGK-9z9VUEu8qUvThbPu2BX9xxrX4a9Xk0XvmL-E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeijedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:h_4AZc-VxvjfFNeKCJcXHq5g_iq1zvwton4zSBLWelFB9tm_Nxyg3g>
    <xmx:h_4AZXuHPTCe4IDghOyYdjYrSDv8OL4TuIm4yAF322_gzMj5GMGnhA>
    <xmx:h_4AZbHNNeJH9AloQQPkzTDfnqe251zz3JnXlvOHMinfeZH_pEE05Q>
    <xmx:h_4AZV2lJuLMXeG5ng8ZHX9z4SAt50Z18j-v8g0fiDeLm6--djG3Zg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Sep 2023 20:12:54 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 05/18] btrfs: flush reservations during quota disable
Date:   Tue, 12 Sep 2023 17:13:16 -0700
Message-ID: <6de26f3c99ed89cb41500cc28e1d797a8819636b.1694563454.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694563454.git.boris@bur.io>
References: <cover.1694563454.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 9348529270bf..84030f81a1d8 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1296,6 +1296,40 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info,
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
@@ -1340,6 +1374,10 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 	clear_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags);
 	btrfs_qgroup_wait_for_completion(fs_info, false);
 
+	ret = flush_reservations(fs_info);
+	if (ret)
+		goto out;
+
 	/*
 	 * 1 For the root item
 	 *
@@ -1401,7 +1439,7 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 	if (ret && trans)
 		btrfs_end_transaction(trans);
 	else if (trans)
-		ret = btrfs_end_transaction(trans);
+		ret = btrfs_commit_transaction(trans);
 	mutex_unlock(&fs_info->cleaner_mutex);
 
 	return ret;
@@ -4021,8 +4059,11 @@ static int __btrfs_qgroup_release_data(struct btrfs_inode *inode,
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

