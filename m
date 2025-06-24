Return-Path: <linux-btrfs+bounces-14916-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40606AE69C8
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 16:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35EB31C21EF9
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 14:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E790B2DFF19;
	Tue, 24 Jun 2025 14:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iT+fHiyQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FDD2DFA47
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Jun 2025 14:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750776147; cv=none; b=dipnlTDSNyQCagIgDZzduccBiLQUmo3hPtHXoFx/8Add2IbTMy5MWNFR+8UchwVtPbroLn/pn6JuPQvyGuGmUdIAjntbwhvNlMHHRtm7fKHT3RJCXv9am01prxXpwPKKYtZEIPS79aM0RLbtHY4BkgY4S7/tSjAKIJEw6WLoJlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750776147; c=relaxed/simple;
	bh=seqKq9xnTtkKakOWHVj6NDk3hYTnnEp1hQkBI7q9f1g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=qDhm3U8xS8DkLXZT7UM/kusdcHggejS5IgNLH20LUD58GhiAPswfZleyH2EqOs++6wX31CGJmgiDZP1v0BNZwryt7j6itxiFUQ4n2UVFDTwHfJ2LuOmgVUR+5HTxS8jvS5Q93DrFkNYLvY7JCaSNrgd0wvDGWP3n8iuUMXZx+v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iT+fHiyQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E0BCC4CEE3
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Jun 2025 14:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750776146;
	bh=seqKq9xnTtkKakOWHVj6NDk3hYTnnEp1hQkBI7q9f1g=;
	h=From:To:Subject:Date:From;
	b=iT+fHiyQhJnH0aYT705raiZTQzGQ4GL6Dcv/dYAMF7qMNKwbFbWvDb9pGys5i6BUw
	 Leq28RoF26Qzm85FLi6YlpyDvd/a1RxPwxBZu5psvAlKP3em9C5da4oHr0nIxeP8jV
	 itZzwDHWwooswBvw2ef2Mw6cpmGL0rIqlvQZ0nqwoSoITVXLgT/Be7VzPk4whuG4rQ
	 PupvJEwFkWVNZiDM25zZzxgDMV9E2Mbg8f9GIy75ag+oBsLPU/hYblc48pow0H9C4Y
	 +/oZXqJ6Dughi4VHNCwS/XhMVvDRm5lbaUFmKMkPzLOj/w5p1KgmgAc/Qw1JmnoZEh
	 HxrsdXlt2a8jQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 00/12] btrfs: log tree fixes and cleanups
Date: Tue, 24 Jun 2025 15:42:10 +0100
Message-ID: <cover.1750709410.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Several bug fixes for logging and log replay, plus some cleanups.
Details in the changelogs.

Filipe Manana (12):
  btrfs: fix missing error handling when searching for inode refs during log replay
  btrfs: fix iteration of extrefs during log replay
  btrfs: fix inode lookup error handling during log replay
  btrfs: record new subvolume in parent dir earlier to avoid dir logging races
  btrfs: propagate last_unlink_trans earlier when doing a rmdir
  btrfs: use btrfs_record_snapshot_destroy() during rmdir
  btrfs: use inode already stored in local variable at btrfs_rmdir()
  btrfs: use btrfs inodes in btrfs_rmdir() to avoid so much usage of BTRFS_I()
  btrfs: split inode ref processing from __add_inode_ref() into a helper
  btrfs: split inode rextef processing from __add_inode_ref() into a helper
  btrfs: add btrfs prefix to is_fsstree() and make it return bool
  btrfs: split btrfs_is_fsstree() into multiple if statements for readability

 fs/btrfs/ctree.h        |  17 +-
 fs/btrfs/delayed-ref.c  |  10 +-
 fs/btrfs/disk-io.c      |   8 +-
 fs/btrfs/extent-tree.c  |   6 +-
 fs/btrfs/extent_map.c   |   6 +-
 fs/btrfs/inode.c        |  64 +++----
 fs/btrfs/ioctl.c        |   8 +-
 fs/btrfs/qgroup.c       |  25 +--
 fs/btrfs/relocation.c   |   2 +-
 fs/btrfs/tree-checker.c |  12 +-
 fs/btrfs/tree-log.c     | 362 ++++++++++++++++++++++------------------
 11 files changed, 281 insertions(+), 239 deletions(-)

-- 
2.47.2


