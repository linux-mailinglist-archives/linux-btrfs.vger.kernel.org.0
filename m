Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80F2D365F2B
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Apr 2021 20:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbhDTS2F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Apr 2021 14:28:05 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:54900 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbhDTS2C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Apr 2021 14:28:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618943265; x=1650479265;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oJoo45cY0Eb88Mi1DxB8Gkixz58luCJ5r6URPg+yYiE=;
  b=Q58nGE9s8DLY4lzmbaHp4S/fT/U2vpYa3zplZ/KIO1g2Ap6t+yjNvukF
   5UNMSnxcbD/prcNy5seav0veDfOGoqIfwyHTUXn6OZyunCOZ4/H5vBHdv
   Z6ThBNt4SSkBiVoXTf/qV7bEV4jn1QR3AWHfSG4hj8Rtw4MV/CCLowOpv
   SuBEc+RgBpl7t0q/ZZkQ6iiZj9absRrHXwEo0bWA4M9TvV1elciISkEPs
   YbOqhY/wEkHygiqrApP9vYQOmx5WvVQrASAChrUkL0jU3adSSF780DLOm
   tCmx4L2m3MccmyfF+80AZQ2F5l0oMkTH+DEUeWXoDDsD96kk0Lg3ytaTq
   A==;
IronPort-SDR: xGf9d6II3DSfhQ4tFvPuyxT91PwyP94QMp/W8ZI1IfTI3PET4zVeWShawp4yIL3EAVmtjX/s9k
 spGuZPy4N4nF/D3TetuV7lvRMR9AAnBajKmY3amZTFEphpld3l3qUGD6Cafhyck9MwzRbnp9iZ
 3p0Sx9sgZSdONZ1yqIFnZLhu4w1gSf20FeRfnxUUUHFgZg5qSYCtOqbddraqyHZlyHJK6Xa6Wj
 hMCYXMtIheUdDRrQkThLWgYlkzdvhgVA0ZUDEBxChsc9MsDrR4O/KlI+85NvG6Wrpf6lgO8sPI
 Y90=
X-IronPort-AV: E=Sophos;i="5.82,237,1613404800"; 
   d="scan'208";a="269507068"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Apr 2021 02:27:44 +0800
IronPort-SDR: 9trxvMoEru+m3ze3TFNvLZF7Vlazd99C+zcNzQXyAWzry10zRI9nmaSnxauSqUDK/y7veXVx2k
 3dZ5Mg4TfjF7WGVvpDr0pgKGtIp+c+TFcV8RnQVmlOEuVrvjzCX8ww6dKmCjPexfsPd+Z9zuJ9
 eKmKCXOnjhk3Dl9tzir/KWDfTBnoKt6/j1bS03z/58Xkat1E+Iudu2QJy4f7/67NV0+qMtZJSI
 7pZxZHZkQCeBHu8o9893+OijDCoyTXD5flG8TDSUjTu51sg5s9jDm4D0EMWa91z1R6rm8AvJ9N
 C3Yq+ts1Cv/G55GFJ/THELrx
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 11:08:09 -0700
IronPort-SDR: IRgbNamSYSV3oqsgZ/l5UQog7mxAltXa8XbTWwnPR28vTGRbPkApUnQQB0HoqM/ykCh+6J8IHr
 pUPegw7r0jEeYGBdxLq2YQYLmx4Tvwq1fsnIoUjNfqTxGooNtjm2JWc9iRrAnmkKoBq1bb4iVT
 G7WGzLfZ7XUf7bRp1/28bBGIySQKlZMsUzZntWCmK4BC0ZqgsBQsxYqGjeGZswHsAo5yM/JgMv
 w0qpzKVMuTxehneBoeXn3zY9Giqk89TLkSfTT4oFStJaQGS0N5tt4mxUmYQA7Q11LuORmXDFZW
 J5A=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Apr 2021 11:27:30 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>,
        Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v6 0/3] btrfs: zoned: automatic BG reclaim
Date:   Wed, 21 Apr 2021 03:27:22 +0900
Message-Id: <cover.1618943115.git.johannes.thumshirn@wdc.com>
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

Changes to v5:
- Prefix define (David)
- Print bg usage percentage in reclaim info (David)

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

 fs/btrfs/block-group.c       | 107 ++++++++++++++++++++++++++++++++++-
 fs/btrfs/block-group.h       |   3 +
 fs/btrfs/ctree.h             |   8 ++-
 fs/btrfs/disk-io.c           |  19 ++++++-
 fs/btrfs/free-space-cache.c  |   9 ++-
 fs/btrfs/sysfs.c             |  35 ++++++++++++
 fs/btrfs/volumes.c           |  63 +++++++++++++--------
 fs/btrfs/volumes.h           |   1 +
 fs/btrfs/zoned.h             |   6 ++
 include/trace/events/btrfs.h |  12 ++++
 10 files changed, 231 insertions(+), 32 deletions(-)

-- 
2.30.0

