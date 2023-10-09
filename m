Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6225F7BDA95
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Oct 2023 14:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346354AbjJIMBu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Oct 2023 08:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346375AbjJIMBt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Oct 2023 08:01:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81F4AB
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Oct 2023 05:01:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE802C433C8
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Oct 2023 12:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696852907;
        bh=4rqsX5ysuhcxzl1y0PIp0OABxFhqTf/yC9mFfcJcnQ0=;
        h=From:To:Subject:Date:From;
        b=Jen2sbofux6vNucf57+5zXRAPACettKcm5Yp5Xo1Pki5WVutabNrZy4bDw9/dcGRN
         EClrvLNVQyZOKaVDyGZMbLVn4GMXSqlFcUcKab/CSpdNEv3AJa9S/qNcExU+AbbkqB
         DIDfka6xxOValR/YwAMPDW9jjRCiGBjob+3uDBuHenUbPscKEcJD8lMiJ64si93Wqc
         agVAAkA3qHJimX1KRbPYKqEaZ2wRHI+0iN7GflDGA9hzKH89uCJy8WUrpqWD7/VB9A
         l3/fORWwltz4aqj7f4SaazJuZHFvrOmCx5n3PuvjMFb0Zffz1BVqaUClLdFOCIlBta
         aOgsFgecNGl3g==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove redundant log root tree index assignment during log sync
Date:   Mon,  9 Oct 2023 13:01:43 +0100
Message-Id: <92f3ac5682d6582c04cfa8ecd5a79eafa774c253.1696852669.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
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

During log syncing, when we start updating the log root tree we compute
an index value, stored in variable 'index2', once we lock the log root
tree's mutex. This value depends on the log root's log_transid. And
shortly after we compute again the same value for 'index2' - the value
is exactly the same since we haven't released the mutex and therefore
the log_transid of the log root is the same as before.

This second 'index2' computation became pointless after commit
a93e01682e28 ("btrfs: remove no longer needed use of log_writers for the
log root tree"). So remove it.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 8b3893c01734..6c7e7e723e3a 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3016,7 +3016,6 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
 		goto out;
 	}
 
-	index2 = root_log_ctx.log_transid % 2;
 	if (atomic_read(&log_root_tree->log_commit[index2])) {
 		blk_finish_plug(&plug);
 		ret = btrfs_wait_tree_log_extents(log, mark);
-- 
2.40.1

