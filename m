Return-Path: <linux-btrfs+bounces-10240-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 210E39ECF4C
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 16:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C95D168019
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 15:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73B1194A67;
	Wed, 11 Dec 2024 15:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACVfLn4R"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22C524634E
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 15:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733929512; cv=none; b=WptRPf6lzfAWLgOdGyAA3ydkvlLbv8rzVKxd00j3pPHFBMdSiqfYVQI1QN+JYVX9Gx+C2nKpwK+1dDOaXVj+ZamxBlV3yT78dSQqoeBN3tIRF+X36d6cRx/DsmuVmmVf+u4BeXmQrarRBs4A4WtLulx+B3ogQ/TtkH7tVftEXxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733929512; c=relaxed/simple;
	bh=D8Xdi6FwoLfpMO7lIWDPJS+zuIqay+kZCmP8/B4ath4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oZ/xulNO1tWG/A8+J6s0C/CfUE5efq3auAWscFPsdLe8DnLSGd4OVWl7zXp291aSMQgMhXuNzECI9NkFerymDXrApJQt87iyKGy/Aa4+U2+IJCSTlV45xlmUJdy80yAhHtEW4SyJhtBHP/LRvgpoZY/WsAtbDD2pSoLOrs1o/hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACVfLn4R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D6E3C4CED2
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 15:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733929511;
	bh=D8Xdi6FwoLfpMO7lIWDPJS+zuIqay+kZCmP8/B4ath4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ACVfLn4R6l3tFYvfY1ILUZlZbveNG0klHngIk0uv7M5BQC+0jeQ8PfBLnT/xD/m7V
	 3VlzzDKEYEBWcIuf+wuEaIQBwrUwW/bKfzbE/tav4uqlFm6KAP/4ql89xm0+yb7e0E
	 E6Mt8kaaBk5HjCxbRo7z5H0G3+V7CVG0vIX2EiqFwVDnyIWtkpmcuxbfYIGRXhgTDg
	 dqdXQ2DB//u6EvkJxZoHCSQRE3GhDYfXoyADWR5Kog5AMcORSAwDWQIv12vZCP1w18
	 z2I9PKeaRmZflzBxfzGcERXfyg3sKKN3Vvo7+uofPXzFkG/ebKeMzOp+xwDaJersOw
	 nzwTT5G4EUEng==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 00/11] btrfs: fixes around swap file activation and cleanups
Date: Wed, 11 Dec 2024 15:04:57 +0000
Message-Id: <cover.1733929327.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1733832118.git.fdmanana@suse.com>
References: <cover.1733832118.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There are a couple issues with swap file activation, one being races with
memory mapped writes, while the other one is a failure due to buggy
detection of extent sharedness - we can often consider an extent as shared
when it is not but it used to be. The rest are just some cleanups or
enhancements.

V2: Updated patch 10/11, it mentioned a no longer existing argument that
    removed in patch 05/11, the patches were re-ordered at some point.

Filipe Manana (11):
  btrfs: fix race with memory mapped writes when activating swap file
  btrfs: fix swap file activation failure due to extents that used to be shared
  btrfs: allow swap activation to be interruptible
  btrfs: avoid monopolizing a core when activating a swap file
  btrfs: remove no longer needed strict argument from can_nocow_extent()
  btrfs: remove the snapshot check from check_committed_ref()
  btrfs: avoid redundant call to get inline ref type at check_committed_ref()
  btrfs: simplify return logic at check_committed_ref()
  btrfs: simplify arguments for btrfs_cross_ref_exist()
  btrfs: add function comment for check_committed_ref()
  btrfs: add assertions and comment about path expectations to btrfs_cross_ref_exist()

 fs/btrfs/btrfs_inode.h |   2 +-
 fs/btrfs/direct-io.c   |   3 +-
 fs/btrfs/extent-tree.c | 128 +++++++++++++++++++++++++-----------
 fs/btrfs/extent-tree.h |   3 +-
 fs/btrfs/file.c        |   2 +-
 fs/btrfs/inode.c       | 146 +++++++++++++++++++++++++++++------------
 fs/btrfs/locking.h     |   5 ++
 7 files changed, 203 insertions(+), 86 deletions(-)

-- 
2.45.2


