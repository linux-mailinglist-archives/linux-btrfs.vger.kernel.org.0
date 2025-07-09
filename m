Return-Path: <linux-btrfs+bounces-15400-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A90EAFF2D8
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 22:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C22195A26B4
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 20:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CFA242D8A;
	Wed,  9 Jul 2025 20:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4auB4L3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD4523A564
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 20:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752092436; cv=none; b=MAoGq81FTHU3QGlX4aetqESkV80Hp+F2yO8cKW1hEssamBkQhKJMJG3nHhCn44q6CZZCrsAelRQfgCGW+BTYY4oJoOyrZDIVj1LzymdQ/jTtS28sP/xlwYaczTODoSZxeZy2vVB4E3lIzbtnzrx1Z3hhhEO4znhrfoNO9Z+zAKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752092436; c=relaxed/simple;
	bh=yLPesu5rQk7NsT46qU/uPx1M04fDf82gvzlMFBuMhds=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GrlLxA1WCH29VIhB22jLUiX97t2Tf+MAOLSl4OBcsatn7b0w7XG6MCtxQO+fACgkDn12PXi4vz0CfPBowf+bT7B8tv/MGYyXMN2m5COueZzEEfu4K5R6jnOP5Uf/8fcTJ0KYgqV3tPTSQvqgxNHljqOhJ6I0W5WFdWrsmIslO4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4auB4L3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA770C4CEF5
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 20:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752092436;
	bh=yLPesu5rQk7NsT46qU/uPx1M04fDf82gvzlMFBuMhds=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=b4auB4L3i9dZSPzGQuGAfoSVo2uOxVtY1fe1nH/hsPwMyJ8l14QJKGgWArzdjinQe
	 Qedbw4HzE6CA4ENtgVyTQTma8BsDCuu26BWsmRqFO/yBL3IX+F3KJ2onmnymhw0phW
	 1Io+NowM8VQuZYRoRENThejMaR4s77FzQU8ke5HLfvjJx0PR3+nSi9geTErQvzzhxm
	 gbK7hzD/jb4igYG7pUXaCCKPT82Q1gMzfUHn3eDfZKbp2EMO23Q0ojzzCBDvL/bD07
	 q0XeQQT9KhsrfehwUy1KmvCLcMSqCl9fVs5N2xg9pFiR66IGWQIhCFIFD5OE4X+e5w
	 sqYX+ET28ezWA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: update function comment for btrfs_check_nocow_lock()
Date: Wed,  9 Jul 2025 21:20:28 +0100
Message-ID: <c0749620cc3ec466aa018461f3fd95c119210a6e.1752092303.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1752092303.git.fdmanana@suse.com>
References: <cover.1752092303.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The documentation for the @nowait parameter is missing, so add it.
The @nowait parameter was added in commit 80f9d24130e4 ("btrfs: make
btrfs_check_nocow_lock nowait compatible"), which forgot to update the
function comment.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 37bf473f2132..c2e83babdb8d 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -962,6 +962,7 @@ lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct folio *folio,
  * @pos:         File offset.
  * @write_bytes: The length to write, will be updated to the nocow writeable
  *               range.
+ * @nowait:      Indicate if we can block or not (non-blocking IO context).
  *
  * This function will flush ordered extents in the range to ensure proper
  * nocow checks.
@@ -970,7 +971,8 @@ lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct folio *folio,
  * > 0          If we can nocow, and updates @write_bytes.
  *  0           If we can't do a nocow write.
  * -EAGAIN      If we can't do a nocow write because snapshoting of the inode's
- *              root is in progress.
+ *              root is in progress or because we are in a non-blocking IO
+ *              context and need to block (@nowait is true).
  * < 0          If an error happened.
  *
  * NOTE: Callers need to call btrfs_check_nocow_unlock() if we return > 0.
-- 
2.47.2


