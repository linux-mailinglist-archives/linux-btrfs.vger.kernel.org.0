Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE1159BDDB
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Aug 2022 12:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbiHVKwA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Aug 2022 06:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbiHVKvz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Aug 2022 06:51:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9042F659
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 03:51:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 535E160FFD
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 10:51:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CAC8C433D7
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 10:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661165513;
        bh=9ls91ugzqt+2lsQ6hmYR/x0CTNdK0bDW2ELEIvW/PD8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=K03LMJf32wK3rKU5UWXHTlPLoExLQMskdW0NxOGQzBN/iXjOrGKKGjTqjOOFX0fJm
         FVEzfdVitCOFfU855jq/ShASDWYZV6aMHTz3T5AeZNMGcOwGKreM7JLyjhR/CD7W6T
         smwd+ssP/CwIe4nTZ7xMcS8kBrUkr4LMpwAl8f/cbjGBgeZX+agnXaQV0j57wJdavf
         W9SicCSpUtBHGuU4oKmD01x8Z1Obk6aWy7huQDpJsihAh4KkRchv2HhPc1iAggjBm4
         lsyZT+iGFugAUbsu2+s3B+6YApxtfN2ulc+k3lomY+KCihtyVWIo9QBMzUDNyEmSZa
         rWI1hvns/mX9A==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 06/15] btrfs: remove root argument from btrfs_delayed_item_reserve_metadata()
Date:   Mon, 22 Aug 2022 11:51:35 +0100
Message-Id: <c0992fbd2a0d74e49087ffa1147967b8efa1f186.1661165149.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1661165149.git.fdmanana@suse.com>
References: <cover.1661165149.git.fdmanana@suse.com>
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

