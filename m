Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B7C7CB261
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Oct 2023 20:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234213AbjJPSWv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Oct 2023 14:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234212AbjJPSWk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Oct 2023 14:22:40 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D402E195
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 11:22:31 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id 71dfb90a1353d-49d0f24a815so2124648e0c.2
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 11:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1697480550; x=1698085350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/lG6cmi+XemzHTouP6yyHX+TZQxYU9G/Ow3oUnVe924=;
        b=lj7HduAZJpS2Ep6+4St65Lb0U/Lp73cMmkJuNsvttugDYpbYaTUFNE9BhWzhsTwiRq
         MpuxSkiamWWy//SZbDCMegG+vfWilpq9ua5JhL90k4ms8Oe12ruiZqoVRvUhgQ+nH5Db
         F6dBBEWkJOnz4wbdrYzaDY2rNRMd8L/zZK81nRhGCUPUQMueyGZhFvdQ20ipKfhiRpqG
         esSLhwXv4iLCg9w9VF1PzxYGoeqoWrzKzX1LJuEszb7a3aA7BnEUpJrYG/CyoAdQsb34
         uIV2bQebASlPTwO3sWk7/XUwCM9XGawdFr/ZpvCB98WhrFmnz3YF7yWH4S/B8P/BEsug
         vELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697480551; x=1698085351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/lG6cmi+XemzHTouP6yyHX+TZQxYU9G/Ow3oUnVe924=;
        b=PdcNNVIZb3PVPTqxILOlGf9sugaJLsLHvLRptFwgj1qa0vLHDs53aQ1fvsedDW4PJ3
         2gCvQIxiBUYHa+YBDnCy0xCl1LIQ9H3CGSPCstPOWaVk6denLhwv901ff+mkb7PIS6e0
         rLSNXjCNXCZ2nlcwbGCQv/dvekKyUbE+y7QEuRGax8H1esGDWDds2uIkAtMsRzVZJ1e7
         lrHR+6kTAgHVxUdYvLgf/T3hEGlm/03W1P0FAlYLR4gl7o2VPP3u/a0yGA+KZD4oGMVR
         Z0a3hUcs07JWamAta0XXYNpcl3uAJbTO8twknCVmfdaHY4w1WeZGBIPlE3V64dAE6QUo
         X35Q==
X-Gm-Message-State: AOJu0YxZ7giEDwRm1gHd4qZKZ/g7kwURinFdMd7BDNy9lszNyqzNh5sT
        4tTDHj5dHwX5ShcF2MaX3mHs1PduTD8Nd5JlrkTZSA==
X-Google-Smtp-Source: AGHT+IFTF/QGEz8WQ8AbJOvUOzv/pi646j7QMXi4r7fEfYLjRn9sb6mE+Q4vu4wPeke3ruJ6O7/J5w==
X-Received: by 2002:a05:6122:12d0:b0:496:b3b7:5d4c with SMTP id d16-20020a05612212d000b00496b3b75d4cmr203641vkp.16.1697480550693;
        Mon, 16 Oct 2023 11:22:30 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id r6-20020ac84246000000b00419cb97418bsm3204200qtm.15.2023.10.16.11.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 11:22:30 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 29/34] btrfs: setup fscrypt_extent_info for new extents
Date:   Mon, 16 Oct 2023 14:21:36 -0400
Message-ID: <4440efad7e63248e21d92d43b03f98e8f4880533.1697480198.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1697480198.git.josef@toxicpanda.com>
References: <cover.1697480198.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

New extents for encrypted inodes must have a fscrypt_extent_info, which
has the necessary keys and does all the registration at the block layer
for them.  This is passed through all of the infrastructure we've
previously added to make sure the context gets saved properly with the
file extents.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 4f23c3af60be..b0109b313217 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7396,7 +7396,20 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 		set_bit(EXTENT_FLAG_COMPRESSED, &em->flags);
 		em->compress_type = compress_type;
 	}
-	em->encryption_type = BTRFS_ENCRYPTION_NONE;
+
+	if (IS_ENCRYPTED(&inode->vfs_inode)) {
+		struct fscrypt_extent_info *fscrypt_info;
+
+		em->encryption_type = BTRFS_ENCRYPTION_FSCRYPT;
+		fscrypt_info = fscrypt_prepare_new_extent(&inode->vfs_inode);
+		if (IS_ERR(fscrypt_info)) {
+			free_extent_map(em);
+			return ERR_CAST(fscrypt_info);
+		}
+		em->fscrypt_info = fscrypt_info;
+	} else {
+		em->encryption_type = BTRFS_ENCRYPTION_NONE;
+	}
 
 	ret = btrfs_replace_extent_map_range(inode, em, true);
 	if (ret) {
@@ -9785,6 +9798,9 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 	if (trans)
 		own_trans = false;
 	while (num_bytes > 0) {
+		struct fscrypt_extent_info *fscrypt_info = NULL;
+		int encryption_type = BTRFS_ENCRYPTION_NONE;
+
 		cur_bytes = min_t(u64, num_bytes, SZ_256M);
 		cur_bytes = max(cur_bytes, min_size);
 		/*
@@ -9799,6 +9815,20 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
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
@@ -9810,7 +9840,8 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 
 		last_alloc = ins.offset;
 		trans = insert_prealloc_file_extent(trans, BTRFS_I(inode),
-						    &ins, NULL, cur_offset);
+						    &ins, fscrypt_info,
+						    cur_offset);
 		/*
 		 * Now that we inserted the prealloc extent we can finally
 		 * decrement the number of reservations in the block group.
@@ -9820,6 +9851,7 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 		btrfs_dec_block_group_reservations(fs_info, ins.objectid);
 		if (IS_ERR(trans)) {
 			ret = PTR_ERR(trans);
+			fscrypt_put_extent_info(fscrypt_info);
 			btrfs_free_reserved_extent(fs_info, ins.objectid,
 						   ins.offset, 0);
 			break;
@@ -9827,6 +9859,7 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 
 		em = alloc_extent_map();
 		if (!em) {
+			fscrypt_put_extent_info(fscrypt_info);
 			btrfs_drop_extent_map_range(BTRFS_I(inode), cur_offset,
 					    cur_offset + ins.offset - 1, false);
 			btrfs_set_inode_full_sync(BTRFS_I(inode));
@@ -9842,6 +9875,8 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 		em->ram_bytes = ins.offset;
 		set_bit(EXTENT_FLAG_PREALLOC, &em->flags);
 		em->generation = trans->transid;
+		em->fscrypt_info = fscrypt_info;
+		em->encryption_type = encryption_type;
 
 		ret = btrfs_replace_extent_map_range(BTRFS_I(inode), em, true);
 		free_extent_map(em);
-- 
2.41.0

