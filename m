Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 623E51F88AA
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Jun 2020 13:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgFNL4Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 14 Jun 2020 07:56:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:58794 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgFNL4Q (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 14 Jun 2020 07:56:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 65DFFAB76;
        Sun, 14 Jun 2020 11:56:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7B00CDA7C3; Sun, 14 Jun 2020 13:56:06 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs updates for 5.8, part 2
Date:   Sun, 14 Jun 2020 13:56:05 +0200
Message-Id: <cover.1592135316.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

this reverts the direct io port to iomap infrastructure of btrfs merged
in the first pull request. We found problems in invalidate page that
don't seem to be fixable as regressions or without changing iomap code
that would not affect other filesystems.

There are 4 patches reverted in total, but 3 of them are followup
cleanups needed to revert a43a67a2d715540c13 cleanly. The result is the
buffer head based implementation of direct io.

There's one trivial conflict that git does not auto-resolve, in the
address space operations readpages has been replaced by readahead and
this change is in the context of the direct io callback diff.

Reverts are not great, but under current circumstances I don't see
better options. Please pull, thanks.

----------------------------------------------------------------
The following changes since commit 2166e5edce9ac1edf3b113d6091ef72fcac2d6c4:

  btrfs: fix space_info bytes_may_use underflow during space cache writeout (2020-05-28 14:01:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.8-part2-tag

for you to fetch changes up to 55e20bd12a56e06c38b953177bb162cbbaa96004:

  Revert "btrfs: switch to iomap_dio_rw() for dio" (2020-06-14 01:19:02 +0200)

----------------------------------------------------------------
David Sterba (4):
      Revert "btrfs: split btrfs_direct_IO to read and write part"
      Revert "btrfs: remove BTRFS_INODE_READDIO_NEED_LOCK"
      Revert "fs: remove dio_end_io()"
      Revert "btrfs: switch to iomap_dio_rw() for dio"

 fs/btrfs/Kconfig       |   1 -
 fs/btrfs/btrfs_inode.h |  18 +++
 fs/btrfs/ctree.h       |   4 -
 fs/btrfs/file.c        |  97 +------------
 fs/btrfs/inode.c       | 379 +++++++++++++++++++++++++++++++------------------
 fs/direct-io.c         |  19 +++
 include/linux/fs.h     |   2 +
 7 files changed, 286 insertions(+), 234 deletions(-)
