Return-Path: <linux-btrfs+bounces-15480-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01589B025D7
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 22:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 678587B5EF0
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 20:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1807B221294;
	Fri, 11 Jul 2025 20:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="spcQ+Qd7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B1D209F2E
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Jul 2025 20:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752266205; cv=none; b=nm6RjkMz41UFStYkhQL9l+wASw6ThPHn/dnOTyhTp2w8j4lA0ZuH0HE/oREcMC2NOEaoPP36wCPXJhYZ0kPTsBVGYyNR0LUqhUINXKBG2+26oOyavYaBSLBK+bRu2mwdSCUeGzRtgUGvTT2MnETiqr1QmtmkcDiGCcGVR6UCaMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752266205; c=relaxed/simple;
	bh=KC8p60BmW8CGvpYmCvqiYgDOJKyuqXy7UeoN9hnIgoA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sNL7vvBIfCNlG62vfF0iCOEBU373YrlS1a350B6UZZNBzgzv8leCmQWioPNv1eOkklyj27ndVO9GtOhjr1Ux5o0Hq1s6q7vNfbusIJeZ/vFhh/ZcgQ6DK5LSUo5kejkcHsfuNYB0GmFX2zeTvftQzsEoAsou6jS0xsghGH1ldqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=spcQ+Qd7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA470C4CEED
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Jul 2025 20:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752266205;
	bh=KC8p60BmW8CGvpYmCvqiYgDOJKyuqXy7UeoN9hnIgoA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=spcQ+Qd7OtU43Zb/dAlwiUkA5Z9fqXXWfv27fFfMZA1byGrlkzR+lok9Tx55xHtJH
	 tmPqxNdeWjX9WMVjhRb7VpYKGub6vetAt26pxxAnu+Q0f1XcRme/UjfBCudClmR9YQ
	 zY4cVbv/kEmTgLOdCWU+K3z2tJKnD4FuR7HNBv4vKUKV63Qpr4kyNKcMHGzOWD88vN
	 /ZcYtgDNPlfG/B2Zl2hxXBX4vmImhIBwRKHzCloULoZKp8uFfD6++pKImLBUnwf/rs
	 kiVwQHQeiYyTb2yb1BOJWBiA/MRS4gMuI6WfV5am0qa1kFfk5x67hV7aqy8kSAQsYo
	 MR8LGXBmV7goQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/3] btrfs: don't skip remaining extrefs if dir not found during log replay
Date: Fri, 11 Jul 2025 21:36:39 +0100
Message-ID: <14b3ff4fffa0cd48a0a28e8cf72b432f6329de23.1752266047.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1752266047.git.fdmanana@suse.com>
References: <cover.1752266047.git.fdmanana@suse.com>
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
 fs/btrfs/tree-log.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index beb47a603411..354761a8cbc1 100644
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
@@ -1492,10 +1501,11 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 		}
 		/* Else, ret == 1, we already have a perfect match, we're done. */
 
+next:
 		ref_ptr = (unsigned long)(ref_ptr + ref_struct_size) + name.len;
 		kfree(name.name);
 		name.name = NULL;
-		if (log_ref_ver) {
+		if (log_ref_ver && dir) {
 			iput(&dir->vfs_inode);
 			dir = NULL;
 		}
-- 
2.47.2


