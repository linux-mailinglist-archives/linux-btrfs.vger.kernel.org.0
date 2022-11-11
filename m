Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373EE6259CD
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Nov 2022 12:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbiKKLup (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Nov 2022 06:50:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbiKKLum (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Nov 2022 06:50:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C792827DFE
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 03:50:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 561EE61EA1
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 11:50:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A652C433B5
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 11:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668167440;
        bh=vEgSk1GJ/D2KkMxx9JOBYCbvDPjN9J5jBz+uwkHLvuM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=UqvG/tTL7kx+rdb7cXaJk4+82RhEguuD8Oqxx2m9UBySC0k9oSGHdgzKEqjYlx+se
         uCB4UPZlaJ90KBJR/JI1LWBTQ6dwYtj1MUZW7c0nVpAqT4QlyQo+wYJzYOSmbG75Un
         bWjnkKIoORXMCtho0o6kaH8EPLxVNtOVl2e6FghfoY8b6FprQkEgtDygxv4+VqRo70
         gzRQtetcTbcb8LGSvXYXylUhnvo/kDxSRLfuWxMl2rd3fkdcga1weoI6avafIeaZWN
         l4eva6s/GwIKOHaoFG4n5SbqlXNE5c22cEtLIxs54i3Ab7DnoXUxfNjnPAH1/EH/l0
         vq7ptSJtAGQyw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/9] btrfs: add an early exit when searching for delalloc range for lseek/fiemap
Date:   Fri, 11 Nov 2022 11:50:28 +0000
Message-Id: <1adb20d99e0b8e1114874a878180471c7b3372a0.1668166764.git.fdmanana@suse.com>
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

During fiemap and lseek (SEEK_HOLE/DATA), when looking for delalloc in a
range corresponding to a hole or a prealloc extent, if we found the whole
range marked as delalloc in the inode's io_tree, then we can terminate
immediately and avoid searching the extent map tree. If not, and if the
found delalloc starts at the same offset of our search start but ends
before our search range's end, then we can adjust the search range for
the search in the extent map tree. So implement those changes.

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
 fs/btrfs/file.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index e6c93be91a06..9b1f76109682 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3216,7 +3216,7 @@ static long btrfs_fallocate(struct file *file, int mode,
 static bool find_delalloc_subrange(struct btrfs_inode *inode, u64 start, u64 end,
 				   u64 *delalloc_start_ret, u64 *delalloc_end_ret)
 {
-	const u64 len = end + 1 - start;
+	u64 len = end + 1 - start;
 	struct extent_map_tree *em_tree = &inode->extent_tree;
 	struct extent_map *em;
 	u64 em_end;
@@ -3242,13 +3242,23 @@ static bool find_delalloc_subrange(struct btrfs_inode *inode, u64 start, u64 end
 		delalloc_len = 0;
 	}
 
-	/*
-	 * If delalloc was found then *delalloc_start_ret has a sector size
-	 * aligned value (rounded down).
-	 */
-	if (delalloc_len > 0)
+	if (delalloc_len > 0) {
+		/*
+		 * If delalloc was found then *delalloc_start_ret has a sector size
+		 * aligned value (rounded down).
+		 */
 		*delalloc_end_ret = *delalloc_start_ret + delalloc_len - 1;
 
+		if (*delalloc_start_ret == start) {
+			/* Delalloc for the whole range, nothing more to do. */
+			if (*delalloc_end_ret == end)
+				return true;
+			/* Else trim our search range for extent maps. */
+			start = *delalloc_end_ret + 1;
+			len = end + 1 - start;
+		}
+	}
+
 	/*
 	 * No outstanding extents means we don't have any delalloc that is
 	 * flushing, so return the unflushed range found in the io tree (if any).
-- 
2.35.1

