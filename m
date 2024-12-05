Return-Path: <linux-btrfs+bounces-10074-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DA29E4EEA
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2024 08:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E04E18817D9
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2024 07:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AA91B87F5;
	Thu,  5 Dec 2024 07:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Y8xK9DrZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01201AB517
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Dec 2024 07:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733385014; cv=none; b=ShAzkUZDkiK6M8fxqs93hG/NOx6UnKG8lTxEfnpe9OfSvkAWOiNtOYPXREUu4fBrelbqvnGmH4tHCuF8bPu8mdBkwUXYX99FfZSva5T/7GbUllebZG+GfDy24qlaphbd8fBkpbmEAUDnj0XQgPxnl3oRX80EYgFsrDNH1A57k5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733385014; c=relaxed/simple;
	bh=fvpwA575vHGzU0h8R6gzJsG7IhjJu0AHYWwMstEvx38=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bp2/vVezYF2gBWRcRDtek/hlpjwPVAAcHB/ayMkTxWFq2zQsbSTpI5iNMlk10+VS//fjM6Oikf5HftKe4Vzi1SPrQXGHThJUd3SIJlsEGEnY1rloeNMP+Wmm52OAO1K8uU5SM4gAHWUw+z8KdOOYCDgphiEPrOeLPL0eR6TDlng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Y8xK9DrZ; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1733385012; x=1764921012;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fvpwA575vHGzU0h8R6gzJsG7IhjJu0AHYWwMstEvx38=;
  b=Y8xK9DrZiwWCEGtnO+esJDMi9n0TjZT0qy9xfhxhobGZ/W65aJwHmlqK
   xW5h/XJj409iNPFhawYYov6uvwIiyRqzekyMvlqnmgq9TltXD2Y8f1p2g
   5Zc8OaOEuwV/Gpw+LtpF5jkHgtyLE2SuXwt3OZAfAORZZu66iBCWz4JpC
   7JZc690qaJBjExmMK5M0fUaeF697cg/Ze+vfcvNQFnqtioBm4xVYwARRT
   I486DdZs/YSCaAYeitoApuBvP5jZpN3YXPBG33GU4Zmv4hYZ68mu6lzQ6
   yJ9ArM/2Z2r/FihjWr12XNSFblg+XaZX5OTVmx71VSGsC1gD4cx77+zXS
   Q==;
X-CSE-ConnectionGUID: 0MlW1WPASKON6g4f+Sn7aA==
X-CSE-MsgGUID: vWgXJlVWTXyr4RvfX4zh4Q==
X-IronPort-AV: E=Sophos;i="6.12,209,1728921600"; 
   d="scan'208";a="32978280"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Dec 2024 15:49:04 +0800
IronPort-SDR: 67514d96_K9zTEpIvcSTes2VwD+2aAIwgHL8Hlir+fxSRn9E0ECvMlUk
 UNNRIhaoBr/pI5jOizqi/MazEh7dMmIV7QS6ehw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Dec 2024 22:52:06 -0800
WDCIronportException: Internal
Received: from naota-x1.dhcp.fujisawa.hgst.com (HELO naota-x1.ad.shared) ([10.89.81.175])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Dec 2024 23:49:04 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 00/11] btrfs: zoned: split out data relocation space_info
Date: Thu,  5 Dec 2024 16:48:16 +0900
Message-ID: <cover.1733384171.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.47.1
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
relocation block group.

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

Naohiro Aota (11):
  btrfs: take btrfs_space_info in btrfs_reserve_data_bytes
  btrfs: take struct btrfs_inode in
    btrfs_free_reserved_data_space_noquota
  btrfs: factor out init_space_info()
  btrfs: spin out do_async_reclaim_data_space()
  btrfs: factor out check_removing_space_info()
  btrfs: introduce space_info argument to btrfs_chunk_alloc
  btrfs: pass space_info for block group creation
  btrfs: introduce btrfs_space_info sub-group
  btrfs: tweak extent/chunk allocation for space_info sub-space
  btrfs: use proper data space_info
  btrfs: reclaim from data sub-space space_info

 fs/btrfs/block-group.c    | 89 ++++++++++++++++++++++++---------------
 fs/btrfs/block-group.h    |  5 ++-
 fs/btrfs/delalloc-space.c | 26 ++++++++----
 fs/btrfs/delalloc-space.h |  3 +-
 fs/btrfs/extent-tree.c    |  5 ++-
 fs/btrfs/inode.c          |  4 +-
 fs/btrfs/relocation.c     |  3 +-
 fs/btrfs/space-info.c     | 84 ++++++++++++++++++++++++------------
 fs/btrfs/space-info.h     | 10 ++++-
 fs/btrfs/sysfs.c          | 16 +++++--
 fs/btrfs/transaction.c    |  2 +-
 fs/btrfs/volumes.c        | 16 ++++---
 fs/btrfs/volumes.h        |  2 +-
 13 files changed, 176 insertions(+), 89 deletions(-)

-- 
2.47.1


