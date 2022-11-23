Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9827B636D47
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Nov 2022 23:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiKWWi0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Nov 2022 17:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiKWWiB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Nov 2022 17:38:01 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACEE101E8
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Nov 2022 14:37:59 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id d8so13461641qki.13
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Nov 2022 14:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+a9t2rbSZiRUOuExHq+1TWeATRk9YCY5aTuvq80WToE=;
        b=GYeZGT7SkEHJ4gIOmvuefVweDT/T1Agc2IEQZrnasTwQgrmN88k89W4wGz5n2KbMgM
         urzihLU26DkRtdAfIAQ3YEE71JCnAqH0+gsCMtl4xXNMtJK2uSrADoH2u3dCenftdpaY
         g24sceNXxDKtNzdDJZhUqmu91uqoLVfKZfRQTKtkvtn6b9n4hiZ05Vxc/MylRytF0AmN
         RwcTQ0IvPpYvSfKX7yon5AdU3nb2xXpwBNkpLkdsWgG4Z+W1H4djYhFn0moiDxjiDTfb
         DTMMfIFSPzULwzZcILLGT0RwNT74JoOb9O262iHDtttNQV8DSjjKIzC9M1EQAd+PneO0
         e9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+a9t2rbSZiRUOuExHq+1TWeATRk9YCY5aTuvq80WToE=;
        b=MBKflWOMDVTZ6jVd69/89fQg2sBEZvwU1LUm9QpnTrFPh8gR2Z3e/KlWLWKRDJApXb
         39+FR4VuOV0Of2qq/SCclPH9utTKw89q4yj3yFXy5YrHNG/fIUEpCeb+8GVVCCu1kdRq
         tzPfdf3CjRDWY0hfcfqaMnc1QbqcQoxzRZzGIjLfKBnuqEfHDtpcxVg0cZTAV0GoKrZF
         LNawajiA68+newFT2GUfIlT0cd7x1hzEeAxMaLjhNU7sAySYzvsruRpePEUJ/oHVxVvP
         8zHX28jD/LSNS7ZxCN0wXYLC+a3FClMHz23Audo72RkTJhwZr6Pkt0rq1Y/Nd+eA86Li
         Elmw==
X-Gm-Message-State: ANoB5pkLV/MjqQPIHlbS2ox7LnKM7pIA7517i8pBBEZ7jkGy53ZxWi3O
        MVVfQidP7BOdYpHYBgBlmenPAlDbgzJEYw==
X-Google-Smtp-Source: AA0mqf76XJ7c2769E+wiKeVP6sF6xDqXw2FppwpWT+obYQ43sG1d0PI1xypqn638Vg0QMckVuhwekQ==
X-Received: by 2002:a05:620a:c95:b0:6fa:91f9:c84d with SMTP id q21-20020a05620a0c9500b006fa91f9c84dmr26672039qki.724.1669243078974;
        Wed, 23 Nov 2022 14:37:58 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id d17-20020a05620a241100b006f87d28ea3asm12994611qkn.54.2022.11.23.14.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 14:37:58 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 15/29] btrfs-progs: move dirty eb tracking to it's own io_tree
Date:   Wed, 23 Nov 2022 17:37:23 -0500
Message-Id: <66d6451a0c3d62cecfd2bcfc70c4b4c7f990ccc1.1669242804.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1669242804.git.josef@toxicpanda.com>
References: <cover.1669242804.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs-progs has a cache tree embedded in the extent_io_tree in order to
track extent buffers.  We use the extent_io_tree part to track dirty,
and the cache tree to keep the extent buffers in.  When we sync
extent-io-tree.[ch] we'll lose this ability, so separate out the dirty
tracking into its own extent_io_tree.  Subsequent patches will adjust
the extent buffer lookup so it doesn't use the custom extent_io_tree
thing.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/ctree.h       | 1 +
 kernel-shared/disk-io.c     | 2 ++
 kernel-shared/extent_io.c   | 4 ++--
 kernel-shared/transaction.c | 2 +-
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 3f674484..b9a58325 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -1218,6 +1218,7 @@ struct btrfs_fs_info {
 	struct btrfs_root *log_root_tree;
 
 	struct extent_io_tree extent_cache;
+	struct extent_io_tree dirty_buffers;
 	struct extent_io_tree free_space_cache;
 	struct extent_io_tree pinned_extents;
 	struct extent_io_tree extent_ins;
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index ad4d0f4c..382d15f5 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -867,6 +867,7 @@ struct btrfs_fs_info *btrfs_new_fs_info(int writable, u64 sb_bytenr)
 		goto free_all;
 
 	extent_io_tree_init(&fs_info->extent_cache);
+	extent_io_tree_init(&fs_info->dirty_buffers);
 	extent_io_tree_init(&fs_info->free_space_cache);
 	extent_io_tree_init(&fs_info->pinned_extents);
 	extent_io_tree_init(&fs_info->extent_ins);
@@ -1350,6 +1351,7 @@ void btrfs_cleanup_all_caches(struct btrfs_fs_info *fs_info)
 		free_extent_buffer(eb);
 	}
 	free_mapping_cache_tree(&fs_info->mapping_tree.cache_tree);
+	extent_io_tree_cleanup(&fs_info->dirty_buffers);
 	extent_io_tree_cleanup(&fs_info->extent_cache);
 	extent_io_tree_cleanup(&fs_info->free_space_cache);
 	extent_io_tree_cleanup(&fs_info->pinned_extents);
diff --git a/kernel-shared/extent_io.c b/kernel-shared/extent_io.c
index bdfb2de6..4b6e0bee 100644
--- a/kernel-shared/extent_io.c
+++ b/kernel-shared/extent_io.c
@@ -1042,7 +1042,7 @@ out:
 
 int set_extent_buffer_dirty(struct extent_buffer *eb)
 {
-	struct extent_io_tree *tree = &eb->fs_info->extent_cache;
+	struct extent_io_tree *tree = &eb->fs_info->dirty_buffers;
 	if (!(eb->flags & EXTENT_DIRTY)) {
 		eb->flags |= EXTENT_DIRTY;
 		set_extent_dirty(tree, eb->start, eb->start + eb->len - 1);
@@ -1053,7 +1053,7 @@ int set_extent_buffer_dirty(struct extent_buffer *eb)
 
 int clear_extent_buffer_dirty(struct extent_buffer *eb)
 {
-	struct extent_io_tree *tree = &eb->fs_info->extent_cache;
+	struct extent_io_tree *tree = &eb->fs_info->dirty_buffers;
 	if (eb->flags & EXTENT_DIRTY) {
 		eb->flags &= ~EXTENT_DIRTY;
 		clear_extent_dirty(tree, eb->start, eb->start + eb->len - 1);
diff --git a/kernel-shared/transaction.c b/kernel-shared/transaction.c
index c50abfca..c1364d69 100644
--- a/kernel-shared/transaction.c
+++ b/kernel-shared/transaction.c
@@ -136,7 +136,7 @@ int __commit_transaction(struct btrfs_trans_handle *trans,
 	u64 end;
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct extent_buffer *eb;
-	struct extent_io_tree *tree = &fs_info->extent_cache;
+	struct extent_io_tree *tree = &fs_info->dirty_buffers;
 	int ret;
 
 	while(1) {
-- 
2.26.3

