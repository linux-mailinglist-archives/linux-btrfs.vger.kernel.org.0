Return-Path: <linux-btrfs+bounces-17430-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FDFBB8EDA
	for <lists+linux-btrfs@lfdr.de>; Sat, 04 Oct 2025 16:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C2C73C6090
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Oct 2025 14:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35D421CC5B;
	Sat,  4 Oct 2025 14:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQdjoJAD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E151D5CDE
	for <linux-btrfs@vger.kernel.org>; Sat,  4 Oct 2025 14:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759588291; cv=none; b=m0m2VQhgAs75xEEfM1N3tbfhIQmvwYCgZ3WZb/Qj/e9htXuhQ5qEFxuswTS0GQ4mJMIcF0qU93A/geU2Nf3Osde1N5CsCJp3QNhitpP9Jh8que+aX5L5trWjbrm//yUQRto+WPKpKNd8bEjSqN8rrTn5osiidX6Xr8akJM00cZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759588291; c=relaxed/simple;
	bh=UbcwfuXLhtRUI38G9nrsDhRd0BAg9o9mZ4ABh8pTR3o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DnL292ccB8dRAC3mQ+KS0ODo9BlMGEMmkLQMaxGBEvKqNaawNwGCdX5HuJgvTy5LO0aDsfbYOM2tcELN2YyvvkOOatuQVfWSFbmqp1V1SVUxwY66ZO2lmC4MqhD5PANRX8zyxcRl2pqa2l/1GBianDBSAjM3oVhiJ1QvSWvLJAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OQdjoJAD; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-339a7744495so529736a91.0
        for <linux-btrfs@vger.kernel.org>; Sat, 04 Oct 2025 07:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759588288; x=1760193088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s5T316lgY0FG0GwBwtiyE75aBnSX3pTEnD8yqGqWY48=;
        b=OQdjoJADxqDEEaZteR0MfwazLr1YZ5CclTgN1bKqMG9e/szRHCtHAiGcItGZ++TQ3E
         9yAS76YML9tXB1cNRR+YOljK0M4Vk8gX2CjwLOV9H7FbvYubhE5oc7AYbjij0noU+KGw
         FNvnecLsuZc0+PW6n1KekqIWA9R+qqy50e2td+vz1tE+brCtZ6134x9cwy7LF2TrGIP/
         tAYF1XYyBC3rwYLiIUO0RZm7FumfBbbgBNbe/s2Xf8CPbKh2BFi1E/sF2+NqbAuhCMfM
         frbonLlXW/gryg+Z8nK+Zj7oPoncGAc7JiwETEtI3xwkSJ3Mww1kq953YCGOuxaJFs9P
         bqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759588288; x=1760193088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s5T316lgY0FG0GwBwtiyE75aBnSX3pTEnD8yqGqWY48=;
        b=ZPm8EGDujvHWIQvetZrOJvnZ/4xG0mQaVbHIV7Q8dUxC1AFDRFnQLY6Zm0n04wR9xt
         1mUy2EoVqCmzWIVU/h/sW1NDYc9ZXG9eB921Gqbg0EUV3Z39VxawCksmvyFSnlsEuf6p
         m9hkpPNy7MLK16lD7f5YFu44jazpOpfw4VlbovPgk5W3/4D2qnYsPGec6i8/uefi4XKZ
         Z0ptvfwIWprGwiKyrcKzfY8GPixHpZAySypCPCJ8dHcbH5t6Dmc1VAJ7As+ndWDf2lqA
         mqB7IXLv1kd3u/4A8HO+iUgw4/JOEr0FHhfM+DJ+W9xTcTZiBKHpacPcBgz+ql34dKB6
         2WwA==
X-Gm-Message-State: AOJu0YzblWQ5rJhllCRLBcrBCTLASfrGSyg6tuYctS3TrcJvKgOtJcDv
	X/EoRGHum9IsXj/De0AiNaMTms4j7uyWE2iiKYz4mX1vjNyPA90q0pK5GPmbd06x5G4Iow==
X-Gm-Gg: ASbGncs+NT7nxofwBTJ2NcTVTeic17wyRRuGHyBdVfuglJewrohLa0WFV4Md07o07Ek
	VwqeKrZ/5kNjxGpLmImCr9KP4ZyIXWJHX+8gWGCEDio43UnoAfdwTgnMfcy6+WbhSyGRXkJ98XW
	x6kkTuOn55ZI5R8feQ4uTa5L8ehzef0MCab/IvBLHhHkHxnQefbDY6kP5TeeNfCD2gOIG+PBiLR
	oeMK6EBoF2GfbkVet2dNKtUVtjFQmViGxvtl+q/JeQn4Q5iVpoRhesiUlrCYRPi8wYoRbJAcL4T
	JokgBbKigBi/eQXPOEN+WjafE2ZaBPI3Him7JSPSons2/oZVe3lgJUx+HYYokAQmw2AexQLvImC
	vlMaoOrqr52FmQ7fw8OuVXHu1sHJUI2G/zYgBzKmSXIFLo6BT4HBGh78KuZa6LXEEww==
X-Google-Smtp-Source: AGHT+IGiPDzHcg7vWnX+PoODAJdAA73LWemGUMoOuHnOTiKYHfvih4YifKvNqpuYwHXR9/eX3X9tnA==
X-Received: by 2002:a17:90b:4c4a:b0:32e:4924:68f8 with SMTP id 98e67ed59e1d1-339c2727366mr4258710a91.2.1759588287710;
        Sat, 04 Oct 2025 07:31:27 -0700 (PDT)
Received: from SaltyKitkat ([141.11.76.106])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6e9d22bsm11229081a91.3.2025.10.04.07.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Oct 2025 07:31:27 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH v2] btrfs: more trivial BTRFS_PATH_AUTO_FREE conversions
Date: Sat,  4 Oct 2025 22:31:09 +0800
Message-ID: <20251004143114.21847-1-sunk67188@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Trivial pattern for the auto freeing with goto -> return conversions.
No other function cleanup.

---

Changelog:
v1 -> v2:
* Add goto -> return conversions

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/uuid-tree.c | 114 ++++++++++++----------------------
 fs/btrfs/verity.c    |  23 +++----
 fs/btrfs/volumes.c   | 142 +++++++++++++++----------------------------
 fs/btrfs/xattr.c     |  36 ++++-------
 4 files changed, 109 insertions(+), 206 deletions(-)

diff --git a/fs/btrfs/uuid-tree.c b/fs/btrfs/uuid-tree.c
index 17b5e81123a1..8dd71df277c1 100644
--- a/fs/btrfs/uuid-tree.c
+++ b/fs/btrfs/uuid-tree.c
@@ -27,32 +27,26 @@ static int btrfs_uuid_tree_lookup(struct btrfs_root *uuid_root, const u8 *uuid,
 				  u8 type, u64 subid)
 {
 	int ret;
-	struct btrfs_path *path = NULL;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct extent_buffer *eb;
 	int slot;
 	u32 item_size;
 	unsigned long offset;
 	struct btrfs_key key;
 
-	if (WARN_ON_ONCE(!uuid_root)) {
-		ret = -ENOENT;
-		goto out;
-	}
+	if (WARN_ON_ONCE(!uuid_root))
+		return -ENOENT;
 
 	path = btrfs_alloc_path();
-	if (!path) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!path)
+		return -ENOMEM;
 
 	btrfs_uuid_to_key(uuid, type, &key);
 	ret = btrfs_search_slot(NULL, uuid_root, &key, path, 0, 0);
-	if (ret < 0) {
-		goto out;
-	} else if (ret > 0) {
-		ret = -ENOENT;
-		goto out;
-	}
+	if (ret < 0)
+		return ret;
+	if (ret > 0)
+		return -ENOENT;
 
 	eb = path->nodes[0];
 	slot = path->slots[0];
@@ -64,7 +58,7 @@ static int btrfs_uuid_tree_lookup(struct btrfs_root *uuid_root, const u8 *uuid,
 		btrfs_warn(uuid_root->fs_info,
 			   "uuid item with illegal size %lu!",
 			   (unsigned long)item_size);
-		goto out;
+		return ret;
 	}
 	while (item_size) {
 		__le64 data;
@@ -78,8 +72,6 @@ static int btrfs_uuid_tree_lookup(struct btrfs_root *uuid_root, const u8 *uuid,
 		item_size -= sizeof(data);
 	}
 
-out:
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -89,7 +81,7 @@ int btrfs_uuid_tree_add(struct btrfs_trans_handle *trans, const u8 *uuid, u8 typ
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_root *uuid_root = fs_info->uuid_root;
 	int ret;
-	struct btrfs_path *path = NULL;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	struct extent_buffer *eb;
 	int slot;
@@ -100,18 +92,14 @@ int btrfs_uuid_tree_add(struct btrfs_trans_handle *trans, const u8 *uuid, u8 typ
 	if (ret != -ENOENT)
 		return ret;
 
-	if (WARN_ON_ONCE(!uuid_root)) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (WARN_ON_ONCE(!uuid_root))
+		return -EINVAL;
 
 	btrfs_uuid_to_key(uuid, type, &key);
 
 	path = btrfs_alloc_path();
-	if (!path) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!path)
+		return -ENOMEM;
 
 	ret = btrfs_insert_empty_item(trans, uuid_root, path, &key,
 				      sizeof(subid_le));
@@ -134,15 +122,12 @@ int btrfs_uuid_tree_add(struct btrfs_trans_handle *trans, const u8 *uuid, u8 typ
 		btrfs_warn(fs_info,
 			   "insert uuid item failed %d (0x%016llx, 0x%016llx) type %u!",
 			   ret, key.objectid, key.offset, type);
-		goto out;
+		return ret;
 	}
 
-	ret = 0;
 	subid_le = cpu_to_le64(subid_cpu);
 	write_extent_buffer(eb, &subid_le, offset, sizeof(subid_le));
-out:
-	btrfs_free_path(path);
-	return ret;
+	return 0;
 }
 
 int btrfs_uuid_tree_remove(struct btrfs_trans_handle *trans, const u8 *uuid, u8 type,
@@ -151,7 +136,7 @@ int btrfs_uuid_tree_remove(struct btrfs_trans_handle *trans, const u8 *uuid, u8
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_root *uuid_root = fs_info->uuid_root;
 	int ret;
-	struct btrfs_path *path = NULL;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	struct extent_buffer *eb;
 	int slot;
@@ -161,29 +146,23 @@ int btrfs_uuid_tree_remove(struct btrfs_trans_handle *trans, const u8 *uuid, u8
 	unsigned long move_src;
 	unsigned long move_len;
 
-	if (WARN_ON_ONCE(!uuid_root)) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (WARN_ON_ONCE(!uuid_root))
+		return -EINVAL;
 
 	btrfs_uuid_to_key(uuid, type, &key);
 
 	path = btrfs_alloc_path();
-	if (!path) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!path)
+		return -ENOMEM;
 
 	ret = btrfs_search_slot(trans, uuid_root, &key, path, -1, 1);
 	if (ret < 0) {
 		btrfs_warn(fs_info, "error %d while searching for uuid item!",
 			   ret);
-		goto out;
-	}
-	if (ret > 0) {
-		ret = -ENOENT;
-		goto out;
+		return ret;
 	}
+	if (ret > 0)
+		return -ENOENT;
 
 	eb = path->nodes[0];
 	slot = path->slots[0];
@@ -192,8 +171,7 @@ int btrfs_uuid_tree_remove(struct btrfs_trans_handle *trans, const u8 *uuid, u8
 	if (!IS_ALIGNED(item_size, sizeof(u64))) {
 		btrfs_warn(fs_info, "uuid item with illegal size %lu!",
 			   (unsigned long)item_size);
-		ret = -ENOENT;
-		goto out;
+		return -ENOENT;
 	}
 	while (item_size) {
 		__le64 read_subid;
@@ -205,26 +183,19 @@ int btrfs_uuid_tree_remove(struct btrfs_trans_handle *trans, const u8 *uuid, u8
 		item_size -= sizeof(read_subid);
 	}
 
-	if (!item_size) {
-		ret = -ENOENT;
-		goto out;
-	}
+	if (!item_size)
+		return -ENOENT;
 
 	item_size = btrfs_item_size(eb, slot);
-	if (item_size == sizeof(subid)) {
-		ret = btrfs_del_item(trans, uuid_root, path);
-		goto out;
-	}
+	if (item_size == sizeof(subid))
+		return btrfs_del_item(trans, uuid_root, path);
 
 	move_dst = offset;
 	move_src = offset + sizeof(subid);
 	move_len = item_size - (move_src - btrfs_item_ptr_offset(eb, slot));
 	memmove_extent_buffer(eb, move_dst, move_src, move_len);
 	btrfs_truncate_item(trans, path, item_size - sizeof(subid), 1);
-
-out:
-	btrfs_free_path(path);
-	return ret;
+	return 0;
 }
 
 static int btrfs_uuid_iter_rem(struct btrfs_root *uuid_root, u8 *uuid, u8 type,
@@ -293,7 +264,7 @@ int btrfs_uuid_tree_iterate(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_root *root = fs_info->uuid_root;
 	struct btrfs_key key;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	int ret = 0;
 	struct extent_buffer *leaf;
 	int slot;
@@ -301,10 +272,8 @@ int btrfs_uuid_tree_iterate(struct btrfs_fs_info *fs_info)
 	unsigned long offset;
 
 	path = btrfs_alloc_path();
-	if (!path) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!path)
+		return -ENOMEM;
 
 	key.objectid = 0;
 	key.type = 0;
@@ -315,14 +284,13 @@ int btrfs_uuid_tree_iterate(struct btrfs_fs_info *fs_info)
 	if (ret) {
 		if (ret > 0)
 			ret = 0;
-		goto out;
+		return ret;
 	}
 
 	while (1) {
-		if (btrfs_fs_closing(fs_info)) {
-			ret = -EINTR;
-			goto out;
-		}
+		if (btrfs_fs_closing(fs_info))
+			return -EINTR;
+
 		cond_resched();
 		leaf = path->nodes[0];
 		slot = path->slots[0];
@@ -353,7 +321,7 @@ int btrfs_uuid_tree_iterate(struct btrfs_fs_info *fs_info)
 			ret = btrfs_check_uuid_tree_entry(fs_info, uuid,
 							  key.type, subid_cpu);
 			if (ret < 0)
-				goto out;
+				return ret;
 			if (ret > 0) {
 				btrfs_release_path(path);
 				ret = btrfs_uuid_iter_rem(root, uuid, key.type,
@@ -369,7 +337,7 @@ int btrfs_uuid_tree_iterate(struct btrfs_fs_info *fs_info)
 					goto again_search_slot;
 				}
 				if (ret < 0 && ret != -ENOENT)
-					goto out;
+					return ret;
 				key.offset++;
 				goto again_search_slot;
 			}
@@ -386,8 +354,6 @@ int btrfs_uuid_tree_iterate(struct btrfs_fs_info *fs_info)
 		break;
 	}
 
-out:
-	btrfs_free_path(path);
 	return ret;
 }
 
diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
index 46bd8ca58670..0f9054ea74ab 100644
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
@@ -121,10 +121,8 @@ static int drop_verity_items(struct btrfs_inode *inode, u8 key_type)
 	while (1) {
 		/* 1 for the item being dropped */
 		trans = btrfs_start_transaction(root, 1);
-		if (IS_ERR(trans)) {
-			ret = PTR_ERR(trans);
-			goto out;
-		}
+		if (IS_ERR(trans))
+			return PTR_ERR(trans);
 
 		/*
 		 * Walk backwards through all the items until we find one that
@@ -143,7 +141,7 @@ static int drop_verity_items(struct btrfs_inode *inode, u8 key_type)
 			path->slots[0]--;
 		} else if (ret < 0) {
 			btrfs_end_transaction(trans);
-			goto out;
+			return ret;
 		}
 
 		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
@@ -161,17 +159,14 @@ static int drop_verity_items(struct btrfs_inode *inode, u8 key_type)
 		ret = btrfs_del_items(trans, root, path, path->slots[0], 1);
 		if (ret) {
 			btrfs_end_transaction(trans);
-			goto out;
+			return ret;
 		}
 		count++;
 		btrfs_release_path(path);
 		btrfs_end_transaction(trans);
 	}
-	ret = count;
 	btrfs_end_transaction(trans);
-out:
-	btrfs_free_path(path);
-	return ret;
+	return count;
 }
 
 /*
@@ -217,7 +212,7 @@ static int write_key_bytes(struct btrfs_inode *inode, u8 key_type, u64 offset,
 			   const char *src, u64 len)
 {
 	struct btrfs_trans_handle *trans;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_root *root = inode->root;
 	struct extent_buffer *leaf;
 	struct btrfs_key key;
@@ -267,7 +262,6 @@ static int write_key_bytes(struct btrfs_inode *inode, u8 key_type, u64 offset,
 		btrfs_end_transaction(trans);
 	}
 
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -296,7 +290,7 @@ static int write_key_bytes(struct btrfs_inode *inode, u8 key_type, u64 offset,
 static int read_key_bytes(struct btrfs_inode *inode, u8 key_type, u64 offset,
 			  char *dest, u64 len, struct folio *dest_folio)
 {
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_root *root = inode->root;
 	struct extent_buffer *leaf;
 	struct btrfs_key key;
@@ -404,7 +398,6 @@ static int read_key_bytes(struct btrfs_inode *inode, u8 key_type, u64 offset,
 		}
 	}
 out:
-	btrfs_free_path(path);
 	if (!ret)
 		ret = copied;
 	return ret;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 2bec544d8ba3..de750ea9f68d 100644
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
@@ -1845,7 +1844,7 @@ static int btrfs_free_dev_extent(struct btrfs_trans_handle *trans,
 		ret = btrfs_previous_item(root, path, key.objectid,
 					  BTRFS_DEV_EXTENT_KEY);
 		if (ret)
-			goto out;
+			return ret;
 		leaf = path->nodes[0];
 		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
 		extent = btrfs_item_ptr(leaf, path->slots[0],
@@ -1860,7 +1859,7 @@ static int btrfs_free_dev_extent(struct btrfs_trans_handle *trans,
 		extent = btrfs_item_ptr(leaf, path->slots[0],
 					struct btrfs_dev_extent);
 	} else {
-		goto out;
+		return ret;
 	}
 
 	*dev_extent_len = btrfs_dev_extent_length(leaf, extent);
@@ -1868,8 +1867,6 @@ static int btrfs_free_dev_extent(struct btrfs_trans_handle *trans,
 	ret = btrfs_del_item(trans, root, path);
 	if (ret == 0)
 		set_bit(BTRFS_TRANS_HAVE_FREE_BGS, &trans->transaction->flags);
-out:
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -1897,7 +1894,7 @@ static noinline int find_next_devid(struct btrfs_fs_info *fs_info,
 	int ret;
 	struct btrfs_key key;
 	struct btrfs_key found_key;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -1909,13 +1906,12 @@ static noinline int find_next_devid(struct btrfs_fs_info *fs_info,
 
 	ret = btrfs_search_slot(NULL, fs_info->chunk_root, &key, path, 0, 0);
 	if (ret < 0)
-		goto error;
+		return ret;
 
 	if (unlikely(ret == 0)) {
 		/* Corruption */
 		btrfs_err(fs_info, "corrupted chunk tree devid -1 matched");
-		ret = -EUCLEAN;
-		goto error;
+		return -EUCLEAN;
 	}
 
 	ret = btrfs_previous_item(fs_info->chunk_root, path,
@@ -1928,10 +1924,7 @@ static noinline int find_next_devid(struct btrfs_fs_info *fs_info,
 				      path->slots[0]);
 		*devid_ret = found_key.offset + 1;
 	}
-	ret = 0;
-error:
-	btrfs_free_path(path);
-	return ret;
+	return 0;
 }
 
 /*
@@ -1942,7 +1935,7 @@ static int btrfs_add_dev_item(struct btrfs_trans_handle *trans,
 			    struct btrfs_device *device)
 {
 	int ret;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_dev_item *dev_item;
 	struct extent_buffer *leaf;
 	struct btrfs_key key;
@@ -1961,7 +1954,7 @@ static int btrfs_add_dev_item(struct btrfs_trans_handle *trans,
 				      &key, sizeof(*dev_item));
 	btrfs_trans_release_chunk_metadata(trans);
 	if (ret)
-		goto out;
+		return ret;
 
 	leaf = path->nodes[0];
 	dev_item = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_dev_item);
@@ -1987,10 +1980,7 @@ static int btrfs_add_dev_item(struct btrfs_trans_handle *trans,
 	write_extent_buffer(leaf, trans->fs_info->fs_devices->metadata_uuid,
 			    ptr, BTRFS_FSID_SIZE);
 
-	ret = 0;
-out:
-	btrfs_free_path(path);
-	return ret;
+	return 0;
 }
 
 /*
@@ -2017,7 +2007,7 @@ static int btrfs_rm_dev_item(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_root *root = device->fs_info->chunk_root;
 	int ret;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 
 	path = btrfs_alloc_path();
@@ -2034,12 +2024,10 @@ static int btrfs_rm_dev_item(struct btrfs_trans_handle *trans,
 	if (ret) {
 		if (ret > 0)
 			ret = -ENOENT;
-		goto out;
+		return ret;
 	}
 
 	ret = btrfs_del_item(trans, root, path);
-out:
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -2626,7 +2614,7 @@ static int btrfs_finish_sprout(struct btrfs_trans_handle *trans)
 	BTRFS_DEV_LOOKUP_ARGS(args);
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_root *root = fs_info->chunk_root;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct extent_buffer *leaf;
 	struct btrfs_dev_item *dev_item;
 	struct btrfs_device *device;
@@ -2648,7 +2636,7 @@ static int btrfs_finish_sprout(struct btrfs_trans_handle *trans)
 		ret = btrfs_search_slot(trans, root, &key, path, 0, 1);
 		btrfs_trans_release_chunk_metadata(trans);
 		if (ret < 0)
-			goto error;
+			return ret;
 
 		leaf = path->nodes[0];
 next_slot:
@@ -2657,7 +2645,7 @@ static int btrfs_finish_sprout(struct btrfs_trans_handle *trans)
 			if (ret > 0)
 				break;
 			if (ret < 0)
-				goto error;
+				return ret;
 			leaf = path->nodes[0];
 			btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
 			btrfs_release_path(path);
@@ -2688,10 +2676,7 @@ static int btrfs_finish_sprout(struct btrfs_trans_handle *trans)
 		path->slots[0]++;
 		goto next_slot;
 	}
-	ret = 0;
-error:
-	btrfs_free_path(path);
-	return ret;
+	return 0;
 }
 
 int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path)
@@ -2946,7 +2931,7 @@ static noinline int btrfs_update_device(struct btrfs_trans_handle *trans,
 					struct btrfs_device *device)
 {
 	int ret;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_root *root = device->fs_info->chunk_root;
 	struct btrfs_dev_item *dev_item;
 	struct extent_buffer *leaf;
@@ -2962,12 +2947,10 @@ static noinline int btrfs_update_device(struct btrfs_trans_handle *trans,
 
 	ret = btrfs_search_slot(trans, root, &key, path, 0, 1);
 	if (ret < 0)
-		goto out;
+		return ret;
 
-	if (ret > 0) {
-		ret = -ENOENT;
-		goto out;
-	}
+	if (ret > 0)
+		return -ENOENT;
 
 	leaf = path->nodes[0];
 	dev_item = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_dev_item);
@@ -2981,8 +2964,6 @@ static noinline int btrfs_update_device(struct btrfs_trans_handle *trans,
 				     btrfs_device_get_disk_total_bytes(device));
 	btrfs_set_device_bytes_used(leaf, dev_item,
 				    btrfs_device_get_bytes_used(device));
-out:
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -3035,7 +3016,7 @@ static int btrfs_free_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_root *root = fs_info->chunk_root;
 	int ret;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 
 	path = btrfs_alloc_path();
@@ -3048,23 +3029,20 @@ static int btrfs_free_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
 
 	ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
 	if (ret < 0)
-		goto out;
-	else if (unlikely(ret > 0)) { /* Logic error or corruption */
+		return ret;
+	if (unlikely(ret > 0)) { /* Logic error or corruption */
 		btrfs_err(fs_info, "failed to lookup chunk %llu when freeing",
 			  chunk_offset);
 		btrfs_abort_transaction(trans, -ENOENT);
-		ret = -EUCLEAN;
-		goto out;
+		return -EUCLEAN;
 	}
 
 	ret = btrfs_del_item(trans, root, path);
 	if (unlikely(ret < 0)) {
 		btrfs_err(fs_info, "failed to delete chunk %llu item", chunk_offset);
 		btrfs_abort_transaction(trans, ret);
-		goto out;
+		return ret;
 	}
-out:
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -3501,7 +3479,7 @@ int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset,
 static int btrfs_relocate_sys_chunks(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_root *chunk_root = fs_info->chunk_root;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct extent_buffer *leaf;
 	struct btrfs_chunk *chunk;
 	struct btrfs_key key;
@@ -3525,7 +3503,7 @@ static int btrfs_relocate_sys_chunks(struct btrfs_fs_info *fs_info)
 		ret = btrfs_search_slot(NULL, chunk_root, &key, path, 0, 0);
 		if (ret < 0) {
 			mutex_unlock(&fs_info->reclaim_bgs_lock);
-			goto error;
+			return ret;
 		}
 		if (unlikely(ret == 0)) {
 			/*
@@ -3535,9 +3513,8 @@ static int btrfs_relocate_sys_chunks(struct btrfs_fs_info *fs_info)
 			 * offset (one less than the previous one, wrong
 			 * alignment and size).
 			 */
-			ret = -EUCLEAN;
 			mutex_unlock(&fs_info->reclaim_bgs_lock);
-			goto error;
+			return -EUCLEAN;
 		}
 
 		ret = btrfs_previous_item(chunk_root, path, key.objectid,
@@ -3545,7 +3522,7 @@ static int btrfs_relocate_sys_chunks(struct btrfs_fs_info *fs_info)
 		if (ret)
 			mutex_unlock(&fs_info->reclaim_bgs_lock);
 		if (ret < 0)
-			goto error;
+			return ret;
 		if (ret > 0)
 			break;
 
@@ -3579,8 +3556,6 @@ static int btrfs_relocate_sys_chunks(struct btrfs_fs_info *fs_info)
 	} else if (WARN_ON(failed && retried)) {
 		ret = -ENOSPC;
 	}
-error:
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -4709,7 +4684,7 @@ int btrfs_recover_balance(struct btrfs_fs_info *fs_info)
 	struct btrfs_balance_control *bctl;
 	struct btrfs_balance_item *item;
 	struct btrfs_disk_balance_args disk_bargs;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct extent_buffer *leaf;
 	struct btrfs_key key;
 	int ret;
@@ -4724,17 +4699,14 @@ int btrfs_recover_balance(struct btrfs_fs_info *fs_info)
 
 	ret = btrfs_search_slot(NULL, fs_info->tree_root, &key, path, 0, 0);
 	if (ret < 0)
-		goto out;
+		return ret;
 	if (ret > 0) { /* ret = -ENOENT; */
-		ret = 0;
-		goto out;
+		return 0;
 	}
 
 	bctl = kzalloc(sizeof(*bctl), GFP_NOFS);
-	if (!bctl) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!bctl)
+		return -ENOMEM;
 
 	leaf = path->nodes[0];
 	item = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_balance_item);
@@ -4771,8 +4743,6 @@ int btrfs_recover_balance(struct btrfs_fs_info *fs_info)
 	fs_info->balance_ctl = bctl;
 	spin_unlock(&fs_info->balance_lock);
 	mutex_unlock(&fs_info->balance_mutex);
-out:
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -7455,7 +7425,7 @@ static void readahead_tree_node_children(struct extent_buffer *node)
 int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_root *root = fs_info->chunk_root;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct extent_buffer *leaf;
 	struct btrfs_key key;
 	struct btrfs_key found_key;
@@ -7572,8 +7542,6 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
 	ret = 0;
 error:
 	mutex_unlock(&uuid_mutex);
-
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -7673,7 +7641,7 @@ int btrfs_init_dev_stats(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices, *seed_devs;
 	struct btrfs_device *device;
-	struct btrfs_path *path = NULL;
+	BTRFS_PATH_AUTO_FREE(path);
 	int ret = 0;
 
 	path = btrfs_alloc_path();
@@ -7695,8 +7663,6 @@ int btrfs_init_dev_stats(struct btrfs_fs_info *fs_info)
 	}
 out:
 	mutex_unlock(&fs_devices->device_list_mutex);
-
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -7705,7 +7671,7 @@ static int update_dev_stat_item(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_root *dev_root = fs_info->dev_root;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	struct extent_buffer *eb;
 	struct btrfs_dev_stats_item *ptr;
@@ -7724,7 +7690,7 @@ static int update_dev_stat_item(struct btrfs_trans_handle *trans,
 		btrfs_warn(fs_info,
 			"error %d while searching for dev_stats item for device %s",
 				  ret, btrfs_dev_name(device));
-		goto out;
+		return ret;
 	}
 
 	if (ret == 0 &&
@@ -7735,7 +7701,7 @@ static int update_dev_stat_item(struct btrfs_trans_handle *trans,
 			btrfs_warn(fs_info,
 				"delete too small dev_stats item for device %s failed %d",
 					  btrfs_dev_name(device), ret);
-			goto out;
+			return ret;
 		}
 		ret = 1;
 	}
@@ -7749,7 +7715,7 @@ static int update_dev_stat_item(struct btrfs_trans_handle *trans,
 			btrfs_warn(fs_info,
 				"insert dev_stats item for device %s failed %d",
 				btrfs_dev_name(device), ret);
-			goto out;
+			return ret;
 		}
 	}
 
@@ -7758,8 +7724,6 @@ static int update_dev_stat_item(struct btrfs_trans_handle *trans,
 	for (i = 0; i < BTRFS_DEV_STAT_VALUES_MAX; i++)
 		btrfs_set_dev_stats_value(eb, ptr, i,
 					  btrfs_dev_stat_read(device, i));
-out:
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -8049,7 +8013,7 @@ static int verify_chunk_dev_extent_mapping(struct btrfs_fs_info *fs_info)
  */
 int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info)
 {
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_root *root = fs_info->dev_root;
 	struct btrfs_key key;
 	u64 prev_devid = 0;
@@ -8080,17 +8044,15 @@ int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info)
 	path->reada = READA_FORWARD;
 	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	if (path->slots[0] >= btrfs_header_nritems(path->nodes[0])) {
 		ret = btrfs_next_leaf(root, path);
 		if (ret < 0)
-			goto out;
+			return ret;
 		/* No dev extents at all? Not good */
-		if (unlikely(ret > 0)) {
-			ret = -EUCLEAN;
-			goto out;
-		}
+		if (unlikely(ret > 0))
+			return -EUCLEAN;
 	}
 	while (1) {
 		struct extent_buffer *leaf = path->nodes[0];
@@ -8116,20 +8078,19 @@ int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info)
 			btrfs_err(fs_info,
 "dev extent devid %llu physical offset %llu overlap with previous dev extent end %llu",
 				  devid, physical_offset, prev_dev_ext_end);
-			ret = -EUCLEAN;
-			goto out;
+			return -EUCLEAN;
 		}
 
 		ret = verify_one_dev_extent(fs_info, chunk_offset, devid,
 					    physical_offset, physical_len);
 		if (ret < 0)
-			goto out;
+			return ret;
 		prev_devid = devid;
 		prev_dev_ext_end = physical_offset + physical_len;
 
 		ret = btrfs_next_item(root, path);
 		if (ret < 0)
-			goto out;
+			return ret;
 		if (ret > 0) {
 			ret = 0;
 			break;
@@ -8137,10 +8098,7 @@ int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info)
 	}
 
 	/* Ensure all chunks have corresponding dev extents */
-	ret = verify_chunk_dev_extent_mapping(fs_info);
-out:
-	btrfs_free_path(path);
-	return ret;
+	return verify_chunk_dev_extent_mapping(fs_info);
 }
 
 /*
diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
index 79fb1614bd0c..3d27eb1e2f74 100644
--- a/fs/btrfs/xattr.c
+++ b/fs/btrfs/xattr.c
@@ -29,9 +29,8 @@ int btrfs_getxattr(const struct inode *inode, const char *name,
 {
 	struct btrfs_dir_item *di;
 	struct btrfs_root *root = BTRFS_I(inode)->root;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct extent_buffer *leaf;
-	int ret = 0;
 	unsigned long data_ptr;
 
 	path = btrfs_alloc_path();
@@ -41,26 +40,19 @@ int btrfs_getxattr(const struct inode *inode, const char *name,
 	/* lookup the xattr by name */
 	di = btrfs_lookup_xattr(NULL, root, path, btrfs_ino(BTRFS_I(inode)),
 			name, strlen(name), 0);
-	if (!di) {
-		ret = -ENODATA;
-		goto out;
-	} else if (IS_ERR(di)) {
-		ret = PTR_ERR(di);
-		goto out;
-	}
+	if (!di)
+		return -ENODATA;
+	if (IS_ERR(di))
+		return PTR_ERR(di);
 
 	leaf = path->nodes[0];
 	/* if size is 0, that means we want the size of the attr */
-	if (!size) {
-		ret = btrfs_dir_data_len(leaf, di);
-		goto out;
-	}
+	if (!size)
+		return btrfs_dir_data_len(leaf, di);
 
 	/* now get the data out of our dir_item */
-	if (btrfs_dir_data_len(leaf, di) > size) {
-		ret = -ERANGE;
-		goto out;
-	}
+	if (btrfs_dir_data_len(leaf, di) > size)
+		return -ERANGE;
 
 	/*
 	 * The way things are packed into the leaf is like this
@@ -73,11 +65,7 @@ int btrfs_getxattr(const struct inode *inode, const char *name,
 				   btrfs_dir_name_len(leaf, di));
 	read_extent_buffer(leaf, buffer, data_ptr,
 			   btrfs_dir_data_len(leaf, di));
-	ret = btrfs_dir_data_len(leaf, di);
-
-out:
-	btrfs_free_path(path);
-	return ret;
+	return btrfs_dir_data_len(leaf, di);
 }
 
 int btrfs_setxattr(struct btrfs_trans_handle *trans, struct inode *inode,
@@ -278,7 +266,7 @@ ssize_t btrfs_listxattr(struct dentry *dentry, char *buffer, size_t size)
 	struct btrfs_key key;
 	struct inode *inode = d_inode(dentry);
 	struct btrfs_root *root = BTRFS_I(inode)->root;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	int iter_ret = 0;
 	int ret = 0;
 	size_t total_size = 0, size_left = size;
@@ -354,8 +342,6 @@ ssize_t btrfs_listxattr(struct dentry *dentry, char *buffer, size_t size)
 	else
 		ret = total_size;
 
-	btrfs_free_path(path);
-
 	return ret;
 }
 
-- 
2.51.0


