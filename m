Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA2C526163
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 May 2022 13:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358530AbiEMLw0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 May 2022 07:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234797AbiEMLwY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 May 2022 07:52:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7812F16D109
        for <linux-btrfs@vger.kernel.org>; Fri, 13 May 2022 04:52:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 145A721AF8
        for <linux-btrfs@vger.kernel.org>; Fri, 13 May 2022 11:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652442742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=/eFmPSFl89eRCY/sN4WTu6pQMilbXgNJPcFZyQL50MI=;
        b=YTNvc4Zspz0sWtoop2e0JL681fGc62a6Pa1xqPH/l13Bmkay3wRXVQj9vO6LttdkWyvyC4
        0/D3Ka59LwO66zSQIIra7Xe2E9z24uf51BuDV1+qfVpCsWuOscy1ol/yva7PQyWGytacNa
        uQrdxqdkD/yG/9x+y7VQnD6xrMZWxWo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9678913A84
        for <linux-btrfs@vger.kernel.org>; Fri, 13 May 2022 11:52:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EanKGHRGfmLZQwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 13 May 2022 11:52:20 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: removed unused header check/btrfsck.h
Date:   Fri, 13 May 2022 19:52:01 +0800
Message-Id: <5675e197da96530f011d40102b0e4dc8c88322b7.1652442718.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It should have been deleted, as CHANGES mentioned this in v5.14, but
obvious it's not.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/btrfsck.h | 196 ------------------------------------------------
 1 file changed, 196 deletions(-)
 delete mode 100644 check/btrfsck.h

diff --git a/check/btrfsck.h b/check/btrfsck.h
deleted file mode 100644
index 112c5406633c..000000000000
--- a/check/btrfsck.h
+++ /dev/null
@@ -1,196 +0,0 @@
-/*
- * Copyright (C) 2013 FUJITSU LIMITED.  All rights reserved.
- * Written by Miao Xie <miaox@cn.fujitsu.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public
- * License v2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public
- * License along with this program; if not, write to the
- * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
- * Boston, MA 021110-1307, USA.
- */
-
-#ifndef __BTRFS_CHECK_H__
-#define __BTRFS_CHECK_H__
-
-#include "kerncompat.h"
-#include "kernel-shared/ctree.h"
-#include "common/extent-cache.h"
-#include "kernel-lib/list.h"
-
-struct block_group_record {
-	struct cache_extent cache;
-	/* Used to identify the orphan block groups */
-	struct list_head list;
-
-	u64 generation;
-
-	u64 objectid;
-	u8  type;
-	u64 offset;
-
-	u64 flags;
-};
-
-struct block_group_tree {
-	struct cache_tree tree;
-	struct list_head block_groups;
-};
-
-struct device_record {
-	struct rb_node node;
-	u64 devid;
-
-	u64 generation;
-
-	u64 objectid;
-	u8  type;
-	u64 offset;
-
-	u64 total_byte;
-	u64 byte_used;
-
-	u64 real_used;
-};
-
-struct stripe {
-	u64 devid;
-	u64 offset;
-	u8 dev_uuid[BTRFS_UUID_SIZE];
-};
-
-struct chunk_record {
-	struct cache_extent cache;
-
-	struct list_head list;
-	struct list_head dextents;
-	struct block_group_record *bg_rec;
-
-	u64 generation;
-
-	u64 objectid;
-	u8  type;
-	u64 offset;
-
-	u64 owner;
-	u64 length;
-	u64 type_flags;
-	u64 stripe_len;
-	u16 num_stripes;
-	u16 sub_stripes;
-	u32 io_align;
-	u32 io_width;
-	u32 sector_size;
-	struct stripe stripes[0];
-};
-
-struct device_extent_record {
-	struct cache_extent cache;
-	/*
-	 * Used to identify the orphan device extents (the device extents
-	 * don't belong to a chunk or a device)
-	 */
-	struct list_head chunk_list;
-	struct list_head device_list;
-
-	u64 generation;
-
-	u64 objectid;
-	u8  type;
-	u64 offset;
-
-	u64 chunk_objectid;
-	u64 chunk_offset;
-	u64 length;
-};
-
-struct device_extent_tree {
-	struct cache_tree tree;
-	/*
-	 * The idea is:
-	 * When checking the chunk information, we move the device extents
-	 * that has its chunk to the chunk's device extents list. After the
-	 * check, if there are still some device extents in no_chunk_orphans,
-	 * it means there are some device extents which don't belong to any
-	 * chunk.
-	 *
-	 * The usage of no_device_orphans is the same as the first one, but it
-	 * is for the device information check.
-	 */
-	struct list_head no_chunk_orphans;
-	struct list_head no_device_orphans;
-};
-
-static inline unsigned long btrfs_chunk_record_size(int num_stripes)
-{
-	return sizeof(struct chunk_record) +
-	       sizeof(struct stripe) * num_stripes;
-}
-void free_chunk_cache_tree(struct cache_tree *chunk_cache);
-
-/*
- * Function to check validation for num_stripes, or it can call
- * float point error for 0 division
- * return < 0 for invalid combination
- * return 0 for valid combination
- */
-static inline int check_num_stripes(u64 type, int num_stripes)
-{
-	if (num_stripes == 0)
-		return -1;
-	if (type & BTRFS_BLOCK_GROUP_RAID5 && num_stripes <= 1)
-		return -1;
-	if (type & BTRFS_BLOCK_GROUP_RAID6 && num_stripes <= 2)
-		return -1;
-	return 0;
-}
-
-u64 calc_stripe_length(u64 type, u64 length, int num_stripes);
-/* For block group tree */
-static inline void block_group_tree_init(struct block_group_tree *tree)
-{
-	cache_tree_init(&tree->tree);
-	INIT_LIST_HEAD(&tree->block_groups);
-}
-
-int insert_block_group_record(struct block_group_tree *tree,
-			      struct block_group_record *bg_rec);
-void free_block_group_tree(struct block_group_tree *tree);
-
-/* For device extent tree */
-static inline void device_extent_tree_init(struct device_extent_tree *tree)
-{
-	cache_tree_init(&tree->tree);
-	INIT_LIST_HEAD(&tree->no_chunk_orphans);
-	INIT_LIST_HEAD(&tree->no_device_orphans);
-}
-
-int insert_device_extent_record(struct device_extent_tree *tree,
-				struct device_extent_record *de_rec);
-void free_device_extent_tree(struct device_extent_tree *tree);
-
-
-/* Create various in-memory record by on-disk data */
-struct chunk_record *btrfs_new_chunk_record(struct extent_buffer *leaf,
-					    struct btrfs_key *key,
-					    int slot);
-struct block_group_record *
-btrfs_new_block_group_record(struct extent_buffer *leaf, struct btrfs_key *key,
-			     int slot);
-struct device_extent_record *
-btrfs_new_device_extent_record(struct extent_buffer *leaf,
-			       struct btrfs_key *key, int slot);
-
-int check_chunks(struct cache_tree *chunk_cache,
-		 struct block_group_tree *block_group_cache,
-		 struct device_extent_tree *dev_extent_cache,
-		 struct list_head *good, struct list_head *bad,
-		 struct list_head *rebuild, int silent);
-#endif
-- 
2.36.1

