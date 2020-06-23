Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C77932053EF
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jun 2020 15:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732879AbgFWNyB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Jun 2020 09:54:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:39418 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732877AbgFWNyA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Jun 2020 09:54:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 99282AD66;
        Tue, 23 Jun 2020 13:53:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2395FDA79B; Tue, 23 Jun 2020 15:53:47 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 5.8-rc3
Date:   Tue, 23 Jun 2020 15:53:45 +0200
Message-Id: <cover.1592918083.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

a number of fixes, located in two areas, one performance fix and one
fixup for better integration with another patchset.

Please pull, thanks.

- bug fixes in nowait aio:
  - fix snapshot creation hang after nowait-aio was used
  - fix failure to write to prealloc extent past EOF
  - don't block when extent range is locked

- block group fixes:
  - relocation failure when scrub runs in parallel
  - refcount fix when removing fails
  - fix race between removal and creation
  - space accounting fixes

- reinstante fast path check for log tree at unlink time, fixes
  performance drop up to 30% in REAIM

- kzfree/kfree fixup to ease treewide patchset renaming kzfree

----------------------------------------------------------------
The following changes since commit 55e20bd12a56e06c38b953177bb162cbbaa96004:

  Revert "btrfs: switch to iomap_dio_rw() for dio" (2020-06-14 01:19:02 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.8-rc2-tag

for you to fetch changes up to b091f7fede97cc64f7aaad3eeb37965aebee3082:

  btrfs: use kfree() in btrfs_ioctl_get_subvol_info() (2020-06-16 19:24:03 +0200)

----------------------------------------------------------------
Filipe Manana (9):
      btrfs: fix a block group ref counter leak after failure to remove block group
      btrfs: fix race between block group removal and block group creation
      btrfs: fix data block group relocation failure due to concurrent scrub
      btrfs: fix bytes_may_use underflow when running balance and scrub in parallel
      btrfs: check if a log root exists before locking the log_mutex on unlink
      btrfs: fix hang on snapshot creation after RWF_NOWAIT write
      btrfs: fix failure of RWF_NOWAIT write into prealloc extent beyond eof
      btrfs: fix RWF_NOWAIT write not failling when we need to cow
      btrfs: fix RWF_NOWAIT writes blocking on extent locks and waiting for IO

Waiman Long (1):
      btrfs: use kfree() in btrfs_ioctl_get_subvol_info()

 fs/btrfs/block-group.c | 44 +++++++++++++++++++++++++++-----------------
 fs/btrfs/ctree.h       |  2 ++
 fs/btrfs/file.c        | 46 +++++++++++++++++++++++++++++++++++++---------
 fs/btrfs/inode.c       | 39 ++++++++++++++++++++++++++++++---------
 fs/btrfs/ioctl.c       |  2 +-
 fs/btrfs/tree-log.c    |  5 +++++
 6 files changed, 102 insertions(+), 36 deletions(-)
