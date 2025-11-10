Return-Path: <linux-btrfs+bounces-18827-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25418C4844D
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Nov 2025 18:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 391D63A53B1
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Nov 2025 17:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76DD28D82A;
	Mon, 10 Nov 2025 17:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="SUQYKBHf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709BE26C39F
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Nov 2025 17:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762794926; cv=none; b=Pff/c3k3DKmK47aBJ3XXA71wT0b6cFvZ6TDtTeCZwkAa51Kf2HZni958OisYxJxac7ILJEgGxd3SKv0w7wIW4AjYxhq5paEc1+LvF14/pdiSHd0UGmCp4MVhjzg4tZQCsuBqW4furnqrJ+mTu5pzyPTxYrOebT1MGE8PigKXYYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762794926; c=relaxed/simple;
	bh=inhLVPSgyPAI5eTcz6ZStSCWeWLPfuhNblAjLRzskbk=;
	h=From:To:Cc:Subject:Date:Message-ID:Mime-Version; b=GGm6HseDZM6QbLIGHBUzDYf3fMwB4MSDVq2iyxi8ZH5MR5Lj9rxmguDhfXfUlKnmUCwLDKN/0wCnIcVImzAj/sQMe5FlzRUDBvP2+Yp7A1ouvn+ue0FR1SnmB9icDu41x67PQgIWpGnFfbi1dnf/iSd840FVBeOMVSNxdOPA0vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=SUQYKBHf; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from beren (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id 936E32D8F88;
	Mon, 10 Nov 2025 17:15:14 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1762794914;
	bh=5KKF8FNz3nu/bk89d0JNZQERvlOKRzLgaMwDg0tVS9k=;
	h=From:To:Cc:Subject:Date;
	b=SUQYKBHfYkpUdZGtvqhDuJygvHNOXoxI3ERL5dF2SZ4G2Pvi2mCqKp4LDIYShsM3l
	 8ADtX19Hqq4T4jdOKYjK+hL364bPeb2B0p/snTKKooJerQCzzxLGzOyHUBb8i+aHHu
	 7By1m8znb2sgft2NJ6i0vFO63FyVfmq7WsfnUPi4=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org
Cc: Mark Harmstone <mark@harmstone.com>
Subject: [PATCH v5 00/16] Remap tree
Date: Mon, 10 Nov 2025 17:14:24 +0000
Message-ID: <20251110171511.20900-1-mark@harmstone.com>
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
* Version 4: https://lore.kernel.org/all/20251024181227.32228-1-mark@harmstone.com/

Changes since v4:
* Addressed various minor issues pointed out by Boris
* Added should_relocate_using_remap_tree() helper function
* Now errors out on mount if we try to use remap tree when bs > ps
* remove_range_from_remap_tree() simplified
* Fixed assert in btrfs_free_block_groups(), when fully_remapped_bgs
  list not empty
* Replace BTRFS_BLOCK_GROUP_STRIPE_REMOVAL_PENDING flag with scanning
  for this on mount
* Fixed refcounting bug in btrfs_trim_fully_remapped_block_group()
* Rebased for recent changes to btrfs_bio_alloc()

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
 fs/btrfs/block-group.c          |  316 ++++-
 fs/btrfs/block-group.h          |   25 +-
 fs/btrfs/block-rsv.c            |    8 +
 fs/btrfs/block-rsv.h            |    1 +
 fs/btrfs/discard.c              |   57 +-
 fs/btrfs/disk-io.c              |  121 +-
 fs/btrfs/extent-tree.c          |  138 ++-
 fs/btrfs/extent-tree.h          |    3 +-
 fs/btrfs/free-space-cache.c     |   87 +-
 fs/btrfs/free-space-cache.h     |    1 +
 fs/btrfs/free-space-tree.c      |    4 +-
 fs/btrfs/free-space-tree.h      |    5 +-
 fs/btrfs/fs.h                   |   10 +-
 fs/btrfs/inode.c                |    2 +-
 fs/btrfs/locking.c              |    1 +
 fs/btrfs/relocation.c           | 1904 +++++++++++++++++++++++++++++--
 fs/btrfs/relocation.h           |   19 +
 fs/btrfs/space-info.c           |   22 +-
 fs/btrfs/sysfs.c                |    4 +
 fs/btrfs/transaction.c          |   11 +
 fs/btrfs/tree-checker.c         |   94 +-
 fs/btrfs/tree-checker.h         |    5 +
 fs/btrfs/volumes.c              |  283 ++++-
 fs/btrfs/volumes.h              |   18 +-
 include/uapi/linux/btrfs.h      |    1 +
 include/uapi/linux/btrfs_tree.h |   29 +-
 30 files changed, 2939 insertions(+), 267 deletions(-)

-- 
2.51.0


