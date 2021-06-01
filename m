Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABEA03973BB
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jun 2021 15:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbhFANEB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Jun 2021 09:04:01 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:2437 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbhFANEA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Jun 2021 09:04:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622552538; x=1654088538;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ty59cxD6XI/XP9SkD0KL0Kdv4TtYx2zReSKp60nGSGs=;
  b=SsuM4/RMQuS8MrHi5MwL3uc3BvyEBuaKBtn6C9ua6pPXrWtKEaHVzq+7
   ySsl43hvN72Hs4m6a5/a4/guFZiAtgzBkRxfYGrSY+EFYlJyFv3e2CW3i
   4jF/zY48o5lD5ME3kkUMU0DOGUOpJXQ0ihzW0o150L4ovm/pvBdIEo3K6
   rruRKLs+lOLeaMdIlflzCZ2nNyhb+jn8LIxQq6ZCsgYj31aOwglQcCg3S
   z/wCcLaMLVyozdiSwgywCtR0zopLIBzk/UaScw1Z+39R1v7ScxveQk8yg
   zfLkF+9jc90QRKBrCkH9uth5JCzw4PqtQpIfZ+0fIpgvIvXtb7uRUdnZo
   w==;
IronPort-SDR: y33PtQsrMiFOMN430SxJKhU9DEkx4107VDedLVJpYohttjmN2vo0Yj+DE2s2H5m8Hdv/njWMKA
 ZgKF18ygrXB6mELmugMBJ8eWl6vl6e2m7yDEHtipAxBy+ssce9q6XEOaell5J5x4B2Bpj+AOKS
 VQRGc9ooh+SvJ9SElLDJPOeIuU+8HANKOrFTyszQvVWRu+9GMzi8WvMwhVsGuPXiSEcT+UYCse
 mKj+vUhLWUSuoj1fv33LxV8ai5HFldaid/NCFCucwK6d67CiKn/i+Cj7b3HsnY/3XlXKz6AIR8
 sr8=
X-IronPort-AV: E=Sophos;i="5.83,239,1616428800"; 
   d="scan'208";a="174991976"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jun 2021 21:02:18 +0800
IronPort-SDR: eGcbaMqKFGWw4hG6jT/Oh0p+fcVYQjR2TzbeWcTT5v9siPUcL9i197g99nlhEBDCT0btW5T87Q
 7dHS1UxDP6hFsudDfls4xcNqaljyOQMDzI2kq+sLV/pIsEkA3v3YhibOR1M6upwZM4ueNKV3QK
 hDA2d42VJWFqHDgAkMWZIM2fpMJgl9N+4XoO9hA1s0jBe3wWiri3Kju77XwZfVfp9P55YspW7n
 dtoETtXgwbSDuD0/dveGmcClP4F0hXyRQqAhvqCWxGQkIBrIkbcPEXzadjOrTRrmaD5mNCrnWg
 18dI8WFYv5ZrC2CuQZSLOxRC
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2021 05:40:11 -0700
IronPort-SDR: o79DwBDSR0on2MvAmCurCmTvr1rUtMaqCc6E7eTBT1FiexSlSrGz3zHNp/e4ttrD4n5F6y5eP8
 M6De/AyYyS/vwwfhISXQ7PvP5WdgGvI5pHL7Q3UqiyWBAYaU5LiyKYzZ0wPDUeeHWYB8A4QKMd
 pVj29fJn+DyRZiYcvPMq8C0WrEwJxdYxPWWdcDC8paPXbMnUm2A5saLa8deC07nln5TKK6H2k7
 6OzFojJuzW9kxmu4xy6Ld4kCeJf32y75WXJ5iBrpF6UIifYE+00CVg8QeX4KOBkXsq1gVNZaha
 nkM=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 01 Jun 2021 06:02:17 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: add a helper for retrieving BTRFS_MAX_EXTENT_SIZE
Date:   Tue,  1 Jun 2021 22:02:09 +0900
Message-Id: <dac9b611e9a5383c028a13d844d0ec1bcb73890d.1622552385.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1622552385.git.johannes.thumshirn@wdc.com>
References: <cover.1622552385.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add a helper for retrieving BTRFS_MAX_EXTENT_SIZE as a preparation for a
fix in this area.

This patch has no functional changes.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/ctree.h                 | 23 +++++++++++++++--------
 fs/btrfs/delalloc-space.c        |  6 +++---
 fs/btrfs/extent_io.c             |  2 +-
 fs/btrfs/inode.c                 | 22 ++++++++++++----------
 fs/btrfs/tests/extent-io-tests.c |  2 +-
 fs/btrfs/tests/inode-tests.c     | 31 ++++++++++++++++---------------
 6 files changed, 48 insertions(+), 38 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index c63980977fa4..5d0398528a7a 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -105,14 +105,6 @@ struct btrfs_ref;
 #define BTRFS_STAT_CURR		0
 #define BTRFS_STAT_PREV		1
 
-/*
- * Count how many BTRFS_MAX_EXTENT_SIZE cover the @size
- */
-static inline u32 count_max_extents(u64 size)
-{
-	return div_u64(size + BTRFS_MAX_EXTENT_SIZE - 1, BTRFS_MAX_EXTENT_SIZE);
-}
-
 static inline unsigned long btrfs_chunk_item_size(int num_stripes)
 {
 	BUG_ON(num_stripes == 0);
@@ -1379,6 +1371,21 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
 	return BTRFS_MAX_ITEM_SIZE(info) - sizeof(struct btrfs_dir_item);
 }
 
+static inline u64 btrfs_get_max_extent_size(struct btrfs_fs_info *fs_info)
+{
+	return BTRFS_MAX_EXTENT_SIZE;
+}
+
+/*
+ * Count how many BTRFS_MAX_EXTENT_SIZE cover the @size
+ */
+static inline u32 count_max_extents(struct btrfs_fs_info *fs_info, u64 size)
+{
+	u64 max_extent_size = btrfs_get_max_extent_size(fs_info);
+
+	return div_u64(size + max_extent_size - 1, max_extent_size);
+}
+
 /*
  * Flags for mount options.
  *
diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index 56642ca7af10..2618693308d1 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -270,7 +270,7 @@ static void calc_inode_reservations(struct btrfs_fs_info *fs_info,
 				    u64 num_bytes, u64 *meta_reserve,
 				    u64 *qgroup_reserve)
 {
-	u64 nr_extents = count_max_extents(num_bytes);
+	u64 nr_extents = count_max_extents(fs_info, num_bytes);
 	u64 csum_leaves = btrfs_csum_bytes_to_leaves(fs_info, num_bytes);
 	u64 inode_update = btrfs_calc_metadata_size(fs_info, 1);
 
@@ -344,7 +344,7 @@ int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes)
 	 * needs to free the reservation we just made.
 	 */
 	spin_lock(&inode->lock);
-	nr_extents = count_max_extents(num_bytes);
+	nr_extents = count_max_extents(fs_info, num_bytes);
 	btrfs_mod_outstanding_extents(inode, nr_extents);
 	inode->csum_bytes += num_bytes;
 	btrfs_calculate_inode_block_rsv_size(fs_info, inode);
@@ -407,7 +407,7 @@ void btrfs_delalloc_release_extents(struct btrfs_inode *inode, u64 num_bytes)
 	unsigned num_extents;
 
 	spin_lock(&inode->lock);
-	num_extents = count_max_extents(num_bytes);
+	num_extents = count_max_extents(fs_info, num_bytes);
 	btrfs_mod_outstanding_extents(inode, -num_extents);
 	btrfs_calculate_inode_block_rsv_size(fs_info, inode);
 	spin_unlock(&inode->lock);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 13c5e880404d..954d28df887a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1863,7 +1863,7 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
 				    u64 *end)
 {
 	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
-	u64 max_bytes = BTRFS_MAX_EXTENT_SIZE;
+	u64 max_bytes = btrfs_get_max_extent_size(btrfs_sb(inode->i_sb));
 	u64 delalloc_start;
 	u64 delalloc_end;
 	bool found;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2eedcf65b8aa..8ba4b194cd3e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1936,6 +1936,7 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
 void btrfs_split_delalloc_extent(struct inode *inode,
 				 struct extent_state *orig, u64 split)
 {
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	u64 size;
 
 	/* not delalloc, ignore it */
@@ -1943,7 +1944,7 @@ void btrfs_split_delalloc_extent(struct inode *inode,
 		return;
 
 	size = orig->end - orig->start + 1;
-	if (size > BTRFS_MAX_EXTENT_SIZE) {
+	if (size > btrfs_get_max_extent_size(fs_info)) {
 		u32 num_extents;
 		u64 new_size;
 
@@ -1952,10 +1953,10 @@ void btrfs_split_delalloc_extent(struct inode *inode,
 		 * applies here, just in reverse.
 		 */
 		new_size = orig->end - split + 1;
-		num_extents = count_max_extents(new_size);
+		num_extents = count_max_extents(fs_info, new_size);
 		new_size = split - orig->start;
-		num_extents += count_max_extents(new_size);
-		if (count_max_extents(size) >= num_extents)
+		num_extents += count_max_extents(fs_info, new_size);
+		if (count_max_extents(fs_info, size) >= num_extents)
 			return;
 	}
 
@@ -1972,6 +1973,7 @@ void btrfs_split_delalloc_extent(struct inode *inode,
 void btrfs_merge_delalloc_extent(struct inode *inode, struct extent_state *new,
 				 struct extent_state *other)
 {
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	u64 new_size, old_size;
 	u32 num_extents;
 
@@ -1985,7 +1987,7 @@ void btrfs_merge_delalloc_extent(struct inode *inode, struct extent_state *new,
 		new_size = other->end - new->start + 1;
 
 	/* we're not bigger than the max, unreserve the space and go */
-	if (new_size <= BTRFS_MAX_EXTENT_SIZE) {
+	if (new_size <= btrfs_get_max_extent_size(fs_info)) {
 		spin_lock(&BTRFS_I(inode)->lock);
 		btrfs_mod_outstanding_extents(BTRFS_I(inode), -1);
 		spin_unlock(&BTRFS_I(inode)->lock);
@@ -2011,10 +2013,10 @@ void btrfs_merge_delalloc_extent(struct inode *inode, struct extent_state *new,
 	 * this case.
 	 */
 	old_size = other->end - other->start + 1;
-	num_extents = count_max_extents(old_size);
+	num_extents = count_max_extents(fs_info, old_size);
 	old_size = new->end - new->start + 1;
-	num_extents += count_max_extents(old_size);
-	if (count_max_extents(new_size) >= num_extents)
+	num_extents += count_max_extents(fs_info, old_size);
+	if (count_max_extents(fs_info, new_size) >= num_extents)
 		return;
 
 	spin_lock(&BTRFS_I(inode)->lock);
@@ -2093,7 +2095,7 @@ void btrfs_set_delalloc_extent(struct inode *inode, struct extent_state *state,
 	if (!(state->state & EXTENT_DELALLOC) && (*bits & EXTENT_DELALLOC)) {
 		struct btrfs_root *root = BTRFS_I(inode)->root;
 		u64 len = state->end + 1 - state->start;
-		u32 num_extents = count_max_extents(len);
+		u32 num_extents = count_max_extents(fs_info, len);
 		bool do_list = !btrfs_is_free_space_inode(BTRFS_I(inode));
 
 		spin_lock(&BTRFS_I(inode)->lock);
@@ -2135,7 +2137,7 @@ void btrfs_clear_delalloc_extent(struct inode *vfs_inode,
 	struct btrfs_inode *inode = BTRFS_I(vfs_inode);
 	struct btrfs_fs_info *fs_info = btrfs_sb(vfs_inode->i_sb);
 	u64 len = state->end + 1 - state->start;
-	u32 num_extents = count_max_extents(len);
+	u32 num_extents = count_max_extents(fs_info, len);
 
 	if ((state->state & EXTENT_DEFRAG) && (*bits & EXTENT_DEFRAG)) {
 		spin_lock(&inode->lock);
diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-tests.c
index 73e96d505f4f..99b791b931d7 100644
--- a/fs/btrfs/tests/extent-io-tests.c
+++ b/fs/btrfs/tests/extent-io-tests.c
@@ -64,7 +64,7 @@ static int test_find_delalloc(u32 sectorsize)
 	struct page *locked_page = NULL;
 	unsigned long index = 0;
 	/* In this test we need at least 2 file extents at its maximum size */
-	u64 max_bytes = BTRFS_MAX_EXTENT_SIZE;
+	u64 max_bytes = btrfs_get_max_extent_size(NULL);
 	u64 total_dirty = 2 * max_bytes;
 	u64 start, end, test_start;
 	bool found;
diff --git a/fs/btrfs/tests/inode-tests.c b/fs/btrfs/tests/inode-tests.c
index c9874b12d337..0a437371ee21 100644
--- a/fs/btrfs/tests/inode-tests.c
+++ b/fs/btrfs/tests/inode-tests.c
@@ -917,6 +917,7 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 	struct btrfs_fs_info *fs_info = NULL;
 	struct inode *inode = NULL;
 	struct btrfs_root *root = NULL;
+	u64 max_extent_size = btrfs_get_max_extent_size(NULL);
 	int ret = -ENOMEM;
 
 	test_msg("running outstanding_extents tests");
@@ -943,7 +944,7 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 
 	/* [BTRFS_MAX_EXTENT_SIZE] */
 	ret = btrfs_set_extent_delalloc(BTRFS_I(inode), 0,
-					BTRFS_MAX_EXTENT_SIZE - 1, 0, NULL);
+					max_extent_size - 1, 0, NULL);
 	if (ret) {
 		test_err("btrfs_set_extent_delalloc returned %d", ret);
 		goto out;
@@ -956,8 +957,8 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 	}
 
 	/* [BTRFS_MAX_EXTENT_SIZE][sectorsize] */
-	ret = btrfs_set_extent_delalloc(BTRFS_I(inode), BTRFS_MAX_EXTENT_SIZE,
-					BTRFS_MAX_EXTENT_SIZE + sectorsize - 1,
+	ret = btrfs_set_extent_delalloc(BTRFS_I(inode), max_extent_size,
+					max_extent_size + sectorsize - 1,
 					0, NULL);
 	if (ret) {
 		test_err("btrfs_set_extent_delalloc returned %d", ret);
@@ -972,8 +973,8 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 
 	/* [BTRFS_MAX_EXTENT_SIZE/2][sectorsize HOLE][the rest] */
 	ret = clear_extent_bit(&BTRFS_I(inode)->io_tree,
-			       BTRFS_MAX_EXTENT_SIZE >> 1,
-			       (BTRFS_MAX_EXTENT_SIZE >> 1) + sectorsize - 1,
+			       max_extent_size >> 1,
+			       (max_extent_size >> 1) + sectorsize - 1,
 			       EXTENT_DELALLOC | EXTENT_DELALLOC_NEW |
 			       EXTENT_UPTODATE, 0, 0, NULL);
 	if (ret) {
@@ -988,8 +989,8 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 	}
 
 	/* [BTRFS_MAX_EXTENT_SIZE][sectorsize] */
-	ret = btrfs_set_extent_delalloc(BTRFS_I(inode), BTRFS_MAX_EXTENT_SIZE >> 1,
-					(BTRFS_MAX_EXTENT_SIZE >> 1)
+	ret = btrfs_set_extent_delalloc(BTRFS_I(inode), max_extent_size >> 1,
+					(max_extent_size >> 1)
 					+ sectorsize - 1,
 					0, NULL);
 	if (ret) {
@@ -1007,8 +1008,8 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 	 * [BTRFS_MAX_EXTENT_SIZE+sectorsize][sectorsize HOLE][BTRFS_MAX_EXTENT_SIZE+sectorsize]
 	 */
 	ret = btrfs_set_extent_delalloc(BTRFS_I(inode),
-			BTRFS_MAX_EXTENT_SIZE + 2 * sectorsize,
-			(BTRFS_MAX_EXTENT_SIZE << 1) + 3 * sectorsize - 1,
+			max_extent_size + 2 * sectorsize,
+			(max_extent_size << 1) + 3 * sectorsize - 1,
 			0, NULL);
 	if (ret) {
 		test_err("btrfs_set_extent_delalloc returned %d", ret);
@@ -1025,8 +1026,8 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 	* [BTRFS_MAX_EXTENT_SIZE+sectorsize][sectorsize][BTRFS_MAX_EXTENT_SIZE+sectorsize]
 	*/
 	ret = btrfs_set_extent_delalloc(BTRFS_I(inode),
-			BTRFS_MAX_EXTENT_SIZE + sectorsize,
-			BTRFS_MAX_EXTENT_SIZE + 2 * sectorsize - 1, 0, NULL);
+			max_extent_size + sectorsize,
+			max_extent_size + 2 * sectorsize - 1, 0, NULL);
 	if (ret) {
 		test_err("btrfs_set_extent_delalloc returned %d", ret);
 		goto out;
@@ -1040,8 +1041,8 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 
 	/* [BTRFS_MAX_EXTENT_SIZE+4k][4K HOLE][BTRFS_MAX_EXTENT_SIZE+4k] */
 	ret = clear_extent_bit(&BTRFS_I(inode)->io_tree,
-			       BTRFS_MAX_EXTENT_SIZE + sectorsize,
-			       BTRFS_MAX_EXTENT_SIZE + 2 * sectorsize - 1,
+			       max_extent_size + sectorsize,
+			       max_extent_size + 2 * sectorsize - 1,
 			       EXTENT_DELALLOC | EXTENT_DELALLOC_NEW |
 			       EXTENT_UPTODATE, 0, 0, NULL);
 	if (ret) {
@@ -1060,8 +1061,8 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 	 * might fail and I'd rather satisfy my paranoia at this point.
 	 */
 	ret = btrfs_set_extent_delalloc(BTRFS_I(inode),
-			BTRFS_MAX_EXTENT_SIZE + sectorsize,
-			BTRFS_MAX_EXTENT_SIZE + 2 * sectorsize - 1, 0, NULL);
+			max_extent_size + sectorsize,
+			max_extent_size + 2 * sectorsize - 1, 0, NULL);
 	if (ret) {
 		test_err("btrfs_set_extent_delalloc returned %d", ret);
 		goto out;
-- 
2.31.1

