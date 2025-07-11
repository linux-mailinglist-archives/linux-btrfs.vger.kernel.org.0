Return-Path: <linux-btrfs+bounces-15479-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B51B025D6
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 22:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5602C3B7ED7
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 20:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3BD20DD48;
	Fri, 11 Jul 2025 20:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMmSVJ30"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B274B1FE451
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Jul 2025 20:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752266204; cv=none; b=M+fq1ttrsfrJMT2tY73fZCaoh+z3I1ytkAaEpbiLXB33jdsIvFPdOD2UI9sB0HDjA20ZSwHNGbLr+3CfkzwYl2XQ2r+EBS8G8QCAkQhqDe9c7xVb0lfqrqOVijXm3O/VLv2cO/X/iM3fZorcVFNZyALG0ArRqb+9aoklcGfudYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752266204; c=relaxed/simple;
	bh=kc9jKNRk2jtARdthmt22W2ocoIX24z8B6wC7+jgQrAU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XaWckzGWO7yUJySDytdjDCPl4Tpd+BfaZEM8+57ZOf1S88ciUwNy/6tSNDBp/plToHZ/0c00rx9FGNvuV0EY2rr96Loy/JUAUOGxPwNfmTiQyypR/KkA5HIrjDX32oKy2PO5SUr3qewfjdTZCEWdUL4yfYZaV85TFFLQNO5Tsoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VMmSVJ30; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2C3C4CEF4
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Jul 2025 20:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752266204;
	bh=kc9jKNRk2jtARdthmt22W2ocoIX24z8B6wC7+jgQrAU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=VMmSVJ30bZfSNK8dHUCdHGhiYelWo2RZJ6kPLLhzBN06AcLPcF54q0yox232zUOlv
	 d0t180q5ayFvl7sfTYGxZ3UoyC7xlJCR110f9OmNwTAFRSs+HgiLebL5AVEEMk7wNo
	 TG7NyOCnwUbtRDl+hCF7qiWrV7ixA6kCY/3MDBSQfXwTkGBVPoI8xSAHyHTx7UD/yG
	 mMf3qiYA1dOZlCeM8g4/WKELeot/Ao4KC8+tdrU1CAYi2hUQc37q3XcK/Kf8mvteHr
	 Tp8kPJe3vB2DnSu1VaMEB91F+dJuKIWsr+XbmJicMWJ/b66IXnO91T9nBxsaYXghUa
	 M8XI9z1Mw1WGg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/3] btrfs: don't ignore inode missing when replaying log tree
Date: Fri, 11 Jul 2025 21:36:38 +0100
Message-ID: <37c78983a2ec090ef23aa71d1109fb0f2dcb6f8f.1752266047.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1752266047.git.fdmanana@suse.com>
References: <cover.1752266047.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

During log replay, at add_inode_ref(), we return -ENOENT if our current
inode isn't found on the subvolume tree or if a parent directory isn't
found. The error comes from btrfs_iget_logging() <- btrfs_iget() <-
btrfs_read_locked_inode().

The single caller of add_inode_ref(), replay_one_buffer(), ignores an
-ENOENT error because it expects that error to mean only that a parent
directory wasn't found and that is ok.

Before commit 5f61b961599a ("btrfs: fix inode lookup error handling during
log replay") we were converting any error when getting a parent directory
to -ENOENT and any error when getting the current inode to -EIO, so our
caller would fail log replay in case we can't find the current inode.
After that commit however in case the current inode is not found we return
-ENOENT to the caller and therefore it ignores the critical fact that the
current inode was not found in the subvolume tree.

Fix this by converting -ENOENT to 0 when we don't find a parent directory,
returning -ENOENT when we don't find the current inode and making the
caller, replay_one_buffer(), not ignore -ENOENT anymore.

Fixes: 5f61b961599a ("btrfs: fix inode lookup error handling during log replay")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 5bdd89c44193..beb47a603411 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -1416,6 +1416,8 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 	dir = btrfs_iget_logging(parent_objectid, root);
 	if (IS_ERR(dir)) {
 		ret = PTR_ERR(dir);
+		if (ret == -ENOENT)
+			ret = 0;
 		dir = NULL;
 		goto out;
 	}
@@ -1440,6 +1442,15 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 				if (IS_ERR(dir)) {
 					ret = PTR_ERR(dir);
 					dir = NULL;
+					/*
+					 * A new parent dir may have not been
+					 * logged and not exist in the subvolume
+					 * tree, see the comment above before
+					 * the loop when getting the first
+					 * parent dir.
+					 */
+					if (ret == -ENOENT)
+						ret = 0;
 					goto out;
 				}
 			}
@@ -2551,9 +2562,8 @@ static int replay_one_buffer(struct btrfs_root *log, struct extent_buffer *eb,
 			   key.type == BTRFS_INODE_EXTREF_KEY) {
 			ret = add_inode_ref(wc->trans, root, log, path,
 					    eb, i, &key);
-			if (ret && ret != -ENOENT)
+			if (ret)
 				break;
-			ret = 0;
 		} else if (key.type == BTRFS_EXTENT_DATA_KEY) {
 			ret = replay_one_extent(wc->trans, root, path,
 						eb, i, &key);
-- 
2.47.2


