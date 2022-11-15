Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4571D62A0F5
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 19:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238263AbiKOSBn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 13:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237952AbiKOSBI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 13:01:08 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC46D2F005
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 10:00:43 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6690433688;
        Tue, 15 Nov 2022 18:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1668535242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Iy5bXyflPNjSnEIykYuf/uYXJoIj0vxQu+TYe+3yv2w=;
        b=r5uP+VGJEb010SJ8/Y8TzwbfLRSuAak7qADiRPKGEafZM5U9Co128zLHHvV52XBYBAl35x
        h/A+x7GniEQkSCL8OhhtljOEg6xlRM8zE8qlAOPXTTt7NmgVXbm3pV1jXOjKTAPn1jqmM0
        KSfHrMpz+onyyLtstEhNnF3TfC8wZOQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1668535242;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Iy5bXyflPNjSnEIykYuf/uYXJoIj0vxQu+TYe+3yv2w=;
        b=tUX6LHEXhLrE+sUWlNwamGKRQqzTBUWsC//ziCPCw1bHaudW/fOM1xYIEMxCU4FlkH7lFz
        XBpAitStElKuTwCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A16613A91;
        Tue, 15 Nov 2022 18:00:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZOsQOsnTc2OKZAAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Tue, 15 Nov 2022 18:00:41 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 02/16] btrfs: qgroup flush responsibility of the caller
Date:   Tue, 15 Nov 2022 12:00:20 -0600
Message-Id: <b5ea2b71e950e0452053cc7ceaade4b96ead6103.1668530684.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1668530684.git.rgoldwyn@suse.com>
References: <cover.1668530684.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Qgroup reservation will be performed under extent locks. If qgroup runs
low, btrfs starts a flush to squeeze out the last available space from
over-reserved uncommitted extents. Move the flush outside of the
reserve function so it can be called by the callee of the
reserving function.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/block-group.c    |  2 +-
 fs/btrfs/delalloc-space.c | 17 +++++++----------
 fs/btrfs/delalloc-space.h |  5 ++---
 fs/btrfs/file.c           | 19 ++++++++++++++++---
 fs/btrfs/inode.c          | 23 +++++++++++++----------
 fs/btrfs/qgroup.c         | 27 +--------------------------
 fs/btrfs/qgroup.h         | 16 ++++++----------
 fs/btrfs/relocation.c     |  3 +--
 fs/btrfs/root-tree.c      |  3 +--
 9 files changed, 48 insertions(+), 67 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 708d843daa72..578c6cbdef3b 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2945,7 +2945,7 @@ static int cache_save_setup(struct btrfs_block_group *block_group,
 	cache_size *= fs_info->sectorsize;
 
 	ret = btrfs_check_data_free_space(BTRFS_I(inode), &data_reserved, 0,
-					  cache_size, false);
+					  cache_size);
 	if (ret)
 		goto out_put;
 
diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index 7ddb1d104e8e..b46614bec817 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -130,7 +130,7 @@ int btrfs_alloc_data_chunk_ondemand(struct btrfs_inode *inode, u64 bytes)
 
 int btrfs_check_data_free_space(struct btrfs_inode *inode,
 				struct extent_changeset **reserved, u64 start,
-				u64 len, bool noflush)
+				u64 len)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	enum btrfs_reserve_flush_enum flush = BTRFS_RESERVE_FLUSH_DATA;
@@ -141,9 +141,7 @@ int btrfs_check_data_free_space(struct btrfs_inode *inode,
 	      round_down(start, fs_info->sectorsize);
 	start = round_down(start, fs_info->sectorsize);
 
-	if (noflush)
-		flush = BTRFS_RESERVE_NO_FLUSH;
-	else if (btrfs_is_free_space_inode(inode))
+	if (btrfs_is_free_space_inode(inode))
 		flush = BTRFS_RESERVE_FLUSH_FREE_SPACE_INODE;
 
 	ret = btrfs_reserve_data_bytes(fs_info, len, flush);
@@ -298,7 +296,7 @@ static void calc_inode_reservations(struct btrfs_fs_info *fs_info,
 }
 
 int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes,
-				    u64 disk_num_bytes, bool noflush)
+				    u64 disk_num_bytes)
 {
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
@@ -317,7 +315,7 @@ int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes,
 	 * If we have a transaction open (can happen if we call truncate_block
 	 * from truncate), then we need FLUSH_LIMIT so we don't deadlock.
 	 */
-	if (noflush || btrfs_is_free_space_inode(inode)) {
+	if (btrfs_is_free_space_inode(inode)) {
 		flush = BTRFS_RESERVE_NO_FLUSH;
 	} else {
 		if (current->journal_info)
@@ -342,8 +340,7 @@ int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes,
 	 */
 	calc_inode_reservations(fs_info, num_bytes, disk_num_bytes,
 				&meta_reserve, &qgroup_reserve);
-	ret = btrfs_qgroup_reserve_meta_prealloc(root, qgroup_reserve, true,
-						 noflush);
+	ret = btrfs_qgroup_reserve_meta_prealloc(root, qgroup_reserve, true);
 	if (ret)
 		return ret;
 	ret = btrfs_reserve_metadata_bytes(fs_info, block_rsv, meta_reserve, flush);
@@ -464,10 +461,10 @@ int btrfs_delalloc_reserve_space(struct btrfs_inode *inode,
 {
 	int ret;
 
-	ret = btrfs_check_data_free_space(inode, reserved, start, len, false);
+	ret = btrfs_check_data_free_space(inode, reserved, start, len);
 	if (ret < 0)
 		return ret;
-	ret = btrfs_delalloc_reserve_metadata(inode, len, len, false);
+	ret = btrfs_delalloc_reserve_metadata(inode, len, len);
 	if (ret < 0) {
 		btrfs_free_reserved_data_space(inode, *reserved, start, len);
 		extent_changeset_free(*reserved);
diff --git a/fs/btrfs/delalloc-space.h b/fs/btrfs/delalloc-space.h
index c5d573f2366e..b91fcde5da80 100644
--- a/fs/btrfs/delalloc-space.h
+++ b/fs/btrfs/delalloc-space.h
@@ -7,8 +7,7 @@ struct extent_changeset;
 
 int btrfs_alloc_data_chunk_ondemand(struct btrfs_inode *inode, u64 bytes);
 int btrfs_check_data_free_space(struct btrfs_inode *inode,
-			struct extent_changeset **reserved, u64 start, u64 len,
-			bool noflush);
+			struct extent_changeset **reserved, u64 start, u64 len);
 void btrfs_free_reserved_data_space(struct btrfs_inode *inode,
 			struct extent_changeset *reserved, u64 start, u64 len);
 void btrfs_delalloc_release_space(struct btrfs_inode *inode,
@@ -21,7 +20,7 @@ void btrfs_delalloc_release_metadata(struct btrfs_inode *inode, u64 num_bytes,
 int btrfs_delalloc_reserve_space(struct btrfs_inode *inode,
 			struct extent_changeset **reserved, u64 start, u64 len);
 int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes,
-				    u64 disk_num_bytes, bool noflush);
+				    u64 disk_num_bytes);
 void btrfs_delalloc_release_extents(struct btrfs_inode *inode, u64 num_bytes);
 
 #endif /* BTRFS_DELALLOC_SPACE_H */
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 448b143a5cb2..940f10f42790 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1189,6 +1189,7 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 	unsigned int ilock_flags = 0;
 	const bool nowait = (iocb->ki_flags & IOCB_NOWAIT);
 	unsigned int bdp_flags = (nowait ? BDP_ASYNC : 0);
+	bool flushed = false;
 
 	if (nowait)
 		ilock_flags |= BTRFS_ILOCK_TRY;
@@ -1242,11 +1243,11 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 
 		only_release_metadata = false;
 		sector_offset = pos & (fs_info->sectorsize - 1);
-
+reserve:
 		extent_changeset_release(data_reserved);
 		ret = btrfs_check_data_free_space(BTRFS_I(inode),
 						  &data_reserved, pos,
-						  write_bytes, nowait);
+						  write_bytes);
 		if (ret < 0) {
 			int can_nocow;
 
@@ -1255,6 +1256,12 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 				break;
 			}
 
+			if (!nowait && !flushed && ret == -EDQUOT) {
+				flushed = true;
+				btrfs_qgroup_flush(BTRFS_I(inode)->root);
+				goto reserve;
+			}
+
 			/*
 			 * If we don't have to COW at the offset, reserve
 			 * metadata only. write_bytes may get smaller than
@@ -1278,7 +1285,7 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 		WARN_ON(reserve_bytes == 0);
 		ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode),
 						      reserve_bytes,
-						      reserve_bytes, nowait);
+						      reserve_bytes);
 		if (ret) {
 			if (!only_release_metadata)
 				btrfs_free_reserved_data_space(BTRFS_I(inode),
@@ -1289,6 +1296,12 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 
 			if (nowait && ret == -ENOSPC)
 				ret = -EAGAIN;
+
+			if (!nowait && !flushed && ret == -EDQUOT) {
+				flushed = true;
+				btrfs_qgroup_flush(BTRFS_I(inode)->root);
+				goto reserve;
+			}
 			break;
 		}
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 4248e6cabbdc..29c1748adacf 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4936,7 +4936,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 	block_end = block_start + blocksize - 1;
 
 	ret = btrfs_check_data_free_space(inode, &data_reserved, block_start,
-					  blocksize, false);
+					  blocksize);
 	if (ret < 0) {
 		if (btrfs_check_nocow_lock(inode, block_start, &write_bytes, false) > 0) {
 			/* For nocow case, no need to reserve data space */
@@ -4945,7 +4945,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 			goto out;
 		}
 	}
-	ret = btrfs_delalloc_reserve_metadata(inode, blocksize, blocksize, false);
+	ret = btrfs_delalloc_reserve_metadata(inode, blocksize, blocksize);
 	if (ret < 0) {
 		if (!only_release_metadata)
 			btrfs_free_reserved_data_space(inode, data_reserved,
@@ -7484,6 +7484,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 	bool space_reserved = false;
 	u64 prev_len;
 	int ret = 0;
+	bool flushed = false;
 
 	/*
 	 * We don't allocate a new extent in the following cases
@@ -7515,10 +7516,14 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 	prev_len = len;
 	if (can_nocow) {
 		struct extent_map *em2;
-
+again:
 		/* We can NOCOW, so only need to reserve metadata space. */
-		ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode), len, len,
-						      nowait);
+		ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode), len, len);
+		if (!nowait && !flushed && ret == -EDQUOT) {
+			btrfs_qgroup_flush(BTRFS_I(inode)->root);
+			flushed = true;
+			goto again;
+		}
 		if (ret < 0) {
 			/* Our caller expects us to free the input extent map. */
 			free_extent_map(em);
@@ -7566,8 +7571,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 		 * We have to COW and we have already reserved data space before,
 		 * so now we reserve only metadata.
 		 */
-		ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode), len, len,
-						      false);
+		ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode), len, len);
 		if (ret < 0)
 			goto out;
 		space_reserved = true;
@@ -7690,7 +7694,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	if (write && !(flags & IOMAP_NOWAIT)) {
 		ret = btrfs_check_data_free_space(BTRFS_I(inode),
 						  &dio_data->data_reserved,
-						  start, data_alloc_len, false);
+						  start, data_alloc_len);
 		if (!ret)
 			dio_data->data_space_reserved = true;
 		else if (ret && !(BTRFS_I(inode)->flags &
@@ -10801,8 +10805,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	ret = btrfs_qgroup_reserve_data(inode, &data_reserved, start, num_bytes);
 	if (ret)
 		goto out_free_data_space;
-	ret = btrfs_delalloc_reserve_metadata(inode, num_bytes, disk_num_bytes,
-					      false);
+	ret = btrfs_delalloc_reserve_metadata(inode, num_bytes, disk_num_bytes);
 	if (ret)
 		goto out_qgroup_free_data;
 
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 05e79f7b4433..db55f3a7949d 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3695,7 +3695,7 @@ static int qgroup_unreserve_range(struct btrfs_inode *inode,
  *   In theory this shouldn't provide much space, but any more qgroup space
  *   is needed.
  */
-static int try_flush_qgroup(struct btrfs_root *root)
+int btrfs_qgroup_flush(struct btrfs_root *root)
 {
 	struct btrfs_trans_handle *trans;
 	int ret;
@@ -3801,15 +3801,6 @@ int btrfs_qgroup_reserve_data(struct btrfs_inode *inode,
 			struct extent_changeset **reserved_ret, u64 start,
 			u64 len)
 {
-	int ret;
-
-	ret = qgroup_reserve_data(inode, reserved_ret, start, len);
-	if (ret <= 0 && ret != -EDQUOT)
-		return ret;
-
-	ret = try_flush_qgroup(inode->root);
-	if (ret < 0)
-		return ret;
 	return qgroup_reserve_data(inode, reserved_ret, start, len);
 }
 
@@ -4008,22 +3999,6 @@ int btrfs_qgroup_reserve_meta(struct btrfs_root *root, int num_bytes,
 	return ret;
 }
 
-int __btrfs_qgroup_reserve_meta(struct btrfs_root *root, int num_bytes,
-				enum btrfs_qgroup_rsv_type type, bool enforce,
-				bool noflush)
-{
-	int ret;
-
-	ret = btrfs_qgroup_reserve_meta(root, num_bytes, type, enforce);
-	if ((ret <= 0 && ret != -EDQUOT) || noflush)
-		return ret;
-
-	ret = try_flush_qgroup(root);
-	if (ret < 0)
-		return ret;
-	return btrfs_qgroup_reserve_meta(root, num_bytes, type, enforce);
-}
-
 void btrfs_qgroup_free_meta_all_pertrans(struct btrfs_root *root)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index 7bffa10589d6..6dbcdab56d0c 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -369,24 +369,20 @@ int btrfs_qgroup_free_data(struct btrfs_inode *inode,
 			   u64 len);
 int btrfs_qgroup_reserve_meta(struct btrfs_root *root, int num_bytes,
 			      enum btrfs_qgroup_rsv_type type, bool enforce);
-int __btrfs_qgroup_reserve_meta(struct btrfs_root *root, int num_bytes,
-				enum btrfs_qgroup_rsv_type type, bool enforce,
-				bool noflush);
 /* Reserve metadata space for pertrans and prealloc type */
 static inline int btrfs_qgroup_reserve_meta_pertrans(struct btrfs_root *root,
 				int num_bytes, bool enforce)
 {
-	return __btrfs_qgroup_reserve_meta(root, num_bytes,
+	return btrfs_qgroup_reserve_meta(root, num_bytes,
 					   BTRFS_QGROUP_RSV_META_PERTRANS,
-					   enforce, false);
+					   enforce);
 }
 static inline int btrfs_qgroup_reserve_meta_prealloc(struct btrfs_root *root,
-						     int num_bytes, bool enforce,
-						     bool noflush)
+						     int num_bytes, bool enforce)
 {
-	return __btrfs_qgroup_reserve_meta(root, num_bytes,
+	return btrfs_qgroup_reserve_meta(root, num_bytes,
 					   BTRFS_QGROUP_RSV_META_PREALLOC,
-					   enforce, noflush);
+					   enforce);
 }
 
 void __btrfs_qgroup_free_meta(struct btrfs_root *root, int num_bytes,
@@ -439,5 +435,5 @@ int btrfs_qgroup_trace_subtree_after_cow(struct btrfs_trans_handle *trans,
 		struct btrfs_root *root, struct extent_buffer *eb);
 void btrfs_qgroup_destroy_extent_records(struct btrfs_transaction *trans);
 bool btrfs_check_quota_leak(struct btrfs_fs_info *fs_info);
-
+int btrfs_qgroup_flush(struct btrfs_root *root);
 #endif
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index aa80e51bc8ca..e8c45192b72a 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3013,8 +3013,7 @@ static int relocate_one_page(struct inode *inode, struct file_ra_state *ra,
 
 		/* Reserve metadata for this range */
 		ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode),
-						      clamped_len, clamped_len,
-						      false);
+						      clamped_len, clamped_len);
 		if (ret)
 			goto release_page;
 
diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index 859874579456..1c92a2c915d3 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -512,8 +512,7 @@ int btrfs_subvolume_reserve_metadata(struct btrfs_root *root,
 		/* One for parent inode, two for dir entries */
 		qgroup_num_bytes = 3 * fs_info->nodesize;
 		ret = btrfs_qgroup_reserve_meta_prealloc(root,
-							 qgroup_num_bytes, true,
-							 false);
+							 qgroup_num_bytes, true);
 		if (ret)
 			return ret;
 	}
-- 
2.35.3

