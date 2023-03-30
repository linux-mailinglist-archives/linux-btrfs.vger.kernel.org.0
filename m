Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A9E6CFB9B
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Mar 2023 08:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjC3Gbr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Mar 2023 02:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjC3Gbq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Mar 2023 02:31:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E3061AA
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 23:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=mH1uJZL/fH9NEAFk7hzMyXMWOiKvEdF6TfnpUfLqRzk=; b=ASW+aVUVP3cbNI9afRVngQcmpV
        GJeN/59Vbb4DkZoC+vAR9W7laB3tJFLr10T+Y5BKDLt5SpbyyMTZ523XNDwCERuq3O45ieVGOAFnk
        f7NBp6Y4pAs2E7YMWS1EvLCXIGIXqrl+BeYmFPbEyNDS7WBfoy8shbXdYW/JP46GIHdMvybUkbLV0
        fLQ7x+R9tY2wjpzUjRW8HmZ5GhFjqGEmxQcZNkqC9uJHNvRzQ516t3aSYofyr9e+3HNI01bBq1tqm
        23zy4N2ecqPcgdVEdZ+F+6ONe9iVmr64uwAwaE28SiCRgeDk6FaiXW0I5lCOzIqPeP/Tz5qg8YqG8
        T5J7ejyA==;
Received: from [182.171.77.115] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1phlp1-002lie-0y;
        Thu, 30 Mar 2023 06:31:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 19/21] btrfs: stop using lock_extent in btrfs_buffer_uptodate
Date:   Thu, 30 Mar 2023 15:30:57 +0900
Message-Id: <20230330063059.1574380-20-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330063059.1574380-1-hch@lst.de>
References: <20230330063059.1574380-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The only other place that locks extents on the btree inode is
read_extent_buffer_subpage while reading in the partial page for a
buffer.  This means locking the extent in btrfs_buffer_uptodate does not
synchronize with anything on non-supage file systems, and on subpage
file systems it only waits for a parallel read(-ahead) to finish,
which seems to be counter to what the callers actually expect.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/disk-io.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 3e15965c531e81..3bce00803af75f 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -113,11 +113,6 @@ static void csum_tree_block(struct extent_buffer *buf, u8 *result)
 int btrfs_buffer_uptodate(struct extent_buffer *eb, u64 parent_transid,
 			  int atomic)
 {
-	struct inode *btree_inode = eb->pages[0]->mapping->host;
-	struct extent_io_tree *io_tree = &BTRFS_I(btree_inode)->io_tree;
-	struct extent_state *cached_state = NULL;
-	int ret = 1;
-
 	if (!extent_buffer_uptodate(eb))
 		return 0;
 
@@ -127,7 +122,6 @@ int btrfs_buffer_uptodate(struct extent_buffer *eb, u64 parent_transid,
 	if (atomic)
 		return -EAGAIN;
 
-	lock_extent(io_tree, eb->start, eb->start + eb->len - 1, &cached_state);
 	if (!extent_buffer_uptodate(eb) ||
 	    btrfs_header_generation(eb) != parent_transid) {
 		btrfs_err_rl(eb->fs_info,
@@ -135,11 +129,9 @@ int btrfs_buffer_uptodate(struct extent_buffer *eb, u64 parent_transid,
 			eb->start, eb->read_mirror,
 			parent_transid, btrfs_header_generation(eb));
 		clear_extent_buffer_uptodate(eb);
-		ret = 0;
+		return 0;
 	}
-	unlock_extent(io_tree, eb->start, eb->start + eb->len - 1,
-		      &cached_state);
-	return ret;
+	return 1;
 }
 
 static bool btrfs_supported_super_csum(u16 csum_type)
-- 
2.39.2

