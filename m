Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3EB7640A3
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jul 2023 22:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjGZUkz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jul 2023 16:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjGZUkx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jul 2023 16:40:53 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E09211C
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 13:40:52 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 023545C00DD;
        Wed, 26 Jul 2023 16:40:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 26 Jul 2023 16:40:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1690404051; x=
        1690490451; bh=M10GRgW8Oo/CA1itNOSle6w3dntzCKyqXOPnbe/r0Ao=; b=T
        qPTG5rZ1DPsZSeFr0soG9bqv37MMGabnJXmR+LwcCokbaxweU33ea3S6mgxA256E
        Jm5sRD5qPc3ow5A2Lot3jNxXN9FHneLoGK4QegXjuKSG5ddDt7OcPTsm0B12Lzx6
        P1eCrUAJ400iP6VANFeVnYY5Y0Fp7za3BZS0wKUjYUmawSInDiE0FNXCADOA+e0O
        zDhdDLlIV3S5ah0iO2rX4zQ2K1Iugw/151Rmy0EjPNH8GnjIXpo5qTZfD14e4/w8
        AkITbzLKGf7CbunJA6IyARl8yW84pimbmAOPPhUxrAupB+k/7RlQ1w8icEvvVg5H
        ynSNkGbPosW33DlsJaHHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1690404051; x=1690490451; bh=M
        10GRgW8Oo/CA1itNOSle6w3dntzCKyqXOPnbe/r0Ao=; b=BRUpLIh0dFkEdv+jI
        ByRn+txK208tUvQxwK6TlMM7P27BOTH+nY37AZMRNv6c3EtJ7kvsGPTAf6OECmqQ
        yS05VFfncrLCKWxdDl1341XKVtp+xI08JkFlYciPnliTRoORUD50DfD6bVCCjIH9
        JJHTsaAfxN1eBl58oRRIEm0odqP9xBUnkXn2OlBfI5LpIP7vqTFK66bHBZCkA1u1
        eUJAn3SPnPT1G5g8p4jkFj+yxOE67MrNj2t3C5jW/qPZTJca23+1sqaAYRpfIEuf
        Ww473WjWXZopKw0RItUOFXuQyiHsNiFSORfarzVlJ3mMRHGOHzgp4sZBcQxmJDjU
        gTJsQ==
X-ME-Sender: <xms:04TBZEzM_ZLxsGtjo1oeLcD9L7E5QfyLi1to_Q3nm0wTY3KaRaS5sQ>
    <xme:04TBZIRgoiF4INIms127EWInNkyhScTUl6VYLJ1LWDSywAndIN-QMTajuDSkl8hjb
    Y1H8eslP0S1Zw3uhVg>
X-ME-Received: <xmr:04TBZGUI6p30EK3GgwTpQqIvOc341d-gzFF6NwjD9I2rJ6y7UOuJUZTAsac4jZ51YTyebsT_zI2eSF_cc-3kl7IKSbU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedriedvgddugeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:04TBZCi9Lxi9mx5Cm34701io9uT6M3lIeONRGTlFwrgZNiRbXfz4sg>
    <xmx:04TBZGA-aX1GSwgVf21sMKLEgeG2Bdv-1qBl2NqOT9_LfLWE9rwqsA>
    <xmx:04TBZDJrQDWz5-qFmy4S07Aw1FX6UTGSxfjeO5hG5JR0n2YqYD5ZbA>
    <xmx:04TBZBrtR9ALorYUZPSWV6R8DSSlRfkyf4L2fegHnJGaUA-rb5Ypjw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Jul 2023 16:40:51 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 05/18] btrfs: flush reservations during quota disable
Date:   Wed, 26 Jul 2023 13:38:32 -0700
Message-ID: <32160328076c60fe8ff76f546b7c013c217c46c8.1690403768.git.boris@bur.io>
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

