Return-Path: <linux-btrfs+bounces-17576-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35477BC8CF5
	for <lists+linux-btrfs@lfdr.de>; Thu, 09 Oct 2025 13:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8B573A4C33
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Oct 2025 11:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF952E1EE7;
	Thu,  9 Oct 2025 11:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="VAcu4Ki2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (unknown [62.3.69.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600222E092B
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Oct 2025 11:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.3.69.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760009301; cv=none; b=nE02U/SSjKP1ijdsSNb1ho8XtaptD+THL/Qxwwb0hH1ETl9VLeABMxKQiihNlUPUy4FAQ+Ky6SROomouJeQtp1GNhSztxV2rThgsWY+BnW+/ZOHFt1W4VPrLzriYoaJXHFn8kgV5kJeavcknGX49TKzGgoSOYfSL8G1Wze+SDj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760009301; c=relaxed/simple;
	bh=wPxsIKwSsIdjpXFdEy/kWTNK1jdAeOWMxJaVWVo1/+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version; b=gkUYlXjWzcRyHAZh1bH1fWRloqnCXPXHtiZ3BO63qATknKgMu1buEvKy0cY8OPg6nMgjkfn0wDnMYGU+7EtlcYHZE7xoBIRiYcytzEWrdT+/PlkgTyu2NJIQBYtaKTaxMBExZ2gyU4ufUc/NmVAQuMPsEGL+RHa4PTkmNuOFewo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=fail smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=VAcu4Ki2; arc=none smtp.client-ip=62.3.69.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=harmstone.com
Received: from localhost.localdomain (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id 9709C2C5655;
	Thu,  9 Oct 2025 12:28:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1760009288;
	bh=gSQjQC92IkI38zC5U+Cph+X7qAWqssxTA6ZmcsRzs9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VAcu4Ki2MF7oLlYffbFQ0jbvaQNzBTa7/LS2eGuBNW/0Uk9/r/YF3XnBn/3BY+rzU
	 kMP3GL0EncMZndCy1RF6CFEkJV66VAJkhlO93LQKvLjT7DlNqIzCz2gQ0oIrY7T0ew
	 Gb51CXOW7E1262rCZF183snOPGc3e/fN8hrO/aNE=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org
Cc: Mark Harmstone <mark@harmstone.com>
Subject: [PATCH v3 08/17] btrfs: redirect I/O for remapped block groups
Date: Thu,  9 Oct 2025 12:28:03 +0100
Message-ID: <20251009112814.13942-9-mark@harmstone.com>
In-Reply-To: <20251009112814.13942-1-mark@harmstone.com>
References: <20251009112814.13942-1-mark@harmstone.com>
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
---
 fs/btrfs/relocation.c | 59 +++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/relocation.h |  2 ++
 fs/btrfs/volumes.c    | 31 +++++++++++++++++++++++
 3 files changed, 92 insertions(+)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 748290758459..4f5d3aaf0f65 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3870,6 +3870,65 @@ static const char *stage_to_string(enum reloc_stage stage)
 	return "unknown";
 }
 
+int btrfs_translate_remap(struct btrfs_fs_info *fs_info, u64 *logical,
+			  u64 *length, bool nolock)
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
+	if (nolock) {
+		path->search_commit_root = 1;
+		path->skip_locking = 1;
+	}
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
index 5c36b3f84b57..a653c42a25a3 100644
--- a/fs/btrfs/relocation.h
+++ b/fs/btrfs/relocation.h
@@ -31,5 +31,7 @@ int btrfs_should_cancel_balance(const struct btrfs_fs_info *fs_info);
 struct btrfs_root *find_reloc_root(struct btrfs_fs_info *fs_info, u64 bytenr);
 bool btrfs_should_ignore_reloc_root(const struct btrfs_root *root);
 u64 btrfs_get_reloc_bg_bytenr(const struct btrfs_fs_info *fs_info);
+int btrfs_translate_remap(struct btrfs_fs_info *fs_info, u64 *logical,
+			  u64 *length, bool nolock);
 
 #endif
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 0abe02a7072f..f2d1203778aa 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6635,6 +6635,37 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	if (IS_ERR(map))
 		return PTR_ERR(map);
 
+	if (map->type & BTRFS_BLOCK_GROUP_REMAPPED) {
+		u64 new_logical = logical;
+		bool nolock = !(map->type & BTRFS_BLOCK_GROUP_DATA);
+
+		/*
+		 * We use search_commit_root in btrfs_translate_remap for
+		 * metadata blocks, to avoid lockdep complaining about
+		 * recursive locking.
+		 * If we get -ENOENT this means this is a BG that has just had
+		 * its REMAPPED flag set, and so nothing has yet been actually
+		 * remapped.
+		 */
+		ret = btrfs_translate_remap(fs_info, &new_logical, length,
+					    nolock);
+		if (ret && (!nolock || ret != -ENOENT))
+			return ret;
+
+		if (ret != -ENOENT && new_logical != logical) {
+			btrfs_free_chunk_map(map);
+
+			map = btrfs_get_chunk_map(fs_info, new_logical,
+						  *length);
+			if (IS_ERR(map))
+				return PTR_ERR(map);
+
+			logical = new_logical;
+		}
+
+		ret = 0;
+	}
+
 	num_copies = btrfs_chunk_map_num_copies(map);
 	if (io_geom.mirror_num > num_copies)
 		return -EINVAL;
-- 
2.49.1


