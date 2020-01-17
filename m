Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6DD1410EC
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 19:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbgAQSjj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 13:39:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:33048 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726603AbgAQSjj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 13:39:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4EDE7AFDF;
        Fri, 17 Jan 2020 18:39:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2CAA4DA871; Fri, 17 Jan 2020 19:39:23 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 5.5-rc7
Date:   Fri, 17 Jan 2020 19:39:20 +0100
Message-Id: <cover.1579282274.git.dsterba@suse.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

please pull a few more fixes that have been in the works during last 2
weeks.  All have a user visible effect and are stable material. Thanks.

* scrub: properly update progress after calling cancel ioctl, calling
  'resume' would start from the beginning otherwise

* fix subvolume reference removal, after moving out of the original path
  the reference is not recognized and will lead to transaction abort

* fix reloc root lifetime checks, could lead to crashes when there's
  subvolume cleaning running in parallel

* fix memory leak when quotas get disabled in the middle of extent
  accounting

* fix transaction abort in case of balance being started on degraded mount
  on eg. RAID1

----------------------------------------------------------------
The following changes since commit de7999afedff02c6631feab3ea726a0e8f8c3d40:

  Btrfs: fix infinite loop during nocow writeback due to race (2019-12-30 16:13:20 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.5-rc6-tag

for you to fetch changes up to b35cf1f0bf1f2b0b193093338414b9bd63b29015:

  btrfs: check rw_devices, not num_devices for balance (2020-01-17 15:40:54 +0100)

----------------------------------------------------------------
Filipe Manana (1):
      Btrfs: always copy scrub arguments back to user space

Johannes Thumshirn (1):
      btrfs: fix memory leak in qgroup accounting

Josef Bacik (4):
      btrfs: rework arguments of btrfs_unlink_subvol
      btrfs: fix invalid removal of root ref
      btrfs: do not delete mismatched root refs
      btrfs: check rw_devices, not num_devices for balance

Qu Wenruo (1):
      btrfs: relocation: fix reloc_root lifespan and access

 fs/btrfs/inode.c      | 73 +++++++++++++++++++++++++++------------------------
 fs/btrfs/ioctl.c      | 14 +++++++++-
 fs/btrfs/qgroup.c     |  6 ++++-
 fs/btrfs/relocation.c | 51 +++++++++++++++++++++++++++++++----
 fs/btrfs/root-tree.c  | 10 ++++---
 fs/btrfs/volumes.c    |  6 ++++-
 6 files changed, 114 insertions(+), 46 deletions(-)
