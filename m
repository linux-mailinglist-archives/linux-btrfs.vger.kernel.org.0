Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9303279DD12
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Sep 2023 02:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237935AbjIMANf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Sep 2023 20:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237899AbjIMANe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Sep 2023 20:13:34 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F1910F2
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Sep 2023 17:13:30 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 363DB32005D8;
        Tue, 12 Sep 2023 20:13:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 12 Sep 2023 20:13:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1694564009; x=
        1694650409; bh=s0tUfaTnj7rM5upihSTGFOoH9CLyCCKCOVsCiEHOmvc=; b=G
        PLbGfj8bEh+etROBb9W3IQqmcFWWd0V+4qwxymInH/6jxAwTVFuA+AzVt4ziors6
        6R2UWvv9OYhj9+AJwinJRBkxoWO/TC2GCDKWN9Sbp7NXvF0dPjGGH9aPim4V2HYS
        j8yAi4anSeKABODkcv1Ajunpa84TEdUumvOwbVoW9FImB2y6d5HnFE5AeM6g/YvU
        2aP+mFnKq6rNNEYeJJ6YWsZvlO040fiAj43wRe0SiUCZL6WA33dBRsdtRMqLk9Cm
        XxDoTFH7P1G9Bx3BR2QIlJl/Utu3vvOSojNtKoUJ9cGRss+oB72g+m5FP8OKbrXJ
        pNH5mLCuk+VWzJMiyAy9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1694564009; x=1694650409; bh=s
        0tUfaTnj7rM5upihSTGFOoH9CLyCCKCOVsCiEHOmvc=; b=FbEcOwjucwkOJSOVi
        KxUPrCzjHVB3I+ABP9sjIlWULw4uTGd5KGo8UQDMbauPEeHQDZN/+Ao42Wwvjq9j
        CDuM6IM72xSbzhXfyuzudjnXfbRutJfhcaAulISLJb2ouzPUB4LdvkvGTsM9uO2m
        Yd9cldF3SHDxRCURmBEMyzOLdqGF/+I2RyJPGzUge0ey7PF2/D3yO5wOIZxK218d
        QKNUqEDgaM8LZIIswM21QTZ4yhhat3XSLtJ/MHYzteiSNlQEkwG6qm3Ajr5FNdQn
        C7vUEbC3icCKg0CpZV7I8jENIWezuX975KAeiEIGK07uyhlotB94QtGU/ZSQz2tR
        AW0pw==
X-ME-Sender: <xms:qf4AZVgZ49DdKd5i4MFXySREWKaYNXbXaigo_KhddintrVktKoh4kg>
    <xme:qf4AZaD2jO6cYiZQyWYR8uCra5aFvJtxliF4h7UXSZkwf41XGpCqeEGV18CyleEqS
    3oRndDqi4_xpAM2TBI>
X-ME-Received: <xmr:qf4AZVEaeUr825eg9hzrE_oZ44mHV9YWQcnWhAEjGc_-tqQGAdbU7Jdkbs3lSVmCrB8Q38U0CjzEqXqO8vjBgU2utoI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeijedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:qf4AZaRmxEiKHRWVXRb0B2TctxncvpF697Wl4WcrMMTvIBip5CZOlA>
    <xmx:qf4AZSzQSoPZPxaMh6nHE8EmAgSFFlHQjk7I66tWEEq8bXUDpXpMqg>
    <xmx:qf4AZQ7HWK_8LARUV4FA_mD3t_niRLH98HO0GoEedJBnx9Lh5U_8uA>
    <xmx:qf4AZYbQ9hUbe41AM8LweasO7lqCXzClyV2QSQyoF8-6wvjOg6QCLA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Sep 2023 20:13:29 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 18/18] btrfs: only set QUOTA_ENABLED when done reading qgroups
Date:   Tue, 12 Sep 2023 17:13:29 -0700
Message-ID: <425f0ca332862491b4ae9499fe42c38be88feba3.1694563454.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694563454.git.boris@bur.io>
References: <cover.1694563454.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index e9413325c1d1..ccc40c2400ca 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2263,7 +2263,6 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
 	root = btrfs_read_tree_root(tree_root, &location);
 	if (!IS_ERR(root)) {
 		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
-		set_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags);
 		fs_info->quota_root = root;
 	}
 
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 759395e83f9e..5f989cf2b01d 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -404,7 +404,7 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
 	u64 flags = 0;
 	u64 rescan_progress = 0;
 
-	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_DISABLED)
+	if (!fs_info->quota_root)
 		return 0;
 
 	fs_info->qgroup_ulist = ulist_alloc(GFP_KERNEL);
@@ -576,13 +576,12 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
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

