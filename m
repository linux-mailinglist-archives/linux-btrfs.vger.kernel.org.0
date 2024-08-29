Return-Path: <linux-btrfs+bounces-7680-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C99A965348
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Aug 2024 01:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFA581C21F50
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Aug 2024 23:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D310C1B86F1;
	Thu, 29 Aug 2024 23:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgQhURK7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054CC18786F
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Aug 2024 23:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724972981; cv=none; b=MuKlwSfTGgAPF3507B9UmpIjILLkN2cUsjg/rgpO1xIBLLm0kZQBHPhi0K3utFkefNJRQ4OCFquQNu9Yo21LLs3uBYAQsLEwdlriEtnLQkFwJf/VTSwTdbapP69tiPsMQnYcPIOxs3jMUAxuVm/v8vNB+Jp0Di0GBmZAVipeRyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724972981; c=relaxed/simple;
	bh=pCgLzO4KJr2J43OdOVeXNDd31ykuS5ggmd+U1UMdcJw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=LjONjSiFJAXZh+nPMDK05gbwTWz6ppbv+AMW0y9YFcywnZQu2GFjTu/YtLSAtvheHUhall3XE0syYAndmBfbtb+cwz0zp68MiqA5IMaDbEnCpKKnkQYdFlHtGKu2THvvFT3GfALTuIiDPEJBXqbKJblZEIvfwopURyHG8/OF5lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VgQhURK7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 199C3C4CEC1
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Aug 2024 23:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724972980;
	bh=pCgLzO4KJr2J43OdOVeXNDd31ykuS5ggmd+U1UMdcJw=;
	h=From:To:Subject:Date:From;
	b=VgQhURK7gAbAx8TBUPloQS0sbCrCXF+HwAcSuq4XeobbCCGNHP1t4MSPCAnGA5ndl
	 /yhE6VYw+FKbAN4V4qqpnSrzMDRa31i24AV1u2bWWs+ZjnzogYLugwKAT5cM4Lhpqw
	 zGYE6KidK9GTQ+/zwNTZ/cTbW/FSqrFFbNFTwBLlLm7eittr8pb5Kdw/ih5tZD8ScD
	 Pv5qKFlAVkroTozm2terdqrgopElf2ThOvD1NHjDwgywz8Er0e9X7TvAMZBT3yXfFz
	 5Gs34GLWryfH9p9X4w6MRCuAcOlx2MsjG8b3sKDB6AkQ/KIrfvg8Qg7hCWWH/mW7dA
	 Bai2qGa/PhX3A==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: fix a regression with concurrent DIO writes and fsync on the same fd
Date: Fri, 30 Aug 2024 00:09:35 +0100
Message-Id: <cover.1724972506.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Fix a recent regression when doing concurrent direct IO writes and fsync
using the same fd from multiple threads. This was reported recently by a
couple users when using QEMU, as well as syzbot. The fix is the first
patch in the series, the second one is just an improvement for some
assertions. Details in the change logs of each patch.

Filipe Manana (2):
  btrfs: fix race between direct IO write and fsync when using same fd
  btrfs: add and use helper to verify the calling task has locked the inode

 fs/btrfs/btrfs_inode.h  |  8 ++++++++
 fs/btrfs/ctree.h        |  1 -
 fs/btrfs/direct-io.c    | 16 +++-------------
 fs/btrfs/file.c         |  9 +++++++--
 fs/btrfs/ordered-data.c |  2 +-
 fs/btrfs/transaction.h  |  6 ++++++
 fs/btrfs/tree-log.c     |  2 +-
 fs/btrfs/verity.c       |  6 +++---
 fs/btrfs/xattr.c        |  2 +-
 9 files changed, 30 insertions(+), 22 deletions(-)

-- 
2.43.0


