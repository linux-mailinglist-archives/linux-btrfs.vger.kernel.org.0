Return-Path: <linux-btrfs+bounces-16932-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B18FB84A1A
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 14:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28863543CFE
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 12:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D992FFDC1;
	Thu, 18 Sep 2025 12:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+5fq9zl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156632F7465
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 12:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758199345; cv=none; b=pzAUszyoWVavEyKeHrfPlZGgmYpciJlDRP7JQQeXlPhFyMG1s4eF28hwjYxmfXnXwnSMBxs3L4TbGraK1f3/G6DqeKpT5PKgJwYwT6NZSmmczSOt2+AaRLAc7Gs6q5q7aU7KbK3WYKBfO5xlu6rfU8q8A0ZLePaKltyQvmck/Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758199345; c=relaxed/simple;
	bh=39kbu3qMNUkerpBOMycXE/HpFpaUcZ4AFcGZ2S2GA14=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WJrOuoFVHtvwLJ3m9bPTfdTGIbl1r1s36R/X5o1LfquE/M7kNJjPCUGvIZjzraSa6Khvdkz6qFYNnQH4pGQi2hrZyeTJnaPUwt/Q6cCrJTz47ngFQnuMZ31qk63hT6VwrKFDNZ4q3ijgXndmrMhkGoGvzDLMgaf4PjRbSvDpWD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+5fq9zl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32419C4CEF7
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 12:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758199344;
	bh=39kbu3qMNUkerpBOMycXE/HpFpaUcZ4AFcGZ2S2GA14=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=g+5fq9zlhQ1p7Uhp1jkH6fnyKVg9V9wPmuldLP+sPmpC8oSM8S9m7mWv9oKgnaByB
	 d3ONYUzcnJ9MoGkY0wkORmMZzr7yudEJnYCkz1rYNVdJkVhiXd5Q3eSIcQpTGSRucz
	 muHqHCfH+eZFqAxvQhM9dOTcDyR5zi0Un3RDixzczxKIrkt6OGeZhqUjOdodfpbhKe
	 WgleqAF5ZqzQyxZjuVBiS/yUSkXLCBN0XGwVQ+0zThejqyNrNf4MCaRXfaDNSFb4AQ
	 zGEGdUJOJBPK2+8oEJC27wgOROC/vgFsrFHjFOXvM2cnBYDCNDWM+p49AQruryz4aK
	 XrApycSIMbrXg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: fix comment about nbytes increase at replay_one_extent()
Date: Thu, 18 Sep 2025 13:42:18 +0100
Message-ID: <2eb36cf3f5719ec0d7350424f3968dda9c7a794a.1758198953.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1758198953.git.fdmanana@suse.com>
References: <cover.1758198953.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The comment is wrong about the part where it says a prealloc extent does
not contribute to an inode's nbytes - it does. Only holes don't contribute
and that's what we are checking for, as prealloc extents always have a
disk_bytenr different from 0. So fix the comment and re-organize the code
to not set nbytes twice and set it to the extent item's number of bytes
only if it doesn't represent a hole - in case it's a hole we have already
initialized nbytes to 0 when we declared it.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 144b12725365..96492080fed8 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -740,15 +740,10 @@ static noinline int replay_one_extent(struct walk_control *wc)
 
 	if (found_type == BTRFS_FILE_EXTENT_REG ||
 	    found_type == BTRFS_FILE_EXTENT_PREALLOC) {
-		nbytes = btrfs_file_extent_num_bytes(wc->log_leaf, item);
-		extent_end = start + nbytes;
-
-		/*
-		 * We don't add to the inodes nbytes if we are prealloc or a
-		 * hole.
-		 */
-		if (btrfs_file_extent_disk_bytenr(wc->log_leaf, item) == 0)
-			nbytes = 0;
+		extent_end = start + btrfs_file_extent_num_bytes(wc->log_leaf, item);
+		/* Holes don't take up space. */
+		if (btrfs_file_extent_disk_bytenr(wc->log_leaf, item) != 0)
+			nbytes = btrfs_file_extent_num_bytes(wc->log_leaf, item);
 	} else if (found_type == BTRFS_FILE_EXTENT_INLINE) {
 		size = btrfs_file_extent_ram_bytes(wc->log_leaf, item);
 		nbytes = btrfs_file_extent_ram_bytes(wc->log_leaf, item);
-- 
2.47.2


