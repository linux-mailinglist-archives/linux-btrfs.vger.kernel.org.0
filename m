Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFDA1FA8CC
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jun 2020 08:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgFPGcp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Jun 2020 02:32:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:37870 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbgFPGco (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Jun 2020 02:32:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 62325AC85
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Jun 2020 06:32:47 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs-progs: fix wrong chunk profile for do_chunk_alloc()
Date:   Tue, 16 Jun 2020 14:32:29 +0800
Message-Id: <20200616063230.90165-2-wqu@suse.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616063230.90165-1-wqu@suse.com>
References: <20200616063230.90165-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
There is a bug report that using DUP data profile, with a 400MiB source
dir, on a 7G disk leads to mkfs failure caused by ENOSPC.

[CAUSE]
After some debugging, it turns out that do_chunk_alloc() is always
passing SINGLE profile for new chunks.

The offending code looks like: extent-tree.c:: do_chunk_alloc()

	ret = btrfs_alloc_chunk(trans, fs_info, &start, &num_bytes,
	                        space_info->flags);

However since commit bce7dbba2859 ("Btrfs-progs: only build space info's
for the main flags"), we no longer store the profile bits in space_info
anymore.

This makes space_info never get updated properly, and causing us to
creating more and more chunks to eat up most of the disk with unused
SINGLE chunks, and finally leads to ENOSPC.

[FIX]
Fix the bug by passing the proper flags to btrfs_alloc_chunk().
Also, to address the original problem commit 2689259501c1 ("btrfs progs:
fix extra metadata chunk allocation in --mixed case") tries to fix, here
we do extra bit OR to ensure we get the proper flags.

Issue: #258
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 extent-tree.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/extent-tree.c b/extent-tree.c
index 4af8f4ba8a47..1cb956382c3b 100644
--- a/extent-tree.c
+++ b/extent-tree.c
@@ -1721,8 +1721,14 @@ static int do_chunk_alloc(struct btrfs_trans_handle *trans,
 		return 0;
 	trans->allocating_chunk = 1;
 
-	ret = btrfs_alloc_chunk(trans, fs_info, &start, &num_bytes,
-	                        space_info->flags);
+	/*
+	 * The space_info only has block group type (data/meta/sys), doesn't
+	 * have the proper profile.
+	 * While we still want to handle mixed block groups properly.
+	 * So here add the extra bits for mixed profile.
+	 */
+	flags |= space_info->flags;
+	ret = btrfs_alloc_chunk(trans, fs_info, &start, &num_bytes, flags);
 	if (ret == -ENOSPC) {
 		space_info->full = 1;
 		trans->allocating_chunk = 0;
@@ -1731,8 +1737,8 @@ static int do_chunk_alloc(struct btrfs_trans_handle *trans,
 
 	BUG_ON(ret);
 
-	ret = btrfs_make_block_group(trans, fs_info, 0, space_info->flags,
-				     start, num_bytes);
+	ret = btrfs_make_block_group(trans, fs_info, 0, flags, start,
+				     num_bytes);
 	BUG_ON(ret);
 	trans->allocating_chunk = 0;
 	return 0;
-- 
2.27.0

