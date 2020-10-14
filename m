Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9203028E2A0
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Oct 2020 16:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbgJNOz5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Oct 2020 10:55:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:38696 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728799AbgJNOz5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Oct 2020 10:55:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 80C7FAD18;
        Wed, 14 Oct 2020 14:55:56 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH] btrfs: Use round_down while calculating start position in btrfs_dirty_pages()
Date:   Wed, 14 Oct 2020 09:55:44 -0500
Message-Id: <20201014145545.10878-1-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

round_down looks prettier than the bit mask operations.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 0ff659455b1e..6e52e2360d8e 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -514,7 +514,7 @@ int btrfs_dirty_pages(struct btrfs_inode *inode, struct page **pages,
 	loff_t isize = i_size_read(&inode->vfs_inode);
 	unsigned int extra_bits = 0;
 
-	start_pos = pos & ~((u64) fs_info->sectorsize - 1);
+	start_pos = round_down(pos, fs_info->sectorsize);
 	num_bytes = round_up(write_bytes + pos - start_pos,
 			     fs_info->sectorsize);
 
-- 
2.26.2

