Return-Path: <linux-btrfs+bounces-17717-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8A6BD5891
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 19:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 984E618A5C08
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 17:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1375E2FB637;
	Mon, 13 Oct 2025 17:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYTH9sPk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5605426FD86
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 17:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760377095; cv=none; b=DUGB/vmSwqpThv7cS8b0TtQVtV4NJ9jx4I67kNZayfN68FHbAaSXVNjJYupHaBSgHidB954AXbXqEXEvtcSNo5yWotlC/Uiv/4+JTdvCkGNot7I81gAnXK24U5jmTjj6ygDRK9iNmfdoIbi5PD7diwuu2P8S+n9oF2cnKqJV8hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760377095; c=relaxed/simple;
	bh=VkyUuMoA2zt6xgo9D5Wq6vHyHJZV8MUflISEdFtVmxI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=s+20jFaZgmjSBzgONYUoq5X8YN+5At9DQVZGf88oTZQY2e9H035enypE3zsa4ERQ2BUWO6sUscVLRXZrWOgCaHrXbkb14XAhQMhcJkHn0IN8DiOseMBBJZxj5FOk0JjLOkTesHSXDdwEF+ez6ls9g/z2fb5x0W1Oz+g5biZcdeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYTH9sPk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD102C4CEE7
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 17:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760377095;
	bh=VkyUuMoA2zt6xgo9D5Wq6vHyHJZV8MUflISEdFtVmxI=;
	h=From:To:Subject:Date:From;
	b=QYTH9sPkm44D8DFIEG92CdptGK9nvWCgOs/46KbQ0+xoVBs0Q2plrasXzSn7rC8w7
	 5Ds9mBqcLKTBwnMpizRc8dO9oS/ki4cEV9bz/lLjnSe8tSla+U/kFX1xIht2pFADAO
	 9dvsE6A43DQGxDAUDF0RGo5E1y7UkEcdxI15KydOsLeSMXwsNxkAWdJOfvBgpq8ILA
	 qmLS1Y6/pJETThUnMiCnlsvAe/6UsJhuccC8TYy7S9cd7M737SIkIgWu/VXFsLEZga
	 iNRPrIC/QvDIYK5XmE/+pP/xMOZPShHBtaFXSaksjyDRHEPhIgVH+UYgc5A3O26aSI
	 m9JxmMWTIEq1A==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 00/16] btrfs: remove fs_info argument from space_info functions
Date: Mon, 13 Oct 2025 18:37:55 +0100
Message-ID: <cover.1760376569.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We don't need to pass fs_info since we can grab it from a space_info.
More details in the changelog, trivial patchset.

Filipe Manana (16):
  btrfs: remove fs_info argument from btrfs_try_granting_tickets()
  btrfs: remove fs_info argument from priority_reclaim_data_space()
  btrfs: remove fs_info argument from priority_reclaim_metadata_space()
  btrfs: remove fs_info argument from maybe_fail_all_tickets()
  btrfs: remove fs_info argument from calc_available_free_space()
  btrfs: remove fs_info argument from btrfs_can_overcommit()
  btrfs: remove fs_info argument from btrfs_dump_space_info()
  btrfs: remove fs_info argument from shrink_delalloc() and flush_space()
  btrfs: remove fs_info argument from btrfs_calc_reclaim_metadata_size()
  btrfs: remove fs_info argument from need_preemptive_reclaim()
  btrfs: remove fs_info argument from steal_from_global_rsv()
  btrfs: remove fs_info argument from handle_reserve_ticket()
  btrfs: remove fs_info argument from maybe_clamp_preempt()
  btrfs: fix parameter documentation for btrfs_reserve_data_bytes()
  btrfs: remove fs_info argument from __reserve_bytes()
  btrfs: remove fs_info argument from btrfs_reserve_metadata_bytes()

 fs/btrfs/block-group.c    |  15 ++--
 fs/btrfs/block-rsv.c      |  14 ++--
 fs/btrfs/delalloc-space.c |   4 +-
 fs/btrfs/delayed-ref.c    |   2 +-
 fs/btrfs/extent-tree.c    |   3 +-
 fs/btrfs/space-info.c     | 168 +++++++++++++++++---------------------
 fs/btrfs/space-info.h     |  14 ++--
 fs/btrfs/transaction.c    |   4 +-
 8 files changed, 101 insertions(+), 123 deletions(-)

-- 
2.47.2


