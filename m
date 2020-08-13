Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8AAE243B07
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Aug 2020 15:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgHMNxK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Aug 2020 09:53:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:41874 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbgHMNxK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Aug 2020 09:53:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 29C1DAFB2;
        Thu, 13 Aug 2020 13:53:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 43CDEDA6EF; Thu, 13 Aug 2020 15:52:05 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs updates for 5.9, part 2
Date:   Thu, 13 Aug 2020 15:52:05 +0200
Message-Id: <cover.1597326304.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

second batch with one minor update, the rest are fixes that have arrived
a bit late for the first batch. There are also some recent fixes for
bugs that were discovered during the merge window and pop up during
testing.

Please pull, thanks.

Fixes:

- fix compression messages when remounting with different level or
  compression algorithm

- tree-log: fix some memory leaks on error handling paths

- restore I_VERSION on remount

- fix return values and error code mixups

- fix umount crash with quotas enabled when removing sysfs files

- fix trim range on a shrunk device

User visible changes:

- show correct subvolume path in /proc/mounts for bind mounts

----------------------------------------------------------------
The following changes since commit 5e548b32018d96c377fda4bdac2bf511a448ca67:

  btrfs: do not set the full sync flag on the inode during page release (2020-07-27 12:55:48 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.9-tag

for you to fetch changes up to c57dd1f2f6a7cd1bb61802344f59ccdc5278c983:

  btrfs: trim: fix underflow in trim length to prevent access beyond device boundary (2020-08-12 10:15:58 +0200)

----------------------------------------------------------------
Boleyn Su (1):
      btrfs: check correct variable after allocation in btrfs_backref_iter_alloc

David Sterba (1):
      btrfs: fix messages after changing compression level by remount

Filipe Manana (1):
      btrfs: fix memory leaks after failure to lookup checksums during inode logging

Josef Bacik (3):
      btrfs: only search for left_info if there is no right_info in try_merge_free_space
      btrfs: don't show full path of bind mounts in subvol=
      btrfs: make sure SB_I_VERSION doesn't get unset by remount

Pavel Machek (1):
      btrfs: fix return value mixup in btrfs_get_extent

Qu Wenruo (3):
      btrfs: inode: fix NULL pointer dereference if inode doesn't need compression
      btrfs: sysfs: fix NULL pointer dereference at btrfs_sysfs_del_qgroups()
      btrfs: trim: fix underflow in trim length to prevent access beyond device boundary

 fs/btrfs/backref.c          |  2 +-
 fs/btrfs/extent-io-tree.h   |  2 ++
 fs/btrfs/extent-tree.c      | 14 ++++++++++++++
 fs/btrfs/free-space-cache.c |  4 ++--
 fs/btrfs/inode.c            | 18 ++++++++++++------
 fs/btrfs/super.c            | 30 +++++++++++++++++++++++-------
 fs/btrfs/sysfs.c            |  8 +++++---
 fs/btrfs/tree-log.c         |  8 ++------
 fs/btrfs/volumes.c          |  4 ++++
 9 files changed, 65 insertions(+), 25 deletions(-)
