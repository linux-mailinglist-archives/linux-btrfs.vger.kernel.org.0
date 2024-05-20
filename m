Return-Path: <linux-btrfs+bounces-5101-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 944F38C9AA5
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 11:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50D1F281F94
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 09:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57EE0481D5;
	Mon, 20 May 2024 09:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAWco8dq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87288481BA
	for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 09:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716198415; cv=none; b=uEwk4siRWhltZS/J/tVSsrcw9Sl9r7kwckfbfzaDy/R4VveQuqo2qVC1Il5Blj6kRG2wkUh37ntYsGtm89fFQFsQ6tdVRLBHT+mN98yN/PbKyivHnS6f79UvPHUqHgXiAd9aAi5jLurstzS1lRvslhZulwHEDR65U6qWqWgqO5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716198415; c=relaxed/simple;
	bh=id1Wk7rM3ib1VmJOr/9jdycmlxGXm4OE4y5nJtaRjzM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZPc91KHHGOJyKWYDWun2BR8ZtoCvDPhl9DswVOKdpSSZ/JulKFlL3YAIifrf6CU1LQdeBiPhRYaZDSkURpk8gzfSatZaXfptwvbMILxoO0MEUrpB+0My6H916i7g5IkeawcuLkO34AeeOGTTMdBsmJs1vkg7Ljy8r98Udw3fAvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAWco8dq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84607C2BD10
	for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 09:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716198415;
	bh=id1Wk7rM3ib1VmJOr/9jdycmlxGXm4OE4y5nJtaRjzM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mAWco8dqzmjDtyOzzZn1YkhMdi4whQoqlYbNspSRwDiq9LhX9M+8oM+D2gz8jFzyn
	 Gf6WPn+Fd2v6YpcIWgkRToXDmn4OOw39UN6Z9le7JtQyFRtGIKkA9ZYdVfcUrvfL2A
	 TBTS4ASFzUqjxpjUed7JMPrIiEpzj59Vy+CiUxZ7JVOwMzIMaKRCkZd6ammnQhrWaU
	 +T/kleOjPqxIofLmhbfpixAe7nibCdAAUnEIEMvIgJBweG7oICc+ohCEDZma5WJgSc
	 2ggj0jwPPv4mQgfWA6mepejhErha0rgVtaRgajcwnNrmVP1cCX6aLyfy+kBHLDCrdr
	 3h62sdvps5PgA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v4 0/6] btrfs: fix logging unwritten extents after failure in write paths
Date: Mon, 20 May 2024 10:46:45 +0100
Message-Id: <cover.1716053516.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1715964570.git.fdmanana@suse.com>
References: <cover.1715964570.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's a bug where a fast fsync can log extent maps that were not written
due to an error in a write path or during writeback. This affects both
direct IO writes and buffered writes, and besides the failure depends on
a race due to the fact that ordered extent completion happens in a work
queue and a fast fsync doesn't wait for ordered extent completion before
logging. The details are in the change log of the first patch.

V4: Use a slightly different approach to avoid a deadlock on the inode's
    spinlock due to it being used both in irq and non-irq context, pointed
    out by Qu.
    Added some cleanup patches (patches 3, 4, 5 and 6).

V3: Change the approach of patch 1/2 to not drop extent maps at
    btrfs_finish_ordered_extent() since that runs in irq context and
    dropping an extent map range triggers NOFS extent map allocations,
    which can trigger a reclaim and that can't run in irq context.
    Updated comments and changelog to distinguish differences between
    failures for direct IO writes and buffered writes.

V2: Rework solution since other error paths caused the same problem, make
    it more generic.
    Added more details to change log and comment about what's going on,
    and why reads aren't affected.

    https://lore.kernel.org/linux-btrfs/cover.1715798440.git.fdmanana@suse.com/

V1: https://lore.kernel.org/linux-btrfs/cover.1715688057.git.fdmanana@suse.com/

Filipe Manana (6):
  btrfs: ensure fast fsync waits for ordered extents after a write failure
  btrfs: make btrfs_finish_ordered_extent() return void
  btrfs: use a btrfs_inode in the log context (struct btrfs_log_ctx)
  btrfs: pass a btrfs_inode to btrfs_fdatawrite_range()
  btrfs: pass a btrfs_inode to btrfs_wait_ordered_range()
  btrfs: use a btrfs_inode local variable at btrfs_sync_file()

 fs/btrfs/btrfs_inode.h      | 10 ++++++
 fs/btrfs/file.c             | 63 ++++++++++++++++++++++---------------
 fs/btrfs/file.h             |  2 +-
 fs/btrfs/free-space-cache.c |  4 +--
 fs/btrfs/inode.c            | 16 +++++-----
 fs/btrfs/ordered-data.c     | 40 ++++++++++++++++++++---
 fs/btrfs/ordered-data.h     |  4 +--
 fs/btrfs/reflink.c          |  8 ++---
 fs/btrfs/relocation.c       |  2 +-
 fs/btrfs/tree-log.c         | 10 +++---
 fs/btrfs/tree-log.h         |  4 +--
 11 files changed, 108 insertions(+), 55 deletions(-)

-- 
2.43.0


