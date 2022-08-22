Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474C159BF0B
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Aug 2022 13:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234336AbiHVLyX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Aug 2022 07:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234204AbiHVLyK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Aug 2022 07:54:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12AE37F94
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 04:53:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD697B81134
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 11:53:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C477C433B5
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 11:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661169231;
        bh=sYMgyG5cnmto6HDXA8qk3LKkoWCdWyuh1tgaxI0AZLk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=f51AtSlvko+K/GH+wjTCn6rnMvs9ZNdnayRaVTzcBpkyQidphOnBjaVk1LkIbFNXA
         eBqA8rVZ3OU/1ahAQBKICwSGJ1yK4eXjoR6pSw7u78SCs3J0niZD5XCSx5CebLSKHo
         hDVWXAj0oGvwIBtpnHxjCz0mZQjB1PASSj7iDSpn4rNzsNskM5zODom78b0zCkqJr3
         yz/+CXSjt6Z/ZnyD2Nmp+v+zYrN3lMlUNO0w4bSjNnEW40j0nbkcLTmsFwMY09nTcq
         PvhTgcIM3uud4VOZ/TTeBcbGKvNCXU2UJG6S068Fe5xy89K9gE5IiNMcQFPMnoqzyQ
         GtKHY89FLNvdA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: fix silent failure when deleting root reference
Date:   Mon, 22 Aug 2022 12:53:46 +0100
Message-Id: <68e07ceeb473de5523baa079d0653c0087c221ac.1661168931.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1661168931.git.fdmanana@suse.com>
References: <cover.1661168931.git.fdmanana@suse.com>
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

At btrfs_del_root_ref(), if btrfs_search_slot() returns an error, we end
up returning from the function with a value of 0 (success). This happens
because the function returns the value stored in the variable 'err', which
is 0, while the error value we got from btrfs_search_slot() is stored in
the 'ret' variable.

So fix it by setting 'err' with the error value.

Fixes: 8289ed9f93bef2 ("btrfs: replace the BUG_ON in btrfs_del_root_ref with proper error handling")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/root-tree.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index a64b26b16904..d647cb2938c0 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -349,9 +349,10 @@ int btrfs_del_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
 	key.offset = ref_id;
 again:
 	ret = btrfs_search_slot(trans, tree_root, &key, path, -1, 1);
-	if (ret < 0)
+	if (ret < 0) {
+		err = ret;
 		goto out;
-	if (ret == 0) {
+	} else if (ret == 0) {
 		leaf = path->nodes[0];
 		ref = btrfs_item_ptr(leaf, path->slots[0],
 				     struct btrfs_root_ref);
-- 
2.35.1

