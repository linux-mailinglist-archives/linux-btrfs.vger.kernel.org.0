Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755F77AB04C
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 13:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbjIVLOF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 07:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbjIVLOC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 07:14:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B948AF
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 04:13:56 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D80D81FD8B;
        Fri, 22 Sep 2023 11:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695381234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m39QlaAOjYaCNz1dDNBkDIeq8ahd+PktZPUeALwBT/4=;
        b=Y5BEQ7DaqChhW5IAH/bo1LisKPM/j9NXoY5M1OdZVvbKjK11Rwoxi8YeuiWZjbCdhxUJJM
        S2v4xr4QsXQ/KbRR2Kr110mEuJPMQp0dBUvGNB4FTc2dFBctbKfoS7feWgkZaB7B4d5jJE
        Y8NFGeYk427GlS/0qfaJuQj7cyF6H6U=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id BE2FF2C142;
        Fri, 22 Sep 2023 11:13:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E6CF3DA832; Fri, 22 Sep 2023 13:07:20 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 4/8] btrfs: relocation: open code mapping_tree_init
Date:   Fri, 22 Sep 2023 13:07:20 +0200
Message-ID: <90521cf5613540330ffde6ec78dc0210aa05d146.1695380646.git.dsterba@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695380646.git.dsterba@suse.com>
References: <cover.1695380646.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There's only one user of mapping_tree_init, we don't need a helper for
the simple initialization.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/relocation.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 87ac8528032c..3e662cadecaf 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -183,13 +183,6 @@ static void mark_block_processed(struct reloc_control *rc,
 	node->processed = 1;
 }
 
-
-static void mapping_tree_init(struct mapping_tree *tree)
-{
-	tree->rb_root = RB_ROOT;
-	spin_lock_init(&tree->lock);
-}
-
 /*
  * walk up backref nodes until reach node presents tree root
  */
@@ -4024,7 +4017,8 @@ static struct reloc_control *alloc_reloc_control(struct btrfs_fs_info *fs_info)
 	INIT_LIST_HEAD(&rc->reloc_roots);
 	INIT_LIST_HEAD(&rc->dirty_subvol_roots);
 	btrfs_backref_init_cache(fs_info, &rc->backref_cache, 1);
-	mapping_tree_init(&rc->reloc_root_tree);
+	rc->reloc_root_tree.rb_root = RB_ROOT;
+	spin_lock_init(&rc->reloc_root_tree.lock);
 	extent_io_tree_init(fs_info, &rc->processed_blocks, IO_TREE_RELOC_BLOCKS);
 	return rc;
 }
-- 
2.41.0

