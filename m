Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3C623F191B
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 14:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236481AbhHSM1o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 08:27:44 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:46871 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbhHSM1o (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 08:27:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629376028; x=1660912028;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=O3QpwDX4NvoK5U4fVkfBC9zUaImlGikJNGPbwnhrLmk=;
  b=TKQO+2wpXdbPRxRnpkTmWMOiFf2AXI6r83B+gwYDCP9XCYOvYvEhiPsf
   YEtoAsf7gteu8pomJaMJRiNSE2I6dWbBjCaYEJuLyrouD8hxNQGxJ+QWe
   j5MdoEQkvENkjpmVWvZRseF85mib+0A2Gq8GJ6KwMTTynjWeT10wVYrDT
   UiRJqOYdy46S0LL+U5L3MUz4Pm2ZCWf3Hksu3CbYFuFKrdz0rxg9V5Ixm
   lgzzSKNgL3ab3SUcQ5NUUSokP/ZAu0l0PL9dCLoiqRZ+XyfPOElOuoxwX
   stQXzCC/N/KQaApfEdnqsrjBOp8sKRI3zddL0z2ZUtuHfaey81gwjv3cC
   A==;
X-IronPort-AV: E=Sophos;i="5.84,334,1620662400"; 
   d="scan'208";a="177773515"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Aug 2021 20:27:07 +0800
IronPort-SDR: LtUijDHS8Lkr/HeXCNvWA+fVX6aumPFKMos6siCN7Fqgx6BSQfuFn3X5nneFrOYmP0+udQWB/2
 HnIAfLUJig9lzg6SB5n+Ad4r/4W0cmOvTtORy+bFPRThKXny+3oNatn9hYE8GPxo3njSd+GYuV
 vSKWD/dxDp8KS1m2tx7swRD3nReFvuNwdCv5AY1t5uIo8QQpMRS2x4xKfNbuL1UHNd697bebz3
 Zzy3FzaMt1FylwDE4lYsinGWRY1zHt3n9thz4DH0kbDjU5pu62gtzDHt4FsxUHGu1NGJIA9oke
 X6GVxxqBa3XZPQ3dUvaFSoM8
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 05:04:15 -0700
IronPort-SDR: 4xeAhwOTLrDv7VRptnzKVOHhMQFzCDWs9ukMiNBfvjU5b741xHdTvqQBgZzmkhZgH4pBeWll0I
 VxM8Np+hYAz2WsyH/ESbYecAVenrPGyBlk+zBmIJQHv5txeyi3osupAV5BtolOcZ4MtTobCn/a
 4vkqSui6Q3msr0WWCVuh35m+gwuHw25A0egbsHT4PrbqcvmhLGKRBQcax4xq+2DN1EOy69K1zE
 VhcdJXNf4pBZTKJUlWOfJohKdHNHAnCHFveGjzwuugva5gffn31etTkZbOhwOTfxFM55N/1TE4
 DwA=
WDCIronportException: Internal
Received: from gkg9hr2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.52.110])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Aug 2021 05:27:07 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 00/17] ZNS Support for Btrfs
Date:   Thu, 19 Aug 2021 21:19:07 +0900
Message-Id: <cover.1629349224.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This series extends zoned support for Zoned Namespace (ZNS) SSDs [1].

[1] https://zonedstorage.io/introduction/zns/

This series is available on GitHub at
v1    https://github.com/naota/linux/tree/btrfs-zns-v1
HEAD  https://github.com/naota/linux/tree/btrfs-zns

The ZNS specification introduces extra functionalities listed below.

  - No conventional zones
  - Zone Append write command
  - Zone Capacity
  - Active Zones

The first two functionalities are already addressed in the current
zoned support on btrfs. We do not rely on conventional zones, and we
use the zone append write command to write data IOs.

This series implements support for the other ones.

While userland tool needs some tweaks (e.g. using capactiy instead of
the length) to be precise, but it still works fine as it is.

* Changes in this version

    - Fix btrfs_zone_finish_endio()'s argument on compress writes
    - Convert btrfs_zone_finish_endio to void and drop a unnecessary variable
    - Do not zone finish if reserved bytes exist

* Zone Capacity Support

A zone capacity is an additional per-zone attribute that indicates the
number of usable logical blocks within each zone, starting from the
first logical block of each zone. It is always smaller or equal to the
zone size.

We can naturally map the capacity to the newly introduced
"zone_capacity" of a block group. Allocations are limited under the
zone capacity instead of the block group's length.

* Active Zones Tracking

The ZNS specification defines a limit on the number of zones that can
be in the implicit open, explicit open or closed conditions. Any zone
with such condition is defined as an active zone and correspond to any
zone that is being written or that has been only partially written. If
the maximum number of active zones is reached, we must either reset or
finish some active zones before being able to chose other zones for
storing data.

In order to not exceed the number of max active zones, we need to
track which zones are active and how the active zones are related to
the block groups. We mark a block group as "active" if the
corresponding device zones are all active. Allocating an extent will
activate a block group, and allocation from an inactive block group is
prohibited. Such active block groups are tracked in a list. Once a
block group is fully written, we deactivate it and remove it from the
list.
  
* Active Zone Aware Sequential Allocator

Handling the active zones will make the allocator complex. Here is a
summary of how find_free_extent_update_loop() behave.
  
1. If enough space is available in an active block group
   -  allocate from it (end, success)
2. If we can activate another zone on a device
   2.1 Try to allocate a new block group and activate it
   2.2 If the activation succeeds
      - allocation will be satisfied from it in the next iteration
   2.3 If the activation failed
      - Try the next cycle. Some writes may free up an active block group
3. If we cannot activate any zones
   3.1 Try to allocate in a small size by checking min_alloc_size
      - btrfs_reserve_extent() will halve the allocation size and
        restart the loop
   3.2 Nothing can be done anymore. Give up. ENOSPC

* Patch series organization

Note: patches 2 and 14 are preparation patches and can be merged
independently.

Patches 1-6 implement zone capacity support.

Patch 7 implements finishing a superblock zone once there is no space
left for new superblock.

Patches 8-13 implement the activation side of the active zone
tracking.

Patches 14 and 15 tweak the allocator to retry with a smaller size if
possible (step 3.1 in the above list)

Patches 16 and 17 implement the deactivation side of the active zone
tracking.

* Changes
  - v2
    - Fix btrfs_zone_finish_endio()'s argument on compress writes
    - Convert btrfs_zone_finish_endio to void and drop a unnecessary variable
    - Do not zone finish if reserved bytes exist

Naohiro Aota (17):
  btrfs: zoned: load zone capacity information from devices
  btrfs: zoned: move btrfs_free_excluded_extents out from
    btrfs_calc_zone_unusable
  btrfs: zoned: calculate free space from zone capacity
  btrfs: zoned: tweak reclaim threshold for zone capacity
  btrfs: zoned: consider zone as full when no more SB can be written
  btrfs: zoned: locate superblock position using zone capacity
  btrfs: zoned: finish superblock zone once no space left for new SB
  btrfs: zoned: load active zone information from devices
  btrfs: zoned: introduce physical_map to btrfs_block_group
  btrfs: zoned: implement active zone tracking
  btrfs: zoned: load active zone info for block group
  btrfs: zoned: activate block group on allocation
  btrfs: zoned: activate new block group
  btrfs: move ffe_ctl one level up
  btrfs: zoned: avoid chunk allocation if active block group has enough
    space
  btrfs: zoned: finish fully written block group
  btrfs: zoned: finish relocating block group

 fs/btrfs/block-group.c      |  29 ++-
 fs/btrfs/block-group.h      |   4 +
 fs/btrfs/ctree.h            |   3 +
 fs/btrfs/disk-io.c          |   6 +-
 fs/btrfs/extent-tree.c      | 204 +++++++++------
 fs/btrfs/extent_io.c        |  11 +-
 fs/btrfs/extent_io.h        |   1 +
 fs/btrfs/free-space-cache.c |  19 +-
 fs/btrfs/inode.c            |   6 +-
 fs/btrfs/relocation.c       |   4 +
 fs/btrfs/zoned.c            | 501 +++++++++++++++++++++++++++++++++---
 fs/btrfs/zoned.h            |  36 ++-
 12 files changed, 695 insertions(+), 129 deletions(-)

-- 
2.33.0

