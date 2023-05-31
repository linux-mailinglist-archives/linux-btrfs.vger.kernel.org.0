Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2592717928
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 09:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234980AbjEaH4L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 03:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234967AbjEaHzo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 03:55:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2471C19B9
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 00:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Aw/C3yg+57Kjl+vjjMhY5P0KCsc0ec1DZQR5pfok8i4=; b=tt7UY956KeDjEFg833O5Rtmkxj
        u+8msoPN6jGje1GrtSglOH78g4IXuQg4tukP5u3XeRy1EA8mSljMoM/WxzszqLh7ybX4HwiuNvtR9
        gtST5L8o/aDwDn9WFPlQnzppv7Y9BGTgTYSQ+D/R8E94TBAdyIvjl2fzyBXvnT0bLTTW7kDKTdIlP
        kCSSjhBSZcrdzL4tTTy6L97wjSCRJyViq3p8AMAkYLxMV+VMstgRM62Vy/jegBB5mdAFGsfcm/jfS
        G1yJQh5Jgn6AhnEv4Sy5x/D0Hb/e2dVWG46kgXvO+ksmCt73rivHum++Pqcd4uSYutiQjX8J/3IE1
        1BBilAkg==;
Received: from [2001:4bb8:182:6d06:f5c3:53d7:b5aa:b6a7] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4Gez-00GWqb-0J;
        Wed, 31 May 2023 07:54:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 03/17] btrfs: merge the two calls to btrfs_add_ordered_extent in run_delalloc_nocow
Date:   Wed, 31 May 2023 09:53:56 +0200
Message-Id: <20230531075410.480499-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531075410.480499-1-hch@lst.de>
References: <20230531075410.480499-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
index a12d4f77859706..6115f10c5c096e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2128,6 +2128,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 		u64 ram_bytes;
 		u64 nocow_end;
 		int extent_type;
+		bool is_prealloc;
 
 		nocow = false;
 
@@ -2266,8 +2267,8 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 		}
 
 		nocow_end = cur_offset + nocow_args.num_bytes - 1;
-
-		if (extent_type == BTRFS_FILE_EXTENT_PREALLOC) {
+		is_prealloc = extent_type == BTRFS_FILE_EXTENT_PREALLOC;
+		if (is_prealloc) {
 			u64 orig_start = found_key.offset - nocow_args.extent_offset;
 			struct extent_map *em;
 
@@ -2283,29 +2284,21 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
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

