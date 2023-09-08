Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1960D7986CE
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 14:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243190AbjIHMJi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 08:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243164AbjIHMJh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 08:09:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777AA1BC5
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 05:09:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D1DC433C7
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 12:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694174974;
        bh=0GMofqGbIZJ8DFuHdu7AWlye8IftUAHMKFaODoGNy/A=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ZP75v1cU/jKq9MdJ6TRonmHw4BsdM244maLjG98icZujP9Q8gyLv9JyYgFOrveTh3
         qgVbuc7YGXlu0kg74pvdeBokXOZRv/CY+pDDuEIe+CANixlrocWDna6IrfgW6IyPjC
         skzDrrvUPBUaR4vTIzcskuuNB3xeho7Iid6fvntHT6Arl4twxDWH1CKKmM5AJA0E4G
         XsbXw8XnUb5tYzsC4RJyFJi61JqOFcIU9fuYK54d3BVQVE/yZDDG9EN8PRobiazcKM
         fbi/6FuLV5xJ9aDuwp6q3ZFdTTeJY1ZVagC7VxYmNEl8K9uyD5W7/lltFa82TIdaAc
         DUOune7y9AN6w==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 07/21] btrfs: remove redundant BUG_ON() from __btrfs_inc_extent_ref()
Date:   Fri,  8 Sep 2023 13:09:09 +0100
Message-Id: <c547f96cd16df65de1aa5607ca06b007e65a7aff.1694174371.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694174371.git.fdmanana@suse.com>
References: <cover.1694174371.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

At __btrfs_inc_extent_ref() we are doing a BUG_ON() if we are dealing with
a tree block reference that has a reference count that is different from 1,
but we have already dealt with this case at run_delayed_tree_ref(), making
it useless. So remove the BUG_ON().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-tree.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 8fca9c2b8917..cf503f2972a1 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1514,15 +1514,14 @@ static int __btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
 	btrfs_release_path(path);
 
 	/* now insert the actual backref */
-	if (owner < BTRFS_FIRST_FREE_OBJECTID) {
-		BUG_ON(refs_to_add != 1);
+	if (owner < BTRFS_FIRST_FREE_OBJECTID)
 		ret = insert_tree_block_ref(trans, path, bytenr, parent,
 					    root_objectid);
-	} else {
+	else
 		ret = insert_extent_data_ref(trans, path, bytenr, parent,
 					     root_objectid, owner, offset,
 					     refs_to_add);
-	}
+
 	if (ret)
 		btrfs_abort_transaction(trans, ret);
 out:
-- 
2.40.1

