Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27BCF1589AB
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2020 06:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgBKFhn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Feb 2020 00:37:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:49910 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727662AbgBKFhn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Feb 2020 00:37:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4C365AB92
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Feb 2020 05:37:42 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/4] btrfs: relocation: Check cancel request after each data page read
Date:   Tue, 11 Feb 2020 13:37:27 +0800
Message-Id: <20200211053729.20807-3-wqu@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200211053729.20807-1-wqu@suse.com>
References: <20200211053729.20807-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When relocating a data extents with large large data extents, we spend
most of our time in relocate_file_extent_cluster() at stage "moving data
extents":
 1)               |  btrfs_relocate_block_group [btrfs]() {
 1)               |    relocate_file_extent_cluster [btrfs]() {
 1) $ 6586769 us  |    }
 1) + 18.260 us   |    relocate_file_extent_cluster [btrfs]();
 1) + 15.770 us   |    relocate_file_extent_cluster [btrfs]();
 1) $ 8916340 us  |  }
 1)               |  btrfs_relocate_block_group [btrfs]() {
 1)               |    relocate_file_extent_cluster [btrfs]() {
 1) $ 11611586 us |    }
 1) + 16.930 us   |    relocate_file_extent_cluster [btrfs]();
 1) + 15.870 us   |    relocate_file_extent_cluster [btrfs]();
 1) $ 14986130 us |  }

So to make data relocation cancelling quicker, here add extra balance
cancelling check after each page read in relocate_file_extent_cluster().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/relocation.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 475479d50cc3..23b279872641 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3396,6 +3396,10 @@ static int relocate_file_extent_cluster(struct inode *inode,
 		btrfs_delalloc_release_extents(BTRFS_I(inode), PAGE_SIZE);
 		balance_dirty_pages_ratelimited(inode->i_mapping);
 		btrfs_throttle(fs_info);
+		if (should_cancel_balance(fs_info)) {
+			ret = -ECANCELED;
+			goto out;
+		}
 	}
 	WARN_ON(nr != cluster->nr);
 out:
-- 
2.25.0

