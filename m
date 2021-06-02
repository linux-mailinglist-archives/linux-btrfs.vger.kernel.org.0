Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1D7397EA6
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jun 2021 04:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhFBCRT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Jun 2021 22:17:19 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:49078 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhFBCRR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Jun 2021 22:17:17 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id F3C991FD2D
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Jun 2021 02:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622600132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Kos2f4RM8bQNR8tbjDsBxHI/M2zpQNcxLu2Sdhf/0rE=;
        b=XLRdPpoaE7Ez3ohiKIy27NWvQh0zDmWW5xo5I2Jd5X0puvY03PBHCbDohcHAA0malxoQUi
        m6flBHEK4y5bvx7eKLwqmU2JrqMZuozZyxwX5UqYjWDPN+0AjpueQ0tO6IuLudnmDX4O06
        IGXyxRzYawt72tvUlXQwHRh8YuPM2xo=
Received: from adam-pc.lan (unknown [10.163.16.38])
        by relay2.suse.de (Postfix) with ESMTP id F38DBA3B83
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Jun 2021 02:15:30 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 00/10] btrfs: defrag: rework to support sector perfect defrag
Date:   Wed,  2 Jun 2021 10:15:18 +0800
Message-Id: <20210602021528.68617-1-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This branch is based on subpage RW branch, as the last patch needs to
enable defrag support for subpage cases.

But despite that one, all patches should be able to be applied on
current misc-next.

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
 fs/btrfs/ioctl.c | 896 ++++++++++++++++++++++-------------------------
 2 files changed, 418 insertions(+), 482 deletions(-)

-- 
2.31.1

