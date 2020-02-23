Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADB11697DE
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Feb 2020 14:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgBWNgv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Feb 2020 08:36:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:53548 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbgBWNgv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Feb 2020 08:36:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 760FAABF4;
        Sun, 23 Feb 2020 13:36:49 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E9EF4DA70E; Sun, 23 Feb 2020 14:36:30 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 5.6-rc3
Date:   Sun, 23 Feb 2020 14:36:29 +0100
Message-Id: <cover.1582462302.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

there are fixes that were found during testing with help of error
injection, plus some other stable material.

There's a fixup to patch added to rc1 causing locking in wrong context
warnings, tests found one more deadlock scenario. The patches are tagged
for stable, two of them now in the queue but we'd like all three
released at the same time.

I'm not happy about fixes to fixes in such a fast succession namely during
rcs, but I hope we found all the fallouts of 28553fa992cb28be. As the
other fixes are not urgent I'm also fine with delaying the pull until
rc4 and coordinating with stable@.

Thanks.

----------------------------------------------------------------
The following changes since commit 52e29e331070cd7d52a64cbf1b0958212a340e28:

  btrfs: don't set path->leave_spinning for truncate (2020-02-17 16:23:06 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.6-rc2-tag

for you to fetch changes up to a5ae50dea9111db63d30d700766dd5509602f7ad:

  Btrfs: fix deadlock during fast fsync when logging prealloc extents beyond eof (2020-02-21 16:21:19 +0100)

----------------------------------------------------------------
Filipe Manana (2):
      Btrfs: fix btrfs_wait_ordered_range() so that it waits for all ordered extents
      Btrfs: fix deadlock during fast fsync when logging prealloc extents beyond eof

Jeff Mahoney (1):
      btrfs: destroy qgroup extent records on transaction abort

Josef Bacik (4):
      btrfs: reset fs_root to NULL on error in open_ctree
      btrfs: do not check delayed items are empty for single transaction cleanup
      btrfs: handle logged extent failure properly
      btrfs: fix bytes_may_use underflow in prealloc error condtition

 fs/btrfs/disk-io.c      |  3 ++-
 fs/btrfs/extent-tree.c  |  2 ++
 fs/btrfs/inode.c        | 26 ++++++++++++++++++--------
 fs/btrfs/ordered-data.c |  7 ++++++-
 fs/btrfs/qgroup.c       | 13 +++++++++++++
 fs/btrfs/qgroup.h       |  1 +
 fs/btrfs/transaction.c  |  2 ++
 7 files changed, 44 insertions(+), 10 deletions(-)
