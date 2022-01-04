Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B183D4841ED
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jan 2022 13:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbiADMxs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Jan 2022 07:53:48 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:49206 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiADMxr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Jan 2022 07:53:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B5E1EB81215
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Jan 2022 12:53:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE7BC36AE7
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Jan 2022 12:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641300825;
        bh=oNVb/yiOiKmg27MKe4tfrrkL9KDiigwjy4DNXYfgBcs=;
        h=From:To:Subject:Date:From;
        b=VXPN8tYjxEAA4oKcz9h+/RlSujF8HNNcpWkySZEtNOchR35y8nclNtMEWW0hIZIMB
         RZguCysWCo/4+rqrZc7Hl3AlRXfJwVByQpwyFm2ZsRF9JbWxpHOi8Z3uq5wkMgh1ck
         SRbyEc9t6BtCFKfb2ATH/RbnlN7TLFSCfDxsd81NMg1vYBk5m/nuKulsIla/Unnsl1
         KTIwpaPaxC65gos+wN6oYO7MRNjjjl4CcycWSXFDe1CZy9CVyhzRnTvARQlOC94API
         PkKMpoPSpIZIOu4t6pvV2fqptso7Wq70r/xwDnpd7jvohbcsZIMp77KvrTnsQhz8zH
         UaNeBdrTz2+Fw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove write and wait of struct walk_control
Date:   Tue,  4 Jan 2022 12:53:41 +0000
Message-Id: <a67495dc1ec5616c5ad09d6a0a761ae1d518ab06.1641300202.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The ->write and ->wait fields of struct walk_control, used for log trees,
are not used since 2008, more specifically since commit d0c803c4049c5c
("Btrfs: Record dirty pages tree-log pages in an extent_io tree") and
since commit d0c803c4049c5c ("Btrfs: Record dirty pages tree-log pages in
an extent_io tree"). So just remove them, along with the function
btrfs_write_tree_block(), which is also not used anymore after removing
the ->write member.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 28 +++++-----------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 4b89ac769347..a54ee3a1d082 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -270,12 +270,6 @@ void btrfs_end_log_trans(struct btrfs_root *root)
 	}
 }
 
-static int btrfs_write_tree_block(struct extent_buffer *buf)
-{
-	return filemap_fdatawrite_range(buf->pages[0]->mapping, buf->start,
-					buf->start + buf->len - 1);
-}
-
 static void btrfs_wait_tree_block_writeback(struct extent_buffer *buf)
 {
 	filemap_fdatawait_range(buf->pages[0]->mapping,
@@ -294,16 +288,6 @@ struct walk_control {
 	 */
 	int free;
 
-	/* should we write out the extent buffer?  This is used
-	 * while flushing the log tree to disk during a sync
-	 */
-	int write;
-
-	/* should we wait for the extent buffer io to finish?  Also used
-	 * while flushing the log tree to disk for a sync
-	 */
-	int wait;
-
 	/* pin only walk, we record which extents on disk belong to the
 	 * log trees
 	 */
@@ -354,17 +338,15 @@ static int process_one_buffer(struct btrfs_root *log,
 			return ret;
 	}
 
-	if (wc->pin)
+	if (wc->pin) {
 		ret = btrfs_pin_extent_for_log_replay(wc->trans, eb->start,
 						      eb->len);
+		if (ret)
+			return ret;
 
-	if (!ret && btrfs_buffer_uptodate(eb, gen, 0)) {
-		if (wc->pin && btrfs_header_level(eb) == 0)
+		if (btrfs_buffer_uptodate(eb, gen, 0) &&
+		    btrfs_header_level(eb) == 0)
 			ret = btrfs_exclude_logged_extents(eb);
-		if (wc->write)
-			btrfs_write_tree_block(eb);
-		if (wc->wait)
-			btrfs_wait_tree_block_writeback(eb);
 	}
 	return ret;
 }
-- 
2.33.0

