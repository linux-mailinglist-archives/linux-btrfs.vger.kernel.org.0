Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E643FBDDDA
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2019 14:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405458AbfIYMOC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Sep 2019 08:14:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:59682 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405177AbfIYMOC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Sep 2019 08:14:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B2DECB626
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Sep 2019 12:14:00 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 00/10] btrfs-progs: image: Enhancement with new data dump feature
Date:   Wed, 25 Sep 2019 20:13:46 +0800
Message-Id: <20190925121356.118038-1-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patchset includes the following features:

- Small fixes to improve btrfs-image error report
  * Output error message for chunk tree build error
  * Fix error output to show correct return value
  Patch 1 and 2.

- Reduce memory usage when decompress super block
  Independent change, for current btrfs-image, it will reduce buffer
  size from 256K to fixed 4K.
  Patch 3.

- Rework how we search chunk tree blocks
  Instead of iterating clusters again and again for each chunk tree
  block, record system chunk array and iterate clusters once for all
  chunk tree blocks.
  This should reduce restore time for large image dump.
  Patch 4, 5 and 6.

- Introduce data dump feature to dump the whole fs.
  This will introduce a new magic number to prevent old btrfs-image to
  hit failure as the item size limit is enlarged.
  Patch 7 and 8.

- Reduce memory usage for data dump restore
  This is mostly due to the fact that we have much larger
  max_pending_size introduced by data dump(256K -> 256M).
  Using 4 * max_pending_size for each decompress thread as buffer is way
  too expensive now.
  Use proper inflate() to replace uncompress() calls.
  Patch 9 and 10.

Changelog:
v2:
- New small fixes:
  * Fix a confusing error message due to unpopulated errno
  * Output error message for chunk tree build error
  
- Fix a regression of previous version
  Patch "btrfs-progs: image: Rework how we search chunk tree blocks"
  deleted a "ret = 0" line which could cause false early exit.

- Reduce memory usage for data dump

v2.1:
- Rebased to devel branch
  Removing 4 already merged patches from the patchset.

- Re-order the patchset
  Put small and independent patches at the top of queue, and put the
  data dump related feature at the end.

- Fix -Wmaybe-uninitialized warnings
  Strangely, D=1 won't trigger these warnings thus they sneak into v2
  without being detected.

- Fix FROM: line
  Reverted to old smtp setup. The new setup will override FROM: line,
  messing up the name of author.

v3:
- Fix a wrong option in error string
- Fix a bug that we always dump data extents

Qu Wenruo (10):
  btrfs-progs: image: Output error message for chunk tree build error
  btrfs-progs: image: Fix error output to show correct return value
  btrfs-progs: image: Don't waste memory when we're just extracting
    super block
  btrfs-progs: image: Allow restore to record system chunk ranges for
    later usage
  btrfs-progs: image: Introduce helper to determine if a tree block is
    in the range of system chunks
  btrfs-progs: image: Rework how we search chunk tree blocks
  btrfs-progs: image: Introduce framework for more dump versions
  btrfs-progs: image: Introduce -d option to dump data
  btrfs-progs: image: Reduce memory requirement for decompression
  btrfs-progs: image: Reduce memory usage for chunk tree search

 image/main.c     | 866 +++++++++++++++++++++++++++++++++++------------
 image/metadump.h |  13 +-
 2 files changed, 654 insertions(+), 225 deletions(-)

-- 
2.23.0

