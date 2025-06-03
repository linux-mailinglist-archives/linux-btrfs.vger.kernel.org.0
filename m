Return-Path: <linux-btrfs+bounces-14419-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F1CACCD69
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 20:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CC41168292
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 18:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED944202F79;
	Tue,  3 Jun 2025 18:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6QBHzyQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B9C19C54E
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Jun 2025 18:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748976912; cv=none; b=BELFsySZg0oN6iG23HJ089yXKgqix6D0rdfzdEB4VFtBcEA+CdH/0GZPBgQzyA/85NnV/AL65vXc0g9Nm9CMaNQL01jg+nris7DJtwifib3SC9TFc3qG0ixqwJ4Y+lUEIujNxejwZYeXU+gsCl8ISInqYZ3ysREyha5YNa2THGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748976912; c=relaxed/simple;
	bh=X1pa+QoiNnt3+tFnssi5kL+1AcgShmdBHdBHrVoIhH4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=CsMkf3S+fGnnKZUKKUHQ28ghA6awrZTXIm4E26dU96CO6aJfls/LMRT988z11rXOz5lD3J7l0AACPGAzLM0C5oWrrVR+Bo389OwNLl0VgBse165Q5BKWZaXh0PPAhb5X07s5+CPxeCmje+jJIVgmjGCTjf8XQbDKWwarTsPSwVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u6QBHzyQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26078C4CEED
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Jun 2025 18:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748976910;
	bh=X1pa+QoiNnt3+tFnssi5kL+1AcgShmdBHdBHrVoIhH4=;
	h=From:To:Subject:Date:From;
	b=u6QBHzyQH5+arFchB0dv8EcRBDZ6ZvSd0zfXcHl3lLwY3oOVHYDE8j0gBI4RlpKUq
	 SlMRPOHodKYCNG7VQuEDKnGdotu538aBYP6yz0JAcquDk8k4vYhOFOVFXtKWPb8gx1
	 epJIpqNZ7X/fLp464JNn8Qwwn1HdVa1xrzRc2S+sF2mjpr6/GYUm5moU6jYJ12eMzY
	 pYIW/+xMeBLpo0pyjx66DcNDnCDNOZgE9E/fP4ERbsm8q8i457ZwRuHT6FacCMgY3Q
	 7pYXcGzIfa7ESgbMjMSMGyLejO8eHrfs6wLog7DJtm7sj4dYTaW2lTnk9iihP+gPgb
	 F8ncKy1SUF3mw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix invalid inode pointer dereferences during log replay
Date: Tue,  3 Jun 2025 19:55:06 +0100
Message-ID: <774f04cc2a403a615ac24ecc9386fb870a88b956.1748975634.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

In a few places where we call read_one_inode(), if we get a NULL pointer
we end up jumping into an error path, or fallthrough in case of
__add_inode_ref(), where we then do something like this:

   iput(&inode->vfs_inode);

which results in an invalid inode pointer that triggers an invalid memory
access, resulting in a crash.

Fix this by making sure we don't do such dereferences.

Fixes: b4c50cbb01a1 ("btrfs: return a btrfs_inode from read_one_inode()")
CC: stable@vger.kernel.org # 6.15+
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 34ed9b2b1b83..1e0042787be7 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -673,10 +673,8 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 	}
 
 	inode = read_one_inode(root, key->objectid);
-	if (!inode) {
-		ret = -EIO;
-		goto out;
-	}
+	if (!inode)
+		return -EIO;
 
 	/*
 	 * first check to see if we already have this extent in the
@@ -961,7 +959,8 @@ static noinline int drop_one_dir_item(struct btrfs_trans_handle *trans,
 	ret = unlink_inode_for_log_replay(trans, dir, inode, &name);
 out:
 	kfree(name.name);
-	iput(&inode->vfs_inode);
+	if (inode)
+		iput(&inode->vfs_inode);
 	return ret;
 }
 
@@ -1176,8 +1175,8 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 					ret = unlink_inode_for_log_replay(trans,
 							victim_parent,
 							inode, &victim_name);
+					iput(&victim_parent->vfs_inode);
 				}
-				iput(&victim_parent->vfs_inode);
 				kfree(victim_name.name);
 				if (ret)
 					return ret;
-- 
2.47.2


