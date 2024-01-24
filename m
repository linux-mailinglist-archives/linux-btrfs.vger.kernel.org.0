Return-Path: <linux-btrfs+bounces-1712-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2795183AF9B
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 18:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACC571F29DA1
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 17:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F1E1272BC;
	Wed, 24 Jan 2024 17:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ctWLfe8r"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8094A1272A5
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 17:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116793; cv=none; b=nAb4L4SNt/lh0qrneH9ns11VJbi/FeX5bvYfD/LJDkxvujDrPAXgJl/FzqmjQkX/cLOmQadfAKbIWd6bAMnNMAKKF/jo4DT8k6jD+l0NTBfq0yrR1LhvlchyD0qAjdKzZUqH1mi8caDHI2CuSjXf10tyVF6ce8iPAZiUr2P8n78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116793; c=relaxed/simple;
	bh=ZRnQu3exkXkwnxG+yjkYAkkQ8T9CooxMfPsSp8G/AOE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K+iqN5mw9klLarik/TIC2JcWyDXQuhux/wQIcIQOCCXsuTk2zkHHASsYJyCtVPOe/X6Th/AHCW0C/L+kpOBQQfJ0RXcWnHhqOhzQ9J1EPFkNZMmYLOU3GQcsPPKABRemi5Fk8f4anCjCFxj/04kpT0PPeFOsDAhJTV7rbMK/U9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=ctWLfe8r; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6000bbdbeceso33054277b3.2
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 09:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706116791; x=1706721591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D/wiyh1QIT2BsCtrC+Ms0ns85d4X+W1MMYQgMRRukyU=;
        b=ctWLfe8r0jfOAoFJNVQ/6dqy3aDEv4RaRZqa1XrDjVIL0T1CIGMVsxodMn1M5iX7aA
         JKFivYb2IhuVykDLyQu5Y5fdRVnXhqZNWKd91HiUmantXMpgpeYs6N846nDlZjm8/dDm
         tqWQLuXe1fk9FzXNFkD4rh8Jf8Pc0C7u9XbgnCoip1paK1Shrw5KjKxaac/VmDf/U76M
         otWPY7ZHwzP9/Cnu8eypf8OSvU1M7YQ7Bhb4MtAe8saXLubWxMNATae1ZB6WQZnXhaiX
         P1O3zApVGSOXWcKiaamvOlEBBjlx4cd2LSgFXupw/Qb2twPSzEVt1maz8DL3RXuFxIDu
         U3Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116791; x=1706721591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D/wiyh1QIT2BsCtrC+Ms0ns85d4X+W1MMYQgMRRukyU=;
        b=R5uOA7P5hWpsdq9J3GEWGMfaNV44bgYP1L6PCLSLAtTsWIZEcgQe3CU26G1ifJ21iM
         CQEDnl+5xCQc9cgHdP6apNS1Z71TxP7gRfkT46VxqfR8iWHIHb0bwJMInYUAghtguT+d
         Cv4kVCuCNuSNNI2TcbM3ElV7g0DJEl1zjE8v/LePPdNGtnexmmpMPGrPk9nRP7QhfVpW
         0mDi1uYnpNhf5TdjaSfc9OFz+sjJn8LJVLRIy1xONhsaBuBFC7HH9Ek493o2IVH0tGU0
         om/G/PAjlX3blCfDOsAQ+INLVGcKKPCVmEKR/eUfvDkIoqrRkdoQyCP3+Gxr+0C8yaPo
         Lpcw==
X-Gm-Message-State: AOJu0Yx4vqdE5unC4t785QaWLWIfEcwbNHgbuhOpM3bbkGSvM9pzDy04
	+DTboMFcN/Cu/nglh0WO/HSaLLiR5kV3M7H+6/l7HyIUEYe5XLGN3X/7u26/VgU1JEJOj+6JnIZ
	m
X-Google-Smtp-Source: AGHT+IF5QVABDHss/1hlMJdzyRmv5Nh6Y9wmpCANJ3EQBlrbY3FBDA1w/6hT5WcHPwawSyZ1ndfaDA==
X-Received: by 2002:a81:8901:0:b0:5ff:4910:dbca with SMTP id z1-20020a818901000000b005ff4910dbcamr1025423ywf.77.1706116791268;
        Wed, 24 Jan 2024 09:19:51 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id v143-20020a814895000000b005ff99f7e10esm60961ywa.138.2024.01.24.09.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:19:51 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v5 30/52] btrfs: pass through fscrypt_extent_info to the file extent helpers
Date: Wed, 24 Jan 2024 12:18:52 -0500
Message-ID: <a8b9dd312a4504f209e861cca5289a528b30ff95.1706116485.git.josef@toxicpanda.com>
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

Now that we have the fscrypt_extnet_info in all of the supporting
structures, pass this through and set the file extent encryption bit
accordingly from the supporting structures.  In subsequent patches code
will be added to populate these appropriately.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c    | 18 +++++++++++-------
 fs/btrfs/tree-log.c |  2 +-
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index cf22be63dcc6..e4557c460ee0 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2897,7 +2897,9 @@ int btrfs_writepage_cow_fixup(struct page *page)
 }
 
 static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
-				       struct btrfs_inode *inode, u64 file_pos,
+				       struct btrfs_inode *inode,
+				       struct fscrypt_extent_info *fscrypt_info,
+				       u64 file_pos,
 				       struct btrfs_file_extent_item *stack_fi,
 				       const bool update_inode_bytes,
 				       u64 qgroup_reserved)
@@ -3029,8 +3031,7 @@ static int insert_ordered_extent_file_extent(struct btrfs_trans_handle *trans,
 	btrfs_set_stack_file_extent_num_bytes(&stack_fi, num_bytes);
 	btrfs_set_stack_file_extent_ram_bytes(&stack_fi, ram_bytes);
 	btrfs_set_stack_file_extent_compression(&stack_fi, oe->compress_type);
-	btrfs_set_stack_file_extent_encryption(&stack_fi,
-					       BTRFS_ENCRYPTION_NONE);
+	btrfs_set_stack_file_extent_encryption(&stack_fi, oe->encryption_type);
 	/* Other encoding is reserved and always 0 */
 
 	/*
@@ -3044,8 +3045,9 @@ static int insert_ordered_extent_file_extent(struct btrfs_trans_handle *trans,
 			     test_bit(BTRFS_ORDERED_TRUNCATED, &oe->flags);
 
 	return insert_reserved_file_extent(trans, BTRFS_I(oe->inode),
-					   oe->file_offset, &stack_fi,
-					   update_inode_bytes, oe->qgroup_rsv);
+					   oe->fscrypt_info, oe->file_offset,
+					   &stack_fi, update_inode_bytes,
+					   oe->qgroup_rsv);
 }
 
 /*
@@ -9726,6 +9728,7 @@ static struct btrfs_trans_handle *insert_prealloc_file_extent(
 				       struct btrfs_trans_handle *trans_in,
 				       struct btrfs_inode *inode,
 				       struct btrfs_key *ins,
+				       struct fscrypt_extent_info *fscrypt_info,
 				       u64 file_offset)
 {
 	struct btrfs_file_extent_item stack_fi;
@@ -9747,6 +9750,7 @@ static struct btrfs_trans_handle *insert_prealloc_file_extent(
 	btrfs_set_stack_file_extent_ram_bytes(&stack_fi, len);
 	btrfs_set_stack_file_extent_compression(&stack_fi, BTRFS_COMPRESS_NONE);
 	btrfs_set_stack_file_extent_encryption(&stack_fi,
+					       fscrypt_info ? BTRFS_ENCRYPTION_FSCRYPT :
 					       BTRFS_ENCRYPTION_NONE);
 	/* Other encoding is reserved and always 0 */
 
@@ -9755,7 +9759,7 @@ static struct btrfs_trans_handle *insert_prealloc_file_extent(
 		return ERR_PTR(ret);
 
 	if (trans) {
-		ret = insert_reserved_file_extent(trans, inode,
+		ret = insert_reserved_file_extent(trans, inode, fscrypt_info,
 						  file_offset, &stack_fi,
 						  true, qgroup_released);
 		if (ret)
@@ -9849,7 +9853,7 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 
 		last_alloc = ins.offset;
 		trans = insert_prealloc_file_extent(trans, BTRFS_I(inode),
-						    &ins, cur_offset);
+						    &ins, NULL, cur_offset);
 		/*
 		 * Now that we inserted the prealloc extent we can finally
 		 * decrement the number of reservations in the block group.
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 43c3b972a4b1..102e78886c60 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4628,7 +4628,7 @@ static int log_one_extent(struct btrfs_trans_handle *trans,
 	u64 block_len;
 	int ret;
 	size_t fscrypt_context_size = 0;
-	u8 encryption = BTRFS_ENCRYPTION_NONE;
+	u8 encryption = extent_map_encryption(em);
 
 	btrfs_set_stack_file_extent_generation(&fi, trans->transid);
 	if (em->flags & EXTENT_FLAG_PREALLOC)
-- 
2.43.0


