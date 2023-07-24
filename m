Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABBF75F9B4
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jul 2023 16:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbjGXOWq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 10:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjGXOWq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 10:22:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C241B7
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jul 2023 07:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=xsBvUcQfoEWTfGOm5VUo3ESEXs5/PPyx0DWl0kQturM=; b=ivz5yECaHm/jbe3O6WrpsppCMA
        ytaYuZserA0UqIxVCE3FlfBXdM1ljCfoP6U/YZbO+pazdAaJHNxV+5NqFvoZkWx82Y0oidLI4UgpR
        Q029Z/TKcieX/BTWFDjqbPld0xPFZ7BJKQzL98Db6mFDBZMSTfEpDq/e25s6AOi7g4G9rF9r4wOPx
        1RpCxqYYP6xmeSL6IO+ankY2RxJsiNCTm+Mxb3j1en8oc27abStbw6KJQXoqeM3Eb57H02JtwCieW
        +YZDq9O67nzHrBnnhhwLpjY2WarcvYSVMi8ovl8VOb7xsLS5oT4Povd/LW8LP1vgIIs8Sow2T8cwj
        OPdpLquA==;
Received: from 67-207-104-238.static.wiline.com ([67.207.104.238] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qNwSR-004b9V-2M;
        Mon, 24 Jul 2023 14:22:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/6] btrfs: fix error handling when in a COW window in run_delalloc_nocow
Date:   Mon, 24 Jul 2023 07:22:38 -0700
Message-Id: <20230724142243.5742-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724142243.5742-1-hch@lst.de>
References: <20230724142243.5742-1-hch@lst.de>
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

When run_delalloc_nocow has cow_start set to a value other than (u64)-1,
it has delayed COW writeback pending behind cur_offset.  When an error
occurs in such a window, the range going back to cow_start and not just
cur_offset needs to be unlocked, but only two error cases handle this
correctly  Move the code to handle unlock the COW range to the common
error handling label and document the logic.

To make things even more complicated, cow_file_range as called by
fallback_to_cow will unlock the range it is operating on when it fails as
well, so we need to reset cow_start right after caling fallback_to_cow
instead of only when it succeeded.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 640e7dd26f6132..434f82fa4957d3 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2031,11 +2031,8 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 		leaf = path->nodes[0];
 		if (path->slots[0] >= btrfs_header_nritems(leaf)) {
 			ret = btrfs_next_leaf(root, path);
-			if (ret < 0) {
-				if (cow_start != (u64)-1)
-					cur_offset = cow_start;
+			if (ret < 0)
 				goto error;
-			}
 			if (ret > 0)
 				break;
 			leaf = path->nodes[0];
@@ -2098,13 +2095,10 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 
 		nocow_args.start = cur_offset;
 		ret = can_nocow_file_extent(path, &found_key, inode, &nocow_args);
-		if (ret < 0) {
-			if (cow_start != (u64)-1)
-				cur_offset = cow_start;
+		if (ret < 0)
 			goto error;
-		} else if (ret == 0) {
+		if (ret == 0)
 			goto out_check;
-		}
 
 		ret = 0;
 		bg = btrfs_inc_nocow_writers(fs_info, nocow_args.disk_bytenr);
@@ -2135,9 +2129,9 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 		if (cow_start != (u64)-1) {
 			ret = fallback_to_cow(inode, locked_page,
 					      cow_start, found_key.offset - 1);
+			cow_start = (u64)-1;
 			if (ret)
 				goto error;
-			cow_start = (u64)-1;
 		}
 
 		nocow_end = cur_offset + nocow_args.num_bytes - 1;
@@ -2216,6 +2210,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 	if (cow_start != (u64)-1) {
 		cur_offset = end;
 		ret = fallback_to_cow(inode, locked_page, cow_start, end);
+		cow_start = (u64)-1;
 		if (ret)
 			goto error;
 	}
@@ -2224,6 +2219,13 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 	if (nocow)
 		btrfs_dec_nocow_writers(bg);
 
+	/*
+	 * If an error happened while a COW region is outstanding, cur_offset
+	 * needs to be reset to cow_start to ensure the COW region is unlocked
+	 * as well.
+	 */
+	if (cow_start != (u64)-1)
+		cur_offset = cow_start;
 	if (ret && cur_offset < end)
 		extent_clear_unlock_delalloc(inode, cur_offset, end,
 					     locked_page, EXTENT_LOCKED |
-- 
2.39.2

