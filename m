Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373044C0490
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Feb 2022 23:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236053AbiBVW1E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Feb 2022 17:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236049AbiBVW1D (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Feb 2022 17:27:03 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76B99F6F9
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 14:26:36 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id g24so1878747qkl.3
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 14:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=0YKRtHH8N6yEXI9lrqTPwiddnLCX/xQgxf7Mq763d74=;
        b=BbI8eQo4IqV8iQqF3c/f5F+Seq23+3Os7oGWiNWUUJm6ki3MSY2psUSBLptjTX9yMG
         4xM4GrOGtK86O0qEZRDF8i/IgEFX4b80NSSYD/Pm71Zvx/cr30DzuctXTrSaZ8kDX9ap
         mopI3Bv6KHoTrhOZU9UxkzpLNVVWLpx3dR10iRAAOFSl5Tn030G4SdLuG9BN7fmze+1b
         Tn1J+YylMeqtynCETvLpnP47Omy1B+y/OL4qpPXEqclTDbXj9C5v9CL6VD2AHOKrR1LU
         BRJjh5JzQ+ePPalNnKQUM7Ub8E9y7LV/AGTJi1b9HXls3eRzKK8gQ75GHgPW4fwn29qk
         jE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0YKRtHH8N6yEXI9lrqTPwiddnLCX/xQgxf7Mq763d74=;
        b=X6wb9AKZE2xUU+z1ofLUw6v8/4eqOv53zgvF9bEhSV6ARlNCTCSuMKOJXIzr/T4LEt
         4oS5Pdj5iWuW8Ka5gn53JaGxg/CdrgemqX1vwT/zN8kItw9Z3SuBVQNBai7w+QTaP7Sx
         g8hv/hx8vor48bmc7zOyLDt3xcJIjyIFD5ON78zYlS5seBhLtRjF99sZU+fbqbcal/PN
         2NHz0XWyS2sYeTxki5zbPeIe3UB398be/GNbszksnEmx1W9blc0or/+UHP+a1hjdfoKG
         GZC17PIwf80AMENzm6sgjVx7NSybcaT8Nb6unwXVWdx90bzCVRprB9hv3VPAfWcxIAI1
         m7Gg==
X-Gm-Message-State: AOAM531B/s7L88tSAdSa8PVg66yDU/Z91UziydIM2hZITKdvAx9MgvjM
        qpOT4bes4e5OKksOGNOlcW8KjISUcopz0WCw
X-Google-Smtp-Source: ABdhPJwUbMoLqyvvOogps81Opm+yLDyQFv60bZUtGnjbw4Vjy9vyE0rrvysEuoqJrX1Y/pIyUBkZdw==
X-Received: by 2002:a05:620a:4626:b0:63f:2610:a08e with SMTP id br38-20020a05620a462600b0063f2610a08emr12161189qkb.591.1645568795654;
        Tue, 22 Feb 2022 14:26:35 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p16sm744081qtx.55.2022.02.22.14.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 14:26:35 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 08/13] btrfs-progs: change btrfs_file_extent_inline_item_len to take a slot
Date:   Tue, 22 Feb 2022 17:26:18 -0500
Message-Id: <7e947492d34fcde5e316e4e03ca39d6d1ea65da1.1645568701.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1645568701.git.josef@toxicpanda.com>
References: <cover.1645568701.git.josef@toxicpanda.com>
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

This matches how the kernel does it, simply pass in the slot and fix up
btrfs_file_extent_inline_item_len to use the btrfs_item_nr() helper and
the correct define.  Fixup all the callers to use the slot now instead
of passing in the btrfs_item.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c               | 11 ++++-------
 check/mode-lowmem.c        |  7 ++-----
 cmds/inspect-tree-stats.c  |  3 +--
 cmds/restore.c             |  5 ++---
 image/main.c               |  4 +---
 kernel-shared/ctree.h      |  6 ++----
 kernel-shared/print-tree.c |  7 ++-----
 7 files changed, 14 insertions(+), 29 deletions(-)

diff --git a/check/main.c b/check/main.c
index 0bc42de7..fb0ef8cb 100644
--- a/check/main.c
+++ b/check/main.c
@@ -1604,20 +1604,18 @@ static int process_file_extent(struct btrfs_root *root,
 	compression = btrfs_file_extent_compression(eb, fi);
 
 	if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
-		struct btrfs_item *item = btrfs_item_nr(slot);
-
 		num_bytes = btrfs_file_extent_ram_bytes(eb, fi);
 		if (num_bytes == 0)
 			rec->errors |= I_ERR_BAD_FILE_EXTENT;
 		if (compression) {
-			if (btrfs_file_extent_inline_item_len(eb, item) >
+			if (btrfs_file_extent_inline_item_len(eb, slot) >
 			    max_inline_size ||
 			    num_bytes > gfs_info->sectorsize)
 				rec->errors |= I_ERR_FILE_EXTENT_TOO_LARGE;
 		} else {
 			if (num_bytes > max_inline_size)
 				rec->errors |= I_ERR_FILE_EXTENT_TOO_LARGE;
-			if (btrfs_file_extent_inline_item_len(eb, item) !=
+			if (btrfs_file_extent_inline_item_len(eb, slot) !=
 			    num_bytes)
 				rec->errors |= I_ERR_INLINE_RAM_BYTES_WRONG;
 		}
@@ -2625,7 +2623,6 @@ static int repair_inline_ram_bytes(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_key key;
 	struct btrfs_file_extent_item *fi;
-	struct btrfs_item *i;
 	u64 on_disk_item_len;
 	int ret;
 
@@ -2639,8 +2636,8 @@ static int repair_inline_ram_bytes(struct btrfs_trans_handle *trans,
 	if (ret < 0)
 		goto out;
 
-	i = btrfs_item_nr(path->slots[0]);
-	on_disk_item_len = btrfs_file_extent_inline_item_len(path->nodes[0], i);
+	on_disk_item_len = btrfs_file_extent_inline_item_len(path->nodes[0],
+							     path->slots[0]);
 	fi = btrfs_item_ptr(path->nodes[0], path->slots[0],
 			    struct btrfs_file_extent_item);
 	btrfs_set_file_extent_ram_bytes(path->nodes[0], fi, on_disk_item_len);
diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 0cdf24cd..729c453a 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -1877,7 +1877,6 @@ static int repair_inline_ram_bytes(struct btrfs_root *root,
 	struct btrfs_trans_handle *trans;
 	struct btrfs_key key;
 	struct btrfs_file_extent_item *fi;
-	struct btrfs_item *item;
 	u32 on_disk_data_len;
 	int ret;
 	int recover_ret;
@@ -1899,9 +1898,8 @@ static int repair_inline_ram_bytes(struct btrfs_root *root,
 	if (ret < 0)
 		goto recover;
 
-	item = btrfs_item_nr(path->slots[0]);
 	on_disk_data_len = btrfs_file_extent_inline_item_len(path->nodes[0],
-			item);
+							     path->slots[0]);
 
 	fi = btrfs_item_ptr(path->nodes[0], path->slots[0],
 			    struct btrfs_file_extent_item);
@@ -1943,7 +1941,6 @@ static int check_file_extent_inline(struct btrfs_root *root,
 	u32 max_inline_extent_size = min_t(u32, gfs_info->sectorsize - 1,
 				BTRFS_MAX_INLINE_DATA_SIZE(gfs_info));
 	struct extent_buffer *node = path->nodes[0];
-	struct btrfs_item *e = btrfs_item_nr(path->slots[0]);
 	struct btrfs_file_extent_item *fi;
 	struct btrfs_key fkey;
 	u64 extent_num_bytes;
@@ -1953,7 +1950,7 @@ static int check_file_extent_inline(struct btrfs_root *root,
 	int err = 0;
 
 	fi = btrfs_item_ptr(node, path->slots[0], struct btrfs_file_extent_item);
-	item_inline_len = btrfs_file_extent_inline_item_len(node, e);
+	item_inline_len = btrfs_file_extent_inline_item_len(node, path->slots[0]);
 	extent_num_bytes = btrfs_file_extent_ram_bytes(node, fi);
 	compressed = btrfs_file_extent_compression(node, fi);
 	btrfs_item_key_to_cpu(node, &fkey, path->slots[0]);
diff --git a/cmds/inspect-tree-stats.c b/cmds/inspect-tree-stats.c
index eeb57810..0731675c 100644
--- a/cmds/inspect-tree-stats.c
+++ b/cmds/inspect-tree-stats.c
@@ -121,8 +121,7 @@ static int walk_leaf(struct btrfs_root *root, struct btrfs_path *path,
 		fi = btrfs_item_ptr(b, i, struct btrfs_file_extent_item);
 		if (btrfs_file_extent_type(b, fi) == BTRFS_FILE_EXTENT_INLINE)
 			stat->total_inline +=
-				btrfs_file_extent_inline_item_len(b,
-							btrfs_item_nr(i));
+				btrfs_file_extent_inline_item_len(b, i);
 	}
 
 	return 0;
diff --git a/cmds/restore.c b/cmds/restore.c
index 48300ae5..bc88af70 100644
--- a/cmds/restore.c
+++ b/cmds/restore.c
@@ -302,7 +302,7 @@ static int copy_one_inline(struct btrfs_root *root, int fd,
 			    struct btrfs_file_extent_item);
 	ptr = btrfs_file_extent_inline_start(fi);
 	len = btrfs_file_extent_ram_bytes(leaf, fi);
-	inline_item_len = btrfs_file_extent_inline_item_len(leaf, btrfs_item_nr(path->slots[0]));
+	inline_item_len = btrfs_file_extent_inline_item_len(leaf, path->slots[0]);
 	read_extent_buffer(leaf, buf, ptr, inline_item_len);
 
 	compress = btrfs_file_extent_compression(leaf, fi);
@@ -834,8 +834,7 @@ static int copy_symlink(struct btrfs_root *root, struct btrfs_key *key,
 	extent_item = btrfs_item_ptr(leaf, path.slots[0],
 			struct btrfs_file_extent_item);
 
-	len = btrfs_file_extent_inline_item_len(leaf,
-			btrfs_item_nr(path.slots[0]));
+	len = btrfs_file_extent_inline_item_len(leaf, path.slots[0]);
 	if (len >= PATH_MAX) {
 		error("symlink '%s' target length %d is longer than PATH_MAX",
 				fs_name, len);
diff --git a/image/main.c b/image/main.c
index 09f60e63..5d67d282 100644
--- a/image/main.c
+++ b/image/main.c
@@ -302,7 +302,6 @@ static void zero_items(struct metadump_struct *md, u8 *dst,
 		       struct extent_buffer *src)
 {
 	struct btrfs_file_extent_item *fi;
-	struct btrfs_item *item;
 	struct btrfs_key key;
 	u32 nritems = btrfs_header_nritems(src);
 	size_t size;
@@ -310,7 +309,6 @@ static void zero_items(struct metadump_struct *md, u8 *dst,
 	int i, extent_type;
 
 	for (i = 0; i < nritems; i++) {
-		item = btrfs_item_nr(i);
 		btrfs_item_key_to_cpu(src, &key, i);
 		if (key.type == BTRFS_CSUM_ITEM_KEY) {
 			size = btrfs_item_size_nr(src, i);
@@ -334,7 +332,7 @@ static void zero_items(struct metadump_struct *md, u8 *dst,
 			continue;
 
 		ptr = btrfs_file_extent_inline_start(fi);
-		size = btrfs_file_extent_inline_item_len(src, item);
+		size = btrfs_file_extent_inline_item_len(src, i);
 		memset(dst + ptr, 0, size);
 	}
 }
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index cda05481..7fb66049 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -2564,11 +2564,9 @@ static inline u64 btrfs_dev_stats_value(const struct extent_buffer *eb,
  * the compressed size
  */
 static inline u32 btrfs_file_extent_inline_item_len(struct extent_buffer *eb,
-						    struct btrfs_item *e)
+						    int nr)
 {
-       unsigned long offset;
-       offset = offsetof(struct btrfs_file_extent_item, disk_bytenr);
-       return btrfs_item_size(eb, e) - offset;
+	return btrfs_item_size_nr(eb, nr) - BTRFS_FILE_EXTENT_INLINE_DATA_START;
 }
 
 /* struct btrfs_ioctl_search_header */
diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index 6e601779..aff2ebc4 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -365,7 +365,6 @@ static const char* file_extent_type_to_str(u8 type)
 }
 
 static void print_file_extent_item(struct extent_buffer *eb,
-				   struct btrfs_item *item,
 				   int slot,
 				   struct btrfs_file_extent_item *fi)
 {
@@ -381,7 +380,7 @@ static void print_file_extent_item(struct extent_buffer *eb,
 
 	if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
 		printf("\t\tinline extent data size %u ram_bytes %llu compression %hhu (%s)\n",
-				btrfs_file_extent_inline_item_len(eb, item),
+				btrfs_file_extent_inline_item_len(eb, slot),
 				btrfs_file_extent_ram_bytes(eb, fi),
 				btrfs_file_extent_compression(eb, fi),
 				compress_str);
@@ -1286,7 +1285,6 @@ static void print_header_info(struct extent_buffer *eb, unsigned int mode)
 
 void btrfs_print_leaf(struct extent_buffer *eb, unsigned int mode)
 {
-	struct btrfs_item *item;
 	struct btrfs_disk_key disk_key;
 	u32 leaf_data_size = BTRFS_LEAF_DATA_SIZE(eb->fs_info);
 	u32 i;
@@ -1319,7 +1317,6 @@ void btrfs_print_leaf(struct extent_buffer *eb, unsigned int mode)
 			error("skip remaining slots");
 			break;
 		}
-		item = btrfs_item_nr(i);
 		item_size = btrfs_item_size_nr(eb, i);
 		/* Untyped extraction of slot from btrfs_item_ptr */
 		ptr = btrfs_item_ptr(eb, i, void*);
@@ -1402,7 +1399,7 @@ void btrfs_print_leaf(struct extent_buffer *eb, unsigned int mode)
 			print_extent_csum(eb, item_size, offset, ptr, print_csum_items);
 			break;
 		case BTRFS_EXTENT_DATA_KEY:
-			print_file_extent_item(eb, item, i, ptr);
+			print_file_extent_item(eb, i, ptr);
 			break;
 		case BTRFS_BLOCK_GROUP_ITEM_KEY:
 			print_block_group_item(eb, ptr);
-- 
2.26.3

