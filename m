Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23A00C2322
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2019 16:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731622AbfI3OYy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Sep 2019 10:24:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:35556 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731030AbfI3OYy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Sep 2019 10:24:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A8522B176;
        Mon, 30 Sep 2019 14:24:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CA8E1DA88C; Mon, 30 Sep 2019 16:25:10 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 5.4-rc2
Date:   Mon, 30 Sep 2019 16:25:08 +0200
Message-Id: <cover.1569852875.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

a bunch of fixes that accumulated in recent weeks, mostly material for
stable.

Summary:

- fix for regression from 5.3 that prevents to use balance convert with
  single profile

- qgroup fixes: rescan race, accounting leak with multiple writers,
  potential leak after io failure recovery

- fix for use after free in relocation (reported by KASAN)

- other error handling fixups

Please pull, thanks.

----------------------------------------------------------------
The following changes since commit 6af112b11a4bc1b560f60a618ac9c1dcefe9836e:

  btrfs: Relinquish CPUs in btrfs_compare_trees (2019-09-09 14:59:20 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.4-rc1-tag

for you to fetch changes up to d4e204948fe3e0dc8e1fbf3f8f3290c9c2823be3:

  btrfs: qgroup: Fix reserved data space leak if we have multiple reserve calls (2019-09-27 15:24:34 +0200)

----------------------------------------------------------------
Dennis Zhou (1):
      btrfs: adjust dirty_metadata_bytes after writeback failure of extent buffer

Filipe Manana (3):
      Btrfs: fix selftests failure due to uninitialized i_mode in test inodes
      Btrfs: fix missing error return if writeback for extent buffer never started
      Btrfs: fix race setting up and completing qgroup rescan workers

Qu Wenruo (4):
      btrfs: relocation: fix use-after-free on dead relocation roots
      btrfs: Fix a regression which we can't convert to SINGLE profile
      btrfs: qgroup: Fix the wrong target io_tree when freeing reserved data space
      btrfs: qgroup: Fix reserved data space leak if we have multiple reserve calls

 fs/btrfs/extent_io.c         | 13 +++++++++++++
 fs/btrfs/qgroup.c            | 38 +++++++++++++++++++++++---------------
 fs/btrfs/relocation.c        |  9 ++++++++-
 fs/btrfs/tests/btrfs-tests.c |  8 +++++++-
 fs/btrfs/volumes.c           |  8 +++++++-
 5 files changed, 58 insertions(+), 18 deletions(-)
