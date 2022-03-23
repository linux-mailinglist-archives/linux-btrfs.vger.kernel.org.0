Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C7B4E563A
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Mar 2022 17:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245435AbiCWQVN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Mar 2022 12:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240527AbiCWQVN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Mar 2022 12:21:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D64570044
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 09:19:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C73E5B81F8B
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 16:19:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB98C340EE
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 16:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648052380;
        bh=xdhdYk9Qm+vG70wInVhwNdSfYvg45CWAcutn+LLUOP4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=QBnBoVfOhavYklIy8tIjIEqrxymc4La/MQMzcu3JJIH6lwszJIc8NhqFSnJUxgwBz
         e0MMjtr0UpwTXgYD4AUpBXNL/kTr1y4uygnllm+u/frSzpuCcemmY7Jew1pTFhmGz8
         Y7BFJ3Wcwx8JBRw02/wpaQLeJfAnB45xRYpbfDMTbAPEzchZMU3PQkiNDZ2qf8Z5DG
         8GeEZNSn17SOu2frMQcE1OMPTV0HtcZXclFqspq3aoP5N/B5Q/jdqGpg19SlmfXIKl
         MsZWMjvj1oJeNAwv6BdQZWUu0+mbzhx2dqigiRvCvhn0mxgiOVSGFAQgxMTsKR7uLz
         xjDOLYqq+He2w==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/8] btrfs: avoid blocking on page locks with nowait dio on compressed range
Date:   Wed, 23 Mar 2022 16:19:23 +0000
Message-Id: <41948e84d91d204a52d67daca1e56d4319d3744f.1648051582.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1648051582.git.fdmanana@suse.com>
References: <cover.1648051582.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

If we are doing NOWAIT direct IO read/write and our inode has compressed
extents, we call filemap_fdatawrite_range() against the range in order
to wait for compressed writeback to complete, since the generic code at
iomap_dio_rw() calls filemap_write_and_wait_range() once, which is not
enough to wait for compressed writeback to complete.

This call to filemap_fdatawrite_range() can block on page locks, since
the first writepages() on a range that we will try to compress results
only in queuing a work to compress the data while holding the pages
locked.

Even though the generic code at iomap_dio_rw() will do the right thing
and return -EAGAIN for NOWAIT requests in case there are pages in the
range, we can still end up at btrfs_dio_iomap_begin() with pages in the
range because either of the following can happen:

1) Memory mapped writes, as we haven't locked the range yet;

2) Buffered reads might have started, which lock the pages, and we do
   the filemap_fdatawrite_range() call before locking the file range.

So don't call filemap_fdatawrite_range() at btrfs_dio_iomap_begin() if we
are doing a NOWAIT read/write. Instead call filemap_range_needs_writeback()
to check if there are any locked, dirty, or under writeback pages, and
return -EAGAIN if that's the case.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 78a5145353e1..3a10b729fd51 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7537,17 +7537,35 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	lockend = start + len - 1;
 
 	/*
-	 * The generic stuff only does filemap_write_and_wait_range, which
-	 * isn't enough if we've written compressed pages to this area, so we
-	 * need to flush the dirty pages again to make absolutely sure that any
-	 * outstanding dirty pages are on disk.
+	 * iomap_dio_rw() only does filemap_write_and_wait_range(), which isn't
+	 * enough if we've written compressed pages to this area, so we need to
+	 * flush the dirty pages again to make absolutely sure that any
+	 * outstanding dirty pages are on disk - the first flush only starts
+	 * compression on the data, while keeping the pages locked, so by the
+	 * time the second flush returns we know bios for the compressed pages
+	 * were submitted and finished, and the pages no longer under writeback.
+	 *
+	 * If we have a NOWAIT request and we have any pages in the range that
+	 * are locked, likely due to compression still in progress, we don't want
+	 * to block on page locks. We also don't want to block on pages marked as
+	 * dirty or under writeback (same as for the non-compression case).
+	 * iomap_dio_rw() did the same check, but after that and before we got
+	 * here, mmap'ed writes may have happened or buffered reads started
+	 * (readpage() and readahead(), which lock pages), as we haven't locked
+	 * the file range yet.
 	 */
 	if (test_bit(BTRFS_INODE_HAS_ASYNC_EXTENT,
 		     &BTRFS_I(inode)->runtime_flags)) {
-		ret = filemap_fdatawrite_range(inode->i_mapping, start,
-					       start + length - 1);
-		if (ret)
-			return ret;
+		if (flags & IOMAP_NOWAIT) {
+			if (filemap_range_needs_writeback(inode->i_mapping,
+							  lockstart, lockend))
+				return -EAGAIN;
+		} else {
+			ret = filemap_fdatawrite_range(inode->i_mapping, start,
+						       start + length - 1);
+			if (ret)
+				return ret;
+		}
 	}
 
 	dio_data = kzalloc(sizeof(*dio_data), GFP_NOFS);
-- 
2.33.0

