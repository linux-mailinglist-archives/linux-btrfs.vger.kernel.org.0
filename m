Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08DEB1F4A7F
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jun 2020 02:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbgFJA6C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Jun 2020 20:58:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:33424 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbgFJA6B (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Jun 2020 20:58:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2FC3BACF2
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Jun 2020 00:58:03 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/5] btrfs: inode: move the qgroup reserved data space release into the callers of insert_reserved_file_extent()
Date:   Wed, 10 Jun 2020 08:57:48 +0800
Message-Id: <20200610005751.10645-3-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610005751.10645-1-wqu@suse.com>
References: <20200610005751.10645-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is to prepare for the incoming timing change of qgroup reserved
data space and ordered extent.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c076cbe9f492..09e1724d620a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2449,7 +2449,8 @@ int btrfs_writepage_cow_fixup(struct page *page, u64 start, u64 end)
 
 static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 				       struct inode *inode, u64 file_pos,
-				       struct btrfs_file_extent_item *stack_fi)
+				       struct btrfs_file_extent_item *stack_fi,
+				       u64 qgroup_reserved)
 {
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	struct btrfs_path *path;
@@ -2459,7 +2460,6 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 	u64 disk_bytenr = btrfs_stack_file_extent_disk_bytenr(stack_fi);
 	u64 num_bytes = btrfs_stack_file_extent_num_bytes(stack_fi);
 	u64 ram_bytes = btrfs_stack_file_extent_ram_bytes(stack_fi);
-	u64 qg_released;
 	int extent_inserted = 0;
 	int ret;
 
@@ -2513,17 +2513,9 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 	if (ret)
 		goto out;
 
-	/*
-	 * Release the reserved range from inode dirty range map, as it is
-	 * already moved into delayed_ref_head
-	 */
-	ret = btrfs_qgroup_release_data(inode, file_pos, ram_bytes);
-	if (ret < 0)
-		goto out;
-	qg_released = ret;
 	ret = btrfs_alloc_reserved_file_extent(trans, root,
 					       btrfs_ino(BTRFS_I(inode)),
-					       file_pos, qg_released, &ins);
+					       file_pos, qgroup_reserved, &ins);
 out:
 	btrfs_free_path(path);
 
@@ -2551,6 +2543,7 @@ static int insert_ordered_extent_file_extent(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_file_extent_item stack_fi;
 	u64 logical_len;
+	int ret;
 
 	memset(&stack_fi, 0, sizeof(stack_fi));
 	btrfs_set_stack_file_extent_type(&stack_fi, BTRFS_FILE_EXTENT_REG);
@@ -2566,8 +2559,11 @@ static int insert_ordered_extent_file_extent(struct btrfs_trans_handle *trans,
 	btrfs_set_stack_file_extent_compression(&stack_fi, oe->compress_type);
 	/* Encryption and other encoding is reserved and all 0 */
 
+	ret = btrfs_qgroup_release_data(inode, oe->file_offset, logical_len);
+	if (ret < 0)
+		return ret;
 	return insert_reserved_file_extent(trans, inode, oe->file_offset,
-					   &stack_fi);
+					   &stack_fi, ret);
 }
 
 /*
@@ -9508,6 +9504,7 @@ static int insert_prealloc_file_extent(struct btrfs_trans_handle *trans,
 	struct btrfs_file_extent_item stack_fi;
 	u64 start = ins->objectid;
 	u64 len = ins->offset;
+	int ret;
 
 	memset(&stack_fi, 0, sizeof(stack_fi));
 
@@ -9519,8 +9516,11 @@ static int insert_prealloc_file_extent(struct btrfs_trans_handle *trans,
 	btrfs_set_stack_file_extent_compression(&stack_fi, BTRFS_COMPRESS_NONE);
 	/* Encryption and other encoding is reserved and all 0 */
 
+	ret = btrfs_qgroup_release_data(inode, file_offset, len);
+	if (ret < 0)
+		return ret;
 	return insert_reserved_file_extent(trans, inode, file_offset,
-					   &stack_fi);
+					   &stack_fi, ret);
 }
 static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 				       u64 start, u64 num_bytes, u64 min_size,
-- 
2.26.2

