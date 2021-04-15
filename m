Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A038A360B32
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Apr 2021 15:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbhDON7X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Apr 2021 09:59:23 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:46699 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbhDON7W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Apr 2021 09:59:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618495141; x=1650031141;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=C6/FDqMyGl40IYim4yyiNGSRWup4AQYL05hEA5GTOAo=;
  b=bKalQZM8WIpNyY+aVto5hoCUGLIqWVUL880i/erUzZX9kT/OmPNcgjro
   pBCLlNYZ4zxLde4v2pNTHXvAHK+E5r4qq/FeqQnzyUUkRDh6P/bD7jnZq
   Q/EM39kzWgbSzqbxg4+SsizsjVxeESnUax7fb6x3Deo1tCDqR1cupKWn4
   p2z439HW8eJu0zl1pHtAQe51znshSHuVxerR/4696mTzjfISVr82Z60v+
   FRyANCTqMxfxoqEfqi68wsJYmhtyviCVc9fcUmkwgJQRB9ubzBGikHbDb
   2c2C4toGzHDJUjou53Qy16qxjXqFCVdzTKekEa5vDVCENiA5loTrJ4rWF
   w==;
IronPort-SDR: 5un+j3HXyH70cn5ZaQSK3+PEmqzrdtAaJNSCo5j7gU0+eiOCg7nV8j8b3vtXT7B/+esO03lTtQ
 owGoRmFvGpGRUcOix73Kc8a48DHeBDiTw5W6/a+IVO/LB5eoRb14RWMCAo6cabszTb50y+c4mb
 7JpfAkiwbtfn9t1dAuKe/jdfcq8CjWts1jlfm5QEgOA/t+CdYv53tyEnZH/g3VvQBkaHScS/yW
 +Uz/9wbyPgbLjB2nPpQvjJD+lXCDkWqCJheKmnWXjGShyHkyuq4u2702jXC8jvPBaQrPGBdSOn
 MqM=
X-IronPort-AV: E=Sophos;i="5.82,225,1613404800"; 
   d="scan'208";a="165555186"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Apr 2021 21:58:54 +0800
IronPort-SDR: iTkpcccGO8AFhaJkr5ewKnFSbN6lTX/Vsnsd4hDPqloYtmvgE9tWncqUWgir8NtslLD4iV9RaV
 KhtKAH08EHa+QM1BFyfHIeMgDGbVh7ip9r3ouCzVuqTQUSrtlzblrKeAxuIEwD2zAnmXfI5rlI
 BPejwt3a2+fxa+E3kL0DoNklWfdSG09DdYiqnelgdFwiz+XEmFv19QlF0FpeMwT/KEYLniEY2r
 wok2nbDVaUE0Pis7Iq1ocn/bzakAPUl0EogSscVBc0i11GDajjuDjQgHjRGEoEcEMK+ThCBadL
 BqrJVJ2qdRZ5f1rL3X/yGNJp
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 06:38:06 -0700
IronPort-SDR: BHVjcflK9onP7k7RzqW+IhHcHwK3zQQIk7xoYDOdTq2/1sQp8Bdvrl8z4CqDNiERdKUmrPUcNR
 IJQMezjgPk1WZqS0lXI2zjqqQMvfnbt0An47urB616FCgbY2X5nJITvQnFB/L88VlLiCrqnsly
 c2k3elnE7vVxZMKnwlN7Mv40Z8Z7D8gyP24FNsAQFh8UN2WBz9ybaQPaNFIvKC7tTbySLnm5wG
 E67NKxpAgzY+J05lyjfKRHR2PuptM+Qp/3qfGeCPNM5scE2lI9mYEbV88q0jPUB/hmHB/eCRkT
 uwk=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Apr 2021 06:58:46 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>,
        Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v4 0/3] btrfs: zoned: automatic BG reclaim
Date:   Thu, 15 Apr 2021 22:58:32 +0900
Message-Id: <cover.1618494550.git.johannes.thumshirn@wdc.com>
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

 fs/btrfs/block-group.c       | 102 +++++++++++++++++++++++++++++++++--
 fs/btrfs/block-group.h       |   3 ++
 fs/btrfs/ctree.h             |   8 ++-
 fs/btrfs/disk-io.c           |  19 +++++--
 fs/btrfs/free-space-cache.c  |   9 +++-
 fs/btrfs/sysfs.c             |  35 ++++++++++++
 fs/btrfs/volumes.c           |  69 ++++++++++++++----------
 fs/btrfs/volumes.h           |   1 +
 include/trace/events/btrfs.h |  12 +++++
 9 files changed, 222 insertions(+), 36 deletions(-)

-- 
2.30.0

