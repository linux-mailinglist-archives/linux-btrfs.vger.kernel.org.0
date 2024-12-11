Return-Path: <linux-btrfs+bounces-10254-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 785F69ED24D
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 17:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6056416690A
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 16:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A191DDA3C;
	Wed, 11 Dec 2024 16:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/EDEYfv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C33748A
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 16:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733935302; cv=none; b=YxeM22sEAy+ifSmaf8YHmfSITAbDQacbtnSI4K4wSQoXHPZ24/RvHLTm4CzxseHGSIt9m7dArR6wipLPTSs8bcSqSbf23Xq9oZc2DeNLFRa4zRzFpx4JWum8kJPqvBxlLyVQXfZ/M0Z/QtQEbYpM12nKZkZBVHDjbhJDcuTKEj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733935302; c=relaxed/simple;
	bh=aldS5hYOgrLEq6CR3iKALSaxFpoZx82F7YOhg/rZn8I=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Gr4pLVa7WlW4EMiOZk2JtNwQsoh6eMbhDdoYQFt1+I5duDvhSeqYMvK3yqy980EAzb30GlsSYADxNCtto7h2k354/B2PIDAkUPKWHJX7vWfNz6KYOmrxWmVYCvv1ri07Hgdv2440qzSWD9WJWPCYs7EZoVUWC68VxF3Z1UDpiSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/EDEYfv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96641C4CED2
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 16:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733935302;
	bh=aldS5hYOgrLEq6CR3iKALSaxFpoZx82F7YOhg/rZn8I=;
	h=From:To:Subject:Date:From;
	b=a/EDEYfvsTi4xXn0qDiyYYmYxdCi6dBW+HZchjolMFyHCo3lenypqbrx/rwj79eA0
	 aUHYkum9330DVA4wJqCVdhO1am2yezmouePN8V9WRtUokZEtJuypL5/PZGW4+Huiij
	 Q/Awgg7KrZm/qZg88+yCu6xNULvwz6AJyOZzw41y+h5PCTO3mAjUOFCBOlCaRG7qWB
	 YtDtNM41TkTJq5BgzAELDgiwN+vcjfDObMPWNhRfv7m7z42vuJDDwaAD6ON58uogQ4
	 2JEm7e/hKd6Oyi5uV9JFH/IjUMqAJLwArs27l5DAa5JVH4Pr+Mb5YZ/e0yrFJEnLig
	 eTTc1ojqHf/XA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix use-after-free when COWing tree bock and tracing is enabled
Date: Wed, 11 Dec 2024 16:41:38 +0000
Message-Id: <8e502fc69ea68d1647707d947e0e4625f0dd1af0.1733934886.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
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

Fix this by grabbing an extra reference on the extent buffer before
calling btrfs_force_cow_block() at btrfs_cow_block(), and then dropping
it after calling the tracepoint.

Reported-by: syzbot+8517da8635307182c8a5@syzkaller.appspotmail.com
Link: https://lore.kernel.org/linux-btrfs/6759a9b9.050a0220.1ac542.000d.GAE@google.com/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 693dc27ffb89..3a28e77b6d72 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -751,10 +751,21 @@ int btrfs_cow_block(struct btrfs_trans_handle *trans,
 	 * Also We don't care about the error, as it's handled internally.
 	 */
 	btrfs_qgroup_trace_subtree_after_cow(trans, root, buf);
+	/*
+	 * When we are called from btrfs_search_slot() for example, we are
+	 * not holding an extra reference on @buf so btrfs_force_cow_block()
+	 * does a free_extent_buffer_stale() on the last reference and schedules
+	 * the extent buffer release with RCU, so we can trigger a
+	 * use-after-free in the trace_btrfs_cow_block() call below in case
+	 * preemption is enabled (CONFIG_PREEMPT=y). So grab an extra reference
+	 * to prevent that.
+	 */
+	atomic_inc(&buf->refs);
 	ret = btrfs_force_cow_block(trans, root, buf, parent, parent_slot,
 				    cow_ret, search_start, 0, nest);
 
 	trace_btrfs_cow_block(root, buf, *cow_ret);
+	free_extent_buffer_stale(buf);
 
 	return ret;
 }
-- 
2.45.2


