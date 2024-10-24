Return-Path: <linux-btrfs+bounces-9129-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D939AEBD9
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 18:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EE661C22997
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 16:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398D31F5836;
	Thu, 24 Oct 2024 16:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhjdAfx4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569DD1F76DC
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2024 16:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729787070; cv=none; b=EHu1dhsOoj3ME9MVA/bZDlg4a+/ditm7xYZ0+rTscDRerzEj7fpzUuZjQbkUIIgfMvU7MoWHox5XIIQrHX3nqFs6wBbajNIPniB+Kp23JXRrv/RpHDdZlJs9DwcKHXfdYP+zoXH9Myme84mIbUp+tCwojmBPAO08p4ns/o3V3qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729787070; c=relaxed/simple;
	bh=Tiiu/wK1FwTE7db9ooHqfDawhFlbwq6Wa7ogtfLpS+E=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=FxHwe7kR59GAjC6doWiqzxLOEb5xjjw2n7ji41rnj2AFkVdZfjtEOm95WjAjmfHK7uehgpvd/h6ZVTvqCf3WI+eGJO/fvBGB6pcquI1+NtU8GcnTqWkDjlBgULV4eIb/+bPEXOfHnZIwRU1CdP4UTLPeq8QGardTlj4tOpIyi58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhjdAfx4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A4E1C4CEC7
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2024 16:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729787069;
	bh=Tiiu/wK1FwTE7db9ooHqfDawhFlbwq6Wa7ogtfLpS+E=;
	h=From:To:Subject:Date:From;
	b=dhjdAfx4vAc+tKVCrOD7pqQ+mztIFKM2MR3vbd7RSOlVQxjuyjgNgzNJKTRIr8X+1
	 otPmvuoEj+94zv20Ngi7/KCevRBh26Eg0s6JObOHr8vVKdspP1M88YVOsgCUzm92qL
	 ywDTx6+mfR8M5ZIAhNWrUOYoddGR0mZgVd2Gp74XWEP97D+NMjJHad4ZmB88ISD9MJ
	 tpxiC48lKA7vMhFccKMvde6FqOm4UyTu0uqpy/JHB1lORlpneiz3sy489/xNbUfVTX
	 jvOzudkS2MvmHmPOdNO4elRlvYZegTXaBHZyNiAkgAmRzpzjx2JX8xTns8p1D2Mzpc
	 5qPJktKAJXsrg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 00/18] btrfs: convert delayed head refs to xarray and cleanups
Date: Thu, 24 Oct 2024 17:24:08 +0100
Message-Id: <cover.1729784712.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

This converts the rb-tree that tracks delayed ref heads into an xarray,
reducing memory used by delayed ref heads and making it more efficient
to add/remove/find delayed ref heads. The rest are mostly cleanups and
refactorings, removing some dead code, deduplicating code, move code
around, etc. More details in the changelogs.

Filipe Manana (18):
  btrfs: remove BUG_ON() at btrfs_destroy_delayed_refs()
  btrfs: move btrfs_destroy_delayed_refs() to delayed-ref.c
  btrfs: remove fs_info parameter from btrfs_destroy_delayed_refs()
  btrfs: remove fs_info parameter from btrfs_cleanup_one_transaction()
  btrfs: remove duplicated code to drop delayed ref during transaction abort
  btrfs: use helper to find first ref head at btrfs_destroy_delayed_refs()
  btrfs: remove num_entries atomic counter from delayed ref root
  btrfs: change return type of btrfs_delayed_ref_lock() to boolean
  btrfs: simplify obtaining a delayed ref head
  btrfs: move delayed ref head unselection to delayed-ref.c
  btrfs: pass fs_info to functions that search for delayed ref heads
  btrfs: pass fs_info to btrfs_cleanup_ref_head_accounting
  btrfs: assert delayed refs lock is held at find_ref_head()
  btrfs: assert delayed refs lock is held at find_first_ref_head()
  btrfs: assert delayed refs lock is held at add_delayed_ref_head()
  btrfs: add comments regarding locking to struct btrfs_delayed_ref_root
  btrfs: track delayed ref heads in an xarray
  btrfs: remove no longer used delayed ref head search functionality

 fs/btrfs/backref.c     |   3 +-
 fs/btrfs/delayed-ref.c | 319 +++++++++++++++++++++++++----------------
 fs/btrfs/delayed-ref.h |  61 +++++---
 fs/btrfs/disk-io.c     |  79 +---------
 fs/btrfs/disk-io.h     |   3 +-
 fs/btrfs/extent-tree.c |  69 ++-------
 fs/btrfs/transaction.c |   8 +-
 7 files changed, 256 insertions(+), 286 deletions(-)

-- 
2.43.0


