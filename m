Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5D5564CD5
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jul 2022 06:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbiGDE6y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jul 2022 00:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbiGDE6u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jul 2022 00:58:50 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F235F267E
        for <linux-btrfs@vger.kernel.org>; Sun,  3 Jul 2022 21:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656910729; x=1688446729;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ectCsfNb0qppLMOswu3/MxgLhmpVLNsrg/MKHVAjkxM=;
  b=HkFpcxYe9Oxt/PgORMIliyMM//5ZUugtey5AeNNkIXkEhNG9TXefoLVa
   Zi2kbG5vjhx2sUy2sckYgFWUJX/X2wcyKfLLysLNAnlp+2klWa/kviA92
   aCUbqWVJGgX3C/Um99Hw6XwKDw/c+Yz120hj7Btx0rzyUbOliOnl+W8PZ
   44nLVDIapcxqDysugBONqKqo8fqof/1Q/OVQUBDgYQ7l35xSmg/H7Q/dI
   5Bl2YxeEULEA+jSlfxgEqcecIgMIUYJEnGxnf2k+JlvJprStiRg9xDjyj
   JDNmJRW9baGfsYARvyf/FOjIAnaNvgUval2nFLeb5PFMr0DCOsO6JRRVC
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,243,1650902400"; 
   d="scan'208";a="204732402"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jul 2022 12:58:49 +0800
IronPort-SDR: OdUtXtZq9FPoZRj7aJ7T9Hus6mrwDFH3n8pQ2xZF/TtDnswNF65q1oWZrXwDnZMK2fIcG84FZI
 uHZnht8C6ai9MQPiIwmxV/E/22m15sFzTKBoU8S2fw3eHFEzzxZI5zyIbyDgXZa/TvP2yGzZ6q
 PAICWYhyhxd0WupV1pgcH206x9fe0jCU7WoAxVaDFMtkluIKgX+Qr8nfEzxW0XKAo51J8vo5Es
 2UkMrcl1H89BXhuCZDhiVZ2NxoZcQThPs5D1T8LZ1d9ltnnfiO1lnJ9CpppzBY/u+O0VM3c1CP
 AMuYxre0WFW1LnZnKVntOgr1
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jul 2022 21:20:42 -0700
IronPort-SDR: E9d7WlOg6/6Ad95hvk5Y2grwCl6byRnGHFFe5HTIw8LvXubWBY+muU/Q3yJ8o/pBPkxxXeBTht
 96Rw6CSF2+xbQbPiRR+7Ld0DACgFSsOcxRSf0QqI1teSCWy7EDW+odQR0GSycMNVD4GEjWIdS5
 M+/JmcZ4j0N12E+LdiEMuA7B1N32RGEXV8yN086W7aICtDUhbL9/fU6WzY1Wc9TsxVKRclWPhI
 1G28N7b/xgJPV2xcFmEglpDuIWDW7Z7KPEWdlCflDB5aw0FOMuc7eiXG0sB9ymijkanfftTA2N
 Smo=
WDCIronportException: Internal
Received: from h5lk5s2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.53.119])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 Jul 2022 21:58:49 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 04/13] btrfs: convert count_max_extents() to use fs_info->max_extent_size
Date:   Mon,  4 Jul 2022 13:58:08 +0900
Message-Id: <943a1cb89b84002b49b758fce808a36a50c195a1.1656909695.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1656909695.git.naohiro.aota@wdc.com>
References: <cover.1656909695.git.naohiro.aota@wdc.com>
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
 fs/btrfs/ctree.h          | 16 ++++++++--------
 fs/btrfs/delalloc-space.c |  6 +++---
 fs/btrfs/inode.c          | 16 ++++++++--------
 3 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index fca253bdb4b8..4aac7df5a17d 100644
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
@@ -4057,6 +4049,14 @@ static inline bool btrfs_is_zoned(const struct btrfs_fs_info *fs_info)
 	return fs_info->zone_size > 0;
 }
 
+/*
+ * Count how many fs_info->max_extent_size cover the @size
+ */
+static inline u32 count_max_extents(struct btrfs_fs_info *fs_info, u64 size)
+{
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
index 74ac7ef69a3f..357322da51b5 100644
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

