Return-Path: <linux-btrfs+bounces-12838-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CFEA7E8B1
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 19:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A074189E5A8
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 17:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B481521ADAB;
	Mon,  7 Apr 2025 17:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksgxBO3D"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0447D20A5D6
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Apr 2025 17:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744047387; cv=none; b=qb4Z8WYkPXWYqOIfaIi8bLNxP5fHW/5Ck3v6OxKbspIPJ9Fq9rc3T1WTcgI6dpRMIud7OMSTcK6yxUHTg6yUOMWGTypiMwuIP+YkTbDrHCuHtq1nE0FJN1hutSeDDG5wx86js1O0jjYQ6Q/iLTfU8B6wFBltBlPwoi24sSPj87Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744047387; c=relaxed/simple;
	bh=CDA5jfrrEV6kuK3LcY3YjEVVSFn6OfHHdzJF4FwtqvY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=sencJF6GopE7+ccu8U28uV0wstrfSBwZQysZwoWcatOq00I2Qw5Rd8YuoyeNCUBVZn9ydvhrPHBwh9raAly/ABc215W1cQvm5yU6Ro86O1s0IZq0XfJSPC3qQsBf2+20HuB2tTw9+9Xs4kK6ujQ0Ek2kKvcDjG86EGy+elx/Fw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksgxBO3D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D96F3C4CEDD
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Apr 2025 17:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744047386;
	bh=CDA5jfrrEV6kuK3LcY3YjEVVSFn6OfHHdzJF4FwtqvY=;
	h=From:To:Subject:Date:From;
	b=ksgxBO3DL6GH5rP8nX89csfv+3vqiHcRC53RXlnjeG6Z3VWECFNvOybGa/BOismJ1
	 xb5SqTPKzzWigGBiFSS6Rae2VghwO7rq5UqTY0NHneGzAxWC/FtScsdvJBeXbd7VUu
	 LUlVkJT7640hsY6H9VkxisdGfYMyIV3EZsfcVye2SOJ0Nqcic5aJJgDJ8WKSf1bOBy
	 eiqiS5LTja7h6Qz+S2PnVsmbE6FS2oW1Dw8Jxe8WzrZ/T2TrGtek30wa+A4lzeXxEH
	 je+hmUqzo5IOVKZKC5gYBn1YYaiVwo/EkHiJARgedDVo2ksZkUnO4qYkg8P2oZ2Yks
	 1JoJKdgXuGgsQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 00/16] btrfs: some cleanups for extent-io-tree (mostly renames)
Date: Mon,  7 Apr 2025 18:36:07 +0100
Message-Id: <cover.1744046765.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

These are mostly to rename exported functions so that they have a 'btrfs_'
prefix and follow coding style, to avoid potential clashes in the future
with other kernel functions defined elsewhere outside btrfs. As more
functions are added to extent-io-tree.h, there's a tendency to follow the
existing style and not add a 'btrfs_' prefix for consistency with the
other function names, so as time passes we get more exported functions
that don't follow the coding style by missing a 'btrfs_' prefix. I'm in
the process of adding another new exported function to extent-io-tree.h
and found my self unconfortable adding a 'btrfs_' prefix to it while the
other exported functions don't have one.

I tried to split the rename into several and more reasonably sized patches
to make it easier to review and also because a few do a bit more than
simply renaming, but with notes in the change logs.

Filipe Manana (16):
  btrfs: remove extent_io_tree_to_inode() and is_inode_io_tree()
  btrfs: add btrfs prefix to trace events for extent state alloc and free
  btrfs: add btrfs prefix to main lock, try lock and unlock extent functions
  btrfs: add btrfs prefix to dio lock and unlock extent functions
  btrfs: rename __lock_extent() and __try_lock_extent()
  btrfs: rename the functions to clear bits for an extent range
  btrfs: rename set_extent_bit() to include a btrfs prefix
  btrfs: rename the functions to search for bits in extent ranges
  btrfs: rename the functions to get inode and fs_info from an extent io tree
  btrfs: directly grab inode at __btrfs_debug_check_extent_io_range()
  btrfs: rename the functions to init and release an extent io tree
  btrfs: rename the functions to count, test and get bit ranges in io trees
  btrfs: rename free_extent_state() to include a btrfs prefix
  btrfs: rename remaining exported functions from extent-io-tree.h
  btrfs: remove double underscore prefix from __set_extent_bit()
  btrfs: make btrfs_find_contiguous_extent_bit() return bool instead of int

 fs/btrfs/block-group.c           |  34 ++---
 fs/btrfs/compression.c           |   6 +-
 fs/btrfs/defrag.c                |  36 ++---
 fs/btrfs/dev-replace.c           |  12 +-
 fs/btrfs/direct-io.c             |  38 +++---
 fs/btrfs/disk-io.c               |  35 ++---
 fs/btrfs/extent-io-tree.c        | 218 ++++++++++++++-----------------
 fs/btrfs/extent-io-tree.h        | 155 +++++++++++-----------
 fs/btrfs/extent-tree.c           |  38 +++---
 fs/btrfs/extent_io.c             |  40 +++---
 fs/btrfs/extent_map.c            |   4 +-
 fs/btrfs/fiemap.c                |   6 +-
 fs/btrfs/file-item.c             |  22 ++--
 fs/btrfs/file.c                  |  87 ++++++------
 fs/btrfs/free-space-cache.c      |  36 ++---
 fs/btrfs/inode.c                 | 167 +++++++++++------------
 fs/btrfs/ioctl.c                 |   8 +-
 fs/btrfs/ordered-data.c          |   8 +-
 fs/btrfs/qgroup.c                |  30 +++--
 fs/btrfs/reflink.c               |  12 +-
 fs/btrfs/relocation.c            |  61 ++++-----
 fs/btrfs/super.c                 |   4 +-
 fs/btrfs/tests/btrfs-tests.c     |   4 +-
 fs/btrfs/tests/extent-io-tests.c |  54 ++++----
 fs/btrfs/tests/inode-tests.c     |  24 ++--
 fs/btrfs/transaction.c           |  34 ++---
 fs/btrfs/tree-log.c              |  12 +-
 fs/btrfs/volumes.c               |  28 ++--
 include/trace/events/btrfs.h     |  16 +--
 29 files changed, 607 insertions(+), 622 deletions(-)

-- 
2.45.2


