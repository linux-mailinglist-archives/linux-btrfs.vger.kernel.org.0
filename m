Return-Path: <linux-btrfs+bounces-12646-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3B0A74C78
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 15:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 454AC16CE70
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 14:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18BE1BD9CE;
	Fri, 28 Mar 2025 14:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pfSiEBby"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253351B0F33
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Mar 2025 14:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743171848; cv=none; b=T2RUbR+o1BGMFxW6Bc6M8FmGlj14QbHdItGaMHrtTBIlXdORAJzQDMsKrXkjuqxiTLTDjXJGrrmFxo3akQZ6WENKZyjCQpK6xu3FXsQH6ZmrMubT4d/waLAx3oQnSOKJFxBifLSQuYkeQMKpRyCE1VzaBv8yUe/1s2YEJQaW3uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743171848; c=relaxed/simple;
	bh=6HtG6MiwlKbFZ9Hp6owW80lhx89PBBwC33tH87g1160=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Db88uP/BPl+Ldz2E5g9zPPQY7zmpHSKyQXmgfdjDtzWNolRS60urw/TD5LrVpOT1S2PjpntEAv18H6Y61up6UZeuniFmZ9M9v29OA7EQ3ETWQ8VLjJjG32OYVmlzjfW7whbri9FY2FPydffuTf9BXcivhbWzgs5YE3u5A3vc5l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pfSiEBby; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F116AC4CEE4
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Mar 2025 14:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743171847;
	bh=6HtG6MiwlKbFZ9Hp6owW80lhx89PBBwC33tH87g1160=;
	h=From:To:Subject:Date:From;
	b=pfSiEBbyMPtMBBcCLcW0NW0mnEVravj9yJ9ZiEjtPt+ZUI+a0jYkHTdbJdXUFO4ks
	 4ZLJ5l8zCIEp7OFOOMvnvuVHVvrMraUMZE6Y2jjb6C3y8hz6CMHNptCQpjBxeCtY+D
	 kLd5xzElbQjZwGpopVp0lKTL1XFpySBdhhQjQAPLsrTKF5XwxkHwQ8jncI4yR0zo2p
	 yL9pIpsVsZC06RCoKl/gxxHSt1YWH0BinnyQ6mKIlxUVc8qjjRc3sJqTEtGjZCOKka
	 qKSkW9l9I1BWWARjIjnkhACrZnsaLcBE4GLwGKuGlFuh8adTx1V4Bp+6V/txYIDcBR
	 pfYxpEARrvZTg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: some cleanups related to io trees
Date: Fri, 28 Mar 2025 14:24:01 +0000
Message-Id: <cover.1743166248.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Remove some no longer used/needed code related to io trees.
Details in the change logs.

Filipe Manana (3):
  btrfs: remove leftover EXTENT_UPTODATE clear from an inode's io_tree
  btrfs: stop searching for EXTENT_DIRTY bit in the excluded extents io tree
  btrfs: remove EXTENT_UPTODATE io tree flag

 fs/btrfs/block-group.c           |  9 ++++-----
 fs/btrfs/extent-io-tree.h        |  8 --------
 fs/btrfs/inode.c                 | 22 ++++++++++------------
 fs/btrfs/relocation.c            |  3 ---
 fs/btrfs/tests/extent-io-tests.c |  1 -
 fs/btrfs/tests/inode-tests.c     | 12 ++++--------
 include/trace/events/btrfs.h     |  1 -
 7 files changed, 18 insertions(+), 38 deletions(-)

-- 
2.45.2


