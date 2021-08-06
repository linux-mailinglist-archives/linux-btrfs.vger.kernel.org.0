Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 198583E24CA
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Aug 2021 10:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243401AbhHFINE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Aug 2021 04:13:04 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49860 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbhHFINC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Aug 2021 04:13:02 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E199D2239B
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Aug 2021 08:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628237565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=0AO6CWjPjzJIp6aOc2R97gDgKRXf+SyNT37NhiSIpus=;
        b=bQorndk1b3cXroJFt7SkgbA6PYI4jzpkwtw8mvCQjgfJo8cXM8aPEaQFKazOrjvljwmnU9
        lAh9zuykDFRDoZnzKnpnvtKW+zlVpaeSNI6xGf2jj5l7koXwTGl9z/+0t31+ypVALyTmna
        Zm4GAjfPVPqJ65VB+tbGEFXUxzRPffA=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 247C31399D
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Aug 2021 08:12:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id o6RYNfzuDGF6IQAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Aug 2021 08:12:44 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v5 00/11] btrfs: defrag: rework to support sector perfect defrag
Date:   Fri,  6 Aug 2021 16:12:31 +0800
Message-Id: <20210806081242.257996-1-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This branch is based on David's misc-next branch, which already has the
subpage read-write support included.

[BACKGROUND]
In current misc-next branch, we disable defrag completely due to the fact
that current code can only work on page basis.

Without proper subpage defrag support, it could lead to problems like
btrfs/062 crash.

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
		The defrag entrance.
		Just do proper inode lock and split the file into
		page aligned 256K clusters to defrag.

Layer 1:	defrag_one_cluster()
		Will collect the initial targets file extents, and pass
		each continuous target to defrag_one_range().

Layer 2:	defrag_one_range()
		Will prepare the needed page and extent locking.
		Then re-check the range for real target list, as initial
		target list is not consistent as it doesn't hage
		page/extent locking to prevent hole punching.

Layer 3:	defrag_one_locked_target()
		The real work, to make the extent range defrag and
		update involved page status.

[BEHAVIOR CHANGE]
In the refactor, there is one behavior change:

- Defraged sector counter is based on the initial target list
  This is mostly to avoid the parameters to be passed too deep into
  defrag_one_locked_target().
  Considering the accounting is not that important, we can afford some
  difference.

[PATCH STRUCTURE]
Patch 01~04:	Small independent refactor to improve readability
Patch 05~09:	Implement the more readable and subpage friendly defrag
Patch 10:	Cleanup of old infrastructure 
Patch 11:	Enable defrag for subpage case

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

v4:
- Fix a callsite which can cause hang due to extent locking
  The call site is defrag_lookup_extent() in defrag_collect_tagets(),
  which has one call site called with extent lock hold.
  Thus it also need to pass the @locked parameter

- Fix a typo
  "defraged" -> "defragged"

v5:
- Fix the btrfs/072 test failure
  Now btrfs/072 no longer reports inode nbytes mismatch error

- Add one patch to make cluster_pages_for_defrag() to be subpage
  compatible

- Move the page writeback wait out of the page preparation loop
  To keep the same old behavior.

- Use pgoff_t for page index

Qu Wenruo (11):
  btrfs: defrag: pass file_ra_state instead of file for
    btrfs_defrag_file()
  btrfs: defrag: also check PagePrivate for subpage cases in
    cluster_pages_for_defrag()
  btrfs: defrag: replace hard coded PAGE_SIZE to sectorsize
  btrfs: defrag: extract the page preparation code into one helper
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
 fs/btrfs/ioctl.c | 911 ++++++++++++++++++++++-------------------------
 2 files changed, 429 insertions(+), 486 deletions(-)

-- 
2.32.0

