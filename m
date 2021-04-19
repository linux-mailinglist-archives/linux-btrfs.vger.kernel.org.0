Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D78C363CDC
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Apr 2021 09:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237966AbhDSHmH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Apr 2021 03:42:07 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:32289 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237893AbhDSHmB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Apr 2021 03:42:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618818093; x=1650354093;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MHYmKAN+pcJkgCQ/NN48WMsiRNJ60S8tSQ/NnFILybY=;
  b=N4GLAsH5nroQdsdNkIjI7N+6u1+aM1xSXTzt7IRRAjzhuIFU4MF6Oy/H
   OzrEN6HA5XmDKEI1oi0E1ESbfZ0ZfN48By5SJIgSrf/u3mheCcR9koFYT
   N+b9Kngvxx9vSEK4xM7IA54M1jQbldOZ7CdqXjwYQlmYAACla5AgTYBvQ
   M0qKBr3eI7PCgxNr+Jh9W+8hkdbmB7LhkQmkucF5GH0hQuooKX4pxUGp2
   LToQHDmQ6Cl7VpQcuLmG3f14E69Rc4jdEoaMv8KgV4aPXGNZWlMiGM3Az
   STxPWvRKYG2FzBUyxx52JPCAsIOdVjqXTdEdyYXuLhbxMPl2yUbwJJdfB
   Q==;
IronPort-SDR: r7mmRjqwDxRf0NMTWaXwUDay9rfpR/FTHqiPI8Y+K6/VUhXpARaQ6I1XmrVPwSfORfUHU5SGRP
 Se1TYa94PhrMW+H9nHOk8CHdn+/i53GpxCPcqEw9TtatkEtIFJzoH/8lpgLEYSpZLRehf2lYmg
 jt0lG9Z6sSiKo/ITZFOruAjrzOdu/+piIiYWQmAsx+m7VOfOC9VIzx91GmjAtz0/BzZOvWqtUw
 6P4WQdOFO1MzVvPHibK6HvuowtysVkgRP5FYF2O2ZGH2xzWIsRViCsVN+7igVj9/o5/qp4oorN
 lfc=
X-IronPort-AV: E=Sophos;i="5.82,233,1613404800"; 
   d="scan'208";a="165966772"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Apr 2021 15:41:09 +0800
IronPort-SDR: WCY2LAUHuGu8VwVJOo4/LIQWbHrIJtKBXfT6SZdjf9p6aQqnEqRMaaYumKfL0BqxKkUJL06maI
 Lmqf5kYoCCRp75x/3b9CBXZBN4wTNGtVZoedfRu9J4rF2AX3MiEGY1Q3TEgzjfG0Aj1biRxvqS
 A07ukJ9S2LhfOH3+A9YDVQKBiNnCpNK41SPj3cQevPmPnP/Q0LzQ8ceMFaWjuJR5wVFLZrGxEu
 iCtW+33nZ4ZxE1iUMod9yBUPHo3u7MneVcj/bNAKgCy5RtTI1sFmB8mvBn3/QpdeyIAdw8hLNj
 SN6VwdFwZNERB0q00/bDrz/W
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2021 00:21:50 -0700
IronPort-SDR: g1cu4yZUlhnCTiAmZAXqa6AwIR0bn1Cnz+gQuQi9U2Vi/Zo4M8D2FkoXplreQ6EzRJSUtrxnCL
 bOClbxv1IYIp4nr6eIiPJlY4lGMlZdrj1+bdoEJ9jrtqleQkysquHWav0E2b4kXwYcl+9WGgZs
 XB6RlCJEWj+fslxY5nUU+OR47haIW/h4+Ae+ppnTHZpvr95SBQPUhUmDHy/0LMBVnaO97Nk70k
 Y0nSYDDF1RQ0XeBRSdyTDXg8zjEdobwFcpPdKUVvNAEhCQpJzs/mlhVyW0ZOR8BxLBV0Uq2WV5
 A84=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Apr 2021 00:41:07 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>,
        Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v5 0/3] btrfs: zoned: automatic BG reclaim
Date:   Mon, 19 Apr 2021 16:40:59 +0900
Message-Id: <cover.1618817864.git.johannes.thumshirn@wdc.com>
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

Zones that are 100% full and zone unusable already get reclaimed atomatically
on transaction commit. Another improvement on the garbage collection side of
zoned btrfs would be no to reclaim block groups that have used, pinned and
reserved = 0 but zone_unusable > 0. This is not yet included as it needs
further reaserch and testing.

Changes to v4:
- Bail out on unmount (Josef)
- Fix delete extents comment (Filipe)
- Use constant for default threashold (David)
- document reclaim_bgs_mutex (David)

Changes to v3:
- Special case "discarding" after relocation (Filipe)

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
  btrfs: zoned: reset zones of relocated block groups
  btrfs: rename delete_unused_bgs_mutex
  btrfs: zoned: automatically reclaim zones

 fs/btrfs/block-group.c       | 106 ++++++++++++++++++++++++++++++++++-
 fs/btrfs/block-group.h       |   3 +
 fs/btrfs/ctree.h             |   8 ++-
 fs/btrfs/disk-io.c           |  19 ++++++-
 fs/btrfs/free-space-cache.c  |   9 ++-
 fs/btrfs/sysfs.c             |  35 ++++++++++++
 fs/btrfs/volumes.c           |  63 +++++++++++++--------
 fs/btrfs/volumes.h           |   1 +
 fs/btrfs/zoned.h             |   2 +
 include/trace/events/btrfs.h |  12 ++++
 10 files changed, 226 insertions(+), 32 deletions(-)

-- 
2.30.0

