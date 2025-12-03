Return-Path: <linux-btrfs+bounces-19488-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B63ECA0878
	for <lists+linux-btrfs@lfdr.de>; Wed, 03 Dec 2025 18:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F1A330072BB
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Dec 2025 17:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80B6347BBE;
	Wed,  3 Dec 2025 17:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbrpuCkj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9D9304BCD
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Dec 2025 17:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764783490; cv=none; b=M0JZivoHcCqcFNXF5pKfGkHx+NFh69JaRiKv9sUeVNhXetWMOwgWPexrwfvN8sxtdApri+LMtalvLmfTgodMljEfHLL5Q5V0ndZSIrc108AuvnM4YZteoFpimuKJ0yliRiol1Kl+O18opHbcULNPxbHznNzXxvR6Wm96gaWyL7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764783490; c=relaxed/simple;
	bh=+d4zBPhAPDMtHt6tdDWwbW4dSMFeUA2IuNhHSPujYkQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=f1aHl8gHt33r7G56acbgFADJn1bJPtg3phgDQwjRwHb+sf42T7uHidag/gD/a44cUjV7ApezD9HfofWzB60sLHLkNpGG60npcwRc5BeTtrzX0NNQb4ePg5BewWc3wweBZJthnEcwEgJsYJ1GYKHhNaiEuqIsQqU5pObX1ARl6rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qbrpuCkj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2560DC4CEF5
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Dec 2025 17:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764783489;
	bh=+d4zBPhAPDMtHt6tdDWwbW4dSMFeUA2IuNhHSPujYkQ=;
	h=From:To:Subject:Date:From;
	b=qbrpuCkjbxGM2z1EQp2re0qkNjBIlbo3JHF+yA5aiew6UbMaopKlNDsKMDADbXhlC
	 9lJK3jw209EMmnHwgMmxOKnRYxWT4df5IoLcJZ8GGaRv29sHcd5ejNBEcgb64/js95
	 NEKdcylN76rmoxk4ClRCGJJ3QpvvDJB0kMSR/7+s6gATExUBY3kq11YtCxTeCDlQ7j
	 jb/RzOOWBLPFX/Y7DwLc7LGG3pAd5Q6f9OB1kzFjedud/zZkoJmFvQR3JaDWtORO2Y
	 4SMVLvhhsDxsRLMundkGf5yfIaqjyKFI0BBsrzu+6ljgrFl4hMU0H+eog/CaAH8H2l
	 pxsOEiPLahmMw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: do not skip logging new dentries when logging a new name
Date: Wed,  3 Dec 2025 17:38:05 +0000
Message-ID: <a1b70971f8b73d44695ab6af56b69e0ae1010179.1764783284.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

When we are logging a directory and the log context indicates that we
are logging a new name for some other file (that is or was inside that
directory), we skip logging the inodes for new dentries in the directory.

This is ok most of the time, but if after the rename or link operation
that triggered the logging of that directory, we have an explicit fsync
of that directory without the directory inode being evicted and reloaded,
we end up never logging the inodes for the new dentries that we found
during the new name logging, as the next directory fsync will only process
dentries that were added after the last time we logged the directory (we
are doing an incremental directory logging).

So make sure we always log new dentries for a directory even if we are
in a context of logging a new name.

A test case for fstests will follow soon.

Reported-by: Vyacheslav Kovalevsky <slava.kovalevskiy.2014@gmail.com>
Link: https://lore.kernel.org/linux-btrfs/84c4e713-85d6-42b9-8dcf-0722ed26cb05@gmail.com/
Fixes: c48792c6ee7a ("btrfs: do not log new dentries when logging that a new name exists")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 64c1155160a2..31edc93a383e 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -5865,14 +5865,6 @@ static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
 	struct btrfs_inode *curr_inode = start_inode;
 	int ret = 0;
 
-	/*
-	 * If we are logging a new name, as part of a link or rename operation,
-	 * don't bother logging new dentries, as we just want to log the names
-	 * of an inode and that any new parents exist.
-	 */
-	if (ctx->logging_new_name)
-		return 0;
-
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
-- 
2.47.2


