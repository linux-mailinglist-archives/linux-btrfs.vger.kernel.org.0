Return-Path: <linux-btrfs+bounces-14175-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 305F6ABFC79
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 19:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69D2D7A5E15
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 17:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01312289E25;
	Wed, 21 May 2025 17:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7qSDyeG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4569B289837
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 17:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747849456; cv=none; b=UDBBcfAE5GKqi9dDjLll6Hgd+u9SUsruTqNwb7Jhr6Wd5gOVvAdZpX1u2ZJRemXyb4M+YPLn5DlNS4N2bfU8gYlHQqdwrZdXdKvyLsxtmoK3dbHDOHpKNWAVAyJWybGasbxxXQUZWv0APxogGIYM4Vv1mtB6bAVD6UuRVa0qo80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747849456; c=relaxed/simple;
	bh=4I7FHkr1YHwnVhUdzsNicCZA+z6gBo/zl34DqFGAQoQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=a+GsuBilG0STKvUMtNhx8hXOMUbwmQS/BPU6DCza0hbFVCFQmRN17gTm4bMEMIHubYSKhrN6qChQAn9t/9JfjJFlFu2Po2KUAZOeC3+LA790cxF8sffpkfrIHMzP48tGeBruQmJ1/I31d6AdYHkYeqNdK5iNxLbzAllsXVl7nks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7qSDyeG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E4AC4CEE4
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 17:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747849454;
	bh=4I7FHkr1YHwnVhUdzsNicCZA+z6gBo/zl34DqFGAQoQ=;
	h=From:To:Subject:Date:From;
	b=l7qSDyeGVAN0iULtReAOpAbG3Vk+SDBMb/vup86R469RU22BReLoLNivs1omFXyIB
	 0Lj04u8Wp8iM7s4wAALU9NO0mZWTIdVLk47bnCizOB0YimQGoWur/POl/E2fXnewgs
	 fHdQjX9jYscQzahaSQzNpnE6konnS8hnsBMV6pQs1tGyOwc3NNxVt/S9J0bNnR8ClZ
	 oIVt4ESLvPNRpTie/ISb89O6hedpvRztZR2liqiREJFQlXQkbuw9ifGdyXa06i65uJ
	 aUEREWhdQtmrxSue3S2sldb4RexxGGU1SkLI+AtFvwtMZ/WuTy16PF9ZudjogiBm2t
	 BjF6g3GnSMD/w==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/4] btrfs: some cleanups for the log tree replay code
Date: Wed, 21 May 2025 18:44:07 +0100
Message-Id: <cover.1747848778.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

A set of trivial cleanups after running into a bug I'm debugging where
replaying directory deletes is failing. Details in the change logs.

Filipe Manana (4):
  btrfs: unfold transaction aborts when replaying log trees
  btrfs: abort transaction during log replay if walk_log_tree() failed
  btrfs: remove redundant path release when replaying a log tree
  btrfs: simplify error detection flow during log replay

 fs/btrfs/tree-log.c | 64 ++++++++++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 27 deletions(-)

-- 
2.47.2


