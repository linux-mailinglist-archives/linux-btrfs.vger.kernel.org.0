Return-Path: <linux-btrfs+bounces-14733-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3BDADD5D4
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 18:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B716540022B
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 16:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A902EE26D;
	Tue, 17 Jun 2025 16:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4Ny/ULd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1182EE264
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 16:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176795; cv=none; b=BIJzq9kqqPoKKjULeeqJsPu9+S7wPe3/EHAlw+EHFOyOGPgjLW+XjnLClf5+9XEqkO77U3c5BZMwxqd+8+k22p3RNTBO9kTWTvyU7GQeAQvQ4ybHQkweKmGx6w8Rjsu8uEzZkZdmoR5CTfWosyx8mnMebuUVD0m69mgUQ44ptPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176795; c=relaxed/simple;
	bh=E/I0Gb8hJryIOmcJCs+krnnkZnjCCBoNq8zyNYdpVc0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fwXd2Mm3hqWqNEbVczQB1+2QFB3Y0lzNmodkBvjZHaDDW5nPDqKNOs3KBl1hkxrVnPcrkrArFXdQCD/djJGGnLTtfh+lQPMq8kremAA+hvWhfU1Wkt7ZpEeyolxzodZ4bA1kvLPt7NBoxaJ9VgZsLrND2O97WVPaPck7vWhGERE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4Ny/ULd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F168C4CEE7
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 16:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750176795;
	bh=E/I0Gb8hJryIOmcJCs+krnnkZnjCCBoNq8zyNYdpVc0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=L4Ny/ULdop4wuYYBSOSSLB4Xm+EtPL2ES5zriG5VpyIaW3fkGcXyzPBkHCrv3T1Kx
	 9o0iWGjoclUlEthZQOwjUUbK9MqXL8VI8QJKRblRwUdBrrd7CuCuxTN0sydTDvdbnO
	 jK680dgdnknDGYzkpmcHu0F3w6+r2YS5ZWfClSVzGYnCzbcg1P6exqFHxkvkBWzlAp
	 l/hP+9gheIpS+WQFoqAJ8pPPVI1RN5PoKW3lgvFTc4CQarT20Uplc3bjGI2n9N1PJd
	 W4h8D1bMgnmFPypsdCAlr7GLbhEEkw9Hd7Kq/82eK0etHDpUyt0I8rts6Sn9rdMrIP
	 YszmUE53DPBnA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 04/16] btrfs: make free_space_test_bit() return a boolean instead
Date: Tue, 17 Jun 2025 17:12:59 +0100
Message-ID: <55f2de2aa39cbe869fb0ae4d83082cd59aedca39.1750075579.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1750075579.git.fdmanana@suse.com>
References: <cover.1750075579.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The function returns the result of another function that returns a boolean
(extent_buffer_test_bit()), and all the callers need is a boolean an not
an integer. So change its return type from int to bool, and modify the
callers to store results in booleans instead of integers, which also makes
them simpler.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/free-space-tree.c | 37 ++++++++++++++++++-------------------
 fs/btrfs/free-space-tree.h |  4 ++--
 2 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index b24c23312892..4cd1f46cd694 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -513,8 +513,8 @@ static int update_free_space_extent_count(struct btrfs_trans_handle *trans,
 }
 
 EXPORT_FOR_TESTS
-int free_space_test_bit(struct btrfs_block_group *block_group,
-			struct btrfs_path *path, u64 offset)
+bool free_space_test_bit(struct btrfs_block_group *block_group,
+			 struct btrfs_path *path, u64 offset)
 {
 	struct extent_buffer *leaf;
 	struct btrfs_key key;
@@ -612,7 +612,8 @@ static int modify_free_space_bitmap(struct btrfs_trans_handle *trans,
 	struct btrfs_key key;
 	u64 end = start + size;
 	u64 cur_start, cur_size;
-	int prev_bit, next_bit;
+	bool prev_bit_set = false;
+	bool next_bit_set = false;
 	int new_extents;
 	int ret;
 
@@ -631,7 +632,7 @@ static int modify_free_space_bitmap(struct btrfs_trans_handle *trans,
 		if (ret)
 			goto out;
 
-		prev_bit = free_space_test_bit(block_group, path, prev_block);
+		prev_bit_set = free_space_test_bit(block_group, path, prev_block);
 
 		/* The previous block may have been in the previous bitmap. */
 		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
@@ -648,8 +649,6 @@ static int modify_free_space_bitmap(struct btrfs_trans_handle *trans,
 		ret = btrfs_search_prev_slot(trans, root, &key, path, 0, 1);
 		if (ret)
 			goto out;
-
-		prev_bit = -1;
 	}
 
 	/*
@@ -681,28 +680,26 @@ static int modify_free_space_bitmap(struct btrfs_trans_handle *trans,
 				goto out;
 		}
 
-		next_bit = free_space_test_bit(block_group, path, end);
-	} else {
-		next_bit = -1;
+		next_bit_set = free_space_test_bit(block_group, path, end);
 	}
 
 	if (remove) {
 		new_extents = -1;
-		if (prev_bit == 1) {
+		if (prev_bit_set) {
 			/* Leftover on the left. */
 			new_extents++;
 		}
-		if (next_bit == 1) {
+		if (next_bit_set) {
 			/* Leftover on the right. */
 			new_extents++;
 		}
 	} else {
 		new_extents = 1;
-		if (prev_bit == 1) {
+		if (prev_bit_set) {
 			/* Merging with neighbor on the left. */
 			new_extents--;
 		}
-		if (next_bit == 1) {
+		if (next_bit_set) {
 			/* Merging with neighbor on the right. */
 			new_extents--;
 		}
@@ -1552,7 +1549,7 @@ static int load_free_space_bitmaps(struct btrfs_caching_control *caching_ctl,
 	struct btrfs_fs_info *fs_info;
 	struct btrfs_root *root;
 	struct btrfs_key key;
-	int prev_bit = 0, bit;
+	bool prev_bit_set = false;
 	/* Initialize to silence GCC. */
 	u64 extent_start = 0;
 	u64 end, offset;
@@ -1583,10 +1580,12 @@ static int load_free_space_bitmaps(struct btrfs_caching_control *caching_ctl,
 
 		offset = key.objectid;
 		while (offset < key.objectid + key.offset) {
-			bit = free_space_test_bit(block_group, path, offset);
-			if (prev_bit == 0 && bit == 1) {
+			bool bit_set;
+
+			bit_set = free_space_test_bit(block_group, path, offset);
+			if (!prev_bit_set && bit_set) {
 				extent_start = offset;
-			} else if (prev_bit == 1 && bit == 0) {
+			} else if (prev_bit_set && !bit_set) {
 				u64 space_added;
 
 				ret = btrfs_add_new_free_space(block_group,
@@ -1602,11 +1601,11 @@ static int load_free_space_bitmaps(struct btrfs_caching_control *caching_ctl,
 				}
 				extent_count++;
 			}
-			prev_bit = bit;
+			prev_bit_set = bit_set;
 			offset += fs_info->sectorsize;
 		}
 	}
-	if (prev_bit == 1) {
+	if (prev_bit_set) {
 		ret = btrfs_add_new_free_space(block_group, extent_start, end, NULL);
 		if (ret)
 			goto out;
diff --git a/fs/btrfs/free-space-tree.h b/fs/btrfs/free-space-tree.h
index e6c6d6f4f221..32e71d0c8dd4 100644
--- a/fs/btrfs/free-space-tree.h
+++ b/fs/btrfs/free-space-tree.h
@@ -53,8 +53,8 @@ int convert_free_space_to_bitmaps(struct btrfs_trans_handle *trans,
 int convert_free_space_to_extents(struct btrfs_trans_handle *trans,
 				  struct btrfs_block_group *block_group,
 				  struct btrfs_path *path);
-int free_space_test_bit(struct btrfs_block_group *block_group,
-			struct btrfs_path *path, u64 offset);
+bool free_space_test_bit(struct btrfs_block_group *block_group,
+			 struct btrfs_path *path, u64 offset);
 #endif
 
 #endif
-- 
2.47.2


