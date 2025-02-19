Return-Path: <linux-btrfs+bounces-11549-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE422A3B2E6
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 08:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5BB616ADCD
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 07:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E18E1C3C12;
	Wed, 19 Feb 2025 07:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mX2kk2Qj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4AC1C173F
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 07:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739951892; cv=none; b=Ww12RM8ymJ8L5iizVU74e+KL2O1qgyRDgI4GNw7rEODJB8RMQoyl7RInj+jJfGA7PD996E1Un7s9waz8hroBL4vsOHp5SZnHkW/YiyrsvOG9NLBoLsdKxTV5Wk0Exrvcb/S7C0+q4OJG4eLkoPfssJH37kUaRc+REcHPgwA7uzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739951892; c=relaxed/simple;
	bh=Ir9LmDLyyy1Fgs9efIu3U/O1o6Jppv4sAi+aciY4ONE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nVNOogJsCIR0GdWUjc/eYi6yw+sRnCo1aAGrGePKq2gjpsPhQ6nThB/RxxaRwo83spycy7Dt/TN4cKkJxU/qG6ieOZKFLckpRGRTvXcApoBdeqB9mD4kPR7gnSFLWxDmPtou5L/CQFLNSK9BvZ3Scz8EK3n4XMKPJXrj55BGkhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=mX2kk2Qj; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1739951890; x=1771487890;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ir9LmDLyyy1Fgs9efIu3U/O1o6Jppv4sAi+aciY4ONE=;
  b=mX2kk2Qjyfc0Fql5KfFV9IuQM38r+LXppe/R64BhaM8BimJB6o/0RvEf
   ObIgsrtTSKjaspYcvcGl2/eLX7HJ142b37wbk2PnQy5bfRJTq37qhLYbA
   iYVkeNqWVH+gShLx7Ij+3yo4E02jE/YTdEc5XQ6HCQEwRYZ1n+GyoUiH8
   eTy5kJcWKCtkcL407oi4Fx4FwgCdVMb0hA2Vaih1oWdJ1vA0Gw/H5c1W6
   Ml0j193zSxjqoKkInjLvlbHgKkcjNn+YghC+3fyUAY6o6F2rVaiN+kW6V
   o3wJNGJ3bTmSQnTzXZ3pu31lZvRuyN70w5SxEH9DZSLM8550yIqxZ1v7F
   A==;
X-CSE-ConnectionGUID: YJIdIgzXRLGRzKsXqPSYsw==
X-CSE-MsgGUID: 7WVh26vSRO2haEh7bt1mbw==
X-IronPort-AV: E=Sophos;i="6.13,298,1732550400"; 
   d="scan'208";a="38310798"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Feb 2025 15:58:03 +0800
IronPort-SDR: 67b58150_54kkZwY2n2bj8tDEwsyQUXvTSdQ92iym8MsXxzDLSxjOnBC
 dNnBNMid5K9IbJgvyN+CWEEBK9Uu5OgbCg9S8hg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Feb 2025 22:59:29 -0800
WDCIronportException: Internal
Received: from 5cg20343qs.ad.shared (HELO naota-xeon..) ([10.224.109.7])
  by uls-op-cesaip01.wdc.com with ESMTP; 18 Feb 2025 23:58:03 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 00/12] btrfs-progs: zoned: support zone capacity and
Date: Wed, 19 Feb 2025 16:57:44 +0900
Message-ID: <cover.1739951758.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Running mkfs.btrfs on a null_blk device with the following setup fails
as below.

- zone size: 64MB
- zone capacity: 64MB
- number of conventional zones: 6
- storage size: 2048MB

    + /home/naota/src/btrfs-progs/mkfs.btrfs -d single -m dup -f /dev/nullb0
    btrfs-progs v6.10
    See https://btrfs.readthedocs.io for more information.

    zoned: /dev/nullb0: host-managed device detected, setting zoned feature
    Resetting device zones /dev/nullb0 (32 zones) ...
    NOTE: several default settings have changed in version 5.15, please make sure
          this does not affect your deployments:
          - DUP for metadata (-m dup)
          - enabled no-holes (-O no-holes)
          - enabled free-space-tree (-R free-space-tree)

    bad tree block 268435456, bytenr mismatch, want=268435456, have=0
    kernel-shared/disk-io.c:485: write_tree_block: BUG_ON `1` triggered, value 1
    /home/naota/src/btrfs-progs/mkfs.btrfs(+0x290ca) [0x55603cf7e0ca]
    /home/naota/src/btrfs-progs/mkfs.btrfs(write_tree_block+0xa7) [0x55603cf80417]
    /home/naota/src/btrfs-progs/mkfs.btrfs(__commit_transaction+0xe8) [0x55603cf9b7d8]
    /home/naota/src/btrfs-progs/mkfs.btrfs(btrfs_commit_transaction+0x176) [0x55603cf9ba66]
    /home/naota/src/btrfs-progs/mkfs.btrfs(main+0x2831) [0x55603cf67291]
    /usr/lib64/libc.so.6(+0x271ee) [0x7f5ab706f1ee]
    /usr/lib64/libc.so.6(__libc_start_main+0x89) [0x7f5ab706f2a9]
    /home/naota/src/btrfs-progs/mkfs.btrfs(_start+0x25) [0x55603cf6a135]
    /home/naota/tmp/test-mkfs.sh: line 13: 821886 Aborted                 (core dumped)

The crash happens because btrfs-progs failed to set proper allocation
pointer when a DUP block group is created over a conventional zone and a
sequential write required zone. In that case, the write pointer is
recovered from the last allocated extent in the block group. That
functionality is not well implemented in btrfs-progs side.

Implementing that functionality is relatively trivial because we can
copy the code from the kernel side. However, the code is quite out of
sync between the kernel side and user space side. So, this series first
refactors btrfs_load_block_group_zone_info() to make it easy to
integrate the code from the kernel side.

The main part is the last patch, which fixes allocation pointer
calculation for all the profiles.

While at it, this series also adds support for zone capacity and zone
activeness. But, zone activeness support is currently limited. It does
not attempt to check the zone active limit on the extent allocation,
because mkfs.btrfs should work without hitting the limit.

- v2
    - Temporarily fails some profiles while adding supports in the patch
      series.
- v1: https://lore.kernel.org/linux-btrfs/cover.1739756953.git.naohiro.aota@wdc.com/

Naohiro Aota (12):
  btrfs-progs: introduce min_not_zero()
  btrfs-progs: zoned: introduce a zone_info struct in
    btrfs_load_block_group_zone_info
  btrfs-progs: zoned: support zone capacity
  btrfs-progs: zoned: load zone activeness
  btrfs-progs: zoned: activate block group on loading
  btrfs-progs: factor out btrfs_load_zone_info()
  btrfs-progs: zoned: factor out SINGLE zone info loading
  btrfs-progs: zoned: implement DUP zone info loading
  btrfs-progs: zoned: implement RAID1 zone info loading
  btrfs-progs: zoned: implement RAID0 zone info loading
  btrfs-progs: implement RAID10 zone info loading
  btrfs-progs: zoned: fix alloc_offset calculation for partly
    conventional block groups

 include/kerncompat.h        |  10 +
 kernel-shared/ctree.h       |   3 +
 kernel-shared/extent-tree.c |   2 +-
 kernel-shared/zoned.c       | 458 +++++++++++++++++++++++++++++++-----
 kernel-shared/zoned.h       |   3 +
 5 files changed, 414 insertions(+), 62 deletions(-)

--
2.48.1


