Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17BFB2EBD51
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Jan 2021 12:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbhAFLuq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Jan 2021 06:50:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:42608 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbhAFLup (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 6 Jan 2021 06:50:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1609933803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=U0fXng+c84ua+0GSFcF+SPPfc+58H4aOX56G4MdyPS0=;
        b=r+ku0bhZ5ww4o7ZI9fx6GXpmQVTGnZ0H+kTxpZHuFwXmE0NemaFJ5c3WlUFj5UemJOz0Cp
        T4Sg8IFapTeru+r6sEIuVTSQRw3ly6IgvkGF7F6c7vpBlpEYIa9h3MNru03QlC+I+tccCY
        qk7T9CJR07skiMNMk+B8rQUdMEpZSM0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 782B5AD1E;
        Wed,  6 Jan 2021 11:50:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1B744DA6E9; Wed,  6 Jan 2021 12:48:14 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 5.11-rc3
Date:   Wed,  6 Jan 2021 12:48:12 +0100
Message-Id: <cover.1609855176.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

a few more fixes that arrived before the end of the year.  Please pull,
thanks.

- a bunch of fixes related to transaction handle lifetime wrt various
  operations (umount, remount, qgroup scan, orphan cleanup)

- async discard scheduling fixes

- fix item size calculation when item keys collide for extend refs
  (hardlinks)

- fix qgroup flushing from running transaction

- fix send, wrong file path when there is an inode with a pending rmdir

- fix deadlock when cloning inline extent and low on free metadata space

----------------------------------------------------------------
The following changes since commit b42fe98c92698d2a10094997e5f4d2dd968fd44f:

  btrfs: scrub: allow scrub to work with subpage sectorsize (2020-12-09 19:16:11 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.11-rc2-tag

for you to fetch changes up to a8cc263eb58ca133617662a5a5e07131d0ebf299:

  btrfs: run delayed iputs when remounting RO to avoid leaking them (2020-12-18 15:00:08 +0100)

----------------------------------------------------------------
Filipe Manana (7):
      btrfs: fix deadlock when cloning inline extent and low on free metadata space
      btrfs: send: fix wrong file path when there is an inode with a pending rmdir
      btrfs: fix transaction leak and crash after RO remount caused by qgroup rescan
      btrfs: fix transaction leak and crash after cleaning up orphans on RO mount
      btrfs: fix race between RO remount and the cleaner task
      btrfs: add assertion for empty list of transactions at late stage of umount
      btrfs: run delayed iputs when remounting RO to avoid leaking them

Josef Bacik (1):
      btrfs: tests: initialize test inodes location

Pavel Begunkov (3):
      btrfs: fix async discard stall
      btrfs: fix racy access to discard_ctl data
      btrfs: merge critical sections of discard lock in workfn

Qu Wenruo (1):
      btrfs: qgroup: don't try to wait flushing if we're already holding a transaction

ethanwu (1):
      btrfs: correctly calculate item size used when item key collision happens

 fs/btrfs/btrfs_inode.h       |  9 ++++++
 fs/btrfs/ctree.c             | 24 +++++++++++++--
 fs/btrfs/ctree.h             | 29 ++++++++++++++++--
 fs/btrfs/dev-replace.c       |  2 +-
 fs/btrfs/discard.c           | 70 +++++++++++++++++++++++---------------------
 fs/btrfs/disk-io.c           | 13 ++++----
 fs/btrfs/extent-tree.c       |  2 ++
 fs/btrfs/file-item.c         |  2 ++
 fs/btrfs/inode.c             | 15 +++++++---
 fs/btrfs/ioctl.c             |  2 +-
 fs/btrfs/qgroup.c            | 43 +++++++++++++++++++--------
 fs/btrfs/reflink.c           | 15 ++++++++++
 fs/btrfs/send.c              | 49 +++++++++++++++++++------------
 fs/btrfs/space-info.c        |  2 +-
 fs/btrfs/super.c             | 40 +++++++++++++++++++++++--
 fs/btrfs/tests/btrfs-tests.c | 10 +++++--
 fs/btrfs/tests/inode-tests.c |  9 ------
 fs/btrfs/volumes.c           |  4 +--
 18 files changed, 243 insertions(+), 97 deletions(-)
