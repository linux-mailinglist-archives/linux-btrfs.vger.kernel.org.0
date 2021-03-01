Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A63327FE2
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Mar 2021 14:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235871AbhCANqz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Mar 2021 08:46:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:45008 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235866AbhCANqx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Mar 2021 08:46:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614606371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=N2seae7zAZtgooEhZqlxXihiEXq8ZUjfrzDAid5SFmc=;
        b=NZZN5C2uaKSaSvNbbriwyulgux/csQIzhqmkTgbDWSXtg8WmYNyfva2aXzCLHE6en5knqU
        OQN6U+tQOQlfFD0o2Bb06fYKp43OYmRpEbMnhhBz+l9EZYwABsg6YZIbA6GmKZ+q8SBnEq
        53Qa93gA5ghlVoBD2JGMwY+wKbr/Vy0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9638CAB8C;
        Mon,  1 Mar 2021 13:46:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 126B1DA7D7; Mon,  1 Mar 2021 14:44:17 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs updates for 5.12-rc2
Date:   Mon,  1 Mar 2021 14:44:16 +0100
Message-Id: <cover.1614605230.git.dsterba@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: David Sterba <dsterba@suse.cz>

Hi,

first batch of fixes that usually arrive during the merge window code
freeze. Regressions and stable material. Please pull, thanks.

Regressions:

- fix deadlock in log sync in zoned mode

- fix bugs in subpage mode still wrongly assuming sectorsize == page
  size

Fixes:

- fix missing kunmap of the Q stripe in RAID6

- block group fixes:
  - fix race between extent freeing/allocation when using bitmaps
  - avoid double put of block group when emptying cluster

- swapfile fixes:
  - fix swapfile writes vs running scrub
  - fix swapfile activation vs snapshot creation

- fix stale data exposure after cloning a hole with NO_HOLES enabled

- remove tree-checker check that does not work in case information from
  other leaves is necessary

----------------------------------------------------------------
The following changes since commit 9d294a685fbcb256ce8c5f7fd88a7596d0f52a8a:

  btrfs: zoned: enable to mount ZONED incompat flag (2021-02-09 02:52:24 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.12-rc1-tag

for you to fetch changes up to 6e37d245994189ba757df7dc2950a44d31421ac6:

  btrfs: zoned: fix deadlock on log sync (2021-02-22 18:08:48 +0100)

----------------------------------------------------------------
Filipe Manana (4):
      btrfs: avoid checking for RO block group twice during nocow writeback
      btrfs: fix race between writes to swap files and scrub
      btrfs: fix race between swap file activation and snapshot creation
      btrfs: fix stale data exposure after cloning a hole with NO_HOLES enabled

Ira Weiny (1):
      btrfs: fix raid6 qstripe kmap

Johannes Thumshirn (1):
      btrfs: zoned: fix deadlock on log sync

Josef Bacik (2):
      btrfs: tree-checker: do not error out if extent ref hash doesn't match
      btrfs: avoid double put of block group when emptying cluster

Nikolay Borisov (1):
      btrfs: fix race between extent freeing/allocation when using bitmaps

Qu Wenruo (2):
      btrfs: make btrfs_submit_compressed_read() subpage compatible
      btrfs: make check_compressed_csum() to be subpage compatible

 fs/btrfs/block-group.c      | 33 +++++++++++++++++++++++-
 fs/btrfs/block-group.h      |  9 +++++++
 fs/btrfs/compression.c      | 62 +++++++++++++++++++++++++++++++--------------
 fs/btrfs/ctree.h            |  5 ++++
 fs/btrfs/free-space-cache.c | 14 +++++-----
 fs/btrfs/inode.c            | 44 +++++++++++++++++++++++++++-----
 fs/btrfs/raid56.c           | 21 ++++++++-------
 fs/btrfs/reflink.c          | 18 +++++++++++++
 fs/btrfs/scrub.c            |  9 ++++++-
 fs/btrfs/tree-checker.c     | 16 +++---------
 fs/btrfs/tree-log.c         |  3 ---
 11 files changed, 175 insertions(+), 59 deletions(-)
