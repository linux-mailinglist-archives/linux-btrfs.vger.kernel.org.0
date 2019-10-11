Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7901D4499
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2019 17:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfJKPlm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Oct 2019 11:41:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:57504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbfJKPll (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Oct 2019 11:41:41 -0400
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE5AC206A1;
        Fri, 11 Oct 2019 15:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570808500;
        bh=K6QDyckbXgjWdYMdc/J7V++QIPJcDaEWoSfporUFoQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M/SC0GiBWoxYLZTDA8wtgZfRnXd9a/qe5lblacJEMt8zJxlvBnKjF8RdEZytoskEI
         gYFucRDEpkMofnstjTsIvdDzraEzvbwtKD9uQpUnRLQ4NIReWgQtR3AMzR5NuJgrwX
         WOojcOIlkyRe5FmiJYb/0Myp+3HNEkplUzGdWNec=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2] Btrfs: fix negative subv_writers counter and data space leak after buffered write
Date:   Fri, 11 Oct 2019 16:41:20 +0100
Message-Id: <20191011154120.5547-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191009164422.7202-1-fdmanana@kernel.org>
References: <20191009164422.7202-1-fdmanana@kernel.org>
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
   root's subv_writers counter to -1 (through a call to
   btrfs_end_write_no_snapshotting()), and we also end up not releasing the
   data space previously reserved through btrfs_check_data_free_space().
   As a consequence the mechanism for synchronizing NOCOW buffered writes
   with snapshotting gets broken.

Fix this by always setting 'only_release_metadata' to false at the start
of each iteration.

Fixes: 8257b2dc3c1a10 ("Btrfs: introduce btrfs_{start, end}_nocow_write() for each subvolume")
Fixes: 7ee9e4405f264e ("Btrfs: check if we can nocow if we don't have data space")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

V2: Moved assignment of false to only_release_metadata to the beginning of
    loop instead. And another "Fixes:" tag that corresponds to the data
    space leak, since the other if for counter dropping to -1 bug.

 fs/btrfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 27e5b269e729..352928b45d2a 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1636,6 +1636,7 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 			break;
 		}
 
+		only_release_metadata = false;
 		sector_offset = pos & (fs_info->sectorsize - 1);
 		reserve_bytes = round_up(write_bytes + sector_offset,
 				fs_info->sectorsize);
@@ -1792,7 +1793,6 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 			set_extent_bit(&BTRFS_I(inode)->io_tree, lockstart,
 				       lockend, EXTENT_NORESERVE, NULL,
 				       NULL, GFP_NOFS);
-			only_release_metadata = false;
 		}
 
 		btrfs_drop_pages(pages, num_pages);
-- 
2.11.0

