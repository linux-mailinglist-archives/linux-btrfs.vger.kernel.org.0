Return-Path: <linux-btrfs+bounces-12404-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F8CA684F6
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 07:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B2D44250AD
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 06:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1E624EAB1;
	Wed, 19 Mar 2025 06:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="o7Mesyjb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A68E2066D6
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Mar 2025 06:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742364900; cv=none; b=TvfN5zlwEEF6Ivx4GTu+ndza9Hq33GX8oEO4YDiAurpNS3YzLX2YhXGO7kKzy/KWxcytq+X1bRH/oSS3E9Idr3lpFN4PAsNJX4EOWTtcAIc+lITSGXYr9MVE5elm6IXaTnGuXfgGAQmIHF0ew6b5sENZCClxegMAS++JJC0R+Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742364900; c=relaxed/simple;
	bh=TSwYq1LH9ATaLMwsigj3WjdNbR04Py8LrBwQrVIQXro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KjNHzeQ+KM+qsZueeC2QiHpWQQLt00OzggcScbm1wRbDpjO+/wEHmmhh6yBwPPDcDNqLPH5X4DenR9d9GW2Vs5RBFgo+rYjOU5qqoqyxC0cb3j0cNhXIiYp25Ljuziav2uOKaE4fE8LHuMZJ6zzXpgA8SveoWP1A7uSAgEMktjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=o7Mesyjb; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1742364898; x=1773900898;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TSwYq1LH9ATaLMwsigj3WjdNbR04Py8LrBwQrVIQXro=;
  b=o7MesyjbNKhbGGk9o5WFQTCzOlLHwFWqnWqp3MwoIGc1FnABFn90/ZHw
   4aAvYwLHotvBBrJk0fvT0o1B4bTGDI31u2IA4EvDmrb1ZlrtbGB/r0wh+
   RXXq4v4brHEb+tk7w1TEX0lV+6rWWz21U4Xt3loV0W99q7vU1hrV256h2
   XEE5gYcVVVka4HzBYx0VSf1sNzup1li41C7WYu1WZGSWaNkFKALxLB1fr
   6ubK+SqnpVDCLoD2fYRIOz1ie8GgbhhjXG2ymhGfOQ4fEncuK3sX/7Gwz
   TCRLqnmE0XljuHEvX62lQk+vkbUfCCngTXZwCuYkn2QRrveW1bM8fSqNI
   w==;
X-CSE-ConnectionGUID: PitlMqmaQZSqdTCwsFhMfg==
X-CSE-MsgGUID: MJdA0wy9TWmnXroTbaz7Dw==
X-IronPort-AV: E=Sophos;i="6.14,258,1736784000"; 
   d="scan'208";a="55227091"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Mar 2025 14:14:57 +0800
IronPort-SDR: 67da5301_pq9vV8Wi8XOfots7kg/b4GCm0vBshrK8O0k7UxT+qm1Wi80
 bPU9/M8aZTjhZmXyXuMdM79YQAuLS68nzBmHdKA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Mar 2025 22:15:45 -0700
WDCIronportException: Internal
Received: from gbdn3z2.ad.shared (HELO naota-xeon..) ([10.224.109.136])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Mar 2025 23:14:56 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 00/13] btrfs: zoned: split out space_info for dedicated block groups
Date: Wed, 19 Mar 2025 15:14:31 +0900
Message-ID: <cover.1742364593.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As discussed in [1], there is a longstanding early ENOSPC issue on the
zoned mode even with simple fio script. This is also causing blktests
zbd/009 to fail [2].

[1] https://lore.kernel.org/linux-btrfs/cover.1731571240.git.naohiro.aota@wdc.com/
[2] https://github.com/osandov/blktests/issues/150

This series is the second part to fix the ENOSPC issue. This series
introduces "space_info sub-space" and use it split a space_info for data
relocation block group and metadata tree-log block group.

Current code assumes we have only one space_info for each block group type
(DATA, METADATA, and SYSTEM). We sometime needs multiple space_info to
manage special block groups.

One example is handling the data relocation block group for the zoned mode.
That block group is dedicated for writing relocated data and we cannot
allocate any regular extent from that block group, which is implemented in
the zoned extent allocator. That block group still belongs to the normal
data space_info. So, when all the normal data block groups are full and
there are some free space in the dedicated block group, the space_info
looks to have some free space, while it cannot allocate normal extent
anymore. That results in a strange ENOSPC error. We need to have a
space_info for the relocation data block group to represent the situation
properly.

Changes:
- v2:
  - Add tree-log sub-space_info implementation.
  - Some spell and style fix.
- v1: https://patch.msgid.link/cover.1733384171.git.naohiro.aota@wdc.com

Naohiro Aota (13):
  btrfs: take btrfs_space_info in btrfs_reserve_data_bytes
  btrfs: take struct btrfs_inode in
    btrfs_free_reserved_data_space_noquota
  btrfs: factor out init_space_info()
  btrfs: spin out do_async_reclaim_{data,metadata}_space()
  btrfs: factor out check_removing_space_info()
  btrfs: introduce space_info argument to btrfs_chunk_alloc
  btrfs: pass space_info for block group creation
  btrfs: introduce btrfs_space_info sub-group
  btrfs: introduce tree-log sub-space_info
  btrfs: tweak extent/chunk allocation for space_info sub-space
  btrfs: use proper data space_info
  btrfs: add block_rsv for treelog
  btrfs: reclaim from sub-space space_info

 fs/btrfs/block-group.c    |  89 +++++++++++++++-----------
 fs/btrfs/block-group.h    |   5 +-
 fs/btrfs/block-rsv.c      |  12 ++++
 fs/btrfs/block-rsv.h      |   1 +
 fs/btrfs/delalloc-space.c |  26 +++++---
 fs/btrfs/delalloc-space.h |   3 +-
 fs/btrfs/disk-io.c        |   1 +
 fs/btrfs/extent-tree.c    |  20 ++++--
 fs/btrfs/fs.h             |   2 +
 fs/btrfs/inode.c          |   4 +-
 fs/btrfs/relocation.c     |   3 +-
 fs/btrfs/space-info.c     | 128 +++++++++++++++++++++++++++-----------
 fs/btrfs/space-info.h     |  11 +++-
 fs/btrfs/sysfs.c          |  26 ++++++--
 fs/btrfs/transaction.c    |   2 +-
 fs/btrfs/volumes.c        |  16 +++--
 fs/btrfs/volumes.h        |   2 +-
 17 files changed, 247 insertions(+), 104 deletions(-)

-- 
2.49.0


