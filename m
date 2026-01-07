Return-Path: <linux-btrfs+bounces-20195-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC428CFE3D5
	for <lists+linux-btrfs@lfdr.de>; Wed, 07 Jan 2026 15:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFEB430ACE23
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jan 2026 14:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050FC32E686;
	Wed,  7 Jan 2026 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="CjfxUAhw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B2D32AAC4
	for <linux-btrfs@vger.kernel.org>; Wed,  7 Jan 2026 14:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795030; cv=none; b=Ktysh8IfspxJG5dAr5BD+8t69HNKe4DsryO1r7FPJvEE4APOpqDGE95Y42zyVtLoOIOFUXp+M0J0nhMxuOtVjyTZ4uiq8wzagVIdDR1AmDeLF7fJeaXcOFJPn+/UhiFAN8iF5ntx4+bD4j8yFbmT+fY64fouvCzhrEAPQo+bVX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795030; c=relaxed/simple;
	bh=HIVbceCIUeBVD9va7KPG+c7NVENDWRMqcVs2JUGmF5E=;
	h=From:To:Cc:Subject:Date:Message-ID:Mime-Version; b=fuheLRget7kGcmwAp3hv++CJiUcd6yNILVOaJFTNBoQTum7FSrTYU3nm88WTgkrxuLu5sumVL4cbPz38Usobx8BTikKkXT7aSxK5mIlUzHe5JZGCRkgcc7cgw7foxu7rk0emyanT5a2UulMvUGu7SeN90DEtVB+csfQVWXyEIuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=CjfxUAhw; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from beren (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id 021C82F1866;
	Wed,  7 Jan 2026 14:10:17 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1767795018;
	bh=DXAp8aSsI40k093Y43/H4xzJqstkGNs9UN4DREhTiT4=;
	h=From:To:Cc:Subject:Date;
	b=CjfxUAhwAhyR7BBK12jjGEqXGDeQy/k5MKzhnJ+sS16KwcecummZRUXuYz8jnX7qt
	 8C8DmYApLuENJug7bTekZ4+7mhzTfEZ2cy9mCdgp+3vydtBFNtfMGGby2KJwWWMSPk
	 vdBFnfBbzQyq/C8vYU0FZkO0LYgPQFJjCBh4BINU=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org
Cc: Mark Harmstone <mark@harmstone.com>
Subject: [PATCH v8 00/17] Remap tree
Date: Wed,  7 Jan 2026 14:09:00 +0000
Message-ID: <20260107141015.25819-1-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit

This is version 8 of the patch series for the new logical remapping tree
feature - see the previous cover letters for more information including
the rationale:

* RFC: https://lore.kernel.org/all/20250515163641.3449017-1-maharmstone@fb.com/
* Version 1: https://lore.kernel.org/all/20250605162345.2561026-1-maharmstone@fb.com/
* Version 2: https://lore.kernel.org/all/20250813143509.31073-1-mark@harmstone.com/
* Version 3: https://lore.kernel.org/all/20251009112814.13942-1-mark@harmstone.com/
* Version 4: https://lore.kernel.org/all/20251024181227.32228-1-mark@harmstone.com/
* Version 5: https://lore.kernel.org/all/20251110171511.20900-1-mark@harmstone.com/
* Version 6: https://lore.kernel.org/all/20251114184745.9304-1-mark@harmstone.com/
* Version 7: https://lore.kernel.org/all/20251124185335.16556-1-mark@harmstone.com/

Changes since version 7:
* renamed struct btrfs_remap to struct btrfs_remap_item
* renamed BTRFS_BLOCK_GROUP_FLAGS_REMAP to BTRFS_BLOCK_GROUP_FLAGS_METADATA_REMAP
* added unlikelies
* renamed new commit_* fields in struct btrfs_block_group to last_*, and added
  new patch renaming existing commit_used to last_used to match
* merged do_copy() into copy_remapped_data()
* initialized on-stack struct btrfs_remap_items
* fixed comments
* added other minor changes as suggested by David Sterba

Mark Harmstone (17):
  btrfs: add definitions and constants for remap-tree
  btrfs: add METADATA_REMAP chunk type
  btrfs: allow remapped chunks to have zero stripes
  btrfs: remove remapped block groups from the free-space tree
  btrfs: don't add metadata items for the remap tree to the extent tree
  btrfs: rename struct btrfs_block_group field commit_used to last_used
  btrfs: add extended version of struct block_group_item
  btrfs: allow mounting filesystems with remap-tree incompat flag
  btrfs: redirect I/O for remapped block groups
  btrfs: handle deletions from remapped block group
  btrfs: handle setting up relocation of block group with remap-tree
  btrfs: move existing remaps before relocating block group
  btrfs: replace identity remaps with actual remaps when doing
    relocations
  btrfs: add do_remap param to btrfs_discard_extent()
  btrfs: allow balancing remap tree
  btrfs: handle discarding fully-remapped block groups
  btrfs: populate fully_remapped_bgs_list on mount

 fs/btrfs/Kconfig                |    2 +
 fs/btrfs/accessors.h            |   30 +
 fs/btrfs/bio.c                  |    3 +-
 fs/btrfs/bio.h                  |    3 +
 fs/btrfs/block-group.c          |  323 ++++--
 fs/btrfs/block-group.h          |   29 +-
 fs/btrfs/block-rsv.c            |    9 +
 fs/btrfs/block-rsv.h            |    1 +
 fs/btrfs/discard.c              |   57 +-
 fs/btrfs/disk-io.c              |  130 ++-
 fs/btrfs/extent-tree.c          |  151 ++-
 fs/btrfs/extent-tree.h          |    4 +-
 fs/btrfs/free-space-cache.c     |   59 +-
 fs/btrfs/free-space-cache.h     |    1 +
 fs/btrfs/free-space-tree.c      |    4 +-
 fs/btrfs/free-space-tree.h      |    5 +-
 fs/btrfs/fs.h                   |   10 +-
 fs/btrfs/inode.c                |    2 +-
 fs/btrfs/locking.c              |    1 +
 fs/btrfs/relocation.c           | 1885 +++++++++++++++++++++++++++++--
 fs/btrfs/relocation.h           |   18 +
 fs/btrfs/space-info.c           |   22 +-
 fs/btrfs/sysfs.c                |    4 +
 fs/btrfs/transaction.c          |    7 +
 fs/btrfs/tree-checker.c         |   94 +-
 fs/btrfs/tree-checker.h         |    5 +
 fs/btrfs/volumes.c              |  355 +++++-
 fs/btrfs/volumes.h              |   18 +-
 include/uapi/linux/btrfs.h      |    1 +
 include/uapi/linux/btrfs_tree.h |   34 +-
 30 files changed, 2991 insertions(+), 276 deletions(-)

-- 
2.51.2


