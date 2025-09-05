Return-Path: <linux-btrfs+bounces-16650-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EC5B45D89
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 18:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 377BD3A65A2
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 16:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643CD309F01;
	Fri,  5 Sep 2025 16:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQYw/ats"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C89309EF8
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 16:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757088641; cv=none; b=TWDL5SxrWWAvnmwXshtwzmMkv64UxlB6yx9p8RjD9pStVIM+Nb9Irnb+VBm6nH/fRRgSJt8HYt4LHt3avxF3/Nv/iyYdCSv2pTOZcaHXYlLZq0HEyb7F1Ur9Y6G/QWikQfQTZZ0BoB6PalMuUZgfL3dj9dDwi0ZCuuDk/nSQV9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757088641; c=relaxed/simple;
	bh=dLkby40ziB33v6+PY52OcmIkU1TRoOTGcDfT3CTe1o4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M8gVOey30O7z0uWiLgpGXimDRa+kxa8KyAolHSuBt//03H7WW2FgsbuBPBWALyq1kI2WU0aadsmtKMMb5UATBn9Him6Qf9wRAAhoC6rnjure7xrylyP3QJZ3bwDpC06cHM6/w4vzmybRH17URlw6Z6joBf7SBUyoEEbQTXp9vl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQYw/ats; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A49C4CEF1
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 16:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757088641;
	bh=dLkby40ziB33v6+PY52OcmIkU1TRoOTGcDfT3CTe1o4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=JQYw/ats4E7kvTeyr0l53vyJCmXnVn39hmUwW2Mn6C+v7TtV3Lab3acUUSgo5p8Ee
	 9EPigVyjBJo4eK2/hbaU8k+5MY7Eic2UYrEVvqktEoUtrEiKFVoGJBIWm2DFBXbIjl
	 xQw91q3SLjK8gmyuP+rX6WYebKnfkS7XOQeCAv2CrnjH4Hk3ce00okqO+HBXJKifVI
	 JRgMqrVE+BcHcG0Kah9+567mB3AgdXpPf08VOmreFptt+2M5XXFcBHGVNzqgwiJif9
	 ea3aXk+CMVEQmsaUXv+tRQ06s8Xd0Ltd8j3Lm3e55fS90eC6ZCf0ix44JuGPlW36yX
	 a67nl6ZoNtAMA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 06/33] btrfs: deduplicate log root free in error paths from btrfs_recover_log_trees()
Date: Fri,  5 Sep 2025 17:09:54 +0100
Message-ID: <33e657e1205e043cb20b223212406a75714a14b4.1757075118.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1757075118.git.fdmanana@suse.com>
References: <cover.1757075118.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Instead of duplicating the dropping of a log tree in case we jump to the
'error' label, move the dropping under the 'error' label and get rid of the
the unnecessary setting of the log root to NULL since we return immediately
after.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 7d1b21df698d..f039f0613a38 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -7491,8 +7491,6 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 			ret = PTR_ERR(wc.root);
 			wc.root = NULL;
 			if (ret != -ENOENT) {
-				btrfs_put_root(wc.log);
-				wc.log = NULL;
 				btrfs_abort_transaction(trans, ret);
 				goto error;
 			}
@@ -7510,8 +7508,6 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 			 */
 			ret = btrfs_pin_extent_for_log_replay(trans, wc.log->node);
 			if (ret) {
-				btrfs_put_root(wc.log);
-				wc.log = NULL;
 				btrfs_abort_transaction(trans, ret);
 				goto error;
 			}
@@ -7597,6 +7593,7 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 error:
 	if (wc.trans)
 		btrfs_end_transaction(wc.trans);
+	btrfs_put_root(wc.log);
 	clear_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags);
 	btrfs_free_path(path);
 	return ret;
-- 
2.47.2


