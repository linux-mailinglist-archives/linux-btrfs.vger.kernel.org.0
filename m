Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A9F2B0154
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 09:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgKLIsG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 03:48:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:39870 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbgKLIsG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 03:48:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605170884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N/8hDexmvGkfmmQp6zL+jr0JbaK9PXlFL+nVTJehc+8=;
        b=GiOdYYu92wYAN/hyS9gpVTsqw89VACwntgOHG7asLfAO8MyDdu/TiQD/h0DaM9DZ4yBCor
        Q1mOapIqUq0xH/HRm5Jx/8llH1vnieyDyIi/+08KotSsvpRdqx2JARlXc42gA9wGbW7ar5
        M0lJ+R4KFXQ1cZNxMf9FsOe9mps3UrU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D79CDAB95;
        Thu, 12 Nov 2020 08:48:04 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v3 1/2] btrfs: remove the phy_offset parameter for btrfs_validate_metadata_buffer()
Date:   Thu, 12 Nov 2020 16:47:57 +0800
Message-Id: <20201112084758.73617-2-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201112084758.73617-1-wqu@suse.com>
References: <20201112084758.73617-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Parameter @phy_offset is the offset against the bio->bi_iter.bi_sector.
@phy_offset is mostly for data io to lookup the csum in btrfs_io_bio.

But for metadata, it's completely useless as metadata stores their own
csum in its btrfs_header.

Remove this useless parameter from btrfs_validate_metadata_buffer().

Just an extra note for parameters @start and @end, they are not utilized
at all for current sectorsize == PAGE_SIZE case, as we can grab eb directly
from page.

But those two parameters are very important for later subpage support,
thus @start/@len are not touched here.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/disk-io.c   | 2 +-
 fs/btrfs/disk-io.h   | 2 +-
 fs/btrfs/extent_io.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index f0161d2ae2a4..8a558a43818d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -593,7 +593,7 @@ static int validate_extent_buffer(struct extent_buffer *eb)
 	return ret;
 }
 
-int btrfs_validate_metadata_buffer(struct btrfs_io_bio *io_bio, u64 phy_offset,
+int btrfs_validate_metadata_buffer(struct btrfs_io_bio *io_bio,
 				   struct page *page, u64 start, u64 end,
 				   int mirror)
 {
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index e75ea6092942..40e81d6e481e 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -79,7 +79,7 @@ void btrfs_btree_balance_dirty(struct btrfs_fs_info *fs_info);
 void btrfs_btree_balance_dirty_nodelay(struct btrfs_fs_info *fs_info);
 void btrfs_drop_and_free_fs_root(struct btrfs_fs_info *fs_info,
 				 struct btrfs_root *root);
-int btrfs_validate_metadata_buffer(struct btrfs_io_bio *io_bio, u64 phy_offset,
+int btrfs_validate_metadata_buffer(struct btrfs_io_bio *io_bio,
 				   struct page *page, u64 start, u64 end,
 				   int mirror);
 blk_status_t btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index e17429d3bd3a..d26677745757 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2928,7 +2928,7 @@ static void end_bio_extent_readpage(struct bio *bio)
 							     start, end, mirror);
 			else
 				ret = btrfs_validate_metadata_buffer(io_bio,
-					offset, page, start, end, mirror);
+					page, start, end, mirror);
 			if (ret)
 				uptodate = 0;
 			else
-- 
2.29.2

