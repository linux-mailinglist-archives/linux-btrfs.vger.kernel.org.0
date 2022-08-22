Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB6B59BDE4
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Aug 2022 12:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbiHVKv5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Aug 2022 06:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233679AbiHVKvw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Aug 2022 06:51:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD8C2F671
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 03:51:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A1B960FDE
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 10:51:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ED73C433D6
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 10:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661165510;
        bh=mbx+WQp/WDRHPgNuv/DepEccXVahMV+YyevwAR9Pw6k=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=RFiYsQSnheOZRtbFui8FprLExFCyFcjFktFKIvKjgGAesEYkBewa9ly0vAvUcd7V0
         hi/kPDdjAbOd7bzyb86VEdrKu+OK7ZU+s+4RNMByz1brVeZDQ//sB455lzZ21mZzqI
         m2G+zoAjD1CMMiwYhe6Gr3WtrOcdTTpLyI0Y9bL6Zyn+VSab0Kg/PxX9Nf47+SQAY4
         8A1n9nOfq4/Mz8RUOu3b05hDqlaY8KrlIdbDh1y0khhD18kXTBNFB0n35H9iB/+UrG
         6zJHYdeel/sbFgNpoDcGyQFdmEcrk3IcFr3zL/0b3AWjNZsNglTJEcgCEQEsqFap2/
         Q14+OW054KNnQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 03/15] btrfs: update stale comment for log_new_dir_dentries()
Date:   Mon, 22 Aug 2022 11:51:32 +0100
Message-Id: <c6d19e12d63731ab5772f26a5c68b7796c3ff331.1661165149.git.fdmanana@suse.com>
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

The comment refers to the function log_dir_items() in order to check why
the inodes of new directory entries need to be logged, but the relevant
comments are no longer at log_dir_items(), they were moved to the function
process_dir_items_leaf() in commit eb10d85ee77f09 ("btrfs: factor out the
copying loop of dir items from log_dir_items()"). So update it with the
current function name.

Also remove references with i_mutex to "VFS lock", since the inode lock
is no longer a mutex since 2016 (it's now a rw semaphore).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 56fbd3b9f642..9625707bfa8a 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -5933,12 +5933,12 @@ struct btrfs_dir_list {
 };
 
 /*
- * Log the inodes of the new dentries of a directory. See log_dir_items() for
- * details about the why it is needed.
+ * Log the inodes of the new dentries of a directory.
+ * See process_dir_items_leaf() for details about why it is needed.
  * This is a recursive operation - if an existing dentry corresponds to a
  * directory, that directory's new entries are logged too (same behaviour as
  * ext3/4, xfs, f2fs, reiserfs, nilfs2). Note that when logging the inodes
- * the dentries point to we do not lock their i_mutex, otherwise lockdep
+ * the dentries point to we do not acquire their VFS lock, otherwise lockdep
  * complains about the following circular lock dependency / possible deadlock:
  *
  *        CPU0                                        CPU1
@@ -5950,7 +5950,7 @@ struct btrfs_dir_list {
  *
  * Where sb_internal is the lock (a counter that works as a lock) acquired by
  * sb_start_intwrite() in btrfs_start_transaction().
- * Not locking i_mutex of the inodes is still safe because:
+ * Not acquiring the VFS lock of the inodes is still safe because:
  *
  * 1) For regular files we log with a mode of LOG_INODE_EXISTS. It's possible
  *    that while logging the inode new references (names) are added or removed
-- 
2.35.1

