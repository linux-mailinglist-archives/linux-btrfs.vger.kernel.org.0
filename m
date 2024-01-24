Return-Path: <linux-btrfs+bounces-1703-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0078683AF94
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 18:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6885E1F28CDB
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 17:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3F286AC7;
	Wed, 24 Jan 2024 17:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="IcKD4s8I"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C2D86154
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 17:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116785; cv=none; b=hhL+30Q7q/f56jWM+PqmtU7xDQfqemc/gkZd58XXZFLYTtHNK9124t21qIFQknAlOKw527xqSuTaKKtVafPKEmizhbsIBZigmo2boCv8yWs5S42y1BgXqKCKJVXtnJtjbj1HnSgVJH4rPbBxTrtIkzz/opKleshVFUO2nV4uT98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116785; c=relaxed/simple;
	bh=OYNFjlSFttfo/bsa8p5w+OIMAuv/NeiC0lBXuZyDXpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZLzz9oSgL0qmVKwKUyndGuxfUhiG2BhdcSVIDeXo+HsUiXSvmYu14WuipbFBPBV5OZpgakm7qT+l7UK2J7KpYz6MCtuDKHe5AInij5eMsbMuQ0DiQIdJASeJSqsozSTixz/d8ZtoUOljgqqgcZKc9KKPgD05cw7KWES/syj9NEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=IcKD4s8I; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-602ab446cd8so1871017b3.1
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 09:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706116782; x=1706721582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kIWva0MuCS/RGv+Jd7LtFZ9O1HpJPZuUrn9Ep/eHzeA=;
        b=IcKD4s8IaxxaT4DHjrN7iufPr/LPQ0+jyyk+mEtqovP4oKU2/hXnSsn04LiL8WK3fO
         ovkXBHVkYDi86wqZILO8MNlVpf4c3GfjQK79wEcZ3oZiiRWwwLdwzmUqoAOSkO7MTJvL
         WqVCj6QfgO/pEUGsHsBiE+00wNZfg5SiZGf6rQsrY9aGE+bxXxjFWo8Mia5HuttWrocL
         yyRPu6Kg1wUvJXUvTknjofeBHCCiWyZh1BSl8grgNhRFmaoLLL9cSqkgM4LyvOYJcuop
         5AN8y8qMLD3Qo/dTsLF8VgxPks6DSOwmi3DnoWlG55QXs2bkOWKVbGrHM51o5ZpXi6Hu
         OZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116782; x=1706721582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kIWva0MuCS/RGv+Jd7LtFZ9O1HpJPZuUrn9Ep/eHzeA=;
        b=QmI9IliHpJEi6xVfHVhDsxKbQipQm2fUn3CoR0T/knZJkp/eXzv2WfiOdA6jHIFN1h
         qJrU5iO6kkY2Snoufm8QpBROIVqBKI/Oqc2UDrc/8gh7sfeG/YE5EOXLgAmDO7KirgLh
         YgNS5YvwgPSCJ7+nUwZOCgwZfVdVQSHRspGyTIz51PPiqzGreeAXTS9hxm8dI3lIJ4wA
         lJh/8ktCH3kCQGZegx7XemA68Z0oCDzoN/4eIhVPSjvr67Utv7g91w+ilOEFdOwA573j
         oHMS7VNH6k8nn0iouIP7j0h2QgQ0nhCXU+k8D+173n79qtdDAH4wSjbxSixBwN3vGJg6
         hzMA==
X-Gm-Message-State: AOJu0YyCodihmwssgesRLEqKbhzcJYw9MUaTCEIHDpBTwA+W7baxI3eW
	1S8FMjf8+lCJbh2NkGyNDnkAqvVruwm5NlaTUV1cbDnvpKswolGaAUVTril54p7Y9LMdaRGEKMn
	/
X-Google-Smtp-Source: AGHT+IF/GAxUs6y7Dgvrp5+bClxQsYrfWizBClt1+cbWe3rXMxSP+OzeUl0IJQ82InnwsyEp/1uLJQ==
X-Received: by 2002:a0d:d60a:0:b0:5ff:63ae:4f56 with SMTP id y10-20020a0dd60a000000b005ff63ae4f56mr1103776ywd.17.1706116782501;
        Wed, 24 Jan 2024 09:19:42 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id fq8-20020a05690c350800b005a7d46770f2sm61495ywb.83.2024.01.24.09.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:19:42 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Cc: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v5 21/52] btrfs: set file extent encryption excplicitly
Date: Wed, 24 Jan 2024 12:18:43 -0500
Message-ID: <1bf1cb768bc8bc54b3855e271412077c60f23c50.1706116485.git.josef@toxicpanda.com>
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

This puts the long-preserved 1-byte encryption field to work, storing
whether the extent is encrypted.  Update the tree-checker to allow for
the encryption bit to be set to our valid types.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/accessors.h            | 2 ++
 fs/btrfs/inode.c                | 8 ++++++--
 fs/btrfs/tree-checker.c         | 8 +++++---
 fs/btrfs/tree-log.c             | 2 ++
 include/uapi/linux/btrfs_tree.h | 8 +++++++-
 5 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
index ed7aa32972ad..cbc176d1dac1 100644
--- a/fs/btrfs/accessors.h
+++ b/fs/btrfs/accessors.h
@@ -949,6 +949,8 @@ BTRFS_SETGET_STACK_FUNCS(stack_file_extent_disk_num_bytes,
 			 struct btrfs_file_extent_item, disk_num_bytes, 64);
 BTRFS_SETGET_STACK_FUNCS(stack_file_extent_compression,
 			 struct btrfs_file_extent_item, compression, 8);
+BTRFS_SETGET_STACK_FUNCS(stack_file_extent_encryption,
+			 struct btrfs_file_extent_item, encryption, 8);
 
 
 BTRFS_SETGET_FUNCS(file_extent_type, struct btrfs_file_extent_item, type, 8);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5db3a92688fb..ec48c24fe630 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3001,7 +3001,9 @@ static int insert_ordered_extent_file_extent(struct btrfs_trans_handle *trans,
 	btrfs_set_stack_file_extent_num_bytes(&stack_fi, num_bytes);
 	btrfs_set_stack_file_extent_ram_bytes(&stack_fi, ram_bytes);
 	btrfs_set_stack_file_extent_compression(&stack_fi, oe->compress_type);
-	/* Encryption and other encoding is reserved and all 0 */
+	btrfs_set_stack_file_extent_encryption(&stack_fi,
+					       BTRFS_ENCRYPTION_NONE);
+	/* Other encoding is reserved and always 0 */
 
 	/*
 	 * For delalloc, when completing an ordered extent we update the inode's
@@ -9689,7 +9691,9 @@ static struct btrfs_trans_handle *insert_prealloc_file_extent(
 	btrfs_set_stack_file_extent_num_bytes(&stack_fi, len);
 	btrfs_set_stack_file_extent_ram_bytes(&stack_fi, len);
 	btrfs_set_stack_file_extent_compression(&stack_fi, BTRFS_COMPRESS_NONE);
-	/* Encryption and other encoding is reserved and all 0 */
+	btrfs_set_stack_file_extent_encryption(&stack_fi,
+					       BTRFS_ENCRYPTION_NONE);
+	/* Other encoding is reserved and always 0 */
 
 	ret = btrfs_qgroup_release_data(inode, file_offset, len, &qgroup_released);
 	if (ret < 0)
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 6eccf8496486..1141b5d92ac9 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -211,6 +211,7 @@ static int check_extent_data_item(struct extent_buffer *leaf,
 	u32 sectorsize = fs_info->sectorsize;
 	u32 item_size = btrfs_item_size(leaf, slot);
 	u64 extent_end;
+	u8 policy;
 
 	if (unlikely(!IS_ALIGNED(key->offset, sectorsize))) {
 		file_extent_err(leaf, slot,
@@ -262,10 +263,11 @@ static int check_extent_data_item(struct extent_buffer *leaf,
 			BTRFS_NR_COMPRESS_TYPES - 1);
 		return -EUCLEAN;
 	}
-	if (unlikely(btrfs_file_extent_encryption(leaf, fi))) {
+	policy = btrfs_file_extent_encryption(leaf, fi);
+	if (unlikely(policy >= BTRFS_NR_ENCRYPTION_TYPES)) {
 		file_extent_err(leaf, slot,
-			"invalid encryption for file extent, have %u expect 0",
-			btrfs_file_extent_encryption(leaf, fi));
+			"invalid encryption for file extent, have %u expect range [0, %u]",
+			policy, BTRFS_NR_ENCRYPTION_TYPES - 1);
 		return -EUCLEAN;
 	}
 	if (btrfs_file_extent_type(leaf, fi) == BTRFS_FILE_EXTENT_INLINE) {
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index c1ceaed65622..51059e5a282c 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4627,6 +4627,7 @@ static int log_one_extent(struct btrfs_trans_handle *trans,
 	u64 extent_offset = em->start - em->orig_start;
 	u64 block_len;
 	int ret;
+	u8 encryption = BTRFS_ENCRYPTION_NONE;
 
 	btrfs_set_stack_file_extent_generation(&fi, trans->transid);
 	if (em->flags & EXTENT_FLAG_PREALLOC)
@@ -4649,6 +4650,7 @@ static int log_one_extent(struct btrfs_trans_handle *trans,
 	btrfs_set_stack_file_extent_num_bytes(&fi, em->len);
 	btrfs_set_stack_file_extent_ram_bytes(&fi, em->ram_bytes);
 	btrfs_set_stack_file_extent_compression(&fi, compress_type);
+	btrfs_set_stack_file_extent_encryption(&fi, encryption);
 
 	ret = log_extent_csums(trans, inode, log, em, ctx);
 	if (ret)
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index f3fcca1c9449..effa93df6b90 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -1101,8 +1101,14 @@ struct btrfs_file_extent_item {
 	 * but not for stat.
 	 */
 	__u8 compression;
+
+	/*
+	 * Type of encryption in use. Unencrypted value is 0.
+	 */
 	__u8 encryption;
-	__le16 other_encoding; /* spare for later use */
+
+	/* spare for later use */
+	__le16 other_encoding;
 
 	/* are we inline data or a real extent? */
 	__u8 type;
-- 
2.43.0


