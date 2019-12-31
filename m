Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0F4D12D6C6
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Dec 2019 08:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbfLaHMb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Dec 2019 02:12:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:46476 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbfLaHMa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Dec 2019 02:12:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 51BD5B168
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Dec 2019 07:12:29 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/5] btrfs-progs: check/lowmem: Detect invalid EXTENT_ITEM and EXTENT_DATA generation
Date:   Tue, 31 Dec 2019 15:12:18 +0800
Message-Id: <20191231071220.32935-4-wqu@suse.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191231071220.32935-1-wqu@suse.com>
References: <20191231071220.32935-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since older `btrfs check --init-extent-tree` could cause invalid
EXTENT_ITEM generation for data extents, add such check to lowmem mode
check.

Also add such generation check to file extents too.

For the repair part, I don't have any good idea yet. So affected user
may depend on --init-extent-tree again.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/mode-lowmem.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index f53a0c39..aad30c28 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -2041,6 +2041,8 @@ static int check_file_extent(struct btrfs_root *root, struct btrfs_path *path,
 	u64 csum_found;		/* In byte size, sectorsize aligned */
 	u64 search_start;	/* Logical range start we search for csum */
 	u64 search_len;		/* Logical range len we search for csum */
+	u64 gen;
+	u64 super_gen = btrfs_super_generation(root->fs_info->super_copy);
 	unsigned int extent_type;
 	unsigned int is_hole;
 	int slot = path->slots[0];
@@ -2067,6 +2069,7 @@ static int check_file_extent(struct btrfs_root *root, struct btrfs_path *path,
 		return check_file_extent_inline(root, path, size, end);
 
 	/* Check REG_EXTENT/PREALLOC_EXTENT */
+	gen = btrfs_file_extent_generation(node, fi);
 	disk_bytenr = btrfs_file_extent_disk_bytenr(node, fi);
 	disk_num_bytes = btrfs_file_extent_disk_num_bytes(node, fi);
 	extent_num_bytes = btrfs_file_extent_num_bytes(node, fi);
@@ -2074,6 +2077,13 @@ static int check_file_extent(struct btrfs_root *root, struct btrfs_path *path,
 	compressed = btrfs_file_extent_compression(node, fi);
 	is_hole = (disk_bytenr == 0) && (disk_num_bytes == 0);
 
+	if (gen > super_gen + 1) {
+		error(
+		"vainlid file extent generation, have %llu expect (0, %llu]",
+			gen, super_gen + 1);
+		err |= INVALID_GENERATION;
+	}
+
 	/*
 	 * Check EXTENT_DATA csum
 	 *
@@ -4152,8 +4162,10 @@ static int check_extent_item(struct btrfs_fs_info *fs_info,
 	u64 parent;
 	u64 num_bytes;
 	u64 root_objectid;
+	u64 gen;
 	u64 owner;
 	u64 owner_offset;
+	u64 super_gen = btrfs_super_generation(fs_info->super_copy);
 	int metadata = 0;
 	int level;
 	struct btrfs_key key;
@@ -4183,6 +4195,13 @@ static int check_extent_item(struct btrfs_fs_info *fs_info,
 
 	ei = btrfs_item_ptr(eb, slot, struct btrfs_extent_item);
 	flags = btrfs_extent_flags(eb, ei);
+	gen = btrfs_extent_generation(eb, ei);
+	if (gen > super_gen + 1) {
+		error(
+		"invalid generation for extent %llu, have %llu expect (0, %llu]",
+			key.objectid, gen, super_gen + 1);
+		err |= INVALID_GENERATION;
+	}
 
 	if (flags & BTRFS_EXTENT_FLAG_TREE_BLOCK)
 		metadata = 1;
-- 
2.24.1

