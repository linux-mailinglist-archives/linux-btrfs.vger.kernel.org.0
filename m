Return-Path: <linux-btrfs+bounces-9630-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCC39C848A
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 09:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0FFF28531C
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 08:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A511F666B;
	Thu, 14 Nov 2024 08:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GurdA/Gw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEAA1F4FDA
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2024 08:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731571484; cv=none; b=ctr6yhQFiuNxBh+1uAbicYNYV90XaKH81PpmGCu6cdAfoc+/Z5vHxmS8Qfo4FUm/o+Y9GnsFmsaWkASMjOjDejoFI2N3HPvvGMEy6sfz9MTrO9YVviyCvcurT/dr8N16gPu7yipDTvCoBZNi7lhCC/MEtHV2o0EjqJhlIwQCiEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731571484; c=relaxed/simple;
	bh=lblzJr6tSetd9VzjRsAcfwoY/hJedHN/YAkbbDrf6FI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bSdcQ08ftWivnuP7X3mnwjQpv8PNsuUbXzYBdbKEOygBxXMpFE+XliLmzdB21bUnMgJOjZftkYkvfaBftk6xeM6sQoeGvTF7CjlgecADTLmDA1HbUh9hhQjSKd0WJ+ZDRsvcv90owq4guXEU6Y7re/X9h7GauxbuiRt5rnP18lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=GurdA/Gw; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1731571483; x=1763107483;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lblzJr6tSetd9VzjRsAcfwoY/hJedHN/YAkbbDrf6FI=;
  b=GurdA/GwBPbMyqUUytxAr1JuyF6ZZdWEla1aAue7023iDOQzfXfyApxu
   yVgC/0WWHhzp4zd2eaOVuQwlsHnJzaPLTINfMwnvNfqFYkOB2RWS7FFTS
   s7E4MjTYqqGrKVtl3HyBVT+u6330kSyRDK0Vh238OZ1WWhVHkH1q+LyPp
   dPV2iUEp24p3lk/scrBqn7vKkS/1F59/my66ZkqooHUxWG7eazkWY9ScE
   e9wSoNhQ0gMFxQ6G73BcGkEslA55j0R7ACwrh7oe+CeHFlHw3nvv9OQIO
   09fQ4rceA4Fvf64OQJY1suaJzpVr4YORlzFmWrEabcHF/s7GxLO3ZjvbI
   Q==;
X-CSE-ConnectionGUID: 7fQV/mrHR1iqt6KdjXxjTg==
X-CSE-MsgGUID: jaBU/3bYT02zYLgEgeoDPQ==
X-IronPort-AV: E=Sophos;i="6.12,153,1728921600"; 
   d="scan'208";a="31543756"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Nov 2024 16:04:42 +0800
IronPort-SDR: 6735a1d9_AJgEUXPa15c1uckqvccqS4JGpNz11TQ7yFfL0wamY9boPJr
 r/aBszK3st8SPO63y3AMbjq4VsTpxxGwpJUdZaQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Nov 2024 23:08:09 -0800
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.24])
  by uls-op-cesaip01.wdc.com with ESMTP; 14 Nov 2024 00:04:41 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 0/3] btrfs: zoned: implement ZONE_RESET space_info reclaiming
Date: Thu, 14 Nov 2024 17:04:26 +0900
Message-ID: <cover.1731571240.git.naohiro.aota@wdc.com>
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

Changes:
- v2:
  - Use the ordinal locking style.
  - Rewrite btrfs_return_free_space() to reduce indent level.
  - Add some extra comment.
- v1: https://lore.kernel.org/linux-btrfs/gjr4vwt5qm7j36xnjijp5wqttpmh62trhsq5vqeotcqm6kx2pq@qovd36rh7hap/T/

Naohiro Aota (3):
  btrfs: introduce btrfs_return_free_space()
  btrfs: drop fs_info argument from btrfs_update_space_info_*
  btrfs: zoned: reclaim unused zone by zone resetting

 fs/btrfs/block-group.c       |  16 ++---
 fs/btrfs/block-rsv.c         |  10 +--
 fs/btrfs/delalloc-space.c    |   2 +-
 fs/btrfs/delayed-ref.c       |   5 +-
 fs/btrfs/extent-tree.c       |  35 ++--------
 fs/btrfs/inode.c             |   2 +-
 fs/btrfs/space-info.c        |  69 ++++++++++++++++---
 fs/btrfs/space-info.h        |  15 +++--
 fs/btrfs/transaction.c       |   3 +-
 fs/btrfs/zoned.c             | 124 +++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h             |   7 ++
 include/trace/events/btrfs.h |   3 +-
 12 files changed, 223 insertions(+), 68 deletions(-)

-- 
2.47.0


