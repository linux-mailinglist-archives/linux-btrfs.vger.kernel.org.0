Return-Path: <linux-btrfs+bounces-17335-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1CEBB4125
	for <lists+linux-btrfs@lfdr.de>; Thu, 02 Oct 2025 15:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08CFD189FDC5
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Oct 2025 13:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8E9310652;
	Thu,  2 Oct 2025 13:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFf49ap5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C16279DD3
	for <linux-btrfs@vger.kernel.org>; Thu,  2 Oct 2025 13:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759412424; cv=none; b=sVYXsy61RicpHTnj2nVaWODtS39kUbgIdCc5dS72abmpgGmF+7n3qSSP/iD+IOy8lj9TE/vnFKj+UnR2urgqqfS8RWxHLNOBIMquUM2YzokVWGBi4L4naNtTo4WFNXhbFZPTumsyPNdmB99R5f+r3YOe5hd24G8jH/2Jh7K3hHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759412424; c=relaxed/simple;
	bh=5L95I3DHT00GkoHnti8BqaYuWTSzWua7rZbhNYPx4m8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YWBKdcQHk7Q7x7WYSuMr0SWvWG9K5zNLpPDJJJod5e+HNV/rRyB3pUKax+fGuY+h/zY3xEXQLLWHYjVmZ7NGlQNMIfX9qK2fFqJDTx5wCVvJ6ZPdi0f7iEdcYb2AMHME4XVFFaMjmTdolqK1iTZloh35OQHD1isXcSJAt7e+524=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFf49ap5; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-269ba651d06so1846465ad.0
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Oct 2025 06:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759412421; x=1760017221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SKY+BjemJB4mqdWWsgjSGx/pEi0eq85pvYV48TqoqZk=;
        b=BFf49ap54ihvI7ZBQC/NVv15EtdPISswbg9ef8fXIT8ge5jJBO4Jhhu6Fk9Uzks4cM
         mLbQBWLQguskP2DgBhvRMIK9Wyx0hgkuTY/6DQ8r/kx7eN1sPTxLWqEIdyht447uqjRQ
         OfdWFpGLLA3W7D3bnEyoZWW0qKrq0gbSPjBAzulaL7ES7ytYP2mr3rG2de312PbWFYyK
         R1qHQCkt0ABKl+bH8jVkabMREq1vRXY4FjVQH+33m/1uNbTn23a0GJsX686ooCo0n/ff
         2o6g/89HHhQjkwsregr8HZG675O9maUqptx00Yav4V+UTE8mD2wELQxTg2YPHyL0C1VT
         PgBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759412421; x=1760017221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SKY+BjemJB4mqdWWsgjSGx/pEi0eq85pvYV48TqoqZk=;
        b=VOtURCDPSpkZdhUvgUytGMH5otSOec1J/IaCsiS0YdU1DHF3KeffHOGzezZjnKhJUF
         QT/bTPvUnbBrqOHMe0UAMBb3DfdhRK1Vnh2mgr0cuXwfCkbvb+c1Hdb/pkUXSJkZrSNV
         +adawIWvjoejgCzVWvzCntnkOcYnzMGfV8ZkK1WD8hj1yxOc2/kmQat7rxGPtpflU91Q
         Ghv9LwrE85YSj0XaGDLTDDay0cBt7Bu1X3S8VEXPobM0ClkwH6z9zbSJBxRE9wovCMg8
         rcKBmnHZ2SRYr3C/yO31VUp0zYYovOW67ZVJ33IxlKcBvOoEUaHYXC2iQ1aXKp0L31Gj
         6WdQ==
X-Gm-Message-State: AOJu0YylQlHB2BSTGmdzT+jhgti9ZrzmMrFBVFcgFVjIxcESQT6unJPr
	xJcxIeH7GzJop9jf+Hx7dniU5vSCT2ddKkVlaRIKZ0aqdV9Qnzuh7DwO
X-Gm-Gg: ASbGnct4KNIxoEGSGYmS6ODq+qAXoL0wJ0AyeEI40GYbbQ8Ch2Ep2JTdDX7fN+m1dNr
	DM+Aua0Au7sb65nO4i11bSdYi/vaEKIZY2ST+r7zm3iXvZLWadES8A+sZ0pR84WiJNu2B+paZND
	CgCQaUCXctHaM2xopSyzP6DucjbtGdssY6+yoGg3S1zhaDprOSt3YcpI7Q2vhjTY/mrzWDv/E56
	YTQmeLTfSeghV2xXfBnhzf31Z2kYHM6E5+BQm6GhCXAxrWlMWX7wvm6DFKQaPPD0OIm9etmCaXB
	CZhciD69SKYCb0dBBEinFVGC9ADEEG1NxvxuxQTjiZiXljpJg6LdBH1tyI536cw523W5So7taqa
	zDyOkMf8w2Xw49bWYbxQWWj5XxtQa3Y9fGDQFWWURdr94SdcL2oCCrXUD6T1g+JKQkbgYlP0FAK
	YrBQ==
X-Google-Smtp-Source: AGHT+IGRAjl2/NgZSpaoplKGZYua1CLsBqWNY3GBDj+MEhOwZUxwcR+SUYxDTN6lr0YhZkRaZISC+g==
X-Received: by 2002:a17:902:e748:b0:27e:eabe:7604 with SMTP id d9443c01a7336-28e7f448299mr45026705ad.9.1759412420847;
        Thu, 02 Oct 2025 06:40:20 -0700 (PDT)
Received: from SaltyKitkat ([156.246.92.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099adbcbesm2021955a12.4.2025.10.02.06.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 06:40:20 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org,
	sunk67188@gmail.com
Subject: [PATCH] btrfs: goto out -> return conversions for previous patch
Date: Thu,  2 Oct 2025 21:39:00 +0800
Message-ID: <20251002133920.24528-1-sunk67188@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930163547.GC4052@twin.jikos.cz>
References: <20250930163547.GC4052@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tested with btrfs/auto group. Tests that require $SCRATCH_DEV_POOL,
$LOGWRITES_DEV, zoned block devices and dm flakey support are skipped.

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/uuid-tree.c | 102 +++++++++++++++----------------------------
 fs/btrfs/verity.c    |  14 +++---
 fs/btrfs/volumes.c   |  98 +++++++++++++++--------------------------
 fs/btrfs/xattr.c     |  29 ++++--------
 4 files changed, 86 insertions(+), 157 deletions(-)

diff --git a/fs/btrfs/uuid-tree.c b/fs/btrfs/uuid-tree.c
index 30e5d80adda9..8dd71df277c1 100644
--- a/fs/btrfs/uuid-tree.c
+++ b/fs/btrfs/uuid-tree.c
@@ -34,25 +34,19 @@ static int btrfs_uuid_tree_lookup(struct btrfs_root *uuid_root, const u8 *uuid,
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
@@ -78,7 +72,6 @@ static int btrfs_uuid_tree_lookup(struct btrfs_root *uuid_root, const u8 *uuid,
 		item_size -= sizeof(data);
 	}
 
-out:
 	return ret;
 }
 
@@ -99,18 +92,14 @@ int btrfs_uuid_tree_add(struct btrfs_trans_handle *trans, const u8 *uuid, u8 typ
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
@@ -133,14 +122,12 @@ int btrfs_uuid_tree_add(struct btrfs_trans_handle *trans, const u8 *uuid, u8 typ
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
-	return ret;
+	return 0;
 }
 
 int btrfs_uuid_tree_remove(struct btrfs_trans_handle *trans, const u8 *uuid, u8 type,
@@ -159,29 +146,23 @@ int btrfs_uuid_tree_remove(struct btrfs_trans_handle *trans, const u8 *uuid, u8
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
@@ -190,8 +171,7 @@ int btrfs_uuid_tree_remove(struct btrfs_trans_handle *trans, const u8 *uuid, u8
 	if (!IS_ALIGNED(item_size, sizeof(u64))) {
 		btrfs_warn(fs_info, "uuid item with illegal size %lu!",
 			   (unsigned long)item_size);
-		ret = -ENOENT;
-		goto out;
+		return -ENOENT;
 	}
 	while (item_size) {
 		__le64 read_subid;
@@ -203,25 +183,19 @@ int btrfs_uuid_tree_remove(struct btrfs_trans_handle *trans, const u8 *uuid, u8
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
-	return ret;
+	return 0;
 }
 
 static int btrfs_uuid_iter_rem(struct btrfs_root *uuid_root, u8 *uuid, u8 type,
@@ -298,10 +272,8 @@ int btrfs_uuid_tree_iterate(struct btrfs_fs_info *fs_info)
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
@@ -312,14 +284,13 @@ int btrfs_uuid_tree_iterate(struct btrfs_fs_info *fs_info)
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
@@ -350,7 +321,7 @@ int btrfs_uuid_tree_iterate(struct btrfs_fs_info *fs_info)
 			ret = btrfs_check_uuid_tree_entry(fs_info, uuid,
 							  key.type, subid_cpu);
 			if (ret < 0)
-				goto out;
+				return ret;
 			if (ret > 0) {
 				btrfs_release_path(path);
 				ret = btrfs_uuid_iter_rem(root, uuid, key.type,
@@ -366,7 +337,7 @@ int btrfs_uuid_tree_iterate(struct btrfs_fs_info *fs_info)
 					goto again_search_slot;
 				}
 				if (ret < 0 && ret != -ENOENT)
-					goto out;
+					return ret;
 				key.offset++;
 				goto again_search_slot;
 			}
@@ -383,7 +354,6 @@ int btrfs_uuid_tree_iterate(struct btrfs_fs_info *fs_info)
 		break;
 	}
 
-out:
 	return ret;
 }
 
diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
index b1903030faf4..5a87bfcbc744 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
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
@@ -161,16 +159,14 @@ static int drop_verity_items(struct btrfs_inode *inode, u8 key_type)
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
-	return ret;
+	return count;
 }
 
 /*
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 18d28789f52e..416a0a054f93 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1844,7 +1844,7 @@ static int btrfs_free_dev_extent(struct btrfs_trans_handle *trans,
 		ret = btrfs_previous_item(root, path, key.objectid,
 					  BTRFS_DEV_EXTENT_KEY);
 		if (ret)
-			goto out;
+			return ret;
 		leaf = path->nodes[0];
 		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
 		extent = btrfs_item_ptr(leaf, path->slots[0],
@@ -1859,7 +1859,7 @@ static int btrfs_free_dev_extent(struct btrfs_trans_handle *trans,
 		extent = btrfs_item_ptr(leaf, path->slots[0],
 					struct btrfs_dev_extent);
 	} else {
-		goto out;
+		return ret;
 	}
 
 	*dev_extent_len = btrfs_dev_extent_length(leaf, extent);
@@ -1867,7 +1867,6 @@ static int btrfs_free_dev_extent(struct btrfs_trans_handle *trans,
 	ret = btrfs_del_item(trans, root, path);
 	if (ret == 0)
 		set_bit(BTRFS_TRANS_HAVE_FREE_BGS, &trans->transaction->flags);
-out:
 	return ret;
 }
 
@@ -1907,13 +1906,12 @@ static noinline int find_next_devid(struct btrfs_fs_info *fs_info,
 
 	ret = btrfs_search_slot(NULL, fs_info->chunk_root, &key, path, 0, 0);
 	if (ret < 0)
-		goto error;
+		return ret;
 
 	if (ret == 0) {
 		/* Corruption */
 		btrfs_err(fs_info, "corrupted chunk tree devid -1 matched");
-		ret = -EUCLEAN;
-		goto error;
+		return -EUCLEAN;
 	}
 
 	ret = btrfs_previous_item(fs_info->chunk_root, path,
@@ -1926,9 +1924,7 @@ static noinline int find_next_devid(struct btrfs_fs_info *fs_info,
 				      path->slots[0]);
 		*devid_ret = found_key.offset + 1;
 	}
-	ret = 0;
-error:
-	return ret;
+	return 0;
 }
 
 /*
@@ -1958,7 +1954,7 @@ static int btrfs_add_dev_item(struct btrfs_trans_handle *trans,
 				      &key, sizeof(*dev_item));
 	btrfs_trans_release_chunk_metadata(trans);
 	if (ret)
-		goto out;
+		return ret;
 
 	leaf = path->nodes[0];
 	dev_item = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_dev_item);
@@ -1984,9 +1980,7 @@ static int btrfs_add_dev_item(struct btrfs_trans_handle *trans,
 	write_extent_buffer(leaf, trans->fs_info->fs_devices->metadata_uuid,
 			    ptr, BTRFS_FSID_SIZE);
 
-	ret = 0;
-out:
-	return ret;
+	return 0;
 }
 
 /*
@@ -2030,11 +2024,10 @@ static int btrfs_rm_dev_item(struct btrfs_trans_handle *trans,
 	if (ret) {
 		if (ret > 0)
 			ret = -ENOENT;
-		goto out;
+		return ret;
 	}
 
 	ret = btrfs_del_item(trans, root, path);
-out:
 	return ret;
 }
 
@@ -2643,7 +2636,7 @@ static int btrfs_finish_sprout(struct btrfs_trans_handle *trans)
 		ret = btrfs_search_slot(trans, root, &key, path, 0, 1);
 		btrfs_trans_release_chunk_metadata(trans);
 		if (ret < 0)
-			goto error;
+			return ret;
 
 		leaf = path->nodes[0];
 next_slot:
@@ -2652,7 +2645,7 @@ static int btrfs_finish_sprout(struct btrfs_trans_handle *trans)
 			if (ret > 0)
 				break;
 			if (ret < 0)
-				goto error;
+				return ret;
 			leaf = path->nodes[0];
 			btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
 			btrfs_release_path(path);
@@ -2683,9 +2676,7 @@ static int btrfs_finish_sprout(struct btrfs_trans_handle *trans)
 		path->slots[0]++;
 		goto next_slot;
 	}
-	ret = 0;
-error:
-	return ret;
+	return 0;
 }
 
 int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path)
@@ -2956,12 +2947,10 @@ static noinline int btrfs_update_device(struct btrfs_trans_handle *trans,
 
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
@@ -2975,7 +2964,6 @@ static noinline int btrfs_update_device(struct btrfs_trans_handle *trans,
 				     btrfs_device_get_disk_total_bytes(device));
 	btrfs_set_device_bytes_used(leaf, dev_item,
 				    btrfs_device_get_bytes_used(device));
-out:
 	return ret;
 }
 
@@ -3041,22 +3029,20 @@ static int btrfs_free_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
 
 	ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
 	if (ret < 0)
-		goto out;
-	else if (ret > 0) { /* Logic error or corruption */
+		return ret;
+	if (ret > 0) { /* Logic error or corruption */
 		btrfs_err(fs_info, "failed to lookup chunk %llu when freeing",
 			  chunk_offset);
 		btrfs_abort_transaction(trans, -ENOENT);
-		ret = -EUCLEAN;
-		goto out;
+		return -EUCLEAN;
 	}
 
 	ret = btrfs_del_item(trans, root, path);
 	if (ret < 0) {
 		btrfs_err(fs_info, "failed to delete chunk %llu item", chunk_offset);
 		btrfs_abort_transaction(trans, ret);
-		goto out;
+		return ret;
 	}
-out:
 	return ret;
 }
 
@@ -3517,7 +3503,7 @@ static int btrfs_relocate_sys_chunks(struct btrfs_fs_info *fs_info)
 		ret = btrfs_search_slot(NULL, chunk_root, &key, path, 0, 0);
 		if (ret < 0) {
 			mutex_unlock(&fs_info->reclaim_bgs_lock);
-			goto error;
+			return ret;
 		}
 		if (ret == 0) {
 			/*
@@ -3527,9 +3513,8 @@ static int btrfs_relocate_sys_chunks(struct btrfs_fs_info *fs_info)
 			 * offset (one less than the previous one, wrong
 			 * alignment and size).
 			 */
-			ret = -EUCLEAN;
 			mutex_unlock(&fs_info->reclaim_bgs_lock);
-			goto error;
+			return -EUCLEAN;
 		}
 
 		ret = btrfs_previous_item(chunk_root, path, key.objectid,
@@ -3537,7 +3522,7 @@ static int btrfs_relocate_sys_chunks(struct btrfs_fs_info *fs_info)
 		if (ret)
 			mutex_unlock(&fs_info->reclaim_bgs_lock);
 		if (ret < 0)
-			goto error;
+			return ret;
 		if (ret > 0)
 			break;
 
@@ -3571,7 +3556,6 @@ static int btrfs_relocate_sys_chunks(struct btrfs_fs_info *fs_info)
 	} else if (WARN_ON(failed && retried)) {
 		ret = -ENOSPC;
 	}
-error:
 	return ret;
 }
 
@@ -4715,17 +4699,14 @@ int btrfs_recover_balance(struct btrfs_fs_info *fs_info)
 
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
@@ -4762,7 +4743,6 @@ int btrfs_recover_balance(struct btrfs_fs_info *fs_info)
 	fs_info->balance_ctl = bctl;
 	spin_unlock(&fs_info->balance_lock);
 	mutex_unlock(&fs_info->balance_mutex);
-out:
 	return ret;
 }
 
@@ -7710,7 +7690,7 @@ static int update_dev_stat_item(struct btrfs_trans_handle *trans,
 		btrfs_warn(fs_info,
 			"error %d while searching for dev_stats item for device %s",
 				  ret, btrfs_dev_name(device));
-		goto out;
+		return ret;
 	}
 
 	if (ret == 0 &&
@@ -7721,7 +7701,7 @@ static int update_dev_stat_item(struct btrfs_trans_handle *trans,
 			btrfs_warn(fs_info,
 				"delete too small dev_stats item for device %s failed %d",
 					  btrfs_dev_name(device), ret);
-			goto out;
+			return ret;
 		}
 		ret = 1;
 	}
@@ -7735,7 +7715,7 @@ static int update_dev_stat_item(struct btrfs_trans_handle *trans,
 			btrfs_warn(fs_info,
 				"insert dev_stats item for device %s failed %d",
 				btrfs_dev_name(device), ret);
-			goto out;
+			return ret;
 		}
 	}
 
@@ -7744,7 +7724,6 @@ static int update_dev_stat_item(struct btrfs_trans_handle *trans,
 	for (i = 0; i < BTRFS_DEV_STAT_VALUES_MAX; i++)
 		btrfs_set_dev_stats_value(eb, ptr, i,
 					  btrfs_dev_stat_read(device, i));
-out:
 	return ret;
 }
 
@@ -8067,17 +8046,15 @@ int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info)
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
-		if (ret > 0) {
-			ret = -EUCLEAN;
-			goto out;
-		}
+		if (ret > 0)
+			return -EUCLEAN;
 	}
 	while (1) {
 		struct extent_buffer *leaf = path->nodes[0];
@@ -8103,20 +8080,19 @@ int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info)
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
@@ -8124,9 +8100,7 @@ int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info)
 	}
 
 	/* Ensure all chunks have corresponding dev extents */
-	ret = verify_chunk_dev_extent_mapping(fs_info);
-out:
-	return ret;
+	return verify_chunk_dev_extent_mapping(fs_info);
 }
 
 /*
diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
index 7fec70dfe06b..3d27eb1e2f74 100644
--- a/fs/btrfs/xattr.c
+++ b/fs/btrfs/xattr.c
@@ -31,7 +31,6 @@ int btrfs_getxattr(const struct inode *inode, const char *name,
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	BTRFS_PATH_AUTO_FREE(path);
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
@@ -73,10 +65,7 @@ int btrfs_getxattr(const struct inode *inode, const char *name,
 				   btrfs_dir_name_len(leaf, di));
 	read_extent_buffer(leaf, buffer, data_ptr,
 			   btrfs_dir_data_len(leaf, di));
-	ret = btrfs_dir_data_len(leaf, di);
-
-out:
-	return ret;
+	return btrfs_dir_data_len(leaf, di);
 }
 
 int btrfs_setxattr(struct btrfs_trans_handle *trans, struct inode *inode,
-- 
2.51.0


