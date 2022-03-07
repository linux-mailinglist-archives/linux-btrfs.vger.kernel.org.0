Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771D94D0B20
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343781AbiCGWej (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343772AbiCGWeh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:34:37 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B5E56C06
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:33:42 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id c4so14655738qtx.1
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=seANJFhmf+f9mN2fxZOYgqTzMP6l8gMREUjtDjXap+Q=;
        b=LNhIWb4ZlccAhoDw4fasZ1YoRKIKReo6n6CD7hZbIHhrsmgCWreH4iC0ZclVvwl/AQ
         sVU0QU5rVeacBNOr9uhISnUXJRbJAwEe6LYQ4T61yhqfJle+Bh/sdNH5BwpAtfdCHHnd
         mQOxQNZN9ruRHf3PSj9phrOXoTcvnMfdShHHT/33EtsdlKu420+DdfsMWC2QyMpefH1H
         /+wUvV8pIyjYCwshyS/hbYC3/8OfOzzYIPkwhuD1bKThBxq6LRnk1PuErg/D/UuwIvHb
         JkQSPo3xLz1IJIT3Dbb1K+nWisFwgUY7qac6AkOt5gyoVUnk3LMNpUKc8TFTgkpAxIIV
         I7Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=seANJFhmf+f9mN2fxZOYgqTzMP6l8gMREUjtDjXap+Q=;
        b=QxUI/uffdVXstk5kDH6vzFevT/YGWG83Tmp4VlUZluWkSuLXiyKKouivSV3Y9qA2yk
         r87AhPCC46j7yb+0vpzXzFs1Hz0N1p/2zfd/rdg2TkX0h7HHwN+WfDcXLXh3MPPIftHV
         QEBEx+z5MYPx2oGUGuphFJ9kHm+UGrhraSPe6I824DouVixk74TqHHRhMGE2IuHOvcQf
         VQTRqZ29vz8q4GgeDfxnqhwqITKvsDMlRgYTXL8y2HqnCLIWsj4woSSDDd3VRMIzalEl
         MoKHcTw9dTO5EW0/Pj+NkZpHsTXxPkRBYNbFFwjzWRgzXMC4bUp/egWtM833GYk5Hbm3
         iAfQ==
X-Gm-Message-State: AOAM531iQQAT3M+EttkLYUcPECGCKzTq2t/xKaMs76uj/DAe2ia60eFg
        nu60/RSk5l4I9b18C9gf1mK8+PW/ZIFGPDTt
X-Google-Smtp-Source: ABdhPJxLni16V7Eyk2XmheuWszIwFL7m3azmFOiDaCnB5PitS9rj25IWhobuxGKvIF6JUcs5BmQN+A==
X-Received: by 2002:ac8:5950:0:b0:2dc:a139:4f36 with SMTP id 16-20020ac85950000000b002dca1394f36mr11450769qtz.646.1646692421152;
        Mon, 07 Mar 2022 14:33:41 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y11-20020a05622a004b00b002dea2052d7dsm9524878qtw.12.2022.03.07.14.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:33:40 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 06/12] btrfs: pass eb to the item_nr_offset helper
Date:   Mon,  7 Mar 2022 17:33:25 -0500
Message-Id: <66a242c07bd5ac14e8418984a849c340ab82301a.1646692306.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646692306.git.josef@toxicpanda.com>
References: <cover.1646692306.git.josef@toxicpanda.com>
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

This helper needs to know what version of the fs we're looking at to
return the proper offset into the leaf where the item starts, so pass in
the eb so we can get the proper offset.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c        | 35 ++++++++++++++++++-----------------
 fs/btrfs/ctree.h        | 20 +++++++++++---------
 fs/btrfs/extent_io.c    |  2 +-
 fs/btrfs/tree-checker.c |  4 ++--
 4 files changed, 32 insertions(+), 29 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 508bbc50fe8b..1a6f24baf33b 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2912,13 +2912,13 @@ static noinline int __push_leaf_right(struct btrfs_path *path,
 	copy_leaf_data(right, left, BTRFS_LEAF_DATA_SIZE(fs_info) - push_space,
 		       leaf_data_end(left), push_space);
 
-	memmove_extent_buffer(right, btrfs_item_nr_offset(push_items),
-			      btrfs_item_nr_offset(0),
+	memmove_extent_buffer(right, btrfs_item_nr_offset(right, push_items),
+			      btrfs_item_nr_offset(right, 0),
 			      right_nritems * sizeof(struct btrfs_item));
 
 	/* copy the items from left to right */
-	copy_extent_buffer(right, left, btrfs_item_nr_offset(0),
-		   btrfs_item_nr_offset(left_nritems - push_items),
+	copy_extent_buffer(right, left, btrfs_item_nr_offset(right, 0),
+		   btrfs_item_nr_offset(left, left_nritems - push_items),
 		   push_items * sizeof(struct btrfs_item));
 
 	/* update the item pointers */
@@ -3112,8 +3112,8 @@ static noinline int __push_leaf_left(struct btrfs_path *path, int data_size,
 
 	/* push data from right to left */
 	copy_extent_buffer(left, right,
-			   btrfs_item_nr_offset(btrfs_header_nritems(left)),
-			   btrfs_item_nr_offset(0),
+			   btrfs_item_nr_offset(left, btrfs_header_nritems(left)),
+			   btrfs_item_nr_offset(right, 0),
 			   push_items * sizeof(struct btrfs_item));
 
 	push_space = BTRFS_LEAF_DATA_SIZE(fs_info) -
@@ -3147,8 +3147,8 @@ static noinline int __push_leaf_left(struct btrfs_path *path, int data_size,
 				  BTRFS_LEAF_DATA_SIZE(fs_info) - push_space,
 				  leaf_data_end(right), push_space);
 
-		memmove_extent_buffer(right, btrfs_item_nr_offset(0),
-			      btrfs_item_nr_offset(push_items),
+		memmove_extent_buffer(right, btrfs_item_nr_offset(right, 0),
+			      btrfs_item_nr_offset(right, push_items),
 			     (btrfs_header_nritems(right) - push_items) *
 			     sizeof(struct btrfs_item));
 	}
@@ -3282,8 +3282,8 @@ static noinline void copy_for_split(struct btrfs_trans_handle *trans,
 	btrfs_set_header_nritems(right, nritems);
 	data_copy_size = btrfs_item_data_end(l, mid) - leaf_data_end(l);
 
-	copy_extent_buffer(right, l, btrfs_item_nr_offset(0),
-			   btrfs_item_nr_offset(mid),
+	copy_extent_buffer(right, l, btrfs_item_nr_offset(right, 0),
+			   btrfs_item_nr_offset(l, mid),
 			   nritems * sizeof(struct btrfs_item));
 
 	copy_leaf_data(right, l, BTRFS_LEAF_DATA_SIZE(fs_info) - data_copy_size,
@@ -3657,8 +3657,8 @@ static noinline int split_item(struct btrfs_path *path,
 	nritems = btrfs_header_nritems(leaf);
 	if (slot != nritems) {
 		/* shift the items */
-		memmove_extent_buffer(leaf, btrfs_item_nr_offset(slot + 1),
-				btrfs_item_nr_offset(slot),
+		memmove_extent_buffer(leaf, btrfs_item_nr_offset(leaf, slot + 1),
+				btrfs_item_nr_offset(leaf, slot),
 				(nritems - slot) * sizeof(struct btrfs_item));
 	}
 
@@ -3946,9 +3946,10 @@ static void setup_items_for_insert(struct btrfs_root *root, struct btrfs_path *p
 						       ioff - batch->total_data_size);
 		}
 		/* shift the items */
-		memmove_extent_buffer(leaf, btrfs_item_nr_offset(slot + batch->nr),
-			      btrfs_item_nr_offset(slot),
-			      (nritems - slot) * sizeof(struct btrfs_item));
+		memmove_extent_buffer(leaf,
+				      btrfs_item_nr_offset(leaf, slot + batch->nr),
+				      btrfs_item_nr_offset(leaf, slot),
+				      (nritems - slot) * sizeof(struct btrfs_item));
 
 		/* shift the data */
 		memmove_leaf_data(leaf, data_end - batch->total_data_size,
@@ -4198,8 +4199,8 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 			btrfs_set_token_item_offset(&token, i, ioff + dsize);
 		}
 
-		memmove_extent_buffer(leaf, btrfs_item_nr_offset(slot),
-			      btrfs_item_nr_offset(slot + nr),
+		memmove_extent_buffer(leaf, btrfs_item_nr_offset(leaf, slot),
+			      btrfs_item_nr_offset(leaf, slot + nr),
 			      sizeof(struct btrfs_item) *
 			      (nritems - slot - nr));
 	}
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 53a8e200c953..0551bd500ce0 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2016,38 +2016,40 @@ BTRFS_SETGET_FUNCS(raw_item_size, struct btrfs_item, size, 32);
 BTRFS_SETGET_STACK_FUNCS(stack_item_offset, struct btrfs_item, offset, 32);
 BTRFS_SETGET_STACK_FUNCS(stack_item_size, struct btrfs_item, size, 32);
 
-static inline unsigned long btrfs_item_nr_offset(int nr)
+static inline unsigned long btrfs_item_nr_offset(const struct extent_buffer *eb,
+						 int nr)
 {
 	return offsetof(struct btrfs_leaf, items) +
 		sizeof(struct btrfs_item) * nr;
 }
 
-static inline struct btrfs_item *btrfs_item_nr(int nr)
+static inline struct btrfs_item *btrfs_item_nr(const struct extent_buffer *eb,
+					       int nr)
 {
-	return (struct btrfs_item *)btrfs_item_nr_offset(nr);
+	return (struct btrfs_item *)btrfs_item_nr_offset(eb, nr);
 }
 
 #define BTRFS_ITEM_SETGET_FUNCS(member)						\
 static inline u32 btrfs_item_##member(const struct extent_buffer *eb,		\
 				      int slot)					\
 {										\
-	return btrfs_raw_item_##member(eb, btrfs_item_nr(slot));		\
+	return btrfs_raw_item_##member(eb, btrfs_item_nr(eb, slot));		\
 }										\
 static inline void btrfs_set_item_##member(const struct extent_buffer *eb,	\
 					   int slot, u32 val)			\
 {										\
-	btrfs_set_raw_item_##member(eb, btrfs_item_nr(slot), val);		\
+	btrfs_set_raw_item_##member(eb, btrfs_item_nr(eb, slot), val);		\
 }										\
 static inline u32 btrfs_token_item_##member(struct btrfs_map_token *token,	\
 					    int slot)				\
 {										\
-	struct btrfs_item *item = btrfs_item_nr(slot);				\
+	struct btrfs_item *item = btrfs_item_nr(token->eb, slot);		\
 	return btrfs_token_raw_item_##member(token, item);			\
 }										\
 static inline void btrfs_set_token_item_##member(struct btrfs_map_token *token,	\
 						 int slot, u32 val)		\
 {										\
-	struct btrfs_item *item = btrfs_item_nr(slot);				\
+	struct btrfs_item *item = btrfs_item_nr(token->eb, slot);		\
 	btrfs_set_token_raw_item_##member(token, item, val);			\
 }
 
@@ -2062,14 +2064,14 @@ static inline u32 btrfs_item_data_end(const struct extent_buffer *eb, int nr)
 static inline void btrfs_item_key(const struct extent_buffer *eb,
 			   struct btrfs_disk_key *disk_key, int nr)
 {
-	struct btrfs_item *item = btrfs_item_nr(nr);
+	struct btrfs_item *item = btrfs_item_nr(eb, nr);
 	read_eb_member(eb, item, struct btrfs_item, key, disk_key);
 }
 
 static inline void btrfs_set_item_key(struct extent_buffer *eb,
 			       struct btrfs_disk_key *disk_key, int nr)
 {
-	struct btrfs_item *item = btrfs_item_nr(nr);
+	struct btrfs_item *item = btrfs_item_nr(eb, nr);
 	write_eb_member(eb, item, struct btrfs_item, key, disk_key);
 }
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 86a0dd3b55b0..951b2e0e0df1 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4507,7 +4507,7 @@ static void prepare_eb_write(struct extent_buffer *eb)
 		 * Leaf:
 		 * header 0 1 2 .. N ... data_N .. data_2 data_1 data_0
 		 */
-		start = btrfs_item_nr_offset(nritems);
+		start = btrfs_item_nr_offset(eb, nritems);
 		end = BTRFS_LEAF_DATA_OFFSET(eb) + leaf_data_end(eb);
 		memzero_extent_buffer(eb, start, end - start);
 	}
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index e56c0107eea3..f0aabda9fd94 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1759,10 +1759,10 @@ static int check_leaf(struct extent_buffer *leaf, bool check_item_data)
 
 		/* Also check if the item pointer overlaps with btrfs item. */
 		if (unlikely(btrfs_item_ptr_offset(leaf, slot) <
-			     btrfs_item_nr_offset(slot) + sizeof(struct btrfs_item))) {
+			     btrfs_item_nr_offset(leaf, slot) + sizeof(struct btrfs_item))) {
 			generic_err(leaf, slot,
 		"slot overlaps with its data, item end %lu data start %lu",
-				btrfs_item_nr_offset(slot) +
+				btrfs_item_nr_offset(leaf, slot) +
 				sizeof(struct btrfs_item),
 				btrfs_item_ptr_offset(leaf, slot));
 			return -EUCLEAN;
-- 
2.26.3

