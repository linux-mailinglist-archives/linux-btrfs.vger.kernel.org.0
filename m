Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 857B9225FA6
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jul 2020 14:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbgGTMvV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jul 2020 08:51:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:43974 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728779AbgGTMvS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jul 2020 08:51:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B10AFACA9;
        Mon, 20 Jul 2020 12:51:21 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Christian Zangl <coralllama@gmail.com>
Subject: [PATCH 1/2] btrfs-progs: convert: Prevent bit overflow for cctx->total_bytes
Date:   Mon, 20 Jul 2020 20:51:08 +0800
Message-Id: <20200720125109.93970-1-wqu@suse.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When convert is called on a 64GiB ext4 fs, it fails like this:

  $ btrfs-convert  /dev/loop0p1
  create btrfs filesystem:
          blocksize: 4096
          nodesize:  16384
          features:  extref, skinny-metadata (default)
          checksum:  crc32c
  creating ext2 image file
  ERROR: missing data block for bytenr 1048576
  ERROR: failed to create ext2_saved/image: -2
  WARNING: an error occurred during conversion, filesystem is partially created but not finalized and not mountable

Btrfs-convert also corrupts the source fs:
  $ LANG=C e2fsck /dev/loop0p1 -f
  e2fsck 1.45.6 (20-Mar-2020)
  Resize inode not valid.  Recreate<y>? yes
  Pass 1: Checking inodes, blocks, and sizes
  Deleted inode 3681 has zero dtime.  Fix<y>? yes
  Inodes that were part of a corrupted orphan linked list found.  Fix<y>? yes
  Inode 3744 was part of the orphaned inode list.  FIXED.
  Deleted inode 3745 has zero dtime.  Fix<y>? yes
  Inode 3747 has INLINE_DATA_FL flag on filesystem without inline data support.
  Clear<y>? yes
  ...

[CAUSE]
After some debugging, the first strange behavior is, the value of
cctx->total_bytes is 0 in ext2_open_fs().

It turns out that, the value assign for cctx->total_bytes could lead to
bit overflow for the unsigned int value.

And that 0 cctx->total_bytes leads to vairous problems for later free
space calculation.
For example, in calculate_available_space(), we use cctx->total_bytes to
ensure we won't create a data chunk beyond device end:

		cue_len = min(cctx->total_bytes - cur_off, cur_len);

If that cur_offset is also 0, we will create a cache_extent with 0 size,
which could cause a lot of problems for cache tree search.

[FIX]
Do manual casting for the multiply operation, so we could got a real u64
result.
The fix will be applied to all supported fses (ext* and reiserfs).

Reported-by: Christian Zangl <coralllama@gmail.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 convert/main.c            | 1 +
 convert/source-ext2.c     | 3 ++-
 convert/source-reiserfs.c | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/convert/main.c b/convert/main.c
index 7709e9a6c085..df6a2ae32722 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -1136,6 +1136,7 @@ static int do_convert(const char *devname, u32 convert_flags, u32 nodesize,
 	if (ret)
 		goto fail;
 
+	ASSERT(cctx.total_bytes);
 	blocksize = cctx.blocksize;
 	total_bytes = (u64)blocksize * (u64)cctx.block_count;
 	if (blocksize < 4096) {
diff --git a/convert/source-ext2.c b/convert/source-ext2.c
index f11ef651245a..a5e3a726863f 100644
--- a/convert/source-ext2.c
+++ b/convert/source-ext2.c
@@ -87,7 +87,8 @@ static int ext2_open_fs(struct btrfs_convert_context *cctx, const char *name)
 	cctx->fs_data = ext2_fs;
 	cctx->blocksize = ext2_fs->blocksize;
 	cctx->block_count = ext2_fs->super->s_blocks_count;
-	cctx->total_bytes = ext2_fs->blocksize * ext2_fs->super->s_blocks_count;
+	cctx->total_bytes = (u64)ext2_fs->blocksize *
+			    (u64)ext2_fs->super->s_blocks_count;
 	cctx->volume_name = strndup((char *)ext2_fs->super->s_volume_name, 16);
 	cctx->first_data_block = ext2_fs->super->s_first_data_block;
 	cctx->inodes_count = ext2_fs->super->s_inodes_count;
diff --git a/convert/source-reiserfs.c b/convert/source-reiserfs.c
index 9fd6b9abb9b4..8d9752f06ca9 100644
--- a/convert/source-reiserfs.c
+++ b/convert/source-reiserfs.c
@@ -82,7 +82,7 @@ static int reiserfs_open_fs(struct btrfs_convert_context *cxt, const char *name)
 	cxt->fs_data = fs;
 	cxt->blocksize = fs->fs_blocksize;
 	cxt->block_count = get_sb_block_count(fs->fs_ondisk_sb);
-	cxt->total_bytes = cxt->blocksize * cxt->block_count;
+	cxt->total_bytes = (u64)cxt->blocksize * (u64)cxt->block_count;
 	cxt->volume_name = strndup(fs->fs_ondisk_sb->s_label, 16);
 	cxt->first_data_block = 0;
 	cxt->inodes_count = reiserfs_count_objectids(fs);
-- 
2.27.0

