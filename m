Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD5C539395
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 May 2022 17:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345503AbiEaPG4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 May 2022 11:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345497AbiEaPGz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 May 2022 11:06:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84C3BCD
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 08:06:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62F9FB80CEF
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 15:06:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A288FC3411E
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 15:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654009612;
        bh=E4UUpWUM96I3D17MxIBsKhLymOrvFzmHvEpOd5VKtDU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=W+s/ubQbI/gl5RDsVfx+phvwXvzF0eX0UUNR9c0FEooTEVng810bnLY6G2NCo6Q/n
         HZ20f0aciug6O39jea73VD8gKn/KZ2fiBKaShCElVY72z5e7lT54/1Q3pe7wFCB5az
         Z7os+gc3rpEUDLYuMnKwEeA9BQAJw0yFPg3ciygap9vk5q+hc6Z0aYi4reIrWZ7DU+
         CspAHonxv624vjr4TIU99nhV1rAofD7BVsbMZuId1dpk6bKvJuHWmVXWZYi+Kcyvee
         vCnPlkyZUlIPhPIBfSZqo63BLlZUkpdbQB6mt2vCmVTPy7DDJG/i7pzY/u7xh51bHe
         0fDRrE9B5CJyw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 05/12] btrfs: deal with deletion errors when deleting delayed items
Date:   Tue, 31 May 2022 16:06:36 +0100
Message-Id: <765e2a5d2f1ae54767fd49fae2fcae2dd34b63ce.1654009356.git.fdmanana@suse.com>
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

Currently, btrfs_delete_delayed_items() ignores any errors returned from
btrfs_batch_delete_items(). This looks fishy but it's not a problem at
the moment because:

1) Two of the errors returned from btrfs_batch_delete_items() are for
   impossible cases, cases where a delayed item does not match any item
   in the leaf the path points to - btrfs_delete_delayed_items() always
   calls btrfs_batch_delete_items() with a path that points to a leaf
   that contains an item matching a delayed item;

2) btrfs_batch_delete_items() may return an error from btrfs_del_items(),
   in which case it does not release the delayed items of the batch.

   At the moment this is harmless because btrfs_del_items() actually is
   always able to delete items, even if it returns an error - when it
   returns an error it's because it ended up with a leaf mostly empty
   (less than 1/3 full) and failed to migrate items from that leaf into
   its neighbour leaves - this is not critical, as all the items were
   deleted, we just left the tree a bit unbalanced, but it's still a
   valid tree and causes no harm, and future operations on the tree will
   eventually balance it.

   So even if we get an error from btrfs_del_items(), the delayed items
   will not be released but the next time we run delayed items we will
   find out, at btrfs_delete_delayed_items(), that they are not present
   in the tree anymore and then release them.

This is all a bit subtle, and it's certainly prone to be a disaster in
case btrfs_del_items() changes one day and may return errors before being
able to delete all the requested items, in which case we could leave the
filesystem in an inconsistent state as we would commit a transaction
despite a failure from deleting items from the tree.

So make btrfs_delete_delayed_items() check for any erros from the call to
btrfs_batch_delete_items().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-inode.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index bb9955e74a51..3c6368c29bb9 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -889,7 +889,9 @@ static int btrfs_delete_delayed_items(struct btrfs_trans_handle *trans,
 			goto delete_fail;
 	}
 
-	btrfs_batch_delete_items(trans, root, path, curr);
+	ret = btrfs_batch_delete_items(trans, root, path, curr);
+	if (ret)
+		goto delete_fail;
 	btrfs_release_path(path);
 	mutex_unlock(&node->mutex);
 	goto do_again;
-- 
2.35.1

