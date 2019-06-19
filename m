Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4943D4BAE4
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2019 16:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfFSONH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jun 2019 10:13:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:45088 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726238AbfFSONG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jun 2019 10:13:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D5213AE99
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2019 14:13:05 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH] btrfs: Simplify update space_info in __reserve_metadata_bytes()
Date:   Wed, 19 Jun 2019 09:12:49 -0500
Message-Id: <20190619141249.23001-1-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Simplification.
We don't need an if-else-if structure where we can use a
simple OR since both conditions are performing the
same action. The short-circuit for OR will ensure that if
the first condition is true, can_overcommit() is not
called.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/extent-tree.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index c7adff343ba9..84a33cbb1e68 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5158,17 +5158,13 @@ static int __reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
 	used = btrfs_space_info_used(space_info, true);
 
 	/*
-	 * If we have enough space then hooray, make our reservation and carry
-	 * on.  If not see if we can overcommit, and if we can, hooray carry on.
+	 * Carry on if we have enough space (short-circuit) OR call
+	 * can_overcommit() to ensure we can overcommit to carry on.
 	 * If not things get more complicated.
 	 */
-	if (used + orig_bytes <= space_info->total_bytes) {
-		update_bytes_may_use(space_info, orig_bytes);
-		trace_btrfs_space_reservation(fs_info, "space_info",
-					      space_info->flags, orig_bytes, 1);
-		ret = 0;
-	} else if (can_overcommit(fs_info, space_info, orig_bytes, flush,
-				  system_chunk)) {
+	if ((used + orig_bytes <= space_info->total_bytes) ||
+	    can_overcommit(fs_info, space_info, orig_bytes, flush,
+			    system_chunk)) {
 		update_bytes_may_use(space_info, orig_bytes);
 		trace_btrfs_space_reservation(fs_info, "space_info",
 					      space_info->flags, orig_bytes, 1);
-- 
2.16.4

