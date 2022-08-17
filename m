Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70044596D74
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Aug 2022 13:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235977AbiHQLXE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Aug 2022 07:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235937AbiHQLXD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Aug 2022 07:23:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDDC6DAD6
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 04:23:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41FE8B81D49
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 11:23:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64DE6C433B5
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 11:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660735379;
        bh=9ls91ugzqt+2lsQ6hmYR/x0CTNdK0bDW2ELEIvW/PD8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=BxeuvuSJy1uJldB9Kfo8FZL0IXecjJuOPDRcmfn6WTZUPwDBgKi3o99dPnlZ/f8aQ
         I94F37uLP7gi4PvMBoCqz/BqA70wQdS5kPkrc/+w2GADPkt1MZKZ7Ax9bFaPg0IPep
         CNWwujRYafhXNKvdAdifb+/ZTtDmek18G5XAFzfEYWe/VVGRiKkMbL4GHG8vORce78
         PM3j8CaJaFb1rHPh7t5+2x2byQ4HUeWAZi0bGNc2myfnK4CCZvo6zdcEdGLtdmMX9b
         /EFQeq1w6OrnKQ6o9w9fCXIsmQgxnnbE8qLO+lp5wfh3L2MI0M9yqeA1EUSqNhjzs3
         SlhLYRYQJArDg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 06/15] btrfs: remove root argument from btrfs_delayed_item_reserve_metadata()
Date:   Wed, 17 Aug 2022 12:22:39 +0100
Message-Id: <acd7124b046ac4c69bba6f9aeb848ceade7b6402.1660735025.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1660735024.git.fdmanana@suse.com>
References: <cover.1660735024.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The root argument of btrfs_delayed_item_reserve_metadata() is used only
to get the fs_info object, but we already have a transaction handle, which
we can use to get the fs_info. So remove the root argument.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-inode.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index e7f34871a132..a080e08bbb4d 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -520,12 +520,11 @@ static struct btrfs_delayed_item *__btrfs_next_delayed_item(
 }
 
 static int btrfs_delayed_item_reserve_metadata(struct btrfs_trans_handle *trans,
-					       struct btrfs_root *root,
 					       struct btrfs_delayed_item *item)
 {
 	struct btrfs_block_rsv *src_rsv;
 	struct btrfs_block_rsv *dst_rsv;
-	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct btrfs_fs_info *fs_info = trans->fs_info;
 	u64 num_bytes;
 	int ret;
 
@@ -1490,8 +1489,7 @@ int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans,
 	}
 
 	if (reserve_leaf_space) {
-		ret = btrfs_delayed_item_reserve_metadata(trans, dir->root,
-							  delayed_item);
+		ret = btrfs_delayed_item_reserve_metadata(trans, delayed_item);
 		/*
 		 * Space was reserved for a dir index item insertion when we
 		 * started the transaction, so getting a failure here should be
@@ -1614,7 +1612,7 @@ int btrfs_delete_delayed_dir_index(struct btrfs_trans_handle *trans,
 	item->key = item_key;
 	item->ins_or_del = BTRFS_DELAYED_DELETION_ITEM;
 
-	ret = btrfs_delayed_item_reserve_metadata(trans, dir->root, item);
+	ret = btrfs_delayed_item_reserve_metadata(trans, item);
 	/*
 	 * we have reserved enough space when we start a new transaction,
 	 * so reserving metadata failure is impossible.
-- 
2.35.1

