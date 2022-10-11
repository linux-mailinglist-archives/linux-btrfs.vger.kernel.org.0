Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62385FB2C2
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Oct 2022 14:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiJKM7F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Oct 2022 08:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiJKM7C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Oct 2022 08:59:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE1C92584
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 05:59:00 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9AD23204E3;
        Tue, 11 Oct 2022 12:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665493138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hvKepMH2wtChA4Vwgtw4p/awMpAN97IyDkcecfBSHag=;
        b=o7jA8O9MmYMjqSzMejGyU1dnoQSW00bkI2OrSsWyl8c1APVlAuM9pLMeTeeY+17YosBZjw
        UVthAoK6yAyYnyMvEga1Z07BCd9qaU//3CKJyKyA8P/QmrGvy2rRZngIhWz0zO/NhewxeG
        zHZCUd1hGNmaE9exasT/qZKt/K5wLxY=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 9309E2C141;
        Tue, 11 Oct 2022 12:58:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 50883DA79D; Tue, 11 Oct 2022 14:58:54 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 4/6] btrfs: convert EXTENT_* bits to enums
Date:   Tue, 11 Oct 2022 14:58:54 +0200
Message-Id: <fb4cfe5e69a9c5df6a699bf99d70cd2e90b6af34.1665492943.git.dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1665492943.git.dsterba@suse.com>
References: <cover.1665492943.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent-io-tree.h | 71 +++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 33 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index c71aa29f719d..673637ed2fa9 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -3,43 +3,48 @@
 #ifndef BTRFS_EXTENT_IO_TREE_H
 #define BTRFS_EXTENT_IO_TREE_H
 
+#include "misc.h"
+
 struct extent_changeset;
 struct io_failure_record;
 
 /* Bits for the extent state */
-#define EXTENT_DIRTY		(1U << 0)
-#define EXTENT_UPTODATE		(1U << 1)
-#define EXTENT_LOCKED		(1U << 2)
-#define EXTENT_NEW		(1U << 3)
-#define EXTENT_DELALLOC		(1U << 4)
-#define EXTENT_DEFRAG		(1U << 5)
-#define EXTENT_BOUNDARY		(1U << 6)
-#define EXTENT_NODATASUM	(1U << 7)
-#define EXTENT_CLEAR_META_RESV	(1U << 8)
-#define EXTENT_NEED_WAIT	(1U << 9)
-#define EXTENT_NORESERVE	(1U << 11)
-#define EXTENT_QGROUP_RESERVED	(1U << 12)
-#define EXTENT_CLEAR_DATA_RESV	(1U << 13)
-/*
- * Must be cleared only during ordered extent completion or on error paths if we
- * did not manage to submit bios and create the ordered extents for the range.
- * Should not be cleared during page release and page invalidation (if there is
- * an ordered extent in flight), that is left for the ordered extent completion.
- */
-#define EXTENT_DELALLOC_NEW	(1U << 14)
-/*
- * When an ordered extent successfully completes for a region marked as a new
- * delalloc range, use this flag when clearing a new delalloc range to indicate
- * that the VFS' inode number of bytes should be incremented and the inode's new
- * delalloc bytes decremented, in an atomic way to prevent races with stat(2).
- */
-#define EXTENT_ADD_INODE_BYTES  (1U << 15)
-
-/*
- * Set during truncate when we're clearing an entire range and we just want the
- * extent states to go away.
- */
-#define EXTENT_CLEAR_ALL_BITS	(1U << 16)
+enum {
+	ENUM_BIT(EXTENT_DIRTY),
+	ENUM_BIT(EXTENT_UPTODATE),
+	ENUM_BIT(EXTENT_LOCKED),
+	ENUM_BIT(EXTENT_NEW),
+	ENUM_BIT(EXTENT_DELALLOC),
+	ENUM_BIT(EXTENT_DEFRAG),
+	ENUM_BIT(EXTENT_BOUNDARY),
+	ENUM_BIT(EXTENT_NODATASUM),
+	ENUM_BIT(EXTENT_CLEAR_META_RESV),
+	ENUM_BIT(EXTENT_NEED_WAIT),
+	ENUM_BIT(EXTENT_NORESERVE),
+	ENUM_BIT(EXTENT_QGROUP_RESERVED),
+	ENUM_BIT(EXTENT_CLEAR_DATA_RESV),
+	/*
+	 * Must be cleared only during ordered extent completion or on error
+	 * paths if we did not manage to submit bios and create the ordered
+	 * extents for the range.  Should not be cleared during page release
+	 * and page invalidation (if there is an ordered extent in flight),
+	 * that is left for the ordered extent completion.
+	 */
+	ENUM_BIT(EXTENT_DELALLOC_NEW),
+	/*
+	 * When an ordered extent successfully completes for a region marked as
+	 * a new delalloc range, use this flag when clearing a new delalloc
+	 * range to indicate that the VFS' inode number of bytes should be
+	 * incremented and the inode's new delalloc bytes decremented, in an
+	 * atomic way to prevent races with stat(2).
+	 */
+	ENUM_BIT(EXTENT_ADD_INODE_BYTES),
+	/*
+	 * Set during truncate when we're clearing an entire range and we just
+	 * want the extent states to go away.
+	 */
+	ENUM_BIT(EXTENT_CLEAR_ALL_BITS),
+};
 
 #define EXTENT_DO_ACCOUNTING    (EXTENT_CLEAR_META_RESV | \
 				 EXTENT_CLEAR_DATA_RESV)
-- 
2.37.3

