Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 612C8CECEA
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2019 21:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbfJGTha (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 15:37:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:44408 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728971AbfJGTh3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 7 Oct 2019 15:37:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 67DC7AD7F;
        Mon,  7 Oct 2019 19:37:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C7FBCDA7FB; Mon,  7 Oct 2019 21:37:43 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 2/5] btrfs: get bdev from latest_dev for dio bh_result
Date:   Mon,  7 Oct 2019 21:37:43 +0200
Message-Id: <2ae45bba23d97e0d60d9949d9c65dbab9961cb34.1570474492.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570474492.git.dsterba@suse.com>
References: <cover.1570474492.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

To remove use of extent_map::bdev we need to find a replacement, and the
latest_bdev is the only one we can use here, because inode::i_bdev and
superblock::s_bdev are NULL.

The only thing that DIO code uses from the bdev is the blocksize to
perform alignment checks in do_blockdev_direct_IO, but we do them in
btrfs code before any call to DIO. We can't pass NULL because there are
dereferences of bdev in __blockdev_direct_IO, even though it's not going
to be used later.

So it's safe to pass any valid bdev that's used within the filesystem.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/inode.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 067cbd6e3923..8e085d21c3c5 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7603,6 +7603,8 @@ static int btrfs_get_blocks_direct_read(struct extent_map *em,
 					struct inode *inode,
 					u64 start, u64 len)
 {
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+
 	if (em->block_start == EXTENT_MAP_HOLE ||
 			test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
 		return -ENOENT;
@@ -7612,7 +7614,7 @@ static int btrfs_get_blocks_direct_read(struct extent_map *em,
 	bh_result->b_blocknr = (em->block_start + (start - em->start)) >>
 		inode->i_blkbits;
 	bh_result->b_size = len;
-	bh_result->b_bdev = em->bdev;
+	bh_result->b_bdev = fs_info->fs_devices->latest_bdev;
 	set_buffer_mapped(bh_result);
 
 	return 0;
@@ -7695,7 +7697,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 	bh_result->b_blocknr = (em->block_start + (start - em->start)) >>
 		inode->i_blkbits;
 	bh_result->b_size = len;
-	bh_result->b_bdev = em->bdev;
+	bh_result->b_bdev = fs_info->fs_devices->latest_bdev;
 	set_buffer_mapped(bh_result);
 
 	if (!test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
-- 
2.23.0

