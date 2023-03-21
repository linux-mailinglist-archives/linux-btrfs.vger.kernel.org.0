Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB8F6C374C
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 17:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjCUQqG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 12:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjCUQp5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 12:45:57 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E9752F7F
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 09:45:39 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 3C0625C0131;
        Tue, 21 Mar 2023 12:45:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 21 Mar 2023 12:45:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1679417137; x=
        1679503537; bh=vVvd6uG5BBvqxe6aBAm6gei27wUE9QbS5Dg+OiOZwJE=; b=d
        ES8XAGNNI7/WEgRHJ9UaEDNfgiqvrd3oldvoA0wPuZPz39IQ7/aV+s7Id99eQnVM
        oMhaSnGAikRsMzsNkuc11WRr8fu2nLBzxqUZYt5q9XDMs7xVA11owRsDJ5uYZNuJ
        Ehl5ci+yy0S2g6uzTj8E5H0GX2gdW64Tk2m6SWosNsV2E4gEynwu9PBBscq8b6S2
        DodnooX5p4GWP3kW2WNUcvRE9P1N7aBLQ0da4Nit/CFtRQxmg/dFmcPijpV40aoI
        f07PNF3Q5br9IJFs5ydb2gkD6cY4YqmRuBXFPSRuTFHCVafwUjOCV16O5zv2cV8u
        wdTIsAf+pT2XW54ILTKvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1679417137; x=1679503537; bh=v
        Vvd6uG5BBvqxe6aBAm6gei27wUE9QbS5Dg+OiOZwJE=; b=UF5IEHC7OAdV2lrq0
        Yk0Obn6jtNKoLPbOA6X9v9zUq6GfByZ8uzry+1/iP2QJBsA6u88Oj1j/bLjJN+cQ
        SXG4E8KEpu4oNwk0x5y9OphIQu4t0JL2559G/zFYcI6P3MxTkiB7tJy11GEQ79lk
        VaEOIVH1n4lSU311CcA/iptWTEJfrUhH51HXmo+vG/9pHowMXfpKi0hxJ7xs/P6J
        w0sMfsGZP9qVcWRBlpHMSnpYP94BTrYcdvXC1le6VwKv6Dh2SNsV2olv50xLLaaW
        qE+0U2bkt5QfILWy/IlNFANDmcOFE6x0KUz+jwD8B/qHt+crWfbXjAlPB2OM0QTX
        9HRZA==
X-ME-Sender: <xms:Md8ZZN4lL3UZQmxj8EWz74H2zOr2Jli2_kmS3parkK0Ieg7Oja29ng>
    <xme:Md8ZZK6vtvUGD0tHzpjAW8ywKdcKE8nZiKeCyVV1DDN4rXnggB1vkA2TNnN1Ke3us
    6jwzQht6jcGz5Ip-yA>
X-ME-Received: <xmr:Md8ZZEd5Z5Cz_0kl86gamrM461tHQv7K9ILaLVGNWHjA7xY93SN5wM4G>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegtddgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:Md8ZZGLZWxeQ82sWyN3vI5mlMEPP6hFh4gZfLfvJv3beeB4CSMk9Dg>
    <xmx:Md8ZZBJfBRYnw8tQrKzNL0TkP_JShJt7MKGltPQGq7zuHxAz1mi3qQ>
    <xmx:Md8ZZPxCMvUkuF__uuhVH273bd8nndHtuax2eCo1FT-qyWdkNaeM3w>
    <xmx:Md8ZZDzYOapDEiBgryNZErCmGTc-x1QBOaPTSo5Yr2kRQhuZcpiIYA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Mar 2023 12:45:36 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 1/6] btrfs: add function to create and return an ordered extent
Date:   Tue, 21 Mar 2023 09:45:28 -0700
Message-Id: <3fac8b7cb05dabbb11205aa9076c889ca2894eb3.1679416511.git.boris@bur.io>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1679416511.git.boris@bur.io>
References: <cover.1679416511.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

The type of flags in btrfs_alloc_ordered_extent and
btrfs_add_ordered_extent is changed from unsigned int to unsigned long
so it's unified with the other ordered extent functions.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Boris Burkov <boris@bur.io>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ordered-data.c | 46 +++++++++++++++++++++++++++++++++--------
 fs/btrfs/ordered-data.h |  7 ++++++-
 2 files changed, 43 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 6c24b69e2d0a..1848d0d1a9c4 100644
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
+ * Return: the new ordered extent or ERR_PTR(-ENOMEM).
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
@@ -256,6 +258,32 @@ int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
 	btrfs_mod_outstanding_extents(inode, 1);
 	spin_unlock(&inode->lock);
 
+	/* One ref for the returned entry to match semantics of lookup. */
+	refcount_inc(&entry->refs);
+
+	return entry;
+}
+
+/*
+ * Add a new btrfs_ordered_extent for the range, but drop the reference instead
+ * of returning it to the caller.
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
+
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

