Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2771D6FB4BD
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 May 2023 18:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233098AbjEHQIx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 May 2023 12:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjEHQIt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 May 2023 12:08:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721104EE5
        for <linux-btrfs@vger.kernel.org>; Mon,  8 May 2023 09:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=4of+mpuzF0uqA1N81tVzZ0M4R7lBJ+9pGzXtukj9jgM=; b=soP2MZX9sYpv0qYEC5KZiV9BKg
        VhbYKtJVCh6eydRh+AJYbGJWlxfApFNN/7zwF2sPbKVtSWgJJkW5iHvJMgycZXGQTBPglnjPLKtry
        aaRI96EcDpVZbUhkNvO3sIufxqRN/N1qa+pX/dKKTbQUfI2DsN5lQG8dMzal2nzEdtSCj0ppTjES/
        MgQ8Y6dA121mxaulwbDsDuXbYKlaL4rYqG7jgKz9FbMXk/hGgJCC6ZMgIt6HLUj4vaHL3ShdsOMGs
        tuvkK1ZmseoBS+7f4cO2vhiFM+Ug74qqYqyzchW3dtfXZ5GV165td4y2jw/OE4B4NLSCBmAMmsUMe
        2L0tbruw==;
Received: from [208.98.210.70] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pw3Pq-000w00-1F;
        Mon, 08 May 2023 16:08:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 04/21] btrfs: merge the two calls to btrfs_add_ordered_extent in run_delalloc_nocow
Date:   Mon,  8 May 2023 09:08:26 -0700
Message-Id: <20230508160843.133013-5-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230508160843.133013-1-hch@lst.de>
References: <20230508160843.133013-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Refactor run_delalloc_nocow a little bit so that there is only a single
call to btrfs_add_ordered_extent instead of two.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c | 37 +++++++++++++++----------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 4f9ef5ca385650..f0372a01c12423 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2145,6 +2145,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 		u64 ram_bytes;
 		u64 nocow_end;
 		int extent_type;
+		bool is_prealloc;
 
 		nocow = false;
 
@@ -2283,8 +2284,8 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 		}
 
 		nocow_end = cur_offset + nocow_args.num_bytes - 1;
-
-		if (extent_type == BTRFS_FILE_EXTENT_PREALLOC) {
+		is_prealloc = extent_type == BTRFS_FILE_EXTENT_PREALLOC;
+		if (is_prealloc) {
 			u64 orig_start = found_key.offset - nocow_args.extent_offset;
 			struct extent_map *em;
 
@@ -2300,29 +2301,21 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 				goto error;
 			}
 			free_extent_map(em);
-			ret = btrfs_add_ordered_extent(inode,
-					cur_offset, nocow_args.num_bytes,
-					nocow_args.num_bytes,
-					nocow_args.disk_bytenr,
-					nocow_args.num_bytes, 0,
-					1 << BTRFS_ORDERED_PREALLOC,
-					BTRFS_COMPRESS_NONE);
-			if (ret) {
+		}
+
+		ret = btrfs_add_ordered_extent(inode, cur_offset,
+				nocow_args.num_bytes, nocow_args.num_bytes,
+				nocow_args.disk_bytenr, nocow_args.num_bytes, 0,
+				is_prealloc ?
+					(1 << BTRFS_ORDERED_PREALLOC) :
+					(1 << BTRFS_ORDERED_NOCOW),
+				BTRFS_COMPRESS_NONE);
+		if (ret) {
+			if (is_prealloc) {
 				btrfs_drop_extent_map_range(inode, cur_offset,
 							    nocow_end, false);
-				goto error;
 			}
-		} else {
-			ret = btrfs_add_ordered_extent(inode, cur_offset,
-						       nocow_args.num_bytes,
-						       nocow_args.num_bytes,
-						       nocow_args.disk_bytenr,
-						       nocow_args.num_bytes,
-						       0,
-						       1 << BTRFS_ORDERED_NOCOW,
-						       BTRFS_COMPRESS_NONE);
-			if (ret)
-				goto error;
+			goto error;
 		}
 
 		if (nocow) {
-- 
2.39.2

