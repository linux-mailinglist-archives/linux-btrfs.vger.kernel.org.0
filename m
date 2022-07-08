Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D81F56C523
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Jul 2022 02:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237547AbiGHXTM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Jul 2022 19:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238899AbiGHXTL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Jul 2022 19:19:11 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6534C41985;
        Fri,  8 Jul 2022 16:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657322350; x=1688858350;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wA2Hdc5+oSsAh0DQ5SCxlPFwt1GkrPXMZVV8EyoQmIQ=;
  b=iOqdW21GlqWasRQInzwYXp0zFaRYuyK8WB2D1P8JKlBcesG8uTmQF+Q8
   UAgzfoivnrALSZld2zD34z9jqueotKyKD+elmyLG4Gl6vBES30ctCSrpM
   54ibTLiI2qrQMyfYShSWYBtA/yPjjL3ZGjGIztzpUKrlXfRcYE/wc+rdO
   DSkKBhG/a2YXf4G9flvYrHNK4cyDZzaVEEq0snWB/TeEBnq6f0qQRsBTD
   aanbXaGZjfzSifybaz/RVYypHVVjAtU6DxEzAR51aIYavAC1Ii2a9lA95
   ApX3iOqeLPuG5N5//qLuE1D4HUi8Iy0LXKpewgOmhh1OCxOTWHmCOiguv
   A==;
X-IronPort-AV: E=Sophos;i="5.92,256,1650902400"; 
   d="scan'208";a="203871822"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jul 2022 07:19:09 +0800
IronPort-SDR: wsc6VLn4pbe1BdQcpzLs8sWPP+Mbas720kj8EVBBiv3XqPMhuMY3973NxfrXcw+wg8xnyRj+bQ
 HvoC/UVZY0N/Vc9+XUYFuNCT9haJGTGToYcJ+/U0uKg8HsYrrmaIoDxiQ0uL9Zj40uuW9c8FMT
 ThkzLUMCDMX4bqtODWzA+7qOinDaq7e1bXL0yhEolM5M81MBNCVGC9m6bKQfjqMRH2jD6+Su++
 0shhvOrDnHMdhnCjWmxL+VOgZzIxSZxaQU2QKfHmpTyzzuG5wq5hlzIqX9PXUaXDXHkBu+4qaB
 Pu4AYjTTfuK/qnqqIMNHFcMJ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Jul 2022 15:36:14 -0700
IronPort-SDR: 4eo3PUIgzL9oieReARKaXP5wK8pG83HmTS4Rlptsq0E6ABYILdcG8Kp8a7/BPZldnDKL2xJ5XY
 aecFfA549tQJQQdMx8nPEzaorfZFyVuQkAcMMZz2XVkP9q1xUtqmaUTzlKnJ+VWvPjQrCRRNaF
 ZtqqJ924HhG573mSqV8CNp7YZDE5sdXUuOdhdqEQCpVlagPPxkREPqi6yKaeXzVbIWoPRigN8a
 kTg8KFP5U9ZolEUikj38JMeb13DenB5zElMq11zGBQAu+qL11m+KW923qM0VcB1aZIvxj1vgSk
 lug=
WDCIronportException: Internal
Received: from phd010370.ad.shared (HELO naota-xeon.wdc.com) ([10.225.55.250])
  by uls-op-cesaip01.wdc.com with ESMTP; 08 Jul 2022 16:19:08 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 04/13] btrfs: convert count_max_extents() to use fs_info->max_extent_size
Date:   Sat,  9 Jul 2022 08:18:41 +0900
Message-Id: <8492f9cc951b3324d6b9989c194fd428c799793e.1657321126.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1657321126.git.naohiro.aota@wdc.com>
References: <cover.1657321126.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If count_max_extents() uses BTRFS_MAX_EXTENT_SIZE to calculate the number
of extents needed, btrfs release the metadata reservation too much on its
way to write out the data.

Now that BTRFS_MAX_EXTENT_SIZE is replaced with fs_info->max_extent_size,
convert count_max_extents() to use it instead, and fix the calculation of
the metadata reservation.

CC: stable@vger.kernel.org # 5.12+
Fixes: d8e3fb106f39 ("btrfs: zoned: use ZONE_APPEND write for zoned mode")
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/ctree.h          | 21 +++++++++++++--------
 fs/btrfs/delalloc-space.c |  6 +++---
 fs/btrfs/inode.c          | 16 ++++++++--------
 3 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index fca253bdb4b8..c215e15baea2 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -107,14 +107,6 @@ struct btrfs_ioctl_encoded_io_args;
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
@@ -4057,6 +4049,19 @@ static inline bool btrfs_is_zoned(const struct btrfs_fs_info *fs_info)
 	return fs_info->zone_size > 0;
 }
 
+/*
+ * Count how many fs_info->max_extent_size cover the @size
+ */
+static inline u32 count_max_extents(struct btrfs_fs_info *fs_info, u64 size)
+{
+#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
+	if (!fs_info)
+		return div_u64(size + BTRFS_MAX_EXTENT_SIZE - 1, BTRFS_MAX_EXTENT_SIZE);
+#endif
+
+	return div_u64(size + fs_info->max_extent_size - 1, fs_info->max_extent_size);
+}
+
 static inline bool btrfs_is_data_reloc_root(const struct btrfs_root *root)
 {
 	return root->root_key.objectid == BTRFS_DATA_RELOC_TREE_OBJECTID;
diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index 36ab0859a263..1e8f17ff829e 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -273,7 +273,7 @@ static void calc_inode_reservations(struct btrfs_fs_info *fs_info,
 				    u64 num_bytes, u64 disk_num_bytes,
 				    u64 *meta_reserve, u64 *qgroup_reserve)
 {
-	u64 nr_extents = count_max_extents(num_bytes);
+	u64 nr_extents = count_max_extents(fs_info, num_bytes);
 	u64 csum_leaves = btrfs_csum_bytes_to_leaves(fs_info, disk_num_bytes);
 	u64 inode_update = btrfs_calc_metadata_size(fs_info, 1);
 
@@ -350,7 +350,7 @@ int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes,
 	 * needs to free the reservation we just made.
 	 */
 	spin_lock(&inode->lock);
-	nr_extents = count_max_extents(num_bytes);
+	nr_extents = count_max_extents(fs_info, num_bytes);
 	btrfs_mod_outstanding_extents(inode, nr_extents);
 	inode->csum_bytes += disk_num_bytes;
 	btrfs_calculate_inode_block_rsv_size(fs_info, inode);
@@ -413,7 +413,7 @@ void btrfs_delalloc_release_extents(struct btrfs_inode *inode, u64 num_bytes)
 	unsigned num_extents;
 
 	spin_lock(&inode->lock);
-	num_extents = count_max_extents(num_bytes);
+	num_extents = count_max_extents(fs_info, num_bytes);
 	btrfs_mod_outstanding_extents(inode, -num_extents);
 	btrfs_calculate_inode_block_rsv_size(fs_info, inode);
 	spin_unlock(&inode->lock);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 155282dacc6e..8ce937b0b014 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2218,10 +2218,10 @@ void btrfs_split_delalloc_extent(struct inode *inode,
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
 
@@ -2278,10 +2278,10 @@ void btrfs_merge_delalloc_extent(struct inode *inode, struct extent_state *new,
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
@@ -2360,7 +2360,7 @@ void btrfs_set_delalloc_extent(struct inode *inode, struct extent_state *state,
 	if (!(state->state & EXTENT_DELALLOC) && (bits & EXTENT_DELALLOC)) {
 		struct btrfs_root *root = BTRFS_I(inode)->root;
 		u64 len = state->end + 1 - state->start;
-		u32 num_extents = count_max_extents(len);
+		u32 num_extents = count_max_extents(fs_info, len);
 		bool do_list = !btrfs_is_free_space_inode(BTRFS_I(inode));
 
 		spin_lock(&BTRFS_I(inode)->lock);
@@ -2402,7 +2402,7 @@ void btrfs_clear_delalloc_extent(struct inode *vfs_inode,
 	struct btrfs_inode *inode = BTRFS_I(vfs_inode);
 	struct btrfs_fs_info *fs_info = btrfs_sb(vfs_inode->i_sb);
 	u64 len = state->end + 1 - state->start;
-	u32 num_extents = count_max_extents(len);
+	u32 num_extents = count_max_extents(fs_info, len);
 
 	if ((state->state & EXTENT_DEFRAG) && (bits & EXTENT_DEFRAG)) {
 		spin_lock(&inode->lock);
-- 
2.35.1

