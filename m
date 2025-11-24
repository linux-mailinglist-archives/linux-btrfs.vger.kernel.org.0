Return-Path: <linux-btrfs+bounces-19306-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A93C822B7
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Nov 2025 19:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B34F84E6CDE
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Nov 2025 18:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236C0319612;
	Mon, 24 Nov 2025 18:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="Px49fQW2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455B92D239A
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Nov 2025 18:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764010416; cv=none; b=tMvtl8CFgfHX+MKsPP8FMEEKJJRb38/dzanmoQKL9/6W2+qaWGrD2Wu/v0dA/bJIQm5ZITqqkRKeNoH8h8OYs1lESiEznxZwG6TRAhSv+msmmOuLgRsIP94QER6uhZYGax5ILMcKq647OCLY1wbnRchYohbiGfOkXNCxeNBaAcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764010416; c=relaxed/simple;
	bh=6eQfowItoiYx8Sk1M9lXe+Br079aw8rowtvuETi5M4I=;
	h=From:To:Cc:Subject:Date:Message-ID:Mime-Version; b=nnzuP+SlALjpBt86MI6zNpGbWPj2y/z0Bk5Xmubkl3Gc9W1h6LxaHEJCo1xcLiv24W31wceSdyFA23+ji1hr4Dk5QNiw8tADiK0E/zjLUMAq3fN6xFyHRnSBI8uo2/cUt9jMmcO0oLra4EQg9Z0Pnhs7O9bELs1tTqw1mj9goMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=Px49fQW2; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from beren (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id B6CCD2DEC58;
	Mon, 24 Nov 2025 18:53:30 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1764010410;
	bh=StDywCNwzbetQh7RBeXOy10POGySdfS3orsaFqSjn6w=;
	h=From:To:Cc:Subject:Date;
	b=Px49fQW2oL6mEgbJIVhDsOuyPJggTtsajXjF05gUjQ/FvHMS004NmLvTCaJaGEdaN
	 5V2ed0ZODiVFi8+70z23XxmYqpeQ66MBpHzBb78m8RcnmRomTZFrDy4BVhOIM5Tzp+
	 y745y1u+VsShsrRDTuNbkdfzWp/Nw4+TgnFc1Qo8=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org
Cc: Mark Harmstone <mark@harmstone.com>
Subject: [PATCH v7 00/16] Remap tree
Date: Mon, 24 Nov 2025 18:52:52 +0000
Message-ID: <20251124185335.16556-1-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit

This is version 7 of the patch series for the new logical remapping tree
feature - see the previous cover letters for more information including
the rationale:

* RFC: https://lore.kernel.org/all/20250515163641.3449017-1-maharmstone@fb.com/
* Version 1: https://lore.kernel.org/all/20250605162345.2561026-1-maharmstone@fb.com/
* Version 2: https://lore.kernel.org/all/20250813143509.31073-1-mark@harmstone.com/
* Version 3: https://lore.kernel.org/all/20251009112814.13942-1-mark@harmstone.com/
* Version 4: https://lore.kernel.org/all/20251024181227.32228-1-mark@harmstone.com/
* Version 5: https://lore.kernel.org/all/20251110171511.20900-1-mark@harmstone.com/
* Version 6: https://lore.kernel.org/all/20251114184745.9304-1-mark@harmstone.com/

Changes since version 6:
* Added new function btrfs_complete_bg_remapping(), to dedupe some code
  in btrfs_handle_fully_remapped_bgs() and
  btrfs_trim_fully_remapped_block_group()
* Rearranged some code in create_remap_tree_entries() to make things
  clearer

Mark Harmstone (16):
  btrfs: add definitions and constants for remap-tree
  btrfs: add REMAP chunk type
  btrfs: allow remapped chunks to have zero stripes
  btrfs: remove remapped block groups from the free-space tree
  btrfs: don't add metadata items for the remap tree to the extent tree
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
 fs/btrfs/accessors.h            |   29 +
 fs/btrfs/bio.c                  |    3 +-
 fs/btrfs/bio.h                  |    3 +
 fs/btrfs/block-group.c          |  306 ++++-
 fs/btrfs/block-group.h          |   25 +-
 fs/btrfs/block-rsv.c            |    8 +
 fs/btrfs/block-rsv.h            |    1 +
 fs/btrfs/discard.c              |   57 +-
 fs/btrfs/disk-io.c              |  125 +-
 fs/btrfs/extent-tree.c          |  152 ++-
 fs/btrfs/extent-tree.h          |    4 +-
 fs/btrfs/free-space-cache.c     |   59 +-
 fs/btrfs/free-space-cache.h     |    1 +
 fs/btrfs/free-space-tree.c      |    4 +-
 fs/btrfs/free-space-tree.h      |    5 +-
 fs/btrfs/fs.h                   |   10 +-
 fs/btrfs/inode.c                |    2 +-
 fs/btrfs/locking.c              |    1 +
 fs/btrfs/relocation.c           | 1889 +++++++++++++++++++++++++++++--
 fs/btrfs/relocation.h           |   18 +
 fs/btrfs/space-info.c           |   22 +-
 fs/btrfs/sysfs.c                |    4 +
 fs/btrfs/transaction.c          |    7 +
 fs/btrfs/tree-checker.c         |   94 +-
 fs/btrfs/tree-checker.h         |    5 +
 fs/btrfs/volumes.c              |  356 +++++-
 fs/btrfs/volumes.h              |   18 +-
 include/uapi/linux/btrfs.h      |    1 +
 include/uapi/linux/btrfs_tree.h |   29 +-
 30 files changed, 2977 insertions(+), 263 deletions(-)

-- 
2.51.0


