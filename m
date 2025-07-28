Return-Path: <linux-btrfs+bounces-15710-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE46FB137A7
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jul 2025 11:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37DE43BB158
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jul 2025 09:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61B3253954;
	Mon, 28 Jul 2025 09:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAnVdeoT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F007C253356
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Jul 2025 09:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753695594; cv=none; b=Zy9Tr6Uqt5QEhCXC2jW67WpuIv3B4PohDOO+1jbI/L5TSLoyGuyKTtJN/etPCEq5+lMBDvzK83IiiqWjx+1Rz06+0vFM4v+WzdZFLktuiHWQiOJ7DfPM8HGwbyn421HZnUCwsIC3lrth5U4GvMVAo5/87/Q/S7VVWi3hI4lrmzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753695594; c=relaxed/simple;
	bh=+ywlkw8VzWRgF4B3AdmGSTYSUazZjpCr3D7E6ye/BEk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l3dRerf7VJhYlr9rNarxLhbCi9/W8x7MwQSUvRyXqtsHbHeFuFoDKR4y85f//vJyyxTwDMJJOjOSRVGLU0SxB8uKOmVXODoYcFVt6VpWMLjIZptgJOWQokzDN3Tn+SnKHgpC6Cttqc2c0OR/W7A9OMCq1zYrGBauo6sxiOcIZlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YAnVdeoT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B698C4CEF4
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Jul 2025 09:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753695593;
	bh=+ywlkw8VzWRgF4B3AdmGSTYSUazZjpCr3D7E6ye/BEk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=YAnVdeoTHtGL8Bc3ykp3b7bjPIRHGpAY7e2BN70xrFRVnDqACjRxBjFlh1KUThMoh
	 uzL/fthXlmdXRm6bLhWPFm1kUVUSayx4Pg3M1MhDcS79MoJBKTcJuBZSVLazrhVc+V
	 AX73E8zqNu0+wA80/WXZuCGBdh1omguJX0wH5k+1Y+RGt2HqEBO4jgK1Tz22oBnndM
	 PiolkgXLERMU1xKLVFWsNDgigdAKMQOvN5Y9neBr6OggxxXKnT+TQKWBvol1G2n0h0
	 nhggXTZtYfptCXJ4xK1m0dVjGyPeOfo8de7qCFFMniB/705RiLT4IOWIEpJ9XUhAFU
	 NoPVJjbppjFuA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: fix inode leak on failure to add link to inode
Date: Mon, 28 Jul 2025 10:39:47 +0100
Message-ID: <7fb0dc01b44be5d7d505e0361daf0732009e8f57.1753469763.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1753469762.git.fdmanana@suse.com>
References: <cover.1753469762.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

If we fail to update the inode or delete the orphan item we leak the inode
since we update its refcount with the ihold() call to account for the
d_instantiate() call which never happens in case we fail those steps. Fix
this by setting 'drop_inode' to true in case we fail those steps.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f2b43b1e90de..46675783578e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6847,6 +6847,7 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
 		ret = btrfs_update_inode(trans, BTRFS_I(inode));
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
+			drop_inode = 1;
 			goto fail;
 		}
 		if (inode->i_nlink == 1) {
@@ -6857,6 +6858,7 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
 			ret = btrfs_orphan_del(trans, BTRFS_I(inode));
 			if (ret) {
 				btrfs_abort_transaction(trans, ret);
+				drop_inode = 1;
 				goto fail;
 			}
 		}
-- 
2.47.2


