Return-Path: <linux-btrfs+bounces-16057-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F97B24C33
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Aug 2025 16:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3898A686560
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Aug 2025 14:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5462FFDF6;
	Wed, 13 Aug 2025 14:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="RDnc0YSM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EEF2E541C
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Aug 2025 14:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755095728; cv=none; b=T6D3VGARD8ihtDo3e40BW4PmZrjx2ptkKYnwE6D6QpLF/BcJI1dnxD0h8vzUjhBzuC0NKbD1Z+sztBuDGyGfd4AQZCe9eg0+fwWGyJ7F/UDyEVTOnXgthfr0Om3XdsrC024Taik97KSznQwDRh2peNykMdj2HYlUIpTsQjQrF+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755095728; c=relaxed/simple;
	bh=LUbRy3k6qkvZNzdA70HmWurii92cQw/ZnDEEfdW5g84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version; b=QDeAWyXys3rueLV7lu51HxA3iaLcYzD6qxbl0JpaSl30w3+YLdzOXi0ym4Zf4cnu3taUU2QkJJP9zj5WRtxWlYD6pJE0TeRKVYgLvycDHQQxwi1SEPrYAEizZKcgv44qxqEaxZIpSnXsJ8y+ZVZoUByqoYQuuGXecLNhc0rIiW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=RDnc0YSM; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from localhost.localdomain (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id 56DF62A7597;
	Wed, 13 Aug 2025 15:35:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1755095713;
	bh=cchSNkuthTSZnH+88crNUbtVdCVlTcFcWB2jtmBM+EU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RDnc0YSMknF6Jcd8RUEYhmkQi/c2yxy+q1pvvZrX5YaoV6DUrajynKF2aFpiPRKAZ
	 LfMVJdtAh2/WxDcc3ari3tg0KRWPPJLkpjeCDK5OojEjwQh54Anzv2lhcfefflK4hH
	 soTVVvfP8eptd6ZlWP8Qqm4nQ3OciT73jzV85Ses=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org
Cc: Mark Harmstone <mark@harmstone.com>
Subject: [PATCH v2 08/16] btrfs: redirect I/O for remapped block groups
Date: Wed, 13 Aug 2025 15:34:50 +0100
Message-ID: <20250813143509.31073-9-mark@harmstone.com>
In-Reply-To: <20250813143509.31073-1-mark@harmstone.com>
References: <20250813143509.31073-1-mark@harmstone.com>
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
index 7256f6748c8f..e1f1da9336e7 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3884,6 +3884,65 @@ static const char *stage_to_string(enum reloc_stage stage)
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
+	*logical = *logical - found_key.objectid + btrfs_remap_address(leaf, remap);
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
index 678e5d4cd780..a2c49cb8bfc6 100644
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


