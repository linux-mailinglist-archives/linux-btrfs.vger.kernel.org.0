Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA216F2634
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Apr 2023 22:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjD2UHi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Apr 2023 16:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjD2UHe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Apr 2023 16:07:34 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB83D129
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:07:33 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-b9a7c1b86e8so1608697276.2
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1682798853; x=1685390853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4EECNVhGKyEANkFkS1xoovYgmElt6xF+Gn3So5gaq1o=;
        b=Zp+E5k4ZsPtlzjBQKPC0W3qPLDKekYn28IZowrQW1+Xg4AqG7MAeNXnecVg7mjR4M8
         3WJNMFDW2gyOPfZDfcB4Jhy8dtkXp1SSGHqnbNPnR8gKjOclvL85xi8UGCfjLlwZpSYy
         4JMFeFlKp1VdhtJ87T7tscYRkvemlG83biMqA52podbRecFMtI+ET+ZmblbeD8lohtXr
         WVqAAdK9MH3GhArnQ/ALPVOLNWb9g1QFRQS+pVBXnIge6dlXtnpOoYVj8ZoDW4OEIQcD
         p+UuuuFHSJR3Yx2uD2sBDW21e7t+VHIVQAbdowhqYaARyNFak8uKSbmQYdc+EaY0QAac
         yPcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682798853; x=1685390853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4EECNVhGKyEANkFkS1xoovYgmElt6xF+Gn3So5gaq1o=;
        b=HjCfcuz6/jk44d1GspP2n82oQ+7KemUKP/JE1aIYCQMhuveYJVBL/6cBp0xKWg71JU
         fzmvQ+7H0iQp2jqzL/mmSbItuSQtbHoYVglmDsmFpD+ZrOtPz1i0GrTAB+V9iBVbaUSC
         m1VQ11LzL1nND5wo16sVciDMWeBHHJHNFJ8hByKCoF7d4BsvGtaIpSv8hgcElb7aNslS
         8c3IE/b71BX19Anp95v8eCdnizvp7yGtqiPOpCG3djkg18KZhiPz3oWl2m6zFj/3rQV0
         eepgSlLNIsQDoJWQ+IK8HMW1klomH0sjy2h2KGJSoqiTZc+0aW/g0XMfuD4MFj0X5V4H
         BvwA==
X-Gm-Message-State: AC+VfDxr/Sm5jgFn2gAyxaED6wYs66VmIn/BhjABxfCIAHRWbd7pIrhr
        Ec8uFBcePHbMRxYjg9aUauF2N5NSpaub86fEBx/YrA==
X-Google-Smtp-Source: ACHHUZ6EZ52MpFA9aFoWtozypEzZiS3mJRw5+toeL9JQAtPDO80dlIbqDes/I66R3TLM/+G2go1GKw==
X-Received: by 2002:a25:c590:0:b0:b99:1e51:19e0 with SMTP id v138-20020a25c590000000b00b991e5119e0mr8540307ybe.11.1682798852556;
        Sat, 29 Apr 2023 13:07:32 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id h204-20020a256cd5000000b00b7b0aba5cccsm5853509ybc.22.2023.04.29.13.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 13:07:32 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 03/12] btrfs: simplify btrfs_check_leaf_* helpers into a single helper
Date:   Sat, 29 Apr 2023 16:07:12 -0400
Message-Id: <3f41d6e2a62eacc4a31966dfaa8a3e0b8f64766b.1682798736.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1682798736.git.josef@toxicpanda.com>
References: <cover.1682798736.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have two helpers for checking leaves, because we have an extra check
for debugging in btrfs_mark_buffer_dirty(), and at that stage we may
have item data that isn't consistent yet.  However we can handle this
case internally in the helper, if BTRFS_HEADER_FLAG_WRITTEN is set we
know the buffer should be internally consistent, otherwise we need to
skip checking the item data.

Simplify this helper down a single helper and handle the item data
checking logic internally to the helper.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c      | 12 +++++-------
 fs/btrfs/tree-checker.c | 19 +++++++------------
 fs/btrfs/tree-checker.h | 13 +------------
 3 files changed, 13 insertions(+), 31 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 59ea049fe7ee..aea1ee834a80 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -325,7 +325,7 @@ static int csum_one_extent_buffer(struct extent_buffer *eb)
 	if (btrfs_header_level(eb))
 		ret = btrfs_check_node(eb);
 	else
-		ret = btrfs_check_leaf_full(eb);
+		ret = btrfs_check_leaf(eb);
 
 	if (ret < 0)
 		goto error;
@@ -582,7 +582,7 @@ static int validate_extent_buffer(struct extent_buffer *eb,
 	 * that we don't try and read the other copies of this block, just
 	 * return -EIO.
 	 */
-	if (found_level == 0 && btrfs_check_leaf_full(eb)) {
+	if (found_level == 0 && btrfs_check_leaf(eb)) {
 		set_bit(EXTENT_BUFFER_CORRUPT, &eb->bflags);
 		ret = -EIO;
 	}
@@ -4687,12 +4687,10 @@ void btrfs_mark_buffer_dirty(struct extent_buffer *buf)
 					 fs_info->dirty_metadata_batch);
 #ifdef CONFIG_BTRFS_FS_CHECK_INTEGRITY
 	/*
-	 * Since btrfs_mark_buffer_dirty() can be called with item pointer set
-	 * but item data not updated.
-	 * So here we should only check item pointers, not item data.
+	 * btrfs_check_leaf() won't check item data if we don't have WRITTEN
+	 * set, so this will only validate the basic structure of the items.
 	 */
-	if (btrfs_header_level(buf) == 0 &&
-	    btrfs_check_leaf_relaxed(buf)) {
+	if (btrfs_header_level(buf) == 0 && btrfs_check_leaf(buf)) {
 		btrfs_print_leaf(buf);
 		ASSERT(0);
 	}
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index e2b54793bf0c..f153ddc60ba1 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1674,7 +1674,7 @@ static int check_leaf_item(struct extent_buffer *leaf,
 	return ret;
 }
 
-static int check_leaf(struct extent_buffer *leaf, bool check_item_data)
+int btrfs_check_leaf(struct extent_buffer *leaf)
 {
 	struct btrfs_fs_info *fs_info = leaf->fs_info;
 	/* No valid key type is 0, so all key should be larger than this key */
@@ -1682,6 +1682,7 @@ static int check_leaf(struct extent_buffer *leaf, bool check_item_data)
 	struct btrfs_key key;
 	u32 nritems = btrfs_header_nritems(leaf);
 	int slot;
+	bool check_item_data = btrfs_header_flag(leaf, BTRFS_HEADER_FLAG_WRITTEN);
 
 	if (unlikely(btrfs_header_level(leaf) != 0)) {
 		generic_err(leaf, 0,
@@ -1807,6 +1808,10 @@ static int check_leaf(struct extent_buffer *leaf, bool check_item_data)
 			return -EUCLEAN;
 		}
 
+		/*
+		 * We only want to do this if WRITTEN is set, otherwise the leaf
+		 * may be in some intermediate state and won't appear valid.
+		 */
 		if (check_item_data) {
 			/*
 			 * Check if the item size and content meet other
@@ -1824,17 +1829,7 @@ static int check_leaf(struct extent_buffer *leaf, bool check_item_data)
 
 	return 0;
 }
-
-int btrfs_check_leaf_full(struct extent_buffer *leaf)
-{
-	return check_leaf(leaf, true);
-}
-ALLOW_ERROR_INJECTION(btrfs_check_leaf_full, ERRNO);
-
-int btrfs_check_leaf_relaxed(struct extent_buffer *leaf)
-{
-	return check_leaf(leaf, false);
-}
+ALLOW_ERROR_INJECTION(btrfs_check_leaf, ERRNO);
 
 int btrfs_check_node(struct extent_buffer *node)
 {
diff --git a/fs/btrfs/tree-checker.h b/fs/btrfs/tree-checker.h
index bfb5efa4e01f..48321e8d91bb 100644
--- a/fs/btrfs/tree-checker.h
+++ b/fs/btrfs/tree-checker.h
@@ -40,18 +40,7 @@ struct btrfs_tree_parent_check {
 	u8 level;
 };
 
-/*
- * Comprehensive leaf checker.
- * Will check not only the item pointers, but also every possible member
- * in item data.
- */
-int btrfs_check_leaf_full(struct extent_buffer *leaf);
-
-/*
- * Less strict leaf checker.
- * Will only check item pointers, not reading item data.
- */
-int btrfs_check_leaf_relaxed(struct extent_buffer *leaf);
+int btrfs_check_leaf(struct extent_buffer *leaf);
 int btrfs_check_node(struct extent_buffer *node);
 
 int btrfs_check_chunk_valid(struct extent_buffer *leaf,
-- 
2.40.0

