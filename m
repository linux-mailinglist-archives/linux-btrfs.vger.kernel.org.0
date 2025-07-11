Return-Path: <linux-btrfs+bounces-15476-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D58B025C3
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 22:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1C245A566D
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 20:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFFB2153CB;
	Fri, 11 Jul 2025 20:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NzGeKiGO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD121F3B83
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Jul 2025 20:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752265580; cv=none; b=uwswrRFfUGbZLGifIGt5I2czdLqt03ufcgmvgTKO+arOcbs7w+10KwPc4H69OBJjAhy+TDYyLZqvbrsJMuJLaL9XtvNHBr7uPSC7lHhT0UuLOKIBLjiXMjNeCpwQkPZup3MfgA7qlIeCaQs0fhSgV06Rs3HJSGj8cLgcTFFWVaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752265580; c=relaxed/simple;
	bh=4f21KttwBZ0GQ+I/8YgrEgAGISn3XzLAKJbRHc5Ok9c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YFj1UI4tazJb6o0AUU2q6eVc0+s80DUpmWVwUNtJBBKbsCbU3SM97woyKfenUMqz7Nl6A476qZB8n+eYOvmoJzvgUQPgP7zPqpfU1TK7Wio4SN3OKFDvAOWQvxKp0HRTjiZFhMbsi9A0emvp9jF5zsS7SbqdO7Ih6dk51TuqPIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NzGeKiGO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 635A9C4CEED
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Jul 2025 20:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752265578;
	bh=4f21KttwBZ0GQ+I/8YgrEgAGISn3XzLAKJbRHc5Ok9c=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NzGeKiGOc+SP0firWQEUCeFWytW2h1o2TPC6cgRxyUR2Fc/mkme/XgKOaxJbdk8m7
	 38LMKXJEOvyTmKLo+wy4R1xGQQspGea247UTrVaq7vd33aZ3jE9bSZnlOLkvqX1Skm
	 dWpJSoFaOdwkqLpeTyOwCzDv+Bs4H04b7uP9nzTnsH/xdtTuvoigIvE2byaI/zNBmk
	 C84dWYl91jDh/2CU4wBREZIg+Wyl9K4NlZ7XIyUTb4zfKhfP0ivIusaf+ZkR73BIIX
	 s6CSUqfKKxSXFA8E03hb98GIrU0EcU7G56mxW0Qn7qBZpw6wTTc3wJD8DKq8lju/T5
	 YeEoClOMxgCMA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: don't skip remaining extrefs if dir not found during log replay
Date: Fri, 11 Jul 2025 21:26:11 +0100
Message-ID: <4dcb25a91257344bb6f6dfe8adf670d4169f79ba.1752265165.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1752265165.git.fdmanana@suse.com>
References: <cover.1752265165.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

During log replay, at add_inode_ref(), if we have an extref item that
contains multiple extrefs and one of them points to a directory that does
not exist in the subvolume tree, we are supposed to ignore it and process
the remaining extrefs encoded in the extref item, since each extref can
point to a different parent inode. However when that happens we just
return from the function and ignore the remaining extrefs.

The problem has been around since extrefs were introduced, in commit
f186373fef00 ("btrfs: extended inode refs"), but it's hard to hit in
practice because getting extref items encoding multiple extref requires
getting a hash collision when computing the offset of the extref's
key. The offset if computed like this:

  key.offset = btrfs_extref_hash(dir_ino, name->name, name->len);

and btrfs_extref_hash() is just a wrapper around crc32c().

Fix this by moving to next iteration of the loop when we don't find
the parent directory that an extref points to.

Fixes: f186373fef00 ("btrfs: extended inode refs")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index beb47a603411..bbd1fca19022 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -1433,6 +1433,8 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 		if (log_ref_ver) {
 			ret = extref_get_fields(eb, ref_ptr, &name,
 						&ref_index, &parent_objectid);
+			if (ret)
+				goto out;
 			/*
 			 * parent object can change from one array
 			 * item to another.
@@ -1449,16 +1451,23 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 					 * the loop when getting the first
 					 * parent dir.
 					 */
-					if (ret == -ENOENT)
+					if (ret == -ENOENT) {
+						/*
+						 * The next extref may refer to
+						 * another parent dir that
+						 * exists, so continue.
+						 */
 						ret = 0;
+						goto next;
+					}
 					goto out;
 				}
 			}
 		} else {
 			ret = ref_get_fields(eb, ref_ptr, &name, &ref_index);
+			if (ret)
+				goto out;
 		}
-		if (ret)
-			goto out;
 
 		ret = inode_in_dir(root, path, btrfs_ino(dir), btrfs_ino(inode),
 				   ref_index, &name);
@@ -1492,6 +1501,7 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 		}
 		/* Else, ret == 1, we already have a perfect match, we're done. */
 
+next:
 		ref_ptr = (unsigned long)(ref_ptr + ref_struct_size) + name.len;
 		kfree(name.name);
 		name.name = NULL;
-- 
2.47.2


