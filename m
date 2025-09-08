Return-Path: <linux-btrfs+bounces-16704-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF72B4891C
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 11:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 036ED1741EF
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 09:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4577A2F7AAF;
	Mon,  8 Sep 2025 09:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+2YfRCZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887502F657F
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 09:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325219; cv=none; b=DF5EznIjzAPUMuVIl07B/duVGA/a0IrjCu4xr47goG4pPF7r5aritOsLPZb5iRZC291ubmmgj1Q9a9KwPBiIKVE0TCa+8ZTjS05aZcFU6nAjFHgdF92QKZ1tz7J4AlauKp6v5jTj1htH6fGPBRGneWAijb5grFTfxkFZD4koosI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325219; c=relaxed/simple;
	bh=LK9Apy8r1lbNeId6cYnEYEcEdKz0SWncXf78dYQunQY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fR5KqDUsXnGBbYLpdeNacKUlU/jhfJCF8Zl4XqdETksOvK79L8LVmz59ii0Jo3fh8ueGnQpEM/PHkVSzYdzSygrAOyhSdXodNW3fZZFqrPafD9kqmMx5CeZGq7kP7iyvNmHiJSFHbxE7thU9pE+zuzzm6YFH1jFZ+YxATM3lRec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+2YfRCZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9ECBC4CEF8
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 09:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757325219;
	bh=LK9Apy8r1lbNeId6cYnEYEcEdKz0SWncXf78dYQunQY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=c+2YfRCZKMuHMz6i7qzUO/bAAe5GGCSCPU77BjAGjIS2gHt0pTvE2eP0vwRg9evh+
	 A4FPSdfTDdscg0RWa2TfJUyvzfHCkti2g37hTTnBXMTDtmwvS77NgF+vBOT//KHGC/
	 PLpqcOU/HIEx9/otua4CikDJhZ3MihvUGuQ5Jyqr5yssHIYRIKf8l/9HJp2WauJR5C
	 pv4jsUSeWjAbWR3gMdEVUFbh2M/yTcqdFk9KjQRxzHdlr4BBIqFvA/IkS0mhpyEDwf
	 MUIakGM4HbvFaMeBZ9ea7o849zqQS0QSCh6S5Uwz3p+5B6CCnWXR0yOIMtxBR3BhBu
	 xvPEqdFeXPoQQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 09/33] btrfs: always drop log root tree reference in btrfs_replay_log()
Date: Mon,  8 Sep 2025 10:53:03 +0100
Message-ID: <e93740b6b73fe149827e6706683424b8e3d160ef.1757271913.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1757271913.git.fdmanana@suse.com>
References: <cover.1757271913.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Currently we have this odd behaviour:

1) At btrfs_replay_log() we drop the reference of the log root tree if
   the call to btrfs_recover_log_trees() failed;

2) But if the call to btrfs_recover_log_trees() did not fail, we don't
   drop the reference in btrfs_replay_log() - we expect that
   btrfs_recover_log_trees() does it in case it returns success.

Let's simplify this and make btrfs_replay_log() always drop the reference
on the log root tree, not only this simplifies code as it's what makes
sense since it's btrfs_replay_log() who grabbed the reference in the first
place.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/disk-io.c  | 2 +-
 fs/btrfs/tree-log.c | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 7b06bbc40898..8dbb6a12ec24 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2088,10 +2088,10 @@ static int btrfs_replay_log(struct btrfs_fs_info *fs_info,
 
 	/* returns with log_tree_root freed on success */
 	ret = btrfs_recover_log_trees(log_tree_root);
+	btrfs_put_root(log_tree_root);
 	if (ret) {
 		btrfs_handle_fs_error(fs_info, ret,
 				      "Failed to recover log tree");
-		btrfs_put_root(log_tree_root);
 		return ret;
 	}
 
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index ab2f6bab096b..4d34aee0cafa 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -7586,7 +7586,6 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 		return ret;
 
 	clear_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags);
-	btrfs_put_root(log_root_tree);
 
 	return 0;
 error:
-- 
2.47.2


