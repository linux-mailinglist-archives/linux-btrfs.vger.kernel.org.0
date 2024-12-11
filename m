Return-Path: <linux-btrfs+bounces-10237-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8214F9ECF17
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 15:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A8661887230
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 14:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6A31D04A9;
	Wed, 11 Dec 2024 14:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IApfP/Zg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A221D90DF
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 14:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733928822; cv=none; b=fqvZMNpZykK8fvigKj4z6P+sx87FzjG7KfNTQClWKYbloILZpFI9XGG2QaUsdeIAOwWRv0iqz9v3b5JKFlvoyPFi6ARjvwimDUei6BkLbsToF1M0W+yZ+nENCfxnGvMl4hs5dtSGmJBw4v1RTPMPqshOys5VRLi9oBa7ahrQAz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733928822; c=relaxed/simple;
	bh=ycC0dKG9jNfYd/lP/T7AVF97cMRAFo92hhkzk1tdHa8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CTM123vimpeEAu+LQmmgRxsbs2NNJF0IAE/EFLR2rHTU8ZcunspyAupl9fvQaNx3PVpfU6lkqbxDyhDd2n9Ue/kJ2SjhvYCcdFIHBqohlcFn3N7KEZqpEbns2SPJG/6J47rglZCEjVKAVQrCc9hNSgwvWBQ8hS7P+3r3ZbRMoQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IApfP/Zg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C301C4CED4
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 14:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733928821;
	bh=ycC0dKG9jNfYd/lP/T7AVF97cMRAFo92hhkzk1tdHa8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=IApfP/ZgSs6513fRvKaOL55KyYGKB4uRcSLzFpPK/VI8uzfhc02bjobeEVQ2SN8pc
	 nPtomaGDPvNuOhFPVTVPswIdNGi6r6lB5GNXjR5VVMrJ5KHdSPtxbzSjAJDLfYYg6Z
	 +ZsMiPBI1CApzpWTZzzxA8zwdyaw0gScr6Wv1/kY0d0264nNXtvTV5AP8hVNDPem99
	 tbZbjOBugpQr1NgQY+5ZPR5TDzOkOahN43hmklaphvK0BtoPmreqGbnEfoqzD+t0+7
	 ix2c1kZtgSGMOdKP7XoafdQ0+mxF7knqCuUMzl4JwnU0sVnll3p60beBURjlN+o9Cy
	 aVtJbx0YyB9IA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 10/11] btrfs: add function comment for check_committed_ref()
Date: Wed, 11 Dec 2024 14:53:27 +0000
Message-Id: <d699eacc037b2dca1b8578948f90ddaf64985395.1733832118.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1733832118.git.fdmanana@suse.com>
References: <cover.1733832118.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There are some not immediately obvious details about the operation of
check_committed_ref(), namely that when it returns 0 it must return with
the path having a locked leaf from the extent tree that contains the
extent's extent item, so that we can later check for delayed refs when
calling check_delayed_ref() in a way that doesn't race with a task running
delayed references. For similar reasons, it must also return with a locked
leaf when the extent item is not found, and that leaf is where the extent
item should be located, because we may have delayed references that are
going to create the extent item. Also document that the function can
return false positives in order to not be too slow, and that the most
important is to not return false negatives.

So add a function comment to check_committed_ref().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-tree.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index af3893ad784b..3dea8ce87bf7 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2295,6 +2295,48 @@ static noinline int check_delayed_ref(struct btrfs_inode *inode,
 	return ret;
 }
 
+/*
+ * Check if there are references for a data extent other than the one belonging
+ * to the given inode and offset.
+ *
+ * @inode:     The only inode we expect to find associated with the data extent.
+ * @path:      A path to use for searching the extent tree.
+ * @offset:    The only offset we expect to find associated with the data
+ *             extent.
+ * @bytenr:    The logical address of the data extent.
+ *
+ * When the extent does not have any other references other than the one we
+ * expect to find, we always return a value of 0 with the path having a locked
+ * leaf that contains the extent's extent item - this is necessary to ensure
+ * we don't race with a task running delayed references, and our caller must
+ * have such a path when calling check_delayed_ref() - it must lock a delayed
+ * ref head while holding the leaf locked. In case the extent item is not found
+ * in the extent tree, we return -ENOENT with the path having the leaf (locked)
+ * where the extent item should be, in order to prevent races with another task
+ * running delayed references, so that we don't miss any reference when calling
+ * check_delayed_ref().
+ *
+ * Note: this may return false positives, and this is because we want to be
+ *       quick here as we're called in write paths (when flushing delalloc and
+ *       in the direct IO write path). For example we can have an extent with
+ *       a single reference but that reference is not inlined, or we may have
+ *       many references in the extent tree but we also have delayed references
+ *       that cancel all the reference except the one for our inode and offset,
+ *       but it would be expensive to do such checks and complex due to all
+ *       locking to avoid races between the checks and flushing delayed refs,
+ *       plus non-inline reference may be located on leaves other than the one
+ *       that contains the extent item in the extent tree. The import thing here
+ *       is to not return false negatives and that the false positives are not
+ *       very common.
+ *
+ * Returns: 0 if there are no cross references and with the path having a locked
+ *          leaf from the extent tree that contains the extent's extent item.
+ *
+ *          1 if there are cross references or if there may be because @strict
+ *          is false and the root was snapshoted after the extent was created.
+ *
+ *          < 0 in case of an error.
+ */
 static noinline int check_committed_ref(struct btrfs_inode *inode,
 					struct btrfs_path *path,
 					u64 offset, u64 bytenr)
-- 
2.45.2


