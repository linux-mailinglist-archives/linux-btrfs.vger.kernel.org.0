Return-Path: <linux-btrfs+bounces-14663-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5619BAD99F6
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Jun 2025 05:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 916063BC08C
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Jun 2025 03:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010CC155A30;
	Sat, 14 Jun 2025 03:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FuKyHwIS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F0F2E11CB
	for <linux-btrfs@vger.kernel.org>; Sat, 14 Jun 2025 03:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749872369; cv=none; b=Mo4BaNziNP9WQIzXSXxUVxi56OvZg5Kgf0DH73IQsEDfd7bskhZw2QaJMUuZBfBP22RbppnjWybft7IYm81vU/1UjUWJEwD+4s1U3dzwI4Mja1tD/fRQQyp7G8POa6Qbe8Jz1iS+8bNuJU+gymD/r4A3HySGRLd15CXj0YgNPYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749872369; c=relaxed/simple;
	bh=8ngtBLdUTjopqVBD84GffwSuoUXb4PcBpeElpeqPz8U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X4B8zps/cwVa16kpZj0atm9SVI11eDW7qaHlv933XECWEpOMONRvBnwhnslUV6TeDOeMX13D9EFbi4bxijPw1usYR7XcCfNu9mWHjvHHv1EsANDIX4m/XktisZlONOlub3YHG4cthZGUNP92khapvlKbvwOnJYub99IT0M18LZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FuKyHwIS; arc=none smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-7d38dff7056so49671585a.3
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Jun 2025 20:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749872366; x=1750477166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gd740qqZCC7fqSiDj9PnG19k7QGA4TuettLjkYD8LKY=;
        b=FuKyHwISkpMwu6LiUwwri9kx5ZDIINL7KzwIbk4kDTo4c1yQypVQ2Am0563/BzHHzJ
         s7DzAAND+wNEDphc/9AqIuhtmAB2vOl4Piv7odJu4CvHtcyTFI9h0/62DFMergxekauz
         kY5nAbCdNil9cBC7yBPWcIVyymEGBGmnMi39aoRkq8pjgxjGpE2xwZ7TOOF4Jym3SMxk
         gZ/8OBQL/a83V/sQ32waXOAonswloWUrwJLIGggyG1SqG8sIRURv7Rbg/rpogVFUXVU+
         SLPdh2FETPdrWTK4aRRTlgitCyzd92lWhHVmno/zFjrfdPvOx3Dhme3dZ2ySJC6SZ5db
         OzmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749872366; x=1750477166;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gd740qqZCC7fqSiDj9PnG19k7QGA4TuettLjkYD8LKY=;
        b=edpBKe6ZPeK/4AinQppj5LFFsZpb6qr8J0Vfa/SOPbF07XVqGsxJi9Snt2ANXHisLx
         HCgb/kod3m4Iu5pZ8xpb4uXnztyEI0ok2OF4hwavh+/2mhxSih5Asa98Xo8+eYLSqEOF
         R1uFpALzbvHOtcT7p9TNInLYWt86SD/EEweiq7QtUUzCOwu96N08tu5s7m2zpzPrejzb
         Bpu2lJm0EdhRkJZ34y9PO+aVJr+HLIzdOlyYWQjl8zJcwgtSI4N0uGJrT6q3TY2elVbm
         YCRcm2sxoPqZU4fJsuVxev60uLR3eY3JgxpbJPdc5jDkWjFrQVzQ7pCyGNb1j5/1mnjf
         D5dA==
X-Gm-Message-State: AOJu0YxHH+7p9tUVELXnyMjzY6RXwJbtg2YQJmTZdtQJ6gLcNavSNsBV
	dNjJ+9lKbEYLIMpWMAIlQE/OWEFtuqFr+WvNa/lsaocuxhCVeB7Mfesz6iyzlvbcaxIBgw==
X-Gm-Gg: ASbGncsja/WjXwV3F5nKJEIKXwTsVPHElPhyjuXOjEf4YBSOEZCuJHREP5bSHRWgfEW
	iWv5/kjbzidOilZepPYNx9sAC9AJfB71AHSrY4ZQQ60tv0+NCx5TUNb4ErZgOghE+4osMFAiOYb
	jb0XTnrMKlDb2nXVTw6ZCw3YIVnKagodv4FP3ZMTA/DLF5dIecb+COHeosjoQ8PkNzL/n6vK2RV
	rk8XEPFiVQh1QYylBaKaktq++QiDwjdENR7XfQ4qEm+wA9hmd7UvOVYFpJKZIoZ8xRXCSrYRjn6
	uXpM0nUpeuafoum82HlN3D6fbSKLFEHpJpFK48v3WzHfVZW3RsQetmg3m6TWVQ==
X-Google-Smtp-Source: AGHT+IGQBE3DANvCtGpjykecZqYexGkrkc61rxYyAuJi5k6F7D2dWX2CThThsvRZfxrEx+qqLu3d6A==
X-Received: by 2002:a0c:f40b:0:b0:6f8:e318:f9dc with SMTP id 6a1803df08f44-6fb4777a81bmr11676916d6.2.1749872366473;
        Fri, 13 Jun 2025 20:39:26 -0700 (PDT)
Received: from SaltyKitkat.. ([154.3.36.122])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb35c315c0sm28417266d6.57.2025.06.13.20.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 20:39:26 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH] btrfs: simplify btrfs_lookup_inode_extref() by removing unused parameters
Date: Sat, 14 Jun 2025 11:39:06 +0800
Message-ID: <20250614033920.3874-1-sunk67188@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `btrfs_lookup_inode_extref()` function no longer requires transaction
handle, insert length, or COW flag, as the onlycaller now perform a
read-only lookup using `trans = NULL`, `ins_len = 0`, and `cow = 0`.

This patch removes the unused parameters from the function signature and
call sites, simplifying the interface and clarifying its current usage as
a read-only lookup helper.

No functional changes intended.

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/inode-item.c | 8 +++-----
 fs/btrfs/inode-item.h | 4 +---
 fs/btrfs/tree-log.c   | 5 ++---
 3 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index a61c3540d67b..a35abe10de64 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -79,12 +79,10 @@ struct btrfs_inode_extref *btrfs_find_name_in_ext_backref(
 
 /* Returns NULL if no extref found */
 struct btrfs_inode_extref *
-btrfs_lookup_inode_extref(struct btrfs_trans_handle *trans,
-			  struct btrfs_root *root,
+btrfs_lookup_inode_extref(struct btrfs_root *root,
 			  struct btrfs_path *path,
 			  const struct fscrypt_str *name,
-			  u64 inode_objectid, u64 ref_objectid, int ins_len,
-			  int cow)
+			  u64 inode_objectid, u64 ref_objectid)
 {
 	int ret;
 	struct btrfs_key key;
@@ -93,7 +91,7 @@ btrfs_lookup_inode_extref(struct btrfs_trans_handle *trans,
 	key.type = BTRFS_INODE_EXTREF_KEY;
 	key.offset = btrfs_extref_hash(ref_objectid, name->name, name->len);
 
-	ret = btrfs_search_slot(trans, root, &key, path, ins_len, cow);
+	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 	if (ret < 0)
 		return ERR_PTR(ret);
 	if (ret > 0)
diff --git a/fs/btrfs/inode-item.h b/fs/btrfs/inode-item.h
index c11b97fdccc4..c57661bdde30 100644
--- a/fs/btrfs/inode-item.h
+++ b/fs/btrfs/inode-item.h
@@ -102,12 +102,10 @@ int btrfs_lookup_inode(struct btrfs_trans_handle *trans,
 		       struct btrfs_key *location, int mod);
 
 struct btrfs_inode_extref *btrfs_lookup_inode_extref(
-			  struct btrfs_trans_handle *trans,
 			  struct btrfs_root *root,
 			  struct btrfs_path *path,
 			  const struct fscrypt_str *name,
-			  u64 inode_objectid, u64 ref_objectid, int ins_len,
-			  int cow);
+			  u64 inode_objectid, u64 ref_objectid);
 
 struct btrfs_inode_ref *btrfs_find_name_in_backref(const struct extent_buffer *leaf,
 						   int slot,
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 97e933113b82..66fff2bc60f3 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -1125,9 +1125,8 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 	btrfs_release_path(path);
 
 	/* Same search but for extended refs */
-	extref = btrfs_lookup_inode_extref(NULL, root, path, name,
-					   inode_objectid, parent_objectid, 0,
-					   0);
+	extref = btrfs_lookup_inode_extref(root, path, name,
+					   inode_objectid, parent_objectid);
 	if (IS_ERR(extref)) {
 		return PTR_ERR(extref);
 	} else if (extref) {
-- 
2.49.0


