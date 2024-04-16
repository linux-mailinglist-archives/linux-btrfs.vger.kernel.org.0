Return-Path: <linux-btrfs+bounces-4300-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E65B8A6BD8
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Apr 2024 15:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BCB7B20B07
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Apr 2024 13:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0F412C46C;
	Tue, 16 Apr 2024 13:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Un0rJkYK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D6D12BF2A
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Apr 2024 13:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713272896; cv=none; b=qw3JffJ0wZTT5z6A4yUAoCgWBzN1K5LoiQqkMbfuxlhuL87zC7XXL/7wS6AllAfqP3glDRSr8agwEerwCLFvHNCSAQopz7ffzkUThwA0Ifp9daH6JjRGBR5S3/Xwv32QtVHPYDnxtUSj8PmNUofg9q9xMCCbT/FAruCmbPFR9vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713272896; c=relaxed/simple;
	bh=zY2L5x7+y5HPSlMCxROKWd44HMyPVdjTs33lniuuuA4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AhG3fHdd3DiM1QIVSM5bXtL7NX+ImizAaBLd9yGM2++HhRUszrLmoQ8kiwk2xUoh2TFk8Fu3nIc4FX5KnvwsG7kNwnmJbVvru/HooX6NYknzOnw6begPKSoylVMYFoEEHY3BeinrWVaMDJQOHFe8YerqF4a2rGGPG2KxjQisiU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Un0rJkYK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8993C2BD10
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Apr 2024 13:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713272895;
	bh=zY2L5x7+y5HPSlMCxROKWd44HMyPVdjTs33lniuuuA4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Un0rJkYKXMPeI5QSyfXwEo4rTElxWpRLD4rC//Rh9mPhn2YEkcTshUusjkOAoXnKW
	 xmoNcFsEGyK2M5EAfJxgy1mP1vhTEx6ZjyQ0ZuV/HVFR1Xx9phs58zoRHf/ZzF1d0G
	 P52BYqkT8/Wot8TCYQyrZrbPDj+CDbr0ktiWOAoegM9yFKJ3/GEsxGcg9Vnizoesqq
	 BuOCLhyAUeGMqS0zajEbobThCAfCiDycDd1aCLv0HnzTHsZRsO01VhCpp3cmDQ3Gqt
	 WW54yZIkH4UFpCMxhTc3F5/0yDmoTs2Or9u2XTYffkIrp0cpxhCWneaugm3ymngfT6
	 6OeHixfjv9Y8A==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 00/10] btrfs: add a shrinker for extent maps
Date: Tue, 16 Apr 2024 14:08:02 +0100
Message-Id: <cover.1713267925.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1712748143.git.fdmanana@suse.com>
References: <cover.1712748143.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Currently we don't limit the amount of extent maps we can have for inodes
from a subvolume tree, which can result in excessive use of memory and in
some cases in running into OOM situations. This was reported some time ago
by a user and it's specially easier to trigger with direct IO.

The shrinker itself is patch 08/10, what comes before is simple preparatory
work and the rest just trace events. More details in the change logs.

V3: Removed some preparatory patches that are already in for-next.

    Updated patch 07/10 to avoid a lockdep warning due to attempt to read
    the percpu counter when freeing fs_info if during the open_ctree()
    path we had an error before initializing the counter. Reported by the
    Intel test robot.

    Update the shrinker patch (08/10) to use the nr_cached_objects and
    free_cached_objects callbacks of struct super_operations.
    Make the shrinker remember the last inode and root it processed, so
    that it starts from there the next time it runs.
    Also avoid a deadlock when trying to lock the mmap lock, not use a
    down_read_trylock() and comment about it.
    Avoid setting the inode full sync flag if an extent in the list of
    modified extents is from an older generation, whose transaction was
    already committed and therefore the file extent item was persisted.

V2: Split patch 09/11 into 3.
    Added two patches to export and use helper to find inode in a root.
    Updated patch 13/15 to use the helper for finding next inode and
    removed the #ifdef for 32 bits case which is irrelevant as on 32 bits
    systems we can't ever have more than ULONG_MAX extent maps allocated.

Filipe Manana (10):
  btrfs: pass the extent map tree's inode to add_extent_mapping()
  btrfs: pass the extent map tree's inode to clear_em_logging()
  btrfs: pass the extent map tree's inode to remove_extent_mapping()
  btrfs: pass the extent map tree's inode to replace_extent_mapping()
  btrfs: pass the extent map tree's inode to setup_extent_mapping()
  btrfs: pass the extent map tree's inode to try_merge_map()
  btrfs: add a global per cpu counter to track number of used extent maps
  btrfs: add a shrinker for extent maps
  btrfs: update comment for btrfs_set_inode_full_sync() about locking
  btrfs: add tracepoints for extent map shrinker events

 fs/btrfs/btrfs_inode.h            |   8 +-
 fs/btrfs/disk-io.c                |   9 +
 fs/btrfs/extent_io.c              |   2 +-
 fs/btrfs/extent_map.c             | 277 +++++++++++++++++++++++++-----
 fs/btrfs/extent_map.h             |   5 +-
 fs/btrfs/fs.h                     |   4 +
 fs/btrfs/super.c                  |  20 +++
 fs/btrfs/tests/extent-map-tests.c |  19 +-
 fs/btrfs/tree-log.c               |   4 +-
 include/trace/events/btrfs.h      |  99 +++++++++++
 10 files changed, 388 insertions(+), 59 deletions(-)

-- 
2.43.0


