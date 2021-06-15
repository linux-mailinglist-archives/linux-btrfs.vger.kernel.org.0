Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1D43A7E04
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Jun 2021 14:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhFOMUp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Jun 2021 08:20:45 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:33564 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbhFOMUo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Jun 2021 08:20:44 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D3EF81FD55
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Jun 2021 12:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623759519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=GshSd/K+k5PgCEc4X2F5XaBFOs1Eo2OZ3dzJzg4giiY=;
        b=aB+E7hPL+r4/yrHV6IIeQgo+pE5pRs8NV6l52Crrjilx5GJAfkFsVLgDoDm5219hyajnL6
        DoRjCOs5IlVh4YcMHWvmCILwR06cOBuKUPA/stgMyJVEz8NY2Q0dVRo77BZNhjSm1X4Hrt
        OFLhmKL+aQ9AnXf3tDMJP+IDljAQE6A=
Received: from adam-pc.lan (unknown [10.163.16.38])
        by relay2.suse.de (Postfix) with ESMTP id D5404A3B8E
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Jun 2021 12:18:38 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 0/9] btrfs: compression: refactor and enhancement preparing for subpage compression support
Date:   Tue, 15 Jun 2021 20:18:27 +0800
Message-Id: <20210615121836.365105-1-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are quite some problems in compression code:

- Weird compressed_bio::pending_bios dance
  If we just don't want compressed_bio being freed halfway, we have more
  sane methods, just like btrfs_subpage::readers.

  So here we fix it by introducing compressed_bio::io_sectors to do the
  job.

- BUG_ON()s inside btrfs_submit_compressed_*()
  Even they are just ENOMEM, we should handle them.
  With io_sectors introduced, we have a way to finish compressed_bio
  all by ourselves, as long as we haven't submitted last bio.

  If we have last bio submitted, then endio will handle it well.

- Duplicated code for compressed bio allocation and submission
  Just small refactor can handle it

- Stripe boundary is checked every time one page is added
  This is overkilled.
  Just learn from extent_io.c refactor which use bio_ctrl to do the
  boundary check only once for each bio.

  Although in compression context, we don't need extra checks in
  extent_io.c, thus we don't need bio_ctrl structure, but
  can afford to do it locally.

- Dead code removal
  One dead comment and a new zombie function,
  btrfs_bio_fits_in_stripe(), can be removed now.

Changelog:
v2:
- Rebased to latest misc-next

- Fix a bug in btrfs_submit_compressed_write() where zoned write is not
  taken into consideration

- Reuse the existing chunk mapping of btrfs_get_chunk_map()

v3:
- Fix a bug that zoned device can't even pass btrfs/001
  This is because at endio time, bi_size for zoned device is always 0.
  We have to use bio_for_each_segment_all() to calculate the real bio
  size instead.
  In theory, it should also happen more frequently for non-zoned device,
  but no catch for all test cases (with "-o compress") except btrfs/011.

- Fix btrfs/011 hang when tested with "-o compress"
  This is caused by checking both atomic value without protection.
  Checking two atomic values is no longer atomic.

  In fact, with compressed_bio::io_sectors introduced, pending_bios is
  only used to wait for any pending bio to finish in error path.

  Thus dec_and_test_compressed_bio() only need to check if io_sectors is
  zero

- Fix a error that in error handling path, we may hang due to missing
  wake_up() in dec_and_test_compressed_bio()

Qu Wenruo (9):
  btrfs: remove a dead comment for btrfs_decompress_bio()
  btrfs: introduce compressed_bio::io_sectors to trace compressed bio
    more elegantly
  btrfs: hunt down the BUG_ON()s inside btrfs_submit_compressed_read()
  btrfs: hunt down the BUG_ON()s inside btrfs_submit_compressed_write()
  btrfs: introduce submit_compressed_bio() for compression
  btrfs: introduce alloc_submit_compressed_bio() for compression
  btrfs: make btrfs_submit_compressed_read() to determine stripe
    boundary at bio allocation time
  btrfs: make btrfs_submit_compressed_write() to determine stripe
    boundary at bio allocation time
  btrfs: remove unused function btrfs_bio_fits_in_stripe()

 fs/btrfs/compression.c | 607 ++++++++++++++++++++++++-----------------
 fs/btrfs/compression.h |  13 +-
 fs/btrfs/ctree.h       |   2 -
 fs/btrfs/inode.c       |  42 ---
 4 files changed, 367 insertions(+), 297 deletions(-)

-- 
2.32.0

