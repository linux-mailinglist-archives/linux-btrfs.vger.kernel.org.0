Return-Path: <linux-btrfs+bounces-18297-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D9DC07ABF
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 20:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBC813B0F7E
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 18:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9560E347BAC;
	Fri, 24 Oct 2025 18:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="x+LJnWUp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875E3346E70
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 18:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761329561; cv=none; b=M94zhEdWLK74Slzn+Sc93ciW92PEaYq1CSIFUcjfp0b2Q+w8cOXNt6uzXgKiGDm/6UwILx5j+ZIpC9QITmS4nDRKfzsp+0EjZmaTQ1WdRovJ3lOTqSXXwOuU/D13ndqsAbLcYrHx4NKRI9dkqcW5MJjYQgVboW1Lr/LzVUhzYt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761329561; c=relaxed/simple;
	bh=kwUcUeZQg6IA7HxGHWL0kKgkEJojHea+Qke21/YK1YY=;
	h=From:To:Cc:Subject:Date:Message-ID:Mime-Version; b=M7pNUrlWeA7/2Y2Bpyi2diWvYtICu70R8lIw4YRnzgjKpVcxyC0VT3ttBJfjFK6A+LJ+58sxpkKkFrjg66t94iDGejDit1+5bm47o9CSBW4Lf5hPiCNcBTaXSJOVH4emlD1OEnKrOqqk6VhVVQ8SOP0JRw209sMD7ZSuvohDOj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=x+LJnWUp; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from localhost.localdomain (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id 277262CFE45;
	Fri, 24 Oct 2025 19:12:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1761329550;
	bh=cgXrLMSleRBLceW6/yNM7UeH/TvOLsZwVO/mRj8NR+w=;
	h=From:To:Cc:Subject:Date;
	b=x+LJnWUp0Oo5syio2dAClIIjGDGdbqYTIGzX9ugT2kZczJEiNzefEF4Y5e+aPWVeF
	 bcmbupoC2EHVYaWJ3YEhSCFbNk0E7JqQFh0RnRn89JiRypOOPd2di3VstN8gy4TaGu
	 f6qDJetWMUb0sIASly2rAIGscp1Yj0rEg4JoaBeE=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org
Cc: Mark Harmstone <mark@harmstone.com>
Subject: [PATCH v4 00/16] Remap tree
Date: Fri, 24 Oct 2025 19:12:01 +0100
Message-ID: <20251024181227.32228-1-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit

This is version 4 of the patch series for the new logical remapping tree
feature - see the previous cover letters for more information including
the rationale:

* RFC: https://lore.kernel.org/all/20250515163641.3449017-1-maharmstone@fb.com/
* Version 1: https://lore.kernel.org/all/20250605162345.2561026-1-maharmstone@fb.com/
* Version 2: https://lore.kernel.org/all/20250813143509.31073-1-mark@harmstone.com/
* Version 3: https://lore.kernel.org/all/20251009112814.13942-1-mark@harmstone.com/

Changes since version 3:
* Removed search_commit_root code for now
* In-memory free-space tree gets cleared for newly remapped block groups
  when on-disk version does
* Made it so that btrfs_mark_bg_fully_remapped() can't run twice on same
  block group
* Removed now-superfluous divide-by-zero check
* Used block group spinlock to protect remap fields
* Fixed async discard looping over empty block group
* Fixed redundant remap_bytes == 0 checks on remapped block group
* Fixed async discard not throttling correctly for remapped block groups
* Added block_group_is_empty() helper function
* Removed patch "btrfs: release BG lock before calling btrfs_link_bg_list()",
  now not needed

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
  btrfs: add stripe removal pending flag

 fs/btrfs/Kconfig                |    2 +
 fs/btrfs/accessors.h            |   29 +
 fs/btrfs/block-group.c          |  280 ++++-
 fs/btrfs/block-group.h          |   23 +-
 fs/btrfs/block-rsv.c            |    8 +
 fs/btrfs/block-rsv.h            |    1 +
 fs/btrfs/discard.c              |   57 +-
 fs/btrfs/disk-io.c              |  107 +-
 fs/btrfs/extent-tree.c          |  137 ++-
 fs/btrfs/extent-tree.h          |    3 +-
 fs/btrfs/free-space-cache.c     |   82 +-
 fs/btrfs/free-space-cache.h     |    1 +
 fs/btrfs/free-space-tree.c      |    4 +-
 fs/btrfs/free-space-tree.h      |    5 +-
 fs/btrfs/fs.h                   |   10 +-
 fs/btrfs/inode.c                |    2 +-
 fs/btrfs/locking.c              |    1 +
 fs/btrfs/relocation.c           | 1866 ++++++++++++++++++++++++++++++-
 fs/btrfs/relocation.h           |   10 +-
 fs/btrfs/space-info.c           |   22 +-
 fs/btrfs/sysfs.c                |    4 +
 fs/btrfs/transaction.c          |   11 +
 fs/btrfs/tree-checker.c         |   94 +-
 fs/btrfs/tree-checker.h         |    5 +
 fs/btrfs/volumes.c              |  283 ++++-
 fs/btrfs/volumes.h              |   19 +-
 include/uapi/linux/btrfs.h      |    1 +
 include/uapi/linux/btrfs_tree.h |   30 +-
 28 files changed, 2889 insertions(+), 208 deletions(-)

-- 
2.49.1


