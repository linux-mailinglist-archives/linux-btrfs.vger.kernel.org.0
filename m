Return-Path: <linux-btrfs+bounces-16053-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D50B24C2B
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Aug 2025 16:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 120E1179BB4
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Aug 2025 14:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D23B2FF178;
	Wed, 13 Aug 2025 14:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="SGEzrp0I"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7421C2EAB8C
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Aug 2025 14:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755095725; cv=none; b=s9ns6/DE+drAKk8Y1fqiK5LeehQ9PGw3lvSxXh3FlygpByfnHXJyUa9vvqgEl82njTU93Uk0ZYjwrxtG1BXonHoMJTep2pJLZO0/ZwpABSHL9xbtAechNqw1sJtAWemIeMG2UymtvTIKE3IftDw9bbsdPI7K/E1HXhz9ljHCZIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755095725; c=relaxed/simple;
	bh=cACDNGoKz+D3IJgffG31pWzy2cyjHYA3lEXQ+u8Uwkc=;
	h=From:To:Cc:Subject:Date:Message-ID:Mime-Version; b=jliuERgIYJ66mI6bs6UTZrXor31+hpzofoSJWx3yHxQzeqvpTknUFySxpKYLgz3bd05cpkPYK0Ov6FHmCWeaTtI3g9Orfh1DSazRYEW0kPU6+pCHqH0q4GM3osWV73AnVPgseuzcD4pXvMoWcvlRivXDflTe4Asq0SJlKdnUaJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=SGEzrp0I; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from localhost.localdomain (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id 0FA432A758F;
	Wed, 13 Aug 2025 15:35:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1755095713;
	bh=seK3xu1jYl0xMgk/pebtgQyN1BN/rLx8IFLuRN3Mzyw=;
	h=From:To:Cc:Subject:Date;
	b=SGEzrp0IRcQi9JbE2hQkg7gReA6tXzfV+Im8lilY/5TgthD2ki+p0ukT3zAgtYSnD
	 3+Busifwm9+uaR6Dloy2Ry8Orbnv98IhlKQBLdwTu6PG4Jn/xbm2eR9CL/sJDHw+m6
	 I++Cx5q5uhl5thUAd/UXt2A7HOy+6sCDgiXC5leY=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org
Cc: Mark Harmstone <mark@harmstone.com>
Subject: [PATCH v2 00/16] btrfs: remap tree
Date: Wed, 13 Aug 2025 15:34:42 +0100
Message-ID: <20250813143509.31073-1-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds a disk format change gated behind
CONFIG_BTRFS_EXPERIMENTAL to add a "remap tree", which acts as a layer of
indirection when doing I/O. When doing relocation, rather than fixing up every
tree, we instead record the old and new addresses in the remap tree. This should
hopefully make things more reliable and flexible, as well as enabling some
future changes we'd like to make, such as larger data extents and reducing
write amplification by removing cow-only metadata items.

The remap tree lives in a new REMAP chunk type. This is because bootstrapping
means that it can't be remapped itself, and has to be relocated by COWing it as
at present. It can't go in the SYSTEM chunk as we are then limited by the chunk
item needing to fit in the superblock.

For more on the design and rationale, please see my RFC sent earlier this year[1], as
well as Josef Bacik's original design document[2]. The main change from Josef's
design is that I've added remap backrefs, as we need to be able to move a
chunk's existing remaps before remapping it.

You will also need my patches to btrfs-progs[3] to make
`mkfs.btrfs -O remap-tree` work, as well as allowing `btrfs check` to recognize
the new format.

Changelog:

Since v1:

* Fixed the problems with discard. Removing an extent in a remapped
block group now gets its address translated through the remap tree, and
when the last identity map of a block group is removed it triggers a
discard for its old dev extents

* Added relocation of the REMAP chunks, i.e. the chunks where the remap
tree itself lives. This can't be done by the existing method as we've
removed the metadata items in the extent tree, so we just COW every
leaf.

* Fixed a couple of lockdep issues

* Addressed the points that Boris made in his review

Since the RFC:

* I've reduce the REMAP chunk size from the normal 1GB to 32MB, to match the
  SYSTEM chunk. For a filesystem with 4KB sectors and 16KB node size, the worst
  case is that one leaf covers ~1MB of data, and the best case ~250GB. For a
  chunk, that implies a worst case of ~2GB and a best case of ~500TB.
  This isn't a disk-format change, so we can always adjust it if it proves too
  big or small in practice. mkfs creates 8MB chunks, as it does for everything.

* You can't make new allocations from remapped block groups, so I've changed
  it so there's no free-space entries for these (thanks to Boris Burkov for the
  suggestion).

* The remap tree doesn't have metadata items in the extent tree (thanks to Josef
  for the suggestion). This was to work around some corruption that delayed refs
  were causing, but it also fits it with our future plans of removing all
  metadata items for COW-only trees, reducing write amplification.

* btrfs_translate_remap() uses search_commit_root when doing metadata lookups,
  to avoid nested locking issues. This also seems to be a lot quicker (btrfs/187
  went from ~20mins to ~90secs).

* Unused remapped block groups should now get cleaned up more aggressively

* Other miscellaneous cleanups and fixes

Known issues:

* Some test failures: btrfs/156, btrfs/170, btrfs/226, btrfs/250

* nodatacow extents aren't safe, as they can race with the relocation thread.
  We either need to follow the btrfs_inc_nocow_writers() approach, which COWs
  the extent, or change it so that it blocks here.

* When initially marking a block group as remapped, we are walking the free-
  space tree and creating the identity remaps all in one transaction. For the
  worst-case scenario, i.e. a 1GB block group with every other sector allocated
  (131,072 extents), this can result in transaction times of more than 10 mins.
  This needs to be changed to allow this to happen over multiple transactions.

* All this is disabled for zoned devices for the time being, as I've not been
  able to test it. I'm planning to make it compatible with zoned at a later
  date.

Thanks

[1] https://lwn.net/Articles/1021452/
[2] https://github.com/btrfs/btrfs-todo/issues/54
[3] https://github.com/maharmstone/btrfs-progs/tree/remap-tree

Mark Harmstone (16):
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
  btrfs: add fully_remapped_bgs list
  btrfs: allow balancing remap tree

 fs/btrfs/Kconfig                |    2 +
 fs/btrfs/accessors.h            |   29 +
 fs/btrfs/block-group.c          |  233 +++-
 fs/btrfs/block-group.h          |   17 +-
 fs/btrfs/block-rsv.c            |    8 +
 fs/btrfs/block-rsv.h            |    1 +
 fs/btrfs/discard.c              |   11 +-
 fs/btrfs/disk-io.c              |   91 +-
 fs/btrfs/extent-tree.c          |  115 +-
 fs/btrfs/extent-tree.h          |    2 +-
 fs/btrfs/free-space-cache.c     |    2 +-
 fs/btrfs/free-space-tree.c      |    4 +-
 fs/btrfs/free-space-tree.h      |    5 +-
 fs/btrfs/fs.h                   |    7 +-
 fs/btrfs/inode.c                |    2 +-
 fs/btrfs/locking.c              |    1 +
 fs/btrfs/relocation.c           | 1906 ++++++++++++++++++++++++++++++-
 fs/btrfs/relocation.h           |    7 +-
 fs/btrfs/space-info.c           |   22 +-
 fs/btrfs/sysfs.c                |    4 +
 fs/btrfs/transaction.c          |    8 +
 fs/btrfs/transaction.h          |    1 +
 fs/btrfs/tree-checker.c         |   92 +-
 fs/btrfs/tree-checker.h         |    5 +
 fs/btrfs/volumes.c              |  299 ++++-
 fs/btrfs/volumes.h              |   19 +-
 include/uapi/linux/btrfs.h      |    1 +
 include/uapi/linux/btrfs_tree.h |   29 +-
 28 files changed, 2717 insertions(+), 206 deletions(-)

-- 
2.49.1


