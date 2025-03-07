Return-Path: <linux-btrfs+bounces-12086-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB54A56936
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 14:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F24041768A4
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 13:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0998221ABA6;
	Fri,  7 Mar 2025 13:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVX1u57t"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51510219EB8
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Mar 2025 13:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741355069; cv=none; b=TqcjpLdr4UR9tUs2VzrP9faLsEwlA/0d3s6pWDiS3k8WoA6fewXnGH9iJztq6JOX9HHJD0Mp3D2cuMWZ5Nt7McGvsBRLf1xY6ejvyFwJjPhrAH/B/r3PDSCQTaD8JLv443loT5HQigQMd6vLPlE08QY59SRwJfd1wegukxZSW+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741355069; c=relaxed/simple;
	bh=OF0NxfhHUodMW3MpJ18V1as56uIZ8NmJQO3ffZCOXu4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=tobaC5thbvlXei8l25S9Lp+EamIheyYdnpAAFaRY73hS6bf1brvctq5JetWMqjEv7IRkO/MbhJzOk0bEEbHL4PudGWl02KWB7lzhjvYHlNAJ3ja0oXRHHaDzpxtUvOERC8JLsdboP1rQBVIvYvBopbUlplaLoFIJBCwV9ISmc+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVX1u57t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4640DC4CED1
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Mar 2025 13:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741355068;
	bh=OF0NxfhHUodMW3MpJ18V1as56uIZ8NmJQO3ffZCOXu4=;
	h=From:To:Subject:Date:From;
	b=EVX1u57ty87RExM6SfPeocWckHcQ/yCAeKx/exfq1BgBS75gsps3suyt7GgTpFc+T
	 vVxYbMP1RaTSbFdaMoEhE/J102ixPtCpYFkfCiejufsgC6TqEXcr8WzEsvSIw/dXmk
	 0T0DUC667BmUDRmPQzKZjQKwnoOkmCOfpbfrMVnIgFSOXwbz2hyCdTXzA1phZpkood
	 ZnKQxOdtklDZ5LkBT5dKXecLm7XsFjLVgqPuX4G6ZhzKi0GbbtKNLFSmk98976xrOM
	 MkD/nZ5UfuYp4KAVgffRar4BuXz9qCjGcKzoYzweIXgaPMcCP7EzWXRy+aYIG+zU1b
	 L84Uj2vAhYJ5A==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/8] btrfs: some trivial cleanups
Date: Fri,  7 Mar 2025 13:44:17 +0000
Message-Id: <cover.1741354476.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

A group of trivial cleanups that started with making log tree code
less verbose while fixing a couple bugs, by removing repeated BTRFS_I()
calls, and then extended to btrfs_iget() and removing redundant arguments
from a few functions. Details in the change logs.

Filipe Manana (8):
  btrfs: return a btrfs_inode from btrfs_iget_logging()
  btrfs: return a btrfs_inode from read_one_inode()
  btrfs: pass a btrfs_inode to fixup_inode_link_count()
  btrfs: make btrfs_iget() return a btrfs inode instead
  btrfs: make btrfs_iget_path() return a btrfs inode instead
  btrfs: remove unnecessary fs_info argument from create_reloc_inode()
  btrfs: remove unnecessary fs_info argument from delete_block_group_cache()
  btrfs: remove unnecessary fs_info argument from btrfs_add_block_group_cache()

 fs/btrfs/block-group.c      |  16 +--
 fs/btrfs/btrfs_inode.h      |   6 +-
 fs/btrfs/defrag.c           |  14 +-
 fs/btrfs/export.c           |  17 ++-
 fs/btrfs/free-space-cache.c |  10 +-
 fs/btrfs/inode.c            |  64 ++++-----
 fs/btrfs/ioctl.c            |   7 +-
 fs/btrfs/relocation.c       |  30 +++--
 fs/btrfs/send.c             |  25 ++--
 fs/btrfs/super.c            |   4 +-
 fs/btrfs/tree-log.c         | 261 +++++++++++++++++-------------------
 11 files changed, 225 insertions(+), 229 deletions(-)

-- 
2.45.2


