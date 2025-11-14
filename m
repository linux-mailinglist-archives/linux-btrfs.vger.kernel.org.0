Return-Path: <linux-btrfs+bounces-19003-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E959C5EF49
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Nov 2025 20:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8B415355DDF
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Nov 2025 18:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6E12DEA93;
	Fri, 14 Nov 2025 18:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="gMD/RHYk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618552DC34E
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Nov 2025 18:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763146087; cv=none; b=To45AowxKbCaXNOzYYSpz2gitCT8XleYwuwOXn995evJHgUcVabXC6UrgrCGFCZAfyvAIXuAoFa3d6n3ELFSxhdnrsXo1R1VXZN+3S1mjJMgO9Iu7ApKr6TQ49hARSuwxHopdJpIBnA7Me2pQjOUC5SSwPezeQfMQm1gZHMDgpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763146087; c=relaxed/simple;
	bh=81fizZ4wnTtz/HHmlZuwTWL5tdJLDBPoDhrW6q1H9z0=;
	h=From:To:Cc:Subject:Date:Message-ID:Mime-Version; b=VPPcR5hdjG6gTWKuxUTl09sMhO7bXCEZA3By7JKfB0qH2FImvdnzeMXpqXyNNTrIAgAl+UJTbIJ9vvFzupWzest7LOEhS7HZKSmo+p9pE4ik9t1e++Yt9Hw4dcNOCldTgMz8MlU1Gs0uy5GtO4tpMdK8J7qTPE2pvg7MiSyR7gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=gMD/RHYk; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from beren (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id DB55C2DAAFE;
	Fri, 14 Nov 2025 18:47:51 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1763146071;
	bh=ebUnPYw5uwZ+LdXrvZJ8BjntvjXxvMPaYMn32yYpNm0=;
	h=From:To:Cc:Subject:Date;
	b=gMD/RHYkJ42bwUUkcTOlabmg+A32dU/S1wBF94RkPMaMX0f95BSRAnl4/RTFFJmAf
	 Q/Q6gbP3VpDaOpCgLx5znF6h8NkNlGcSc+M44M1Qtu7ihnUVpkdbDAqAN5QqAp8Fim
	 Y164/eu6LW5dvMc8a9MmEDrtESpuRuydkGv6O7LM=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org
Cc: Mark Harmstone <mark@harmstone.com>
Subject: [PATCH v6 00/16] Remap tree
Date: Fri, 14 Nov 2025 18:47:05 +0000
Message-ID: <20251114184745.9304-1-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit

This is version 6 of the patch series for the new logical remapping tree
feature - see the previous cover letters for more information including
the rationale:

* RFC: https://lore.kernel.org/all/20250515163641.3449017-1-maharmstone@fb.com/
* Version 1: https://lore.kernel.org/all/20250605162345.2561026-1-maharmstone@fb.com/
* Version 2: https://lore.kernel.org/all/20250813143509.31073-1-mark@harmstone.com/
* Version 3: https://lore.kernel.org/all/20251009112814.13942-1-mark@harmstone.com/
* Version 4: https://lore.kernel.org/all/20251024181227.32228-1-mark@harmstone.com/
* Version 5: https://lore.kernel.org/all/20251110171511.20900-1-mark@harmstone.com/

Changes since version 5:

* Fixed locking in btrfs_handle_fully_remapped_bgs()
* btrfs_mark_bg_fully_remapped() now puts BGs straight onto discard list if
  using async discard, rather than fully_remapped_bgs
* Now using btrfs_mark_bg_unused() rather than a reimplementation of it
* Fixed potential race between btrfs_handle_fully_remapped_bgs() and
  btrfs_delete_unused_bgs()
* Non-async discard call to btrfs_handle_fully_remapped_bgs() moved from
  transaction commit to cleaner thread
* Fixed reservation of SYSTEM chunk metadata
* Reservations now done before starting a transaction to mark a block group
  fully remapped
* Some other niggles that Boris pointed out

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
 fs/btrfs/extent-tree.c          |  129 ++-
 fs/btrfs/extent-tree.h          |    3 +-
 fs/btrfs/free-space-cache.c     |   78 +-
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
 fs/btrfs/volumes.c              |  356 +++++-
 fs/btrfs/volumes.h              |   18 +-
 include/uapi/linux/btrfs.h      |    1 +
 include/uapi/linux/btrfs_tree.h |   29 +-
 30 files changed, 2968 insertions(+), 263 deletions(-)

-- 
2.51.0


