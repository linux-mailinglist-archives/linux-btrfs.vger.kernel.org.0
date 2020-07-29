Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14777231B62
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jul 2020 10:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgG2Iku (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jul 2020 04:40:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:43110 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726993AbgG2Ikt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jul 2020 04:40:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 18BF0AC22
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jul 2020 08:40:59 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs-progs: convert: report available space before convertion happens
Date:   Wed, 29 Jul 2020 16:40:38 +0800
Message-Id: <20200729084038.78151-4-wqu@suse.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200729084038.78151-1-wqu@suse.com>
References: <20200729084038.78151-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now if an ENOSPC error happened, the free space report would help user
to determine if it's a real ENOSPC or a bug in btrfs.

The reported free space is the calculated free space, which doesn't
include super block space, nor merged data chunks.

The free space is always smaller than the reported available space of
the original fs, as we need extra padding space for used space to avoid
too fragmented data chunks.

The output exact would be:

$ ./btrfs-convert  /dev/nvme/btrfs
create btrfs filesystem:
        blocksize: 4096
        nodesize:  16384
        features:  extref, skinny-metadata (default)
        checksum:  crc32c
free space report: free / total = 0 / 10737418240 (0%) <<<
ERROR: unable to create initial ctree: No space left on device
WARNING: an error occurred during conversion, the original filesystem is not modified

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 convert/common.h    |  9 +++++++++
 convert/main.c      | 26 ++++++++++++++++++++++++--
 convert/source-fs.c |  1 +
 3 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/convert/common.h b/convert/common.h
index 7ec26cd996d3..2c7799433294 100644
--- a/convert/common.h
+++ b/convert/common.h
@@ -35,6 +35,7 @@ struct btrfs_convert_context {
 	u64 inodes_count;
 	u64 free_inodes_count;
 	u64 total_bytes;
+	u64 free_bytes_initial;
 	char *volume_name;
 	const struct btrfs_convert_operations *convert_ops;
 
@@ -47,6 +48,14 @@ struct btrfs_convert_context {
 	/* Free space which is not covered by data_chunks */
 	struct cache_tree free_space;
 
+	/*
+	 * Free space reserved for ENOSPC report, it's just a copy
+	 * free_space.
+	 * But after initial calculation, free_space_initial is no longer
+	 * updated, so we have a good idea on how many free space we really
+	 * have for btrfs.
+	 */
+	struct cache_tree free_space_initial;
 	void *fs_data;
 };
 
diff --git a/convert/main.c b/convert/main.c
index 451e4f158689..49c95e092cbb 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -727,6 +727,23 @@ out:
 	return ret;
 }
 
+static int copy_free_space_tree(struct btrfs_convert_context *cctx)
+{
+	struct cache_tree *src = &cctx->free_space;
+	struct cache_tree *dst = &cctx->free_space_initial;
+	struct cache_extent *cache;
+	int ret = 0;
+
+	for (cache = search_cache_extent(src, 0); cache;
+	     cache = next_cache_extent(cache)) {
+		ret = add_merge_cache_extent(dst, cache->start, cache->size);
+		if (ret < 0)
+			return ret;
+		cctx->free_bytes_initial += cache->size;
+	}
+	return ret;
+}
+
 /*
  * Read used space, and since we have the used space,
  * calculate data_chunks and free for later mkfs
@@ -740,7 +757,10 @@ static int convert_read_used_space(struct btrfs_convert_context *cctx)
 		return ret;
 
 	ret = calculate_available_space(cctx);
-	return ret;
+	if (ret < 0)
+		return ret;
+
+	return copy_free_space_tree(cctx);
 }
 
 /*
@@ -1165,7 +1185,9 @@ static int do_convert(const char *devname, u32 convert_flags, u32 nodesize,
 	printf("\tnodesize:  %u\n", nodesize);
 	printf("\tfeatures:  %s\n", features_buf);
 	printf("\tchecksum:  %s\n", btrfs_super_csum_name(csum_type));
-
+	printf("free space report: free / total = %llu / %llu (%lld%%)\n",
+		cctx.free_bytes_initial, cctx.total_bytes,
+		cctx.free_bytes_initial * 100 / cctx.total_bytes);
 	memset(&mkfs_cfg, 0, sizeof(mkfs_cfg));
 	mkfs_cfg.csum_type = csum_type;
 	mkfs_cfg.label = cctx.volume_name;
diff --git a/convert/source-fs.c b/convert/source-fs.c
index f7fd3d6055b7..d2f7a825238d 100644
--- a/convert/source-fs.c
+++ b/convert/source-fs.c
@@ -74,6 +74,7 @@ void init_convert_context(struct btrfs_convert_context *cctx)
 	cache_tree_init(&cctx->used_space);
 	cache_tree_init(&cctx->data_chunks);
 	cache_tree_init(&cctx->free_space);
+	cache_tree_init(&cctx->free_space_initial);
 }
 
 void clean_convert_context(struct btrfs_convert_context *cctx)
-- 
2.27.0

