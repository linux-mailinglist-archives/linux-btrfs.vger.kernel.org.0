Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE5B596D76
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Aug 2022 13:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbiHQLXA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Aug 2022 07:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbiHQLW6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Aug 2022 07:22:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA86606A4
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 04:22:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B824614C7
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 11:22:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA33C433D6
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 11:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660735377;
        bh=mbx+WQp/WDRHPgNuv/DepEccXVahMV+YyevwAR9Pw6k=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=PjZIwyXcVCIA39yQs8Ysap15EDnmfATaY4AsoVdbkCOujJ9u5rkK9XUDrlyoxOSVg
         ehdhYCSxQqPe9JLJk1cIiKOfguZ6zBD8O0zFdD1uEJBqvaRyw4rDlJo1kMyikHMQwN
         smqnK6AZ6LucR2Sg6dcN1pdcpN5MtEJMtyGuVnEI0UI8IehlO+swEzxPhwqfHEIKEk
         WNrXVwGfuyvDUhsTdBCetr91FSPaSXNI4WMKBYyQK1TqYmX4NkCTNl3E0XIVPfEkXi
         1uA4b1K8Foy7n0v00c4LVfD1onpnt3qt32VYZfQs4xkL4umj8TcsDxHkMufXFFyUKD
         4n4YlfuCLBvDQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 03/15] btrfs: update stale comment for log_new_dir_dentries()
Date:   Wed, 17 Aug 2022 12:22:36 +0100
Message-Id: <0e76a896083520a5acb00a01f098d6d655ef0449.1660735024.git.fdmanana@suse.com>
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

