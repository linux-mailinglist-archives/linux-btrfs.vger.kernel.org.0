Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8FC4D0B24
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343761AbiCGWeh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239639AbiCGWed (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:34:33 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452432981A
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:33:38 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id q4so13291113qki.11
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=kWGw9hAjv4QltzgS1Hl1A0Ie+q709aoGGLkEUwcwCt8=;
        b=4mw3XbGfM2yOfxx4ViimqLSlKO9fhZF+b69pxtSewRuhwFbQKJaJNf0u7blFWNT8sL
         H8UABCn9xAOp+a/nlNOnCSCCg5BoaOQyV8rnUnD88pr4YhmdNWXkC28Af6OT9LDdJ7UU
         7j57Y4CqcxqvMc1AYG+bPKg9WxrgED3xzWX8letx/b2QqHE+9CAOjd1Uc4tOl6Yw1Sg/
         k5QWl1OKs8L+J94jB7crio5imdHfVFovEm7hgwmYYM7wEiJoTy6VGO7a+zvIea8G8OwG
         a9d6YIqyZaQKgpWGX2/Znzj9jiOlmTikKdzSPEXsjiJoDU8dT0mlUNRwmlh3DQ/toz+f
         jA0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kWGw9hAjv4QltzgS1Hl1A0Ie+q709aoGGLkEUwcwCt8=;
        b=JGNLR3wm+p1Ei2IXZEm9PUqhnH6iEJUwyMVN/5piwG9n1BgPYOx6uBMdx2Uo0obbiz
         6YxtOwRxMUGgVwWN8XAFKqTGvyH6tMU1KHWl0RnaGLeadSHYENa00FznkRSD+jH/1dcZ
         UR+V4kD+qIv026jpOicp8rVc71IrWoXCXucXapCnUHfvK6qoI3ao/UatupB+lUm0Txy7
         T9kkj04pA+NZOoe+g4L145OkeaWv46WL8TvjKps/E/vfEcHSKxb2ffPiZExlIhlaM28/
         8WQDfhDPhBh+B2r/weo+aKrMC4jXPmoPiZc7T4YzGg6YlsF9eQDU2d13vUupxk4DYa8q
         /5ZA==
X-Gm-Message-State: AOAM530YyJqUS8rgc9yezDAUO2QVoDwIq672wfEO91XNJLgnM81CQyoK
        g1IwRP2YJe6KPL3lI++2/w83QJQhwVSaTuWh
X-Google-Smtp-Source: ABdhPJzKDGvZ0eGHfqzOBSy4Yebjuho/R3dd8MGM8nGkbibMSr/OAPEUO3QS+F/CXysXv26KiLTUDg==
X-Received: by 2002:a37:f510:0:b0:663:9d17:8c2e with SMTP id l16-20020a37f510000000b006639d178c2emr8273745qkk.397.1646692417054;
        Mon, 07 Mar 2022 14:33:37 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k125-20020a378883000000b006491db6dbb1sm6987747qkd.84.2022.03.07.14.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:33:36 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 03/12] btrfs: introduce *_leaf_data helpers
Date:   Mon,  7 Mar 2022 17:33:22 -0500
Message-Id: <2b26868e81099774fb63e93059d5fcd06f2077c5.1646692306.git.josef@toxicpanda.com>
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

The item offsets are set not taking into account the
BTRFS_LEAF_DATA_OFFSET, which is to say they ignore the size of the
header.

ie btrfs_item_offset(nr) is actually sizeof(struct btrfs_header) +
btrfs_item_offset(nr) into the leaf.

Because of this anywhere we do memmove/copy of the item data we have to
add BTRFS_LEAF_DATA_OFFSET to the offsets we're using.  Which means we
have the following pattern

copy_extent_buffer(src, dst,
		   BTRFS_LEAF_DATA_OFFSET + btrfs_item_offset(nr),
		   BTRFS_LEAF_DATA_OFFSET + other_offset, size);

in a lot of spaces.  Clean this up by adding two helpers that do the
appropriate offset adjustment, and change all the users to simply pass
in the item_offset offsets.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c | 84 ++++++++++++++++++++++++++----------------------
 1 file changed, 46 insertions(+), 38 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index eee0b7e3c68a..8a35db9d7319 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -43,6 +43,31 @@ static const struct btrfs_csums {
 				     .driver = "blake2b-256" },
 };
 
+/*
+ * These helpers take the btrfs_item_offset() values and adjust them based on
+ * the header size.  Do not use these with the value adjusted for the header,
+ * simply use the raw btrfs_item_offset() values.
+ */
+static inline void memmove_leaf_data(const struct extent_buffer *dst,
+				     unsigned long dst_offset,
+				     unsigned long src_offset,
+				     unsigned long len)
+{
+	dst_offset += BTRFS_LEAF_DATA_OFFSET;
+	src_offset += BTRFS_LEAF_DATA_OFFSET;
+	memmove_extent_buffer(dst, dst_offset, src_offset, len);
+}
+
+static inline void copy_leaf_data(const struct extent_buffer *dst,
+				  const struct extent_buffer *src,
+				  unsigned long dst_offset,
+				  unsigned long src_offset, unsigned long len)
+{
+	dst_offset += BTRFS_LEAF_DATA_OFFSET;
+	src_offset += BTRFS_LEAF_DATA_OFFSET;
+	copy_extent_buffer(dst, src, dst_offset, src_offset, len);
+}
+
 int btrfs_super_csum_size(const struct btrfs_super_block *s)
 {
 	u16 t = btrfs_super_csum_type(s);
@@ -2880,16 +2905,12 @@ static noinline int __push_leaf_right(struct btrfs_path *path,
 
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
 
 	memmove_extent_buffer(right, btrfs_item_nr_offset(push_items),
 			      btrfs_item_nr_offset(0),
@@ -3098,11 +3119,8 @@ static noinline int __push_leaf_left(struct btrfs_path *path, int data_size,
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
 
@@ -3125,10 +3143,9 @@ static noinline int __push_leaf_left(struct btrfs_path *path, int data_size,
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
 
 		memmove_extent_buffer(right, btrfs_item_nr_offset(0),
 			      btrfs_item_nr_offset(push_items),
@@ -3269,10 +3286,8 @@ static noinline void copy_for_split(struct btrfs_trans_handle *trans,
 			   btrfs_item_nr_offset(mid),
 			   nritems * sizeof(struct btrfs_item));
 
-	copy_extent_buffer(right, l,
-		     BTRFS_LEAF_DATA_OFFSET + BTRFS_LEAF_DATA_SIZE(fs_info) -
-		     data_copy_size, BTRFS_LEAF_DATA_OFFSET +
-		     leaf_data_end(l), data_copy_size);
+	copy_leaf_data(right, l, BTRFS_LEAF_DATA_SIZE(fs_info) - data_copy_size,
+		       leaf_data_end(l), data_copy_size);
 
 	rt_data_off = BTRFS_LEAF_DATA_SIZE(fs_info) - btrfs_item_data_end(l, mid);
 
@@ -3755,9 +3770,8 @@ void btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end)
 
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
@@ -3782,9 +3796,8 @@ void btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end)
 			}
 		}
 
-		memmove_extent_buffer(leaf, BTRFS_LEAF_DATA_OFFSET +
-			      data_end + size_diff, BTRFS_LEAF_DATA_OFFSET +
-			      data_end, old_data_start - data_end);
+		memmove_leaf_data(leaf, data_end + size_diff, data_end,
+				  old_data_start - data_end);
 
 		offset = btrfs_disk_key_offset(&disk_key);
 		btrfs_set_disk_key_offset(&disk_key, offset + size_diff);
@@ -3849,9 +3862,8 @@ void btrfs_extend_item(struct btrfs_path *path, u32 data_size)
 	}
 
 	/* shift the data */
-	memmove_extent_buffer(leaf, BTRFS_LEAF_DATA_OFFSET +
-		      data_end - data_size, BTRFS_LEAF_DATA_OFFSET +
-		      data_end, old_data - data_end);
+	memmove_leaf_data(leaf, data_end - data_size, data_end,
+			  old_data - data_end);
 
 	data_end = old_data;
 	old_size = btrfs_item_size(leaf, slot);
@@ -3939,10 +3951,8 @@ static void setup_items_for_insert(struct btrfs_root *root, struct btrfs_path *p
 			      (nritems - slot) * sizeof(struct btrfs_item));
 
 		/* shift the data */
-		memmove_extent_buffer(leaf, BTRFS_LEAF_DATA_OFFSET +
-				      data_end - batch->total_data_size,
-				      BTRFS_LEAF_DATA_OFFSET + data_end,
-				      old_data - data_end);
+		memmove_leaf_data(leaf, data_end - batch->total_data_size,
+				  data_end, old_data - data_end);
 		data_end = old_data;
 	}
 
@@ -4177,10 +4187,8 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
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
-- 
2.26.3

