Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0478727ADB
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 11:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbjFHJKf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 05:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbjFHJKd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 05:10:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6C595
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 02:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=xzQWy1afB+qq0upbjXhJ/JSNQP2yInueLQeG6vrNp+o=; b=g2jCsCCrVAUd49gkAGzfSMSbQn
        G6JCiipWomZueLl58kk/a+8+QiHX0HP/ZvkZaWzyRr33dN+nG1cwMIvh+JLGuXOT7OYVBUziJLmx8
        fdwsT1+rFwk8JJ9ReAzaW4Il3899BQId2XAqpi+i1SV8mdf9Mh70yBsqaB6ObIN3zX8eSpZzGQC7f
        nUdvD5wGJIPyRZ+rH68oMiuGeyrWXNZhf2pPMBHFokclNeaJrdLpaL91P0P+Mdt3NoqbHKT5gSrjX
        nN9bKMVKqAKbZ7hn8YUp9jax5MsZcp1UEaTmZf109N99fYL0umEK/UDO7hSdodh6kS4y0ESNvkxOg
        Dvuk/sjA==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q7Bf3-008eKB-1R;
        Thu, 08 Jun 2023 09:10:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     nborisov@suse.com, linux-btrfs@vger.kernel.org,
        syzbot+ee90502d5c8fd1d0dd93@syzkaller.appspotmail.com
Subject: [PATCH] btrfs: fix iomap_begin length for nocow writes
Date:   Thu,  8 Jun 2023 11:10:25 +0200
Message-Id: <20230608091025.104716-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
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

can_nocow_extent can reduce the len passed in, which needs to be
propagated to btrfs_dio_iomap_begin so that iomap does not submit
more data then is mapped.

This problems exists since the btrfs_get_blocks_direct helper was added
in commit c5794e51784a ("btrfs: Factor out write portion of
btrfs_get_blocks_direct"), but the ordered_extent splitting added in
commit b73a6fd1b1ef ("btrfs: split partial dio bios before submit")
added a WARN_ON that made a syzcaller test fail.

Fixes: c5794e51784a ("btrfs: Factor out write portion of btrfs_get_blocks_direct")
Reported-by: syzbot+ee90502d5c8fd1d0dd93@syzkaller.appspotmail.com
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: syzbot+ee90502d5c8fd1d0dd93@syzkaller.appspotmail.com
---
 fs/btrfs/inode.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 19c707bc8801a9..3f99f02dc1fe20 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7264,7 +7264,7 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 static int btrfs_get_blocks_direct_write(struct extent_map **map,
 					 struct inode *inode,
 					 struct btrfs_dio_data *dio_data,
-					 u64 start, u64 len,
+					 u64 start, u64 *lenp,
 					 unsigned int iomap_flags)
 {
 	const bool nowait = (iomap_flags & IOMAP_NOWAIT);
@@ -7275,6 +7275,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 	struct btrfs_block_group *bg;
 	bool can_nocow = false;
 	bool space_reserved = false;
+	u64 len = *lenp;
 	u64 prev_len;
 	int ret = 0;
 
@@ -7345,15 +7346,19 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 		free_extent_map(em);
 		*map = NULL;
 
-		if (nowait)
-			return -EAGAIN;
+		if (nowait) {
+			ret = -EAGAIN;
+			goto out;
+		}
 
 		/*
 		 * If we could not allocate data space before locking the file
 		 * range and we can't do a NOCOW write, then we have to fail.
 		 */
-		if (!dio_data->data_space_reserved)
-			return -ENOSPC;
+		if (!dio_data->data_space_reserved) {
+			ret = -ENOSPC;
+			goto out;
+		}
 
 		/*
 		 * We have to COW and we have already reserved data space before,
@@ -7394,6 +7399,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 		btrfs_delalloc_release_extents(BTRFS_I(inode), len);
 		btrfs_delalloc_release_metadata(BTRFS_I(inode), len, true);
 	}
+	*lenp = len;
 	return ret;
 }
 
@@ -7570,7 +7576,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 
 	if (write) {
 		ret = btrfs_get_blocks_direct_write(&em, inode, dio_data,
-						    start, len, flags);
+						    start, &len, flags);
 		if (ret < 0)
 			goto unlock_err;
 		unlock_extents = true;
-- 
2.39.2

