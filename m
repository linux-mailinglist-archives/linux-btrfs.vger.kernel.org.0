Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5931D21663
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2019 11:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbfEQJmN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 May 2019 05:42:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:33210 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727338AbfEQJmN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 May 2019 05:42:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EBB67AEDB
        for <linux-btrfs@vger.kernel.org>; Fri, 17 May 2019 09:42:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 297C1DA871; Fri, 17 May 2019 11:43:10 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 00/15] RAID/volumes code cleanups
Date:   Fri, 17 May 2019 11:43:10 +0200
Message-Id: <cover.1558085801.git.dsterba@suse.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is preparatory work for RAID1C3, making use of the raid_attr table
that replaces the hand crafted if-else-if sequences and bit mask checks.
Pluging a new bg profile is easy on top of that, though there are still
some possible cleanups left.

There's one user-visible change, patch 2/15, where the balance filters
allow conversion to the RAID56 profiles with the minimum number of
devices. This is for consistency with mkfs/mount.

So this will work:

 $ mkfs.btrfs -d raid1 -m raid1 /dev/sda /dev/sdb
 $ mount dev/sda /mnt
 $ btrfs balance start -dconvert=raid5 -mconvert=raid5 /mnt

David Sterba (15):
  btrfs: fix minimum number of chunk errors for DUP
  btrfs: raid56: allow the exact minimum number of devices for balance
    convert
  btrfs: remove mapping tree structures indirection
  btrfs: use raid_attr table in get_profile_num_devs
  btrfs: use raid_attr in btrfs_chunk_max_errors
  btrfs: use raid_attr table in calc_stripe_length for nparity
  btrfs: use raid_attr to get allowed profiles for balance conversion
  btrfs: use raid_attr table to find profiles for integrity lowering
  btrfs: use raid_attr table for btrfs_bg_type_to_factor
  btrfs: factor out helper for counting data stripes
  btrfs: use u8 for raid_array members
  btrfs: factor out devs_max setting in __btrfs_alloc_chunk
  btrfs: refactor helper for bg flags to name conversion
  btrfs: constify map parameter for nr_parity_stripes and
    nr_data_stripes
  btrfs: read number of data stripes from map only once

 fs/btrfs/ctree.h            |   6 +-
 fs/btrfs/dev-replace.c      |   2 +-
 fs/btrfs/disk-io.c          |   6 +-
 fs/btrfs/extent-tree.c      |  28 ++---
 fs/btrfs/free-space-cache.c |   2 +-
 fs/btrfs/raid56.h           |   4 +-
 fs/btrfs/scrub.c            |  16 +--
 fs/btrfs/volumes.c          | 202 ++++++++++++++++--------------------
 fs/btrfs/volumes.h          |  24 ++---
 9 files changed, 125 insertions(+), 165 deletions(-)

-- 
2.21.0

