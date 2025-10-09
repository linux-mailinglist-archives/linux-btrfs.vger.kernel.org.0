Return-Path: <linux-btrfs+bounces-17592-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2ADBC8D5B
	for <lists+linux-btrfs@lfdr.de>; Thu, 09 Oct 2025 13:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A2B74F6135
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Oct 2025 11:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5710C2E0B59;
	Thu,  9 Oct 2025 11:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="1rhut1JU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (unknown [62.3.69.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A4F2750E1
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Oct 2025 11:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.3.69.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760009647; cv=none; b=GSB4FhTAT1PuLiF1PlSAYyaO8E1rqPptvXIC6WabPAaZ6w+ngtkE00bNNKU7y2ZjpbhUQtT0KxpfIvkSDp5Id4UxMiiqUUEljekHlnnR2lX5pYKhxu6SncAkURu9Id0nmZWkb1I5HfO9cN+5oDqTb38mcAGFdJKX7izrmAFCuRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760009647; c=relaxed/simple;
	bh=8tFZj1tvXxnRVo8adE5JoVAkHeG2gtWhq2LUBq9whns=;
	h=From:To:Cc:Subject:Date:Message-ID:Mime-Version; b=I7BsUxWS3rMFjT/0wuwpqnkvafzPxhC1AfmYXu++q8TNMa0jkedeGn/wkDW5xJDG42onE7UH0z1MSruZAwk2i73jJJMd1nNvVcVg0/QOrFWc723zuT31qFWwOzE6+o437H7/zsYu8E4SgU/nW5wmMVmQxbN+Ned0KnBjmpErtO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=fail smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=1rhut1JU; arc=none smtp.client-ip=62.3.69.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=harmstone.com
Received: from localhost.localdomain (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id 361032C564D;
	Thu,  9 Oct 2025 12:28:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1760009288;
	bh=VXDAdP8j6JhYfCU5hEHVVwjKmUzvqKDA5uvnBBm+d7s=;
	h=From:To:Cc:Subject:Date;
	b=1rhut1JUnkbTK5V+i57TWH2Xr4ezO0Lj0AqzguQywo5n7zOz16q7oZdDHbowha4C3
	 f0lC/cLF3b4WuTnAdwkzj1zaQaSiEvU95MMS5Q1br4Saoly9GWtNGtVRpdfxFK53aG
	 +BNkXLMsEU7CddSv3uORZAo02lRlx7rtuh3eBpQo=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org
Cc: Mark Harmstone <mark@harmstone.com>
Subject: [PATCH v3 00/17] Remap tree
Date: Thu,  9 Oct 2025 12:27:55 +0100
Message-ID: <20251009112814.13942-1-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit

This is version 3 of the patch series for the new logical remapping tree
feature - see the previous cover letters for more information including
the rationale:

* RFC: https://lore.kernel.org/all/20250515163641.3449017-1-maharmstone@fb.com/
* Version 1: https://lore.kernel.org/all/20250605162345.2561026-1-maharmstone@fb.com/
* Version 2: https://lore.kernel.org/all/20250813143509.31073-1-mark@harmstone.com/

Changes since version 2:
* Addressed the points that Boris mentioned in his reviews
* Moved fully_remapped_bgs list from the transaction to fs_info
* Chunk sub_stripes now set to 0 when num_stripes is
* Fixed crash with RAID0
* Made it so changing a block group's flags feeds through to the
  block_group_item on commit
* Added discarding of fully-remapped block groups

For async discard, we set a new flag on the block group item,
BTRFS_BLOCK_GROUP_STRIPE_REMOVAL_PENDING, in the transaction in which
the last identity remap is removed. We then queue up async discard of
the whole of the range in the usual way. Once the block group has been
fully discarded, we remove the device extents, remove the chunk stripes,
and clear the STRIPE_REMOVAL_PENDING flag.

If we encounter a block group with this flag set when we walk the block
group tree on mount, we queue it up for discard again - that way it's
not possible for the discard of a block group to be missed.

For sync discard we don't set this flag, discard happens at the same
time as the transaction commit. But if we encounter it on mount we still
queue the BG up for discard, it just happens on the commit of the first
transaction after mount.

If you are trying the btrfs-progs patches I linked to in the other cover
letters, bear in mind that btrfs-check doesn't like the fact that
BTRFS_BLOCK_GROUP_STRIPE_REMOVAL_PENDING gets set on the block group
item but not the chunk item. There didn't seem much point in setting it
on both, but I can change this if anybody has strong feelings on the
matter.

Mark Harmstone (17):
  btrfs: add definitions and constants for remap-tree
  btrfs: add REMAP chunk type
  btrfs: allow remapped chunks to have zero stripes
  btrfs: remove remapped block groups from the free-space tree
  btrfs: don't add metadata items for the remap tree to the extent tree
  btrfs: add extended version of struct block_group_item
  btrfs: allow mounting filesystems with remap-tree incompat flag
  btrfs: redirect I/O for remapped block groups
  btrfs: release BG lock before calling btrfs_link_bg_list()
  btrfs: handle deletions from remapped block group
  btrfs: handle setting up relocation of block group with remap-tree
  btrfs: move existing remaps before relocating block group
  btrfs: replace identity maps with actual remaps when doing relocations
  btrfs: add do_remap param to btrfs_discard_extent()
  btrfs: allow balancing remap tree
  btrfs: handle discarding fully-remapped block groups
  btrfs: add stripe removal pending flag

 fs/btrfs/Kconfig                |    2 +
 fs/btrfs/accessors.h            |   29 +
 fs/btrfs/block-group.c          |  272 ++++-
 fs/btrfs/block-group.h          |   22 +-
 fs/btrfs/block-rsv.c            |    8 +
 fs/btrfs/block-rsv.h            |    1 +
 fs/btrfs/discard.c              |   70 +-
 fs/btrfs/disk-io.c              |  107 +-
 fs/btrfs/extent-tree.c          |  131 ++-
 fs/btrfs/extent-tree.h          |    3 +-
 fs/btrfs/free-space-cache.c     |   84 +-
 fs/btrfs/free-space-cache.h     |    1 +
 fs/btrfs/free-space-tree.c      |    4 +-
 fs/btrfs/free-space-tree.h      |    5 +-
 fs/btrfs/fs.h                   |   10 +-
 fs/btrfs/inode.c                |    2 +-
 fs/btrfs/locking.c              |    1 +
 fs/btrfs/relocation.c           | 1867 ++++++++++++++++++++++++++++++-
 fs/btrfs/relocation.h           |   10 +-
 fs/btrfs/space-info.c           |   22 +-
 fs/btrfs/sysfs.c                |    4 +
 fs/btrfs/transaction.c          |   13 +
 fs/btrfs/tree-checker.c         |   94 +-
 fs/btrfs/tree-checker.h         |    5 +
 fs/btrfs/volumes.c              |  302 ++++-
 fs/btrfs/volumes.h              |   19 +-
 include/uapi/linux/btrfs.h      |    1 +
 include/uapi/linux/btrfs_tree.h |   30 +-
 28 files changed, 2901 insertions(+), 218 deletions(-)

-- 
2.49.1


