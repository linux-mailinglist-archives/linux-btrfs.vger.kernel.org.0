Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC2056C53A
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Jul 2022 02:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238724AbiGHXTJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Jul 2022 19:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238583AbiGHXTH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Jul 2022 19:19:07 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EBE41991;
        Fri,  8 Jul 2022 16:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657322346; x=1688858346;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=he3X5eO0f4D0xft/Fne4hgV9ZFUymggDmq32/GrN7vQ=;
  b=ZgtBJHGOSP+leB7fxCVaNbGVspA6mB/c2GD73opQ+RGF9rrQ9mGht7RI
   9ghQ39YeGw3f1Bc+eKyhOiTR4F6U1qRzt6rGaNje9v2+k5Tb7tmoN1BRl
   1KvxWOQYFvFoO2UmbbUaB8Zp+gnSYHLHLR+w550eBq5H8qkbkPObVEHOx
   6As7lunwLooHAeabBqsdJXBB2aS8/piL3sKHYAH8VDcfcwi1fojicdPb2
   9iVDXUhGXspH+LUpXSthXFVJKmO0j6IyH5LglD8quxSFI0uc0dOr/tQnm
   OBDJ6kottSMm+wNXLjT+JEC79kQXLf/oG6c1rGSNRDZatn/qZQLQpWXop
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,256,1650902400"; 
   d="scan'208";a="203871810"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jul 2022 07:19:05 +0800
IronPort-SDR: z9/fkJzbkho95aFVVQ9p76rzzDccoxPHLYxFQQhh5gQq20YA2Ob+LWPdQG0LmyByNVWabivXjG
 i3hN46W74kwus5LivcmU9uqHWO4npM2LQlYNm0DaH2vRi3OwEtRTm9gTP80/gD+yjd89jvCoex
 RuhW8/fsN3M7zgkxdz+k+jMgHgFZRRQxEXBfSZH4NPcEqPFwZtqaeCHXWoF8ppY5zdZSaQZgLU
 QK6H85i+Wzy7fEKxxcWBO722vGW/7ln95eczRUUnS2Gqe/deg2YTOAa/L1zDRlJVOGMFQHWXpV
 uJZITlkpQTnCriakAH0qsre0
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Jul 2022 15:36:11 -0700
IronPort-SDR: L2gLIS7kqteCf4Haq3u3mXwpWhMSbKgLQlYOyhwQmyyYqxW8CKfpnXKiRE3bkHmM8sSMlm9wpX
 977eq8VwCzx40QX43dSEgcyMPkaUiZJz3ydYksqGoy+HTRVXUDuneNFiWqES95m+nbDFgXasrI
 FKBKcgY2XbpzGeeGe2ewD2SvzsSsYlJ7REpIfFEakijsYL+diN4HueEvK0jYKTWVd/J1Yuj6mG
 mXphEwCZIzu3all/wOkR6KDcp51zVtnnCub8VCwtXHfTsBYqG3vZV1lkLrHprjPhQlyppeIHZT
 ef0=
WDCIronportException: Internal
Received: from phd010370.ad.shared (HELO naota-xeon.wdc.com) ([10.225.55.250])
  by uls-op-cesaip01.wdc.com with ESMTP; 08 Jul 2022 16:19:05 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 00/13] btrfs: zoned: fix active zone tracking issues
Date:   Sat,  9 Jul 2022 08:18:37 +0900
Message-Id: <cover.1657321126.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This series addresses mainly two issues on zoned btrfs' active zone
tracking and one issue which is a dependency of the main issue.

* ChangeLog
- v2
  - Support sanity tests (Johannes)
    - fs_info can be NULL while it is running sanity tests. Consider that
      case in CONFIG_FS_BTRFS_RUN_SANITY_TESTS.
  - Propagete an error of btrfs_zone_finish() (Johannes)
  - Add a comment to max_segments limitation (Christoph)
  - Rename btrfs_finish_one_bg() to btrfs_zone_finish_one_bg() to make the
    it clear it is related to zoned code.
  - Do not reduce active_total_bytes when finishing a block group.
    - While it's no longer active, but it still can have "used" bytes. So,
      it should be counted to host "total_bytes". Or, it breaks free space
      calculation.
  - Do not try to activate a fully allocated block group.

* Background

A ZNS drive has an upper limit of zones that simultaneously can be written
out. We call the limit max_active_zones. An active zone is deactivated when
we write fully to the zone, or when we explicitly send a REQ_OP_ZONE_FINISH
command to make it full.

The zoned btrfs must be aware of max_active_zones to use a ZNS drive. So,
we have an active zone tracking system that considers a block group as
active iff the underlying zone is active. In fact, we consider a block
group (and its underlying zones) as active when we start allocating from
it. Then, when the last region which can be allocated in the block group is
written, we send a REQ_OP_ZONE_FINISH command to each zone and consider the
block group as inactive.

So, in short, we currently depend on writing fully to a zone to finish a block group.

* Issues
** Issue A

In a certain situation, the current zoned btrfs's extent allocation fails
with an early -ENOSPC on a ZNS drive. When all the block groups do not have
enough space left for the allocation, it tries to allocate a new block
group if we can activate a new zone. If not, it returns -ENOSPC while the
device still has free space left.

** Issue B

When doing a buffered write, we call cow_file_range() to allocate the data
extent. The cow_file_range() works like an all-or-nothing manner: if it can
allocate for all the range it returns 0, or -ENOSPC if not. Thus, when all
the block group have small free space left, and btrfs cannot finish any
block group, the allocation partly succeed but fails in the end. This also
results in an early -ENOSPC.

We cannot finish any block group in a certain situation. Let's consider
that we have 8 active data block groups (forget about metadata/system block
groups here) and each of them has 1 MB free space left. Now, we want to do
10 MB buffered write. We can allocate blocks for the 8 of 10 MB. And, we
can no longer allocate from any block group. Furthermore, we cannot finish
any block group, because all the block groups have 1 MB reserved unwritten
space left now. And, since this 1 MB regions are owned by the allocating
process itself, simply waiting for the region to be written won't work.

** Issue C

To address issue A, we needed to disable metadata reservation
over-commit. That reveals that we under-estimate the number of extents to
be written on zoned btrfs. On zoned btrfs, we use a ZONE APPEND command to
write data, whose bio size is limited by max_zone_append_sectors and
max_segments. So, a data extent is always split at most at the size of the
limit. As a result, if BTRFS_MAX_EXTENT_SIZE is larger than the limit, we
tend to have more extents than expected from the estimation using
BTRFS_MAX_EXTENT_SIZE.

Since the metadata reservation is done before allocation (e.g, at
btrfs_buffered_write) and released afterward along with the delalloc
process or ordered extent creation. As a result, we can be short of the
metadata reservation in a certain situation, and can cause a WARN by that.

* Solutions
** For issue A

Issue A is that we can have early -ENOSPC if we cannot activate another
block group and no block group has enough space left.

To avoid the early -ENOSPC, we need to choose one block group and finish it
to make rooms for a new block group to be activated. But, that is only
possible from the data extent allocation context. From the metadata
context, we can cause a deadlock because we might need to wait for a
running transaction to make the finishing block group read-only.

So, we use two different methods for data allocation and metadata
allocation. For data allocation, we can finish a block group on-demand from
btrfs_reserve_extent() context. The finishing block group will be the block
group with a least free space left.

For metadata allocation, we use flush_space() to ensure that reserved bytes
can be written into active block groups. To do so, we track active block
groups' total bytes as active_total_bytes, and activate a block group
on-demand from flush_space().

Also, a newly allocated block group from some contexts must be activated

** For issue B

Issue B is about when we cannot allocate space from any block group, and we
cannot finish any block group. This issue only occurs when allocating a
data extent, because metadata reservation is ensured to be contained in
active block groups by solution for issue A.

In this case, writing out the partially allocated region will close the gap
between the allocation pointer and the capacity of the block group, make
the zone finished, and opens up rooms to activate a new block group. So,
this series implements the partial writing out and retrying of the
alloction.

In a certain case, we can't allocate anything from the block groups. In
that case, we'd expect there is on-going IOs to finish a block group. So,
we wait for it and retry the allocation.

** For issue C

Issue C is about that we underestimate the number of extents to be written
on zoned btrfs, because we don't expect an ordered extent is split by the
size of a bio.

We need to use a proper extent size limit to fix issue C. For that, we
revive the fs_info->max_zone_append_size and use it to calculate
count_max_extents(). Technically, the bio size is also limited by the
max_segments, so the limit is also capped by it.

* Patch structure
 
The fix for issue C comes first because it is a dependency of the fixes for
issue A and B.

Patches 1 to 5 address issue C by reviving fs_info->max_zone_append_bytes
and use it to replace BTRFS_MAX_EXTENT_SIZE on zoned btrfs.

Patches 6 to 11 address issue A. In detail, patch 7 fixes the data
allocation by finishing a block group when we cannot activate another block
group. Patch 10 fixes the metadata allocation by finishing a block group at
space reservation time.

Patches 12 and 13 address issue B by writing out a successfully allocated
part first and retrying the rest allocation.

Naohiro Aota (13):
  block: add bdev_max_segments() helper
  btrfs: zoned: revive max_zone_append_bytes
  btrfs: replace BTRFS_MAX_EXTENT_SIZE with fs_info->max_extent_size
  btrfs: convert count_max_extents() to use fs_info->max_extent_size
  btrfs: use fs_info->max_extent_size in get_extent_max_capacity()
  btrfs: let can_allocate_chunk return int
  btrfs: zoned: finish least available block group on data BG allocation
  btrfs: zoned: introduce space_info->active_total_bytes
  btrfs: zoned: disable metadata overcommit for zoned
  btrfs: zoned: activate metadata BG on flush_space
  btrfs: zoned: activate necessary block group
  btrfs: zoned: write out partially allocated region
  btrfs: zoned: wait until zone is finished when allocation didn't
    progress

 fs/btrfs/block-group.c    |  28 ++++++++-
 fs/btrfs/ctree.h          |  30 ++++++---
 fs/btrfs/delalloc-space.c |   6 +-
 fs/btrfs/disk-io.c        |   3 +
 fs/btrfs/extent-tree.c    |  70 ++++++++++++++++-----
 fs/btrfs/extent_io.c      |   8 ++-
 fs/btrfs/inode.c          |  90 +++++++++++++++++++--------
 fs/btrfs/ioctl.c          |  11 ++--
 fs/btrfs/space-info.c     |  76 ++++++++++++++++++++---
 fs/btrfs/space-info.h     |   4 +-
 fs/btrfs/zoned.c          | 124 ++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h          |  18 ++++++
 include/linux/blkdev.h    |   5 ++
 13 files changed, 404 insertions(+), 69 deletions(-)

-- 
2.35.1

