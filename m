Return-Path: <linux-btrfs+bounces-16836-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 756F7B58247
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Sep 2025 18:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 162701B205C4
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Sep 2025 16:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD31286433;
	Mon, 15 Sep 2025 16:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uPm3sIYt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4EC2874EA
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Sep 2025 16:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757954248; cv=none; b=Dhl9epRLsbJEalMVTTA1c4vkb5CRCy/u9NakSjg6DWChmb+lXdDlGPBjQ7Kqp+RWu3X9zhIB01ZAIE7L0OXDQ19mVwiw/jp38TjllkVKmxTM9YLkkZRv+6s/LxMXF8daOWCmkOonMoCLTdmtRZvFoMC/E/VwlO9GAHEIzA7AlZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757954248; c=relaxed/simple;
	bh=NKWlyhcQyCfucRvE+/NaOzn1+G1FqJnCHQp7uA0aGzg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=owZnYIfOBWsrtecDyqVnNPdixLxgKlYRchvVmMwoz/KTM39/8iWjLsJ1u+8M4wGmfRNTnO1WIAbRtVcGxSHdXh222r/hgWBBhNDQWlByc8y8Lz+78oszilS8M1jYiZfreL+p0lTfAl4LpRc652ycDXbQy65aP5uk428BBlnz82s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uPm3sIYt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E72C4CEFA
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Sep 2025 16:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757954247;
	bh=NKWlyhcQyCfucRvE+/NaOzn1+G1FqJnCHQp7uA0aGzg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=uPm3sIYtoUC6GDVukdscXe8nQpb6UDv2eSdwKZnYIWVq5xZbFlOpX2Fs9U1PWBDZJ
	 XLRX/U0RQX+VnqcMin/oRxvPDIOMZsU9y+IzZlVdhcWRFdqzsg9x832jH1PEQfYQsX
	 uVOdp4Uvyht2W5gXnHlcSsIoEG13on3/0KJKIXLke+QZuTmXgPdCRR2VzBeFvD4zgM
	 ra0ttWt6UVSWD3EQlZ0t85G1AmFp4rkfYHImxDRrygR7MkmewCevISBRSmNrHaQaNS
	 ksf86S/KOzLcyxD3suIemIIRKqSB53sumhbIQ/4FBDv75CgBQzDRElpjfd6gOzoUdh
	 /Vu3hOXoKjemQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 11/11] btrfs: print-tree: print key types as human readable strings
Date: Mon, 15 Sep 2025 17:37:13 +0100
Message-ID: <74a826edd670f56b098b10c429125c96e3bc446b.1757952682.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1757952682.git.fdmanana@suse.com>
References: <cover.1757952682.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Looking at a leaf dump from the kernel's print-tree implementation is not
so friendly to analyse since key types are printed as numbers. Improve on
this by printing key types as strings that are a diminutive of the macro
names for key types, just like we do in btrfs-progs.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/print-tree.c | 68 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index 02ad18abefb9..62b993fae54f 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -13,6 +13,12 @@
 #include "volumes.h"
 #include "raid-stripe-tree.h"
 
+/*
+ * Large enough buffer size for the stringification of any key type yet short
+ * enough to use the stack and avoid allocations.
+ */
+#define KEY_TYPE_BUF_SIZE 32
+
 struct root_name_map {
 	u64 id;
 	const char *name;
@@ -366,6 +372,60 @@ static void print_file_extent_item(const struct extent_buffer *eb, int i)
 		btrfs_file_extent_compression(eb, fi));
 }
 
+static void key_type_string(const struct btrfs_key *key, char *buf, int buf_size)
+{
+	static const char *key_to_str[256] = {
+		[BTRFS_INODE_ITEM_KEY]			= "INODE_ITEM",
+		[BTRFS_INODE_REF_KEY]			= "INODE_REF",
+		[BTRFS_INODE_EXTREF_KEY]		= "INODE_EXTREF",
+		[BTRFS_DIR_ITEM_KEY]			= "DIR_ITEM",
+		[BTRFS_DIR_INDEX_KEY]			= "DIR_INDEX",
+		[BTRFS_DIR_LOG_ITEM_KEY]		= "DIR_LOG_ITEM",
+		[BTRFS_DIR_LOG_INDEX_KEY]		= "DIR_LOG_INDEX",
+		[BTRFS_XATTR_ITEM_KEY]			= "XATTR_ITEM",
+		[BTRFS_VERITY_DESC_ITEM_KEY]		= "VERITY_DESC_ITEM",
+		[BTRFS_VERITY_MERKLE_ITEM_KEY]		= "VERITY_MERKLE_ITEM",
+		[BTRFS_ORPHAN_ITEM_KEY]			= "ORPHAN_ITEM",
+		[BTRFS_ROOT_ITEM_KEY]			= "ROOT_ITEM",
+		[BTRFS_ROOT_REF_KEY]			= "ROOT_REF",
+		[BTRFS_ROOT_BACKREF_KEY]		= "ROOT_BACKREF",
+		[BTRFS_EXTENT_ITEM_KEY]			= "EXTENT_ITEM",
+		[BTRFS_METADATA_ITEM_KEY]		= "METADATA_ITEM",
+		[BTRFS_TREE_BLOCK_REF_KEY]		= "TREE_BLOCK_REF",
+		[BTRFS_SHARED_BLOCK_REF_KEY]		= "SHARED_BLOCK_REF",
+		[BTRFS_EXTENT_DATA_REF_KEY]		= "EXTENT_DATA_REF",
+		[BTRFS_SHARED_DATA_REF_KEY]		= "SHARED_DATA_REF",
+		[BTRFS_EXTENT_OWNER_REF_KEY]		= "EXTENT_OWNER_REF",
+		[BTRFS_EXTENT_CSUM_KEY]			= "EXTENT_CSUM",
+		[BTRFS_EXTENT_DATA_KEY]			= "EXTENT_DATA",
+		[BTRFS_BLOCK_GROUP_ITEM_KEY]		= "BLOCK_GROUP_ITEM",
+		[BTRFS_FREE_SPACE_INFO_KEY]		= "FREE_SPACE_INFO",
+		[BTRFS_FREE_SPACE_EXTENT_KEY]		= "FREE_SPACE_EXTENT",
+		[BTRFS_FREE_SPACE_BITMAP_KEY]		= "FREE_SPACE_BITMAP",
+		[BTRFS_CHUNK_ITEM_KEY]			= "CHUNK_ITEM",
+		[BTRFS_DEV_ITEM_KEY]			= "DEV_ITEM",
+		[BTRFS_DEV_EXTENT_KEY]			= "DEV_EXTENT",
+		[BTRFS_TEMPORARY_ITEM_KEY]		= "TEMPORARY_ITEM",
+		[BTRFS_DEV_REPLACE_KEY]			= "DEV_REPLACE",
+		[BTRFS_STRING_ITEM_KEY]			= "STRING_ITEM",
+		[BTRFS_QGROUP_STATUS_KEY]		= "QGROUP_STATUS",
+		[BTRFS_QGROUP_RELATION_KEY]		= "QGROUP_RELATION",
+		[BTRFS_QGROUP_INFO_KEY]			= "QGROUP_INFO",
+		[BTRFS_QGROUP_LIMIT_KEY]		= "QGROUP_LIMIT",
+		[BTRFS_PERSISTENT_ITEM_KEY]		= "PERSISTENT_ITEM",
+		[BTRFS_UUID_KEY_SUBVOL]			= "UUID_KEY_SUBVOL",
+		[BTRFS_UUID_KEY_RECEIVED_SUBVOL]	= "UUID_KEY_RECEIVED_SUBVOL",
+		[BTRFS_RAID_STRIPE_KEY]			= "RAID_STRIPE",
+	};
+
+	if (key->type == 0 && key->objectid == BTRFS_FREE_SPACE_OBJECTID)
+		scnprintf(buf, buf_size, "UNTYPED");
+	else if (key_to_str[key->type])
+		scnprintf(buf, buf_size, key_to_str[key->type]);
+	else
+		scnprintf(buf, buf_size, "UNKNOWN.%d", key->type);
+}
+
 void btrfs_print_leaf(const struct extent_buffer *l)
 {
 	struct btrfs_fs_info *fs_info;
@@ -390,10 +450,14 @@ void btrfs_print_leaf(const struct extent_buffer *l)
 		   btrfs_leaf_free_space(l), btrfs_header_owner(l));
 	print_eb_refs_lock(l);
 	for (i = 0 ; i < nr ; i++) {
+		char key_buf[KEY_TYPE_BUF_SIZE];
+
 		btrfs_item_key_to_cpu(l, &key, i);
 		type = key.type;
-		pr_info("\titem %d key (%llu %u %llu) itemoff %d itemsize %d\n",
-			i, key.objectid, type, key.offset,
+		key_type_string(&key, key_buf, KEY_TYPE_BUF_SIZE);
+
+		pr_info("\titem %d key (%llu %s %llu) itemoff %d itemsize %d\n",
+			i, key.objectid, key_buf, key.offset,
 			btrfs_item_offset(l, i), btrfs_item_size(l, i));
 		switch (type) {
 		case BTRFS_INODE_ITEM_KEY:
-- 
2.47.2


