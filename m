Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EACA7AB04F
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 13:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbjIVLOG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 07:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbjIVLOE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 07:14:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53394AC
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 04:13:58 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0A8C221879;
        Fri, 22 Sep 2023 11:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695381237; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nrjIAhyiZPWvvzpDHy35UXS8dtVe+2Ej7K0N//nNpuI=;
        b=HImjCefhUGkz+VGx7qeqXTeLtZAQcH2FeEaoe8QFq4YONrsxhdTfkPpfQvmbH/kX4iefH3
        NWAqF9CsDkVCvmDBiG3Intq3c6eeJoZrNVfqF020WwsEQui4RAQSmvhFXcKFcXNN3LMF1z
        dPaFh8KknWxIiqxHPaWHooNwLsQiFTM=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E53942C142;
        Fri, 22 Sep 2023 11:13:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1BA46DA832; Fri, 22 Sep 2023 13:07:23 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 5/8] btrfs: switch btrfs_backref_cache::is_reloc to bool
Date:   Fri, 22 Sep 2023 13:07:23 +0200
Message-ID: <a6570ecf163983ecc3b057aab71dd3d76d8a5307.1695380646.git.dsterba@suse.com>
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

The btrfs_backref_cache::is_reloc is an indicator variable and should
use a bool type.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/backref.c    | 2 +-
 fs/btrfs/backref.h    | 4 ++--
 fs/btrfs/relocation.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 0cde873bdee2..0dc91bf654b5 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -3001,7 +3001,7 @@ int btrfs_backref_iter_next(struct btrfs_backref_iter *iter)
 }
 
 void btrfs_backref_init_cache(struct btrfs_fs_info *fs_info,
-			      struct btrfs_backref_cache *cache, int is_reloc)
+			      struct btrfs_backref_cache *cache, bool is_reloc)
 {
 	int i;
 
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 3b077d10bbc0..83a9a34e948e 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -440,11 +440,11 @@ struct btrfs_backref_cache {
 	 * Reloction backref cache require more info for reloc root compared
 	 * to generic backref cache.
 	 */
-	unsigned int is_reloc;
+	bool is_reloc;
 };
 
 void btrfs_backref_init_cache(struct btrfs_fs_info *fs_info,
-			      struct btrfs_backref_cache *cache, int is_reloc);
+			      struct btrfs_backref_cache *cache, bool is_reloc);
 struct btrfs_backref_node *btrfs_backref_alloc_node(
 		struct btrfs_backref_cache *cache, u64 bytenr, int level);
 struct btrfs_backref_edge *btrfs_backref_alloc_edge(
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 3e662cadecaf..75463377f418 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4016,7 +4016,7 @@ static struct reloc_control *alloc_reloc_control(struct btrfs_fs_info *fs_info)
 
 	INIT_LIST_HEAD(&rc->reloc_roots);
 	INIT_LIST_HEAD(&rc->dirty_subvol_roots);
-	btrfs_backref_init_cache(fs_info, &rc->backref_cache, 1);
+	btrfs_backref_init_cache(fs_info, &rc->backref_cache, true);
 	rc->reloc_root_tree.rb_root = RB_ROOT;
 	spin_lock_init(&rc->reloc_root_tree.lock);
 	extent_io_tree_init(fs_info, &rc->processed_blocks, IO_TREE_RELOC_BLOCKS);
-- 
2.41.0

