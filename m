Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D10F6EDFA2
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2019 13:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbfKDMEY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Nov 2019 07:04:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:44048 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728592AbfKDMEX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 Nov 2019 07:04:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BFC46AF6A
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Nov 2019 12:04:21 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 5/7] btrfs-progs: Refactor btrfs_new_block_group_record() to accept parameters directly
Date:   Mon,  4 Nov 2019 20:03:59 +0800
Message-Id: <20191104120401.56408-6-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104120401.56408-1-wqu@suse.com>
References: <20191104120401.56408-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently btrfs_new_block_group_record() needs to extract numbers from
key and block group item manually.

This is not generic enough to handle skinny-bg-tree feature.
So change let btrfs_new_block_group_record() to accept @bytenr, @len and
@flags directly, so later skinny-bg-tree feature can reuse it in
original mode.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 btrfsck.h                   |  4 ++--
 check/common.h              |  4 ++--
 check/main.c                | 25 +++++++++++++------------
 cmds/rescue-chunk-recover.c |  6 +++++-
 4 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/btrfsck.h b/btrfsck.h
index ac7f5d488b5a..be811a133687 100644
--- a/btrfsck.h
+++ b/btrfsck.h
@@ -189,8 +189,8 @@ struct chunk_record *btrfs_new_chunk_record(struct extent_buffer *leaf,
 					    struct btrfs_key *key,
 					    int slot);
 struct block_group_record *
-btrfs_new_block_group_record(struct extent_buffer *leaf, struct btrfs_key *key,
-			     int slot);
+btrfs_new_block_group_record(struct extent_buffer *leaf, u64 bytenr, u64 len,
+			     u64 flags);
 struct device_extent_record *
 btrfs_new_device_extent_record(struct extent_buffer *leaf,
 			       struct btrfs_key *key, int slot);
diff --git a/check/common.h b/check/common.h
index 62cdc1d934c7..ff206f27c304 100644
--- a/check/common.h
+++ b/check/common.h
@@ -166,8 +166,8 @@ struct chunk_record *btrfs_new_chunk_record(struct extent_buffer *leaf,
 					    struct btrfs_key *key,
 					    int slot);
 struct block_group_record *
-btrfs_new_block_group_record(struct extent_buffer *leaf, struct btrfs_key *key,
-			     int slot);
+btrfs_new_block_group_record(struct extent_buffer *leaf, u64 bytenr, u64 len,
+			     u64 flags);
 struct device_extent_record *
 btrfs_new_device_extent_record(struct extent_buffer *leaf,
 			       struct btrfs_key *key, int slot);
diff --git a/check/main.c b/check/main.c
index a0e5ac47c152..a1261ce0ebe7 100644
--- a/check/main.c
+++ b/check/main.c
@@ -5193,10 +5193,9 @@ static int process_device_item(struct rb_root *dev_cache,
 }
 
 struct block_group_record *
-btrfs_new_block_group_record(struct extent_buffer *leaf, struct btrfs_key *key,
-			     int slot)
+btrfs_new_block_group_record(struct extent_buffer *leaf, u64 bytenr, u64 len,
+			     u64 flags)
 {
-	struct btrfs_block_group_item *ptr;
 	struct block_group_record *rec;
 
 	rec = calloc(1, sizeof(*rec));
@@ -5205,17 +5204,15 @@ btrfs_new_block_group_record(struct extent_buffer *leaf, struct btrfs_key *key,
 		exit(-1);
 	}
 
-	rec->cache.start = key->objectid;
-	rec->cache.size = key->offset;
+	rec->cache.start = bytenr;
+	rec->cache.size = len;
 
 	rec->generation = btrfs_header_generation(leaf);
 
-	rec->objectid = key->objectid;
-	rec->type = key->type;
-	rec->offset = key->offset;
-
-	ptr = btrfs_item_ptr(leaf, slot, struct btrfs_block_group_item);
-	rec->flags = btrfs_disk_block_group_flags(leaf, ptr);
+	rec->objectid = bytenr;
+	rec->type = BTRFS_BLOCK_GROUP_ITEM_KEY;
+	rec->offset = len;
+	rec->flags = flags;
 
 	INIT_LIST_HEAD(&rec->list);
 
@@ -5226,10 +5223,14 @@ static int process_block_group_item(struct block_group_tree *block_group_cache,
 				    struct btrfs_key *key,
 				    struct extent_buffer *eb, int slot)
 {
+	struct btrfs_block_group_item bgi;
 	struct block_group_record *rec;
 	int ret = 0;
 
-	rec = btrfs_new_block_group_record(eb, key, slot);
+	read_extent_buffer(eb, &bgi, btrfs_item_ptr_offset(eb, slot),
+			   sizeof(bgi));
+	rec = btrfs_new_block_group_record(eb, key->objectid, key->offset,
+					   btrfs_block_group_flags(&bgi));
 	ret = insert_block_group_record(block_group_cache, rec);
 	if (ret) {
 		fprintf(stderr, "Block Group[%llu, %llu] existed.\n",
diff --git a/cmds/rescue-chunk-recover.c b/cmds/rescue-chunk-recover.c
index 22d7a5959531..cd575668f89e 100644
--- a/cmds/rescue-chunk-recover.c
+++ b/cmds/rescue-chunk-recover.c
@@ -226,12 +226,16 @@ static int process_block_group_item(struct block_group_tree *bg_cache,
 				    struct extent_buffer *leaf,
 				    struct btrfs_key *key, int slot)
 {
+	struct btrfs_block_group_item bgi;
 	struct block_group_record *rec;
 	struct block_group_record *exist;
 	struct cache_extent *cache;
 	int ret = 0;
 
-	rec = btrfs_new_block_group_record(leaf, key, slot);
+	read_extent_buffer(leaf, &bgi, btrfs_item_ptr_offset(leaf, slot),
+			   sizeof(bgi));
+	rec = btrfs_new_block_group_record(leaf, key->objectid, key->offset,
+					   btrfs_block_group_flags(&bgi));
 	if (!rec->cache.size)
 		goto free_out;
 again:
-- 
2.23.0

