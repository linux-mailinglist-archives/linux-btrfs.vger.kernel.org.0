Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54755341A66
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Mar 2021 11:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhCSKtd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Mar 2021 06:49:33 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:6295 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbhCSKtB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Mar 2021 06:49:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1616150940; x=1647686940;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=d0/apORlc69o617XeWV4k5gVa37bc550ktxUJ7KLzcY=;
  b=bwr9CErA/XoizqMbBDs1lK/Vrux934aWyVfLW/wyQWbpsYXWhEjuNNgq
   CQOK7rTUH0Pppo7D6Tiq2TGEXngd0g56UT5Z8iwPWcTIQbSzqq4wxMkEh
   ZzzkNbT4Bf/ak40BIuuMCuUk212/4pk7ndZYk7EPYqmI+6ZzTpdontI+c
   RPxiAno6Gys2zPWRQOuE9CN1gSfcKppJC16Z+zLtmbhwnWocMjroDvOfD
   5bei27MK+bZjyMPSJxkCtA7A/n2hsa61EKsmV3gBnhKDrbGsGmjKppzPY
   Ml2/awb5pptQQfxn/pxMtMfvRMYzLfKYq4UmoXCceXcfzJQrM+LbrZuRM
   A==;
IronPort-SDR: eeDVK7k0KCBF1ttFnqKY+wCLmE3hH2OQJA1odaOkWwYllv6MhPNoi0L8zJrFcx/suRpquOaIFK
 pOIcsxrLOqnLmUntSSgGXdCfDC7blIQehULkIu9s5jxNHG0jy9DCscDyZHnMj6W50tfntP2V90
 UhgZMqgH1BHcb8OgaAry5XEAgqGn48+qAqTnvfK9Ivj5+UrS2Ts0G6KAVnaOLRPTAQLpZ1qJn7
 sTJi6rDJOoO1d1rFP1Iqe1+fAIpWrBdREAsaQD8MZJ8fzGvD1/H9QB8wD2E09UM0g/9C+8Qor5
 o4o=
X-IronPort-AV: E=Sophos;i="5.81,261,1610380800"; 
   d="scan'208";a="167028610"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Mar 2021 18:49:00 +0800
IronPort-SDR: a71eNPaaa5T48VhxjaWvsM8EsH/yB1k5d5a8hvuquW+Z8IIpBQPStBaaGnKVT+vt4m9FDnpnp0
 DTa2q2E4f2+qbJ5ly5R8N17XMc16QqIvxNyZbI0pLTDQ8gei+lE+fjbYRDR6cb1a1w1IXaKDN5
 8vdUciysycqrr1hhTmwMVM8zb6yArYvY1Wc/sUFy7nv7SZXpdccK5egCTUGxfZ8KGIryux5aPe
 czZR5KZHtee1hZKn9tRNzhBH3ajIOBQrMbx2/0CfniJvMHFOpbnfcneNZvIh24Kr87ITd6NJi7
 YlCu1005IbYdq8jQNXjbJ08z
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 03:29:33 -0700
IronPort-SDR: OeIt30zFMHVHsi2pWyFIWIyAraPCoN0wQNAb4tXy9EmdKWuNpJJUVWa6QhUOONYxSQ1Pt7MzI2
 XlzMPHBaIBCRVpBbF+JWZM30bSk8IQJ68xrppDIIAydDIZ61EPLOolQSlGgKxULjoJjVCbh6Q7
 G0qX994XRTa/tzOpToCIU4Pl+6QYAvKo5/CIN7BM44vjDTXv+hzMVjEoSGD3qwYYfEgnTatr1v
 519SKQMU+oTKApt8yur30+t+s8tY7MPTXapoOrYcGqqhq1n4uDocBGNf+4tORVeI3bFpm7iKBG
 fyU=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Mar 2021 03:49:00 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2 0/2] btrfs: zoned: automatic BG reclaim
Date:   Fri, 19 Mar 2021 19:48:50 +0900
Message-Id: <cover.1616149060.git.johannes.thumshirn@wdc.com>
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


Changes to v1:
- Document sysfs parameter (David)
- Add info print for reclaim (Josef)
- Rename delete_unused_bgs_mutex to reclaim_bgs_lock (Filipe)
- Remove list_is_singular check (Filipe)
- Document of space_info->groups_sem use (Filipe)

Johannes Thumshirn (2):
  btrfs: rename delete_unused_bgs_mutex
  btrfs: zoned: automatically reclaim zones

 fs/btrfs/block-group.c       | 90 ++++++++++++++++++++++++++++++++++--
 fs/btrfs/block-group.h       |  2 +
 fs/btrfs/ctree.h             |  5 +-
 fs/btrfs/disk-io.c           | 17 +++++--
 fs/btrfs/free-space-cache.c  |  9 +++-
 fs/btrfs/sysfs.c             | 35 ++++++++++++++
 fs/btrfs/volumes.c           | 48 +++++++++----------
 fs/btrfs/volumes.h           |  1 +
 include/trace/events/btrfs.h | 12 +++++
 9 files changed, 187 insertions(+), 32 deletions(-)

-- 
2.30.0

