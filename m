Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69EC1D1460
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2019 18:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730708AbfJIQo0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Oct 2019 12:44:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:56294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729644AbfJIQo0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 9 Oct 2019 12:44:26 -0400
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03746206BB
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2019 16:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570639465;
        bh=nryicaO10T/qEAhNndCA6zs01yN74x7Dz/w517gzzVs=;
        h=From:To:Subject:Date:From;
        b=Zx+hQtl5Bt06puJaHkk8l44pax2cHEzrQCQk+k2bJulyhmcRvh7gVIudtB1iEruQg
         /q8Hv3CfHRaWhAwKQ1XYY1vK3i3IlzQIcnSakF58Ik3dL6Pnb9ylO2nsKVRmgUkQNt
         0IV4YA13hRCYWEHSIETvEticOx2P1xmAV4OHj6ZY=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] Btrfs: fix negative subv_writers counter and data space leak after buffered write
Date:   Wed,  9 Oct 2019 17:44:22 +0100
Message-Id: <20191009164422.7202-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When doing a buffered write it's possible to leave the subv_writers
counter of the root, used for synchronization between buffered nocow
writers and snapshotting. This happens in an exceptional case like the
following:

1) We fail to allocate data space for the write, since there's not
   enough available data space nor enough unallocated space for allocating
   a new data block group;

2) Because of that failure, we try to go to NOCOW mode, which succeeds
   and therefore we set the local variable 'only_release_metadata' to true
   and set the root's sub_writers counter to 1 through the call to
   btrfs_start_write_no_snapshotting() made by check_can_nocow();

3) The call to btrfs_copy_from_user() returns zero, which is very unlikely
   to happen but not impossible;

4) No pages are copied because btrfs_copy_from_user() returned zero;

5) We call btrfs_end_write_no_snapshotting() which decrements the root's
   subv_writers counter to 0;

6) We don't set 'only_release_metadata' back to 'false' because we do
   it only if 'copied', the value returned by btrfs_copy_from_user(), is
   greater than zero;

7) On the next iteration of the while loop, which processes the same
   page range, we are now able to allocate data space for the write (we
   got enough data space released in the meanwhile);

8) After this if we fail at btrfs_delalloc_reserve_metadata(), because
   now there isn't enough free metadata space, or in some other place
   further below (prepare_pages(), lock_and_cleanup_extent_if_need(),
   btrfs_dirty_pages()), we break out of the while loop with
   'only_release_metadata' having a value of 'true';

9) Because 'only_release_metadata' is 'true' we end up decrementing the
   root's subv_writers counter to -1, and we also end up not releasing the
   data space previously reserved through btrfs_check_data_free_space().
   As a consequence the mechanism for synchronizing NOCOW buffered writes
   with snapshotting gets broken.

Fix this by always setting 'only_release_metadata' to false whenever it
currently has a true value, independently of having been able to copy any
data to the pages.

Fixes: 8257b2dc3c1a10 ("Btrfs: introduce btrfs_{start, end}_nocow_write() for each subvolume")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 27e5b269e729..c98c1d10fd3a 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1780,18 +1780,19 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 		}
 
 		release_bytes = 0;
-		if (only_release_metadata)
+		if (only_release_metadata) {
 			btrfs_end_write_no_snapshotting(root);
-
-		if (only_release_metadata && copied > 0) {
-			lockstart = round_down(pos,
-					       fs_info->sectorsize);
-			lockend = round_up(pos + copied,
-					   fs_info->sectorsize) - 1;
-
-			set_extent_bit(&BTRFS_I(inode)->io_tree, lockstart,
-				       lockend, EXTENT_NORESERVE, NULL,
-				       NULL, GFP_NOFS);
+			if (copied > 0) {
+				lockstart = round_down(pos,
+						       fs_info->sectorsize);
+				lockend = round_up(pos + copied,
+						   fs_info->sectorsize) - 1;
+
+				set_extent_bit(&BTRFS_I(inode)->io_tree,
+					       lockstart, lockend,
+					       EXTENT_NORESERVE, NULL, NULL,
+					       GFP_NOFS);
+			}
 			only_release_metadata = false;
 		}
 
-- 
2.11.0

