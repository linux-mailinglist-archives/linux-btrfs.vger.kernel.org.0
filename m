Return-Path: <linux-btrfs+bounces-2670-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B13F5861563
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 16:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2ACE1C23C9F
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 15:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A6C823C1;
	Fri, 23 Feb 2024 15:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="urINt8zj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFF8823AA
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Feb 2024 15:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708701597; cv=none; b=BGtr/LFJA3GCcxfkun5cv3TgfIJ0TvWQwRejLRsl+Uinfqt3PjISlmYg3B+Wy2xw10nndo9IzIHaVmgBVO7l776sYO2O7Kd7NccZ7rykFzvoUvWHY/09fAfQI0wRTzAly4om0zMMHXskXz6F3RLMEJN/s5TqwzDm659mLhIkYYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708701597; c=relaxed/simple;
	bh=c0+3Gq++WCmsCj1KzUqZ39habb9lLjwvg1++gk3kI9I=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r65ICKkAkJMgF6TGaiCmwn/gkC80z8ev1S4CdkCPSiWqILb7nVeAv1LV1I0c+RhKF56HfnMNO4ZYjCV8OLdmIsYpJJr5AGocWUMnkhZfCxnBfDIwrP6ctDkcm+gNNqaN6XoXpU4MbxbLWPYVZuXfNpFlLH85ua0eAG75DZB5M7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=urINt8zj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D58C433C7
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Feb 2024 15:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708701596;
	bh=c0+3Gq++WCmsCj1KzUqZ39habb9lLjwvg1++gk3kI9I=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=urINt8zjtN9Q7q+Fgh10FRKtob2vDBKchwKZLh/igv3S8RhGBzSkLXiDqOft9avSM
	 /cFrOcogNQwg+8yCaOV7owdR7vl60w4uDoXil4VtzODACvNpsVtoMMFluPxEJ9Pix7
	 HG8sFO3GBhHuVkoEI6q7riO+0KPCaEw873Hm3b68YQWZFoLzeW2Cuy4MjVlwIXnLsR
	 Ufreh+yj2zAVlbvMJh52XYF6Hj4CawrI6U9vrH3Zt54UFa05vMoLaGMOrAi8hKkjux
	 Y4mNrNvot9PQsZb4jLfBC94RBkePB37nGGPGAmFrLZuOSCMXBlc8TlRwX+5Hk5WBaK
	 W88ljcCcxiOWg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/2] btrfs: fix race between ordered extent completion and fiemap
Date: Fri, 23 Feb 2024 15:19:48 +0000
Message-Id: <7d5ec94b36124c23184574c120a9eb8e2b76af12.1708701186.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1708701186.git.fdmanana@suse.com>
References: <cover.1708701186.git.fdmanana@suse.com>
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

There's also another case where we before calling btrfs_next_leaf() we
processing a hole or a prealloc extent and we had several delalloc ranges
within that hole or prealloc extent. In that case if the ordered extents
complete before we find the next key, we may end up finding an extent item
with an offset than is smaller than offset we have in cache->offset.

So fix this by changing emit_fiemap_extent() to address these two
scenarios like this:

1) For the first case, steps listed above, adjust the length of the
   previously cached extent so that it does not overlap with the current
   extent, and emit the previous one. This makes everything consistent by
   reflecting the current state of file extent items in the btree and
   without emitting extents that have overlapping ranges;

2) For the second case where he had a hole or prealloc extent with
   multiple delalloc ranges inside the hole or prealloc extent's range,
   just discard what we have in the fiemap cache and assign the current
   file extent item to the cache. This also makes everything consistent
   by reflecting the current state of file extent items in the btree and
   without emitting extents that have overlapping ranges.

This issue could be triggered often with test case generic/561, and was
also hit and reported by Wang Yugui.

Reported-by: Wang Yugui <wangyugui@e16-tech.com>
Link: https://lore.kernel.org/linux-btrfs/20240223104619.701F.409509F4@e16-tech.com/
Fixes: b0ad381fa769 ("btrfs: fix deadlock with fiemap and extent locking")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_io.c | 39 +++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 43496a07ee42..4ae2076756f6 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2487,13 +2487,43 @@ static int emit_fiemap_extent(struct fiemap_extent_info *fieinfo,
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
+	 *
+	 * Upon calling btrfs_next_leaf() we may also find an extent with an
+	 * offset smaller than cache->offset, and this happens when we had a
+	 * hole or prealloc extent with several delalloc subranges, but after
+	 * btrfs_next_leaf() released the path, delalloc completed as well as
+	 * the ordered extents and we're now with a smaller offset. In this
+	 * case just discard what we have in the cache and start from this
+	 * current extent.
 	 */
 	if (cache->offset + cache->len > offset) {
+		if (offset < cache->offset) {
+			goto assign;
+		} else if (offset > cache->offset) {
+			cache->len = offset - cache->offset;
+			goto emit;
+		}
+
+		/* cache->offset == offset, should never happen. */
 		WARN_ON(1);
 		return -EINVAL;
 	}
@@ -2515,6 +2545,7 @@ static int emit_fiemap_extent(struct fiemap_extent_info *fieinfo,
 		return 0;
 	}
 
+emit:
 	/* Not mergeable, need to submit cached one */
 	ret = fiemap_fill_next_extent(fieinfo, cache->offset, cache->phys,
 				      cache->len, cache->flags);
-- 
2.40.1


