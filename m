Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285A7564CDF
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jul 2022 06:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbiGDE6w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jul 2022 00:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbiGDE6t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jul 2022 00:58:49 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C52267E
        for <linux-btrfs@vger.kernel.org>; Sun,  3 Jul 2022 21:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656910727; x=1688446727;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4Jn8i1KYPZMdvz8aXsGm5K9oPYzIuzxEAchadp+rUwY=;
  b=cIbKGbCWKMGZT5Tv1S+3QJnV/otfvK3ZmrNRSx54sr7qxUGouHKryl/2
   RY5Rynh3Y6po0KILQMfxT15uokzikul3LtNSotogMsFCz7JNONfkwcG9F
   QNWr1cGVFJYynXUsNWTP21aikA3F1oUIX0VFP8+VY/atsAig0Ct7QKi41
   wsvU/SEt6D4oxauYPLoJcp9WBFRUQj1UwU2APdylFp5MqGyFTwAVGH3kq
   pVEEH2h7L3omsAp0bCKt/zqaimZzeTlau6S42L1eTXVpT0IP2MYhAOaxh
   0dhudpv6whqc9x6njlOPRJwQQIZ6CpUaw9GxcFROPEr+I9sfQgYDJxCJU
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,243,1650902400"; 
   d="scan'208";a="204732392"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jul 2022 12:58:46 +0800
IronPort-SDR: n4KTyLH/qFYRhCW45G8qyKA4wIjjM0SfCXvs2YK0lD8ezAbY3FYIn72YqFj9tkoiiG+X2C4amk
 ljpmq3fIpAHkLu7WV/Y8f97jG9ZjJk5BFoWVAatVjhJs/077rOQ552xKkb8tEfRPCm9H7o5lYO
 APQvgEZtl1tBrC5OqzpGofCPvL/NmFUIoWw+aUdtCL3Oopb5FuM045iwXFv9xH6dpOFBidByZ2
 yWPcITIWKpPpWmGEJMtJ1GzVljV6zLYz3JidGOwPShPv361Gukzndrd2JCdM+e2rBkHfoLLb4r
 pzk9WrNzk89+ZO7JhiLYFNB4
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jul 2022 21:20:39 -0700
IronPort-SDR: L4CI+82VaNV6r4oW1WSwp1nOy7GsQCEq9h4DYviknlCWI+jTEIBMPmo1e9nu0x0NDvUcBhhJVU
 NwnAGi33CrI4OacZryHdJrguKOcjSkLInVDaR7FGCdqHEYFJYSjnOzkBM78DqfELO6W0ZanIX+
 JgkgUR33XpsXYm54gAbYRdFwbuAfFWhO90KG63fIcwHK7eQk9MTDr5oLxBt4PgXLRpMqkkojv8
 3oXAiBNyFHy9faKaO4nG/TbQ5cUx0b/I7eT98grOpfVw0aK2I1C0KUslCV+tLTxH/fLYeb42wp
 EY8=
WDCIronportException: Internal
Received: from h5lk5s2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.53.119])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 Jul 2022 21:58:47 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 00/13] btrfs: zoned: fix active zone tracking issues
Date:   Mon,  4 Jul 2022 13:58:04 +0900
Message-Id: <cover.1656909695.git.naohiro.aota@wdc.com>
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

 fs/btrfs/block-group.c    |  23 +++++++-
 fs/btrfs/ctree.h          |  25 +++++---
 fs/btrfs/delalloc-space.c |   6 +-
 fs/btrfs/disk-io.c        |   3 +
 fs/btrfs/extent-tree.c    |  64 +++++++++++++++-----
 fs/btrfs/extent_io.c      |   3 +-
 fs/btrfs/inode.c          |  90 ++++++++++++++++++++--------
 fs/btrfs/ioctl.c          |  11 ++--
 fs/btrfs/space-info.c     |  66 +++++++++++++++++----
 fs/btrfs/space-info.h     |   4 +-
 fs/btrfs/zoned.c          | 119 ++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h          |  18 ++++++
 include/linux/blkdev.h    |   5 ++
 13 files changed, 368 insertions(+), 69 deletions(-)

-- 
2.35.1

