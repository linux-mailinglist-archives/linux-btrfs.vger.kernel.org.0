Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613D159BDDF
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Aug 2022 12:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbiHVKvv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Aug 2022 06:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233679AbiHVKvu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Aug 2022 06:51:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4A72F659
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 03:51:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A76B860FDE
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 10:51:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F6CC433C1
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 10:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661165509;
        bh=j/ODHUZcA8OtCTa/SH4CvYiotd90a7Eerw3O0tw+FbI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=cz2+dd8bzPxBh5PcKE8q4kPLq0rKSJ+hZFGKSATSxKJdp/yc4qj8AZNaSve/inFzw
         +W8hbOZY9iZyXYlWBFI5B3QM1Xemx5NR1EW7yXxskXuNazmps0pz1py7xCGrH3oTEB
         QeIM8BBkL/5luXjENCCvNXcuk0Oxt+4xGk0on7NvMaJzIXOt6E+9NdokBE0ATUZnH0
         s5GJ6Pt5MiI0E60himN5TC+Or4sl5p8iQzF2D4RZGMUYM8Io145NjOuTpwtahxMy0Z
         cz015E6aP5fISXzvGr1RjdotIV+0R5JdWaepkcFkFFCUZ3T+qdLmPFrIa1UiYhwQUF
         rZaANIwOIKkoA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 01/15] btrfs: don't drop dir index range items when logging a directory
Date:   Mon, 22 Aug 2022 11:51:30 +0100
Message-Id: <be82faa3791cc86405485f7cd6df4e626aabd05d.1661165149.git.fdmanana@suse.com>
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

When logging a directory that was previously logged in the current
transaction, we drop all the range items (BTRFS_DIR_LOG_INDEX_KEY key
type). This is because we will process all leaves in the subvolume's tree
that were changed in the current transaction and then add range items for
covering new dir index items and deleted dir index items, which could
cover now a larger range than before.

We used to fail if we tried to insert a range item key that already
exists, so we dropped all range items to avoid failing. However nowadays,
since commit 750ee454908e90 ("btrfs: fix assertion failure when logging
directory key range item"), we simply update any range item that already
exists, increasing its range's last dir index if needed. Since the range
covered by a range item can never decrease, due to the fact that dir index
values come from a monotonically increasing counter and are never reused,
we can stop dropping all range items before we start logging a directory.
By not dropping the items we can avoid having occasional tree rebalance
operations.

This will also be needed for an incoming change where we start logging
delayed items directly, without flushing them first.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 4d2d19fea112..cffd15e23614 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -5716,14 +5716,10 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 	 * copies of everything.
 	 */
 	if (S_ISDIR(inode->vfs_inode.i_mode)) {
-		int max_key_type = BTRFS_DIR_LOG_INDEX_KEY;
-
 		clear_bit(BTRFS_INODE_COPY_EVERYTHING, &inode->runtime_flags);
-		if (inode_only == LOG_INODE_EXISTS)
-			max_key_type = BTRFS_XATTR_ITEM_KEY;
 		if (ctx->logged_before)
 			ret = drop_inode_items(trans, log, path, inode,
-					       max_key_type);
+					       BTRFS_XATTR_ITEM_KEY);
 	} else {
 		if (inode_only == LOG_INODE_EXISTS && ctx->logged_before) {
 			/*
-- 
2.35.1

