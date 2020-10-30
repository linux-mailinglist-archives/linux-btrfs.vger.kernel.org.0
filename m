Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4642A0AE3
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Oct 2020 17:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbgJ3QOG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Oct 2020 12:14:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:57152 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbgJ3QOF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Oct 2020 12:14:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604074444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9k/GbWFKRzkuxPVG6xFt2m0prwkRRBX2XBNPOZHUXZo=;
        b=kWi3c8A/RVFsMCrkoEZw2you3/+aS+zzzhq4Qakd5YIzimVoqZeCW1V+uVTFBijknadOTq
        8dwFYyZ9TxhogKP0n3AvCvNYP/qcOmq965Wq4/g9m7Ec3bry8riv7EpY6GXVvfHHaIYnxw
        20tLkq1ztk8MnGIX3RXMXB3Z3MVoeMw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DBE33AC1F;
        Fri, 30 Oct 2020 16:14:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3FB38DA80D; Fri, 30 Oct 2020 17:12:28 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 5.10-rc2
Date:   Fri, 30 Oct 2020 17:12:27 +0100
Message-Id: <cover.1604073247.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

please pull the following branch with fixes. Thanks.

- lockdep fixes
  - drop path locks before manipulating sysfs objects or qgroups
  - preliminary fixes before tree locks get switched to rwsem
  - use annotated seqlock

- build warning fixes (printk format)

- fix relocation vs fallocate race

- tree checker properly validates number of stripes and parity

- readahead vs device replace fixes

- iomap dio fix for unnecessary buffered io fallback

----------------------------------------------------------------
The following changes since commit 1fd4033dd011a3525bacddf37ab9eac425d25c4f:

  btrfs: rename BTRFS_INODE_ORDERED_DATA_CLOSE flag (2020-10-07 12:18:00 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.10-rc1-tag

for you to fetch changes up to d5c8238849e7bae6063dfc16c08ed62cee7ee688:

  btrfs: convert data_seqcount to seqcount_mutex_t (2020-10-27 15:11:51 +0100)

----------------------------------------------------------------
Daniel Xu (1):
      btrfs: tree-checker: validate number of chunk stripes and parity

Davidlohr Bueso (1):
      btrfs: convert data_seqcount to seqcount_mutex_t

Filipe Manana (3):
      btrfs: fix relocation failure due to race with fallocate
      btrfs: fix use-after-free on readahead extent after failure to create it
      btrfs: fix readahead hang and use-after-free after removing a device

Johannes Thumshirn (1):
      btrfs: don't fallback to buffered read if we don't need to

Josef Bacik (3):
      btrfs: drop the path before adding block group sysfs files
      btrfs: drop the path before adding qgroup items when enabling qgroups
      btrfs: add a helper to read the tree_root commit root for backref lookup

Pujin Shi (1):
      btrfs: tree-checker: fix incorrect printk format

 fs/btrfs/backref.c      |  13 ++++-
 fs/btrfs/block-group.c  |   1 +
 fs/btrfs/ctree.h        |   2 +
 fs/btrfs/dev-replace.c  |   5 ++
 fs/btrfs/disk-io.c      | 139 ++++++++++++++++++++++++++++++++++--------------
 fs/btrfs/disk-io.h      |   3 ++
 fs/btrfs/extent-tree.c  |   2 +-
 fs/btrfs/file.c         |   3 +-
 fs/btrfs/inode.c        |   8 ++-
 fs/btrfs/qgroup.c       |  18 +++++++
 fs/btrfs/reada.c        |  47 ++++++++++++++++
 fs/btrfs/tree-checker.c |  18 +++++++
 fs/btrfs/volumes.c      |   5 +-
 fs/btrfs/volumes.h      |  12 ++---
 14 files changed, 225 insertions(+), 51 deletions(-)
