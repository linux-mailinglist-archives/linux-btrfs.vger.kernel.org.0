Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C89633A3944
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jun 2021 03:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhFKBdQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Jun 2021 21:33:16 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60736 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbhFKBdP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Jun 2021 21:33:15 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0B73F21992
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Jun 2021 01:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623375078; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=rEbfwIRkrxsjQjMQ2uHG481YlQknwv/bxTCp36fwCOw=;
        b=c4XbwFN0ojoPw5OYhUhaIKYNiq8Avxuunmf84XSFUC2DQBN1Gj/RTgcoJC6RPX0EPhBzff
        pAq3U8e7/942vanw2RdX3QVwRHesUZRsownRpEuPQiwOC0f8Hj6myZ/Oqh2AXfpIiSYr/X
        SFNk5J1V1jwnuLeLgiSPph8zL0G/irs=
Received: from adam-pc.lan (unknown [10.163.16.38])
        by relay2.suse.de (Postfix) with ESMTP id 132A7A3B84
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Jun 2021 01:31:16 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/9] btrfs: compression: refactor and enhancement preparing for subpage compression support
Date:   Fri, 11 Jun 2021 09:31:05 +0800
Message-Id: <20210611013114.57264-1-wqu@suse.com>
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

Qu Wenruo (9):
  btrfs: remove a dead comment for btrfs_decompress_bio()
  btrfs: add compressed_bio::io_sectors to trace compressed bio more
    elegantly
  btrfs: hunt down the BUG_ON()s inside btrfs_submit_compressed_read()
  btrfs: hunt down the BUG_ON()s inside btrfs_submit_compressed_write()
  btrfs: introduce submit_compressed_bio() for compression
  btrfs: introduce alloc_submit_compressed_bio() for compression
  btrfs: make btrfs_submit_compressed_read() to determine stripe
    boundary at bio allocation time
  btrfs: make btrfs_submit_compressed_read() to determine stripe
    boundary at bio allocation time
  btrfs: remove unused function btrfs_bio_fits_in_stripe()

 fs/btrfs/compression.c | 591 +++++++++++++++++++++++++----------------
 fs/btrfs/compression.h |  13 +-
 fs/btrfs/ctree.h       |   2 -
 fs/btrfs/inode.c       |  42 ---
 4 files changed, 369 insertions(+), 279 deletions(-)

-- 
2.32.0

