Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B36B032EF79
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Mar 2021 16:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbhCEP5m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Mar 2021 10:57:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:37384 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229493AbhCEP5R (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Mar 2021 10:57:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614959836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZAnSSRKge8CGgRvv2YLRiVtc08HTPhe6n18APsSGUbY=;
        b=HX3Qksmzf2Q8srPPs0FLbpS/eVzupFGGhfvemMNEiqqTiFDavIbM9KW3C+gHbWninFS8wS
        JeacavLDx9DgtgXYG42ZC17DvXpYm4ZcnXMJAbJCjEXsiMyFgAx1y5Y9C4nln5DQVjy30i
        itbIrAVxluamBBpsubkYLKNIcRDCBoU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6572EACBF;
        Fri,  5 Mar 2021 15:57:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E6DA7DA79B; Fri,  5 Mar 2021 16:55:19 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 5.12-rc1, part 2
Date:   Fri,  5 Mar 2021 16:55:17 +0100
Message-Id: <cover.1614954547.git.dsterba@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: David Sterba <dsterba@suse.cz>

Hi,

more regression fixes and stabilization. Please pull, thanks.

Regressions:

- zoned mode
  - count zone sizes in wider int types
  - fix space accounting for read-only block groups

- subpage: fix page tail zeroing

Fixes:

- fix spurious warning when remounting with free space tree

- fix warning when creating a directory with smack enabled

- ioctl checks for qgroup inheritance when creating a snapshot

- qgroup
  - fix missing unlock on error path in zero range
  - fix amount of released reservation on error
  - fix flushing from unsafe context with open transaction, potentially
    deadlocking

- minor build warning fixes

----------------------------------------------------------------
The following changes since commit 6e37d245994189ba757df7dc2950a44d31421ac6:

  btrfs: zoned: fix deadlock on log sync (2021-02-22 18:08:48 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.12-rc1-tag

for you to fetch changes up to badae9c86979c459bd7d895d6d7ddc7a01131ff7:

  btrfs: zoned: do not account freed region of read-only block group as zone_unusable (2021-03-04 16:16:58 +0100)

----------------------------------------------------------------
Boris Burkov (1):
      btrfs: fix spurious free_space_tree remount warning

Dan Carpenter (1):
      btrfs: validate qgroup inherit for SNAP_CREATE_V2 ioctl

Filipe Manana (1):
      btrfs: fix warning when creating a directory with smack enabled

Naohiro Aota (2):
      btrfs: zoned: use sector_t for zone sectors
      btrfs: zoned: do not account freed region of read-only block group as zone_unusable

Nikolay Borisov (4):
      btrfs: unlock extents in btrfs_zero_range in case of quota reservation errors
      btrfs: free correct amount of space in btrfs_delayed_inode_reserve_metadata
      btrfs: export and rename qgroup_reserve_meta
      btrfs: don't flush from btrfs_delayed_inode_reserve_metadata

Qu Wenruo (1):
      btrfs: subpage: fix the false data csum mismatch error

Randy Dunlap (1):
      btrfs: ref-verify: use 'inline void' keyword ordering

 fs/btrfs/delayed-inode.c    |  5 +++--
 fs/btrfs/extent_io.c        | 21 ++++++++++++++++-----
 fs/btrfs/file.c             |  5 ++++-
 fs/btrfs/free-space-cache.c |  7 ++++++-
 fs/btrfs/inode.c            |  2 +-
 fs/btrfs/ioctl.c            | 19 ++++++++++++++++++-
 fs/btrfs/qgroup.c           |  8 ++++----
 fs/btrfs/qgroup.h           |  2 ++
 fs/btrfs/ref-verify.c       |  4 ++--
 fs/btrfs/super.c            |  4 ++--
 fs/btrfs/xattr.c            | 31 +++++++++++++++++++++++++++----
 fs/btrfs/zoned.c            |  4 ++--
 12 files changed, 87 insertions(+), 25 deletions(-)
