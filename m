Return-Path: <linux-btrfs+bounces-20411-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D40D13F19
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jan 2026 17:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9B2A3038F6F
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jan 2026 16:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3CB3659FD;
	Mon, 12 Jan 2026 16:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=urbackup.org header.i=@urbackup.org header.b="LXeEpOJ6";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="FdtOzJEb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from a4-6.smtp-out.eu-west-1.amazonses.com (a4-6.smtp-out.eu-west-1.amazonses.com [54.240.4.6])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F589306B12
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Jan 2026 16:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.4.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768234639; cv=none; b=OpxrqkRd8Yh4cMo5j32bX3oMZycQwpQZlgDrBB+tWeAkL0wYIioTPtjSYkoT+K+IjryCQfbYUispGTUe9xtXOpNkeUXE1x6PSy9nfD5PP9o8oIkGAlZjlo5k/JwERiV8YMYdROymyvakLV9D2weLrwoi7quixkO9ZTgWECPAmic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768234639; c=relaxed/simple;
	bh=M27JzXpG9gIjTh4JzmnPh9ZQhAhxyIKg2lcJpeIkk8s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PTOsN/6ncaEtMHBHfzvP8F9CHxEjmIiBXO+yEsL/+1+mpMbUDCpNild8ZAH0KvyIEpjlActpUovcXed+D+iLTWAzGUMdcC5Ud2JCu21JCGZILIsj+BM1lmwfOZd5oomOiL/Xc6JGUNrysgBJWbBu46MuRiI7gfrpV6eVghuwuE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=urbackup.org; spf=pass smtp.mailfrom=bounce.urbackup.org; dkim=pass (1024-bit key) header.d=urbackup.org header.i=@urbackup.org header.b=LXeEpOJ6; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=FdtOzJEb; arc=none smtp.client-ip=54.240.4.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=urbackup.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.urbackup.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ob2ngmaigrjtzxgmrxn2h6b3gszyqty3; d=urbackup.org; t=1768234636;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding;
	bh=M27JzXpG9gIjTh4JzmnPh9ZQhAhxyIKg2lcJpeIkk8s=;
	b=LXeEpOJ6burzQNipRQO4yyCam6ufoerCINoKt1Z9gzz5ue7eeQczXYSbOkkFcZJS
	FvvZ7+FwfKe3wH9f22QyQ6mjeCi147FXBzNtwNOORGWyRkuw8EvGwNM7r29tZfnfgk0
	Ghs2Ca33bx4H8KQEtZ05Bu/0gu2y9wbdDDwUyBe0=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1768234636;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=M27JzXpG9gIjTh4JzmnPh9ZQhAhxyIKg2lcJpeIkk8s=;
	b=FdtOzJEbSmamOskV/BgJj35r++or8O/k3t9GJIoZw4fKW/HsYHOm6Qf7lUbNJJFh
	tBKUbpYLZosfRfKtBYi12w3wsORlQSqZqAMqGLuCElwCvf7rGvNMG6wkOIKgJPDAzv/
	Ng4sO/kJf/y7NOcjwu6HPRHjdko9M7BHoQcvEIL8=
From: Martin Raiber <martin@urbackup.org>
To: linux-btrfs@vger.kernel.org
Cc: Martin Raiber <martin@urbackup.org>
Subject: [PATCH 0/7] Improve performance of find_free_extent
Date: Mon, 12 Jan 2026 16:17:16 +0000
Message-ID: <0102019bb2ff554d-2be39adf-dd94-4f37-864a-69bbf700de33-000000@eu-west-1.amazonses.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: ::1.eu-west-1.zKMZH6MF2g3oUhhjaE2f3oQ8IBjABPbvixQzV8APwT0=:AmazonSES
X-SES-Outgoing: 2026.01.12-54.240.4.6

On a system with large btrfs file system and old (but many cores) CPU, I saw the throughput bottlenecked
by find_free_extent performance, running in parallel, e.g., by flush_delalloc and btrfs-flush.
While the logic in find_free_extent can probably be improved (not iterating through tens of 
thousands of block groups), I was able to fix the immediate problem by using percpu synchronization
primitives and two other micro-optimizations.

Martin Raiber (7):
  btrfs: Use percpu refcounting for block groups
  btrfs: Use percpu semaphore for space info groups_sem
  btrfs: Don't lock data_rwsem if space cache v1 is not used
  btrfs: Use percpu sem for block_group_cache_lock
  btrfs: Skip locking percpu semaphores on mount
  btrfs: Introduce fast path for checking if a block group is done
  btrfs: Move block group members frequently accessed together  closer

 fs/btrfs/block-group.c | 168 +++++++++++++++++++++++------------------
 fs/btrfs/block-group.h |  18 +++--
 fs/btrfs/disk-io.c     |   6 +-
 fs/btrfs/extent-tree.c |  24 +++---
 fs/btrfs/fs.h          |   2 +-
 fs/btrfs/ioctl.c       |   8 +-
 fs/btrfs/space-info.c  |  33 +++++---
 fs/btrfs/space-info.h  |   4 +-
 fs/btrfs/sysfs.c       |   9 ++-
 fs/btrfs/zoned.c       |  13 ++--
 10 files changed, 163 insertions(+), 122 deletions(-)

-- 
2.39.5


