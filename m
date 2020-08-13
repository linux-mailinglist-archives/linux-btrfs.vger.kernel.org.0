Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11E8F243410
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Aug 2020 08:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgHMGeJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Aug 2020 02:34:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:55002 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbgHMGeJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Aug 2020 02:34:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 73AEBAD39
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Aug 2020 06:34:30 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: cleanup how we calculate lockend in lock_and_cleanup_extent_if_need()
Date:   Thu, 13 Aug 2020 14:33:52 +0800
Message-Id: <20200813063352.94447-1-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We're just doing rounding up to sectorsize to calculate the lockend.

There is no need to do the unnecessary length calculation, just direct
round_up() is enough.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 2f96f083eb8c..c71ea9e5c529 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1475,9 +1475,7 @@ lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct page **pages,
 	int ret = 0;
 
 	start_pos = round_down(pos, fs_info->sectorsize);
-	last_pos = start_pos
-		+ round_up(pos + write_bytes - start_pos,
-			   fs_info->sectorsize) - 1;
+	last_pos = round_up(pos + write_bytes, fs_info->sectorsize) - 1;
 
 	if (start_pos < inode->vfs_inode.i_size) {
 		struct btrfs_ordered_extent *ordered;
-- 
2.28.0

