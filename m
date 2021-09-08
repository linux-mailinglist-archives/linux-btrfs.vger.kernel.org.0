Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B69C3403D78
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Sep 2021 18:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348125AbhIHQUu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Sep 2021 12:20:50 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:3327 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347311AbhIHQUu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Sep 2021 12:20:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1631117981; x=1662653981;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TG6vG+SgnO4GuDBQMBITEFOJnuJHxrBIBnPwLBYzIig=;
  b=BqynckarqTaPdfwde2mB/ZYWKZdz/B+90lnTshrIR0MSa3ZVKpH5gcmM
   M42HWUgX2LaMRPfWbauhUp3y6x+DEui4GXcp39+c/z7JQgly49JSNydFy
   slGgwq12VoDlVRGkz+lBa4o6jAomrw4mM7Fh0G0L1KV6OsGDSjvgVl0Mw
   zKk22tJmeWAg4QivWH+nL4PDx4Yj0lBfXRhWHqWyqLfRVKt+phKHXjZH1
   sPmZ8lCHKKcK5MRvQ1B6Q7i9QyAESk6Gf6O1zp+4bchPCRg2S6jGb3gp2
   rFvGViODzczNKQcFxVyxcCXidl0nt/BLfjOHcaSltL6b3VpSWQ9soRruA
   Q==;
X-IronPort-AV: E=Sophos;i="5.85,278,1624291200"; 
   d="scan'208";a="179493933"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2021 00:19:41 +0800
IronPort-SDR: BadK6WdIXZwfZ/5D5YqnYZ0oVZgCES5jtBch8vZUkIS+tY07wb7wYMEX8gmxGq+SpGeT5jcbok
 i6OFFv/gAv0BE1obM0LdPY32yJuj5OYu4vsBH8EV8lz9S40cHhHGUKwww1JpDSaLIN9K4XK4w7
 Fm0f02HaAl9e8fV5L0VUR4kkFCM8YRUKkS2Mx8QBmRnlup8NyKlOFcCJZKtR2rt/KfaUnPlZmK
 mJW6y1Yu4QsYqekPf6AuTNqkqS0xJ0i1YflMFURwjda44gRwR1KSigt+o7QfnZkkN2F4bx4Hrw
 mTR/rUujMBZm0047aoQ42q8k
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2021 08:54:38 -0700
IronPort-SDR: d3rncuDmU9AbwXVcsZ2kpTkoo1PCq9bIdrj3QGf5lIDzrPu2j11Gd4T/TtyfphWJi/FJAv+eAt
 jRlW5zdplzAeEvE6ZfCFlj4wEmcxtNktk6TlmLUwh63qpeOmPYjNV54Bn9XMBuTmC8Vt8eTZdV
 Cqix7wBgAuQVpr5bZWZBpFYfRGFTDauuveA10RfdkKhsv7jPv3MszdNLbgc/7huMp5nq6smWRq
 7muOLmgiAo27ajDLQYaFcHgkoqUd9mNVev1N2/4T8ZfEHKSs5Ai9zYFPwErv7+tqP4+37nH4Pz
 stg=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Sep 2021 09:19:42 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 0/8] btrfs: zoned: unify relocation on a zoned and regular FS
Date:   Thu,  9 Sep 2021 01:19:24 +0900
Message-Id: <cover.1631117101.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A while ago David reported a bug in zoned btrfs' relocation code. The bug is
triggered because relocation on a zoned filesystem does not preallocate the
extents it copies and a writeback process running in parallel can cause a
split of the written extent. But splitting extents is currently not allowed on
relocation as it assumes a one to one copy of the relocated extents.

This causes transaction aborts and the filessytem switching to read-only in
order to prevent further damage.

The first patch in this series is just a preparation to avoid overly long
lines in follow up patches. Patch number two adds a dedicated block group for
relocation on a zoned filesystem. Number three excludes multiple processes
from adding pages to a relocation inode in a zoned filesystem. Patch four
switches relocation from REQ_OP_ZONE_APPEND to regular REQ_OP_WRITE, five
prepares an ASSERT()ion that we can enter the nocow path on a zoned filesystem
under very special circumstances and the sixth patch then switches the
relocation code for a zoned filesystem to using the same code path as we use
on a non zoned filesystem. As the changes before have made the prerequisites
to do so. The last two patches in this series are just a simple rename of a
function whose name we have twice in the btrfs codebase but with a different
purpose in different files and a cleanup of a complicated boolean comparison
into an if to make it stand out.

Changes to v1:
- Added patches 3 and 8
- Added comments to patches 4 and 5 (Naohiro)
- Move btrfs_clear_data_reloc_bg() out of line (David)
- Untangle the 'skip' assing into an if (David)
- Commented new fs_info members (David)

Johannes Thumshirn (8):
  btrfs: introduce btrfs_is_data_reloc_root
  btrfs: zoned: add a dedicated data relocation block group
  btrfs: zoned: only allow one process to add pages to a relocation
    inode
  btrfs: zoned: use regular writes for relocation
  btrfs: check for relocation inodes on zoned btrfs in should_nocow
  btrfs: zoned: allow preallocation for relocation inodes
  btrfs: rename setup_extent_mapping in relocation code
  btrfs: zoned: let the for_treelog test in the allocator stand out

 fs/btrfs/block-group.c |  1 +
 fs/btrfs/ctree.h       | 12 +++++++++
 fs/btrfs/disk-io.c     |  3 ++-
 fs/btrfs/extent-tree.c | 60 +++++++++++++++++++++++++++++++++++++-----
 fs/btrfs/extent_io.c   |  7 +++++
 fs/btrfs/inode.c       | 29 +++++++++++---------
 fs/btrfs/relocation.c  | 43 +++++-------------------------
 fs/btrfs/zoned.c       | 21 +++++++++++++++
 fs/btrfs/zoned.h       |  4 ++-
 9 files changed, 123 insertions(+), 57 deletions(-)

-- 
2.32.0

