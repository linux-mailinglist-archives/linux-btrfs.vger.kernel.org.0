Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3F13AC4E8
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jun 2021 09:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbhFRH0y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Jun 2021 03:26:54 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48270 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhFRH0y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Jun 2021 03:26:54 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6783C1FD8F
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Jun 2021 07:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624001084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=hMvagMFVD0GdqohxUmkv65yoiE6wELvje0AEGP0EgIs=;
        b=a3K8MciYmndZZidxXo4eQXr+fsCpFuAduDfRfKBqyTIyFvZ+vgHVNOTRwOjjhdjB+EulIx
        5RP09tcGyvQeP/l7bVLYCFtkQR7BNenR3E4q61cd3GMFPv16umQaWdf9nmK/1DvH0ZwSa6
        k6TtRmseMXHHpGBTA2DPaRh5S31Erlk=
Received: from adam-pc.lan (unknown [10.163.16.38])
        by relay2.suse.de (Postfix) with ESMTP id 5B712A3B9E
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Jun 2021 07:24:40 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v5 00/11] btrfs: add data write support for subpage
Date:   Fri, 18 Jun 2021 15:24:26 +0800
Message-Id: <20210618072437.207550-1-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This much smaller patchset can be fetched from github:
https://github.com/adam900710/linux/tree/subpage

Thanks for the hard work from David, now there are only 11 patches left.

And thanks him again for fixing up the small typos and style problem in
my old patches. Almost no patch is no untouched, really appreciate the
effort.

=== Current stage ===
The tests on x86 pass without new failure, and generic test group on
arm64 with 64K page size passes except known failure and defrag group.

For btrfs test group, all pass except compression/raid56/defrag.

For anyone who is interested in testing, please use btrfs-progs v5.12 to
avoid false alert at mkfs time.

=== Limitation ===
There are several limitations introduced just for subpage:
- No compressed write support
  Read is no problem, but compression write path has more things left to
  be modified.

  I'm already working on that, the status is:
  * Split compressed bio submission
    Patchset submitted, since it's also cleaning up several BUG_ON()s, it
    has a better chance to get merged.
    But I'm not in a hurry to push this part into v5.14, especially
    not before the initial subpage enablement.

  * Fix up extent_clear_unlock_delalloc() to avoid use subpage unlock
    for pages not locked by subpage helpers
    WIP

  * Testing

- No inline extent will be created
  This is mostly due to the fact that filemap_fdatawrite_range() will
  trigger more write than the range specified.
  In fallocate calls, this behavior can make us to writeback which can
  be inlined, before we enlarge the isize, causing inline extent being
  created along with regular extents.

  In fact, even on x86_64, we can still have fsstress to create inodes
  with mixed inline and regular extents.
  Thus there is a much bigger problem to address.

- No support for RAID56
  There are still too many hardcoded PAGE_SIZE in raid56 code.
  Considering it's already considered unsafe due to its write-hole
  problem, disabling RAID56 for subpage looks sane to me.

- No defrag support for subpage
  The support for subpage defrag has already an initial version
  submitted to the mail list.
  Thus the correct support won't be included in this patchset.

  Currently I'm not pushing defrag patchset, as it's really not
  the priority, and still has rare bugs related to EXTENT_DELALLOC_NEW
  extent bit.

=== Patchset structure ===
Patch 01~02:	Support for subpage relocation
Patch 03~10:	Subpage specific fixes and extra limitations
Patch 11:	Enable subpage support

=== Changelog ===
v2:
- Rebased to latest misc-next
  Now metadata write patches are removed from the series, as they are
  already merged into misc-next.

- Added new Reviewed-by/Tested-by/Reported-by tags

- Use separate endio functions to subpage metadata write path

- Re-order the patches, to make refactors at the top of the series
  One refactor, the submit_extent_page() one, should benefit 4K page
  size more than 64K page size, thus it's worthy to be merged early

- New bug fixes exposed by Ritesh Harjani on Power

- Reject RAID56 completely
  Exposed by btrfs test group, which caused BUG_ON() for various sites.
  Considering RAID56 is already not considered safe, it's better to
  reject them completely for now.

- Fix subpage scrub repair failure
  Caused by hardcoded PAGE_SIZE

- Fix free space cache inode size
  Same cause as scrub repair failure

v3:
- Rebased to remove write path prepration patches

- Properly enable btrfs defrag
  Previsouly, btrfs defrag is in fact just disabled.
  This makes tons of tests in btrfs/defrag to fail.

- More bug fixes for rare race/crashes
  * Fix relocation false alert on csum mismatch
  * Fix relocation data corruption
  * Fix a rare case of false ASSERT()
    The fix already get merged into the prepration patches, thus no
    longer in this patchset though.
  
  Mostly reported by Ritesh from IBM.

v4:
- Disable subpage defrag completely
  As full page defrag can race with fsstress in btrfs/062, causing
  strange ordered extent bugs.
  The full subpage defrag will be submitted as an indepdent patchset.

v5:
- Rebased to latest misc-next branch


Qu Wenruo (11):
  btrfs: extract relocation page read and dirty part into its own
    function
  btrfs: make relocate_one_page() to handle subpage case
  btrfs: fix wild subpage writeback which does not have ordered extent.
  btrfs: disable inline extent creation for subpage
  btrfs: allow submit_extent_page() to do bio split for subpage
  btrfs: reject raid5/6 fs for subpage
  btrfs: fix a crash caused by race between prepare_pages() and
    btrfs_releasepage()
  btrfs: fix a use-after-free bug in writeback subpage helper
  btrfs: fix a subpage false alert for relocating partial preallocated
    data extents
  btrfs: fix a subpage relocation data corruption
  btrfs: allow read-write for 4K sectorsize on 64K page size systems

 fs/btrfs/disk-io.c    |  13 +-
 fs/btrfs/extent_io.c  | 209 ++++++++++++++++++++--------
 fs/btrfs/file.c       |  13 +-
 fs/btrfs/inode.c      |  78 +++++++++--
 fs/btrfs/ioctl.c      |   6 +
 fs/btrfs/relocation.c | 308 ++++++++++++++++++++++++++++--------------
 fs/btrfs/subpage.c    |  20 ++-
 fs/btrfs/subpage.h    |   7 +
 fs/btrfs/super.c      |   7 -
 fs/btrfs/sysfs.c      |   5 +
 fs/btrfs/volumes.c    |   8 ++
 11 files changed, 488 insertions(+), 186 deletions(-)

-- 
2.32.0

