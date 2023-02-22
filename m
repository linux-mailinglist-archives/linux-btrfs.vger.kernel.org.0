Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F077869EC14
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Feb 2023 01:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjBVAuH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Feb 2023 19:50:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjBVAuG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Feb 2023 19:50:06 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67EE30B3E
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 16:50:04 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id B59835C00CD;
        Tue, 21 Feb 2023 19:50:03 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 21 Feb 2023 19:50:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1677027003; x=1677113403; bh=C/
        VsmcybzzxQYnnH4aeNNdrkKhHurY2mURsqInuFFSw=; b=iLuO7ochYLxyF8hWwv
        juPhC1EMnVO40YSYAPQiMzQKx2ww+e6hKAZOcmGnyOu00J1jtD9F9DuUcyXYWLb3
        ZHPMyKmlOEGr4BADbYtKtM15TimHWPjRMs43fZt0b7BO6QGJ1ivKlQa6DS/FPkOn
        7XkPD0QYYQObg1g1lBO4Wg6ASEVGiC9e1GJLq6gmt/Yij63/qFw5+BlwosM8pm5a
        8TKYMOAxly7fg8+LUvVIkiwWGLIz70UNDxvDiKgNXSZKEFA6gJdJCc2zEdW9xSJw
        ZN3ZtpfOR87l5Wy0lhygWBdliFy9arqebxMwN8j9S/h+NhCN/lAgdD6VnrLocstz
        8nbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1677027003; x=1677113403; bh=C/VsmcybzzxQY
        nnH4aeNNdrkKhHurY2mURsqInuFFSw=; b=NI2PTsLaapMQ2g8AIciPNge1Y8JQK
        YERSiYXEqxX0SHqOZ+5tIQ7I97ZqemQh4d/U3LYALMl1jqVW2FJWX2NZRSQEaUye
        KFBaY8xhxWk/N2OQzdldUHz+csAeDrMjC1hJBr++/UUTHWv3DLtqSF9GYE4VwgbH
        7xIsH33iRnRIleZrSFarA6kVbinQ/WpJ+MOeySSUqj6RulfwhkgZtjbfoT0uo4yD
        iQ1VWG3ce+sNGLKaCIBI+S/qiDNtlORdNIBTyMA6axwHfnVsQlnRyoUvV3DoUHaJ
        vjXjxuhCUwsgHRcU7aXE5+PxxwYMl5SIw72bphQGNpSD+MlKUK/Vka15w==
X-ME-Sender: <xms:u2b1Y9XDUHK-Fk6sls0xHsvram_GfGegtvFnAz5vaC1k83PD2O8Vvg>
    <xme:u2b1Y9nbpsKc25uwEbmUB3STxOqLdzNlDkJRoFj0-5lqa1Zb0H0yfjDJ3-ye9iYzP
    x-Gw7T9_OUL9pWp_Jk>
X-ME-Received: <xmr:u2b1Y5bp_JvcmMkw2WwX3mW7yqrfJI60jUZVw7cIAA5gksEHEfKyJPjt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudejkedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:u2b1YwWlt1PyBATkzu61MKcKh332nN54PQP5s6rTfw1sGetmkzldRQ>
    <xmx:u2b1Y3mFU1YPwEDgDaeJK91EFWDsTT_hAh4ACFHNcCmpm5SjzEuG1w>
    <xmx:u2b1Y9cm7UUSWBxS90pBq12ud_aQ3OzhEufqfGDrVqG2cKVMzvgMGQ>
    <xmx:u2b1Y2tjqUXIpbCIOyAjhBfCrPelIHQag10nUrPq53UVY1nMggX0AQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Feb 2023 19:50:03 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 1/2] btrfs: btrfs_alloc_ordered_extent
Date:   Tue, 21 Feb 2023 16:49:59 -0800
Message-Id: <70260eb8a1df6ad3b32ff4be62c9799fcc12ebc3.1677026757.git.boris@bur.io>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1677026757.git.boris@bur.io>
References: <cover.1677026757.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently, btrfs_add_ordered_extent allocates a new ordered extent, adds
it to the rb_tree, but doesn't return a referenced pointer to the
caller. There are cases where it is useful for the creator of a new
ordered_extent to hang on to such a pointer, so add a new function
btrfs_alloc_ordered_extent which is the same as
btrfs_add_ordered_extent, except it takes an additional reference count
and returns a pointer to the ordered_extent. Implement
btrfs_add_ordered_extent as btrfs_alloc_ordered_extent followed by
dropping the new reference and handling the IS_ERR case.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/ordered-data.c | 45 ++++++++++++++++++++++++++++++++---------
 fs/btrfs/ordered-data.h |  7 ++++++-
 2 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 6c24b69e2d0a..35c082ef163e 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -160,14 +160,16 @@ static inline struct rb_node *tree_search(struct btrfs_ordered_inode_tree *tree,
  * @compress_type:   Compression algorithm used for data.
  *
  * Most of these parameters correspond to &struct btrfs_file_extent_item. The
- * tree is given a single reference on the ordered extent that was inserted.
+ * tree is given a single reference on the ordered extent that was inserted, and
+ * the returned pointer is given a second reference.
  *
- * Return: 0 or -ENOMEM.
+ * Return: the new ordered_extent or ERR_PTR(-ENOMEM).
  */
-int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
-			     u64 num_bytes, u64 ram_bytes, u64 disk_bytenr,
-			     u64 disk_num_bytes, u64 offset, unsigned flags,
-			     int compress_type)
+struct btrfs_ordered_extent *btrfs_alloc_ordered_extent(
+			struct btrfs_inode *inode, u64 file_offset,
+			u64 num_bytes, u64 ram_bytes, u64 disk_bytenr,
+			u64 disk_num_bytes, u64 offset, unsigned long flags,
+			int compress_type)
 {
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
@@ -181,7 +183,7 @@ int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
 		/* For nocow write, we can release the qgroup rsv right now */
 		ret = btrfs_qgroup_free_data(inode, NULL, file_offset, num_bytes);
 		if (ret < 0)
-			return ret;
+			return ERR_PTR(ret);
 		ret = 0;
 	} else {
 		/*
@@ -190,11 +192,11 @@ int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
 		 */
 		ret = btrfs_qgroup_release_data(inode, file_offset, num_bytes);
 		if (ret < 0)
-			return ret;
+			return ERR_PTR(ret);
 	}
 	entry = kmem_cache_zalloc(btrfs_ordered_extent_cache, GFP_NOFS);
 	if (!entry)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	entry->file_offset = file_offset;
 	entry->num_bytes = num_bytes;
@@ -256,6 +258,31 @@ int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
 	btrfs_mod_outstanding_extents(inode, 1);
 	spin_unlock(&inode->lock);
 
+	/* one ref for the returned entry to match semantics of lookup */
+	refcount_inc(&entry->refs);
+	return entry;
+}
+
+
+/*
+ * Add a new btrfs_ordered_extent for the range, but drop the reference
+ * instead of returning it to the caller.
+ */
+int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
+			     u64 num_bytes, u64 ram_bytes, u64 disk_bytenr,
+			     u64 disk_num_bytes, u64 offset, unsigned long flags,
+			     int compress_type)
+{
+	struct btrfs_ordered_extent *ordered;
+
+	ordered = btrfs_alloc_ordered_extent(inode, file_offset, num_bytes,
+					     ram_bytes, disk_bytenr,
+					     disk_num_bytes, offset, flags,
+					     compress_type);
+
+	if (IS_ERR(ordered))
+		return PTR_ERR(ordered);
+	btrfs_put_ordered_extent(ordered);
 	return 0;
 }
 
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index eb40cb39f842..18007f9c00ad 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -178,9 +178,14 @@ void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
 bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
 				    struct btrfs_ordered_extent **cached,
 				    u64 file_offset, u64 io_size);
+struct btrfs_ordered_extent *btrfs_alloc_ordered_extent(
+			struct btrfs_inode *inode, u64 file_offset,
+			u64 num_bytes, u64 ram_bytes, u64 disk_bytenr,
+			u64 disk_num_bytes, u64 offset, unsigned long flags,
+			int compress_type);
 int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
 			     u64 num_bytes, u64 ram_bytes, u64 disk_bytenr,
-			     u64 disk_num_bytes, u64 offset, unsigned flags,
+			     u64 disk_num_bytes, u64 offset, unsigned long flags,
 			     int compress_type);
 void btrfs_add_ordered_sum(struct btrfs_ordered_extent *entry,
 			   struct btrfs_ordered_sum *sum);
-- 
2.38.1

