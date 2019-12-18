Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD2AD123C5A
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2019 02:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfLRBTz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 20:19:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:49736 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbfLRBTz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 20:19:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 10337ABCD
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2019 01:19:53 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/6] btrfs-progs: check/original: Do extra verification on file extent item
Date:   Wed, 18 Dec 2019 09:19:38 +0800
Message-Id: <20191218011942.9830-3-wqu@suse.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218011942.9830-1-wqu@suse.com>
References: <20191218011942.9830-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
For certain fuzzed image, `btrfs check` will fail with the following
call trace:
  Checking filesystem on issue_213.raw
  UUID: 99e50868-0bda-4d89-b0e4-7e8560312ef9
  [1/7] checking root items
  [2/7] checking extents
  Program received signal SIGABRT, Aborted.
  0x00007ffff7c88f25 in raise () from /usr/lib/libc.so.6
  (gdb) bt
  #0  0x00007ffff7c88f25 in raise () from /usr/lib/libc.so.6
  #1  0x00007ffff7c72897 in abort () from /usr/lib/libc.so.6
  #2  0x00005555555abc3e in run_next_block (...) at check/main.c:6398
  #3  0x00005555555b0f36 in deal_root_from_list (...) at check/main.c:8408
  #4  0x00005555555b1a3d in check_chunks_and_extents (fs_info=0x5555556a1e30) at check/main.c:8690
  #5  0x00005555555b1e3e in do_check_chunks_and_extents (fs_info=0x5555556a1e30) a
  #6  0x00005555555b5710 in cmd_check (cmd=0x555555696920 <cmd_struct_check>, argc
  #7  0x0000555555568dc7 in cmd_execute (cmd=0x555555696920 <cmd_struct_check>, ar
  #8  0x0000555555569713 in main (argc=2, argv=0x7fffffffde70) at btrfs.c:386

[CAUSE]
This fuzzed images has a corrupted EXTENT_DATA item in data reloc tree:
        item 1 key (256 EXTENT_DATA 256) itemoff 16111 itemsize 12
                generation 0 type 2 (prealloc)
                prealloc data disk byte 16777216 nr 0
                prealloc data offset 0 nr 0

There are several problems with the item:
- Bad item size
  12 is too small.
- Bad key offset
  offset of EXTENT_DATA type key represents file offset, which should
  always be aligned to sector size (4K in this particular case).

[FIX]
Do extra item size and key offset check for original mode, and remove
the abort() call in run_next_block().

And to show off how robust lowmem mode is, lowmem can handle it without
any hiccup.

With this fix, original mode can detect the problem properly:
  Checking filesystem on issue_213.raw
  UUID: 99e50868-0bda-4d89-b0e4-7e8560312ef9
  [1/7] checking root items
  [2/7] checking extents
  ERROR: invalid file extent item size, have 12 expect (21, 16283]
  ERROR: errors found in extent allocation tree or chunk allocation
  [3/7] checking free space cache
  [4/7] checking fs roots
  root 18446744073709551607 root dir 256 error
  root 18446744073709551607 inode 256 errors 62, no orphan item, odd file extent, bad file extent
  ERROR: errors found in fs roots
  found 131072 bytes used, error(s) found
  total csum bytes: 0
  total tree bytes: 131072
  total fs tree bytes: 32768
  total extent tree bytes: 16384
  btree space waste bytes: 124774
  file data blocks allocated: 0
   referenced 0

Issue: #213
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/check/main.c b/check/main.c
index 08dc9e66..91752dce 100644
--- a/check/main.c
+++ b/check/main.c
@@ -6268,7 +6268,10 @@ static int run_next_block(struct btrfs_root *root,
 		btree_space_waste += btrfs_leaf_free_space(buf);
 		for (i = 0; i < nritems; i++) {
 			struct btrfs_file_extent_item *fi;
+			unsigned long inline_offset;
 
+			inline_offset = offsetof(struct btrfs_file_extent_item,
+						 disk_bytenr);
 			btrfs_item_key_to_cpu(buf, &key, i);
 			/*
 			 * Check key type against the leaf owner.
@@ -6384,18 +6387,45 @@ static int run_next_block(struct btrfs_root *root,
 			}
 			if (key.type != BTRFS_EXTENT_DATA_KEY)
 				continue;
+			/* Check itemsize before we continue*/
+			if (btrfs_item_size_nr(buf, i) < inline_offset) {
+				ret = -EUCLEAN;
+				error(
+		"invalid file extent item size, have %u expect (%lu, %lu]",
+					btrfs_item_size_nr(buf, i),
+					inline_offset,
+					BTRFS_LEAF_DATA_SIZE(fs_info));
+				continue;
+			}
 			fi = btrfs_item_ptr(buf, i,
 					    struct btrfs_file_extent_item);
 			if (btrfs_file_extent_type(buf, fi) ==
 			    BTRFS_FILE_EXTENT_INLINE)
 				continue;
+
+			/* Prealloc/regular extent must have fixed item size */
+			if (btrfs_item_size_nr(buf, i) !=
+			    sizeof(struct btrfs_file_extent_item)) {
+				ret = -EUCLEAN;
+				error(
+			"invalid file extent item size, have %u expect %zu",
+					btrfs_item_size_nr(buf, i),
+					sizeof(struct btrfs_file_extent_item));
+				continue;
+			}
+			/* key.offset (file offset) must be aligned */
+			if (!IS_ALIGNED(key.offset, fs_info->sectorsize)) {
+				ret = -EUCLEAN;
+				error(
+			"invalid file offset, have %llu expect aligned to %u",
+					key.offset, fs_info->sectorsize);
+				continue;
+			}
 			if (btrfs_file_extent_disk_bytenr(buf, fi) == 0)
 				continue;
 
 			data_bytes_allocated +=
 				btrfs_file_extent_disk_num_bytes(buf, fi);
-			if (data_bytes_allocated < root->fs_info->sectorsize)
-				abort();
 
 			data_bytes_referenced +=
 				btrfs_file_extent_num_bytes(buf, fi);
-- 
2.24.1

