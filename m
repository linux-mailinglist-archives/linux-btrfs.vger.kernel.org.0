Return-Path: <linux-btrfs+bounces-1725-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F41CA83AFAD
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 18:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A37D628BB1D
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 17:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0ECC1292FA;
	Wed, 24 Jan 2024 17:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="F3APG9kY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A220F81AC7
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 17:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116806; cv=none; b=HfxW9IO/vxfDM8JwI7i6oPR9jxJYWVvtkAenPKZVkeuKuqeNTbF4hxZzSAzwK2D7JH4idLJwFXGBwhj3qjssL7a75DxkO39ORuRqHhQBPvEJi2UNKYn1Zd5NAFQhKUyq1JWZWfFWgeQ3Se1o+xCJqx39/WP2zyf6giey7Lzm2w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116806; c=relaxed/simple;
	bh=RsgzIVBsz01VwzkIxSD2+w4KA2XXIeeWH0vR/60+LQc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OJzoJtxb8cu5O9JTVA9xxg36JjqTPA3ublxcwHCgoy+Ieg/vd4q9VMoX+PLutopYCLwnvrjn+3p2GsI9eEg0agq5XzENMPi13I7hQg2hPZyCXOZwJLK+rD+1NDaWNd2R7vKs063DrdIYIIOXzp/DFuHceL1z78OfFIGhQEV8ahs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=F3APG9kY; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dc221f01302so4470179276.2
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 09:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706116803; x=1706721603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OloT/erk4mHRgg9VGWOA3jcX3n+PreTy1AVXCpgYEsE=;
        b=F3APG9kYFsq3cAI95glBr2AgCk+/nG0Z4oLGKQduPdcAXzuvcGJHYskqS2gRaXku/p
         SWrvX/Ga4Nifk06Qv561HD7t8baVb6tVwVSVHY6T3kmr6C/c8yjdJgBdRV8P0RlCXjs4
         5y9hZj/o9hWU2/ZQksXZ5YSIrav/LPRohTpoyiQRaTW8Awe7Bg+FcCjEEkG706N5Woit
         5rwGcySPwX9zJDD4bfSUN3BCYgHluIgvQmDWTXmaRKFXl+VFrglsb/pxHc9DbmjmY5CD
         FvZrjIXPbetsbq/U0eUzNk7IxLfEVJX0oNy/pQBc71wWr3T4CwVIccF6yIRF003sA+MI
         1pYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116803; x=1706721603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OloT/erk4mHRgg9VGWOA3jcX3n+PreTy1AVXCpgYEsE=;
        b=HPrYte0uHrg11RaBgwFqLI03l3yhPoVI3X41sWSkld5Fa2Ch0v5dj1D9vBP0go9HZs
         qibkGWe02S1KQKLl0hBISPghzYuRTNi+HNicajBfZVbm8rESQh4OiDB42sKsNjiGC2eO
         O+1fxpH3D0NSYoIO5ZEAJBZZ1BPzg7NnLlUHYz6A2x1HIRpoK+fvprY8ASafNas6b6jf
         a0Gmxfk7Iw6ac4Iy0zJ6SBeQkRRFL+Tw9m+eaiL56NjEoY9YQSFg7o8A5GA+TBWeUlEd
         b9ULtHLJrgzN2TM359iQAFIgKh+a/7X+6FMM7zXWW0WYmWyM+GDKKwo7tva+ghQOqJ8z
         I9jA==
X-Gm-Message-State: AOJu0YxSqunLLyTvn4KTaNf9qdbkDCBot8PmjOPIKwSbQ1SkLWoTgwej
	FY/wP8xvX6ZtAfUiKxcppV4Dm3qy8Kg8CYlI7nU2fkgm7J7NCotcfdPc5rrw6pQiqLUjnf6fP2U
	s
X-Google-Smtp-Source: AGHT+IHaqWhrpDkjISBRATMkV1CIWIFl9HfeZzFRPLcxMZciRt/LBMMfWyBultpUP/fkkBsgmYZmPw==
X-Received: by 2002:a25:8609:0:b0:dc2:3aec:d5ee with SMTP id y9-20020a258609000000b00dc23aecd5eemr1053429ybk.114.1706116803431;
        Wed, 24 Jan 2024 09:20:03 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id y185-20020a25dcc2000000b00d677aec54ffsm2935134ybe.60.2024.01.24.09.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:20:03 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v5 43/52] btrfs: make btrfs_ref_to_path handle encrypted filenames
Date: Wed, 24 Jan 2024 12:19:05 -0500
Message-ID: <365d4f820f70b7cf69b1b9cae9b949a15c3350b0.1706116485.git.josef@toxicpanda.com>
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

We use this helper for inode-resolve and path resolution in send, so
update this helper to properly decrypt any encrypted names it finds.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/backref.c | 45 +++++++++++++++++++++++++++++++++++++++++----
 fs/btrfs/fscrypt.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/fscrypt.h | 11 +++++++++++
 3 files changed, 98 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index f58fe7c745c2..9ed854b9f3fc 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -20,6 +20,7 @@
 #include "extent-tree.h"
 #include "relocation.h"
 #include "tree-checker.h"
+#include "fscrypt.h"
 
 /* Just arbitrary numbers so we can be sure one of these happened. */
 #define BACKREF_FOUND_SHARED     6
@@ -2117,6 +2118,42 @@ int btrfs_find_one_extref(struct btrfs_root *root, u64 inode_objectid,
 	return ret;
 }
 
+static int copy_resolved_iref_to_buf(struct btrfs_root *fs_root,
+				     struct extent_buffer *eb,
+				     char *dest, u64 parent,
+				     unsigned long name_off, u32 name_len,
+				     s64 *bytes_left)
+{
+	struct btrfs_fs_info *fs_info = fs_root->fs_info;
+	struct fscrypt_str fname = FSTR_INIT(NULL, 0);
+	int ret;
+
+	/* No encryption, just copy the name in. */
+	if (!btrfs_fs_incompat(fs_info, ENCRYPT)) {
+		*bytes_left -= name_len;
+		if (*bytes_left >= 0)
+			read_extent_buffer(eb, dest + *bytes_left,
+					   name_off, name_len);
+		return 0;
+	}
+
+	ret = fscrypt_fname_alloc_buffer(BTRFS_NAME_LEN, &fname);
+	if (ret)
+		return ret;
+
+	ret = btrfs_decrypt_name(fs_root, eb, name_off, name_len, parent,
+				 &fname);
+	if (ret)
+		goto out;
+
+	*bytes_left -= fname.len;
+	if (*bytes_left >= 0)
+		memcpy(dest + *bytes_left, fname.name, fname.len);
+out:
+	fscrypt_fname_free_buffer(&fname);
+	return ret;
+}
+
 /*
  * this iterates to turn a name (from iref/extref) into a full filesystem path.
  * Elements of the path are separated by '/' and the path is guaranteed to be
@@ -2148,10 +2185,10 @@ char *btrfs_ref_to_path(struct btrfs_root *fs_root, struct btrfs_path *path,
 		dest[bytes_left] = '\0';
 
 	while (1) {
-		bytes_left -= name_len;
-		if (bytes_left >= 0)
-			read_extent_buffer(eb, dest + bytes_left,
-					   name_off, name_len);
+		ret = copy_resolved_iref_to_buf(fs_root, eb, dest, parent,
+						name_off, name_len, &bytes_left);
+		if (ret)
+			break;
 		if (eb != eb_in) {
 			if (!path->skip_locking)
 				btrfs_tree_read_unlock(eb);
diff --git a/fs/btrfs/fscrypt.c b/fs/btrfs/fscrypt.c
index 6a6ecf4a49e2..83fa99a5be6e 100644
--- a/fs/btrfs/fscrypt.c
+++ b/fs/btrfs/fscrypt.c
@@ -365,6 +365,52 @@ int btrfs_fscrypt_bio_length(struct bio *bio, u64 map_length)
 	return map_length;
 }
 
+int btrfs_decrypt_name(struct btrfs_root *root, struct extent_buffer *eb,
+		       unsigned long name_off, u32 name_len,
+		       u64 parent_ino, struct fscrypt_str *name)
+{
+	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct inode *dir;
+	struct fscrypt_str iname = FSTR_INIT(NULL, 0);
+	int ret;
+
+	ASSERT(name_len <= BTRFS_NAME_LEN);
+
+	ret = fscrypt_fname_alloc_buffer(name_len, &iname);
+	if (ret)
+		return ret;
+
+	dir = btrfs_iget(fs_info->sb, parent_ino, root);
+	if (IS_ERR(dir)) {
+		ret = PTR_ERR(dir);
+		goto out;
+	}
+
+	/*
+	 * Directory isn't encrypted, the name isn't encrypted, we can just copy
+	 * it into the buffer.
+	 */
+	if (!IS_ENCRYPTED(dir)) {
+		read_extent_buffer(eb, name->name, name_off, name_len);
+		name->len = name_len;
+		goto out_inode;
+	}
+
+	read_extent_buffer(eb, iname.name, name_off, name_len);
+
+	ret = fscrypt_prepare_readdir(dir);
+	if (ret)
+		goto out_inode;
+
+	ASSERT(dir->i_crypt_info);
+	ret = fscrypt_fname_disk_to_usr(dir, 0, 0, &iname, name);
+out_inode:
+	iput(dir);
+out:
+	fscrypt_fname_free_buffer(&iname);
+	return ret;
+}
+
 const struct fscrypt_operations btrfs_fscrypt_ops = {
 	.has_per_extent_encryption = 1,
 	.get_context = btrfs_fscrypt_get_context,
diff --git a/fs/btrfs/fscrypt.h b/fs/btrfs/fscrypt.h
index 703122e8d57f..6fca223e7d9e 100644
--- a/fs/btrfs/fscrypt.h
+++ b/fs/btrfs/fscrypt.h
@@ -38,6 +38,9 @@ bool btrfs_mergeable_encrypted_bio(struct bio *bio, struct inode *inode,
 				   struct fscrypt_extent_info *fi,
 				   u64 logical_offset);
 int btrfs_fscrypt_bio_length(struct bio *bio, u64 map_length);
+int btrfs_decrypt_name(struct btrfs_root *root, struct extent_buffer *eb,
+		       unsigned long name_off, u32 name_len,
+		       u64 parent_ino, struct fscrypt_str *name);
 
 #else
 static inline void btrfs_fscrypt_save_extent_info(struct btrfs_inode *inode,
@@ -98,6 +101,14 @@ static inline u64 btrfs_fscrypt_bio_length(struct bio *bio, u64 map_length)
 	return map_length;
 }
 
+static inline int btrfs_decrypt_name(struct btrfs_root *root,
+				     struct extent_buffer *eb,
+				     unsigned long name_off, u32 name_len,
+				     u64 parent_ino, struct fscrypt_str *name)
+{
+	return -EINVAL;
+}
+
 #endif /* CONFIG_FS_ENCRYPTION */
 
 extern const struct fscrypt_operations btrfs_fscrypt_ops;
-- 
2.43.0


