Return-Path: <linux-btrfs+bounces-19794-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C13ACC450A
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 17:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3EDB53031D99
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 16:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6316323EAB4;
	Tue, 16 Dec 2025 16:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OS44hdHS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24CD26299
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Dec 2025 16:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765902802; cv=none; b=ZPeO8A2LiEvcq87TSf3P3EhprE1Q0p+QLq/Xh36ePkIwXghG1DSMkKuRHLvVKsQQ83MM4vDJkTIRcydv9HE+j3Yl56xvz3ThsxccoW6XJ8PMN+wWJid4uXDeB7km3UsU0SY0mftJiVG2mJKpHFd9QmGWAF/g0JlpVemuOWKNpVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765902802; c=relaxed/simple;
	bh=rOce8Ek6dfIOO9aV5an0aKdWIWln5ah8ZoTKURTDDJY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=VTrVtJXsb8eKdc9/YQo3Jje8/rVgGYh50w/ztK4hiaNSy7J4L6yLgWfv+OhhQ13nZBNnMjeHtRKon7JjHr6OParvdWcChze8wVftUXvQXu/BWaTvMpY7rDgF5PpwQ1dd85++8uoGV+w9JsjY/91IvSrfX0OaM4OmmVKNVZHAiMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OS44hdHS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE77CC4CEF1
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Dec 2025 16:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765902802;
	bh=rOce8Ek6dfIOO9aV5an0aKdWIWln5ah8ZoTKURTDDJY=;
	h=From:To:Subject:Date:From;
	b=OS44hdHSeIaUBWDDGpRi7SIcDcFHO/XigFYINcrzVj+9jtAmNmVmw96mDIxN1ddG0
	 viw8dWNUgHzWtrezo7I26xRYp0+PM/fsso/kvtNAfaqF96E6Sw55gMCQMY7nCfuLpq
	 57Fuq6/X1jUP2XBpolHpHVoq7Qp0D7wtcCuC7MGYFQ+NYxQgO5kv2VCG5otU4rhFc7
	 FKzGudyg1Yn+ZzyOB6bplcXA82v0oAf7uv7r/gG9jiQmIan5XUtOEI5NudHCttgLJ9
	 EkYHWbkB6KwAxevyrc2E62Ab72j4S0x10Ek2PscLSPGFKrNrmSMFY2/1c5SXy30850
	 jAGrYDAjzJIkQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/4] btrfs: some cleanups in btrfs_find_orphan_roots()
Date: Tue, 16 Dec 2025 16:33:15 +0000
Message-ID: <cover.1765899509.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Some cleanups in btrfs_find_orphan_roots(). Details in the changelogs.

Filipe Manana (4):
  btrfs: use single return variable in btrfs_find_orphan_roots()
  btrfs: remove redundant path release in btrfs_find_orphan_roots()
  btrfs: don't call btrfs_handle_fs_error() after failure to join transaction
  btrfs: don't call btrfs_handle_fs_error() after failure to delete orphan item

 fs/btrfs/root-tree.c | 47 ++++++++++++++++++++------------------------
 1 file changed, 21 insertions(+), 26 deletions(-)

-- 
2.47.2


