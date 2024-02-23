Return-Path: <linux-btrfs+bounces-2660-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AF7860BC3
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 09:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29BFFB24029
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 08:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2491171C7;
	Fri, 23 Feb 2024 08:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkOt97D1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E9617C9B
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Feb 2024 08:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708675722; cv=none; b=ZqwWzQUbJvoyw8aMsWVhz1dWN0teZECI47V+D9HASQMNH+ftBs/WZtzhUrtLJ3vuHWl8SnwlUKTFnmW19w3l1my9Ht+CQbhfz0w2JlEgMO09VgJ9u0FcjODljFPMz/S8pFP8BytaJo6l4VdMBso0N1VVtymrmO/pkY6Q0V+OFzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708675722; c=relaxed/simple;
	bh=G5HewuADVVss7qlXbFsHg0qHlnOODflvK78XyybrJiw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GTXzSPw3OUWNI1KpL/KcyH5h79oILcKa0fY5tvk36snWnLqcIvzJUjqYwQXsGejsawMLV/RgjQBthD/X/xD6KvDLGLihvNvh7AjwX0YA9o/ETxCNUXLZgiCZuUQBamTzedM/IoLNfZKY7myNlH1z4BvBog3I8z9KY+hCXnAs6jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkOt97D1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2BCDC43390
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Feb 2024 08:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708675721;
	bh=G5HewuADVVss7qlXbFsHg0qHlnOODflvK78XyybrJiw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=nkOt97D1Du5eKS29OjexKdo+QZymHn3+0dCmf0DxhJwvf9GxUOOC5C2c76K8YryWn
	 jrT3Kl9w2wKmml+mO92/+0r/Jy9VuQMyjXjPVvAYccOxTv/CMhd0EXrCboO9k3W7I7
	 ZUBZrZdf0A1OaaDrg5HuI4PLY1lrlO0nq50VHDsxQN7MR2LznPRd4JTd1fqsJXbEOe
	 lNIdzgS410ohp7HTF1TRryboA9PyFz/J+XrbDvW/ms8UZCsRvqKpDbp+v64z4Xoo0/
	 2Vaxgr3heAnuqvb4oE27WLyuaQva8+4a8wItm2HfX2OBxAwX8AGWLdlSLg7POzLFKX
	 Wt5Il6gu+VUfQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: fix race between ordered extent completion and fiemap
Date: Fri, 23 Feb 2024 08:08:31 +0000
Message-Id: <59ba5bade2a139255f6f6b25fe30280af4bbc82a.1708635463.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1708635463.git.fdmanana@suse.com>
References: <cover.1708635463.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

For fiemap we recently stopped locking the target extent range for the
whole duration of the fiemap call, in order to avoid a deadlock in a
scenario where the fiemap buffer happens to be a memory mapped range of
the same file. This use case is very unlikely to be useful in practice but
it may be triggered by fuzz testing (syzbot, etc).

However by not locking the target extent range for the whole duration of
the fiemap call we can race with an ordered extent. This happens like
this:

1) The fiemap task finishes processing a file extent item that covers
   the file range [512K, 1M[, and that file extent item is the last item
   in the leaf currently being processed;

2) And ordered extent for the file range [768K, 2M[, in COW mode,
   completes (btrfs_finish_one_ordered()) and the file extent item
   covering the range [512K, 1M[ is trimmed to cover the range
   [512K, 768K[ and then a new file extent item for the range [768K, 2M[
   is inserted in the inode's subvolume tree;

3) The fiemap task calls fiemap_next_leaf_item(), which then calls
   btrfs_next_leaf() to find the next leaf / item. This finds that the
   the next key following the one we previously processed (its type is
   BTRFS_EXTENT_DATA_KEY and its offset is 512K), is the key corresponding
   to the new file extent item inserted by the ordered extent, which has
   a type of BTRFS_EXTENT_DATA_KEY and an offset of 768K;

4) Later the fiemap code ends up at emit_fiemap_extent() and triggers
   the warning:

      if (cache->offset + cache->len > offset) {
               WARN_ON(1);
               return -EINVAL;
      }

   Since we get 1M > 768K, because the previously emitted entry for the
   old extent covering the file range [512K, 1M[ ends at an offset that
   is greater than the new extent's start offset (768K). This make fiemap
   fail with -EINVAL besides triggering the warning that produces a stack
   trace like the following:

     [ 1621.677651] ------------[ cut here ]------------
     [ 1621.677656] WARNING: CPU: 1 PID: 204366 at fs/btrfs/extent_io.c:2492 emit_fiemap_extent+0x84/0x90 [btrfs]
     [ 1621.677899] Modules linked in: btrfs blake2b_generic (...)
     [ 1621.677951] CPU: 1 PID: 204366 Comm: pool Not tainted 6.8.0-rc5-btrfs-next-151+ #1
     [ 1621.677954] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
     [ 1621.677956] RIP: 0010:emit_fiemap_extent+0x84/0x90 [btrfs]
     [ 1621.678033] Code: 2b 4c 89 63 (...)
     [ 1621.678035] RSP: 0018:ffffab16089ffd20 EFLAGS: 00010206
     [ 1621.678037] RAX: 00000000004fa000 RBX: ffffab16089ffe08 RCX: 0000000000009000
     [ 1621.678039] RDX: 00000000004f9000 RSI: 00000000004f1000 RDI: ffffab16089ffe90
     [ 1621.678040] RBP: 00000000004f9000 R08: 0000000000001000 R09: 0000000000000000
     [ 1621.678041] R10: 0000000000000000 R11: 0000000000001000 R12: 0000000041d78000
     [ 1621.678043] R13: 0000000000001000 R14: 0000000000000000 R15: ffff9434f0b17850
     [ 1621.678044] FS:  00007fa6e20006c0(0000) GS:ffff943bdfa40000(0000) knlGS:0000000000000000
     [ 1621.678046] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
     [ 1621.678048] CR2: 00007fa6b0801000 CR3: 000000012d404002 CR4: 0000000000370ef0
     [ 1621.678053] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
     [ 1621.678055] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
     [ 1621.678056] Call Trace:
     [ 1621.678074]  <TASK>
     [ 1621.678076]  ? __warn+0x80/0x130
     [ 1621.678082]  ? emit_fiemap_extent+0x84/0x90 [btrfs]
     [ 1621.678159]  ? report_bug+0x1f4/0x200
     [ 1621.678164]  ? handle_bug+0x42/0x70
     [ 1621.678167]  ? exc_invalid_op+0x14/0x70
     [ 1621.678170]  ? asm_exc_invalid_op+0x16/0x20
     [ 1621.678178]  ? emit_fiemap_extent+0x84/0x90 [btrfs]
     [ 1621.678253]  extent_fiemap+0x766/0xa30 [btrfs]
     [ 1621.678339]  btrfs_fiemap+0x45/0x80 [btrfs]
     [ 1621.678420]  do_vfs_ioctl+0x1e4/0x870
     [ 1621.678431]  __x64_sys_ioctl+0x6a/0xc0
     [ 1621.678434]  do_syscall_64+0x52/0x120
     [ 1621.678445]  entry_SYSCALL_64_after_hwframe+0x6e/0x76

So to fix this by changing emit_fiemap_extent() to adjust the length of
the previously cached extent so that it does not overlap with the current
extent, and emit the previous one. This makes everything consistent by
reflecting the current state of file extent items in the btree and
without emitting extents that have overlapping ranges.

Fixes: b0ad381fa769 ("btrfs: fix deadlock with fiemap and extent locking")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_io.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index e2dbadfc082f..eab23cb2bb93 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2482,15 +2482,31 @@ static int emit_fiemap_extent(struct fiemap_extent_info *fieinfo,
 		goto assign;
 
 	/*
-	 * Sanity check, extent_fiemap() should have ensured that new
-	 * fiemap extent won't overlap with cached one.
-	 * Not recoverable.
+	 * When iterating the extents of the inode, at extent_fiemap(), we may
+	 * find an extent that starts at an offset behind the end offset of the
+	 * previous extent we processed. This happens if fiemap is called
+	 * without FIEMAP_FLAG_SYNC and there are ordered extents completing
+	 * while we call btrfs_next_leaf() (through fiemap_next_leaf_item()).
 	 *
-	 * NOTE: Physical address can overlap, due to compression
+	 * For example we are in leaf X processing its last item, which is the
+	 * file extent item for file range [512K, 1M[, and after
+	 * btrfs_next_leaf() releases the path, there's an ordered extent that
+	 * completes for the file range [768K, 2M[, and that results in trimming
+	 * the file extent item so that it now corresponds to the file range
+	 * [512K, 768K[ and a new file extent item is inserted for the file
+	 * range [768K, 2M[, which may end up as the last item of leaf X or as
+	 * the first item of the next leaf - in either case btrfs_next_leaf()
+	 * will leave us with a path pointing to the new extent item, for the
+	 * file range [768K, 2M[, since that's the first key that follows the
+	 * last one we processed. So in order not to report overlapping extents
+	 * to user space, we trim the length of the previously cached extent and
+	 * emit it.
 	 */
 	if (cache->offset + cache->len > offset) {
-		WARN_ON(1);
-		return -EINVAL;
+		if (WARN_ON(offset <= cache->offset))
+			return -EINVAL;
+		cache->len = offset - cache->offset;
+		goto emit;
 	}
 
 	/*
@@ -2510,6 +2526,7 @@ static int emit_fiemap_extent(struct fiemap_extent_info *fieinfo,
 		return 0;
 	}
 
+emit:
 	/* Not mergeable, need to submit cached one */
 	ret = fiemap_fill_next_extent(fieinfo, cache->offset, cache->phys,
 				      cache->len, cache->flags);
-- 
2.40.1


