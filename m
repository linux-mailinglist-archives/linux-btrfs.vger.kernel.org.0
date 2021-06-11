Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F55F3A4295
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jun 2021 15:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbhFKNCh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Jun 2021 09:02:37 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35826 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbhFKNCh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Jun 2021 09:02:37 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B675A21A5C
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Jun 2021 13:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623416438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=BNzOn5EAE/wDiONz+a2R9w75ztwL77jFwMdmTp85mhg=;
        b=u8s/IhR1Mu1QE99LnVdzPuXdRtmeyoPj463apRq3ZN3G26P9OlL9B8YIA1NAR8/p3219Mw
        bnfrYaponMbpbn11adCjttxNRFTtAcNwGrt932sst5sPbRKt+SngDdfd1e6CzmnXcYDdKf
        +BtdXI7waww8uQ+l6AS+e4l26DbguSg=
Received: from adam-pc.lan (unknown [10.163.16.38])
        by relay2.suse.de (Postfix) with ESMTP id 4376AA3BCE
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Jun 2021 13:00:36 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/9] btrfs: compression: refactor and enhancement preparing for subpage compression support
Date:   Fri, 11 Jun 2021 21:00:24 +0800
Message-Id: <20210611130033.329908-1-wqu@suse.com>
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

 fs/btrfs/compression.c | 585 +++++++++++++++++++++++------------------
 fs/btrfs/compression.h |  13 +-
 fs/btrfs/ctree.h       |   2 -
 fs/btrfs/inode.c       |  42 ---
 4 files changed, 345 insertions(+), 297 deletions(-)

-- 
2.32.0

