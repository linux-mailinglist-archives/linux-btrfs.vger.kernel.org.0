Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEC67CB252
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Oct 2023 20:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234223AbjJPSWc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Oct 2023 14:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbjJPSWV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Oct 2023 14:22:21 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FD0F2
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 11:22:18 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-66d264e67d8so17602086d6.1
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 11:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1697480538; x=1698085338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q5MCWk661EZR0yQflHwRp7j11F40Rg/sD7ho8oSo4N0=;
        b=ZhTF/T3XNQVatZydGHRvTW+B+V3MTmwaE3TNlfCrAikaJvVxAhujXSMGE5ntKYrb/h
         M7f+AExrEgt3Mf8ncaZhXEftS9hQkLr0Ivfey1678WlBUmV0DxXvLP58dqeo1HrOn+sZ
         KdgXxgAV7pUHr3g+fpYzGSpzj+/nHZrj4quomuglMIoFcbU2JHnWm12E9j2/H5xgg2aF
         W7JlYsy0x81JYH4Hv+EgzL9JnBFH38Fw4NUC8vofWw/B8oYC7JbNYUe9Iwd8H4zuywqE
         crt6ravKegSWGul+f5oyY6NLsemHSbxzHW/DJL+o2HDiRX2kK5jOQmB2Ld/2UsnGMa9f
         GfIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697480538; x=1698085338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q5MCWk661EZR0yQflHwRp7j11F40Rg/sD7ho8oSo4N0=;
        b=INd6y8SBzf5OrDDXCMKS2FGYxV9ghDuB5SGtf0oydTH0ebkZY7xVCQQ2+6cB9uuB5l
         B8w37jpwG97rC2UGAoWgH87EIEV05MXfTLrfis66vKtieufmtaCFp0FHF9aGIA6IlqYe
         FHam6jb81wpaXk1cuFOfXA1T5SX5gI0Xm/s8zlQOu0UpmOOKj9Bz3uCSaSRpQ72UGwtJ
         HLxOB7MapF5mI634e+XF403UPW34XQZ2xpJA2+UmMKfWQfVTFDpAaSEpd94J6WRMWRwK
         rUGbJgaIIQWjkzeeUaDJzoFR0HGnVGAnmQ3xRO0/uIG9WY35cEbQR7mG7a8wDpepTQvE
         xdbA==
X-Gm-Message-State: AOJu0Ywtxp73l2DE7zO0BXgNgzQbHcJpeI4RNzwSelcJHFHqb4HMnfgD
        M8h/X0taCig6SsEYFSWedtbvCTdNqtM89s8oeIL3Jg==
X-Google-Smtp-Source: AGHT+IEMSUFeX/w2LqeqyHD2PRlqrSDk5lU3r+BQ+a6HA+u9lazPv2Pf4CxyCXJVbYEEjunno7ii+w==
X-Received: by 2002:a05:6214:c49:b0:66d:44b6:8aa8 with SMTP id r9-20020a0562140c4900b0066d44b68aa8mr212475qvj.47.1697480537823;
        Mon, 16 Oct 2023 11:22:17 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id bz7-20020ad44c07000000b0065b2be40d58sm3573307qvb.25.2023.10.16.11.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 11:22:17 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v3 18/34] btrfs: set file extent encryption excplicitly
Date:   Mon, 16 Oct 2023 14:21:25 -0400
Message-ID: <e55aa2c59d6e679d1f7ec3f21c16ecf8c3315914.1697480198.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1697480198.git.josef@toxicpanda.com>
References: <cover.1697480198.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

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
index aa0844535644..5aaf204fa55f 100644
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
index e5b52edcb042..9cb8b82ff8be 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2992,7 +2992,9 @@ static int insert_ordered_extent_file_extent(struct btrfs_trans_handle *trans,
 	btrfs_set_stack_file_extent_num_bytes(&stack_fi, num_bytes);
 	btrfs_set_stack_file_extent_ram_bytes(&stack_fi, ram_bytes);
 	btrfs_set_stack_file_extent_compression(&stack_fi, oe->compress_type);
-	/* Encryption and other encoding is reserved and all 0 */
+	btrfs_set_stack_file_extent_encryption(&stack_fi,
+					       BTRFS_ENCRYPTION_NONE);
+	/* Other encoding is reserved and always 0 */
 
 	/*
 	 * For delalloc, when completing an ordered extent we update the inode's
@@ -9640,7 +9642,9 @@ static struct btrfs_trans_handle *insert_prealloc_file_extent(
 	btrfs_set_stack_file_extent_num_bytes(&stack_fi, len);
 	btrfs_set_stack_file_extent_ram_bytes(&stack_fi, len);
 	btrfs_set_stack_file_extent_compression(&stack_fi, BTRFS_COMPRESS_NONE);
-	/* Encryption and other encoding is reserved and all 0 */
+	btrfs_set_stack_file_extent_encryption(&stack_fi,
+					       BTRFS_ENCRYPTION_NONE);
+	/* Other encoding is reserved and always 0 */
 
 	qgroup_released = btrfs_qgroup_release_data(inode, file_offset, len);
 	if (qgroup_released < 0)
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index a416cbea75d1..825b235927c6 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -210,6 +210,7 @@ static int check_extent_data_item(struct extent_buffer *leaf,
 	u32 sectorsize = fs_info->sectorsize;
 	u32 item_size = btrfs_item_size(leaf, slot);
 	u64 extent_end;
+	u8 policy;
 
 	if (unlikely(!IS_ALIGNED(key->offset, sectorsize))) {
 		file_extent_err(leaf, slot,
@@ -261,10 +262,11 @@ static int check_extent_data_item(struct extent_buffer *leaf,
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
index c1fd4ef2dd8b..404577383513 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4628,6 +4628,7 @@ static int log_one_extent(struct btrfs_trans_handle *trans,
 	u64 extent_offset = em->start - em->orig_start;
 	u64 block_len;
 	int ret;
+	u8 encryption = BTRFS_ENCRYPTION_NONE;
 
 	btrfs_set_stack_file_extent_generation(&fi, trans->transid);
 	if (test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
@@ -4649,6 +4650,7 @@ static int log_one_extent(struct btrfs_trans_handle *trans,
 	btrfs_set_stack_file_extent_num_bytes(&fi, em->len);
 	btrfs_set_stack_file_extent_ram_bytes(&fi, em->ram_bytes);
 	btrfs_set_stack_file_extent_compression(&fi, em->compress_type);
+	btrfs_set_stack_file_extent_encryption(&fi, encryption);
 
 	ret = log_extent_csums(trans, inode, log, em, ctx);
 	if (ret)
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index ef796a3cf387..e5a4ba9573a0 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -1093,8 +1093,14 @@ struct btrfs_file_extent_item {
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
2.41.0

