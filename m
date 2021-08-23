Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5CC73F51DE
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 22:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbhHWUPo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 16:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbhHWUPo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 16:15:44 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB30C061575
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Aug 2021 13:15:01 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id a66so1847223qkc.1
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Aug 2021 13:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=OUTnjDt2fPnKZkbPtE3c5yUpcclsZaL7w/4Ket3lhAM=;
        b=FWUSrmZew5PEAleOHtkeOSdWLlUHpVLKE4OvhLiNm8ztaHoIkpTyK7QqJtA8e3BFDd
         z/uGxAGecUhWoEmmIM105v3NyviPKpP6luFm76WnDqMrxaWkr6L2Hi6aaOTNDmHAfHI4
         dCAdXbJPkw7mWz2rBNJMrqtCk/ExzdDU5kDFM9sZwwbvofXANC9s/4z5qqFYg2eYhHxg
         ktFFXVSkUpyXyQ5aXqko+U/Xfp3e3fpnTcJNJPxQKDpgSYB7Wp2ZCTMGkIm+6cVgkQE+
         DKAOzlNDTjbY13Iqmgx7WKSbPbWWf6b4msvr/cNQbMW4l00w+JcHhbG2iYCRjcphCxHx
         nfVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OUTnjDt2fPnKZkbPtE3c5yUpcclsZaL7w/4Ket3lhAM=;
        b=LM4uzEDnfAlnjxL0W+qwn+YkNP2V1YPC3t7oFTjsmwNeRxX6bo6RP99v5jgRrfLKKA
         fiVNzNwhOdJrnel9bAxdDX5lOauSBsM8Ya4HSBiM6w4NWsCPFISSrLuQae4lHElrioBA
         /u82FqmliI8eD+HOAMr5t0q0bRfhIxh3NFBPdtOurq9rXWR46LD3+zVEJ+YtrVnVPH1e
         hMmywYy894mZbBdcZzT8m8+rPHp0yau52tG1qgrbc+M7Cid09FgReJKrtD8vRfVfino3
         4b2qqyYoUZtzO1U6DYBXRPbdnAMUbwBbkcgm9oKMi2Xwyw12bfLh//rsjTFpZdyaxg+F
         pvDg==
X-Gm-Message-State: AOAM530hHVrLMstRFAG6XifGwMDQjeS8iYKIpktOVRaV5wIf5Lu0LVIT
        6z8QKxYNery7Z40FI293JTamVTBrhkEm7w==
X-Google-Smtp-Source: ABdhPJwDIz+w4hO38IGNi55/OdvNH/4R52Jojzq9o9EBMOx8OiUACZpsqbfkuZf2NoSCFhzbVkoTHg==
X-Received: by 2002:a05:620a:1495:: with SMTP id w21mr22801483qkj.443.1629749699878;
        Mon, 23 Aug 2021 13:14:59 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n189sm9193188qka.69.2021.08.23.13.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 13:14:59 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 02/10] btrfs-progs: mkfs: get rid of MKFS_SUPER_BLOCK
Date:   Mon, 23 Aug 2021 16:14:47 -0400
Message-Id: <af239313f5dd2ce233ffb306c620405c9815d1ec.1629749291.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1629749291.git.josef@toxicpanda.com>
References: <cover.1629749291.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We use these block's in order to keep track of which blocks need to be
added to the extent tree and where their roots need to be written.
However we skip MKFS_SUPER_BLOCK for all of these helpers, and we don't
actually need to keep track of the specific block we allocated because
it is always BTRFS_SUPER_INFO_OFFSET.  Remove this enum as we don't need
it.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 mkfs/common.c | 17 ++++++-----------
 mkfs/common.h |  2 --
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/mkfs/common.c b/mkfs/common.c
index 35ee4bff..ee9ad390 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -76,8 +76,7 @@ static int btrfs_create_tree_root(int fd, struct btrfs_mkfs_config *cfg,
 
 	for (i = 0; i < blocks_nr; i++) {
 		blk = blocks[i];
-		if (blk == MKFS_SUPER_BLOCK || blk == MKFS_ROOT_TREE
-		    || blk == MKFS_CHUNK_TREE)
+		if (blk == MKFS_ROOT_TREE || blk == MKFS_CHUNK_TREE)
 			continue;
 
 		btrfs_set_root_bytenr(&root_item, cfg->blocks[blk]);
@@ -201,15 +200,12 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	uuid_generate(super.dev_item.uuid);
 	uuid_generate(chunk_tree_uuid);
 
-	cfg->blocks[MKFS_SUPER_BLOCK] = BTRFS_SUPER_INFO_OFFSET;
 	for (i = 0; i < blocks_nr; i++) {
 		blk = blocks[i];
-		if (blk == MKFS_SUPER_BLOCK)
-			continue;
-		cfg->blocks[i] = system_group_offset + cfg->nodesize * (i - 1);
+		cfg->blocks[blk] = system_group_offset + cfg->nodesize * i;
 	}
 
-	btrfs_set_super_bytenr(&super, cfg->blocks[MKFS_SUPER_BLOCK]);
+	btrfs_set_super_bytenr(&super, BTRFS_SUPER_INFO_OFFSET);
 	btrfs_set_super_num_devices(&super, 1);
 	btrfs_set_super_magic(&super, BTRFS_MAGIC_TEMPORARY);
 	btrfs_set_super_generation(&super, 1);
@@ -257,8 +253,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	itemoff = __BTRFS_LEAF_DATA_SIZE(cfg->nodesize);
 	for (i = 0; i < blocks_nr; i++) {
 		blk = blocks[i];
-		if (blk == MKFS_SUPER_BLOCK)
-			continue;
+
 		item_size = sizeof(struct btrfs_extent_item);
 		if (!skinny_metadata)
 			item_size += sizeof(struct btrfs_tree_block_info);
@@ -270,7 +265,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 			ret = -EINVAL;
 			goto out;
 		}
-		if (cfg->blocks[blk] < cfg->blocks[blocks[i - 1]]) {
+		if (i && cfg->blocks[blk] < cfg->blocks[blocks[i - 1]]) {
 			error("blocks %d and %d in reverse order: %llu < %llu",
 				blk, blocks[i - 1],
 				(unsigned long long)cfg->blocks[blk],
@@ -487,7 +482,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	buf->len = BTRFS_SUPER_INFO_SIZE;
 	csum_tree_block_size(buf, btrfs_csum_type_size(cfg->csum_type), 0,
 			     cfg->csum_type);
-	ret = sbwrite(fd, buf->data, cfg->blocks[MKFS_SUPER_BLOCK]);
+	ret = sbwrite(fd, buf->data, BTRFS_SUPER_INFO_OFFSET);
 	if (ret != BTRFS_SUPER_INFO_SIZE) {
 		ret = (ret < 0 ? -errno : -EIO);
 		goto out;
diff --git a/mkfs/common.h b/mkfs/common.h
index 378da6bd..f2d28057 100644
--- a/mkfs/common.h
+++ b/mkfs/common.h
@@ -45,7 +45,6 @@ struct btrfs_root;
  * Tree root blocks created during mkfs
  */
 enum btrfs_mkfs_block {
-	MKFS_SUPER_BLOCK = 0,
 	MKFS_ROOT_TREE,
 	MKFS_EXTENT_TREE,
 	MKFS_CHUNK_TREE,
@@ -56,7 +55,6 @@ enum btrfs_mkfs_block {
 };
 
 static const enum btrfs_mkfs_block extent_tree_v1_blocks[] = {
-	MKFS_SUPER_BLOCK,
 	MKFS_ROOT_TREE,
 	MKFS_EXTENT_TREE,
 	MKFS_CHUNK_TREE,
-- 
2.26.3

