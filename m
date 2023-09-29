Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398E87B3A50
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Sep 2023 20:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbjI2S7S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Sep 2023 14:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233058AbjI2S7R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Sep 2023 14:59:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7731AB
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Sep 2023 11:59:13 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5B8B7218E8;
        Fri, 29 Sep 2023 18:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1696013952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ECpnbrVZwPb5L+tBn1nQMfM8o9AKQbrknpcMoU2gemk=;
        b=WgsoN4IvqRvT1qqlu2YixwN0N4UNsSmQgGRaOs+fCDT990i/9W9QGgJs9Hyb4in45r01f5
        V/SI9w4YgCVQ6kHU5LXR/R+j2zH3vzfnqLC6KT3RNbP+g5fMsunXLIPiXwtUJI8+AaOqJn
        Slw1DNrcTeIRHvlM06I6YFgMP/pX+Ow=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 3BCDB2C142;
        Fri, 29 Sep 2023 18:59:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1D87BDA832; Fri, 29 Sep 2023 20:52:34 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 2/2] btrfs: reorder btrfs_inode to fill gaps
Date:   Fri, 29 Sep 2023 20:52:34 +0200
Message-ID: <b42f735ed04dfda999ff746d9f92b1b447c46199.1696012551.git.dsterba@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1696012550.git.dsterba@suse.com>
References: <cover.1696012550.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Previous commit created a hole in struct btrfs_inode, we can move
outstanding_extents there. This reduces size by 8 bytes from 1120 to
1112 on a release config.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/btrfs_inode.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 3a01443a9fe0..81bf514d988f 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -113,6 +113,14 @@ struct btrfs_inode {
 	/* held while logging the inode in tree-log.c */
 	struct mutex log_mutex;
 
+	/*
+	 * Counters to keep track of the number of extent item's we may use due
+	 * to delalloc and such.  outstanding_extents is the number of extent
+	 * items we think we'll end up using, and reserved_extents is the number
+	 * of extent items we've reserved metadata for.
+	 */
+	unsigned outstanding_extents;
+
 	/* used to order data wrt metadata */
 	spinlock_t ordered_tree_lock;
 	struct rb_root ordered_tree;
@@ -236,14 +244,6 @@ struct btrfs_inode {
 	/* Read-only compatibility flags, upper half of inode_item::flags */
 	u32 ro_flags;
 
-	/*
-	 * Counters to keep track of the number of extent item's we may use due
-	 * to delalloc and such.  outstanding_extents is the number of extent
-	 * items we think we'll end up using, and reserved_extents is the number
-	 * of extent items we've reserved metadata for.
-	 */
-	unsigned outstanding_extents;
-
 	struct btrfs_block_rsv block_rsv;
 
 	struct btrfs_delayed_node *delayed_node;
-- 
2.41.0

