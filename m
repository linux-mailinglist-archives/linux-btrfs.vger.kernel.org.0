Return-Path: <linux-btrfs+bounces-2070-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EAE84702C
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 13:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A65BA1F2B17A
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 12:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAE613F01A;
	Fri,  2 Feb 2024 12:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pS0mRmks"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B127E9
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Feb 2024 12:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706876578; cv=none; b=BLV3RqqJCDmpIOeZZi2ViRdbZHkdERSAtRQdCFOTduqdtJ3BqPZ28LT5f/1T8vor2vojjroypKLdtwPY7rBPygp0h/SU230eXeOyvM5RaHAQg68GR1Nlck4648lwxJ25iwHrJ++pVBl7anWddLV+WncNg20G9qQED+bnx90zGDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706876578; c=relaxed/simple;
	bh=czMjn/deRz0GzhjNx3E8iEiY4eGS+lZIEtQ1qJW3gP4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=rmLd7puW9di6giy+soqkE0BsvXs7oJntEXcqLV/J1+InWu8BoRdcxNk/R1h1v8TmCCxRw0FcRVLRG1uzslnIPJ2zphaaNfJfAcx34bZJPFqEtdKUiOEicMWQOW5cUurcmfp7RBILyqlUPszxFf7QbZa3qlY9Et9RYEaOX/r7Zno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pS0mRmks; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20119C433C7
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Feb 2024 12:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706876577;
	bh=czMjn/deRz0GzhjNx3E8iEiY4eGS+lZIEtQ1qJW3gP4=;
	h=From:To:Subject:Date:From;
	b=pS0mRmkstyF86VYtwKTpjePUkW/ktG3uxdWIhTxN+82fJw4neNva+XLRUqM1lrehN
	 aWXI3bUS0FyUjjNsTXZkW146JBmWTk8PLyFpMItTIFhtj2V8DLQrNdV2IJ8bWLVam5
	 +Prrhck3oKzQjUPDpzy0ROR4ZSRdioW0WYf+tAFmSrHzQL1bDLXwEm7d/4lxW03fWd
	 7rHmgKKgCV4fcS47ZiyEioIJPFZpkgcHBNMhs3Z8HgaYtF+eTEla7oUYedqQLTaOSY
	 IRpABL7JNiIZRIoXfO89xMI1bHFDg/JrbfjoQbjlNZTndWN6N4oQCxWpE7LkP/y6PG
	 2/jJuQhhW85rw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: reject encoded write if inode has nodatasum flag set
Date: Fri,  2 Feb 2024 12:22:53 +0000
Message-Id: <5e9fccf6a2c57b6bbd28427ca864fe838b43d394.1706876439.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Currently we allow an encoded write against inodes that have the NODATASUM
flag set, either because they are NOCOW files or they were created while
the filesystem was mounted with "-o nodatasum". This results in having
compressed extents without corresponding checksums, which is a filesystem
inconsistency reported by 'btrfs check'.

For example, running btrfs/281 with MOUNT_OPTIONS="-o nodatacow" triggers
this and 'btrfs check' errors out with:

   [1/7] checking root items
   [2/7] checking extents
   [3/7] checking free space tree
   [4/7] checking fs roots
   root 256 inode 257 errors 1040, bad file extent, some csum missing
   root 256 inode 258 errors 1040, bad file extent, some csum missing
   ERROR: errors found in fs roots
   (...)

So reject encoded writes if the target inode has NODATASUM set.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 50aea888d977..2329bff33d4b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -10289,6 +10289,13 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	if (encoded->encryption != BTRFS_ENCODED_IO_ENCRYPTION_NONE)
 		return -EINVAL;
 
+	/*
+	 * Compressed extents should always have checksums, so error out if we
+	 * have a NOCOW file or inode was created while mounted with NODATASUM.
+	 */
+	if (inode->flags & BTRFS_INODE_NODATASUM)
+		return -EINVAL;
+
 	orig_count = iov_iter_count(from);
 
 	/* The extent size must be sane. */
-- 
2.40.1


