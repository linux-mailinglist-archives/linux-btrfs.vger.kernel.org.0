Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E264765F11
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jul 2023 00:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbjG0WPR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jul 2023 18:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjG0WPQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jul 2023 18:15:16 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55ECE13E
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 15:15:15 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 9F0CC3200927;
        Thu, 27 Jul 2023 18:15:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 27 Jul 2023 18:15:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1690496114; x=
        1690582514; bh=M10GRgW8Oo/CA1itNOSle6w3dntzCKyqXOPnbe/r0Ao=; b=W
        LdGn+eVp3pSLDEfglJ9A07M5e/bUkbVadPvtOwbgitzMcVt9KN1ttzmCHyDsVmzC
        YxpYlokxuRqbyRzTz2H47+v50owH9xds1rP5Thod9bWkw1FFM4A4kgf2+yL/a50Z
        wlnYK/ZT7yZRnyAphhV2HG3YhjYXXKGwyca8dxK/stX2EZyh6XJ6jBAYoIAhuEeM
        5hbAoBYrPx3uGmexqtwf0pwA+EYz+p+7gxrs2c4oFnfPMw2W6tcBopSDaAQW+rZQ
        rvvuzCmQEBt8oRFq2/XHeSpEoMjOKtfm1MAHTltnSoF5k6N9s69oG4tcE2lPkttp
        o2MIxRKK8prLTIOwycvdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1690496114; x=1690582514; bh=M
        10GRgW8Oo/CA1itNOSle6w3dntzCKyqXOPnbe/r0Ao=; b=HDQS2LE/6Xe6edAbx
        NC0MJwDN5KDSf/HZQUy2tXlEH/ohH2pZuHmId1S5GcrII8zfA1Y5gJH7MiaF9USL
        IxNp3K4lL08IiltGJb+4Ppx/OWI5E63FbSNSK3TwcQFJvb90g+8DtoJZ3cO4+jKh
        sZcparebsTjsKTrxgsMuYp20xvp+Ck0K/GWqYzziPkEVtyq7M9U98MhxrPUCqHBX
        MdgIAl3MTnBR/9wfaeNed0as7mgWHHyklQc7ghoJHEiE42UxS3I9AW3xqqXYbAzg
        TcngW+GcEn1oP3GUv9OB6Mn7uZAdBua0z5VDeeu2rHUK6dFp/WNiaj/f7Y436T35
        lWSgQ==
X-ME-Sender: <xms:cezCZNiuIuBNP9NOQtge2R5duZQ9zZceJcsrBL0xG9zyQAUnE_Kkbg>
    <xme:cezCZCCe8F7qII3WFBdWyvfN7X5OcPXkLODELoW8R3RGipLEmQ5R7IVnjAq3oMoEs
    YgFpzKoT4PlkDv4DNU>
X-ME-Received: <xmr:cezCZNFrZBeqIl9sugTqRrXzl8n0zKXmiMPods4RRt-UBPbwCJU7nUydGUIbN4iB7i0u5yFO0k_JJ0mYAfshsZBYtEc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrieehgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:cuzCZCQaLxanceB1NhMtAC9GuZqFU_YK6bGpdoXLfYVzaSCDmZeBxw>
    <xmx:cuzCZKw9_lDiAxgen_zm4nx5sSbckmvLLIyMhV-WQJRWOI5wnahmOQ>
    <xmx:cuzCZI5mH2secOe_uifVrv3GJ8ndv7b2hvdeNFxLC1ZUOfaQCLVihA>
    <xmx:cuzCZAbSau8tNoL5U3UHEOA4E9yVKhWMWt_YoNUTfZ_47IeP0K9hsg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Jul 2023 18:15:13 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 05/18] btrfs: flush reservations during quota disable
Date:   Thu, 27 Jul 2023 15:12:52 -0700
Message-ID: <32160328076c60fe8ff76f546b7c013c217c46c8.1690495785.git.boris@bur.io>
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

