Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB5D359C5A
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Apr 2021 12:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbhDIKx3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Apr 2021 06:53:29 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:19455 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhDIKx2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Apr 2021 06:53:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617965596; x=1649501596;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Zt12N5GvNhfzK5T+UvO725IP+X82LXDSzfM5YTKLqRY=;
  b=mi3CXZbik0tJ6YpDb9gRrSiWkXGob4CgDCZF1ISUi/51ltKfx6TMeP56
   b08I49Bn08Cifi559P2DsE8InfNHmEFsMLx4FC8XTLQoT6LBoGCxnW6HT
   VbCivxrsrTBApdgxiKsd6VBztq7QrJyFj8LVlc+6sWF7BfPlKbVplX9dV
   gNwdKi/7ZHqfQ4wbrVqE6B3w/zdPhmQGGwSGY+uz6heY+OmEvtMHFA0hG
   +RjVOUT8eq/y/zo25ECxn3s4NS9NpF2jFYynh8PLOvfH8+SqwY8j7k/0N
   yLz+EEA7AqJS6HsjerqxuzYE/Irl/IR3UJ6Gu7P93xaBGBAtqBYsv+ICJ
   g==;
IronPort-SDR: szLZlFo+bqmudOcyjsA6JhAc+3enSC+Jc95xmIkf1gRkpEfW9hpH3+U/LU1kB5139XKrvyP5RV
 CFL/qh1MGHwj1PZW87v+YYsz2zJgHWW/O2SvvGRAgJT7XnXLl85THmdpKDdvJGkHf/tEqG/jB+
 46cNDG7YhfKr46uxwbKmjHPDDbfnMyfQ/SLjUKcisTbb9rpTCuePXsUj/CEGOSaooz2+4UzPaa
 3Usmd+rfZygEYeWjkQxsUomXoxGcVGluBytWTROKl/CkYqQU2dvN3vZkfq76bd/WPcJdr+Fll9
 acw=
X-IronPort-AV: E=Sophos;i="5.82,209,1613404800"; 
   d="scan'208";a="168797954"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Apr 2021 18:53:15 +0800
IronPort-SDR: i2Aby4PtQ4gPu4d1q4Zc066gGW3j/fMR/i+f8vjnjQLgNQNp2LZ00VglfWxESSv7/ASmUbYQEg
 6C7SCRNH5H87y0v2m2+4d9k1zxbTWHNUg090byaUYduy47bkMDeD8GJeyPtlx9xPbhDO7fwT4c
 G/27SazIM/qH7Zc/AvPTCNkw79ZNzJpCnZ8D9AJQVJDN4rPx2/Qnb7f9ZW2bndqXTqXRoZEg6t
 whRh9STcOMmkgs3BNw4r66rRplm9fbZN2VBLdNY4TTxMXGspEyp6wQxDrFSfi/t3jLQBkxIh/V
 wp0QrppqymdwX6qbSOWIPb4A
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 03:32:51 -0700
IronPort-SDR: yxkBu/h3k3rMag9uATIWJ74dKd8U1H4Um8Af+85jXYoLHIF6n0rMSpKdF2aRwvGIcJRTclSzSz
 MxKF4nqn/iRDmt9MNxi8I9YycXyR2lhr8wajO3ZKJG2PqX3cMHXmKKHMcT4OdXc3a8GEQYQ8U3
 7rz/Yi8R4UihpnJKMbVHte7ThTYs72oXXv/VXCsYspy2zYFJwrNfJqDESq/X75mLWyq9uUXhSn
 6kSVfIvrEGvslONjhgV1xBJuNTPSnX0AoN64+mo1ZuAfGUTEClUVtHxrYWhmeLCCP9s1QASpLI
 e0o=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Apr 2021 03:53:15 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>,
        Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v3 0/3] btrfs: zoned: automatic BG reclaim 
Date:   Fri,  9 Apr 2021 19:53:06 +0900
Message-Id: <cover.1617962110.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When a file gets deleted on a zoned file system, the space freed is not
returned back into the block group's free space, but is migrated to
zone_unusable.

As this zone_unusable space is behind the current write pointer it is not
possible to use it for new allocations. In the current implementation a
zone is reset once all of the block group's space is accounted as zone
unusable.

This behaviour can lead to premature ENOSPC errors on a busy file system.

Instead of only reclaiming the zone once it is completely unusable,
kick off a reclaim job once the amount of unusable bytes exceeds a user
configurable threshold between 51% and 100%. It can be set per mounted
filesystem via the sysfs tunable bg_reclaim_threshold which is set to 75%
per default.

Similar to reclaiming unused block groups, these dirty block groups are
added to a to_reclaim list and then on a transaction commit, the reclaim
process is triggered but after we deleted unused block groups, which will
free space for the relocation process.

Changes to v2:
- Fix locking in multiple ways (Filipe)
- Offload reclaim into workqueue (Josef)
- Add patch discarding/zone-resetting after successfull relocation (Anand)

Changes to v1:
- Document sysfs parameter (David)
- Add info print for reclaim (Josef)
- Rename delete_unused_bgs_mutex to reclaim_bgs_lock (Filipe)
- Remove list_is_singular check (Filipe)
- Document of space_info->groups_sem use (Filipe)

Johannes Thumshirn (3):
  btrfs: discard relocated block groups
  btrfs: rename delete_unused_bgs_mutex
  btrfs: zoned: automatically reclaim zones

 fs/btrfs/block-group.c       | 102 +++++++++++++++++++++++++++++++++--
 fs/btrfs/block-group.h       |   3 ++
 fs/btrfs/ctree.h             |   8 ++-
 fs/btrfs/disk-io.c           |  19 +++++--
 fs/btrfs/free-space-cache.c  |   9 +++-
 fs/btrfs/sysfs.c             |  35 ++++++++++++
 fs/btrfs/volumes.c           |  61 ++++++++++++---------
 fs/btrfs/volumes.h           |   1 +
 include/trace/events/btrfs.h |  12 +++++
 9 files changed, 218 insertions(+), 32 deletions(-)

-- 
2.30.0

