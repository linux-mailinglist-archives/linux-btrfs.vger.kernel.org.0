Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 008AC160A4F
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2020 07:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgBQGRF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Feb 2020 01:17:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:41800 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbgBQGRE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Feb 2020 01:17:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EA553AAC2
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Feb 2020 06:17:02 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 2/3] btrfs: relocation: Check cancel request after each data page read
Date:   Mon, 17 Feb 2020 14:16:53 +0800
Message-Id: <20200217061654.65567-3-wqu@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200217061654.65567-1-wqu@suse.com>
References: <20200217061654.65567-1-wqu@suse.com>
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

Also add a comment explaining how the cancelling/error handling works.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/relocation.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 475479d50cc3..dc97fdd58c3d 100644
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
@@ -4208,6 +4212,14 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 	backref_cache_cleanup(&rc->backref_cache);
 	btrfs_block_rsv_release(fs_info, rc->block_rsv, (u64)-1);
 
+	/*
+	 * Even when the relocation is cancelled, we should all go throught
+	 * prepare_to_merge() and merge_reloc_roots().
+	 *
+	 * For error (including cancelled balance), prepare_to_merge() will
+	 * mark all reloc tree orphan, then queue them for cleanup in
+	 * merge_reloc_roots()
+	 */
 	err = prepare_to_merge(rc, err);
 
 	merge_reloc_roots(rc);
-- 
2.25.0

