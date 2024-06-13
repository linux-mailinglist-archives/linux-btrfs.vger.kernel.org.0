Return-Path: <linux-btrfs+bounces-5705-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF522906AB0
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 13:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F17901C22EC2
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 11:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAF1142E84;
	Thu, 13 Jun 2024 11:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rbTAFFrh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2179E142E70
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2024 11:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718276732; cv=none; b=OuSxd51Hh3oHGOV3rMKSxUMRHCdt4+yFp9XBEDOgAmQsDe4czRLGgMjka+67kD7AQNaKFPTYcM7agPruzSGLzlV+uYaiYz10injA4aMo/UFuuUhiXsKjdStX30CLANp5JjUTHq+8XYWfIQJL1d25DcVCiN31cP1lNWdOsPzijzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718276732; c=relaxed/simple;
	bh=sXFik2XIDsSpTXLYDJieHibIPWWGvFKhogceOv/JZ4Y=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=HqvCHlZ9fUKHF9gF/2+31lyMEysQnaOFbnDJxDLyFHHBPIW7Co28P5aMEWLRvPs5bDLb5v/ZYOWw//ax2PjZ/PySE7G9k6wJCgr6TrLcDEdwon+CNzLoigF6oWCBo3a/hImL0w8ENZ2r5rgKsmFWrhRhKJtX3Rfl+NpcQSAKQss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rbTAFFrh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D358C2BBFC
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2024 11:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718276731;
	bh=sXFik2XIDsSpTXLYDJieHibIPWWGvFKhogceOv/JZ4Y=;
	h=From:To:Subject:Date:From;
	b=rbTAFFrhzOTMRAhOcPykKGHVqnGbOB5bIN6GfKNpbtX4gyRrTKcegTZh5og9FFqvb
	 45w1F7mqeHUypwWRIT0cW5CsPzVF2E18n8PQPe3jXKgDU7nuIhPeQKNUMNJ2DKvTMt
	 ZYAvHCah7b9ANLSTafFJEKCbk6yjOc2D/ZbPwq22rSZKQ0yg5hcqcPbcgYzCmCOIcS
	 6PCpMq5Ybt7doPN2FbK42ms0XHfUOkAXH5DRCiW2dSXrvzENv/8+IdbmW20wyfTrzc
	 i7ZrwFz8MbI8Ub1s/qZtDqUDQSNw4c3tyFxRdN/+ZPtV67f/uiXQB5zJeVZNhIXOLt
	 EoxEDBtsYomWA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/4] btrfs: fix a deadlock with reclaim during logging/log replay
Date: Thu, 13 Jun 2024 12:05:24 +0100
Message-Id: <cover.1718276261.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Fix a deadlock when opening an inode during inode logging and log replay
due to a GFP_KERNEL allocation, reported by syzbot. The rest is just some
trivial cleanups. Details in the change logs.

Filipe Manana (4):
  btrfs: use NOFS context when getting inodes during logging and log replay
  btrfs: remove super block argument from btrfs_iget()
  btrfs: remove super block argument from btrfs_iget_path()
  btrfs: remove super block argument from btrfs_iget_locked()

 fs/btrfs/btrfs_inode.h      |  6 +++---
 fs/btrfs/defrag.c           |  2 +-
 fs/btrfs/export.c           |  4 ++--
 fs/btrfs/free-space-cache.c |  3 +--
 fs/btrfs/inode.c            | 24 ++++++++++-----------
 fs/btrfs/ioctl.c            |  3 +--
 fs/btrfs/relocation.c       |  4 ++--
 fs/btrfs/send.c             |  9 ++++----
 fs/btrfs/super.c            |  2 +-
 fs/btrfs/tree-log.c         | 43 ++++++++++++++++++++++++-------------
 10 files changed, 54 insertions(+), 46 deletions(-)

-- 
2.43.0


