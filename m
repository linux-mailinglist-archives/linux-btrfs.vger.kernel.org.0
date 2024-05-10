Return-Path: <linux-btrfs+bounces-4894-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D30D28C2950
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2024 19:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D0322879E4
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2024 17:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7832518637;
	Fri, 10 May 2024 17:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTVJVtwA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A8D17C7F
	for <linux-btrfs@vger.kernel.org>; Fri, 10 May 2024 17:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715362381; cv=none; b=F8TmQTciRE7TqrtltLnIJh4B+f4h4D7qZ3YgRT7X23/+qCIJsEWkyFPlIGwz9/3YJ7xxRLtSUlBjYa4Z27qdM/0QYJxxOlmZpvuEnhZ+cRGxlw8t4T0+gj5dGe0d14kySNhlAHmPOppkQPc3zA0LnFmbUWFawziUz7m/1Ny8Q3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715362381; c=relaxed/simple;
	bh=jtinGbYEX01wiRZ9EZbkcGxq5Cm5DmTwR8xHmzBWgbU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dZ3UVk8LJgk6FaCSlnVG03DfUPrA9vgpwFB1byNDlC9t5hCaYhH929rfGlgFKb8CL9kd95B5VYtQDxb1lc9U9HG4toTh0yxByip2w9cWb8YY87gE8TuzLDrr1H5ZeilJQWktN8ePBwRWvYkrUuYX0qbxaPz13ZuqAghrIRFIex8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTVJVtwA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07AEFC113CC
	for <linux-btrfs@vger.kernel.org>; Fri, 10 May 2024 17:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715362381;
	bh=jtinGbYEX01wiRZ9EZbkcGxq5Cm5DmTwR8xHmzBWgbU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=CTVJVtwARJayrpoKZXL65zPY8kaQZIM6v0Sm1BB+Fxcsa3hTCAFkchvmGkxE0tWd+
	 uNZIvb4WMGyPu6OQPP65PH8OSgJjDWGEdFMeWvvTqYhjJGBf7jbyFXqaS7tl4K+daQ
	 Nai/gRWzWdaXtCuXzLSt5snzG05OeYAODJmftu1Z8KvoA1psseaEACYVdfb0F12FQQ
	 nKzJMMtYbgTLwgM+igsdhpP41Mhr2HZJ9vm9/9sn/ORUcv0l4mUZHjxuuqBEzfy841
	 YSgDPSJLQOqIGtvIzYfGSbGJ85uBIOJlmB4Ngm8PMDAlSVTubQNR2SOQFvID7vi2t+
	 2KxLOZfrAWqkQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 00/10] btrfs: inode management and memory consumption improvements
Date: Fri, 10 May 2024 18:32:48 +0100
Message-Id: <cover.1715362104.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1715169723.git.fdmanana@suse.com>
References: <cover.1715169723.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Some inode related improvements, to use an xarray to track open inodes per
root instead of a red black tree, reduce lock contention and use less memory
per btrfs inode, so now we can fit 4 inodes per 4K page instead of 3.
More details in the change logs.

V2: Added two more patches (9/10 and 10/10) to make sure btrfs_inode size
    is reduced to 1024 bytes when CONFIG_FS_ENCRYPTION and CONFIG_FS_VERITY
    are set. I wasn't using these configs before, and with them the final
    size for btrfs_inode was 1032 bytes and not 1016 bytes as I initially
    had - now the final size is 1024 bytes with those configs enabled.

Filipe Manana (10):
  btrfs: use an xarray to track open inodes in a root
  btrfs: preallocate inodes xarray entry to avoid transaction abort
  btrfs: reduce nesting and deduplicate error handling at btrfs_iget_path()
  btrfs: remove inode_lock from struct btrfs_root and use xarray locks
  btrfs: unify index_cnt and csum_bytes from struct btrfs_inode
  btrfs: don't allocate file extent tree for non regular files
  btrfs: remove location key from struct btrfs_inode
  btrfs: remove objectid from struct btrfs_inode on 64 bits platforms
  btrfs: rename rb_root member of extent_map_tree from map to root
  btrfs: use a regular rb_root instead of cached rb_root for extent_map_tree

 fs/btrfs/btrfs_inode.h            | 130 ++++++++++----
 fs/btrfs/ctree.h                  |   8 +-
 fs/btrfs/delayed-inode.c          |  29 ++-
 fs/btrfs/disk-io.c                |  12 +-
 fs/btrfs/export.c                 |   2 +-
 fs/btrfs/extent_map.c             |  50 +++---
 fs/btrfs/extent_map.h             |   2 +-
 fs/btrfs/file-item.c              |  13 +-
 fs/btrfs/inode.c                  | 286 +++++++++++++++---------------
 fs/btrfs/ioctl.c                  |   8 +-
 fs/btrfs/relocation.c             |  12 +-
 fs/btrfs/tests/btrfs-tests.c      |   5 +-
 fs/btrfs/tests/extent-map-tests.c |   6 +-
 fs/btrfs/tree-log.c               |   9 +-
 14 files changed, 317 insertions(+), 255 deletions(-)

-- 
2.43.0


