Return-Path: <linux-btrfs+bounces-1714-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A547A83AFA0
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 18:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20F6A1F29F04
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 17:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EA51272CC;
	Wed, 24 Jan 2024 17:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="oIn+AuOV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770681272BA
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 17:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116795; cv=none; b=ORC8lfaTRFWb8FhWHn3Tq1FVe2XEF0oNzQT5mvA8rr3VVEQxzRz9sbOho4NJ5ItW2rIMtq2yYK8Zubgln6BIX6ghchdNoh+cVrzVTBWT3eUMOWdCsD4ybIdRNYo1LY3dxGIG4NHQHQWtq3TDctmJq3cWLd7MtGHnki7C50GFXyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116795; c=relaxed/simple;
	bh=ISFQXNg84S5QdLTAk0E7kwRdicViZeD3qyiidpxErlg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jdfTQwQJq+/0/saeclncUr/L0Ra6/j+ydWcFVvUVVf3vCcl9bK+bKOsGQA337pivu3v3CxHLXgXKIHlBmVGjg/puTYpbONHPnOlt//K/eybymOAkfkzfOEb3pO8sQd5eVTPHrCg+q+80/oBTJTAbSRiFEywMHsJQArWeVXBYBHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=oIn+AuOV; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so4157654276.1
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 09:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706116793; x=1706721593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X2O1eKvEKn42C1szqxvSwRqikI3pX2uy9M6d9AXC5Xo=;
        b=oIn+AuOVtuTh9q4r67VYU6iwIQ7b6I8PRHzIL2w5HdbT6Ex+4tjLw7jX+N0AEg9ZCE
         HNTNM8LF8jpFOyH8uF6jb9RFkgFJRAgpKfGYFGdi+xJ95TxIo34zIiiSBrz4x6EdPdX7
         JuCvI3TvhObYnZz/CXQ/5bMGIeISqsYtDZkmq8TqIA5uik4M1BVpx+3foZSntkccn0zK
         Hye0RznvcPstMX7BL3Rj/oeq9uteSerdVQjXifhkOh5nDC4WfwoRi4hVc8EIwUmZr6eT
         Y13LjVTvjONgIJon1lPyPCRdWoQ0/L1ExOXlRr/dhdX3FpHYwmNV+hwm7EeSdm3EwGKA
         CKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116793; x=1706721593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X2O1eKvEKn42C1szqxvSwRqikI3pX2uy9M6d9AXC5Xo=;
        b=d0rupKn5+KtKaVAkRE3B80bT/HaAfVv4gj0y3OcpCGMf9HyR0YMI89n3cS6xnx9oMb
         WzZOOJRsT6mJLi64Uo7Xn2OXpRpFm4lADIk4gbM6v3nO2erVSD5Lzp4IcVTE3DzyXejf
         mh56ELUgo7vifFIkZ8QcVDdgw6diIOqeH+4yjAOECMO1sx6NQTSE266xgmRsiP8/wvS+
         swvNcIsz8796ghLScgxoE06fRMA1mvp636aa+K0sZyG0CuGEAN5fdgo/P+aF0woxgOHB
         ZSjRfEqENGU/p6Ed2xUM4O9ktzB6jTQgwQsgTfHAunQ/fz8bp4uUp8ZrMpZtoKjkh1e6
         nMdg==
X-Gm-Message-State: AOJu0YzAfJSpb6Tpqxu50Qiv6WxLGJNpp85TDDSO65t1Rxcrs1IzzFWJ
	HFloVdImjhzQjnnttYolurmbiSW2DmLqEZyc4eoSCX3LRfA/Vb86TiiYQCMZBKqDiL1drZzJuC7
	Y
X-Google-Smtp-Source: AGHT+IFnMGb4t/kjhbZ71NmWqPIX+8RyVlAf0A6uipplbdk2RUEgYxB3W8dTueoliKdBSzvtDRZUog==
X-Received: by 2002:a25:2e0e:0:b0:dbd:b170:e119 with SMTP id u14-20020a252e0e000000b00dbdb170e119mr790482ybu.112.1706116793166;
        Wed, 24 Jan 2024 09:19:53 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id z15-20020a25868f000000b00dc252f785c3sm2871452ybk.17.2024.01.24.09.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:19:52 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v5 32/52] btrfs: setup fscrypt_extent_info for new extents
Date: Wed, 24 Jan 2024 12:18:54 -0500
Message-ID: <d8ab016d25f70c9365f508af1d8e0b9ab7c09d76.1706116485.git.josef@toxicpanda.com>
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

New extents for encrypted inodes must have a fscrypt_extent_info, which
has the necessary keys and does all the registration at the block layer
for them.  This is passed through all of the infrastructure we've
previously added to make sure the context gets saved properly with the
file extents.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 7fa38eaa5afd..71098063bb9f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7436,6 +7436,16 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode,
 	if (fscrypt_info) {
 		extent_map_set_encryption(em, BTRFS_ENCRYPTION_FSCRYPT);
 		em->fscrypt_info = fscrypt_get_extent_info(fscrypt_info);
+	} else if (IS_ENCRYPTED(&inode->vfs_inode)) {
+		struct fscrypt_extent_info *fscrypt_info;
+
+		extent_map_set_encryption(em, BTRFS_ENCRYPTION_FSCRYPT);
+		fscrypt_info = fscrypt_prepare_new_extent(&inode->vfs_inode);
+		if (IS_ERR(fscrypt_info)) {
+			free_extent_map(em);
+			return ERR_CAST(fscrypt_info);
+		}
+		em->fscrypt_info = fscrypt_info;
 	} else {
 		extent_map_set_encryption(em, BTRFS_ENCRYPTION_NONE);
 	}
@@ -9858,6 +9868,9 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 	if (trans)
 		own_trans = false;
 	while (num_bytes > 0) {
+		struct fscrypt_extent_info *fscrypt_info = NULL;
+		int encryption_type = BTRFS_ENCRYPTION_NONE;
+
 		cur_bytes = min_t(u64, num_bytes, SZ_256M);
 		cur_bytes = max(cur_bytes, min_size);
 		/*
@@ -9872,6 +9885,20 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 		if (ret)
 			break;
 
+		if (IS_ENCRYPTED(inode)) {
+			fscrypt_info = fscrypt_prepare_new_extent(inode);
+			if (IS_ERR(fscrypt_info)) {
+				btrfs_dec_block_group_reservations(fs_info,
+								   ins.objectid);
+				btrfs_free_reserved_extent(fs_info,
+							   ins.objectid,
+							   ins.offset, 0);
+				ret = PTR_ERR(fscrypt_info);
+				break;
+			}
+			encryption_type = BTRFS_ENCRYPTION_FSCRYPT;
+		}
+
 		/*
 		 * We've reserved this space, and thus converted it from
 		 * ->bytes_may_use to ->bytes_reserved.  Any error that happens
@@ -9883,7 +9910,8 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 
 		last_alloc = ins.offset;
 		trans = insert_prealloc_file_extent(trans, BTRFS_I(inode),
-						    &ins, NULL, cur_offset);
+						    &ins, fscrypt_info,
+						    cur_offset);
 		/*
 		 * Now that we inserted the prealloc extent we can finally
 		 * decrement the number of reservations in the block group.
@@ -9893,6 +9921,7 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 		btrfs_dec_block_group_reservations(fs_info, ins.objectid);
 		if (IS_ERR(trans)) {
 			ret = PTR_ERR(trans);
+			fscrypt_put_extent_info(fscrypt_info);
 			btrfs_free_reserved_extent(fs_info, ins.objectid,
 						   ins.offset, 0);
 			break;
@@ -9900,6 +9929,7 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 
 		em = alloc_extent_map();
 		if (!em) {
+			fscrypt_put_extent_info(fscrypt_info);
 			btrfs_drop_extent_map_range(BTRFS_I(inode), cur_offset,
 					    cur_offset + ins.offset - 1, false);
 			btrfs_set_inode_full_sync(BTRFS_I(inode));
@@ -9915,6 +9945,8 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 		em->ram_bytes = ins.offset;
 		em->flags |= EXTENT_FLAG_PREALLOC;
 		em->generation = trans->transid;
+		em->fscrypt_info = fscrypt_info;
+		extent_map_set_encryption(em, encryption_type);
 
 		ret = btrfs_replace_extent_map_range(BTRFS_I(inode), em, true);
 		free_extent_map(em);
-- 
2.43.0


