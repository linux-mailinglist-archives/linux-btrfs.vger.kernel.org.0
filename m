Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B904A4251A6
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Oct 2021 13:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbhJGLGE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Oct 2021 07:06:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:51374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232732AbhJGLGB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 7 Oct 2021 07:06:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 33A9F61042
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Oct 2021 11:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633604647;
        bh=4udXX5Ics/pzmbLcwxaOpz0sDJtP4YHhtTT8P/mrIE0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=EI6+723gIN1ixqW+wCIdZngiAKnr5drgjfMlzdgD1mq3AA5HrULytFxt6nV0mokCH
         4E2r187MUfGfZlXbckzG2EY3xczv0cbr5rccL5p1gCDdV2GmWXWxZli+BYZC5BwHsD
         wMxM8soBc6DHiKNlhJGfx9Ej31ToTteXXWJowsnX4O644uJBmFIHVeEMl0r2gWw8z+
         admBmr3ylSxBMMeVG/WkoWJvp8CQL7qZ74Tr4iRhTMeTFDRa5VSUR2vwxL8/KkprcC
         ZYds5ffxwNOGne9LQTW3cvt/6ym4jdvaKE6EKzVte5gMtU5OCa9/lPW8JJjvspKJTR
         pVR5/GSYhidcg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: update comments for chunk allocation -ENOSPC cases
Date:   Thu,  7 Oct 2021 12:04:00 +0100
Message-Id: <0bb66b8bc9bf4c48d8ce0009dfd9c251a1fbd429.1633604360.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1633604360.git.fdmanana@suse.com>
References: <cover.1633604360.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Update the comments at btrfs_chunk_alloc() and do_chunk_alloc() that
describe which cases can lead to a failure to allocate metadata and system
space despite having previously reserved space. This adds one more reason
that I previously forgot to mention.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index c4ffb267a9b3..5a250173afac 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3409,7 +3409,7 @@ static int do_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags)
 	/*
 	 * Normally we are not expected to fail with -ENOSPC here, since we have
 	 * previously reserved space in the system space_info and allocated one
-	 * new system chunk if necessary. However there are two exceptions:
+	 * new system chunk if necessary. However there are three exceptions:
 	 *
 	 * 1) We may have enough free space in the system space_info but all the
 	 *    existing system block groups have a profile which can not be used
@@ -3435,7 +3435,14 @@ static int do_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags)
 	 *    with enough free space got turned into RO mode by a running scrub,
 	 *    and in this case we have to allocate a new one and retry. We only
 	 *    need do this allocate and retry once, since we have a transaction
-	 *    handle and scrub uses the commit root to search for block groups.
+	 *    handle and scrub uses the commit root to search for block groups;
+	 *
+	 * 3) We had one system block group with enough free space when we called
+	 *    check_system_chunk(), but after that, right before we tried to
+	 *    allocate the last extent buffer we needed, a discard operation came
+	 *    in and it temporarily removed the last free space entry from the
+	 *    block group (discard removes a free space entry, discards it, and
+	 *    then adds back the entry to the block group cache).
 	 */
 	if (ret == -ENOSPC) {
 		const u64 sys_flags = btrfs_system_alloc_profile(trans->fs_info);
@@ -3519,7 +3526,15 @@ static int do_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags)
  *    properly, either intentionally or as a bug. One example where this is
  *    done intentionally is fsync, as it does not reserve any transaction units
  *    and ends up allocating a variable number of metadata extents for log
- *    tree extent buffers.
+ *    tree extent buffers;
+ *
+ * 4) The task has reserved enough transaction units / metadata space, but right
+ *    before it tries to allocate the last extent buffer it needs, a discard
+ *    operation comes in and, temporarily, removes the last free space entry from
+ *    the only metadata block group that had free space (discard starts by
+ *    removing a free space entry from a block group, then does the discard
+ *    operation and, once it's done, it adds back the free space entry to the
+ *    block group).
  *
  * We also need this 2 phases setup when adding a device to a filesystem with
  * a seed device - we must create new metadata and system chunks without adding
-- 
2.33.0

