Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0675B7640B3
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jul 2023 22:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjGZUlR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jul 2023 16:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbjGZUlP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jul 2023 16:41:15 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB75212F
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 13:41:15 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 775AC5C0041;
        Wed, 26 Jul 2023 16:41:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 26 Jul 2023 16:41:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1690404074; x=
        1690490474; bh=viAizQ0r/4qqgU5hDlsoySIq+vR07iEZB9wwvK991Hc=; b=r
        D9ARiqHSqF0YN0RP8RzKfDzIrVzz19l5jOL6Afc/zM9dEuEHOx+aAGIP1lhuLWMG
        gmvjqWd2pcb+j3XiJ0o3IkOkacO0qNz6T92xcxqrkxr0mHisKjUUfmaBBRlKZaib
        LGjtjCcAoRwDxAwaPg9LLDHxb7oVhUGIjJ91SU0GgpredSZEcP0YM1/pvABVGd25
        82ICCWUuvXAXG4uBUxdZQ9u5JztlMswl/1yYmduGW3IcyoOBz9+SD6pTqq6O4LBp
        4pW062KGchuq61ZW5uuakE2Y6t8NJR5wvR3DJ1zdKNgcy7BMyHZp6twQ2CHwFpRS
        f+tnfn2BIBEXUJU8Dastw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1690404074; x=1690490474; bh=v
        iAizQ0r/4qqgU5hDlsoySIq+vR07iEZB9wwvK991Hc=; b=qyFyQ2XR7rVK/+vQx
        Gy+QRRdRU7SIOBZ0bDDgotyVDwXhA9f7Z8STPzic6SygF85LOLmnMhtwEi9jUGkL
        VWzmEMp9D/8QMe7FCNsQGhtpTkT3bBpKY5fA0uoT/mJ7WfTUhDTfFZRiaGgrGQS3
        cyRQRZr5IHIwMqUE2ajOmbvCbeFr4Thr5oBuNp1sHFQzvvzmdLJToE/ikhAlx2a3
        r/+eL+lL/+vp7BzuYkg2iN50C4RJApXvs9h/mnLcxVzE6PpORolvpHAOzrEe8pFS
        5ErPyRdoJwaJ/VBJ24vl9Z8UTQpe7+SGms+C6oerpl4vXj286e19asCv6aG+MMLH
        2cV6Q==
X-ME-Sender: <xms:6oTBZBIxdlmHm1Ei2coqbD3B2doNS6JKlzUzVx7PGzmx5hGKA3Ybmw>
    <xme:6oTBZNIs92fM1k30aYNoNr9JlyeKUI6-ulb2ncPmbP4U9J3fFCIxkC0nyFCsHWI6-
    0SBChWPIFUhgz8TusE>
X-ME-Received: <xmr:6oTBZJsZe7s8e--JHFMLFpG6yhaoQURAf0T5b3tAp2lt3TrIDevNeK_XTsW6-3sxwUrNGf1-SDhNG_uDrEauQgpcepY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedriedvgdduhedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:6oTBZCaVMragkBNwblor_T1zRXWRdgkRY1JDHAr7BH-TfhNmiqy7LA>
    <xmx:6oTBZIZp1bTV8reuTl3kP5PFBHP7gIwIAIysEYmEAIcsKesms2hl_Q>
    <xmx:6oTBZGDuGrgOmtPhDEQd_uvNJSaCKsK7WrbND_tgyxmjsQL8q2ysqw>
    <xmx:6oTBZBCvecA-bK6OJPE-J976wL6yfcsiwFPakX0sW15Jj4cB_34thw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Jul 2023 16:41:13 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 18/18] btrfs: only set QUOTA_ENABLED when done reading qgroups
Date:   Wed, 26 Jul 2023 13:38:45 -0700
Message-ID: <d2274b6bf879ac16b4f60b6109cc0200c680908b.1690403768.git.boris@bur.io>
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

In open_ctree, we set BTRFS_FS_QUOTA_ENABLED as soon as we see a
quota_root, as opposed to after we are done setting up the qgroup
structures. In the quota_enable path, we wait until after the structures
are set up. Likewise, in disable, we clear the bit before tearing down
the structures. I feel that this organization is less surprising for the
open_ctree path.

I don't believe this fixes any actual bug, but avoids potential
confusion when using btrfs_qgroup_mode in an intermediate state where we
are enabled but haven't yet setup the qgroup status flags. It also
avoids any risk of calling a qgroup function and attempting to use the
qgroup rbtrees before they exist/are setup.

This all occurs before we do rw setup, so I believe it should be mostly
a no-op.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/disk-io.c |  1 -
 fs/btrfs/qgroup.c  | 15 +++++++--------
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index e2b0e11800fc..874685c84df2 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2254,7 +2254,6 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
 	root = btrfs_read_tree_root(tree_root, &location);
 	if (!IS_ERR(root)) {
 		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
-		set_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags);
 		fs_info->quota_root = root;
 	}
 
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index a8a603242431..1f915d70b99d 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -402,7 +402,7 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
 	u64 rescan_progress = 0;
 	bool simple;
 
-	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_DISABLED)
+	if (!fs_info->quota_root)
 		return 0;
 
 	fs_info->qgroup_ulist = ulist_alloc(GFP_KERNEL);
@@ -565,13 +565,12 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
 out:
 	btrfs_free_path(path);
 	fs_info->qgroup_flags |= flags;
-	if (!(fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_ON))
-		clear_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags);
-	else if (fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_RESCAN &&
-		 ret >= 0)
-		ret = qgroup_rescan_init(fs_info, rescan_progress, 0);
-
-	if (ret < 0) {
+	if (ret >= 0) {
+		if (fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_ON)
+			set_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags);
+		if (fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_RESCAN)
+			ret = qgroup_rescan_init(fs_info, rescan_progress, 0);
+	} else {
 		ulist_free(fs_info->qgroup_ulist);
 		fs_info->qgroup_ulist = NULL;
 		fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_RESCAN;
-- 
2.41.0

