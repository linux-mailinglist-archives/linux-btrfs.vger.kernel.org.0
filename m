Return-Path: <linux-btrfs+bounces-9412-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 952BB9C3931
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 08:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5424D2821B4
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 07:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F6615B97E;
	Mon, 11 Nov 2024 07:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VKRZ8UQt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E62113AA31
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 07:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731311335; cv=none; b=WJ+Z0AYGrnY7xMhja2ZASqSqhP2j4C6X4wwGhKLD7bDgn9YkJ8+oPDWf2EFqIlXW+Gfs9+sb4Y21KQ91LLiLSwqYooF5HLte3nbOoBvApB7BVKffq/tZL50gHy4T8P+fk/Ac5kcnPE0HzrMzdp+ZrzC8FJTn35sjJ7X2Onv5Wrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731311335; c=relaxed/simple;
	bh=bSBfIDqTKr/wun2GJ+i4SP66bccKn/4dKTv56so+x9k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X0CNRnIVaYzmI4kRCIjT3ePzFyszB0agKsQ7yQnJXPwTxgtxrzPf1nLBgnPMwVZBGWJ8R7PnQch5UCE4XLG6wN055yI4n0P/PR8Qy74ayPbJ86SETO7ELpSnkz2A7hBy7fJKxVWtfX4ElxzOo3fuQYG96MIlySJqvubmC9cruwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=VKRZ8UQt; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1731311333; x=1762847333;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bSBfIDqTKr/wun2GJ+i4SP66bccKn/4dKTv56so+x9k=;
  b=VKRZ8UQtV/v1uWjEvl0Hqz9tZwmsvb8a9iN48o7MVkKvgUQZgnLHBLd3
   dv8EV01B16txxO73IjyhUEu52CVWv6HOUsA5DWOp7gxM39NZwQHp+KAR4
   7pFDgKqmnpaMuFssQMxeiQInVr0QrHYQPzkaiLPuIOairL/XOVKH7FKQp
   PgIujdMzFWXtZ6qZb3xOkkFiNREF/DgzHOuQZBrZ8BMPGi7nFJbcERVfj
   K1ebU6yHIQT4Wyak7MG8R6Kx2K5N3Me9bCiHZQIHiNgK+A0Uly4SWkrga
   NKKw9oHD2p4/7nHo7/oCJnCSEFUyiUEVjw5VFX5BnUrJk1aZYMa71wORS
   w==;
X-CSE-ConnectionGUID: ZfwvAIgJTqGNWjvN/vFrTQ==
X-CSE-MsgGUID: rE9PnzzSR8SsWetVyBzH9A==
X-IronPort-AV: E=Sophos;i="6.12,144,1728921600"; 
   d="scan'208";a="32235393"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2024 15:47:45 +0800
IronPort-SDR: 6731a819_30wEANSgORKjCtOpB4lM7nTAHAbl0dmfGuXahwgtHgiIyJG
 ZdRBf4vtjtNPqWe0ho8AK8LlFyY1rj8GuA3C07Q==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Nov 2024 22:45:46 -0800
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.23])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Nov 2024 23:47:45 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 0/3] btrfs: zoned: implement ZONE_RESET space_info reclaiming
Date: Mon, 11 Nov 2024 16:46:36 +0900
Message-ID: <cover.1731309514.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a longstanding early ENOSPC issue on the zoned mode. When there
are heavy write operations on a nearly ENOSPC file system, freeing up
the space and resetting the zones often cannot catch up the write speed.
That results in an early ENOSPC. For example, running the following fio
script, which repeatedly over-writes 15 GB files on 20 GB file system
results in a ENOSPC shown below.

Fio script:

  [test]
  filename=/mnt/scratch/test
  readwrite=write
  ioengine=libaio
  direct=1
  loops=10
  filesize=15G
  bs=128k

Result:

  BTRFS info (device nvme0n1): cannot satisfy tickets, dumping space info
  BTRFS info (device nvme0n1): space_info DATA has 0 free, is full
  BTRFS info (device nvme0n1): space_info total=20535312384, used=16106127360, pinned=0, reserved=0, may_use=0,
  readonly=0 zone_unusable=4429185024
  BTRFS info (device nvme0n1): failing ticket with 131072 bytes
  BTRFS info (device nvme0n1): space_info DATA has 0 free, is full
  BTRFS info (device nvme0n1): space_info total=20535312384, used=16106127360, pinned=0, reserved=0, may_use=0,
  readonly=0 zone_unusable=4429185024
  BTRFS info (device nvme0n1): global_block_rsv: size 25870336 reserved 25853952
  BTRFS info (device nvme0n1): trans_block_rsv: size 0 reserved 0
  BTRFS info (device nvme0n1): chunk_block_rsv: size 0 reserved 0
  BTRFS info (device nvme0n1): delayed_block_rsv: size 0 reserved 0
  BTRFS info (device nvme0n1): delayed_refs_rsv: size 0 reserved 0
  fio: io_u error on file /mnt/scratch/test: No space left on device: write offset=13287555072, buflen=131072
  fio: pid=869, err=28/file:io_u.c:1962, func=io_u error, error=No space left on device
  ...
  Run status group 0 (all jobs):
    WRITE: bw=113MiB/s (118MB/s), 113MiB/s-113MiB/s (118MB/s-118MB/s), io=27.4GiB (29.4GB), run=248965-248965msec

As the result shows, fio fails only after 27GB. Instead, it should be
able to write 150 GB by freeing over-written region. The space_info
status shows that there is 4.1 GB zone_unusable in the DATA space. While
this space will be eventually freed after a transaction commit and zone
reset, the space_info dump means btrfs is too slow to reuse the zone_unusable.

There are some reasons to hit ENOSPC early and this series only
addresses one of them: unusable block group is not reclaimed enough
fast. This series introduces a new space_info reclaim method
ZONE_RESET. That method will pick a block group in the unused list and
send ZONE_RESET command to free up and reuse the zone_unusable space.

For the first implementation, the ZONE_RESET is only applied to a block
group whose region is fully zone_unusable. Reclaiming partial
zone_unusable block group could be implemented later.

Patches 1 and 2 do the preparation for the patch 3 and there are no
functional change. Patch 3 introduces the new space_info reclaim method
ZONE_RESET described above.

Following series will fully fix ENOSPC issue on the above fio script.
One will separate space_info of regular data and relocation data. And,
another will rework zone resetting of deleted block group to let it set
the empty zone bit early.

Naohiro Aota (3):
  btrfs: introduce btrfs_return_free_space()
  btrfs: drop fs_info argument from btrfs_update_space_info_*
  btrfs: zoned: reclaim unused zone by zone resetting

 fs/btrfs/block-group.c       |  16 ++----
 fs/btrfs/block-rsv.c         |  10 +---
 fs/btrfs/delalloc-space.c    |   2 +-
 fs/btrfs/delayed-ref.c       |   5 +-
 fs/btrfs/extent-tree.c       |  35 +++---------
 fs/btrfs/inode.c             |   2 +-
 fs/btrfs/space-info.c        |  64 +++++++++++++++++----
 fs/btrfs/space-info.h        |  15 +++--
 fs/btrfs/transaction.c       |   3 +-
 fs/btrfs/zoned.c             | 104 +++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h             |   7 +++
 include/trace/events/btrfs.h |   1 +
 12 files changed, 197 insertions(+), 67 deletions(-)

-- 
2.47.0


