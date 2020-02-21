Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79094168378
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2020 17:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbgBUQbo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Feb 2020 11:31:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:43836 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbgBUQbn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Feb 2020 11:31:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 14F0DAEEC;
        Fri, 21 Feb 2020 16:31:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9FDE7DA70E; Fri, 21 Feb 2020 17:31:24 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 11/11] btrfs: reduce pointer intdirections in btree_readpage_end_io_hook
Date:   Fri, 21 Feb 2020 17:31:24 +0100
Message-Id: <98513b19d5af7821e6e00eee4ad09b5aa5c76abf.1582302545.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1582302545.git.dsterba@suse.com>
References: <cover.1582302545.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

All we need to read is checksum size from fs_info superblock, and
fs_info is provided by extent buffer so we can get rid of the wild
pointer indirections from page/inode/root.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/disk-io.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index ab8d975f071c..bccdb55ececf 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -604,9 +604,8 @@ static int btree_readpage_end_io_hook(struct btrfs_io_bio *io_bio,
 	u64 found_start;
 	int found_level;
 	struct extent_buffer *eb;
-	struct btrfs_root *root = BTRFS_I(page->mapping->host)->root;
-	struct btrfs_fs_info *fs_info = root->fs_info;
-	u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
+	struct btrfs_fs_info *fs_info;
+	u16 csum_size;
 	int ret = 0;
 	u8 result[BTRFS_CSUM_SIZE];
 	int reads_done;
@@ -615,6 +614,8 @@ static int btree_readpage_end_io_hook(struct btrfs_io_bio *io_bio,
 		goto out;
 
 	eb = (struct extent_buffer *)page->private;
+	fs_info = eb->fs_info;
+	csum_size = btrfs_super_csum_size(fs_info->super_copy);
 
 	/* the pending IO might have been the only thing that kept this buffer
 	 * in memory.  Make sure we have a ref for all this other checks
-- 
2.25.0

