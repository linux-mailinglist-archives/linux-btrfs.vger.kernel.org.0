Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67A9CE0583
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2019 15:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388275AbfJVNwB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Oct 2019 09:52:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:58518 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387831AbfJVNwB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Oct 2019 09:52:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 83F8CAFAF;
        Tue, 22 Oct 2019 13:51:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 509ECDA733; Tue, 22 Oct 2019 15:52:12 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 5.4-rc5
Date:   Tue, 22 Oct 2019 15:52:07 +0200
Message-Id: <cover.1571751313.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

please pull the following updates, all stable material.
Thanks.

Changes:

* fixes of error handling cleanup of metadata accounting with qgroups
  enabled

* fix swapped values for qgroup tracepoints

* fix during file sync, the full-sync status might get dropped
  externally, eg. by background witeback under some circumstances

* don't start unused worker thread, functionality removed already

----------------------------------------------------------------
The following changes since commit 431d39887d6273d6d84edf3c2eab09f4200e788a:

  btrfs: silence maybe-uninitialized warning in clone_range (2019-10-08 13:14:55 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.4-rc4-tag

for you to fetch changes up to ba0b084ac309283db6e329785c1dc4f45fdbd379:

  Btrfs: check for the full sync flag while holding the inode lock during fsync (2019-10-17 20:36:02 +0200)

----------------------------------------------------------------
David Sterba (1):
      btrfs: don't needlessly create extent-refs kernel thread

Filipe Manana (3):
      Btrfs: add missing extents release on file extent cluster relocation error
      Btrfs: fix qgroup double free after failure to reserve metadata for delalloc
      Btrfs: check for the full sync flag while holding the inode lock during fsync

Qu Wenruo (4):
      btrfs: block-group: Fix a memory leak due to missing btrfs_put_block_group()
      btrfs: qgroup: Always free PREALLOC META reserve in btrfs_delalloc_release_extents()
      btrfs: tracepoints: Fix wrong parameter order for qgroup events
      btrfs: tracepoints: Fix bad entry members of qgroup events

 fs/btrfs/block-group.c       |  1 +
 fs/btrfs/ctree.h             |  5 +----
 fs/btrfs/delalloc-space.c    |  7 ++-----
 fs/btrfs/disk-io.c           |  6 ------
 fs/btrfs/file.c              | 43 ++++++++++++++++++++-----------------------
 fs/btrfs/inode-map.c         |  4 ++--
 fs/btrfs/inode.c             | 12 ++++++------
 fs/btrfs/ioctl.c             |  6 ++----
 fs/btrfs/qgroup.c            |  4 ++--
 fs/btrfs/relocation.c        |  9 +++++----
 include/trace/events/btrfs.h |  3 ++-
 11 files changed, 43 insertions(+), 57 deletions(-)
