Return-Path: <linux-btrfs+bounces-14729-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74908ADD5C2
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 18:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AE062C79FA
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 16:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4ED82ED176;
	Tue, 17 Jun 2025 16:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KSS/WdYG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A9C2ED171
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 16:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176792; cv=none; b=I/mKzfRyzDZGhAy+N64PhTimQb8hYpoS7ZkWCOOsUqaWwTjJhFCC3i6qZTJR445fXd5zQAMbAMBYNNJbopWu555T3/MgeU2PJX39+EfJr9rxrPtAoeBM6Zo0tiwRaiTUlVo535xeRUAGrOZhEkJopbtJm+VhYs6ikjmGf/Vo8kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176792; c=relaxed/simple;
	bh=wDOiPGDXAiQcwlarDvLcTcMqg+kEjJaknuPMl2WdI20=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=t8VOSJS919dFSSLdUwPwYzhWey1xLQ5J6Yw5F4tS3JqhRDZMe6g9jFHMWY0ol3N1v9zZx91l1S8Ow7ElxiTqYBTCzoiANk+msITz0JFGg74l87Ecl+N7uz4gsWXhWEIt6QjnyuUbzo19qwEmUrkNO1L5ISMK8Kfqn9NksZtUu20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KSS/WdYG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21BC0C4CEF1
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 16:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750176791;
	bh=wDOiPGDXAiQcwlarDvLcTcMqg+kEjJaknuPMl2WdI20=;
	h=From:To:Subject:Date:From;
	b=KSS/WdYGeu2Zv1KApN190u8wXLdsCiitw1xBSpLZYMB4b3K4IOeOydk/sz5TxzvcC
	 EBXR0vqDlQk+kPuWeDswa0oejRbGa+3hFId/0i8cxn+tUvImA4HxonoIontd6M5iCS
	 MtwWKP5kbgFyj5I3a1fPKm/a+08JMzqQ5S+70FBydd/GXW0XDaeCxza6TB86fOprs2
	 NGe9SZySeVh/53SBpTEmxNZhRyj5ExzFhAb6c25GxB+9kFSnwwPPOl1wmf3M60Fcrz
	 F1jZ44Aj8nqQTA+CmXsVWk7FQwzsPEglkX0xu092butBKqSVugWawKsZUS/CysaSD3
	 werpNpDqBUwdg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 00/16] btrfs: free space tree optimization and cleanups
Date: Tue, 17 Jun 2025 17:12:55 +0100
Message-ID: <cover.1750075579.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

A free space tree optimization (last patch in the series), and the rest
mostly cleanups and preparatory work. Details in the change logs.

Filipe Manana (16):
  btrfs: remove pointless out label from add_new_free_space_info()
  btrfs: remove pointless out label from update_free_space_extent_count()
  btrfs: make extent_buffer_test_bit() return a boolean instead
  btrfs: make free_space_test_bit() return a boolean instead
  btrfs: remove pointless out label from modify_free_space_bitmap()
  btrfs: remove pointless out label from remove_free_space_extent()
  btrfs: remove pointless out label from add_free_space_extent()
  btrfs: remove pointless out label from load_free_space_bitmaps()
  btrfs: remove pointless out label from load_free_space_extents()
  btrfs: add btrfs prefix to free space tree exported functions
  btrfs: rename free_space_set_bits() and make it less confusing
  btrfs: turn remove argument of modify_free_space_bitmap() to boolean
  btrfs: avoid double slot decrement at btrfs_convert_free_space_to_extents()
  btrfs: use fs_info from local variable in btrfs_convert_free_space_to_extents()
  btrfs: add and use helper to determine if using bitmaps in free space tree
  btrfs: cache if we are using free space bitmaps for a block group

 fs/btrfs/block-group.c                 |  10 +-
 fs/btrfs/block-group.h                 |   5 +
 fs/btrfs/extent-tree.c                 |   4 +-
 fs/btrfs/extent_io.c                   |   4 +-
 fs/btrfs/extent_io.h                   |   4 +-
 fs/btrfs/free-space-tree.c             | 293 ++++++++++++-------------
 fs/btrfs/free-space-tree.h             |  52 ++---
 fs/btrfs/tests/extent-io-tests.c       |  14 +-
 fs/btrfs/tests/free-space-tree-tests.c |  93 ++++----
 9 files changed, 234 insertions(+), 245 deletions(-)

-- 
2.47.2


