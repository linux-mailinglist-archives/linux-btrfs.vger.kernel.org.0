Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078374D0B1F
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343776AbiCGWei (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343760AbiCGWeg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:34:36 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07987473BD
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:33:41 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id 85so5225491qkm.9
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=9bg6d5MpYuJ2RqMmHKgf+xALFufHhFb5OlRi+TMJgCw=;
        b=PIm5lTX1RU+cCXhkHxCrR5tLCvdX5IazeLtQYOjmAx0vrvKUPCZJFUXauK47oKRZHu
         WgeYqBkMOEF9SfaVktC6FdnwUlQSkIdNoIrSfP9MQUXqxYG9hBd14OBCqMRln0/BuH7y
         Vrrd/5gnvCotGiK03gGFWvx6S/L1LjLjF/Q84M2s9CvMrgRiiopbVPW+JVChR7Qpv7zb
         y7j3mjMqYIsVJlh7OhS7095dk5m4ubZpvVR86xI+Yddh2ybHwdIaiDOWb9SsoX57LkuI
         CE1/tQjpb+mh9xQnuBdr759rfKcZ3QZUnnlMq9aZO3NMQf/4Ye0J1A13S4ikeFNbJKVb
         73GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9bg6d5MpYuJ2RqMmHKgf+xALFufHhFb5OlRi+TMJgCw=;
        b=7ENGkcakEQpbevLCYLhVlCT/30jA2JX9yivBvgcBrsBLgFA+w0q326ZTs2e561Ql6n
         Ww/VRmKeute3W6/kBWnKMk60bOQmYBOSP4pZj2qm4Dg0QMwfopNa54sFcM0UAXopyasC
         YQn1GUOErOUmvHu7U9mF2xv6Pp8mNe+6usYNowZPvrlfTokaBtkpeTr/NTz6533z+tgz
         G1XKPa9PEgCbn2g1u1yBr6KjmV6qzco/pAIlOjdv7M0Ugze9B+uzoGxaMCRpA1f+cNoy
         qlC6MdLU4Y+//w3EGvQgoqKoPuo89WXkv5dlu3kl5C74g++PhEsoqxhLiadqkJX++Xom
         jagg==
X-Gm-Message-State: AOAM531JJjl19T5s9dgpgC2ZI/9qkzDFmxbjzDhVGJAlFpKkZbL2KC4S
        uyM+VxmwcAPDJ6lh7btOF9cPVa8ltiJaKImE
X-Google-Smtp-Source: ABdhPJzLY1BwydJAVU9EZiaYc0nWCx0VsiErgaYCGFz8p+YnH5etm5lxOKDlWL/Ft1iBtegYDz0b/Q==
X-Received: by 2002:a05:620a:4511:b0:67a:ee33:3c17 with SMTP id t17-20020a05620a451100b0067aee333c17mr8042720qkp.61.1646692419780;
        Mon, 07 Mar 2022 14:33:39 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n8-20020a05620a222800b004e0e071f382sm6542518qkh.125.2022.03.07.14.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:33:39 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 05/12] btrfs: pass eb to the node_key_ptr helpers
Date:   Mon,  7 Mar 2022 17:33:24 -0500
Message-Id: <8963cb7832d29b72e2324f3103ddb311a5463dd0.1646692306.git.josef@toxicpanda.com>
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

These helpers are going to require the eb in order to determine the size
of the header we need to use, so add the eb to the arguments and change
all of the callers to pass in the eb.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c        | 28 ++++++++++++++--------------
 fs/btrfs/ctree.h        | 20 +++++++++++---------
 fs/btrfs/extent_io.c    |  2 +-
 fs/btrfs/tree-mod-log.c |  4 ++--
 4 files changed, 28 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 2e270f8d995e..508bbc50fe8b 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2495,8 +2495,8 @@ static int push_node_left(struct btrfs_trans_handle *trans,
 		return ret;
 	}
 	copy_extent_buffer(dst, src,
-			   btrfs_node_key_ptr_offset(dst_nritems),
-			   btrfs_node_key_ptr_offset(0),
+			   btrfs_node_key_ptr_offset(dst, dst_nritems),
+			   btrfs_node_key_ptr_offset(src, 0),
 			   push_items * sizeof(struct btrfs_key_ptr));
 
 	if (push_items < src_nritems) {
@@ -2504,8 +2504,8 @@ static int push_node_left(struct btrfs_trans_handle *trans,
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
@@ -2565,8 +2565,8 @@ static int balance_node_right(struct btrfs_trans_handle *trans,
 	}
 	ret = btrfs_tree_mod_log_insert_move(dst, push_items, 0, dst_nritems);
 	BUG_ON(ret < 0);
-	memmove_extent_buffer(dst, btrfs_node_key_ptr_offset(push_items),
-				      btrfs_node_key_ptr_offset(0),
+	memmove_extent_buffer(dst, btrfs_node_key_ptr_offset(dst, push_items),
+				      btrfs_node_key_ptr_offset(dst, 0),
 				      (dst_nritems) *
 				      sizeof(struct btrfs_key_ptr));
 
@@ -2577,8 +2577,8 @@ static int balance_node_right(struct btrfs_trans_handle *trans,
 		return ret;
 	}
 	copy_extent_buffer(dst, src,
-			   btrfs_node_key_ptr_offset(0),
-			   btrfs_node_key_ptr_offset(src_nritems - push_items),
+			   btrfs_node_key_ptr_offset(dst, 0),
+			   btrfs_node_key_ptr_offset(src, src_nritems - push_items),
 			   push_items * sizeof(struct btrfs_key_ptr));
 
 	btrfs_set_header_nritems(src, src_nritems - push_items);
@@ -2681,8 +2681,8 @@ static void insert_ptr(struct btrfs_trans_handle *trans,
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
@@ -2764,8 +2764,8 @@ static noinline int split_node(struct btrfs_trans_handle *trans,
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
@@ -4106,8 +4106,8 @@ static void del_ptr(struct btrfs_root *root, struct btrfs_path *path,
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
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index f4f3d41775e6..53a8e200c953 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1961,50 +1961,52 @@ BTRFS_SETGET_STACK_FUNCS(stack_key_blockptr, struct btrfs_key_ptr,
 BTRFS_SETGET_STACK_FUNCS(stack_key_generation, struct btrfs_key_ptr,
 			 generation, 64);
 
-static inline unsigned long btrfs_node_key_ptr_offset(int nr)
+static inline unsigned long btrfs_node_key_ptr_offset(const struct extent_buffer *eb,
+						      int nr)
 {
 	return offsetof(struct btrfs_node, ptrs) +
 		sizeof(struct btrfs_key_ptr) * nr;
 }
 
-static inline struct btrfs_key_ptr *btrfs_node_key_ptr(int nr)
+static inline struct btrfs_key_ptr *btrfs_node_key_ptr(const struct extent_buffer *eb,
+						       int nr)
 {
-	return (struct btrfs_key_ptr *)btrfs_node_key_ptr_offset(nr);
+	return (struct btrfs_key_ptr *)btrfs_node_key_ptr_offset(eb, nr);
 }
 
 static inline u64 btrfs_node_blockptr(const struct extent_buffer *eb, int nr)
 {
-	return btrfs_key_blockptr(eb, btrfs_node_key_ptr(nr));
+	return btrfs_key_blockptr(eb, btrfs_node_key_ptr(eb, nr));
 }
 
 static inline void btrfs_set_node_blockptr(const struct extent_buffer *eb,
 					   int nr, u64 val)
 {
-	btrfs_set_key_blockptr(eb, btrfs_node_key_ptr(nr), val);
+	btrfs_set_key_blockptr(eb, btrfs_node_key_ptr(eb, nr), val);
 }
 
 static inline u64 btrfs_node_ptr_generation(const struct extent_buffer *eb, int nr)
 {
-	return btrfs_key_generation(eb, btrfs_node_key_ptr(nr));
+	return btrfs_key_generation(eb, btrfs_node_key_ptr(eb, nr));
 }
 
 static inline void btrfs_set_node_ptr_generation(const struct extent_buffer *eb,
 						 int nr, u64 val)
 {
-	btrfs_set_key_generation(eb, btrfs_node_key_ptr(nr), val);
+	btrfs_set_key_generation(eb, btrfs_node_key_ptr(eb, nr), val);
 }
 
 static inline void btrfs_node_key(const struct extent_buffer *eb,
 				  struct btrfs_disk_key *disk_key, int nr)
 {
-	read_eb_member(eb, btrfs_node_key_ptr(nr), struct btrfs_key_ptr, key,
+	read_eb_member(eb, btrfs_node_key_ptr(eb, nr), struct btrfs_key_ptr, key,
 		       disk_key);
 }
 
 static inline void btrfs_set_node_key(const struct extent_buffer *eb,
 				      struct btrfs_disk_key *disk_key, int nr)
 {
-	write_eb_member(eb, btrfs_node_key_ptr(nr), struct btrfs_key_ptr, key,
+	write_eb_member(eb, btrfs_node_key_ptr(eb, nr), struct btrfs_key_ptr, key,
 			disk_key);
 }
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c5334af2fae5..86a0dd3b55b0 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4500,7 +4500,7 @@ static void prepare_eb_write(struct extent_buffer *eb)
 	/* Set btree blocks beyond nritems with 0 to avoid stale content */
 	nritems = btrfs_header_nritems(eb);
 	if (btrfs_header_level(eb) > 0) {
-		end = btrfs_node_key_ptr_offset(nritems);
+		end = btrfs_node_key_ptr_offset(eb, nritems);
 		memzero_extent_buffer(eb, end, eb->len - end);
 	} else {
 		/*
diff --git a/fs/btrfs/tree-mod-log.c b/fs/btrfs/tree-mod-log.c
index 8a3a14686d3e..e73fc11c8887 100644
--- a/fs/btrfs/tree-mod-log.c
+++ b/fs/btrfs/tree-mod-log.c
@@ -694,8 +694,8 @@ static void tree_mod_log_rewind(struct btrfs_fs_info *fs_info,
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

