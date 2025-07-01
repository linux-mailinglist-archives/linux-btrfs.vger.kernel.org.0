Return-Path: <linux-btrfs+bounces-15170-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36061AEFE92
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jul 2025 17:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DCF144538C
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jul 2025 15:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62A527AC43;
	Tue,  1 Jul 2025 15:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8IU81Z9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1211527AC2A
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Jul 2025 15:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751384549; cv=none; b=hK5AunlB1INMR0d5rZ6LBHogx8LJUuZp89tHNGB8bf8OJru7OcMZJYvp0QpA4hapHWKFqU1BOM3z9Ak91Scq7Eld9fiJutX5oIjftkvZAGraUDfacv8UqoGD/QmOZiwAUNHSeCQ40a28hpAL9SvBsZFPChQNGZHehEMeIrc5Fuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751384549; c=relaxed/simple;
	bh=orR/IDpQiqy3Q2B5ZPVss62/WQUgfweIS43q8DeTaxc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=droNS+23H+cbgqIKPH+R4StlNHqC1ZRSfYFC22H0/H5J0Ocg4ZwWfapT8NtHJ/FrgLnaa1jD6VcM7vvuG4i0iWrV3mYMX01oB7ETpsNuu9v8hNYQXZb3PpwJ6RAlMeE4R/KMvqC9HSdjdruXFwmP7fsYIXYBIkmLDML7bVeZIpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8IU81Z9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D64FC4CEED
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Jul 2025 15:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751384548;
	bh=orR/IDpQiqy3Q2B5ZPVss62/WQUgfweIS43q8DeTaxc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=V8IU81Z9BPFSkJ3A2W+7vvHh7JMcZtgiI4U9GE+o/NKhz2g91BV2mngknilWH8jkT
	 yHYh34ZNfjLQ5Iju09LRUBhZ+HeIyN+BRyUGhE4O+OJLo5LlBTQALKUIw3GrZaAbQ8
	 ghZD1oTBgha1uC9yrH54yTTcxDc+vXczmXYBrcWCpF7LY6zr/E5fDu2sgA2E20P89/
	 mbheubnk2dNVOuy3MWx972DZ7Te9GIx8MPPhS7p4X61roOzqQEmq78ZzCLzxQD+Cf8
	 2/Hgj1VaMYdRar+0a/mV2ak2LJRppH4Ahv+GJY5RNSYBT8EW0DyAncxOikscT5jJ6G
	 tEG6r0R0iXS3w==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: qgroup: fix qgroup create ioctl returning success after quotas disabled
Date: Tue,  1 Jul 2025 16:42:21 +0100
Message-ID: <9a550560f176ad2ad5a2f3a0b1900175e574dd7b.1751383079.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1751383079.git.fdmanana@suse.com>
References: <cover.1751383079.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

When quotas are disabled qgroup ioctls are supposed to return -ENOTCONN,
but the qgroup create ioctl stopped doing that when it races with a quota
disable operation, returning 0 instead. This change of behaviour happened
in commit 6ed05643ddb1 ("btrfs: create qgroup earlier in snapshot
creation").

The issue happens as follows:

1) Task A enters btrfs_ioctl_qgroup_create(), qgroups are enabled and so
   qgroup_enabled() returns true since fs_info->quota_root is not NULL;

2) Task B enters btrfs_ioctl_quota_ctl() -> btrfs_quota_disable() and
   disables qgroups, so now fs_info->quota_root is NULL;

3) Task A enters btrfs_create_qgroup() and calls btrfs_qgroup_mode(),
   which returns BTRFS_QGROUP_MODE_DISABLED since quotas are disabled,
   and then btrfs_create_qgroup() returns 0 to the caller, which makes
   the ioctl return 0 instead of -ENOTCONN.

   The check for fs_info->quota_root and returning -ENOTCONN if it's NULL
   is made only after the call btrfs_qgroup_mode().

Fix this by moving the check for disabled quotas with btrfs_qgroup_mode()
into transaction.c:create_pending_snapshot(), so that we don't abort the
transaction if btrfs_create_qgroup() returns -ENOTCONN and quotas are
disabled.

Fixes: 6ed05643ddb1 ("btrfs: create qgroup earlier in snapshot creation")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/qgroup.c      | 3 ---
 fs/btrfs/transaction.c | 6 ++++--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index eb1bb57dee7d..ae9bc7c71a34 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1662,9 +1662,6 @@ int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 	struct btrfs_qgroup *prealloc = NULL;
 	int ret = 0;
 
-	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_DISABLED)
-		return 0;
-
 	mutex_lock(&fs_info->qgroup_ioctl_lock);
 	if (!fs_info->quota_root) {
 		ret = -ENOTCONN;
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 2e07c90be5cd..c5c0d9cf1a80 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1735,8 +1735,10 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 
 	ret = btrfs_create_qgroup(trans, objectid);
 	if (ret && ret != -EEXIST) {
-		btrfs_abort_transaction(trans, ret);
-		goto fail;
+		if (ret != -ENOTCONN || btrfs_qgroup_enabled(fs_info)) {
+			btrfs_abort_transaction(trans, ret);
+			goto fail;
+		}
 	}
 
 	/*
-- 
2.47.2


