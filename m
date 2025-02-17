Return-Path: <linux-btrfs+bounces-11491-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0477AA379C7
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2025 03:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50B70188F563
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2025 02:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C921465AB;
	Mon, 17 Feb 2025 02:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BxqY30vc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14005C8FE
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Feb 2025 02:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739759873; cv=none; b=gjF3XYZcFyJOz4ZBrjVPjhpgR3BwOYU+xRBPKcShOZnI2MUUGCvn1pQu8cK7U/n2u1YQW9FruQuLEExdEE4Nn90Vkc1WPiQnbfErXLB++eiLJISULpGse21u+EOYDeQ80A7cRASkD3HmWS5jl5/reMXGy8GLrPAalmmv2v4UYPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739759873; c=relaxed/simple;
	bh=SXY6/8iF/6ULTp+jnwlPfCy2XvLgazdydwO/tKKacb8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oRMBr+usVf9QK0WSbLpWWGDIPQE2+Oqp45EV3q59lqBCV8BFBT/hdBXSiLCFM10Rbi0WfJZzPA4hMTcqkxqt+dj+5DignJAPDqdrA7s8g0Higp/ciDj/NhfaYbNVP9rkLR4jI3+KDTF/i6xf5O5SjJSMktBDS9OCWvsjRKYcoek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=BxqY30vc; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1739759871; x=1771295871;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SXY6/8iF/6ULTp+jnwlPfCy2XvLgazdydwO/tKKacb8=;
  b=BxqY30vc3y55G/qorMFTXIy7p3WzMAVt4My+vGzT0Upvqt3WPPj7Th0T
   EbR7BylsOEgB7fdVvVGoNxwDZBYkMu+sFM6vyW4npqZqomKOayINfxyAU
   sV3qAVryV+8eZtSyJTHt764/Vj7c8+B06CyEKaBqJA1aTfp2vrvhzrueg
   7Xi6d1l4fj4ilJeUSuCdooXKlF5lYxuXTVcOlK66zSwVEP3UQME31jiV0
   DmncZVUpUDP2OSvZlyKDnFtPo6pOS3KscgD+009DsBogrxM5S9Nj+1pk5
   q18mGdDSWlfzoXLajJowrQzWE5gOjlQmpZ08eprSKuf5oTu2h4s6UAHqW
   w==;
X-CSE-ConnectionGUID: QrNTpNdFQqG3XAwX/ckhcQ==
X-CSE-MsgGUID: on8EGXhqQcyBTpJz2NVEGw==
X-IronPort-AV: E=Sophos;i="6.13,291,1732550400"; 
   d="scan'208";a="39877170"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2025 10:37:45 +0800
IronPort-SDR: 67b29341_KSMXzQU2BNaZ+d8EK+eGS/s4mAirl5JD9YrCmTYVQCPfkRs
 24oo1yyg/JgZIvcelxAZnZJAPLmUxggUa1y1E0Q==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Feb 2025 17:39:13 -0800
WDCIronportException: Internal
Received: from 5cg2075f7l.ad.shared (HELO naota-xeon..) ([10.224.109.184])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Feb 2025 18:37:44 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 00/12] btrfs-progs: zoned: support zone capacity and
Date: Mon, 17 Feb 2025 11:37:30 +0900
Message-ID: <cover.1739756953.git.naohiro.aota@wdc.com>
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


