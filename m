Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64CC6294845
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 08:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440815AbgJUG1b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 02:27:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:44046 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436568AbgJUG1b (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 02:27:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603261650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NaisI4tRgIxExBLYX2BkuNqgYAVDdP62/iyDNZC8Z8Y=;
        b=G6ykUonDHyuc5Kx0IPaDewbiYzAXD6148vejd9Hm/sqJWN3UKauQdnthheacK93yeykSoe
        bEF7Tk8kmx5gdnjbB4swEXq6pDireEDvyMzYMf5Njn5uLoVVTQ2mX8b2nEM1GQnkRy+/Q6
        T/yuSpdqvfQz1ACuaE/lBTMRvJUeMSM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 088E7AC12
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 06:27:30 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 41/68] btrfs: set btree inode track_uptodate for subpage support
Date:   Wed, 21 Oct 2020 14:25:27 +0800
Message-Id: <20201021062554.68132-42-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021062554.68132-1-wqu@suse.com>
References: <20201021062554.68132-1-wqu@suse.com>
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

