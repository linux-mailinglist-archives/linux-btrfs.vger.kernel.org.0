Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03A3629EAF
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 17:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238461AbiKOQQl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 11:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238526AbiKOQQe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 11:16:34 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001462C642
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 08:16:32 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id mi9so10073534qvb.8
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 08:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=avD+peq+4BIlPyi3TFx2UJploKTryxmT1bAj7TyUaRM=;
        b=kATGDGLR6RgP8Uz2ls97Qa2UaAYUX2J5ONtJdtfCkjFmPX4gL/95YMTJMsxbTzzN13
         VRpAKj7tcE+V/kLosW6hPUKV3tlhM6s/WTiCFrVQHbkGEOZG5QSYKgpcSGaJZX7McR/T
         EoCmSsmGlxDxL3dbWBIUM+xoF6M1/fsr2+kEV+wOBgxTARhQbyrkgCzu0D0q1GdOFIIv
         TtUlxlcL89681Wkdnp8Dyjl8TLTsh95Zkst1JL0ah1TXqsCi0l/Vd4NcUSzofHEA/VUd
         OWCen0hHw3Mo5Z/ucIQkucEYcDCKokj1sZdghDgjA/ehMcB0leUoLLSKIVOYc1iRI6PI
         VC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=avD+peq+4BIlPyi3TFx2UJploKTryxmT1bAj7TyUaRM=;
        b=6eB8hQ/56/hQfH0aQIW2M8/okIGAouohl9u6DqKskFE+ySOi3DB6BezJeUQkbksGtw
         fdnsilsfKtCgWRAV5hZJT8nEWRTQM2XujuMoyvBOONPiV8HAXROVWnGWcCerbK63V0Hm
         xqYQ9mhtONKyKPnzdGW0sNToIdUe3lN2eyCKz+OeXxS4NDEE+6rC+P+kZchvYcc5mIo4
         d4RkdW39QmtodZ20eC4ATZtKakvhK9uqDYTcdHFBDb298qg9TQuK07sge46P0yh5hd58
         MgGue7UjunwA4wjieHUQZ2XS/iikIb5NCx15mrdjE8//wXxNR/BOeQOtggxQToMuoqTn
         MF1g==
X-Gm-Message-State: ANoB5pl5GakoLzzWb6RqeYlw8bp/v5cchI/3dcfgtrZgInN/OH+14urp
        WoqygCuoZYnWtxY9yTCvWaZpfpYQbXkUzA==
X-Google-Smtp-Source: AA0mqf6D2Wk5VwDg0HaN/YhWD7ClSIZs445Qb52whdSm5fWTu+hw6eK7irn/RLR6oulmkpQcKLaGtw==
X-Received: by 2002:a05:6214:881:b0:4bb:5f2c:fbb4 with SMTP id cz1-20020a056214088100b004bb5f2cfbb4mr17137987qvb.99.1668528991641;
        Tue, 15 Nov 2022 08:16:31 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id c8-20020ac853c8000000b00359961365f1sm7277761qtq.68.2022.11.15.08.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 08:16:31 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 06/11] btrfs: pass the extent buffer for the btrfs_item_nr helpers
Date:   Tue, 15 Nov 2022 11:16:15 -0500
Message-Id: <f3845f634e8c991570a3afed9674071e6fad0b54.1668526429.git.josef@toxicpanda.com>
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

This is actually a change for extent tree v2, but it exists in
btrfs-progs but not in the kernel.  This makes it annoying to sync
accessors.h with btrfs-progs, and since this is the way I need it for
extent-tree v2 simply update these helpers to take the extent buffer in
order to make syncing possible now, and make the extent tree v2 stuff
easier moving forward.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/accessors.h    | 18 +++++++++---------
 fs/btrfs/ctree.c        | 35 ++++++++++++++++++-----------------
 fs/btrfs/extent_io.c    |  2 +-
 fs/btrfs/tree-checker.c |  4 ++--
 4 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
index 066a662f38c3..2b4fb696142b 100644
--- a/fs/btrfs/accessors.h
+++ b/fs/btrfs/accessors.h
@@ -417,37 +417,37 @@ BTRFS_SETGET_FUNCS(raw_item_size, struct btrfs_item, size, 32);
 BTRFS_SETGET_STACK_FUNCS(stack_item_offset, struct btrfs_item, offset, 32);
 BTRFS_SETGET_STACK_FUNCS(stack_item_size, struct btrfs_item, size, 32);
 
-static inline unsigned long btrfs_item_nr_offset(int nr)
+static inline unsigned long btrfs_item_nr_offset(const struct extent_buffer *eb, int nr)
 {
 	return offsetof(struct btrfs_leaf, items) +
 		sizeof(struct btrfs_item) * nr;
 }
 
-static inline struct btrfs_item *btrfs_item_nr(int nr)
+static inline struct btrfs_item *btrfs_item_nr(const struct extent_buffer *eb, int nr)
 {
-	return (struct btrfs_item *)btrfs_item_nr_offset(nr);
+	return (struct btrfs_item *)btrfs_item_nr_offset(eb, nr);
 }
 
 #define BTRFS_ITEM_SETGET_FUNCS(member)						\
 static inline u32 btrfs_item_##member(const struct extent_buffer *eb, int slot)	\
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
 
@@ -462,7 +462,7 @@ static inline u32 btrfs_item_data_end(const struct extent_buffer *eb, int nr)
 static inline void btrfs_item_key(const struct extent_buffer *eb,
 			   struct btrfs_disk_key *disk_key, int nr)
 {
-	struct btrfs_item *item = btrfs_item_nr(nr);
+	struct btrfs_item *item = btrfs_item_nr(eb, nr);
 
 	read_eb_member(eb, item, struct btrfs_item, key, disk_key);
 }
@@ -470,7 +470,7 @@ static inline void btrfs_item_key(const struct extent_buffer *eb,
 static inline void btrfs_set_item_key(struct extent_buffer *eb,
 				      struct btrfs_disk_key *disk_key, int nr)
 {
-	struct btrfs_item *item = btrfs_item_nr(nr);
+	struct btrfs_item *item = btrfs_item_nr(eb, nr);
 
 	write_eb_member(eb, item, struct btrfs_item, key, disk_key);
 }
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index a5a2be4d7717..42c91d52e445 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -3011,13 +3011,13 @@ static noinline int __push_leaf_right(struct btrfs_path *path,
 		     BTRFS_LEAF_DATA_OFFSET + leaf_data_end(left),
 		     push_space);
 
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
@@ -3211,8 +3211,8 @@ static noinline int __push_leaf_left(struct btrfs_path *path, int data_size,
 
 	/* push data from right to left */
 	copy_extent_buffer(left, right,
-			   btrfs_item_nr_offset(btrfs_header_nritems(left)),
-			   btrfs_item_nr_offset(0),
+			   btrfs_item_nr_offset(left, btrfs_header_nritems(left)),
+			   btrfs_item_nr_offset(right, 0),
 			   push_items * sizeof(struct btrfs_item));
 
 	push_space = BTRFS_LEAF_DATA_SIZE(fs_info) -
@@ -3250,8 +3250,8 @@ static noinline int __push_leaf_left(struct btrfs_path *path, int data_size,
 				      BTRFS_LEAF_DATA_OFFSET +
 				      leaf_data_end(right), push_space);
 
-		memmove_extent_buffer(right, btrfs_item_nr_offset(0),
-			      btrfs_item_nr_offset(push_items),
+		memmove_extent_buffer(right, btrfs_item_nr_offset(right, 0),
+			      btrfs_item_nr_offset(left, push_items),
 			     (btrfs_header_nritems(right) - push_items) *
 			     sizeof(struct btrfs_item));
 	}
@@ -3385,8 +3385,8 @@ static noinline void copy_for_split(struct btrfs_trans_handle *trans,
 	btrfs_set_header_nritems(right, nritems);
 	data_copy_size = btrfs_item_data_end(l, mid) - leaf_data_end(l);
 
-	copy_extent_buffer(right, l, btrfs_item_nr_offset(0),
-			   btrfs_item_nr_offset(mid),
+	copy_extent_buffer(right, l, btrfs_item_nr_offset(right, 0),
+			   btrfs_item_nr_offset(l, mid),
 			   nritems * sizeof(struct btrfs_item));
 
 	copy_extent_buffer(right, l,
@@ -3762,8 +3762,8 @@ static noinline int split_item(struct btrfs_path *path,
 	nritems = btrfs_header_nritems(leaf);
 	if (slot != nritems) {
 		/* shift the items */
-		memmove_extent_buffer(leaf, btrfs_item_nr_offset(slot + 1),
-				btrfs_item_nr_offset(slot),
+		memmove_extent_buffer(leaf, btrfs_item_nr_offset(leaf, slot + 1),
+				btrfs_item_nr_offset(leaf, slot),
 				(nritems - slot) * sizeof(struct btrfs_item));
 	}
 
@@ -4055,9 +4055,10 @@ static void setup_items_for_insert(struct btrfs_root *root, struct btrfs_path *p
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
 		memmove_extent_buffer(leaf, BTRFS_LEAF_DATA_OFFSET +
@@ -4311,8 +4312,8 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 			btrfs_set_token_item_offset(&token, i, ioff + dsize);
 		}
 
-		memmove_extent_buffer(leaf, btrfs_item_nr_offset(slot),
-			      btrfs_item_nr_offset(slot + nr),
+		memmove_extent_buffer(leaf, btrfs_item_nr_offset(leaf, slot),
+			      btrfs_item_nr_offset(leaf, slot + nr),
 			      sizeof(struct btrfs_item) *
 			      (nritems - slot - nr));
 	}
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 6b382070b4ad..e5935d761c04 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2663,7 +2663,7 @@ static void prepare_eb_write(struct extent_buffer *eb)
 		 * Leaf:
 		 * header 0 1 2 .. N ... data_N .. data_2 data_1 data_0
 		 */
-		start = btrfs_item_nr_offset(nritems);
+		start = btrfs_item_nr_offset(eb, nritems);
 		end = BTRFS_LEAF_DATA_OFFSET;
 		if (nritems == 0)
 			end += BTRFS_LEAF_DATA_SIZE(eb->fs_info);
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 32e051101a27..baad1ed7e111 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1784,10 +1784,10 @@ static int check_leaf(struct extent_buffer *leaf, bool check_item_data)
 
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

