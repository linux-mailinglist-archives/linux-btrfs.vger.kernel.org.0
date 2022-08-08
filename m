Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5928858C769
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Aug 2022 13:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236621AbiHHLSr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Aug 2022 07:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238662AbiHHLSp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Aug 2022 07:18:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAF3DF4F
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Aug 2022 04:18:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC412B80B2B
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Aug 2022 11:18:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B969EC433C1
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Aug 2022 11:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659957521;
        bh=rMaJ11qFN7zu/CVRtM2hsDeCqE/s77kpmS/WB0JwG8Q=;
        h=From:To:Subject:Date:From;
        b=uFbixbaXihp2pWlp1BnCAHsWNBWVT64n0rZDaMSBVLbdURVREVS8x4H2NG80coFJ6
         9a/TcoladvD4F/eu5c1PCuFlP4t/fnO54B+H0ZInl/Ugp9J+23OaLhXZ3E7mYQD2hB
         hVIiZQ95X4S803HfG4MbM3w3QO7rsV4QFq+IwFtYS+nyHnsRTB33LWxkXluW6ePNlR
         2QwLlNTL3ZxxglMla3/uRlVwCHbiz8yiVxSHOdlE8f/Il8FzzjaDzB4qoYznEjUUhH
         KgvAaLOBeTsmIRWw6yW+gRHS1SeLGs8yxy9Bwszi7CusEUOc0BNp2019bjjSLBMlSY
         bcOB5DuRjAd7Q==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: update generation of hole file extent item when merging holes
Date:   Mon,  8 Aug 2022 12:18:37 +0100
Message-Id: <98d51d2ad8fca034c9605605394c15b516f13e5d.1659956764.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When punching a hole into a file range that is adjacent with a hole and we
are not using the no-holes feature, we expand the range of the adjacent
file extent item that represents a hole, to save metadata space.

However we don't update the generation of hole file extent item, which
means a full fsync will not log that file extent item if the fsync happens
in a later transaction (since commit 7f30c07288bb9e ("btrfs: stop copying
old file extents when doing a full fsync")).

For example, if we do this:

    $ mkfs.btrfs -f -O ^no-holes /dev/sdb
    $ mount /dev/sdb /mnt
    $ xfs_io -f -c "pwrite -S 0xab 2M 2M" /mnt/foobar
    $ sync

We end up with 2 file extent items in our file:

1) One that represents the hole for the file range [0, 2M), with a
   generation of 7;

2) Another one that represents an extent covering the range [2M, 4M).

After that if we do the following:

    $ xfs_io -c "fpunch 2M 2M" /mnt/foobar

We end up with a single file extent item in the file, which represents a
hole for the range [0, 4M) and with a generation of 7 - because we end
dropping the data extent for range [2M, 4M) and then update the file
extent item that represented the hole at [0, 2M), by increasing
length from 2M to 4M.

Then doing a full fsync and power failing:

    $ xfs_io -c "fsync" /mnt/foobar
    <power failure>

will result in the full fsync not logging the file extent item that
represents the hole for the range [0, 4M), because its generation is 7,
which is lower than the generation of the current transaction (8).
As a consequence, after mounting again the filesystem (after log replay),
the region [2M, 4M) does not have a hole, it still points to the
previous data extent.

So fix this by always updating the generation of existing file extent
items representing holes when we merge/expand them. This solves the
problem and it's the same approach as when we merge prealloc extents that
got written (at btrfs_mark_extent_written()). Setting the generation to
the current transaction's generation is also what we do when merging
the new hole extent map with the previous one or the next one.

A test case for fstests, covering both cases of hole file extent item
merging (to the left and to the right), will be sent soon.

Fixes: 7f30c07288bb9e ("btrfs: stop copying old file extents when doing a full fsync")
CC: stable@vger.kernel.org # 5.18+
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 687fb372093f..470421955de4 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2499,6 +2499,7 @@ static int fill_holes(struct btrfs_trans_handle *trans,
 		btrfs_set_file_extent_num_bytes(leaf, fi, num_bytes);
 		btrfs_set_file_extent_ram_bytes(leaf, fi, num_bytes);
 		btrfs_set_file_extent_offset(leaf, fi, 0);
+		btrfs_set_file_extent_generation(leaf, fi, trans->transid);
 		btrfs_mark_buffer_dirty(leaf);
 		goto out;
 	}
@@ -2515,6 +2516,7 @@ static int fill_holes(struct btrfs_trans_handle *trans,
 		btrfs_set_file_extent_num_bytes(leaf, fi, num_bytes);
 		btrfs_set_file_extent_ram_bytes(leaf, fi, num_bytes);
 		btrfs_set_file_extent_offset(leaf, fi, 0);
+		btrfs_set_file_extent_generation(leaf, fi, trans->transid);
 		btrfs_mark_buffer_dirty(leaf);
 		goto out;
 	}
-- 
2.35.1

