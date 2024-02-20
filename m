Return-Path: <linux-btrfs+bounces-2584-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E96D85BBF5
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 13:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 058CE1F21D01
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 12:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1BB69954;
	Tue, 20 Feb 2024 12:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f84eBkVb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CB4692FC
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Feb 2024 12:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708431881; cv=none; b=ZCfvQk5xJLN8pkwBPE4s/NgWtm7HTw0lYdvyxgn4bAVQViX1qkkfij1qE5zrKKWy1BEvckTJyVp/LRMOc2Qa4A7MDUrg48Dz3GYb17TSOjGT8lwaH9Yh501W91L9kM+hZ6yb23+R+Qzf3xQqSOwSLrX+DfGgcLaeVgtgECs4X5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708431881; c=relaxed/simple;
	bh=gtWtLWd8/wA+RjE6bZzp5u+ly7pdKAiJKlctcGrLkHs=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=oN7cPx7OhPD7R28QqUM1se6LI0gSf1zK1sh7MveuEHYIqcyl6h+IagnbBEtQ3zjWuFWtwzJFZol6gViLwPfVIUGxxjGyXLmygF8aP6o+ytxqIOecKc78m+wPWD9OqrIK9o6HbaJ8E6wnF1P6b12ZXR5fIj2N401k63+iL5SPigw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f84eBkVb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A7FC433C7
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Feb 2024 12:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708431881;
	bh=gtWtLWd8/wA+RjE6bZzp5u+ly7pdKAiJKlctcGrLkHs=;
	h=From:To:Subject:Date:From;
	b=f84eBkVbOIx0x3oUyDf0LCIaGcOP1s0m8Yt+ldGU8H30d3nMRZNw8tXZI+PfBCZvn
	 Gh48jQQrEkQuGsmSEc6otsKW7nOBoC5w7uvUP8LQC8tsXpI4VtkF9xa8Q8g3sWhjWZ
	 p9sljqlPk6BEH9QFfRB741zFPEHb/JGJlkw58nAQhAUkUvZzLnBDtt9vwQr4c1Mtoz
	 kayMPotaTn52nUyeHIzHWDn0TAVvL6s2bDyeYUNnAcQ85+QmQ0ffpZ50PNxJBeys1V
	 JqrrviQqUDr5eeoTo2FNECygUUYA4vL2cjnuMJLHxyNTHkIfIbEfZE2BrZXXL7itbm
	 uC3kK05LCgPcg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: fix a couple KCSAN warnings
Date: Tue, 20 Feb 2024 12:24:32 +0000
Message-Id: <cover.1708429856.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

KCSAN reports a couple data races around access to block reserves.
While they are very likely harmless it generates some noise and reports
will keep coming, so address these.

Filipe Manana (2):
  btrfs: fix data races when accessing the reserved amount of block reserves
  btrfs: fix data race at btrfs_use_block_rsv() when accessing block reserve

 fs/btrfs/block-rsv.c  |  2 +-
 fs/btrfs/block-rsv.h  | 32 ++++++++++++++++++++++++++++++++
 fs/btrfs/space-info.c | 26 +++++++++++++-------------
 3 files changed, 46 insertions(+), 14 deletions(-)

-- 
2.40.1


