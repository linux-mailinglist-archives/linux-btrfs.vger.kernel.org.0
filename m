Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F2B3AAAAC
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Jun 2021 07:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbhFQFRC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Jun 2021 01:17:02 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:38148 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhFQFRC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Jun 2021 01:17:02 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7D0CA1FDB1
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Jun 2021 05:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623906894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=oE3tOJnIhdQ30YiNBvnPK8vcRTIuB5mkp55kzcIsCAg=;
        b=qlrSJNF9j3t2GgXq85gm5UGqYTUnJ8rqDX+0vVAg+QpG44WLBCGV5iBTkH/6dydTYVfleH
        P+Uf7CO7AccWbxZiwxFu3nSmIRYBQqftFry8Lwfe90NLBV77IWGBRC1TPATIGcbl06CRDa
        xH5bNUsu4YjkMKcUsuK4QTiemnFJNNQ=
Received: from adam-pc.lan (unknown [10.163.16.38])
        by relay2.suse.de (Postfix) with ESMTP id 78DD0A3BB8
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Jun 2021 05:14:53 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 0/9] btrfs: compression: refactor and enhancement preparing for subpage compression support
Date:   Thu, 17 Jun 2021 13:14:41 +0800
Message-Id: <20210617051450.206704-1-wqu@suse.com>
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

v4:
- Use formal words for BUG_ON() removal patch titles

- Remove compressed_bio::pending_bios
  As compressed_bio::pending_sectors can replace it completely

- Remove unnecessary comments and BUG_ON()s

- Use wait_var_event() APIs to reduce the memory overhead

- Comments update to follow the same schema for moved comments

Qu Wenruo (9):
  btrfs: remove a dead comment for btrfs_decompress_bio()
  btrfs: introduce compressed_bio::pending_sectors to trace compressed
    bio more elegantly
  btrfs: handle errors properly inside btrfs_submit_compressed_read()
  btrfs: handle errors properly inside btrfs_submit_compressed_write()
  btrfs: introduce submit_compressed_bio() for compression
  btrfs: introduce alloc_compressed_bio() for compression
  btrfs: make btrfs_submit_compressed_read() to determine stripe
    boundary at bio allocation time
  btrfs: make btrfs_submit_compressed_write() to determine stripe
    boundary at bio allocation time
  btrfs: remove unused function btrfs_bio_fits_in_stripe()

 fs/btrfs/compression.c | 587 +++++++++++++++++++++++------------------
 fs/btrfs/compression.h |   4 +-
 fs/btrfs/ctree.h       |   2 -
 fs/btrfs/inode.c       |  42 ---
 4 files changed, 336 insertions(+), 299 deletions(-)

-- 
2.32.0

