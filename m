Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB1AD395785
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 May 2021 10:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbhEaIxv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 May 2021 04:53:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:41508 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231172AbhEaIxl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 May 2021 04:53:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622451121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8MLhAvYuwDU6vws7oow0Ndh/f7C4oFYU0y0qdMnjAq8=;
        b=Hd9RRWnZyINa71V81jlLloqktoclc5WJIFX25WQUeYHZGoCV5o4r+r/DARo7osn2gQyB/W
        +wKQfLZXXylq7ri8jM1K1G+Gswk/+RZLpASSVahOwly2SToMPg0SeWtevpSBC0hR/QZtkg
        03jKskq7qug6HTT3hdIJTRMS2MJthrk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EC936B2E9
        for <linux-btrfs@vger.kernel.org>; Mon, 31 May 2021 08:52:00 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 28/30] btrfs: fix a subpage false alert for relocating partial preallocated data extents
Date:   Mon, 31 May 2021 16:51:04 +0800
Message-Id: <20210531085106.259490-29-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210531085106.259490-1-wqu@suse.com>
References: <20210531085106.259490-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When relocating partial preallocated data extents (part of the
preallocated extent is written) for subpage, it can cause the following
false alert and make the relocation to fail:

  BTRFS info (device dm-3): balance: start -d
  BTRFS info (device dm-3): relocating block group 13631488 flags data
  BTRFS warning (device dm-3): csum failed root -9 ino 257 off 4096 csum 0x98757625 expected csum 0x00000000 mirror 1
  BTRFS error (device dm-3): bdev /dev/mapper/arm_nvme-test errs: wr 0, rd 0, flush 0, corrupt 1, gen 0
  BTRFS warning (device dm-3): csum failed root -9 ino 257 off 4096 csum 0x98757625 expected csum 0x00000000 mirror 1
  BTRFS error (device dm-3): bdev /dev/mapper/arm_nvme-test errs: wr 0, rd 0, flush 0, corrupt 2, gen 0
  BTRFS info (device dm-3): balance: ended with status: -5

The minimal script to reproduce looks like this:

  mkfs.btrfs -f -s 4k $dev
  mount $dev -o nospace_cache $mnt
  xfs_io -f -c "falloc 0 8k" $mnt/file
  xfs_io -f -c "pwrite 0 4k" $mnt/file
  btrfs balance start -d $mnt

[CAUSE]
Function btrfs_verify_data_csum() checks if the full range has
EXTENT_NODATASUM bit for data reloc inode, if *all* bytes of the range
has EXTENT_NODATASUM bit, then it skip the range.

This works pretty well for regular sectorsize, as in that case
btrfs_verify_data_csum() is called for each sector, thus no problem at
all.

But for subpage case, btrfs_verify_data_csum() is called on each bvec,
which can contain several sectors, and since it checks *all* bytes for
EXTENT_NODATASUM bit, if we have some range with csum, then we will
continue checking all the sectors.

For the preallocated sectors, it doesn't have any csum, thus obviously
the csum won't match and cause the false alert.

[FIX]
Move the EXTENT_NODATASUM check into the main loop, so that we can check
each sector for EXTENT_NODATASUM bit for subpage case.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d3c67411f683..85f465328ab2 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3188,19 +3188,24 @@ unsigned int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u32 bio_offset,
 	if (!root->fs_info->csum_root)
 		return 0;
 
-	if (root->root_key.objectid == BTRFS_DATA_RELOC_TREE_OBJECTID &&
-	    test_range_bit(io_tree, start, end, EXTENT_NODATASUM, 1, NULL)) {
-		clear_extent_bits(io_tree, start, end, EXTENT_NODATASUM);
-		return 0;
-	}
-
 	ASSERT(page_offset(page) <= start &&
 	       end <= page_offset(page) + PAGE_SIZE - 1);
 	for (pg_off = offset_in_page(start);
 	     pg_off < offset_in_page(end);
 	     pg_off += sectorsize, bio_offset += sectorsize) {
+		u64 file_offset = pg_off + page_offset(page);
 		int ret;
 
+		if (root->root_key.objectid == BTRFS_DATA_RELOC_TREE_OBJECTID &&
+		    test_range_bit(io_tree, file_offset,
+				   file_offset + sectorsize - 1,
+				   EXTENT_NODATASUM, 1, NULL)) {
+			/* Skip the range without csum for data reloc inode */
+			clear_extent_bits(io_tree, file_offset,
+					  file_offset + sectorsize - 1,
+					  EXTENT_NODATASUM);
+			continue;
+		}
 		ret = check_data_csum(inode, io_bio, bio_offset, page, pg_off,
 				      page_offset(page) + pg_off);
 		if (ret < 0) {
-- 
2.31.1

