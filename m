Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A2739EC78
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jun 2021 04:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhFHDBY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Jun 2021 23:01:24 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41338 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbhFHDBY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Jun 2021 23:01:24 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 36541219C1
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Jun 2021 02:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623121171; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=f5G4W/SiPvWpMcr/3zluYPxmOrihUn//T1BBKz2R3rM=;
        b=ux9NrlS7iXiIHbbZaFz1jt1P27MB55JsW9Th3i422qhDG9F/6yNWOX1WhgC7jS5bvuAd+q
        EGoclIJn6Dee79uAR1VpbqH2x6GLXCDkgC2asu16TwH937py9Irq8qDqIiKFEAz+6CqV9Q
        4nU9cPkqsFVvfFUBTGqgkcOCGOR96+0=
Received: from adam-pc.lan (unknown [10.163.16.38])
        by relay2.suse.de (Postfix) with ESMTP id 24BD3A3B83
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Jun 2021 02:59:29 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 00/10]  btrfs: defrag: rework to support sector perfect defrag
Date:   Tue,  8 Jun 2021 10:59:17 +0800
Message-Id: <20210608025927.119169-1-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This branch is based on subpage RW branch, as the last patch needs to
enable defrag support for subpage cases.

But despite that one, all other patches can be applied on current
misc-next.

[BACKGROUND]
In subpage rw branch, we disable defrag completely due to the fact that
current code can only work on page basis.

This could lead to problems like btrfs/062 crash.

Thus this patchset will make defrag to work on both regular and subpage
sectorsize.

[SOLUTION]
To defrag a file range, what we do is pretty much like buffered write,
except we don't really write any new data to page cache, but just mark
the range dirty.

Then let later writeback to merge the range into a larger extent.

But current defrag code is working on per-page basis, not per-sector,
thus we have to refactor it a little to make it to work properly for
subpage.

This patch will separate the code into 3 layers:
Layer 0:	btrfs_defrag_file()
		The defrag entrace
		Just do proper inode lock and split the file into
		page aligned 256K clusters to defrag

Layer 1:	defrag_one_cluster()
		Will collect the initial targets file extents, and pass
		each continuous target to defrag_one_range()

Layer 2:	defrag_one_range()
		Will prepare the needed page and extent locking.
		Then re-check the range for real target list, as initial
		target list is not consistent as it doesn't hage
		page/extent locking to prevent hole punching.

Layer 3:	defrag_one_locked_target()
		The real work, to make the extent range defrag and
		update involved page status

[BEHAVIOR CHANGE]
In the refactor, there is one behavior change:

- Defraged sector counter is based on the initial target list
  This is mostly to avoid the paremters to be passed too deep into
  defrag_one_locked_target().
  Considering the accounting is not that important, we can afford some
  difference.

[PATCH STRUTURE]
Patch 01~03:	Small independent refactor to improve readability
Patch 04~08:	Implement the more readable and subpage friendly defrag
Patch 09:	Cleanup of old infrastruture
Patch 10:	Enable defrag for subpage case

Now both regular sectorsize and subpage sectorsize can pass defrag test
group.

[CHANGELOG]
v2:
- Make sure we won't defrag hole
  This is done by re-collect the target list after have page and extent
  locked. So that we can have a consistent view of the extent map.

- Add a new layer to avoid variable naming bugs
  Since we need to handle real target list inside defrag_one_range(),
  and that function has parameters like "start" and "len", while inside
  the loop we need things like "entry->start" and "entry->len", it has
  already caused hard to debug bugs during development.

  Thus introduce a new layer, defrag_one_ragen() to prepare pages/extent
  lock then pass the entry to defrag_one_locked_target().

v3:
- Fix extent_state leak
  Now we pass the @cached_state to defrag_one_locked_target() other
  than allowing it to allocate a new one.

  This can be reproduced by enabling "TEST_FS_MODULE_RELOAD" environment
  variable for fstests and run "-g defrag" group.

- Fix a random hang in test cases like btrfs/062
  Since defrag_one_range() will lock the extent range first, then
  call defrag_collect_targets(), which will in turn call
  defrag_lookup_extent() and lock extent range again.

  This will cause a dead lock, and this only happens when the
  extent range is smaller than the original locked range.
  Thus sometimes the test can pass, but sometimes it can hang.

  Fix it by teaching defrag_collect_targets() and defrag_lookup_extent()
  to skip extent lock for certain call sites.
  Thus this needs some loops for btrfs/062.
  The hang possibility is around 1/2 ~ 1/3 when run in a loop.

Qu Wenruo (10):
  btrfs: defrag: pass file_ra_state instead of file for
    btrfs_defrag_file()
  btrfs: defrag: extract the page preparation code into one helper
  btrfs: defrag: replace hard coded PAGE_SIZE to sectorsize for
    defrag_lookup_extent()
  btrfs: defrag: introduce a new helper to collect target file extents
  btrfs: defrag: introduce a helper to defrag a continuous prepared
    range
  btrfs: defrag: introduce a helper to defrag a range
  btrfs: defrag: introduce a new helper to defrag one cluster
  btrfs: defrag: use defrag_one_cluster() to implement
    btrfs_defrag_file()
  btrfs: defrag: remove the old infrastructure
  btrfs: defrag: enable defrag for subpage case

 fs/btrfs/ctree.h |   4 +-
 fs/btrfs/ioctl.c | 921 ++++++++++++++++++++++-------------------------
 2 files changed, 432 insertions(+), 493 deletions(-)

-- 
2.31.1

