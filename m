Return-Path: <linux-btrfs+bounces-13256-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD8DA97CE6
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 04:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3561178B29
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 02:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095AC2641F9;
	Wed, 23 Apr 2025 02:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="X6rK4aB/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1A31F4CB6
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 02:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745376263; cv=none; b=QzPcXbQrg7qbYpzAb0ldvCwhxpF/zb9ZDwULX25qjsmLAumPkBRYUVy1dD0l4Mpi973rbfG4dSZe+OgtZmbqAfabYmXRVo3qIk9guVpH/qC5zv4oC17Rc5p2Tf/8xLkX77zi/oWuZvwUof+TPoicnc5Cje4p9MkL4uyUa832XC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745376263; c=relaxed/simple;
	bh=3zWH763VKi7cQyB74aFMvrzuDPVxhKGlbKgZ+oB3fcg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G5zMKwHm3LWOFRYQfZN21QcPRXuwV24pY6Lu2Fqj8Poacj0JuvAX6kW1kKv/froKHH5y8NWRvlrA7y4hRKNjcR+XF/sHVbc6rg8mSUzAUp9jMjPHa/gEmuaCZtdT8iWICSpGTBytKBxLxvUS/x7II7T0WWOKii3+SWePR8Aqj6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=X6rK4aB/; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1745376261; x=1776912261;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3zWH763VKi7cQyB74aFMvrzuDPVxhKGlbKgZ+oB3fcg=;
  b=X6rK4aB/kGXWipLnVLbDser5FFBu9ZAlZVpA7tSDVL92oUJg5m5oNhFy
   Cea5h9ZtzaCzDKapt+qrh0k6A5Dgg+kYJvkq0w2UldemDlzyUKLwKw9FP
   K3e8BN03iR9+ZfNW7t0G7/zGzuUAKrKGEgJwUHSuTxUVyD2u+eg6s5gcJ
   XdeJnA6KifywKYJI4EyZMNsQU+dx7JQDZnrEqg3utEvpyzRztfmmxuLSZ
   RH/tD/5W7UMDbzHpBoyyeXG0jT2O039iJVH7b+8NUeK06Kl8gZr3rAt7w
   PKcVLvJPwpHIbDdv6MQgIPSkj/XgyDw/09VQSAcIbBrJDA4yOV7ZUBKKE
   Q==;
X-CSE-ConnectionGUID: NEwnT8SVS7m9q3IJxSWhyA==
X-CSE-MsgGUID: iudLkvqeQf+50Jr93Kc6cw==
X-IronPort-AV: E=Sophos;i="6.15,232,1739808000"; 
   d="scan'208";a="83011831"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Apr 2025 10:44:14 +0800
IronPort-SDR: 680845e6_rL1H6EPi/FgmWaniUEgXWnkPSXQ+3XllaWp47auYaZxFj31
 0UREVMoKqo+mlzVg2oDKILSQXqCjtz5hciVmFVA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Apr 2025 18:44:06 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon..) ([10.224.173.39])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Apr 2025 19:44:14 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v4 00/13] btrfs: zoned: split out space_info for dedicated block groups
Date: Wed, 23 Apr 2025 11:43:40 +0900
Message-ID: <cover.1745375070.git.naohiro.aota@wdc.com>
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
- v4:
  - Pass down space_info from top of call tree, instead querying it at the bottom.
  - Make BTRFS_SUB_GROUP_* id distinct.
  - Use treelog_rsv on regular btrfs too.
  - Fix NULL dereference bug.
  - Some format and commit log fix.
- v3: https://patch.msgid.link/cover.1744813603.git.naohiro.aota@wdc.com 
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

 fs/btrfs/block-group.c    | 123 ++++++++++++++++++---------
 fs/btrfs/block-group.h    |   7 +-
 fs/btrfs/block-rsv.c      |  11 +++
 fs/btrfs/block-rsv.h      |   1 +
 fs/btrfs/delalloc-space.c |  27 ++++--
 fs/btrfs/delalloc-space.h |   3 +-
 fs/btrfs/disk-io.c        |   1 +
 fs/btrfs/extent-tree.c    |  20 ++++-
 fs/btrfs/fs.h             |   2 +
 fs/btrfs/inode.c          |   4 +-
 fs/btrfs/relocation.c     |   3 +-
 fs/btrfs/space-info.c     | 169 ++++++++++++++++++++++++++------------
 fs/btrfs/space-info.h     |  11 ++-
 fs/btrfs/sysfs.c          |  27 +++++-
 fs/btrfs/transaction.c    |   5 +-
 fs/btrfs/volumes.c        |  36 ++++++--
 fs/btrfs/volumes.h        |   3 +-
 17 files changed, 328 insertions(+), 125 deletions(-)

-- 
2.49.0


