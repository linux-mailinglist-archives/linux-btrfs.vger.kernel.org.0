Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3620E629EA7
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 17:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238497AbiKOQQm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 11:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238536AbiKOQQg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 11:16:36 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C76C2AC56
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 08:16:34 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id fz10so9004830qtb.3
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 08:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q58XeUebTGOUUxoNTJlVxLKsEbsUensEXY3h30vLrsM=;
        b=P77IV4umBXluCD1v504prqrQZvvNmMueKjJVQC1mMx1XCIFh/TlbR4+HnVgKnPBSPC
         pCrIceH0iZOPOtVXhc4Zt8pBiTCZ29Z+PRORaxT6ygwlTyKxqwCuLKjbMI94JuBvFSAY
         W0Mpw+bAgDEB+ytbOtCSNstJYhQcnY2Y8CTV/2+aXBKbMTnva3ZPNh4sFeh8Zfltts7Q
         yz1X/5LDLTj5o3+/MOUhMNUiDw67plkUJF19tjYl24nypyTR7M2EiHe1b4bMnrMS8JHB
         DHKagrSEWb2F68bHOIhPLgOUU7MsIyAqY+kXbc+5aimBUeQOHfq17qc5D8qtHJjQ8hCU
         M2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q58XeUebTGOUUxoNTJlVxLKsEbsUensEXY3h30vLrsM=;
        b=zRfKgKF48Wdp4HfW90dCR5YOhMj0cqwjNXwnE2QUkMcgDWl8IYWGXAohbxTRal/BIV
         tDRp3+N8OpHArti3EYC2EruretsxOXvutq+2ewqh6whlzK6XmE2LekN7wJnugKzrpesH
         1C7+wMHoQe0WvsTu9AeyS5jI5drO5Q5wRdktuLBxbZkucb6s/MQqHGO3jjFpN0dsFY9S
         oEQvhy8P6azjWxmsyarfp0t3evENapbgJN11gsxFUMCsq9PZdwel4hG8l2p/4PXlUV7g
         eoA3BJkdUW0P/3dX3rBNyfcY20f0ePYU2lFesquHPlQv8FHlnfoRMazwoONvWpBJxGee
         iO0w==
X-Gm-Message-State: ANoB5pnxDlbhzafWqSbXvLutZ4oVOTRqtvXHaFR5UV9W3wklQoS27ef6
        7BkGYc6bx4McFkgKnMlhkHH7Ys6b/6D51g==
X-Google-Smtp-Source: AA0mqf5io+CjwV6N2oRXRooc94F0yM/98Unj+KAN74TSY0szZkhBq86pHdRJMNn3vd5RsDhVlY3FXw==
X-Received: by 2002:a05:622a:4c08:b0:3a5:eb38:ab59 with SMTP id ey8-20020a05622a4c0800b003a5eb38ab59mr9633621qtb.246.1668528992983;
        Tue, 15 Nov 2022 08:16:32 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id h3-20020a05620a244300b006eed47a1a1esm8402963qkn.134.2022.11.15.08.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 08:16:32 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 07/11] btrfs: add eb to btrfs_node_key_ptr_offset
Date:   Tue, 15 Nov 2022 11:16:16 -0500
Message-Id: <73127d7b1dfb836b4ba0f45569eff6ba7dd43686.1668526429.git.josef@toxicpanda.com>
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

This is a change needed for extent tree v2, as we will be growing the
header size.  This exists in btrfs-progs currently, and not having it
makes syncing accessors.[ch] more problematic.  So make this change to
set us up for extent tree v2 and match what btrfs-progs does to make
syncing easier.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/accessors.c    |  2 +-
 fs/btrfs/accessors.h    |  4 ++--
 fs/btrfs/ctree.c        | 28 ++++++++++++++--------------
 fs/btrfs/extent_io.c    |  2 +-
 fs/btrfs/tree-mod-log.c |  4 ++--
 5 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/accessors.c b/fs/btrfs/accessors.c
index 7a7b7d263102..206cf1612c1d 100644
--- a/fs/btrfs/accessors.c
+++ b/fs/btrfs/accessors.c
@@ -168,7 +168,7 @@ DEFINE_BTRFS_SETGET_BITS(64)
 void btrfs_node_key(const struct extent_buffer *eb,
 		    struct btrfs_disk_key *disk_key, int nr)
 {
-	unsigned long ptr = btrfs_node_key_ptr_offset(nr);
+	unsigned long ptr = btrfs_node_key_ptr_offset(eb, nr);
 	read_eb_member(eb, (struct btrfs_key_ptr *)ptr,
 		       struct btrfs_key_ptr, key, disk_key);
 }
diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
index 2b4fb696142b..88eea44fdd7f 100644
--- a/fs/btrfs/accessors.h
+++ b/fs/btrfs/accessors.h
@@ -392,7 +392,7 @@ static inline void btrfs_set_node_ptr_generation(const struct extent_buffer *eb,
 	btrfs_set_key_generation(eb, (struct btrfs_key_ptr *)ptr, val);
 }
 
-static inline unsigned long btrfs_node_key_ptr_offset(int nr)
+static inline unsigned long btrfs_node_key_ptr_offset(const struct extent_buffer *eb, int nr)
 {
 	return offsetof(struct btrfs_node, ptrs) +
 		sizeof(struct btrfs_key_ptr) * nr;
@@ -406,7 +406,7 @@ static inline void btrfs_set_node_key(const struct extent_buffer *eb,
 {
 	unsigned long ptr;
 
-	ptr = btrfs_node_key_ptr_offset(nr);
+	ptr = btrfs_node_key_ptr_offset(eb, nr);
 	write_eb_member(eb, (struct btrfs_key_ptr *)ptr,
 		        struct btrfs_key_ptr, key, disk_key);
 }
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 42c91d52e445..d9b1002e0cd0 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2590,8 +2590,8 @@ static int push_node_left(struct btrfs_trans_handle *trans,
 		return ret;
 	}
 	copy_extent_buffer(dst, src,
-			   btrfs_node_key_ptr_offset(dst_nritems),
-			   btrfs_node_key_ptr_offset(0),
+			   btrfs_node_key_ptr_offset(dst, dst_nritems),
+			   btrfs_node_key_ptr_offset(src, 0),
 			   push_items * sizeof(struct btrfs_key_ptr));
 
 	if (push_items < src_nritems) {
@@ -2599,8 +2599,8 @@ static int push_node_left(struct btrfs_trans_handle *trans,
 		 * Don't call btrfs_tree_mod_log_insert_move() here, key removal
 		 * was already fully logged by btrfs_tree_mod_log_eb_copy() above.
 		 */
-		memmove_extent_buffer(src, btrfs_node_key_ptr_offset(0),
-				      btrfs_node_key_ptr_offset(push_items),
+		memmove_extent_buffer(src, btrfs_node_key_ptr_offset(src, 0),
+				      btrfs_node_key_ptr_offset(src, push_items),
 				      (src_nritems - push_items) *
 				      sizeof(struct btrfs_key_ptr));
 	}
@@ -2660,8 +2660,8 @@ static int balance_node_right(struct btrfs_trans_handle *trans,
 	}
 	ret = btrfs_tree_mod_log_insert_move(dst, push_items, 0, dst_nritems);
 	BUG_ON(ret < 0);
-	memmove_extent_buffer(dst, btrfs_node_key_ptr_offset(push_items),
-				      btrfs_node_key_ptr_offset(0),
+	memmove_extent_buffer(dst, btrfs_node_key_ptr_offset(dst, push_items),
+				      btrfs_node_key_ptr_offset(dst, 0),
 				      (dst_nritems) *
 				      sizeof(struct btrfs_key_ptr));
 
@@ -2672,8 +2672,8 @@ static int balance_node_right(struct btrfs_trans_handle *trans,
 		return ret;
 	}
 	copy_extent_buffer(dst, src,
-			   btrfs_node_key_ptr_offset(0),
-			   btrfs_node_key_ptr_offset(src_nritems - push_items),
+			   btrfs_node_key_ptr_offset(dst, 0),
+			   btrfs_node_key_ptr_offset(src, src_nritems - push_items),
 			   push_items * sizeof(struct btrfs_key_ptr));
 
 	btrfs_set_header_nritems(src, src_nritems - push_items);
@@ -2776,8 +2776,8 @@ static void insert_ptr(struct btrfs_trans_handle *trans,
 			BUG_ON(ret < 0);
 		}
 		memmove_extent_buffer(lower,
-			      btrfs_node_key_ptr_offset(slot + 1),
-			      btrfs_node_key_ptr_offset(slot),
+			      btrfs_node_key_ptr_offset(lower, slot + 1),
+			      btrfs_node_key_ptr_offset(lower, slot),
 			      (nritems - slot) * sizeof(struct btrfs_key_ptr));
 	}
 	if (level) {
@@ -2859,8 +2859,8 @@ static noinline int split_node(struct btrfs_trans_handle *trans,
 		return ret;
 	}
 	copy_extent_buffer(split, c,
-			   btrfs_node_key_ptr_offset(0),
-			   btrfs_node_key_ptr_offset(mid),
+			   btrfs_node_key_ptr_offset(split, 0),
+			   btrfs_node_key_ptr_offset(c, mid),
 			   (c_nritems - mid) * sizeof(struct btrfs_key_ptr));
 	btrfs_set_header_nritems(split, c_nritems - mid);
 	btrfs_set_header_nritems(c, mid);
@@ -4218,8 +4218,8 @@ static void del_ptr(struct btrfs_root *root, struct btrfs_path *path,
 			BUG_ON(ret < 0);
 		}
 		memmove_extent_buffer(parent,
-			      btrfs_node_key_ptr_offset(slot),
-			      btrfs_node_key_ptr_offset(slot + 1),
+			      btrfs_node_key_ptr_offset(parent, slot),
+			      btrfs_node_key_ptr_offset(parent, slot + 1),
 			      sizeof(struct btrfs_key_ptr) *
 			      (nritems - slot - 1));
 	} else if (level) {
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index e5935d761c04..56dbe58818e1 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2656,7 +2656,7 @@ static void prepare_eb_write(struct extent_buffer *eb)
 	/* Set btree blocks beyond nritems with 0 to avoid stale content */
 	nritems = btrfs_header_nritems(eb);
 	if (btrfs_header_level(eb) > 0) {
-		end = btrfs_node_key_ptr_offset(nritems);
+		end = btrfs_node_key_ptr_offset(eb, nritems);
 		memzero_extent_buffer(eb, end, eb->len - end);
 	} else {
 		/*
diff --git a/fs/btrfs/tree-mod-log.c b/fs/btrfs/tree-mod-log.c
index 3bea19698a10..5a1f0b3997fc 100644
--- a/fs/btrfs/tree-mod-log.c
+++ b/fs/btrfs/tree-mod-log.c
@@ -696,8 +696,8 @@ static void tree_mod_log_rewind(struct btrfs_fs_info *fs_info,
 			n--;
 			break;
 		case BTRFS_MOD_LOG_MOVE_KEYS:
-			o_dst = btrfs_node_key_ptr_offset(tm->slot);
-			o_src = btrfs_node_key_ptr_offset(tm->move.dst_slot);
+			o_dst = btrfs_node_key_ptr_offset(eb, tm->slot);
+			o_src = btrfs_node_key_ptr_offset(eb, tm->move.dst_slot);
 			memmove_extent_buffer(eb, o_dst, o_src,
 					      tm->move.nr_items * p_size);
 			break;
-- 
2.26.3

