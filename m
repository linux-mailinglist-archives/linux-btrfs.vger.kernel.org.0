Return-Path: <linux-btrfs+bounces-5075-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B01E8C8A5A
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2024 18:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23CB42852F5
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2024 16:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F44D13D8B9;
	Fri, 17 May 2024 16:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfdlwqoI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8028213D8A3
	for <linux-btrfs@vger.kernel.org>; Fri, 17 May 2024 16:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715964762; cv=none; b=HYdvrIfReTf77ilcQlTo8HHcjsck1XroGFeX8V+1QrQwikMvB3E32TJ9eQxLaop16pmWYf4kv1hhBarp5AQQEzLj/4InATyeZSUSUj8Bz/XRLcfOPFa68DNmFt9IHSNAfNV5Prf/xz4jSTNapPdNZdq15aoagd5Ls5WQild+0dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715964762; c=relaxed/simple;
	bh=pTZnimOqpNV3bTAVdding2KtPsb9y825sFzgZK77rDY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=bAiO2/oGyNJ6SG5x70/eRVLSvXIzPbkl47ApzGO5OUhSFndt8wocbK6q8tyJBCfuGemmUh9B6fHL2A5mLa/qFqAcnc7cp+fcM6zIPxRpE3850f2uIrSIRrhwKJVFhWTqeDBPqD+oVX8WDrJNvAX3AqKV+ohe4/Nf7tp8erNercg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfdlwqoI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1494C2BD10
	for <linux-btrfs@vger.kernel.org>; Fri, 17 May 2024 16:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715964761;
	bh=pTZnimOqpNV3bTAVdding2KtPsb9y825sFzgZK77rDY=;
	h=From:To:Subject:Date:From;
	b=hfdlwqoIq0YpKJILWPVJIIvQgt4ICCvsdWcnY6cjhknbvAtouN+BKWPknHt6ZPKCC
	 5mcxaxd9Pd0hD4d69rZEzKhaiYT6/l1JYLWpiq76lgoQlu7jbCNfuHZQsKlOKyjLTP
	 tb4qItIjSsZ5p5rL7EwNKqFm0INQCv/B8AayOg9zJ1XFgAX32z58VrHH1tNmYqzEP5
	 7ouRxr2WWAzkeCC8dy5vSWPusCXujD4Z3uHv/IgH6eMHQZDjgtRAnOHWuNcqATg7Tm
	 BiA+Af0I/TAyesNd/ewsNaP3mxXXLfrNHLQeIqFjW9BlyN7Xg19MNm5jmbEDtn2VVv
	 sw5bs1tlwfrLg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 0/2] btrfs: fix logging unwritten extents after failure in write paths
Date: Fri, 17 May 2024 17:52:36 +0100
Message-Id: <cover.1715964570.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
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

Filipe Manana (2):
  btrfs: ensure fast fsync waits for ordered extents after a write failure
  btrfs: make btrfs_finish_ordered_extent() return void

 fs/btrfs/btrfs_inode.h  | 19 +++++++++++++------
 fs/btrfs/file.c         | 15 +++++++++++++++
 fs/btrfs/ordered-data.c | 34 ++++++++++++++++++++++++++++++++--
 fs/btrfs/ordered-data.h |  2 +-
 4 files changed, 61 insertions(+), 9 deletions(-)

-- 
2.43.0


