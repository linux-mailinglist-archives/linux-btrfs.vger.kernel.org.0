Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCCE3D533A
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 08:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbhGZFzD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 01:55:03 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35664 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbhGZFzD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 01:55:03 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D0B4B1FE46
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Jul 2021 06:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627281331; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VkeKobQ96Nq/EoIPp7DD7L8zTPyLy6qunomdOJhVfJg=;
        b=Lyw/MCPJjZSrAZ9EcEqNGKun+28Q2RnNv6GLBPB1Av65cnSa7o3EW/+COJtaMdVH53pgKb
        RzaR8PH1DSKoZy5mvB4f+dkGzSOF4UrQClsntkQU8lzvJPa6XkNkMzJpeLfaVxNxJ3n0RZ
        LCh21rjOa9cIrQaKdWUeEaaU/DFyeJU=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 126771365C
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Jul 2021 06:35:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id YHslMbJX/mCXBQAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Jul 2021 06:35:30 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v8 15/18] btrfs: fix a subpage false alert for relocating partial preallocated data extents
Date:   Mon, 26 Jul 2021 14:35:04 +0800
Message-Id: <20210726063507.160396-16-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210726063507.160396-1-wqu@suse.com>
References: <20210726063507.160396-1-wqu@suse.com>
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
index 4e4f39a75564..a20500357c68 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3290,19 +3290,24 @@ unsigned int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u32 bio_offset,
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
2.32.0

