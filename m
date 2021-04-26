Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C55E836AC1F
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Apr 2021 08:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbhDZG2v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Apr 2021 02:28:51 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41929 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhDZG2u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Apr 2021 02:28:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619418489; x=1650954489;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Nv9sH57X+6atx6aUDcE1wS4QcC/yGVAHDHNUyhKLHeQ=;
  b=R9HXE1Zoax3sWyl2Cc+Fn3cYF39Qkq/AtzpGDkz1gVu3XY9MCI8orY/S
   t8+94AAkck6HM59S/eV9VonuZzkVmTjPa90rHnF5v5oqzfm7LAQ+WHhDw
   xUDs4gwe7B5MFHdMq3Oj31gZtemieoDXbzn+Lo5gkf51S6Qq4Qsuhh4lg
   NM3mZPQPImGBQiMUx/XcbKpbJSgYxNTVz14YBDyZt9fMRhy4WGiI2X0Md
   9Xs0PvYNVOEHTJlMU9T17HT7ng1ngAGGlLYAaTAae3ACSmddK5eI8E3X/
   9oiDbrEs84rzHeL5NbB8g07q2nauoxhJmVrCHLGh5qALPcTrUtLzgp/gu
   g==;
IronPort-SDR: 7RnMgbPgWGAXYZeflCz+xQwfkID51IlqrOgGPj0prLG+3NhNnJ0B6j8sU4OJc407Tkp+LB2uuZ
 LecXmGc6eWHAqAEbVtIdmeJ8qQKqu1MnMyZG1kVsD7KreE+rWsiBDPPytE7cWcVHUhKVUFhNdV
 RmFP1qvnVw9XW8OOLB1NjHbw4XfAcm0vTtTCOjClqrNLfvnFmPA5gYuocl4nU3vghb56J+6MIi
 TqIA4PNsNxqBlVnM8LFZr1MwEn8uCI6WM6oPJoXRTr5tgcZvHSKKxYGfOG7tlUujZW0S5j5ABR
 ifs=
X-IronPort-AV: E=Sophos;i="5.82,251,1613404800"; 
   d="scan'208";a="170788100"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Apr 2021 14:28:09 +0800
IronPort-SDR: +LUt7tH6YaZRiEAP0tyKRZLzvj2NTdBBQod7Zv/4786qQQWTIEmg2RZSvVal8e6GiI4PyK+noc
 hlm2+kOdjx09XBd3oGc/DMFjcHXkiKOWPC/Y1L5ZMeAhDQW/v000d82EE1iH6AM7PDpus/2cIm
 1/hRYiXx6cYh1LFP2LBnNNSAtwYVyYTLTLG643g75aAchFbkwfLLCOzbAsTh2rNT69ldhFa9ug
 uHWN9Klbnvy5B4Dju17Z5Q+nxFVkyGS07kHiQfe+gFU5rt/6kdVT0T+Iv8qVtgP2rqikwKZgQ0
 iqQCu35kYvkPu8Px244/0meS
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 23:08:32 -0700
IronPort-SDR: VjABNMeLDxz6uqVbk8/ppHeVchzmZDRflkJItjpIeOfHDG/On9eqWuvA2B2hkFJjvgUQb5QsCO
 8ow6ezy/3dNA8sw9OI/jRrY4pGqEdx8VcA5xPLdgEvhlE6ZmXraWS84P4K+5+VR4qXOB/h05Wm
 CY/sPmAVLUkZYCVXNGFm/9M64YRuZm3jcYbF4c00fkEzUlLf4w4mctwh6DZGcyb7/iJijTnQCP
 7GoMbxNRkJX7D+XizO2aWIUEz6WUkwvvFqZeH9JfkgyXLhA349jJs7o1lLY9sDRT2Kl7XIsCb/
 b18=
WDCIronportException: Internal
Received: from bgy2573.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.58])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Apr 2021 23:28:08 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 00/26] btrfs-progs: zoned: zoned block device support
Date:   Mon, 26 Apr 2021 15:27:16 +0900
Message-Id: <cover.1619416549.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This series implements user-land side support for zoned btrfs.

This series is based on misc-next + preparation series below.
https://lore.kernel.org/linux-btrfs/cover.1617694997.git.naohiro.aota@wdc.com/

Userland tool depends on patched util-linux (libblkid and wipefs) to handle
log-structured superblock. The patches are available in the util-linux list.
https://lore.kernel.org/util-linux/20210426055036.2103620-1-naohiro.aota@wdc.com/T/

Followup work will address several areas that can be improved.


* Patch series organization

Patches 1 and 2 are preparation patches. They add a helper function
queue_param() and provide fs_info in struct btrfs_device as same as the
kernel code.

Patch 3 adds a check for a header file of zoned block device support.

Patches 4 to 16 implement zoned btrfs features (loading zone info,
chunk/extent allocator, zone emulation for a non-zoned device, etc.) like
in the kernel code.

Patches 17 to 19 extend btrfs_prepare_device() for a zoned device.

Patches 20 to 24 implement zoned support for mkfs.btrfs.

And, patches 25 and 26 add zoned support for other commands ("device add"
and "device replace").

Naohiro Aota (26):
  btrfs-progs: utils: Introduce queue_param helper function
  btrfs-progs: provide fs_info from btrfs_device
  btrfs-progs: build: zoned: Check zoned block device support
  btrfs-progs: zoned: add new ZONED feature flag
  btrfs-progs: zoned: get zone information of zoned block devices
  btrfs-progs: zoned: check and enable ZONED mode
  btrfs-progs: zoned: introduce max_zone_append_size
  btrfs-progs: zoned: disallow mixed-bg in ZONED mode
  btrfs-progs: zoned: allow zoned filesystems on non-zoned block devices
  btrfs-progs: zoned: implement log-structured superblock for ZONED mode
  btrfs-progs: zoned: implement zoned chunk allocator
  btrfs-progs: zoned: load zone's allocation offset
  btrfs-progs: zoned: implement sequential extent allocation
  btrfs-progs: zoned: calculate allocation offset for conventional zones
  btrfs-progs: zoned: redirty clean extent buffers in zoned btrfs
  btrfs-progs: zoned: reset zone of freed block group
  btrfs-progs: zoned: support resetting zoned device
  btrfs-progs: zoned: support zero out on zoned block device
  btrfs-progs: zoned: support wiping SB on sequential write zone
  btrfs-progs: mkfs: zoned: detect and enable zoned feature flag
  btrfs-progs: mkfs: zoned: check incompatible features with zoned btrfs
  btrfs-progs: mkfs: zoned: tweak initial system block group placement
  btrfs-progs: mkfs: zoned: use sbwrite to update superblock
  btrfs-progs: zoned: wipe temporary superblocks in superblock log zone
  btrfs-progs: zoned: device-add: support ZONED device
  btrfs-progs: zoned: introduce zoned support for device replace

 Makefile                    |    2 +-
 cmds/device.c               |   21 +-
 cmds/inspect-dump-super.c   |    3 +-
 cmds/replace.c              |   13 +-
 cmds/rescue-chunk-recover.c |    2 +-
 common/device-scan.c        |    7 +-
 common/device-utils.c       |  127 +++-
 common/device-utils.h       |    4 +
 common/fsfeatures.c         |    8 +
 common/fsfeatures.h         |    3 +-
 configure.ac                |   13 +
 kerncompat.h                |   23 +
 kernel-shared/ctree.h       |   28 +-
 kernel-shared/disk-io.c     |   39 +-
 kernel-shared/extent-tree.c |   26 +
 kernel-shared/print-tree.c  |    1 +
 kernel-shared/transaction.c |    6 +
 kernel-shared/volumes.c     |  153 ++++-
 kernel-shared/volumes.h     |    8 +-
 kernel-shared/zoned.c       | 1181 +++++++++++++++++++++++++++++++++++
 kernel-shared/zoned.h       |  170 +++++
 mkfs/common.c               |   38 +-
 mkfs/common.h               |    1 +
 mkfs/main.c                 |  112 ++--
 24 files changed, 1887 insertions(+), 102 deletions(-)
 create mode 100644 kernel-shared/zoned.c
 create mode 100644 kernel-shared/zoned.h

-- 
2.31.1

