Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F2C27DE1E
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 03:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbgI3B5D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Sep 2020 21:57:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:50832 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729950AbgI3B5C (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Sep 2020 21:57:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601431021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NaisI4tRgIxExBLYX2BkuNqgYAVDdP62/iyDNZC8Z8Y=;
        b=a+QjQEasVXhXsVWN++UnGNUnIJeAbRwOdh6eevFozRA7XgDjtgVTWN+FhGHYR7hPYeKgOV
        IQrA38bVH6RxbyBaeFlcA66h5+u5TAZmWlzZ0N1Dz8uk4zDi5hP0wqhgzbzQ0i8mJXwrca
        IiAHB7pXqW58jaLq0KrZTxWgL9MdUyk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BD0A5AF99
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Sep 2020 01:57:01 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 37/49] btrfs: set btree inode track_uptodate for subpage support
Date:   Wed, 30 Sep 2020 09:55:27 +0800
Message-Id: <20200930015539.48867-38-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930015539.48867-1-wqu@suse.com>
References: <20200930015539.48867-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Let btree io tree to track EXTENT_UPTODATE bit, so that for subpage
metadata IO, we don't need to bother tracking the UPTODATE status
manually through bio submission/endio functions.

Currently only subpage metadata will cleanup the extra bits utizlied
(EXTENT_HAS_TREE_BLOCK, EXTENT_UPTODATE, EXTENT_LOCKED), while the
regular page size will only clean up EXTENT_LOCKED.

This still allows the regular page size case to avoid the extra delay in
extent io tree operations, but allows subpage case to be sector size
aligned.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index efbe12e4f952..97c44f518a49 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2244,7 +2244,14 @@ static void btrfs_init_btree_inode(struct btrfs_fs_info *fs_info)
 	RB_CLEAR_NODE(&BTRFS_I(inode)->rb_node);
 	extent_io_tree_init(fs_info, &BTRFS_I(inode)->io_tree,
 			    IO_TREE_BTREE_INODE_IO, inode);
-	BTRFS_I(inode)->io_tree.track_uptodate = false;
+	/*
+	 * For subpage size support, btree inode tracks EXTENT_UPTODATE for
+	 * its IO.
+	 */
+	if (btrfs_is_subpage(fs_info))
+		BTRFS_I(inode)->io_tree.track_uptodate = true;
+	else
+		BTRFS_I(inode)->io_tree.track_uptodate = false;
 	extent_map_tree_init(&BTRFS_I(inode)->extent_tree);
 
 	BTRFS_I(inode)->io_tree.ops = &btree_extent_io_ops;
-- 
2.28.0

