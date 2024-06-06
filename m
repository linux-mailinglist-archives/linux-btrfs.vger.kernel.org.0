Return-Path: <linux-btrfs+bounces-5491-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 244548FE0F5
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2024 10:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2C79B2184A
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2024 08:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA0413C812;
	Thu,  6 Jun 2024 08:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hk6IPYwF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3888E573
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Jun 2024 08:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717662611; cv=none; b=nAV6p9SxtGlE9Ed17TeGwOO5r6UWAWBRnfZEehR1yptcqTT4ORfm+YKYkchow4fD/4+qsTHf7MEiEtsKNlvmQmykQseo+gvjxgM83fkVn74Cp9SX6Eg0HzhwKM632cZbDeXhSHsk5p+K05n+6vebLBlykprwM5JoHYmLtHiJ4Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717662611; c=relaxed/simple;
	bh=iJEkFiBi5d1cbgrCWFAP+34/se9eGaoQbetR2sikyFw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=eFeOxH0o9We0na7M35Y7p+fInuFBZjeEDc7Rrl4JJQTBaCW2Z4Ph0GIsgPUJV0WkIF6xnYK5rtGNQmx27JXxlsq2AeoZ1NjF87rHje9HVlfBYVjMIYGMhrFLvnN74vjL8YK4I8lO7InwxKipVjGA/1+DrdSLrC3xlCAUHmJNjJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hk6IPYwF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D547DC4AF0D
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Jun 2024 08:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717662611;
	bh=iJEkFiBi5d1cbgrCWFAP+34/se9eGaoQbetR2sikyFw=;
	h=From:To:Subject:Date:From;
	b=hk6IPYwFyQ1mdjge4EFgzUvYXL8DF0pkckUxHvmCnExUAB1OH+YGcQY7lntoQHi99
	 wS+1hNt1mfu0K8jbqfrerJYFXaHz9rvShnwLTeU3WPV1Lz+TL8Ecr8DmihLJuyTshN
	 IWnxFxbZv+nxzq3W6hxLymnD+PAy7cYnha/EKf17E5ojMoF8PIOccRAZjfqQZEbo/5
	 yqdBty5rL3D7HD8guAM2aY4JAnlGaY7nPcG31cHhgdmzbhldEDU5JxGDeiixHFDdns
	 wd5VxVWM/m2S3VtZoFuHfw3XBpUsAVMkGKS7Hr4p9EsqKhrGL3/GLH315I3+Dif8ZR
	 zFpcxT1Pz4rDw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove pointless code when creating and deleting a subvolume
Date: Thu,  6 Jun 2024 09:30:07 +0100
Message-Id: <292b2e90e9a64cd3156b0545f6e62b253ea17b9e.1717662443.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

When creating and deleting a subvolume, after starting a transaction we
are explicitly calling btrfs_record_root_in_trans() for the root which we
passed to btrfs_start_transaction(). This is pointless because at
transaction.c:start_transaction() we end up doing that call, regardless
of whether we actually start a new transaction or join an existing one,
and if we were not it would mean the root item of that root would not
be updated in the root tree when committing the transaction, leading to
problems easy to spot with fstests for example.

Remove these redundant calls. They were introduced with commit
74e97958121a ("btrfs: qgroup: fix qgroup prealloc rsv leak in subvolume
operations").

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 5 -----
 fs/btrfs/ioctl.c | 3 ---
 2 files changed, 8 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0610b9fa6fae..ddf96c4cc858 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4552,11 +4552,6 @@ int btrfs_delete_subvolume(struct btrfs_inode *dir, struct dentry *dentry)
 		ret = PTR_ERR(trans);
 		goto out_release;
 	}
-	ret = btrfs_record_root_in_trans(trans, root);
-	if (ret) {
-		btrfs_abort_transaction(trans, ret);
-		goto out_end_trans;
-	}
 	btrfs_qgroup_convert_reserved_meta(root, qgroup_reserved);
 	qgroup_reserved = 0;
 	trans->block_rsv = &block_rsv;
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 5e3cb0210869..d00d49338ecb 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -658,9 +658,6 @@ static noinline int create_subvol(struct mnt_idmap *idmap,
 		ret = PTR_ERR(trans);
 		goto out_release_rsv;
 	}
-	ret = btrfs_record_root_in_trans(trans, BTRFS_I(dir)->root);
-	if (ret)
-		goto out;
 	btrfs_qgroup_convert_reserved_meta(root, qgroup_reserved);
 	qgroup_reserved = 0;
 	trans->block_rsv = &block_rsv;
-- 
2.43.0


