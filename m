Return-Path: <linux-btrfs+bounces-14367-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C70ACAC86
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 12:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A707517E7BC
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 10:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03BA204840;
	Mon,  2 Jun 2025 10:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ReDEX5e3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130031624E1
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 10:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748860401; cv=none; b=FmtYw8JMhhAVfzyyH6MPaTlqcOoHGef9K6RWeycPZw37ylNcKUyJDAjofT1SWkoIQjKH8wTRhBoxYqpzDJVgL8RTplTV1voBxhzMRbFHuEA1NEBFYLhMzopAzMY1aABSBPRTZBMGMdYrdfl312fXF86kDvMwDSoKiPJHo/sx3Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748860401; c=relaxed/simple;
	bh=Z7FN7niSPqh3gCb/ZX/EM/4azuHBTRopDhTw1VImpiI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jjb/SRzY/9mzolwVBrbM3ZCblUMDY5gOWB4mt+sfdZxUpKurKv0OACOm/DT0ilz25hX9tlawAivBlJ9TLCmNEKFcZWekPzNXCXyxqLrLiTLmXjjTRXsJbwMJ3U8J25qhm0UEl/gJ3a9n/Tw4NHX1QSd50op1IpeeyYq8IMLTsFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ReDEX5e3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F8FC4CEED
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 10:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748860400;
	bh=Z7FN7niSPqh3gCb/ZX/EM/4azuHBTRopDhTw1VImpiI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ReDEX5e3anbZCdO4+jpXVtql6ZwAk+2gkjlBzIsqSVRN1FdDdfotaaYKwAPqTvbbk
	 fBQFzvHZkf+ythXBeFVvGLQ7r2IKsEJ7OOkgYuV4RLYAM8tZtbcGB65nMl7R1nq2Hf
	 OAGn86VC1JUqQuWynzcXWfb8UBfKcvObdwm1ptb7JDjFhfCMhEevM5nHsnT/ZeQuLp
	 XHaqNPqimhE1oZp5vDHJZVtTNQylszSXjOZFZiUgdsyG/1zfR4GST4FsxlbVQqIXmP
	 v6+LfAcL3b/jTgh0TCu4qVCgAydxSXuG/s2wJFPzq/0NzdapFKa/dAV4GX1ZEg9+3v
	 KoRrAawW4NO6Q==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 06/14] btrfs: allocate path earlier at btrfs_del_dir_entries_in_log()
Date: Mon,  2 Jun 2025 11:32:59 +0100
Message-ID: <e3f8146b07006070d70b1879fa09440a2d7ae5a8.1748789125.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1748789125.git.fdmanana@suse.com>
References: <cover.1748789125.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Instead of allocating the path after joining the log transaction, allocate
it before so that we're not delaying log commits for the rare cases where
the allocation takes a significant time (under memory pressure and all
slabs are full, there's the need to allocate a new page, etc).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 14506a09f28e..cbdf9791ec5d 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3472,27 +3472,27 @@ void btrfs_del_dir_entries_in_log(struct btrfs_trans_handle *trans,
 		return;
 	}
 
+	path = btrfs_alloc_path();
+	if (!path) {
+		btrfs_set_log_full_commit(trans);
+		return;
+	}
+
 	ret = join_running_log_trans(root);
 	ASSERT(ret == 0, "join_running_log_trans() ret=%d", ret);
 	if (WARN_ON(ret))
-		return;
+		goto out;
 
 	mutex_lock(&dir->log_mutex);
 
-	path = btrfs_alloc_path();
-	if (!path) {
-		ret = -ENOMEM;
-		goto out_unlock;
-	}
-
 	ret = del_logged_dentry(trans, root->log_root, path, btrfs_ino(dir),
 				name, index);
-	btrfs_free_path(path);
-out_unlock:
 	mutex_unlock(&dir->log_mutex);
 	if (ret < 0)
 		btrfs_set_log_full_commit(trans);
 	btrfs_end_log_trans(root);
+out:
+	btrfs_free_path(path);
 }
 
 /* see comments for btrfs_del_dir_entries_in_log */
-- 
2.47.2


