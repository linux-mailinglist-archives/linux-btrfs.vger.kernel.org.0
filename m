Return-Path: <linux-btrfs+bounces-9364-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 924879BE647
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Nov 2024 12:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5647C288469
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Nov 2024 11:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4721DED76;
	Wed,  6 Nov 2024 11:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTmDJjou"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D451F667B
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Nov 2024 11:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730893852; cv=none; b=WS6qcoXhGVlHcroaW6dJnbLAgvWHWdELB9nyAj+cSw6hbNuBtUurH1kPzlttp7GR01NT6RJqUWQUl8nGTVzTF4Vfojxzlfeu/yExUthh2iEduFBvr4fBr+RgcvTFt2jZIN8Tw2XyMuVlMv1/3ugt9ueU9OnvBA9cSzgOnvSIN08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730893852; c=relaxed/simple;
	bh=IpZix5SK0DnjLf2Ro0Ml/0QOF1RTYQQ7MppGLlMuk44=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qd/fGifbaa6GftiIxar1i3IGdZ54se89dUzEliAwD0SOP++evsfCoWF75w4jgYwgjpErxBHeDCqL4+xdF+r8hn1SiLp5DDCWmmCG041dBnjF0d7ZqFC1kABm0JQP2EfeIx+58zQfkPpUuj+Hyx6cNAW3zHF02eKROo10sUa59bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTmDJjou; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA218C4CED4
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Nov 2024 11:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730893852;
	bh=IpZix5SK0DnjLf2Ro0Ml/0QOF1RTYQQ7MppGLlMuk44=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=BTmDJjouE7Ts7okjcPG/yewStX0DjBO0lOPWSzuHP6QrFUgA7NLfzvIo6tDA6D3/T
	 +JBqqtOMPkhNXw6a3+dJO7sjhBb0f05bi/RVJIne6PtVg2JtG1JncATTLlNKTabRdZ
	 rCNdveSKju6cnIbvmjo5aPr+O3BgjMbcd5e8oq2ZAOYQUaYKrnkYcp3JjYcVc+LXdm
	 ZkGC08BqZF42F13bhFkOtjNcQJRGQjKbBVZhjNw0TVDWP7QSJO9YLd8jTOYRpCWzPg
	 aFwB/Bl5vS/V1AMQQjFYkwNU5KFxfmIHC4i+JWBk/oaAqmYjgBRsYNWZkL9EL73E/6
	 /Zs1K5vcoPT7A==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: send: check for read-only send root under critical section
Date: Wed,  6 Nov 2024 11:50:46 +0000
Message-Id: <9d93c7970de221d5045212aa4be5200aa271e081.1730892928.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1730892925.git.fdmanana@suse.com>
References: <cover.1730892925.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We're checking if the send root is read-only without being under the
protection of the root's root_item_lock spinlock, which is what protects
the root's flags when clearing the read-only flag, done at
btrfs_ioctl_subvol_setflags(). Furthermore, it should be done in the
same critical section that increments the root's send_in_progress counter,
as btrfs_ioctl_subvol_setflags() clears the read-only flag in the same
critical section that checks the counter's value.

So fix this by moving the read-only check under the critical section
delimited by the root's root_item_lock which also increments the root's
send_in_progress counter.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 3fcc8113641d..7254279c3cc9 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -8133,7 +8133,12 @@ long btrfs_ioctl_send(struct btrfs_inode *inode, const struct btrfs_ioctl_send_a
 		spin_unlock(&send_root->root_item_lock);
 		return -EPERM;
 	}
-	if (btrfs_root_readonly(send_root) && send_root->dedupe_in_progress) {
+	/* Userspace tools do the checks and warn the user if it's not RO. */
+	if (!btrfs_root_readonly(send_root)) {
+		spin_unlock(&send_root->root_item_lock);
+		return -EPERM;
+	}
+	if (send_root->dedupe_in_progress) {
 		dedupe_in_progress_warn(send_root);
 		spin_unlock(&send_root->root_item_lock);
 		return -EAGAIN;
@@ -8141,15 +8146,6 @@ long btrfs_ioctl_send(struct btrfs_inode *inode, const struct btrfs_ioctl_send_a
 	send_root->send_in_progress++;
 	spin_unlock(&send_root->root_item_lock);
 
-	/*
-	 * Userspace tools do the checks and warn the user if it's
-	 * not RO.
-	 */
-	if (!btrfs_root_readonly(send_root)) {
-		ret = -EPERM;
-		goto out;
-	}
-
 	/*
 	 * Check that we don't overflow at later allocations, we request
 	 * clone_sources_count + 1 items, and compare to unsigned long inside
-- 
2.45.2


