Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31233AC4F6
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jun 2021 09:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbhFRH1n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Jun 2021 03:27:43 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60618 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbhFRH1j (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Jun 2021 03:27:39 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 66DD321AAE;
        Fri, 18 Jun 2021 07:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624001130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NiPr8EftLpJebEM8QdozW8FLL9nbwyYgcBowic4Ox3o=;
        b=sRMiTkHCT2l4gxpvx0QJbDCIzsAOvZ9/siPjfGTj25+gFcv3gfHwExMiTcW0lo1ack19ne
        aTzIlS52CgkhOgff5uD6wm0IXCIQqdtR/AcR/gtawAJHoCQ9zzl2Ls1N7rRmuLgo94Gcy3
        2mdI8Eccus1rZgZ4HVOIXT8B0zSZ6N8=
Received: from adam-pc.lan (unknown [10.163.16.38])
        by relay2.suse.de (Postfix) with ESMTP id CCC9BA3BD3;
        Fri, 18 Jun 2021 07:25:27 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH v5 10/11] btrfs: fix a subpage relocation data corruption
Date:   Fri, 18 Jun 2021 15:24:36 +0800
Message-Id: <20210618072437.207550-11-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618072437.207550-1-wqu@suse.com>
References: <20210618072437.207550-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When using the following script, btrfs will report data corruption after
one data balance with subpage support:

  mkfs.btrfs -f -s 4k $dev
  mount $dev -o nospace_cache $mnt
  $fsstress -w -n 8 -s 1620948986 -d $mnt/ -v > /tmp/fsstress
  sync
  btrfs balance start -d $mnt
  btrfs scrub start -B $mnt

Similar problem can be easily observed in btrfs/028 test case, there
will be tons of balance failure with -EIO.

[CAUSE]
Above fsstress will result the following data extents layout in extent
tree:
  item 10 key (13631488 EXTENT_ITEM 98304) itemoff 15889 itemsize 82
    refs 2 gen 7 flags DATA
    extent data backref root FS_TREE objectid 259 offset 1339392 count 1
    extent data backref root FS_TREE objectid 259 offset 647168 count 1
  item 11 key (13631488 BLOCK_GROUP_ITEM 8388608) itemoff 15865 itemsize 24
    block group used 102400 chunk_objectid 256 flags DATA
  item 12 key (13733888 EXTENT_ITEM 4096) itemoff 15812 itemsize 53
    refs 1 gen 7 flags DATA
    extent data backref root FS_TREE objectid 259 offset 729088 count 1

Then when creating the data reloc inode, the data reloc inode will look
like this:

	0	32K	64K	96K 100K	104K
	|<------ Extent A ----->|   |<- Ext B ->|

Then when we first try to relocate extent A, we setup the data reloc
inode with iszie 96K, then read both page [0, 64K) and page [64K, 128K).

For page 64K, since the isize is just 96K, we fill range [96K, 128K)
with 0 and set it uptodate.

Then when we come to extent B, we update isize to 104K, then try to read
page [64K, 128K).
Then we find the page is already uptodate, so we skip the read.
But range [96K, 128K) is filled with 0, not the real data.

Then we writeback the data reloc inode to disk, with 0 filling range
[96K, 128K), corrupting the content of extent B.

The behavior is caused by the fact that we still do full page read for
subpage case.

The bug won't really happen for regular sectorsize, as one page only
contains one sector.

[FIX]
This patch will fix the problem by invalidating range [isize, PAGE_END]
in prealloc_file_extent_cluster().

So that if above example happens, when we preallocate the file extent
for extent B, we will clear the uptodate bits for range [96K, 128K),
allowing later relocate_one_page() to re-read the needed range.

There is a special note for the invalidating part.

Since we're not calling real btrfs_invalidatepage(), but just clearing
the subpage and page uptodate bits, we can leave a page half dirty and
half out of date.

Reading such page can make btrfs to deadlock, as we normally expect a
dirty page to be full uptodate.

Thus here we flush and wait the data reloc inode before doing the hacked
invalidating.
This won't cause extra overhead, as we're going to writeback the data
later anyway.

Reported-by: Ritesh Harjani <riteshh@linux.ibm.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/relocation.c | 59 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index af4bd2e9665f..c6c430685c3f 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2782,10 +2782,69 @@ static noinline_for_stack int prealloc_file_extent_cluster(
 	u64 num_bytes;
 	int nr;
 	int ret = 0;
+	u64 isize = i_size_read(&inode->vfs_inode);
 	u64 prealloc_start = cluster->start - offset;
 	u64 prealloc_end = cluster->end - offset;
 	u64 cur_offset = prealloc_start;
 
+	/*
+	 * For subpage case, previous isize may not be aligned to PAGE_SIZE.
+	 * This means the range [isize, PAGE_END + 1) is filled with 0 by
+	 * btrfs_do_readpage() call of previously relocated file cluster.
+	 *
+	 * If the current cluster starts in above range, btrfs_do_readpage()
+	 * will skip the read, and relocate_one_page() will later writeback
+	 * the padding 0 as new data, causing data corruption.
+	 *
+	 * Here we have to manually invalidate the range (isize, PAGE_END + 1).
+	 */
+	if (!IS_ALIGNED(isize, PAGE_SIZE)) {
+		struct address_space *mapping = inode->vfs_inode.i_mapping;
+		struct btrfs_fs_info *fs_info = inode->root->fs_info;
+		const u32 sectorsize = fs_info->sectorsize;
+		struct page *page;
+
+		ASSERT(sectorsize < PAGE_SIZE);
+		ASSERT(IS_ALIGNED(isize, sectorsize));
+
+		/*
+		 * Btrfs subpage can't handle page with DIRTY but without
+		 * UPTODATE bit as it can lead to the following deadlock:
+		 * btrfs_readpage()
+		 * | Page already *locked*
+		 * |- btrfs_lock_and_flush_ordered_range()
+		 *    |- btrfs_start_ordered_extent()
+		 *       |- extent_write_cache_pages()
+		 *          |- lock_page()
+		 *             We try to lock the page we already hold.
+		 *
+		 * Here we just writeback the whole data reloc inode, so that
+		 * we will be ensured to have no dirty range in the page, and
+		 * are safe to clear the uptodate bits.
+		 *
+		 * This shouldn't cause too much overhead, as we need to write
+		 * the data back anyway.
+		 */
+		ret = filemap_write_and_wait(mapping);
+		if (ret < 0)
+			return ret;
+
+		clear_extent_bits(&inode->io_tree, isize,
+				  round_up(isize, PAGE_SIZE) - 1,
+				  EXTENT_UPTODATE);
+		page = find_lock_page(mapping, isize >> PAGE_SHIFT);
+		/*
+		 * If page is freed we don't need to do anything then, as
+		 * we will re-read the whole page anyway.
+		 */
+		if (page) {
+			btrfs_subpage_clear_uptodate(fs_info, page, isize,
+					round_up(isize, PAGE_SIZE) - isize);
+			unlock_page(page);
+			put_page(page);
+		}
+	}
+
 	BUG_ON(cluster->start != cluster->boundary[0]);
 	ret = btrfs_alloc_data_chunk_ondemand(inode,
 					      prealloc_end + 1 - prealloc_start);
-- 
2.32.0

