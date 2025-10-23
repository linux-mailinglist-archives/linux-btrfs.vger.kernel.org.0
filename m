Return-Path: <linux-btrfs+bounces-18187-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 655F3C02468
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 18:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB99C4F7AC6
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 16:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0459526ED48;
	Thu, 23 Oct 2025 16:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IoxbKpj7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262C726E71F
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 16:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235207; cv=none; b=lCRZQhwZNwzwaJwCqHNFLopjw7PtXxVrPebRcM+j2cuz9DSoKl+rQ2q9A4UTpSoGFYVrcHznZcFel6z0BL5Fb76bKvjzhObW0GM6E8CkA6V+f9aqCvzbdoy2kgjGQbV68jlSfVHk/mXTDMbKBwl5v2U7/p3RTz1bdfYx6L3Askk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235207; c=relaxed/simple;
	bh=CTqaMUxqMjjwXAEYVKQW9WfJdyt9YgtGehZCWHlwQL8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=X5yoXPisasmlzfKaHo7HgA9FVovllLuIJCppvIq1wTE2ZnardFHxiOvwYJkRlhHmjvFTSR0i4TU6Lv9WXy5GHzjjetEjDtWLxQ9TeKHBDVBjtLAgBRFWtfXF/T6jlQlQpGdlFewQjv0ygR0UGhImujLew6f2swYgGr/4i3PqL5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IoxbKpj7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F68C4CEE7
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 16:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761235205;
	bh=CTqaMUxqMjjwXAEYVKQW9WfJdyt9YgtGehZCWHlwQL8=;
	h=From:To:Subject:Date:From;
	b=IoxbKpj71IEWxpttRpsRIj9pJI0Zm7qvkVguo7rG5Ioy2bd8+WpFtOFDwDp6rhYfD
	 0RxBNBph9tyx1w1fqMpcDRmewMbw3D0XB+YESxmYkeonYIFsql+nzghM+WMD0I1/we
	 TMBjjh2oN7+nh0zvDoghEU9dGgnuaoeXQYmnjyJF+GkiLkYSmLLyCxtx+uHJAu8IRp
	 ouY/OU8bHvxdJJHMDdLEwcPQHOMixg6O3ws+lUYXChNkqXgva5BvY+lyZmXOFRlGZf
	 4FFKNyf+f5/FrdddcxlBNYm5DNrU+vA38iSx1ImoIpF6xUzj1L/lI5Vno4KwcLMq4i
	 2TFBPjZQNzjsg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 00/28] btrfs: some small optimizations around space_info locking and cleanups
Date: Thu, 23 Oct 2025 16:59:33 +0100
Message-ID: <cover.1761234580.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Several optimizations to reduce critical sections delimited by a
space_info's spinlock and several cleanups mostly arround space
reservation and flushing. Details in the changelogs.

Filipe Manana (28):
  btrfs: return real error when failing tickets in maybe_fail_all_tickets()
  btrfs: avoid recomputing used space in btrfs_try_granting_tickets()
  btrfs: make btrfs_can_overcommit() return bool instead of int
  btrfs: avoid used space computation when trying to grant tickets
  btrfs: avoid used space computation when reserving space
  btrfs: inline btrfs_space_info_used()
  btrfs: bail out earlier from need_preemptive_reclaim() if we have tickets
  btrfs: increment loop count outside critical section during metadata reclaim
  btrfs: shorten critical section in btrfs_preempt_reclaim_metadata_space()
  btrfs: avoid unnecessary reclaim calculation in priority_reclaim_metadata_space()
  btrfs: assert space_info is locked in steal_from_global_rsv()
  btrfs: assign booleans to global reserve's full field
  btrfs: process ticket outside global reserve critical section
  btrfs: remove double underscore prefix from __reserve_bytes()
  btrfs: reduce space_info critical section in btrfs_chunk_alloc()
  btrfs: reduce block group critical section in btrfs_free_reserved_bytes()
  btrfs: reduce block group critical section in btrfs_add_reserved_bytes()
  btrfs: reduce block group critical section in do_trimming()
  btrfs: reduce block group critical section in pin_down_extent()
  btrfs: use local variable for space_info in pin_down_extent()
  btrfs: remove 'reserved' argument from btrfs_pin_extent()
  btrfs: change 'reserved' argument from pin_down_extent() to bool
  btrfs: reduce block group critical section in unpin_extent_range()
  btrfs: remove pointless label and goto from unpin_extent_range()
  btrfs: add data_race() in btrfs_account_ro_block_groups_free_space()
  btrfs: move ticket wakeup and finalization to remove_ticket()
  btrfs: avoid space_info locking when checking if tickets are served
  btrfs: tag as unlikely fs aborted checks in space flushing code

 fs/btrfs/block-group.c      |  41 +++---
 fs/btrfs/extent-tree.c      |  72 ++++++-----
 fs/btrfs/extent-tree.h      |   3 +-
 fs/btrfs/free-space-cache.c |  20 +--
 fs/btrfs/space-info.c       | 243 +++++++++++++++++++-----------------
 fs/btrfs/space-info.h       |  18 ++-
 6 files changed, 219 insertions(+), 178 deletions(-)

-- 
2.47.2


