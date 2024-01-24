Return-Path: <linux-btrfs+bounces-1698-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA2E83AFA5
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 18:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4BEDB2BE33
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 17:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860B786138;
	Wed, 24 Jan 2024 17:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ZRGDiWri"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9081886125
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 17:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116780; cv=none; b=sCBlG4FZtGUltaLJY0yNSDunCppnZhNAR3HWVYN8p3wMxqE7J/M/tmn3WA5soW7E0CcKFqen5Mud7b8qrpwE7YtWJ2Z4kNMaQ7jeHq7mPVqSINzNfSR3mpuncPdtpBDhAaPmMZJp2zigeNnQWB6twJ7IqJO+x6urvHEih3kcON4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116780; c=relaxed/simple;
	bh=8UJoSISST2M8H9gQ4PbQmeMqipSq8kSVoYEai3riRBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e1FjB8MQcipwP9aTPlcBgtmKQNoHaDoCHHjt844D2vXpH1HDjzpPSipP76xNkJGy4lJsX5RJdnIaL7FVGZ2X1r4KJlEpMFoxszjDF8JkSbLeNWsjqm3Du3sVYRl3uJHOK6rO0fLm0aJmja5WPPD9voN5HmZ/f2D5Fod9p8OMoWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=ZRGDiWri; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5ffcb478512so29556257b3.0
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 09:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706116777; x=1706721577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yw08K3DKsF3YQaIlHLn48T7ybYb2Lkz78eTR3CsHweU=;
        b=ZRGDiWrikjl23TOOICOUiIUgbBvj+U5usqhv1gUB3U4olTh6qJakjgvXs3jubAzWAR
         BrDu0IcCQ1/PToUo5pDJm4rvkX/449Q6Gcz0w4wYGRzu9wGDUUkJ+u6YzrGEuBfhnXlT
         szpmIpPdywRBSW99UM/8wcm5pMdsuzx87qr6RcEieX4oBxssWi03yQeJ6wzgPUXT2AqB
         R3bJdWgPphzgJ4MSH/lBoyO/UWrMWyIJ4eJVFUN+CVwOAX/fK+ck+hiwY0bMcq8rqxx2
         0ie9Ta3/IdhfWn8PKs/3mEOTI/wiX+WavKz0e8BYKv1+6XXE3x95BGF6T+g64uSNV6vF
         Im1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116777; x=1706721577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yw08K3DKsF3YQaIlHLn48T7ybYb2Lkz78eTR3CsHweU=;
        b=B9qtmHTYQwBvYYi5m1WbGgUNVyUBp+0S/uFUVdSiZCzxDBPh6IBxKQYJq83nEAiyex
         ch+qglNsuRhKPpsuRnoxs6QYVcLprGRXF00EH8VckSI+eiXWxSajXv6QyLetAE9hRPLl
         f1AKU1DkRA6St0BKQ5JM/e/ter0AJIZyzfOSeLBhRNplK998Eh/z/wDKKP4sJDrGkgHJ
         jZmFh7lDfeHOlZZJMpxNi7AdksoD4KqLT55Gh85LA43yCSNe5jnApJvGxH7ZkOK+aJlK
         WBe9HODXPML196cw2HaTOAZVuacGiLCUOKhEI+yWCa1U38s9gomt24adwJ2nB0dHR6Fw
         iJaQ==
X-Gm-Message-State: AOJu0Yz/HMXv+dAiTmdhlfVRzXQkuW1cjjWYofYW7FxE+YZXvag5H/vX
	ij9DKNJzMcpCIpvrqb71xosEyadJ28J291UalnqyGOLihMtBklKVQjvG7Shv/dQPFAxqlYvNlKb
	G
X-Google-Smtp-Source: AGHT+IFCMr9yl08HMQDcZfFxxUuPljZ5OvjBKsYB9bK8WwCNfrSMF55DaB1JgFMK4FDOZLPKiN4tVQ==
X-Received: by 2002:a81:a18d:0:b0:602:ac9e:d626 with SMTP id y135-20020a81a18d000000b00602ac9ed626mr166588ywg.21.1706116777214;
        Wed, 24 Jan 2024 09:19:37 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id o129-20020a817387000000b006000b154233sm61603ywc.89.2024.01.24.09.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:19:36 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Cc: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v5 16/52] btrfs: handle nokey names.
Date: Wed, 24 Jan 2024 12:18:38 -0500
Message-ID: <a7e3aec8ec03814b4baa1d929ae8fb77f13c17d2.1706116485.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706116485.git.josef@toxicpanda.com>
References: <cover.1706116485.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

For encrypted or unencrypted names, we calculate the offset for the dir
item by hashing the name for the dir item. However, this doesn't work
for a long nokey name, where we do not have the complete ciphertext.
Instead, fscrypt stores the filesystem-provided hash in the nokey name,
and we can extract it from the fscrypt_name structure in such a case.

Additionally, for nokey names, if we find the nokey name on disk we can
update the fscrypt_name with the disk name, so add that to searching for
diritems.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/dir-item.c | 37 +++++++++++++++++++++++++++++++++++--
 fs/btrfs/fscrypt.c  | 27 +++++++++++++++++++++++++++
 fs/btrfs/fscrypt.h  | 11 +++++++++++
 3 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/dir-item.c b/fs/btrfs/dir-item.c
index a64cfddff7f0..897fb5477369 100644
--- a/fs/btrfs/dir-item.c
+++ b/fs/btrfs/dir-item.c
@@ -231,6 +231,28 @@ struct btrfs_dir_item *btrfs_lookup_dir_item(struct btrfs_trans_handle *trans,
 	return di;
 }
 
+/*
+ * If appropriate, populate the disk name for a fscrypt_name looked up without
+ * a key.
+ *
+ * @path:	The path to the extent buffer in which the name was found.
+ * @di:		The dir item corresponding.
+ * @fname:	The fscrypt_name to perhaps populate.
+ *
+ * Returns: 0 if the name is already populated or the dir item doesn't exist
+ * or the name was successfully populated, else an error code.
+ */
+static int ensure_disk_name_from_dir_item(struct btrfs_path *path,
+					  struct btrfs_dir_item *di,
+					  struct fscrypt_name *name)
+{
+	if (name->disk_name.name || !di)
+		return 0;
+
+	return btrfs_fscrypt_get_disk_name(path->nodes[0], di,
+					   &name->disk_name);
+}
+
 /*
  * Lookup for a directory item by fscrypt_name.
  *
@@ -257,8 +279,12 @@ struct btrfs_dir_item *btrfs_lookup_dir_item_fname(struct btrfs_trans_handle *tr
 
 	key.objectid = dir;
 	key.type = BTRFS_DIR_ITEM_KEY;
-	key.offset = btrfs_name_hash(name->disk_name.name, name->disk_name.len);
-	/* XXX get the right hash for no-key names */
+
+	if (!name->disk_name.name)
+		key.offset = name->hash | ((u64)name->minor_hash << 32);
+	else
+		key.offset = btrfs_name_hash(name->disk_name.name,
+					     name->disk_name.len);
 
 	ret = btrfs_search_slot(trans, root, &key, path, mod, -mod);
 	if (ret == 0)
@@ -266,6 +292,8 @@ struct btrfs_dir_item *btrfs_lookup_dir_item_fname(struct btrfs_trans_handle *tr
 
 	if (ret == -ENOENT || (di && IS_ERR(di) && PTR_ERR(di) == -ENOENT))
 		return NULL;
+	if (ret == 0)
+		ret = ensure_disk_name_from_dir_item(path, di, name);
 	if (ret < 0)
 		di = ERR_PTR(ret);
 
@@ -382,7 +410,12 @@ btrfs_search_dir_index_item(struct btrfs_root *root, struct btrfs_path *path,
 	btrfs_for_each_slot(root, &key, &key, path, ret) {
 		if (key.objectid != dirid || key.type != BTRFS_DIR_INDEX_KEY)
 			break;
+
 		di = btrfs_match_dir_item_fname(root->fs_info, path, name);
+		if (di)
+			ret = ensure_disk_name_from_dir_item(path, di, name);
+		if (ret)
+			break;
 		if (di)
 			return di;
 	}
diff --git a/fs/btrfs/fscrypt.c b/fs/btrfs/fscrypt.c
index 8f22c5f257ff..c38e12eee279 100644
--- a/fs/btrfs/fscrypt.c
+++ b/fs/btrfs/fscrypt.c
@@ -15,6 +15,33 @@
 #include "transaction.h"
 #include "xattr.h"
 
+/*
+ * From a given location in a leaf, read a name into a qstr (usually a
+ * fscrypt_name's disk_name), allocating the required buffer. Used for
+ * nokey names.
+ */
+int btrfs_fscrypt_get_disk_name(struct extent_buffer *leaf,
+				struct btrfs_dir_item *dir_item,
+				struct fscrypt_str *name)
+{
+	unsigned long de_name_len = btrfs_dir_name_len(leaf, dir_item);
+	unsigned long de_name = (unsigned long)(dir_item + 1);
+	/*
+	 * For no-key names, we use this opportunity to find the disk
+	 * name, so future searches don't need to deal with nokey names
+	 * and we know what the encrypted size is.
+	 */
+	name->name = kmalloc(de_name_len, GFP_NOFS);
+
+	if (!name->name)
+		return -ENOMEM;
+
+	read_extent_buffer(leaf, name->name, de_name, de_name_len);
+
+	name->len = de_name_len;
+	return 0;
+}
+
 /*
  * This function is extremely similar to fscrypt_match_name() but uses an
  * extent_buffer.
diff --git a/fs/btrfs/fscrypt.h b/fs/btrfs/fscrypt.h
index 1647bbbcd609..c08fd52c99b4 100644
--- a/fs/btrfs/fscrypt.h
+++ b/fs/btrfs/fscrypt.h
@@ -9,11 +9,22 @@
 #include "fs.h"
 
 #ifdef CONFIG_FS_ENCRYPTION
+int btrfs_fscrypt_get_disk_name(struct extent_buffer *leaf,
+				struct btrfs_dir_item *di,
+				struct fscrypt_str *qstr);
+
 bool btrfs_fscrypt_match_name(struct fscrypt_name *fname,
 			      struct extent_buffer *leaf,
 			      unsigned long de_name, u32 de_name_len);
 
 #else
+static inline int btrfs_fscrypt_get_disk_name(struct extent_buffer *leaf,
+					      struct btrfs_dir_item *di,
+					      struct fscrypt_str *qstr)
+{
+	return 0;
+}
+
 static inline bool btrfs_fscrypt_match_name(struct fscrypt_name *fname,
 					    struct extent_buffer *leaf,
 					    unsigned long de_name,
-- 
2.43.0


