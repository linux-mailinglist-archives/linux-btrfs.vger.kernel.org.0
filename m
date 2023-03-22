Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F28C6C5499
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Mar 2023 20:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjCVTMT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Mar 2023 15:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjCVTMS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Mar 2023 15:12:18 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FC15C120
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Mar 2023 12:12:00 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id EA9E3320029B;
        Wed, 22 Mar 2023 15:11:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 22 Mar 2023 15:11:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1679512317; x=
        1679598717; bh=vVvd6uG5BBvqxe6aBAm6gei27wUE9QbS5Dg+OiOZwJE=; b=h
        F09SGgndTnbyZ3sW8A/r+JMIRPutQnhRI4t78oDObCiZ3BjWKobamcT58jQGwpjC
        FPdxchF1g3uq3jEMetEx9aibH3BxvMRbWsMpJuHFrArmP5gAPnE36XFz7Ao2HdgK
        qUoqQyCLe9wFUdour5O+/O0SoZ7BmsUgSTGfPz9AJT80BkUJMPy35f7JWRneB9h+
        VzrZCUV4ltXHqqPsBTSdObMQT1x6pVoNcVQlM5138IID+wtCDu5CZ9C7CuVxFfge
        KVcFur8YubkDWOWdwRchkd8OTRWoByHi1OqTAUQn+YHYrvDd2hdHcZLdk1UXP1jJ
        erZ55/5VCaI8PSh9BGXBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1679512317; x=1679598717; bh=v
        Vvd6uG5BBvqxe6aBAm6gei27wUE9QbS5Dg+OiOZwJE=; b=uRz0B0IZCKWlUND9T
        uE1qCH4ureA0OHJXLlBUPEDaoS3QLkSxluPlv2a30tqr7pYA9n0mYFk9eCvR+22D
        Ob9BdSiHk/ZvAHzAI5C8HHTFaQ/nrcFzum3rTiVSrhMTMzZ2Se0SFqLVtSa1bKuY
        R7zNS6vGKfliI/xgOEFEJHnUTjeUcMZ2vu0+hFVRcvHzp2NOBjJpyyBZn6QF+jrQ
        AmTVgB434LSg/CUu2Mk/Vt32DfSV2bQstrzuzhzWkQuhQYZ178/ZqEb4KlIlrwTP
        ukeeCO93zIflkwpM6L89Z2L8EgBrW65ibJf0QEWZWGC4MlzmObOM3K1AbKo6RqaK
        md58A==
X-ME-Sender: <xms:_VIbZLDzbPxKyDHip73QHTjyYW5zAB0_vguOMbQaEaN9OsXDJP-8pg>
    <xme:_VIbZBj-ietY_zMe2jpyx9AND35RpCaHz58K3mcHZWl7pk7-uGw6EhnjxygOFCfgp
    rEyHLThPmDlOBvcoyc>
X-ME-Received: <xmr:_VIbZGkYi0kAxOlLcKcuGRkb0OwUcONxIQgzFOHxg7IyGv7BjshCLQSa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegvddguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejff
    evvdehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:_VIbZNwm1xt3e6Ou3toWTmNv9Nn3WH3eQ2IU4crIRiZlkh7VaKSWFQ>
    <xmx:_VIbZAT4mP5O_WONfw_guVR5YRtEPgYkeC3ArC1cQ_f7KlDNiCc_pg>
    <xmx:_VIbZAbOi3IMkq7emryGf7kyJcKZ7P2_U995OVMIwOJfr1Y8al9eAg>
    <xmx:_VIbZJ55kcWHIeqLasM1nCcXgw9zY5efbnnaShPqeuGDBKtvWujgHQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Mar 2023 15:11:56 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 1/5] btrfs: add function to create and return an ordered extent
Date:   Wed, 22 Mar 2023 12:11:48 -0700
Message-Id: <3fac8b7cb05dabbb11205aa9076c889ca2894eb3.1679512207.git.boris@bur.io>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1679512207.git.boris@bur.io>
References: <cover.1679512207.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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

