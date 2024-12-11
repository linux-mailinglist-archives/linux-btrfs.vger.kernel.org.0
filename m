Return-Path: <linux-btrfs+bounces-10269-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8690A9ED915
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 22:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14E331646BD
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 21:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFE91DDC29;
	Wed, 11 Dec 2024 21:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJotTN7e"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EDF1A2872
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 21:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733953988; cv=none; b=BiQv9vvs729r2t1iUUJtz0iiXyyMyVlJxBGOoDeLbEmuVlbUviejHAZvPx5QZy/rjJzHYnDFrfYFvyGuKHkbeemBy2vOq4q0SL64Tlrrr21+iOrVqqN3S9FWcmBuDLPT9i6S2acyspYn9H4BDfd+VdKTl8Ic3RMY2w9U4KUKixw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733953988; c=relaxed/simple;
	bh=1YfkVSMgZDAd93B3SAWgYEcerhVtmYjEJRWfQ73V640=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HnUqBk2cIpXSzpd3WgiRj+CpeyqKSp7+NxjPaeTlJv3dvHPVn0/F6YwcjIHK5wI9w7GzhRM4EZfaAMekBvdEoJCF9JwF5QXLwD5by7wkFFwrYBLB0QTG4PpwlmrKL0GyniZQh/741c0l4b1DoHMwKs55b6JuAjtjRHsnvq3U8dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJotTN7e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA38AC4CED2
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 21:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733953987;
	bh=1YfkVSMgZDAd93B3SAWgYEcerhVtmYjEJRWfQ73V640=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=AJotTN7ehIvEb/iTAMS7crKzlQZUnRNfvYXp2Je6/5Q4LqP7F6xM3xV/55jxCFKAL
	 GCX12A1tCn/+S4o3Tt9W/g+khNObdX0sevZ84ipeqji4FsLFt5WTqma/ASiT0j4Qbx
	 pJmZqw1/FvxruyV0VCeIbbsAhw/FQPcXGFbpApvSTRzmt35x0ZsaqwMwYUvcjeGqbg
	 8a0kl/DWlkYU1wZAPz1FybAB9UAFIFUmur87+flRwvwpUqPOnvcS9s97fBWOtciKMR
	 nzFDCcMfDxWUeJUyJ4vVkAbrdOBMnwqPEBZ43bCL7nK0hQo4xelZWJD8jSIrio0a6n
	 Iec8xFelvHOVg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: fix use-after-free when COWing tree bock and tracing is enabled
Date: Wed, 11 Dec 2024 21:53:03 +0000
Message-Id: <1b96eb7eb9ce220acc21b2ac2057a5a3eab1fb3b.1733953828.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <8e502fc69ea68d1647707d947e0e4625f0dd1af0.1733934886.git.fdmanana@suse.com>
References: <8e502fc69ea68d1647707d947e0e4625f0dd1af0.1733934886.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

When a COWing a tree block, at btrfs_cow_block(), and we have the
tracepoint trace_btrfs_cow_block() enabled and preemption is also enabled
(CONFIG_PREEMPT=y), we can trigger a use-after-free in the COWed extent
buffer while inside the tracepoint code. This is because in some paths
that call btrfs_cow_block(), such as btrfs_search_slot(), we are holding
the last reference on the extent buffer @buf so btrfs_force_cow_block()
drops the last reference on the @buf extent buffer when it calls
free_extent_buffer_stale(buf), which schedules the release of the extent
buffer with RCU. This means that if we are on a kernel with preemption,
the current task may be preempted before calling trace_btrfs_cow_block()
and the extent buffer already released by the time trace_btrfs_cow_block()
is called, resulting in a use-after-free.

Fix this by moving the trace_btrfs_cow_block() from btrfs_cow_block() to
btrfs_force_cow_block() before the COWed extent buffer is freed.
This also has a side effect of invoking the tracepoint in the tree defrag
code, at defrag.c:btrfs_realloc_node(), since btrfs_force_cow_block() is
called there, but this is fine and it was actually missing there.

Reported-by: syzbot+8517da8635307182c8a5@syzkaller.appspotmail.com
Link: https://lore.kernel.org/linux-btrfs/6759a9b9.050a0220.1ac542.000d.GAE@google.com/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

V2: Instead of temporarily bumping the extent buffer's reference count
    to safely call the tracepoint, move the tracepoint call to
    btrfs_force_cow_block().

 fs/btrfs/ctree.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 693dc27ffb89..185985a337b3 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -654,6 +654,8 @@ int btrfs_force_cow_block(struct btrfs_trans_handle *trans,
 			goto error_unlock_cow;
 		}
 	}
+
+	trace_btrfs_cow_block(root, buf, cow);
 	if (unlock_orig)
 		btrfs_tree_unlock(buf);
 	free_extent_buffer_stale(buf);
@@ -710,7 +712,6 @@ int btrfs_cow_block(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	u64 search_start;
-	int ret;
 
 	if (unlikely(test_bit(BTRFS_ROOT_DELETING, &root->state))) {
 		btrfs_abort_transaction(trans, -EUCLEAN);
@@ -751,12 +752,8 @@ int btrfs_cow_block(struct btrfs_trans_handle *trans,
 	 * Also We don't care about the error, as it's handled internally.
 	 */
 	btrfs_qgroup_trace_subtree_after_cow(trans, root, buf);
-	ret = btrfs_force_cow_block(trans, root, buf, parent, parent_slot,
-				    cow_ret, search_start, 0, nest);
-
-	trace_btrfs_cow_block(root, buf, *cow_ret);
-
-	return ret;
+	return btrfs_force_cow_block(trans, root, buf, parent, parent_slot,
+				     cow_ret, search_start, 0, nest);
 }
 ALLOW_ERROR_INJECTION(btrfs_cow_block, ERRNO);
 
-- 
2.45.2


