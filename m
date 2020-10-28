Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 678F629E31B
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 03:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729860AbgJ2CpY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Oct 2020 22:45:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:58246 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbgJ1Vdo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Oct 2020 17:33:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603869881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=73Q1XAdsFGmy0qR+eHlvhZ0IPSLSoj79+XTz1nqcVPY=;
        b=XNZhPJfR+uylo0I5bIVrgfonlivpwzciy3Iq21+YpDGbSHCTVDOb+dWllWjcIQgJ3/ShUD
        TpyecdyXpavCZswU9BMT6o2JnyLuBs6Za5SwXhu7kvM2STMkG4fuHIPpVgFdWVHdsxS6gX
        eTLDpldjPr3LPjmAuj8eURf0G2bzYDc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0C41DADDF
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Oct 2020 07:24:41 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: ordered-data: rename parameter @len to @nr_sectors
Date:   Wed, 28 Oct 2020 15:24:31 +0800
Message-Id: <20201028072432.86907-3-wqu@suse.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201028072432.86907-1-wqu@suse.com>
References: <20201028072432.86907-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The parameter is the number of sectors of the range to search.
While most "len" we used in other locations are in byte size, this can
lead to confusion.

Rename @len to @nr_sectors to make it more clear and avoid confusion.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ordered-data.c | 9 ++++++---
 fs/btrfs/ordered-data.h | 2 +-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index ebac13389e7e..10c13f8a1603 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -802,9 +802,11 @@ btrfs_lookup_first_ordered_extent(struct inode *inode, u64 file_offset)
  * search the ordered extents for one corresponding to 'offset' and
  * try to find a checksum.  This is used because we allow pages to
  * be reclaimed before their checksum is actually put into the btree
+ *
+ * @nr_sectors:	The length of the search range, in sectors.
  */
 int btrfs_find_ordered_sum(struct inode *inode, u64 offset, u64 disk_bytenr,
-			   u8 *sum, int len)
+			   u8 *sum, int nr_sectors)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_ordered_sum *ordered_sum;
@@ -828,12 +830,13 @@ int btrfs_find_ordered_sum(struct inode *inode, u64 offset, u64 disk_bytenr,
 			    inode->i_sb->s_blocksize_bits;
 			num_sectors = ordered_sum->len >>
 				      inode->i_sb->s_blocksize_bits;
-			num_sectors = min_t(int, len - index, num_sectors - i);
+			num_sectors = min_t(int, nr_sectors - index,
+					    num_sectors - i);
 			memcpy(sum + index, ordered_sum->sums + i * csum_size,
 			       num_sectors * csum_size);
 
 			index += (int)num_sectors * csum_size;
-			if (index == len)
+			if (index == nr_sectors)
 				goto out;
 			disk_bytenr += num_sectors * sectorsize;
 		}
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index d61ea9c880a3..3ffc1c27ee30 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -175,7 +175,7 @@ struct btrfs_ordered_extent *btrfs_lookup_ordered_range(
 		u64 file_offset,
 		u64 len);
 int btrfs_find_ordered_sum(struct inode *inode, u64 offset, u64 disk_bytenr,
-			   u8 *sum, int len);
+			   u8 *sum, int nr_sectors);
 u64 btrfs_wait_ordered_extents(struct btrfs_root *root, u64 nr,
 			       const u64 range_start, const u64 range_len);
 void btrfs_wait_ordered_roots(struct btrfs_fs_info *fs_info, u64 nr,
-- 
2.29.1

