Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78CB6629EAB
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 17:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238503AbiKOQQo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 11:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238487AbiKOQQg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 11:16:36 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5292AE20
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 08:16:35 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id o8so10088326qvw.5
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 08:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1lmzpXhwpTPAif/ydufqa954TBdI0ZzvQj65SxziPQs=;
        b=K1IbmxdvHuCsFIFjrEqOsW1jOs1OE8xP4h/gRivSnEiGDyx0ftuyX5PbEaws4kAV2F
         dVz3VWKptMlLX8OTYZU7BgIxQHXfF41/WM3rDYCZBfDDc0U2YMdSD/5Hjy0ByDlAOSFD
         7rMpX+gAQfsY1q1sy5xhWn3DTqhVOgmJyDXCDkaQpm/gpFDCdQx2AI0Nj+DbrsAIMN1x
         pIDh3WyN9ONFk6VIm4voj1bHp3QCh/i3XF9Eu8mhR+cu58cGEh6cEVxasWeCLJlEAMDQ
         RsrcBpdE/emmjH8dkZ/OQ1anpiS9j5VT7ajFf5gNM/mFlbhpMCw5+0ZlGRlVIq07oQ/Z
         XajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1lmzpXhwpTPAif/ydufqa954TBdI0ZzvQj65SxziPQs=;
        b=39F3pbkJ2LxdPkaBlsIv/y9gyz1mofXXJkjdAhVx5d5RtAR4qPQzEfCq/K4P+anE+2
         CNUlIylXCng+6CIUxX41L1T8YIZhKlQ8qekVPGFVKQrzbl/X+EYYRJwWkj4HEd/3Py3q
         5/2RDaj+6WlY1OEHdYZrd+mw8ytPJcBHBlB+PdgdBqCOPD4mnFn34iRz5FOyeiZGbIk1
         YNU4egTMUuDjGtCZa6nnD1S8dT5R5IbNwPcMaM9PmB5orL9QT5jiKOKOuFbzDMno5PCq
         cR/6hyvVgk9cX9BuynZlVU5N810keT0eztmFgNqRXOkWzfqVDLVqnJU3gSEqlgPphYaE
         HLUg==
X-Gm-Message-State: ANoB5pnHWIjyRNiCXWvwY9YrI9jf1Lzw4JrTgFRhICabb8pnSP7LcvyW
        T3oxJiSP88iuQBaSl6g9RJ113yEtXF20AQ==
X-Google-Smtp-Source: AA0mqf6HXrug/pjMHDBIJyeKHSADIcayzFirCqYX8jL40IF6Wagh2N6dhPPa54k3DBDU/wcqUjE51g==
X-Received: by 2002:ad4:4581:0:b0:4b4:a0b0:2dd9 with SMTP id x1-20020ad44581000000b004b4a0b02dd9mr17309118qvu.125.1668528994282;
        Tue, 15 Nov 2022 08:16:34 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id s36-20020a05622a1aa400b0039cc944ebdasm7441293qtc.54.2022.11.15.08.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 08:16:33 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 08/11] btrfs: add helpers for manipulating leaf items and data
Date:   Tue, 15 Nov 2022 11:16:17 -0500
Message-Id: <736aa0650e28df2b70d3a75fdd0fa7b18997db37.1668526429.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1668526429.git.josef@toxicpanda.com>
References: <cover.1668526429.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have some gnarly memmove and copy_extent_buffer calls for leaf
manipulation.  This is because our item offsets aren't absolute, they're
based on 0 being where the items start in the leaf, which is after the
btrfs_header.  This means any manipulation of the data requires adding
sizeof(struct btrfs_header) to the offsets we pull from the items.
Moving the items themselves is easier as the helpers are absolute
offsets, however we of course have to call the helpers to get the
offsets for the item numbers.  This makes for
copy_extent_buffer/memmove_extent_buffer calls that are kind of hard to
reason about what's happening.

Fix this by pushing this logic into helpers.  For data we'll only use
the item provided offsets, and the helpers will use the
BTRFS_LEAF_DATA_OFFSET addition for the offsets.  Additionally for the
item manipulation simply pass in the item numbers, and then the helpers
will call the offset helper to get the actual offset into the leaf.

The diffstat makes this look like more code, but that's simply because I
added comments for the helpers, it's net negative for the amount of
code, and is easier to reason.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c | 177 +++++++++++++++++++++++++++++------------------
 1 file changed, 111 insertions(+), 66 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index d9b1002e0cd0..ac8b76e90b1c 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -65,6 +65,87 @@ static inline unsigned int leaf_data_end(const struct extent_buffer *leaf)
 	return btrfs_item_offset(leaf, nr - 1);
 }
 
+/*
+ * memmove_leaf_data - memmove item data in a leaf
+ * @leaf:	leaf that we're doing a memmove on
+ * @dst_offset:	item data offset we're moving to
+ * @src_offset:	item data offset were' moving from
+ * @len:	length of the data we're moving
+ *
+ * This is just a wrapper around memmove_extent_buffer() that takes into account
+ * the header on the leaf.  The btrfs_item offset's start directly after the
+ * header, so we have to adjust any offsets to account for the header in the
+ * leaf.  This handles that math to simplify the callers.
+ */
+static inline void memmove_leaf_data(const struct extent_buffer *leaf,
+				     unsigned long dst_offset,
+				     unsigned long src_offset,
+				     unsigned long len)
+{
+	memmove_extent_buffer(leaf, BTRFS_LEAF_DATA_OFFSET + dst_offset,
+			      BTRFS_LEAF_DATA_OFFSET + src_offset, len);
+}
+
+/*
+ * copy_leaf_data - copy item data from src into dst at the given offset
+ * @dst:	destination leaf that we're copying into
+ * @src:	source leaf that we're copying from
+ * @dst_offset:	item data offset we're copying to
+ * @src_offset:	item data offset were' copying from
+ * @len:	length of the data we're copying
+ *
+ * This is just a wrapper around copy_extent_buffer() that takes into account
+ * the header on the leaf.  The btrfs_item offset's start directly after the
+ * header, so we have to adjust any offsets to account for the header in the
+ * leaf.  This handles that math to simplify the callers.
+ */
+static inline void copy_leaf_data(const struct extent_buffer *dst,
+				  const struct extent_buffer *src,
+				  unsigned long dst_offset,
+				  unsigned long src_offset, unsigned long len)
+{
+	copy_extent_buffer(dst, src, BTRFS_LEAF_DATA_OFFSET + dst_offset,
+			   BTRFS_LEAF_DATA_OFFSET + src_offset, len);
+}
+
+/*
+ * memmove_leaf_items - memmove items in a leaf
+ * @dst:	destination leaf for the items
+ * @dst_item:	the item nr we're copying into
+ * @src_item:	the item nr we're copying from
+ * @nr_items:	the number of items to copy
+ *
+ * This is just a wrapper around memmove_extent_buffer() that does the math to
+ * get the appropriate offsets into the leaf from the item numbers.
+ */
+static inline void memmove_leaf_items(const struct extent_buffer *leaf,
+				      int dst_item, int src_item, int nr_items)
+{
+	memmove_extent_buffer(leaf, btrfs_item_nr_offset(leaf, dst_item),
+			      btrfs_item_nr_offset(leaf, src_item),
+			      nr_items * sizeof(struct btrfs_item));
+}
+
+/*
+ * copy_leaf_items - copy items from src into dst at the given offset
+ * @dst:	destination leaf for the items
+ * @src:	source leaf for the items
+ * @dst_item:	the item nr we're copying into
+ * @src_item:	the item nr we're copying from
+ * @nr_items:	the number of items to copy
+ *
+ * This is just a wrapper around copy_extent_buffer() that does the math to get
+ * the appropriate offsets into the leaf from the item numbers.
+ */
+static inline void copy_leaf_items(const struct extent_buffer *dst,
+				   const struct extent_buffer *src,
+				   int dst_item, int src_item, int nr_items)
+{
+	copy_extent_buffer(dst, src, btrfs_item_nr_offset(dst, dst_item),
+			      btrfs_item_nr_offset(src, src_item),
+			      nr_items * sizeof(struct btrfs_item));
+}
+
 int btrfs_super_csum_size(const struct btrfs_super_block *s)
 {
 	u16 t = btrfs_super_csum_type(s);
@@ -3000,25 +3081,17 @@ static noinline int __push_leaf_right(struct btrfs_path *path,
 
 	/* make room in the right data area */
 	data_end = leaf_data_end(right);
-	memmove_extent_buffer(right,
-			      BTRFS_LEAF_DATA_OFFSET + data_end - push_space,
-			      BTRFS_LEAF_DATA_OFFSET + data_end,
-			      BTRFS_LEAF_DATA_SIZE(fs_info) - data_end);
+	memmove_leaf_data(right, data_end - push_space, data_end,
+			  BTRFS_LEAF_DATA_SIZE(fs_info) - data_end);
 
 	/* copy from the left data area */
-	copy_extent_buffer(right, left, BTRFS_LEAF_DATA_OFFSET +
-		     BTRFS_LEAF_DATA_SIZE(fs_info) - push_space,
-		     BTRFS_LEAF_DATA_OFFSET + leaf_data_end(left),
-		     push_space);
+	copy_leaf_data(right, left, BTRFS_LEAF_DATA_SIZE(fs_info) - push_space,
+		       leaf_data_end(left), push_space);
 
-	memmove_extent_buffer(right, btrfs_item_nr_offset(right, push_items),
-			      btrfs_item_nr_offset(right, 0),
-			      right_nritems * sizeof(struct btrfs_item));
+	memmove_leaf_items(right, push_items, 0, right_nritems);
 
 	/* copy the items from left to right */
-	copy_extent_buffer(right, left, btrfs_item_nr_offset(right, 0),
-		   btrfs_item_nr_offset(left, left_nritems - push_items),
-		   push_items * sizeof(struct btrfs_item));
+	copy_leaf_items(right, left, 0, left_nritems - push_items, push_items);
 
 	/* update the item pointers */
 	btrfs_init_map_token(&token, right);
@@ -3210,19 +3283,13 @@ static noinline int __push_leaf_left(struct btrfs_path *path, int data_size,
 	WARN_ON(!empty && push_items == btrfs_header_nritems(right));
 
 	/* push data from right to left */
-	copy_extent_buffer(left, right,
-			   btrfs_item_nr_offset(left, btrfs_header_nritems(left)),
-			   btrfs_item_nr_offset(right, 0),
-			   push_items * sizeof(struct btrfs_item));
+	copy_leaf_items(left, right, btrfs_header_nritems(left), 0, push_items);
 
 	push_space = BTRFS_LEAF_DATA_SIZE(fs_info) -
 		     btrfs_item_offset(right, push_items - 1);
 
-	copy_extent_buffer(left, right, BTRFS_LEAF_DATA_OFFSET +
-		     leaf_data_end(left) - push_space,
-		     BTRFS_LEAF_DATA_OFFSET +
-		     btrfs_item_offset(right, push_items - 1),
-		     push_space);
+	copy_leaf_data(left, right, leaf_data_end(left) - push_space,
+		       btrfs_item_offset(right, push_items - 1), push_space);
 	old_left_nritems = btrfs_header_nritems(left);
 	BUG_ON(old_left_nritems <= 0);
 
@@ -3245,15 +3312,12 @@ static noinline int __push_leaf_left(struct btrfs_path *path, int data_size,
 	if (push_items < right_nritems) {
 		push_space = btrfs_item_offset(right, push_items - 1) -
 						  leaf_data_end(right);
-		memmove_extent_buffer(right, BTRFS_LEAF_DATA_OFFSET +
-				      BTRFS_LEAF_DATA_SIZE(fs_info) - push_space,
-				      BTRFS_LEAF_DATA_OFFSET +
-				      leaf_data_end(right), push_space);
+		memmove_leaf_data(right,
+				  BTRFS_LEAF_DATA_SIZE(fs_info) - push_space,
+				  leaf_data_end(right), push_space);
 
-		memmove_extent_buffer(right, btrfs_item_nr_offset(right, 0),
-			      btrfs_item_nr_offset(left, push_items),
-			     (btrfs_header_nritems(right) - push_items) *
-			     sizeof(struct btrfs_item));
+		memmove_leaf_items(right, 0, push_items,
+				   btrfs_header_nritems(right) - push_items);
 	}
 
 	btrfs_init_map_token(&token, right);
@@ -3385,14 +3449,10 @@ static noinline void copy_for_split(struct btrfs_trans_handle *trans,
 	btrfs_set_header_nritems(right, nritems);
 	data_copy_size = btrfs_item_data_end(l, mid) - leaf_data_end(l);
 
-	copy_extent_buffer(right, l, btrfs_item_nr_offset(right, 0),
-			   btrfs_item_nr_offset(l, mid),
-			   nritems * sizeof(struct btrfs_item));
+	copy_leaf_items(right, l, 0, mid, nritems);
 
-	copy_extent_buffer(right, l,
-		     BTRFS_LEAF_DATA_OFFSET + BTRFS_LEAF_DATA_SIZE(fs_info) -
-		     data_copy_size, BTRFS_LEAF_DATA_OFFSET +
-		     leaf_data_end(l), data_copy_size);
+	copy_leaf_data(right, l, BTRFS_LEAF_DATA_SIZE(fs_info) - data_copy_size,
+		       leaf_data_end(l), data_copy_size);
 
 	rt_data_off = BTRFS_LEAF_DATA_SIZE(fs_info) - btrfs_item_data_end(l, mid);
 
@@ -3762,9 +3822,7 @@ static noinline int split_item(struct btrfs_path *path,
 	nritems = btrfs_header_nritems(leaf);
 	if (slot != nritems) {
 		/* shift the items */
-		memmove_extent_buffer(leaf, btrfs_item_nr_offset(leaf, slot + 1),
-				btrfs_item_nr_offset(leaf, slot),
-				(nritems - slot) * sizeof(struct btrfs_item));
+		memmove_leaf_items(leaf, slot + 1, slot, nritems - slot);
 	}
 
 	btrfs_cpu_key_to_disk(&disk_key, new_key);
@@ -3875,9 +3933,8 @@ void btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end)
 
 	/* shift the data */
 	if (from_end) {
-		memmove_extent_buffer(leaf, BTRFS_LEAF_DATA_OFFSET +
-			      data_end + size_diff, BTRFS_LEAF_DATA_OFFSET +
-			      data_end, old_data_start + new_size - data_end);
+		memmove_leaf_data(leaf, data_end + size_diff, data_end,
+				  old_data_start + new_size - data_end);
 	} else {
 		struct btrfs_disk_key disk_key;
 		u64 offset;
@@ -3902,9 +3959,8 @@ void btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end)
 			}
 		}
 
-		memmove_extent_buffer(leaf, BTRFS_LEAF_DATA_OFFSET +
-			      data_end + size_diff, BTRFS_LEAF_DATA_OFFSET +
-			      data_end, old_data_start - data_end);
+		memmove_leaf_data(leaf, data_end + size_diff, data_end,
+				  old_data_start - data_end);
 
 		offset = btrfs_disk_key_offset(&disk_key);
 		btrfs_set_disk_key_offset(&disk_key, offset + size_diff);
@@ -3969,9 +4025,8 @@ void btrfs_extend_item(struct btrfs_path *path, u32 data_size)
 	}
 
 	/* shift the data */
-	memmove_extent_buffer(leaf, BTRFS_LEAF_DATA_OFFSET +
-		      data_end - data_size, BTRFS_LEAF_DATA_OFFSET +
-		      data_end, old_data - data_end);
+	memmove_leaf_data(leaf, data_end - data_size, data_end,
+			  old_data - data_end);
 
 	data_end = old_data;
 	old_size = btrfs_item_size(leaf, slot);
@@ -4055,16 +4110,11 @@ static void setup_items_for_insert(struct btrfs_root *root, struct btrfs_path *p
 						       ioff - batch->total_data_size);
 		}
 		/* shift the items */
-		memmove_extent_buffer(leaf,
-				      btrfs_item_nr_offset(leaf, slot + batch->nr),
-				      btrfs_item_nr_offset(leaf, slot),
-				      (nritems - slot) * sizeof(struct btrfs_item));
+		memmove_leaf_items(leaf, slot + batch->nr, slot, nritems - slot);
 
 		/* shift the data */
-		memmove_extent_buffer(leaf, BTRFS_LEAF_DATA_OFFSET +
-				      data_end - batch->total_data_size,
-				      BTRFS_LEAF_DATA_OFFSET + data_end,
-				      old_data - data_end);
+		memmove_leaf_data(leaf, data_end - batch->total_data_size,
+				  data_end, old_data - data_end);
 		data_end = old_data;
 	}
 
@@ -4299,10 +4349,8 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		for (i = 0; i < nr; i++)
 			dsize += btrfs_item_size(leaf, slot + i);
 
-		memmove_extent_buffer(leaf, BTRFS_LEAF_DATA_OFFSET +
-			      data_end + dsize,
-			      BTRFS_LEAF_DATA_OFFSET + data_end,
-			      last_off - data_end);
+		memmove_leaf_data(leaf, data_end + dsize, data_end,
+				  last_off - data_end);
 
 		btrfs_init_map_token(&token, leaf);
 		for (i = slot + nr; i < nritems; i++) {
@@ -4312,10 +4360,7 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 			btrfs_set_token_item_offset(&token, i, ioff + dsize);
 		}
 
-		memmove_extent_buffer(leaf, btrfs_item_nr_offset(leaf, slot),
-			      btrfs_item_nr_offset(leaf, slot + nr),
-			      sizeof(struct btrfs_item) *
-			      (nritems - slot - nr));
+		memmove_leaf_items(leaf, slot, slot + nr, nritems - slot - nr);
 	}
 	btrfs_set_header_nritems(leaf, nritems - nr);
 	nritems -= nr;
-- 
2.26.3

