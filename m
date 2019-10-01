Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF028C3F0A
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2019 19:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731005AbfJARwU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Oct 2019 13:52:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:60198 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730979AbfJARwT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 1 Oct 2019 13:52:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2E0FCB1B9;
        Tue,  1 Oct 2019 17:52:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0AAFBDA88C; Tue,  1 Oct 2019 19:52:36 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 2/2] btrfs: use has_single_bit_set for clarity
Date:   Tue,  1 Oct 2019 19:52:35 +0200
Message-Id: <aa25f813ffd891f64d2b5204e561a0f5b1c6ec50.1569951996.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1569951996.git.dsterba@suse.com>
References: <cover.1569951996.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Replace is_power_of_2 with the helper that is self-documenting and
remove the open coded call in alloc_profile_is_valid.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/tree-checker.c | 15 ++++++++-------
 fs/btrfs/volumes.c      |  7 +------
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index f28f9725cef1..b8f82d9be9f0 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -23,6 +23,7 @@
 #include "disk-io.h"
 #include "compression.h"
 #include "volumes.h"
+#include "misc.h"
 
 /*
  * Error message should follow the following format:
@@ -630,7 +631,7 @@ int btrfs_check_chunk_valid(struct extent_buffer *leaf,
 		return -EUCLEAN;
 	}
 
-	if (!is_power_of_2(type & BTRFS_BLOCK_GROUP_PROFILE_MASK) &&
+	if (!has_single_bit_set(type & BTRFS_BLOCK_GROUP_PROFILE_MASK) &&
 	    (type & BTRFS_BLOCK_GROUP_PROFILE_MASK) != 0) {
 		chunk_err(leaf, chunk, logical,
 		"invalid chunk profile flag: 0x%llx, expect 0 or 1 bit set",
@@ -814,11 +815,11 @@ static int check_inode_item(struct extent_buffer *leaf,
 	}
 
 	/*
-	 * S_IFMT is not bit mapped so we can't completely rely on is_power_of_2,
-	 * but is_power_of_2() can save us from checking FIFO/CHR/DIR/REG.
-	 * Only needs to check BLK, LNK and SOCKS
+	 * S_IFMT is not bit mapped so we can't completely rely on
+	 * is_power_of_2/has_single_bit_set, but it can save us from checking
+	 * FIFO/CHR/DIR/REG.  Only needs to check BLK, LNK and SOCKS
 	 */
-	if (!is_power_of_2(mode & S_IFMT)) {
+	if (!has_single_bit_set(mode & S_IFMT)) {
 		if (!S_ISLNK(mode) && !S_ISBLK(mode) && !S_ISSOCK(mode)) {
 			inode_item_err(fs_info, leaf, slot,
 			"invalid mode: has 0%o expect valid S_IF* bit(s)",
@@ -1039,8 +1040,8 @@ static int check_extent_item(struct extent_buffer *leaf,
 			   btrfs_super_generation(fs_info->super_copy) + 1);
 		return -EUCLEAN;
 	}
-	if (!is_power_of_2(flags & (BTRFS_EXTENT_FLAG_DATA |
-				    BTRFS_EXTENT_FLAG_TREE_BLOCK))) {
+	if (!has_single_bit_set(flags & (BTRFS_EXTENT_FLAG_DATA |
+					 BTRFS_EXTENT_FLAG_TREE_BLOCK))) {
 		extent_err(leaf, slot,
 		"invalid extent flag, have 0x%llx expect 1 bit set in 0x%llx",
 			flags, BTRFS_EXTENT_FLAG_DATA |
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index db13f7ae2c12..f0ff1c34eda1 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3844,12 +3844,7 @@ static int alloc_profile_is_valid(u64 flags, int extended)
 	if (flags == 0)
 		return !extended; /* "0" is valid for usual profiles */
 
-	/* true if exactly one bit set */
-	/*
-	 * Don't use is_power_of_2(unsigned long) because it won't work
-	 * for the single profile (1ULL << 48) on 32-bit CPUs.
-	 */
-	return flags != 0 && (flags & (flags - 1)) == 0;
+	return has_single_bit_set(flags);
 }
 
 static inline int balance_need_close(struct btrfs_fs_info *fs_info)
-- 
2.23.0

