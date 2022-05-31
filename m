Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA66539399
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 May 2022 17:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345514AbiEaPG7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 May 2022 11:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345508AbiEaPG5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 May 2022 11:06:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0814FBCD
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 08:06:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98BF361344
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 15:06:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8069AC34114
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 15:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654009615;
        bh=rblnR3HjoTWZF3vsKL49N73woY/yIzlf9aT/ZQ4WT8I=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=H5cO9nN5jk7VMtb/3qaCi7XepCeZAgsp/+4Xm0qKE+RjMTUqD9RMtZm19GhGiCBEA
         d5EeOfNzKjsvUkP27Xi1ISC2rpSehGOY8LoehAjYcEF4FndMbPl7ba1NPiDKH1BaP4
         Ws+CsrN5DQInsNfPtHAhS8aTZ+sGiq2t5+Zq7a1oJo+zrZK7za+oU7xHg4RlEPDzXd
         j9Mb1WpOJu5qdJDWCQx6vkuzx/3yv77SBYEk7V3lPA7FNwFifwffdsZVvUuOSw/bKm
         2xq1uCuO3LSm2bxc7vMgsGc/u5LvZUIE01SR4UVNxZwODX4c5tIN2grSZXBM/sQ0Ag
         v3FFzfABq9WVg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 08/12] btrfs: assert that delayed item is a dir index item when adding it
Date:   Tue, 31 May 2022 16:06:39 +0100
Message-Id: <eb5eea6bfa2e5c7bc3440b0637b164dda4d5beca.1654009356.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1654009356.git.fdmanana@suse.com>
References: <cover.1654009356.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

All delayed items are for dir index items, we don't support any other item
types at the moment. So simplify __btrfs_add_delayed_item() and add an
assertion for checking the item's key type. This also allows the next
change to be simpler and avoid to check key types. In case we add support
for different item types in the future, then we'll hit the assertion
during development and be able to adjust any code that is assuming delayed
items are always associated to dir index items.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-inode.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 74c806d3ab2a..addffd7719fc 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -431,10 +431,12 @@ static int __btrfs_add_delayed_item(struct btrfs_delayed_node *delayed_node,
 	ins->delayed_node = delayed_node;
 	ins->ins_or_del = action;
 
-	if (ins->key.type == BTRFS_DIR_INDEX_KEY &&
-	    action == BTRFS_DELAYED_INSERTION_ITEM &&
+	/* Delayed items are always for dir index items. */
+	ASSERT(ins->key.type == BTRFS_DIR_INDEX_KEY);
+
+	if (action == BTRFS_DELAYED_INSERTION_ITEM &&
 	    ins->key.offset >= delayed_node->index_cnt)
-			delayed_node->index_cnt = ins->key.offset + 1;
+		delayed_node->index_cnt = ins->key.offset + 1;
 
 	delayed_node->count++;
 	atomic_inc(&delayed_node->root->fs_info->delayed_root->items);
-- 
2.35.1

