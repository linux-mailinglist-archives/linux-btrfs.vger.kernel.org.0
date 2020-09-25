Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D267279244
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Sep 2020 22:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgIYUhF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Sep 2020 16:37:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:37590 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727495AbgIYUhE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Sep 2020 16:37:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4346BABBD;
        Fri, 25 Sep 2020 20:37:02 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH] btrfs: Calculate num_pages, reserve_bytes once in  btrfs_buffered_write()
Date:   Fri, 25 Sep 2020 15:36:38 -0500
Message-Id: <20200925203638.28890-1-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Cleanup.

write_bytes can change in btrfs_check_nocow_lock(). Calculate variables
such as num_pages and reserve_bytes once we are sure of the value of
write_bytes so there is no need to re-calculate.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/file.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 038e0afaf3d0..7695988fdba3 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1648,8 +1648,7 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 		size_t write_bytes = min(iov_iter_count(i),
 					 nrptrs * (size_t)PAGE_SIZE -
 					 offset);
-		size_t num_pages = DIV_ROUND_UP(write_bytes + offset,
-						PAGE_SIZE);
+		size_t num_pages;
 		size_t reserve_bytes;
 		size_t dirty_pages;
 		size_t copied;
@@ -1657,8 +1656,6 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 		size_t num_sectors;
 		int extents_locked;
 
-		WARN_ON(num_pages > nrptrs);
-
 		/*
 		 * Fault pages before locking them in prepare_pages
 		 * to avoid recursive lock
@@ -1670,35 +1667,28 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 
 		only_release_metadata = false;
 		sector_offset = pos & (fs_info->sectorsize - 1);
-		reserve_bytes = round_up(write_bytes + sector_offset,
-				fs_info->sectorsize);
 
 		extent_changeset_release(data_reserved);
 		ret = btrfs_check_data_free_space(BTRFS_I(inode),
 						  &data_reserved, pos,
 						  write_bytes);
 		if (ret < 0) {
+			/*
+			 * If we don't have to cow at the offset, reserve
+			 * metadata only. write_bytes may get smaller
+			 * than requested here.
+			 */
 			if (btrfs_check_nocow_lock(BTRFS_I(inode), pos,
-						   &write_bytes) > 0) {
-				/*
-				 * For nodata cow case, no need to reserve
-				 * data space.
-				 */
+						   &write_bytes) > 0)
 				only_release_metadata = true;
-				/*
-				 * our prealloc extent may be smaller than
-				 * write_bytes, so scale down.
-				 */
-				num_pages = DIV_ROUND_UP(write_bytes + offset,
-							 PAGE_SIZE);
-				reserve_bytes = round_up(write_bytes +
-							 sector_offset,
-							 fs_info->sectorsize);
-			} else {
+			else
 				break;
-			}
 		}
 
+		num_pages = DIV_ROUND_UP(write_bytes + offset, PAGE_SIZE);
+		WARN_ON(num_pages > nrptrs);
+		reserve_bytes = round_up(write_bytes + sector_offset,
+					 fs_info->sectorsize);
 		WARN_ON(reserve_bytes == 0);
 		ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode),
 				reserve_bytes);
-- 
2.26.2

