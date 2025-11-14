Return-Path: <linux-btrfs+bounces-19010-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2ECEC5EEB5
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Nov 2025 19:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE29A3B6CDD
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Nov 2025 18:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781812E2659;
	Fri, 14 Nov 2025 18:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="soC3JKAc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4746F2DF147
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Nov 2025 18:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763146094; cv=none; b=QJoVg+eLr6vs9SPm7pmGGlmB8lIJP+t7wBRUQXQptaEpBbLrAs8Vzfp/nBKHcYfY0r4gN5rT3xL/QD793Z7retsQYNagGxaXfMjxNfUS6zyHBF8EGRfzmSz+2CVXhLPE5Bj0Igyo2SVkXpUnG8S/YseFPWvdU86IV72oW3XoYrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763146094; c=relaxed/simple;
	bh=+wJA1c7Xc3n8KnHAHII7scQvcLE0GKairqKPwueFVdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version; b=kcikgFU3bdwOyWIsEtYNiZEY+gzaJ6JLAkz+beyxTIg+CxHyOhg4SpahU3r9M2AfnPggYl2Xabhb6KhFdN8bwRSWKQqfiUmyIdj8vkWqsVfurKYZBWef+l2YetAL5sVUj1D/kRGAp4y9zPQU2VUwLvM61bNvxplt9R6k4JSBqFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=soC3JKAc; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from beren (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id 56F2D2DAB06;
	Fri, 14 Nov 2025 18:47:52 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1763146072;
	bh=cXxRU7VzW/+lJnMEvOcjDDlTb3/9RhT62KQ9LHgHn9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=soC3JKAcCQZg244U6lM00+0e1uP2JTpTtv+TK2iQol1AAWKWU7eDsSP+NDUScoY/T
	 /G+R9m4Ho7cRTubuNcZxLVGdth4wY7eZB6PsermWiFtDD22p3xmRsYnhu3yqxrr8wb
	 tFTJTOZ71I9IuVo7c69elVrQ4zf44dMKsMG9pf4s=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org
Cc: Mark Harmstone <mark@harmstone.com>,
	Boris Burkov <boris@bur.io>
Subject: [PATCH v6 08/16] btrfs: redirect I/O for remapped block groups
Date: Fri, 14 Nov 2025 18:47:13 +0000
Message-ID: <20251114184745.9304-9-mark@harmstone.com>
In-Reply-To: <20251114184745.9304-1-mark@harmstone.com>
References: <20251114184745.9304-1-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit

Change btrfs_map_block() so that if the block group has the REMAPPED
flag set, we call btrfs_translate_remap() to obtain a new address.

btrfs_translate_remap() searches the remap tree for a range
corresponding to the logical address passed to btrfs_map_block(). If it
is within an identity remap, this part of the block group hasn't yet
been relocated, and so we use the existing address.

If it is within an actual remap, we subtract the start of the remap
range and add the address of its destination, contained in the item's
payload.

Signed-off-by: Mark Harmstone <mark@harmstone.com>
Reviewed-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/relocation.c | 54 +++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/relocation.h |  2 ++
 fs/btrfs/volumes.c    | 19 +++++++++++++++
 3 files changed, 75 insertions(+)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 739fca944296..00e1898edbbe 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3860,6 +3860,60 @@ static const char *stage_to_string(enum reloc_stage stage)
 	return "unknown";
 }
 
+int btrfs_translate_remap(struct btrfs_fs_info *fs_info, u64 *logical,
+			  u64 *length)
+{
+	int ret;
+	struct btrfs_key key, found_key;
+	struct extent_buffer *leaf;
+	struct btrfs_remap *remap;
+	BTRFS_PATH_AUTO_FREE(path);
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	key.objectid = *logical;
+	key.type = (u8)-1;
+	key.offset = (u64)-1;
+
+	ret = btrfs_search_slot(NULL, fs_info->remap_root, &key, path,
+				0, 0);
+	if (ret < 0)
+		return ret;
+
+	leaf = path->nodes[0];
+
+	if (path->slots[0] == 0)
+		return -ENOENT;
+
+	path->slots[0]--;
+
+	btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
+
+	if (found_key.type != BTRFS_REMAP_KEY &&
+	    found_key.type != BTRFS_IDENTITY_REMAP_KEY) {
+		return -ENOENT;
+	}
+
+	if (found_key.objectid > *logical ||
+	    found_key.objectid + found_key.offset <= *logical) {
+		return -ENOENT;
+	}
+
+	if (*logical + *length > found_key.objectid + found_key.offset)
+		*length = found_key.objectid + found_key.offset - *logical;
+
+	if (found_key.type == BTRFS_IDENTITY_REMAP_KEY)
+		return 0;
+
+	remap = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_remap);
+
+	*logical += btrfs_remap_address(leaf, remap) - found_key.objectid;
+
+	return 0;
+}
+
 /*
  * function to relocate all extents in a block group.
  */
diff --git a/fs/btrfs/relocation.h b/fs/btrfs/relocation.h
index 5c36b3f84b57..b2ba83966650 100644
--- a/fs/btrfs/relocation.h
+++ b/fs/btrfs/relocation.h
@@ -31,5 +31,7 @@ int btrfs_should_cancel_balance(const struct btrfs_fs_info *fs_info);
 struct btrfs_root *find_reloc_root(struct btrfs_fs_info *fs_info, u64 bytenr);
 bool btrfs_should_ignore_reloc_root(const struct btrfs_root *root);
 u64 btrfs_get_reloc_bg_bytenr(const struct btrfs_fs_info *fs_info);
+int btrfs_translate_remap(struct btrfs_fs_info *fs_info, u64 *logical,
+			  u64 *length);
 
 #endif
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 453e8581650e..6a72c2a599a6 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6586,6 +6586,25 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	if (IS_ERR(map))
 		return PTR_ERR(map);
 
+	if (map->type & BTRFS_BLOCK_GROUP_REMAPPED) {
+		u64 new_logical = logical;
+
+		ret = btrfs_translate_remap(fs_info, &new_logical, length);
+		if (ret)
+			return ret;
+
+		if (new_logical != logical) {
+			btrfs_free_chunk_map(map);
+
+			map = btrfs_get_chunk_map(fs_info, new_logical,
+						  *length);
+			if (IS_ERR(map))
+				return PTR_ERR(map);
+
+			logical = new_logical;
+		}
+	}
+
 	num_copies = btrfs_chunk_map_num_copies(map);
 	if (io_geom.mirror_num > num_copies)
 		return -EINVAL;
-- 
2.51.0


