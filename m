Return-Path: <linux-btrfs+bounces-9363-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D305F9BE644
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Nov 2024 12:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6915BB251E3
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Nov 2024 11:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8501F669B;
	Wed,  6 Nov 2024 11:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rx4qI7n/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7368D1F667B
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Nov 2024 11:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730893851; cv=none; b=NON4Y9dQPQvz0X9eMqSL1H1rfy0ykUNerDEZaULx8rumC61i2kHx9zJIXfpewaInIGgG+HwxizofUleLzo+Td66vegnATK24Yw4rQR8lTU5wDMV5Lssk2CugzQQh+6HDXCpKgOGnlHzZQQDfS1XtSrVDeJPAJ1aDVXCLqB/UKkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730893851; c=relaxed/simple;
	bh=zKzX8IxewO2WjA9xl9/q2XAm335FISAh0Ki8XKJI/is=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GXbGaUqB86z/lfKH9HSoycK0Co8dsfHg308l018rIVmBEg8Vz3tePICR3r7gTgSvSydQQ4Wi6G9TlO9QaCqYuy3Mfo9Qs7zRpkbppt1K4hpBFRn9lilE2UyLmD097X64qPLK864ULxb6Gmkrrym9ddYkBr/ui5a/3a4ibEHy3Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rx4qI7n/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE5DC4CED7
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Nov 2024 11:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730893851;
	bh=zKzX8IxewO2WjA9xl9/q2XAm335FISAh0Ki8XKJI/is=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=rx4qI7n/Fdo4iCzf4oHxO09orVQcFr7XtfNL40Llb3BxJqoojGpLcpVhyGS6PAoIa
	 /H9RIElql9Xb6PIHlZQdTOCf2PMSg09RVr++dySjumaqX3L7+d9qjlFSjkbyXdIlfP
	 9Ro7Qchhq830nkg7uvahOhVqkqyv4JZcZRGyaVMvJNxp4B4eRaErbFUNpNK3Wq5Ybu
	 kFPZs9si0qDh3U7P1dW+apetpP9o6FJm7XddL+PssD2AY8zQI4JxHtDC42WGZ+eI+W
	 pyUyC4hArANXdzOYcipIkZUC2esa5VCnoDNtn+JXjJvfQ7rT1Ak5mZkKYmTO3IcXZc
	 apkgMuP5DXQGw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: send: check for dead send root under critical section
Date: Wed,  6 Nov 2024 11:50:45 +0000
Message-Id: <e1899c7f343a0ba0f78f9aecbda3517cb530aa28.1730892928.git.fdmanana@suse.com>
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

We're checking if the send root is dead without the protection of the
root's root_item_lock spinlock, which is what protects the root's flags.
The inverse, setting the dead flag on a root, is done under the protection
of that lock, at btrfs_delete_subvolume(). Also checking and updating the
root's send_in_progress counter is supposed to be done in the same
critical section as checking for or setting the root dead flag, so that
these operations are done atomically as a single step (which is correctly
done by btrfs_delete_subvolume()).

So fix this by checking if the send root is dead in the same critical
section that updates the send_in_progress counter, which is protected by
the root's root_item_lock spinlock.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index cadb945bb345..3fcc8113641d 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -8125,6 +8125,14 @@ long btrfs_ioctl_send(struct btrfs_inode *inode, const struct btrfs_ioctl_send_a
 	 * making it RW. This also protects against deletion.
 	 */
 	spin_lock(&send_root->root_item_lock);
+	/*
+	 * Unlikely but possible, if the subvolume is marked for deletion but
+	 * is slow to remove the directory entry, send can still be started.
+	 */
+	if (btrfs_root_dead(send_root)) {
+		spin_unlock(&send_root->root_item_lock);
+		return -EPERM;
+	}
 	if (btrfs_root_readonly(send_root) && send_root->dedupe_in_progress) {
 		dedupe_in_progress_warn(send_root);
 		spin_unlock(&send_root->root_item_lock);
@@ -8207,15 +8215,6 @@ long btrfs_ioctl_send(struct btrfs_inode *inode, const struct btrfs_ioctl_send_a
 	}
 
 	sctx->send_root = send_root;
-	/*
-	 * Unlikely but possible, if the subvolume is marked for deletion but
-	 * is slow to remove the directory entry, send can still be started
-	 */
-	if (btrfs_root_dead(sctx->send_root)) {
-		ret = -EPERM;
-		goto out;
-	}
-
 	sctx->clone_roots_cnt = arg->clone_sources_count;
 
 	if (sctx->proto >= 2) {
-- 
2.45.2


