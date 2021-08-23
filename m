Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 109CB3F51E1
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 22:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbhHWUPt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 16:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbhHWUPt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 16:15:49 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19554C061575
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Aug 2021 13:15:06 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id g11so14892030qtk.5
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Aug 2021 13:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3QDCulYuGjgRhd7CiWWolUZz+Qzo7UKc9pr9nZpMg9s=;
        b=SVROTRhFruoMJfltoWAwji0yrW2+S4jZcIooDrh3NwzAv0sIJrd8S0QUNBASbgUF5P
         MzP4NrcME6i31zknlDcotUnTX3gvSODmwF0U9kaL+dxwfa+T140y58ERNXEdxYC2JstH
         bvCpYXayU/Q/rh65dR+ry9kcMRdI/l6LhB/gTnNWZ/LXVX7pWwNoIoWBN5a+J25bP8TE
         e/K67k1APx767HmDUluUFDMcYSENVKMAfcnXlz4IPOwuOTa2nKloqndkAA46HiNLxDpc
         Njm8Km8PPPNi1uFFntCNHwL6KfjfxcQn7HDtDxlxrpNDFaHozKGaIsf+vdxBNsblm7Sw
         hk3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3QDCulYuGjgRhd7CiWWolUZz+Qzo7UKc9pr9nZpMg9s=;
        b=TZ+0TGSWm8pvms3yWvKDREJVfSni5YWFdYNsUxbaidg/aqKwtqjQakzA/rLPpKA5mW
         LcxvzCw8oSpmcNyZk6J238MPqvZiTqLLu5gCZsxLTQg8CVctFbkgu8xDGfaO14oJZkxN
         EwJhR8MVZT2nyoQDa2coZMwvrBWlHHuC1tey8VAPStuRUtKwljmjIJLEQhG9LlJBl8NQ
         9fLGUwEOBwxKgm3Ki8vfShNqp38XKmR5aZN8LNTcKYXaCwUu5VKgscx223yu8bcxHKHT
         C6glnHijvuMuLvkUpJIHh5xe95HENA4PUtFU/LQPN3AnPzJv4Do7jf8c0PDldGSexg6q
         QRBQ==
X-Gm-Message-State: AOAM531caNC69FBR+zknpBpWCweV2aYAKZAJyonLVJF/D9lCBJZOK4PX
        OffuHtDWNn6mBBMe+Y0RkDPeY+RwKH4AEA==
X-Google-Smtp-Source: ABdhPJzJKRV3fc7z2r/CDu2lr4icusmY8FJxyMsbCvKGEHKV7HfyJHJUNRLWC0l/r+Ke8g0FFyT/0Q==
X-Received: by 2002:ac8:73cb:: with SMTP id v11mr5711161qtp.292.1629749704894;
        Mon, 23 Aug 2021 13:15:04 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w129sm9304069qkb.61.2021.08.23.13.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 13:15:04 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v2 05/10] btrfs-progs: mkfs: add helper for writing empty tree nodes
Date:   Mon, 23 Aug 2021 16:14:50 -0400
Message-Id: <fe2a03b4c09ccc01bace112d68f09b2a372e1dae.1629749291.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1629749291.git.josef@toxicpanda.com>
References: <cover.1629749291.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With extent tree v2 we're going to be writing some more empty trees for
the initial mkfs step, so take this common code and make it a helper.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 mkfs/common.c | 47 +++++++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/mkfs/common.c b/mkfs/common.c
index 339c5556..a392a5b0 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -39,6 +39,25 @@ static u64 reference_root_table[] = {
 	[MKFS_CSUM_TREE]	=	BTRFS_CSUM_TREE_OBJECTID,
 };
 
+static int btrfs_write_empty_tree(int fd, struct btrfs_mkfs_config *cfg,
+				  struct extent_buffer *buf, u64 objectid,
+				  u64 block)
+{
+	int ret;
+
+	memset(buf->data + sizeof(struct btrfs_header), 0,
+		cfg->nodesize - sizeof(struct btrfs_header));
+	btrfs_set_header_bytenr(buf, block);
+	btrfs_set_header_owner(buf, objectid);
+	btrfs_set_header_nritems(buf, 0);
+	csum_tree_block_size(buf, btrfs_csum_type_size(cfg->csum_type), 0,
+			     cfg->csum_type);
+	ret = pwrite(fd, buf->data, cfg->nodesize, block);
+	if (ret != cfg->nodesize)
+		return ret < 0 ? -errno : -EIO;
+	return 0;
+}
+
 static int btrfs_create_tree_root(int fd, struct btrfs_mkfs_config *cfg,
 				  struct extent_buffer *buf,
 				  const enum btrfs_mkfs_block *blocks,
@@ -453,31 +472,15 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	}
 
 	/* create the FS root */
-	memset(buf->data + sizeof(struct btrfs_header), 0,
-		cfg->nodesize - sizeof(struct btrfs_header));
-	btrfs_set_header_bytenr(buf, cfg->blocks[MKFS_FS_TREE]);
-	btrfs_set_header_owner(buf, BTRFS_FS_TREE_OBJECTID);
-	btrfs_set_header_nritems(buf, 0);
-	csum_tree_block_size(buf, btrfs_csum_type_size(cfg->csum_type), 0,
-			     cfg->csum_type);
-	ret = pwrite(fd, buf->data, cfg->nodesize, cfg->blocks[MKFS_FS_TREE]);
-	if (ret != cfg->nodesize) {
-		ret = (ret < 0 ? -errno : -EIO);
+	ret = btrfs_write_empty_tree(fd, cfg, buf, BTRFS_FS_TREE_OBJECTID,
+				     cfg->blocks[MKFS_FS_TREE]);
+	if (ret)
 		goto out;
-	}
 	/* finally create the csum root */
-	memset(buf->data + sizeof(struct btrfs_header), 0,
-		cfg->nodesize - sizeof(struct btrfs_header));
-	btrfs_set_header_bytenr(buf, cfg->blocks[MKFS_CSUM_TREE]);
-	btrfs_set_header_owner(buf, BTRFS_CSUM_TREE_OBJECTID);
-	btrfs_set_header_nritems(buf, 0);
-	csum_tree_block_size(buf, btrfs_csum_type_size(cfg->csum_type), 0,
-			     cfg->csum_type);
-	ret = pwrite(fd, buf->data, cfg->nodesize, cfg->blocks[MKFS_CSUM_TREE]);
-	if (ret != cfg->nodesize) {
-		ret = (ret < 0 ? -errno : -EIO);
+	ret = btrfs_write_empty_tree(fd, cfg, buf, BTRFS_CSUM_TREE_OBJECTID,
+				     cfg->blocks[MKFS_CSUM_TREE]);
+	if (ret)
 		goto out;
-	}
 
 	/* and write out the super block */
 	memset(buf->data, 0, BTRFS_SUPER_INFO_SIZE);
-- 
2.26.3

