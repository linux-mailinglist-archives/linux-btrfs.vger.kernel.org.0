Return-Path: <linux-btrfs+bounces-17284-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C99A3BAB749
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Sep 2025 07:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20DB31925301
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Sep 2025 05:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6733261B9E;
	Tue, 30 Sep 2025 05:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ccvf79IK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394F52EB10
	for <linux-btrfs@vger.kernel.org>; Tue, 30 Sep 2025 05:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759209100; cv=none; b=rYFq4ZTQTILkWBuws/0+wqezPmwydyfQUHZOHCrFCm1j7wL81mw2SJ1fuXAOh7HihZcfQL5oeJdOhFy8G2unKCsihPIS9Tlh2jP11ZyHQzGUovM2ELcWjiFCqFCQlXy+ziiUi0OI+2My7bOPQNKekgAfz0cUAD9Fh8ULXvWaO44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759209100; c=relaxed/simple;
	bh=dUBZ+9UAIvJeIGvh7Wi9G8OkPGpxtAF479+uK64POvc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qsFtz+MBed+4MQHnS35xgIonfLjd24HjKuOI/1vddz0QsR8CJ4VOI8Ddm4qeOLB8Unn91rR+rLgIn5TkHkv1CphRlc5/ozVE08TranltTrl2r+eSUPMIwUgHkwKpOskzUZ3gTUf6SgMpoE6P1ZHe0loYWpg4oIVa8827ovBy3u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ccvf79IK; arc=none smtp.client-ip=209.85.219.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-7d67341add6so829556d6.1
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Sep 2025 22:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759209097; x=1759813897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o6j6GODYJOF2tyw1rETRwdJY17w+uymGZwz+n8aE3ko=;
        b=Ccvf79IKJfTD80BuiC13BbAPWh5vq8RhNlOkQMTLGB2Yyck3azzrOW+WmPWCAmD+jA
         6bh9ylBOIBcNObCm4smwgj7ObCKcaJLCUiDKkJK9XLb35jnJ7zJwAN5aj75sXesHzwNT
         9mSundlbM+3AkYzqYcYZgXRFc/UfUmDoxCK0rYUARl4ndTgfQmTt2idva9oJsaffJM5C
         9H+iQSqTKBBz0ooluc+XUirmDUvpHmveaC/U8CggNvdkaUgF7Zi+f2NCvugbOtlc+VYZ
         ckJRImjmhfEFFKtiutxZW2a0mTwYR5bzclp2+QmHITogZrIBTUHibdafp5KpmcnTdLuX
         ElZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759209097; x=1759813897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o6j6GODYJOF2tyw1rETRwdJY17w+uymGZwz+n8aE3ko=;
        b=fkJqgee3vUIGEI57xJpBSczNf1liwiCRsG58Q3fXD+wP83kv1w7m/xSVNDmOIvXSZs
         CU3XmWbsRjK2pOOqCnNg0zcNNSha0uAGIzVY6XNE9LUeSd+3eSdadiDmhhGJK6Z244UZ
         j5umGtSEXu3u49cF6yAkUGTb/XYhrQABbXUdiqhsQIkRlvmhwSiEcxAseswo1puOzkau
         81YnvBOj2DIVBIgnYLMIaZqXlbpe2lXbDXtxCaZCJLMP5/UFKDEyI3H0wk5mh1YePq9d
         M7o2LGju9UTJTn3G9C0gtkVTjNOOr7B31RbXFZxU26Il0r3PoxOECl1pA9/9FAZIthPD
         0EXw==
X-Gm-Message-State: AOJu0YwBVp8QriUaCm8F2iRFZ89bLAgWzwjsrmVAPqhZb4RccQAp97kv
	aWgoQqUEMRLh/tBPECPvH44jIKsNbgjLV5IpZ01DxcfpCSQkENKCeOsCOzqQal7f3o29zg==
X-Gm-Gg: ASbGnctA2QTlYAL7rlcIaVyrz5T0B3vl9Su7uJ+GcAxQOpjxemZj55mIT74Yml9M5Qt
	6BFGT5Kc5Qs6otEi5TUm3s9F5BULcq1rnxeyXljitfTtwI37133JJCMVHX43NUBiejWM5KtYEh7
	LSNOz5WBJo0thwhRWsvXjII77C1ukDWBsLijBDzYvxZFuHQ9fVROIZxuRu6IyX/M0ktlgJ87kfx
	5du0zez8Lz2WEnljruZw0fzAPiTiDvMxB/p1aowhSICsq0QQaU7du9UpQec8ICCoaISleAzFlG5
	ZLPBRazbMKg4Eh64u39CkpLPZPQ3vjrKR5f6d/e5AuXWbS/goIDJsWAQxoU2zCSTiBpmshD2Tym
	9XQdoi6/3TwwxW4HmET9+BaS002Cm8fidGwrdIdQw1IVh+pQesluA
X-Google-Smtp-Source: AGHT+IG+OlExkk47Si+dIkhQKweO6ZpafVI6eGQsSA+Cd8WOYT/uCO7bVVShsL+VKygC4aXCrttvuA==
X-Received: by 2002:a05:6214:528d:b0:815:e14a:1f44 with SMTP id 6a1803df08f44-815e14a1f99mr145514706d6.0.1759209096763;
        Mon, 29 Sep 2025 22:11:36 -0700 (PDT)
Received: from SaltyKitkat ([154.3.38.40])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-80142f5d6d1sm87946026d6.33.2025.09.29.22.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 22:11:36 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH] btrfs: more trivial BTRFS_PATH_AUTO_FREE conversions
Date: Tue, 30 Sep 2025 13:09:07 +0800
Message-ID: <20250930050918.31029-2-sunk67188@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Trivial pattern for the auto freeing without goto -> return conversions.
No other function cleanup.

Tested with btrfs/auto group.

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/uuid-tree.c | 12 ++++--------
 fs/btrfs/verity.c    |  9 +++------
 fs/btrfs/volumes.c   | 44 ++++++++++++++------------------------------
 fs/btrfs/xattr.c     |  7 ++-----
 4 files changed, 23 insertions(+), 49 deletions(-)

diff --git a/fs/btrfs/uuid-tree.c b/fs/btrfs/uuid-tree.c
index 17b5e81123a1..30e5d80adda9 100644
--- a/fs/btrfs/uuid-tree.c
+++ b/fs/btrfs/uuid-tree.c
@@ -27,7 +27,7 @@ static int btrfs_uuid_tree_lookup(struct btrfs_root *uuid_root, const u8 *uuid,
 				  u8 type, u64 subid)
 {
 	int ret;
-	struct btrfs_path *path = NULL;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct extent_buffer *eb;
 	int slot;
 	u32 item_size;
@@ -79,7 +79,6 @@ static int btrfs_uuid_tree_lookup(struct btrfs_root *uuid_root, const u8 *uuid,
 	}
 
 out:
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -89,7 +88,7 @@ int btrfs_uuid_tree_add(struct btrfs_trans_handle *trans, const u8 *uuid, u8 typ
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_root *uuid_root = fs_info->uuid_root;
 	int ret;
-	struct btrfs_path *path = NULL;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	struct extent_buffer *eb;
 	int slot;
@@ -141,7 +140,6 @@ int btrfs_uuid_tree_add(struct btrfs_trans_handle *trans, const u8 *uuid, u8 typ
 	subid_le = cpu_to_le64(subid_cpu);
 	write_extent_buffer(eb, &subid_le, offset, sizeof(subid_le));
 out:
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -151,7 +149,7 @@ int btrfs_uuid_tree_remove(struct btrfs_trans_handle *trans, const u8 *uuid, u8
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_root *uuid_root = fs_info->uuid_root;
 	int ret;
-	struct btrfs_path *path = NULL;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	struct extent_buffer *eb;
 	int slot;
@@ -223,7 +221,6 @@ int btrfs_uuid_tree_remove(struct btrfs_trans_handle *trans, const u8 *uuid, u8
 	btrfs_truncate_item(trans, path, item_size - sizeof(subid), 1);
 
 out:
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -293,7 +290,7 @@ int btrfs_uuid_tree_iterate(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_root *root = fs_info->uuid_root;
 	struct btrfs_key key;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	int ret = 0;
 	struct extent_buffer *leaf;
 	int slot;
@@ -387,7 +384,6 @@ int btrfs_uuid_tree_iterate(struct btrfs_fs_info *fs_info)
 	}
 
 out:
-	btrfs_free_path(path);
 	return ret;
 }
 
diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
index 4633cbcfcdb9..b1903030faf4 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -109,7 +109,7 @@ static int drop_verity_items(struct btrfs_inode *inode, u8 key_type)
 {
 	struct btrfs_trans_handle *trans;
 	struct btrfs_root *root = inode->root;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	int count = 0;
 	int ret;
@@ -170,7 +170,6 @@ static int drop_verity_items(struct btrfs_inode *inode, u8 key_type)
 	ret = count;
 	btrfs_end_transaction(trans);
 out:
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -217,7 +216,7 @@ static int write_key_bytes(struct btrfs_inode *inode, u8 key_type, u64 offset,
 			   const char *src, u64 len)
 {
 	struct btrfs_trans_handle *trans;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_root *root = inode->root;
 	struct extent_buffer *leaf;
 	struct btrfs_key key;
@@ -267,7 +266,6 @@ static int write_key_bytes(struct btrfs_inode *inode, u8 key_type, u64 offset,
 		btrfs_end_transaction(trans);
 	}
 
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -296,7 +294,7 @@ static int write_key_bytes(struct btrfs_inode *inode, u8 key_type, u64 offset,
 static int read_key_bytes(struct btrfs_inode *inode, u8 key_type, u64 offset,
 			  char *dest, u64 len, struct folio *dest_folio)
 {
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_root *root = inode->root;
 	struct extent_buffer *leaf;
 	struct btrfs_key key;
@@ -404,7 +402,6 @@ static int read_key_bytes(struct btrfs_inode *inode, u8 key_type, u64 offset,
 		}
 	}
 out:
-	btrfs_free_path(path);
 	if (!ret)
 		ret = copied;
 	return ret;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c6e3efd6f602..18d28789f52e 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1681,7 +1681,7 @@ static int find_free_dev_extent(struct btrfs_device *device, u64 num_bytes,
 	struct btrfs_root *root = fs_info->dev_root;
 	struct btrfs_key key;
 	struct btrfs_dev_extent *dev_extent;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	u64 search_start;
 	u64 hole_size;
 	u64 max_hole_start;
@@ -1812,7 +1812,6 @@ static int find_free_dev_extent(struct btrfs_device *device, u64 num_bytes,
 	       "max_hole_start=%llu max_hole_size=%llu search_end=%llu",
 	       max_hole_start, max_hole_size, search_end);
 out:
-	btrfs_free_path(path);
 	*start = max_hole_start;
 	if (len)
 		*len = max_hole_size;
@@ -1826,7 +1825,7 @@ static int btrfs_free_dev_extent(struct btrfs_trans_handle *trans,
 	struct btrfs_fs_info *fs_info = device->fs_info;
 	struct btrfs_root *root = fs_info->dev_root;
 	int ret;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	struct btrfs_key found_key;
 	struct extent_buffer *leaf = NULL;
@@ -1869,7 +1868,6 @@ static int btrfs_free_dev_extent(struct btrfs_trans_handle *trans,
 	if (ret == 0)
 		set_bit(BTRFS_TRANS_HAVE_FREE_BGS, &trans->transaction->flags);
 out:
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -1897,7 +1895,7 @@ static noinline int find_next_devid(struct btrfs_fs_info *fs_info,
 	int ret;
 	struct btrfs_key key;
 	struct btrfs_key found_key;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -1930,7 +1928,6 @@ static noinline int find_next_devid(struct btrfs_fs_info *fs_info,
 	}
 	ret = 0;
 error:
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -1942,7 +1939,7 @@ static int btrfs_add_dev_item(struct btrfs_trans_handle *trans,
 			    struct btrfs_device *device)
 {
 	int ret;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_dev_item *dev_item;
 	struct extent_buffer *leaf;
 	struct btrfs_key key;
@@ -1989,7 +1986,6 @@ static int btrfs_add_dev_item(struct btrfs_trans_handle *trans,
 
 	ret = 0;
 out:
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -2017,7 +2013,7 @@ static int btrfs_rm_dev_item(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_root *root = device->fs_info->chunk_root;
 	int ret;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 
 	path = btrfs_alloc_path();
@@ -2039,7 +2035,6 @@ static int btrfs_rm_dev_item(struct btrfs_trans_handle *trans,
 
 	ret = btrfs_del_item(trans, root, path);
 out:
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -2626,7 +2621,7 @@ static int btrfs_finish_sprout(struct btrfs_trans_handle *trans)
 	BTRFS_DEV_LOOKUP_ARGS(args);
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_root *root = fs_info->chunk_root;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct extent_buffer *leaf;
 	struct btrfs_dev_item *dev_item;
 	struct btrfs_device *device;
@@ -2690,7 +2685,6 @@ static int btrfs_finish_sprout(struct btrfs_trans_handle *trans)
 	}
 	ret = 0;
 error:
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -2946,7 +2940,7 @@ static noinline int btrfs_update_device(struct btrfs_trans_handle *trans,
 					struct btrfs_device *device)
 {
 	int ret;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_root *root = device->fs_info->chunk_root;
 	struct btrfs_dev_item *dev_item;
 	struct extent_buffer *leaf;
@@ -2982,7 +2976,6 @@ static noinline int btrfs_update_device(struct btrfs_trans_handle *trans,
 	btrfs_set_device_bytes_used(leaf, dev_item,
 				    btrfs_device_get_bytes_used(device));
 out:
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -3035,7 +3028,7 @@ static int btrfs_free_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_root *root = fs_info->chunk_root;
 	int ret;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 
 	path = btrfs_alloc_path();
@@ -3064,7 +3057,6 @@ static int btrfs_free_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
 		goto out;
 	}
 out:
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -3501,7 +3493,7 @@ int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset,
 static int btrfs_relocate_sys_chunks(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_root *chunk_root = fs_info->chunk_root;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct extent_buffer *leaf;
 	struct btrfs_chunk *chunk;
 	struct btrfs_key key;
@@ -3580,7 +3572,6 @@ static int btrfs_relocate_sys_chunks(struct btrfs_fs_info *fs_info)
 		ret = -ENOSPC;
 	}
 error:
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -4709,7 +4700,7 @@ int btrfs_recover_balance(struct btrfs_fs_info *fs_info)
 	struct btrfs_balance_control *bctl;
 	struct btrfs_balance_item *item;
 	struct btrfs_disk_balance_args disk_bargs;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct extent_buffer *leaf;
 	struct btrfs_key key;
 	int ret;
@@ -4772,7 +4763,6 @@ int btrfs_recover_balance(struct btrfs_fs_info *fs_info)
 	spin_unlock(&fs_info->balance_lock);
 	mutex_unlock(&fs_info->balance_mutex);
 out:
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -7455,7 +7445,7 @@ static void readahead_tree_node_children(struct extent_buffer *node)
 int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_root *root = fs_info->chunk_root;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct extent_buffer *leaf;
 	struct btrfs_key key;
 	struct btrfs_key found_key;
@@ -7572,8 +7562,6 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
 	ret = 0;
 error:
 	mutex_unlock(&uuid_mutex);
-
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -7673,7 +7661,7 @@ int btrfs_init_dev_stats(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices, *seed_devs;
 	struct btrfs_device *device;
-	struct btrfs_path *path = NULL;
+	BTRFS_PATH_AUTO_FREE(path);
 	int ret = 0;
 
 	path = btrfs_alloc_path();
@@ -7695,8 +7683,6 @@ int btrfs_init_dev_stats(struct btrfs_fs_info *fs_info)
 	}
 out:
 	mutex_unlock(&fs_devices->device_list_mutex);
-
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -7705,7 +7691,7 @@ static int update_dev_stat_item(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_root *dev_root = fs_info->dev_root;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	struct extent_buffer *eb;
 	struct btrfs_dev_stats_item *ptr;
@@ -7759,7 +7745,6 @@ static int update_dev_stat_item(struct btrfs_trans_handle *trans,
 		btrfs_set_dev_stats_value(eb, ptr, i,
 					  btrfs_dev_stat_read(device, i));
 out:
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -8051,7 +8036,7 @@ static int verify_chunk_dev_extent_mapping(struct btrfs_fs_info *fs_info)
  */
 int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info)
 {
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_root *root = fs_info->dev_root;
 	struct btrfs_key key;
 	u64 prev_devid = 0;
@@ -8141,7 +8126,6 @@ int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info)
 	/* Ensure all chunks have corresponding dev extents */
 	ret = verify_chunk_dev_extent_mapping(fs_info);
 out:
-	btrfs_free_path(path);
 	return ret;
 }
 
diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
index 79fb1614bd0c..7fec70dfe06b 100644
--- a/fs/btrfs/xattr.c
+++ b/fs/btrfs/xattr.c
@@ -29,7 +29,7 @@ int btrfs_getxattr(const struct inode *inode, const char *name,
 {
 	struct btrfs_dir_item *di;
 	struct btrfs_root *root = BTRFS_I(inode)->root;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct extent_buffer *leaf;
 	int ret = 0;
 	unsigned long data_ptr;
@@ -76,7 +76,6 @@ int btrfs_getxattr(const struct inode *inode, const char *name,
 	ret = btrfs_dir_data_len(leaf, di);
 
 out:
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -278,7 +277,7 @@ ssize_t btrfs_listxattr(struct dentry *dentry, char *buffer, size_t size)
 	struct btrfs_key key;
 	struct inode *inode = d_inode(dentry);
 	struct btrfs_root *root = BTRFS_I(inode)->root;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	int iter_ret = 0;
 	int ret = 0;
 	size_t total_size = 0, size_left = size;
@@ -354,8 +353,6 @@ ssize_t btrfs_listxattr(struct dentry *dentry, char *buffer, size_t size)
 	else
 		ret = total_size;
 
-	btrfs_free_path(path);
-
 	return ret;
 }
 
-- 
2.51.0


