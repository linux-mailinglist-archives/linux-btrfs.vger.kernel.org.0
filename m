Return-Path: <linux-btrfs+bounces-13076-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A49DA90673
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 16:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10612188EB8F
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 14:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA6D1AC892;
	Wed, 16 Apr 2025 14:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="k97Kp2pL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AEE1AAA1C
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 14:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744813715; cv=none; b=Gh58Thk97g9FAZUSeq3uQSx5GLdk/dJjbKqY0VmTHAsDhX4B27dFNuvofeEFhunvfPKNwF8NIDGxHpdFoo2zY8TF6WJx5TZ8vcn/DF/I5LW5cSNiOXZ2bKAhwdBa+ienGB/BXP7W/MEr1CnqW4MGDEz1QPQaHAHT2G7Czne7OjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744813715; c=relaxed/simple;
	bh=mDzM0jNiRCEtswp5daYti0Pt6fANJrZ+ApYILXJo2sk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ov3MoirzverrTx4+x6+3QGWicnsHifRnVfaIq5Y9Z2dsEBCys7YWWpA/xxF6sc2DuXBmbno+5l7yXDU08gQaa6KKJBNJtapfEVYGqx5b1wG7sL0cm2Fxb/jBVET1Gpl++SBpC/zmSUXTyhfvUHEiThWS+uKpX2KGKI0ZNZx7RlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=k97Kp2pL; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1744813713; x=1776349713;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mDzM0jNiRCEtswp5daYti0Pt6fANJrZ+ApYILXJo2sk=;
  b=k97Kp2pLBVPqQQHm5HuXSXcmCHHQcS7TTykB6nlPt1cCwrQa4P65M3JF
   smfnqPJJ1e8oPiD7sEisygzUPOX2WdBEMPjWjuxIzWQocHv8mZu23lgxw
   LRnH1Z4k1s1BTu6HArZbcToaBA3RsT04Q0bDCVko42pCXnLOrn91gVpvm
   taKJuaW58+Bouv7Pa0FsxsLX+bl86moE9vpzabYmpoRlarZ0s04qLCzx/
   RgIgh3nEfG3UiM+rE5iSptLRuq0ZPNq0X/Fwcw46zA8fh4SM2301AmFiO
   tbG3HhFs3cmu11rGygXgL7lblwtZx2XVGYsdGOPeCi+QrAioSINP1kuXo
   g==;
X-CSE-ConnectionGUID: pyW8bKsMQ3WijvKPOPrp/w==
X-CSE-MsgGUID: OhjcQ/sqTge9JaxqJjoLkQ==
X-IronPort-AV: E=Sophos;i="6.15,216,1739808000"; 
   d="scan'208";a="81484517"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2025 22:28:26 +0800
IronPort-SDR: 67ffb07c_Do8+LNq3lfyQKCeF59tjG8aAovITLygdvAXrw9OBc2uksCm
 8jVHrPljK4r/r2A8M5n90eJyqnCuqeiE5E+6jjw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Apr 2025 06:28:29 -0700
WDCIronportException: Internal
Received: from 5cg2075gjp.ad.shared (HELO naota-xeon..) ([10.224.104.89])
  by uls-op-cesaip01.wdc.com with ESMTP; 16 Apr 2025 07:28:26 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 00/13] btrfs: zoned: split out space_info for dedicated block groups
Date: Wed, 16 Apr 2025 23:28:05 +0900
Message-ID: <cover.1744813603.git.naohiro.aota@wdc.com>
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
- v3: 
  - Add proper error handling at ASSERT in btrfs_create_chunk
  - Move the loop on sub_group into check_removing_space_info() 
  - Introduce create_space_info_sub_group() to create sub_group
    space_info.
  - Format fix.
- v2: https://patch.msgid.link/cover.1742364593.git.naohiro.aota@wdc.com
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

 fs/btrfs/block-group.c    |  99 +++++++++++++++++-----------
 fs/btrfs/block-group.h    |   7 +-
 fs/btrfs/block-rsv.c      |  12 ++++
 fs/btrfs/block-rsv.h      |   1 +
 fs/btrfs/delalloc-space.c |  24 ++++---
 fs/btrfs/delalloc-space.h |   3 +-
 fs/btrfs/disk-io.c        |   1 +
 fs/btrfs/extent-tree.c    |  20 ++++--
 fs/btrfs/fs.h             |   2 +
 fs/btrfs/inode.c          |   4 +-
 fs/btrfs/relocation.c     |   3 +-
 fs/btrfs/space-info.c     | 134 ++++++++++++++++++++++++++++----------
 fs/btrfs/space-info.h     |  11 +++-
 fs/btrfs/sysfs.c          |  26 ++++++--
 fs/btrfs/transaction.c    |   2 +-
 fs/btrfs/volumes.c        |  22 +++++--
 fs/btrfs/volumes.h        |   3 +-
 17 files changed, 267 insertions(+), 107 deletions(-)

-- 
2.49.0


