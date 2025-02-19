Return-Path: <linux-btrfs+bounces-11579-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BDDA3BD51
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 12:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D83DF3B6EFA
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 11:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B691EB187;
	Wed, 19 Feb 2025 11:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVfcY/2Q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC9A1E8855
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 11:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739965424; cv=none; b=ZthsENenj0fQZlbJVq6uB+LfokiVW7JoKvybqVgPyhtvqtPr6y+OCC54ZXC3A4q7O+468L7E56wTvqaEgS/LCvOcEAqF7eymIAZy/AGmhPj6paCVMrRVuuJsuB/INez5DurMAIRgK5/Bib0l6//60hZGWHHwX8hN14m/M78IONQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739965424; c=relaxed/simple;
	bh=rKG84Dm+qgA2a8K8nJHKowtWopfIOurS1J8H/BWnAXQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LgO6chwSHJqUS1JCHr6PFkYOT+vyVPZzE1Sq+5PyWPQJVHTVj3Te82XK/futd4/mHEbo36ibxZoYBxgalE2uQTYZaGCEpgwG7RLb/fzPguB1zFhelsAl7tMMJknPfXpVlMyEbZIXPDAs6RGzj1Q0e4Hz0xEWaB3pVhm/7XTZvbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVfcY/2Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CAABC4CED1
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 11:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739965424;
	bh=rKG84Dm+qgA2a8K8nJHKowtWopfIOurS1J8H/BWnAXQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=WVfcY/2QSNEWysFEy/7itgg09B0+fxSxIlaqGfwUoO1VRqYtbEwXmbLK0RJwcoJPF
	 59hY+uMi8jFGeFg1u5Ri0W1z8GQibkD5IpHUq1+lOv3YhCVSzwyfcvk26aLa6JZJDY
	 7yvDQH6Z1dj/eduHFLXETXGdoFYhiC2RZAia8O2iSogt37P06DfSN7vZB94WCGwrnP
	 ZJVvJ68rt3stwlqgmH9w4VY6b1jtTc62mSMb70cX6f40dGD8kdY96MM+KEP9eWBoIC
	 7uH8I4nu/Nvpnvxa/0eXLzW1PWgu0j5j9Cu+ZFiLqx2wQcheL1P5buzJGT7s22pJJH
	 sDQvxC8am6Ttw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 14/26] btrfs: send: add and use helper to rename current inode when processing refs
Date: Wed, 19 Feb 2025 11:43:14 +0000
Message-Id: <474e6f7bf43469d83f91f5c455d0a0454a8e5c36.1739965104.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1739965104.git.fdmanana@suse.com>
References: <cover.1739965104.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Extract the logic to rename the current inode at process_recorded_refs()
into a helper function and use it, therefore removing duplicated logic
and making it easier for an upcoming patch by avoiding yet more duplicated
logic.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 6e27a7d77b25..653e0b9a94ca 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4133,6 +4133,19 @@ static int refresh_ref_path(struct send_ctx *sctx, struct recorded_ref *ref)
 	return ret;
 }
 
+static int rename_current_inode(struct send_ctx *sctx,
+				struct fs_path *current_path,
+				struct fs_path *new_path)
+{
+	int ret;
+
+	ret = send_rename(sctx, current_path, new_path);
+	if (ret < 0)
+		return ret;
+
+	return fs_path_copy(current_path, new_path);
+}
+
 /*
  * This does all the move/link/unlink/rmdir magic.
  */
@@ -4418,13 +4431,10 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 		 * it depending on the inode mode.
 		 */
 		if (is_orphan && can_rename) {
-			ret = send_rename(sctx, valid_path, cur->full_path);
+			ret = rename_current_inode(sctx, valid_path, cur->full_path);
 			if (ret < 0)
 				goto out;
 			is_orphan = false;
-			ret = fs_path_copy(valid_path, cur->full_path);
-			if (ret < 0)
-				goto out;
 		} else if (can_rename) {
 			if (S_ISDIR(sctx->cur_inode_mode)) {
 				/*
@@ -4432,10 +4442,7 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 				 * dirs, we always have one new and one deleted
 				 * ref. The deleted ref is ignored later.
 				 */
-				ret = send_rename(sctx, valid_path,
-						  cur->full_path);
-				if (!ret)
-					ret = fs_path_copy(valid_path,
+				ret = rename_current_inode(sctx, valid_path,
 							   cur->full_path);
 				if (ret < 0)
 					goto out;
-- 
2.45.2


