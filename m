Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C13797F23
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 01:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235927AbjIGXQP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Sep 2023 19:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234477AbjIGXQO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Sep 2023 19:16:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F075BD
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Sep 2023 16:16:10 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EFA46210DB;
        Thu,  7 Sep 2023 23:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1694128568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M2uJLWMvQj8z9vuOQANTqjOCZlPxeZkpjbUfKyP8o90=;
        b=q/sYxHuOYWqcjWhpRLrCozI32sAv4yJ463tB3k+TGwALeuAXpweEeDy4g/v0jgeEbXK/BA
        h1GobssUmZOi4koA3Ukx5Jo4VVt4U9fGWTCXCtfxSx0ww29WRyw42o8v9G+ZbYyAkkMR9l
        qGnt1ogtyX0Ht+QKJz/SeYYlYvgF9vo=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E37DB2C142;
        Thu,  7 Sep 2023 23:16:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 21CE8DA8C5; Fri,  8 Sep 2023 01:09:38 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 08/10] btrfs: reduce size and reorder compression members in struct btrfs_inode
Date:   Fri,  8 Sep 2023 01:09:38 +0200
Message-ID: <9c8300f8034d596a60307972b54390364fca1c73.1694126893.git.dsterba@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694126893.git.dsterba@suse.com>
References: <cover.1694126893.git.dsterba@suse.com>
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

Currently the compression type values are bounded and fit to an u8, we
can pack the btrfs_inode a bit by reordering them to the space created
by the location key. This reduces size from 1112 to 1104.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/btrfs_inode.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index b675dc09845d..2e1c0f68d704 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -81,6 +81,16 @@ struct btrfs_inode {
 	 */
 	struct btrfs_key location;
 
+	/*
+	 * Cached values of inode properties
+	 */
+	u8 prop_compress;		/* per-file compression algorithm */
+	/*
+	 * Force compression on the file using the defrag ioctl, could be
+	 * different from prop_compress and takes precedence if set
+	 */
+	u8 defrag_compress;
+
 	/*
 	 * Lock for counters and all fields used to determine if the inode is in
 	 * the log or not (last_trans, last_sub_trans, last_log_commit,
@@ -235,16 +245,6 @@ struct btrfs_inode {
 
 	struct btrfs_block_rsv block_rsv;
 
-	/*
-	 * Cached values of inode properties
-	 */
-	unsigned prop_compress;		/* per-file compression algorithm */
-	/*
-	 * Force compression on the file using the defrag ioctl, could be
-	 * different from prop_compress and takes precedence if set
-	 */
-	unsigned defrag_compress;
-
 	struct btrfs_delayed_node *delayed_node;
 
 	/* File creation time. */
-- 
2.41.0

