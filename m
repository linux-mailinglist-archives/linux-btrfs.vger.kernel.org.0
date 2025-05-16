Return-Path: <linux-btrfs+bounces-14093-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C96ABA310
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 20:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E294C4A7C5E
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 18:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC4627F756;
	Fri, 16 May 2025 18:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2Doq0Du"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A141F27F731
	for <linux-btrfs@vger.kernel.org>; Fri, 16 May 2025 18:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747420874; cv=none; b=el2WeV6wM1CAec0ET3AJg8doJAWAGGwe2/oQxrp3m/f9NPN+ro8oFRa3tD2cbhEFsmWugnPcSVsXm+m6oM2wUJ6kZSns+WyGMspnv59cBmh41xH200EfjjBldCi27Z2X9ZIAQd+8xu4vDzB7+k6xFo38ZS0O9/xmOwdkluI5RCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747420874; c=relaxed/simple;
	bh=DlwIZk3+0T8WvUPJPMWApppXsGzWNhH6oR08e5L5194=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=aPfPF3kbUxOfOnBXKo0NuzvxaOTnt3v6tmgs1pMlw1xNv3i+jjjDAT9mc5asQEUwXbH44+RjMFv+XAFIy2cjo6iRCp0itQAw71y0MdN7X/ZxSWMb7RmlLdl+Y26jIhOoEfe6KgttSWv/VSuqfVv8EcR/slccCb8Ogy+8869pUS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2Doq0Du; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FFF3C4CEED
	for <linux-btrfs@vger.kernel.org>; Fri, 16 May 2025 18:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747420874;
	bh=DlwIZk3+0T8WvUPJPMWApppXsGzWNhH6oR08e5L5194=;
	h=From:To:Subject:Date:From;
	b=M2Doq0DubhMn+1WH9lWvLi3LURQ3QHRDHcvSr0MbHDWLKrbhfKsQjBZZXvopkQtYw
	 0FGOT7G+pksOGypnucL7epXvijXE69b/AP3cpcJ6Fk27SylYnXUrifYr1pGS8iNrBh
	 JM72l/HBZveOOb6+3I4InU0v+QdDOYh/cEqcr9QBH1OEJGBn8rO7VObacTGV4Fl9SP
	 bc59sGiZBJi3wo+KoCDmF7J2SUPI40dBuyt67rekN8l83kVlwQs3uqEn3w4yOKV20Z
	 Bd9Pv8HgjLuR8M83VVmzaB/To2zpgqfsAom6Cm0Xxp0pH3aAkO4KrdCcnXWnAK1Pk4
	 DtoCDT7FDkBHw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: unfold transaction abort at clone_copy_inline_extent()
Date: Fri, 16 May 2025 19:41:10 +0100
Message-Id: <390968e8253cb5624145c3e2e84b784fe25cf522.1747420784.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We have a common error path where we abort the transaction, but like this
in case we get a transaction abort stack trace we don't know exactly which
previous function call failed. Instead abort the transaction after any
function call that returns an error, so that we can easily indentify which
function failed.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/reflink.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 5eacd3584a8d..0197bd9160a7 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -268,11 +268,15 @@ static int clone_copy_inline_extent(struct btrfs_inode *inode,
 	drop_args.end = aligned_end;
 	drop_args.drop_cache = true;
 	ret = btrfs_drop_extents(trans, root, inode, &drop_args);
-	if (ret)
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
 		goto out;
+	}
 	ret = btrfs_insert_empty_item(trans, root, path, new_key, size);
-	if (ret)
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
 		goto out;
+	}
 
 	write_extent_buffer(path->nodes[0], inline_data,
 			    btrfs_item_ptr_offset(path->nodes[0],
@@ -281,6 +285,8 @@ static int clone_copy_inline_extent(struct btrfs_inode *inode,
 	btrfs_update_inode_bytes(inode, datal, drop_args.bytes_found);
 	btrfs_set_inode_full_sync(inode);
 	ret = btrfs_inode_set_file_extent_range(inode, 0, aligned_end);
+	if (ret)
+		btrfs_abort_transaction(trans, ret);
 out:
 	if (!ret && !trans) {
 		/*
@@ -295,10 +301,8 @@ static int clone_copy_inline_extent(struct btrfs_inode *inode,
 			trans = NULL;
 		}
 	}
-	if (ret && trans) {
-		btrfs_abort_transaction(trans, ret);
+	if (ret && trans)
 		btrfs_end_transaction(trans);
-	}
 	if (!ret)
 		*trans_out = trans;
 
-- 
2.47.2


