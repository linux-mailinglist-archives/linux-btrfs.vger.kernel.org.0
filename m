Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC61718EA5
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jun 2023 00:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjEaWjV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 18:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjEaWjT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 18:39:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FA4B3;
        Wed, 31 May 2023 15:39:15 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id AC3132190C;
        Wed, 31 May 2023 22:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1685572753; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=WdJHBhhL3sF0CGSk4KOdtDV9lZJmzBUbfDHyrdHhRwA=;
        b=Cj2KHh1qc/iGwOozL6mxpPdwZRWuNpRtgpZpnEodSXSN71cZJsVadoQWvFfcc3Yk4stKSl
        b4Ja5BWzZhY5SKaBbForyQRgpksMiP++/7NCWT7+gmbqz8BlQG2mJo3vbfwo+DMGh4l/QW
        tCCdVAKGv8zf2sut8841XW+LeMqcEdM=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 97AB12C141;
        Wed, 31 May 2023 22:39:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1645DDA82D; Thu,  1 Jun 2023 00:33:03 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>, stable@vger.kernel.org
Subject: [PATCH] btrfs: add block-group tree to lockdep classes
Date:   Thu,  1 Jun 2023 00:33:01 +0200
Message-Id: <20230531223301.3522-1-dsterba@suse.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The block group tree was not present among the lockdep classes. We could
get potentially lockdep warnings but so far none has been seen, also
because block-group-tree is a relatively new feature.

CC: stable@vger.kernel.org # 6.1+
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/locking.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
index 3a496b0d3d2b..7979449a58d6 100644
--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -57,8 +57,8 @@
 
 static struct btrfs_lockdep_keyset {
 	u64			id;		/* root objectid */
-	/* Longest entry: btrfs-free-space-00 */
-	char			names[BTRFS_MAX_LEVEL][20];
+	/* Longest entry: btrfs-block-group-00 */
+	char			names[BTRFS_MAX_LEVEL][24];
 	struct lock_class_key	keys[BTRFS_MAX_LEVEL];
 } btrfs_lockdep_keysets[] = {
 	{ .id = BTRFS_ROOT_TREE_OBJECTID,	DEFINE_NAME("root")	},
@@ -72,6 +72,7 @@ static struct btrfs_lockdep_keyset {
 	{ .id = BTRFS_DATA_RELOC_TREE_OBJECTID,	DEFINE_NAME("dreloc")	},
 	{ .id = BTRFS_UUID_TREE_OBJECTID,	DEFINE_NAME("uuid")	},
 	{ .id = BTRFS_FREE_SPACE_TREE_OBJECTID,	DEFINE_NAME("free-space") },
+	{ .id = BTRFS_BLOCK_GROUP_TREE_OBJECTID, DEFINE_NAME("block-group") },
 	{ .id = 0,				DEFINE_NAME("tree")	},
 };
 
-- 
2.40.0

