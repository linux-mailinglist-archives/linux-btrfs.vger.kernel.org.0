Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007447AB04E
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 13:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbjIVLN6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 07:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233536AbjIVLNz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 07:13:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50FCCA
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 04:13:49 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 698DD21A57;
        Fri, 22 Sep 2023 11:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695381228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vIDTMTZgmmJmyZ4LDSJWTZMzQXWdy96JATvFARgxPWw=;
        b=UnnBvLyzGyvDEWTmpyS5570CSeKaDtr0B2ITItfJB+3l+q3bSwrl3UfMJV7SaaKYl3R/82
        rctjwQRarLLC797QxmV8aSIw1pBkbsn27QOgqqB7WwbxldKfY5xtOLluTrLQJHDtZ0Pe9v
        cpgs1EpCdNNRorJlHBt+JgTvS3YJbEA=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 4D6062C142;
        Fri, 22 Sep 2023 11:13:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 72156DA832; Fri, 22 Sep 2023 13:07:14 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 1/8] btrfs: relocation: use more natural types for tree_block bitfields
Date:   Fri, 22 Sep 2023 13:07:14 +0200
Message-ID: <e62321f3079658ce3c5a278e48c84e5d66c306b3.1695380646.git.dsterba@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695380646.git.dsterba@suse.com>
References: <cover.1695380646.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We don't need to use bitfields for tree_block::level and
tree_block::key_ready, there's enough padding in the structure for
proper types.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/relocation.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 6e8e14d1aeaa..9ff3572a8451 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -111,8 +111,8 @@ struct tree_block {
 	}; /* Use rb_simple_node for search/insert */
 	u64 owner;
 	struct btrfs_key key;
-	unsigned int level:8;
-	unsigned int key_ready:1;
+	u8 level;
+	bool key_ready;
 };
 
 #define MAX_EXTENTS 128
@@ -2664,7 +2664,7 @@ static int get_tree_block_key(struct btrfs_fs_info *fs_info,
 	else
 		btrfs_node_key_to_cpu(eb, &block->key, 0);
 	free_extent_buffer(eb);
-	block->key_ready = 1;
+	block->key_ready = true;
 	return 0;
 }
 
@@ -3313,7 +3313,7 @@ static int add_tree_block(struct reloc_control *rc,
 	block->key.objectid = rc->extent_root->fs_info->nodesize;
 	block->key.offset = generation;
 	block->level = level;
-	block->key_ready = 0;
+	block->key_ready = false;
 	block->owner = owner;
 
 	rb_node = rb_simple_insert(blocks, block->bytenr, &block->rb_node);
-- 
2.41.0

