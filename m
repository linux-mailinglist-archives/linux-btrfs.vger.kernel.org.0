Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51853474B5
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Mar 2021 10:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbhCXJbz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Mar 2021 05:31:55 -0400
Received: from mail.synology.com ([211.23.38.101]:59258 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235004AbhCXJbp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Mar 2021 05:31:45 -0400
Received: from localhost.localdomain (unknown [10.17.32.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by synology.com (Postfix) with ESMTPSA id 6B46CCE781EE;
        Wed, 24 Mar 2021 17:31:44 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1616578304; bh=ycjCGG+Ux6zuThGd3xuSA4cvVmyaodPS7cGN+rD28t0=;
        h=From:To:Cc:Subject:Date;
        b=eBNVQZApI1nVQ4+4osC1qG8/CpAYhaS/yColSxeB+GB4O+OhEYrcU4bjgYGMH4IRS
         XHWGDRpaSgNjDzT7mWjDiwSesW/XQe/TPPUepV4btR4UZPZVVmFLiiZG/YVvYM4npz
         eu1Xkqzt3JTzkO98516e6qi0QdqJ36j7NGSngzk8=
From:   bingjingc <bingjingc@synology.com>
To:     josef@toxicpanda.com, dsterba@suse.com, quwenruo@cn.fujitsu.com,
        clm@fb.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     bingjingc@synology.com, cccheng@synology.com, robbieko@synology.com
Subject: [PATCH] btrfs: fix a potential hole-punching failure
Date:   Wed, 24 Mar 2021 17:31:10 +0800
Message-Id: <1616578270-7365-1-git-send-email-bingjingc@synology.com>
X-Mailer: git-send-email 2.7.4
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: BingJing Chang <bingjingc@synology.com>

In commit d77815461f04 ("btrfs: Avoid trucating page or punching hole in
a already existed hole."), existed holes can be skipped by calling
find_first_non_hole() to adjust *start and *len. However, if the given
len is invalid and large, when an EXTENT_MAP_HOLE extent is found, the
*len will not be set to zero because (em->start + em->len) is less than
(*start + *len). Then the ret will be 1 but the *len will not be set to
0. The propagated non-zero ret will result in fallocate failure.

In the while-loop of btrfs_replace_file_extents(), len is not updated
every time before it calls find_first_non_hole(). That is, if the last
file extent in the given hole-punching range has been dropped but
btrfs_drop_extents() fails with -ENOSPC (btrfs_drop_extents() runs out
of reserved space of the given transaction), the problem can happen.
After it calls find_first_non_hole(), the cur_offset will be adjusted
to be larger than or equal to end. However, since the len is not set to
zero. The break-loop condition (ret && !len) will not meet. After it
leaves the while-loop, uncleared ret will result in fallocate failure.

We're not able to construct a reproducible way to let
btrfs_drop_extents() fails with -ENOSPC after it drops the last file
extent but with remaining holes. However, it's quite easy to fix. We
just need to update and check the len every time before we call
find_first_non_hole(). To make the while loop more readable, we also
pull the variable updates to the bottom of loop like this:
while (cur_offset < end) {
        ...
        // update cur_offset & len
        // advance cur_offset & len in hole-punching case if needed
}

Reported-by: Robbie Ko <robbieko@synology.com>
Fixes: d77815461f04 ("btrfs: Avoid trucating page or punching hole in a
already existed hole.")
Reviewed-by: Robbie Ko <robbieko@synology.com>
Reviewed-by: Chung-Chiang Cheng <cccheng@synology.com>
Signed-off-by: BingJing Chang <bingjingc@synology.com>
---
 fs/btrfs/file.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 0e155f0..dccb017 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2735,8 +2735,6 @@ int btrfs_replace_file_extents(struct inode *inode, struct btrfs_path *path,
 			extent_info->file_offset += replace_len;
 		}
 
-		cur_offset = drop_args.drop_end;
-
 		ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
 		if (ret)
 			break;
@@ -2756,7 +2754,9 @@ int btrfs_replace_file_extents(struct inode *inode, struct btrfs_path *path,
 		BUG_ON(ret);	/* shouldn't happen */
 		trans->block_rsv = rsv;
 
-		if (!extent_info) {
+		cur_offset = drop_args.drop_end;
+		len = end - cur_offset;
+		if (!extent_info && len) {
 			ret = find_first_non_hole(BTRFS_I(inode), &cur_offset,
 						  &len);
 			if (unlikely(ret < 0))
-- 
2.7.4

