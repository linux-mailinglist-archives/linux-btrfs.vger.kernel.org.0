Return-Path: <linux-btrfs+bounces-4964-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A1E8C57D5
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 16:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5F74B21890
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 14:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BEF14533E;
	Tue, 14 May 2024 14:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJnZQkSq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C74145332
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 14:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715696628; cv=none; b=QBg8hxiKwA/10ggrsxX4BuFFt87qGvcZUdCSolZrTsaAgQ4Ii00UOFprSDC42qtF+exgfIJhdHVv757cq3vHPTHelerVKbcXW6CuT15DeegwaSwFW67h7djQFIrT651pX+Vq8gH3j+nJoMGSXvupj5yTV2onoc1pPkXhr8/yPeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715696628; c=relaxed/simple;
	bh=bL2OEu9UONwwIpfDb9gBdK6tz3zHtysU0RJ7WWnZel0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=kDilLIOwbXcLbDeRgRcZLj6PgdL2SJKH4dqr8jyGYNcWq1N8Y4PERcd3fUuonIIDw6u6STzWXwfcdWrhJa55RZYoOqbqVbr9S9GtOXObb40VZlrcsCwWdyUFa8QxIsRpUWhqEMBJ/p1OHkAE1P9ByKtxh4+A3/XVMFsFDiJVBIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJnZQkSq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B27CC4AF08
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 14:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715696628;
	bh=bL2OEu9UONwwIpfDb9gBdK6tz3zHtysU0RJ7WWnZel0=;
	h=From:To:Subject:Date:From;
	b=NJnZQkSqe9Vfum3T2/0pI+hcTty5npoAuV1TXAZ1BT1Yhfhdm4CL8uXEx4Mj1PRoJ
	 XxYM7B5+MSfAqoftUWzJd4HpJb2FNKwobYm7zKrRU/x0k3myL38wP3+X9Vez5cI+4R
	 gXk/P4VdEVD3+p0AgVHzPvM0BoT4EC5O7IZsLTz/rD/qw2YiVuE0cII5XTUWIdP4sU
	 MnjYXcByBjPFj+o2aqu/CmPcuCZ8yFhLndDuptHhLzkzNLrUPgSOvQ52ENV57jW1Aw
	 8sJMgVOHuWkoVNH7T2BJg4fJrYVpPwQfK8Q/yRMezSAb8gf/eFhZIkcm0OY4R9YUUC
	 m8GOTiuGiS4tw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: fix a bug in the direct IO write path for COW writes
Date: Tue, 14 May 2024 15:23:38 +0100
Message-Id: <cover.1715688057.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Fix a bug in an error path for direct IO writes in COW mode, which can make
a subsequent fsync log invalid extent items (pointing to unwritten data).
The second patch is just a cleanup. Details in the change logs.

Filipe Manana (2):
  btrfs: drop extent maps after failed COW dio write
  btrfs: refactor btrfs_dio_submit_io() for less nesting and indentation

 fs/btrfs/inode.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

-- 
2.43.0


