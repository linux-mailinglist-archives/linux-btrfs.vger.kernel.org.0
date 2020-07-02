Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8662212410
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 15:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbgGBNDa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 09:03:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:43064 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729055AbgGBNDa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jul 2020 09:03:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1051AAD1B;
        Thu,  2 Jul 2020 13:03:29 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 0/7] Corrupt counter improvement
Date:   Thu,  2 Jul 2020 15:23:27 +0300
Message-Id: <20200702122335.9117-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This series aims to make the device corrupt counter be incremented when we
encounter checksum error. This stems from an upstream report at [0] that btrfs
doesn't actually increment the corruption device stats counter. There's no good
reason why this should be the case so here's a patchset rectifying this.

While looking around the code I thought the signature of the functions related
to creating the failrec are somewhat quirky so the first 2 patches fix this.

Patch 3 introduces btrfs_device into btrfs_io_bio so that functions in the
bio completion stack can use it.

Patch 4 removes a redundant check

Next 3 patches wire in increment of the CORRUPT counter in the respective
read end io routines, namely compressed and ordinary reads.

Last patch creates a symlink of the private bdi that btrfs creates on mount
which is used in an xfstest for this series.

[0] https://lore.kernel.org/linux-btrfs/4857863.FCrPRfMyHP@liv/

Nikolay Borisov (8):
  btrfs: Make get_state_failrec return failrec directly
  btrfs: Streamline btrfs_get_io_failure_record logic
  btrfs: Record btrfs_device directly btrfs_io_bio
  btrfs: Don't check for btrfs_device::bdev in btrfs_end_bio
  btrfs: Increment device corruption error in case of checksum error
  btrfs: Remove needless ASSERT
  btrfs: Increment corrupt device counter during compressed read
  btrfs: sysfs: Add bdi link to the fsid dir

 fs/btrfs/compression.c    |  10 ++-
 fs/btrfs/ctree.h          |   2 +
 fs/btrfs/extent-io-tree.h |   6 +-
 fs/btrfs/extent_io.c      | 152 +++++++++++++++++++-------------------
 fs/btrfs/inode.c          |   3 +
 fs/btrfs/raid56.c         |   1 +
 fs/btrfs/sysfs.c          |  16 +++-
 fs/btrfs/volumes.c        |  24 +++---
 fs/btrfs/volumes.h        |   2 +-
 9 files changed, 114 insertions(+), 102 deletions(-)

--
2.17.1

