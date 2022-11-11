Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2698B6259CF
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Nov 2022 12:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbiKKLuq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Nov 2022 06:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233378AbiKKLup (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Nov 2022 06:50:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415022657C
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 03:50:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ECC27B82510
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 11:50:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C3B1C433D6
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 11:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668167441;
        bh=YJ4AYQQylpYc/jA4Wbp/NIRUWPIzjgYpsif7MDR53Jc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=an/PVE/ZlxGc40towd7Vkm7FwW4ehW3jgzAm1dZL7uKHWFOwVMFYYcYm2DEX13Sbz
         dWJzZPmKY7lrH16inDsAwuCHXM/iwlRK85is9lhTRvPKctKEbKbCcrITECDArimA0n
         /yQoGhELmHWcSkc/8WQVqFI/YBi7ZtpYcmtIskyZfnRUwyDHX1+QQk3MXfwVyES32D
         S26l14Rsp0FJTgp120Qexrmo+/YGJx0ReZDk5uaIZBqbVMC3FjsO0PKFcWOk8pg077
         6dpIwmEjAJVqisnXg/M9G+PrbfNht8smmaDqdqrzVzsE6OL7NIlj73SPMWq4DLVSpW
         Wqrl3TjSIFVcQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/9] btrfs: skip unnecessary delalloc searches during lseek/fiemap
Date:   Fri, 11 Nov 2022 11:50:29 +0000
Message-Id: <6c37d5df98ea62a42aed127822c760053a6583dc.1668166764.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1668166764.git.fdmanana@suse.com>
References: <cover.1668166764.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

During lseek (SEEK_HOLE/DATA) and fiemap, when processing a file range
that corresponds to a hole or a prealloc extent, if we find that there is
no delalloc marked in the inode's io_tree but there is delalloc due to
an extent map in the io tree, then on the next iteration that calls
find_delalloc_subrange() we can skip searching the io tree again, since
on the first call we had no delalloc in the io tree for the whole range.

This change is part of a patchset that has the goal to make performance
better for applications that use lseek's SEEK_HOLE and SEEK_DATA modes to
iterate over the extents of a file. Two examples are the cp program from
coreutils 9.0+ and the tar program (when using its --sparse / -S option).
A sample test and results are listed in the changelog of the last patch
in the series:

  1/9 btrfs: remove leftover setting of EXTENT_UPTODATE state in an inode's io_tree
  2/9 btrfs: add an early exit when searching for delalloc range for lseek/fiemap
  3/9 btrfs: skip unnecessary delalloc searches during lseek/fiemap
  4/9 btrfs: search for delalloc more efficiently during lseek/fiemap
  5/9 btrfs: remove no longer used btrfs_next_extent_map()
  6/9 btrfs: allow passing a cached state record to count_range_bits()
  7/9 btrfs: update stale comment for count_range_bits()
  8/9 btrfs: use cached state when looking for delalloc ranges with fiemap
  9/9 btrfs: use cached state when looking for delalloc ranges with lseek

Reported-by: Wang Yugui <wangyugui@e16-tech.com>
Link: https://lore.kernel.org/linux-btrfs/20221106073028.71F9.409509F4@e16-tech.com/
Link: https://lore.kernel.org/linux-btrfs/CAL3q7H5NSVicm7nYBJ7x8fFkDpno8z3PYt5aPU43Bajc1H0h1Q@mail.gmail.com/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 9b1f76109682..99cc95487d42 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3214,6 +3214,7 @@ static long btrfs_fallocate(struct file *file, int mode,
  * looping while it gets adjacent subranges, and merging them together.
  */
 static bool find_delalloc_subrange(struct btrfs_inode *inode, u64 start, u64 end,
+				   bool *search_io_tree,
 				   u64 *delalloc_start_ret, u64 *delalloc_end_ret)
 {
 	u64 len = end + 1 - start;
@@ -3231,7 +3232,7 @@ static bool find_delalloc_subrange(struct btrfs_inode *inode, u64 start, u64 end
 	spin_lock(&inode->lock);
 	outstanding_extents = inode->outstanding_extents;
 
-	if (inode->delalloc_bytes > 0) {
+	if (*search_io_tree && inode->delalloc_bytes > 0) {
 		spin_unlock(&inode->lock);
 		*delalloc_start_ret = start;
 		delalloc_len = count_range_bits(&inode->io_tree,
@@ -3257,6 +3258,9 @@ static bool find_delalloc_subrange(struct btrfs_inode *inode, u64 start, u64 end
 			start = *delalloc_end_ret + 1;
 			len = end + 1 - start;
 		}
+	} else {
+		/* No delalloc, future calls don't need to search again. */
+		*search_io_tree = false;
 	}
 
 	/*
@@ -3390,6 +3394,7 @@ bool btrfs_find_delalloc_in_range(struct btrfs_inode *inode, u64 start, u64 end,
 {
 	u64 cur_offset = round_down(start, inode->root->fs_info->sectorsize);
 	u64 prev_delalloc_end = 0;
+	bool search_io_tree = true;
 	bool ret = false;
 
 	while (cur_offset < end) {
@@ -3398,6 +3403,7 @@ bool btrfs_find_delalloc_in_range(struct btrfs_inode *inode, u64 start, u64 end,
 		bool delalloc;
 
 		delalloc = find_delalloc_subrange(inode, cur_offset, end,
+						  &search_io_tree,
 						  &delalloc_start,
 						  &delalloc_end);
 		if (!delalloc)
-- 
2.35.1

