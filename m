Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC6221CCB8
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jul 2020 03:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbgGMBDk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 12 Jul 2020 21:03:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:53984 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbgGMBDk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 12 Jul 2020 21:03:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A5DDBAD4A
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jul 2020 01:03:40 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 4/4] btrfs: Add comments for btrfs_reserve_flush_enum
Date:   Mon, 13 Jul 2020 09:03:22 +0800
Message-Id: <20200713010322.18507-5-wqu@suse.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200713010322.18507-1-wqu@suse.com>
References: <20200713010322.18507-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This enum is the the interface exposed to developers.

Although we have a detailed comment explaining the whole idea of space
flushing at the head of space-info.c, the exposed enum interface doesn't
have any comment.

Some corner cases, like BTRFS_RESERVE_FLUSH_ALL and
BTRFS_RESERVE_FLUSH_ALL_STEAL can be interrupted by fatal signals, are
not explained at all.

So add some simple comments for these enums as a quick reference.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index c96c27f66999..9e5cb19aaf54 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2563,16 +2563,46 @@ int btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
 int btrfs_extent_readonly(struct btrfs_fs_info *fs_info, u64 bytenr);
 void btrfs_clear_space_info_full(struct btrfs_fs_info *info);
 
+/*
+ * Different levels for to flush space when doing reserve.
+ *
+ * The higher the level, the more methods we try to reclaim space.
+ */
 enum btrfs_reserve_flush_enum {
 	/* If we are in the transaction, we can't flush anything.*/
 	BTRFS_RESERVE_NO_FLUSH,
+
 	/*
-	 * Flushing delalloc may cause deadlock somewhere, in this
-	 * case, use FLUSH LIMIT
+	 * Flush space by:
+	 * - Running delayed inode items
+	 * - Allocating a new chunk
 	 */
 	BTRFS_RESERVE_FLUSH_LIMIT,
+
+	/*
+	 * Flushing space by:
+	 * - Running delayed inode items
+	 * - Running delayed refs
+	 * - Running delalloc and wait for ordered extents
+	 * - Allocating a new chunk
+	 */
 	BTRFS_RESERVE_FLUSH_EVICT,
+
+	/*
+	 * Flush space by above mentioned methods and:
+	 * - Running delayed iputs
+	 * - Commiting transaction
+	 *
+	 * Can be interruped by fatal signal.
+	 */
 	BTRFS_RESERVE_FLUSH_ALL,
+
+	/*
+	 * Pretty much the same as FLUSH_ALL, but can also steal space
+	 * from global rsv.
+	 *
+	 * Can be interruped by fatal signal.
+	 */
 	BTRFS_RESERVE_FLUSH_ALL_STEAL,
 };
 
-- 
2.27.0

