Return-Path: <linux-btrfs+bounces-4832-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C3E8BFCF5
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 May 2024 14:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B788BB21DF9
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 May 2024 12:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C99B83A0E;
	Wed,  8 May 2024 12:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h96Wp8uD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DCE3D96D
	for <linux-btrfs@vger.kernel.org>; Wed,  8 May 2024 12:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715170654; cv=none; b=Len+l6cIaYl83O5D3yuxT5fjsRtK9GEqa2AidYoAYU/b9MeK8uVFTg+cYpIUtjrzsljt7K5bBlR/e0hjzpMqOzsbBnZyn4DQg6yF9rJPpbA30SIyAqnhytiSsjda0CP0ADAhcp4e/b439vEsSmw4bbSjNY8IJFaMCy91GlyLdLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715170654; c=relaxed/simple;
	bh=mGiw248DHkZoq9K1RWhFJGRosiy3po4FKFDlOx6SOrQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=h6UNdCRDxolvF8V6r/0H3oJjuVZrUwjEd9/6EdsE9zEKWzMu/81SWdGYXC9ClLW0fgb00IsqCnl4GfoWbGhoy/IZeqqpCMY4EvgXGAmb9TL8r26EC7kGfAkzH0ZE+g4vjlSp6Yic4O1mz0+2TEFBewr0r/fG/jKVTfuwP0yfYoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h96Wp8uD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE10C113CC
	for <linux-btrfs@vger.kernel.org>; Wed,  8 May 2024 12:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715170654;
	bh=mGiw248DHkZoq9K1RWhFJGRosiy3po4FKFDlOx6SOrQ=;
	h=From:To:Subject:Date:From;
	b=h96Wp8uDKleMGwBozxv4Ykv1hgVDA112HBLTeKOBb8dpEC+C1aX2josnn59O9t/SY
	 7JhR3RCr1GnbFDOf47cQglORQJYCIE1hcqIcnCgOblpOt4XdOxORV8oCAqU4bh4Y8x
	 fj3CrzlX9lhUrwk+5lAJEVyk3/AcVYnTf+obGLNIGJN26JUWNBsHYHK0etSj8pGtXZ
	 wxVZzF147A2eyQffAoBiuhOvMbFP+V2QWHHV8ZcciWYywZ/PqG/psh/zU027nM1L/2
	 P97Rtlr0M8vPvFYjMzCrsK3Uln4WBKtK8BgwL6NbO+ZEMqlN6a87QRoa/poNw99gzw
	 Tn8MbPx6adOYA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/8] btrfs: inode management and memory consumption improvements
Date: Wed,  8 May 2024 13:17:23 +0100
Message-Id: <cover.1715169723.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
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
More details in the the change logs.

Filipe Manana (8):
  btrfs: use an xarray to track open inodes in a root
  btrfs: preallocate inodes xarray entry to avoid transaction abort
  btrfs: reduce nesting and deduplicate error handling at btrfs_iget_path()
  btrfs: remove inode_lock from struct btrfs_root and use xarray locks
  btrfs: unify index_cnt and csum_bytes from struct btrfs_inode
  btrfs: don't allocate file extent tree for non regular files
  btrfs: remove location key from struct btrfs_inode
  btrfs: remove objectid from struct btrfs_inode on 64 bits platforms

 fs/btrfs/btrfs_inode.h       | 130 +++++++++++-----
 fs/btrfs/ctree.h             |   8 +-
 fs/btrfs/delayed-inode.c     |  27 ++--
 fs/btrfs/disk-io.c           |  12 +-
 fs/btrfs/export.c            |   2 +-
 fs/btrfs/file-item.c         |  13 +-
 fs/btrfs/inode.c             | 286 +++++++++++++++++------------------
 fs/btrfs/ioctl.c             |   8 +-
 fs/btrfs/relocation.c        |  12 +-
 fs/btrfs/tests/btrfs-tests.c |   5 +-
 fs/btrfs/tree-log.c          |   9 +-
 11 files changed, 285 insertions(+), 227 deletions(-)

-- 
2.43.0


