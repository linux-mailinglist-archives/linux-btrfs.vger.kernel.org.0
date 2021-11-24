Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A20145B76F
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Nov 2021 10:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235124AbhKXJeE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Nov 2021 04:34:04 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:32168 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234162AbhKXJeD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Nov 2021 04:34:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637746254; x=1669282254;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0Xwn6LfmkjbiJdhwkVgE8WDW5zxxouLUvRJoYfotULM=;
  b=KVZWXBu0LbR2noNUbzmyy9tfKxi+w1PGGwlOv/cbkguPPFzu9zLfQtXE
   Y/dpr+Ju2yFqQuF/+s1Ilzhv5SEx7nIstbu3+dnT65CNEyTIWKKA0UjuC
   iy41CdWcy+QXLu13MjBqec25vkw5hNSzXpECYmAmjd5PzryI9IgWSeqEA
   i1pwazcnLsgV5avRmy5gdf/l9ZqFvUq35YKAK314gXXl50fOHdsKRMbqa
   brvsckkGYcpXAp5vqKnqeEseTFCguFwlmODvJbWJOzf6+aWug5dae0wRI
   fCwmS8jD99N0lWRR+uKUGF0+qoIVVPfdpgeXtSUDfG2mtKCV2hbo3y3ui
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,260,1631548800"; 
   d="scan'208";a="185499344"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Nov 2021 17:30:53 +0800
IronPort-SDR: mP5xCAJ57PnLrGUaNyIhZzEWqWjox0fJoqXe/PWs/jIWRTZHve94WooS/u36V800suDS3NIe8Y
 8e21PYLsimG6fDbvJCnBz2wQu3YCowuuHvji00zWJEobl+hBqcj4pfT/EVcuq+EdxpdorbbLCE
 nFWUibDWswqq0KWMQ/quGPmA3pL9nIyc0fMEsHFd3RxiLQ2OYo161Xtg475Ew3/4s/XrIroEc2
 UzUW98PX3CbehAsk5pIt2e6hteY8AZHHfbEPynXqwpzG3eeKTLjAGXQ0X6tTwS6cfsUgACGXyc
 ACde/1Nohzb1fV+kVvO0kIeQ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 01:05:47 -0800
IronPort-SDR: GmpQ83Yn5IN6ynkjCDJzFCLm781qllyyAWCQneqtVtMxvPbi+6agcJGGIJ+R1IKjNVj9I/MtZI
 GLYs7CLJUyydxsJfSS9byh8iDqr9V/6bk49dDL9GBXwUPJzG3/HQjBFXNAp8b9X6ztJKr23+tF
 nicG7D5uZ4M7LQmf+MrSLdp1Paq3jSfndTrc7ZpT0hXPr5iLAap8nTTH49kG/CCocCaEBndtsm
 zENKYi278LwF4F+PhHrtZ4Ny3pEKzQu71wPAWCEIz4Gokb3MuGj6Wr6NWp01E4gG/6C0aduhzF
 pbg=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Nov 2021 01:30:53 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: [PATCH 00/21] btrfs: first batch of zoned cleanups
Date:   Wed, 24 Nov 2021 01:30:26 -0800
Message-Id: <cover.1637745470.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Here's a first batch of cleanups for the zoend code. It reduces the number of
calls to btrfs_is_zoned() outside of zoned.[ch] from 46 on misc-next to 33.

As I had to create a scrub.h file, I also moved the scrub related function
prototypes from ctree.h to scrub.h.

Johannes Thumshirn (21):
  btrfs: zoned: encapsulate inode locking for zoned relocation
  btrfs: zoned: simplify btrfs_check_meta_write_pointer
  btrfs: zoned: sink zone check into btrfs_repair_one_zone
  btrfs: zoned: it's pointless to check for REQ_OP_ZONE_APPEND and
    btrfs_is_zoned
  btrfs: zoned: move compatible fs flags check to zoned code
  btrfs: zoned: move mark_block_group_to_copy to zoned code
  btrfs: zoned: move btrfs_finish_block_group_to_copy to zoned code
  btrfs: zoned: move is_block_group_to_copy to zoned code
  btrfs: zoned: skip zoned check if block_group is marked as copy
  btrfs: move struct scrub_ctx to scrub.h
  btrfs: zoned: move fill_writer_pointer_gap to zoned code
  btrfs: zoned: sync_write_pointer_for_zoned to zoned code
  btrfs: make scrub_submit and scrub_wr_submit non-static
  btrfs: zoned: move sync_replace_for_zoned to zoned code
  btrfs: zoned: move finish_extent_writes_for_zoned to zoned code
  btrfs: move btrfs_scrub_dev() definition to scrub.h
  btrfs: move btrfs_scrub_pause() definition to scrub.h
  btrfs: move btrfs_scrub_continue() definition to scrub.h
  btrfs: move btrfs_scrub_cancel() definition to scrub.h
  btrfs: move btrfs_scrub_cancel_dev() definition to scrub.h
  btrfs: move btrfs_scrub_progress() definition to scrub.h

 fs/btrfs/ctree.h       |  10 --
 fs/btrfs/dev-replace.c | 182 +-----------------------
 fs/btrfs/dev-replace.h |   3 -
 fs/btrfs/disk-io.c     |   1 +
 fs/btrfs/extent_io.c   |  16 +--
 fs/btrfs/ioctl.c       |  13 +-
 fs/btrfs/scrub.c       | 187 +++++--------------------
 fs/btrfs/scrub.h       |  62 +++++++++
 fs/btrfs/super.c       |   1 +
 fs/btrfs/transaction.c |   1 +
 fs/btrfs/volumes.c     |  36 ++---
 fs/btrfs/volumes.h     |   2 +-
 fs/btrfs/zoned.c       | 306 ++++++++++++++++++++++++++++++++++++++---
 fs/btrfs/zoned.h       |  77 +++++++++++
 14 files changed, 483 insertions(+), 414 deletions(-)
 create mode 100644 fs/btrfs/scrub.h

-- 
2.31.1

