Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE5F52B1A00
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 12:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgKMLYm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 06:24:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:53962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbgKMLY1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 06:24:27 -0500
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8871E207DE
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 11:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605266660;
        bh=y4iX4MsOaaVjhZONiFjW41JpsBWusJE0WhzFLDtOJpg=;
        h=From:To:Subject:Date:From;
        b=JSYigLpIlBPzv5xGHvLSPMTfn9ILmAN1sxoIrGb5BWTzugSRwBZS7R17Vce0Ui1OW
         YrJEh8n73Ril7CKS0QcfG0mxCWibtqYZ+wOe5nQJfzXhKkRNFONKsEOoriCb9X5Byw
         HazPxQ0QEmjIXo7Qrs5Ln70FVUXDOR7hWOnz9aWE=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove unnecessary attempt do drop extent maps after adding inline extent
Date:   Fri, 13 Nov 2020 11:24:17 +0000
Message-Id: <1b80a3ffc965dbf663ab746dc11ea5e9fa1e10bf.1605266387.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

At inode.c:cow_file_range_inline(), after we insert the inline extent
in the fs/subvolume btree, we call btrfs_drop_extent_cache() to drop
all extent maps in the file range, however that is not necessary because
we have already done it in the call to btrfs_drop_extents(), which calls
btrfs_drop_extent_cache() for us, and since at this point we have the file
range locked in the inode's iotree (we are in the writeback path), we know
no other task can come in and read stale file extent items or find none
and therefore create either stale extent maps or an extent map that
represens a hole.

So just remove that unnecessary call to btrfs_drop_extent_cache(), as it's
doing nothing and only wasting time. This call has been around since 2008,
introduced in commit c8b978188c9a ("Btrfs: Add zlib compression support"),
but even back then it seems it was not necessary, since we had the range
locked in the inode's iotree and the call to btrfs_drop_extents() already
used to always call btrfs_drop_extent_cache().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 84a75cf86d88..0a2ee8983528 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -392,7 +392,6 @@ static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 start,
 	}
 
 	set_bit(BTRFS_INODE_NEEDS_FULL_SYNC, &inode->runtime_flags);
-	btrfs_drop_extent_cache(inode, start, aligned_end - 1, 0);
 out:
 	/*
 	 * Don't forget to free the reserved space, as for inlined extent
-- 
2.28.0

