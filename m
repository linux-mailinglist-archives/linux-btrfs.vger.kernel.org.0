Return-Path: <linux-btrfs+bounces-8223-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F29BE985763
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2024 12:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B77632847F8
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2024 10:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B059C18A6A3;
	Wed, 25 Sep 2024 10:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WShXoe8v"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93A2189F52
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Sep 2024 10:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727261441; cv=none; b=p8LsUDdOBREXdvYIAteCjGBBDSl97+9d77n8d0r50neY2BKT/YlJOXXtCPWB+fTtZKJyqWueFs4tPL8d+CBiDTeRzDb82M/I6d/qq3dxoeb7Q2JguoqZHbOptjBOZSHEi1AV5Wh9KVfvEPx3Xp248nw0pxVEKSafgCgPRbF8Wxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727261441; c=relaxed/simple;
	bh=AMjAsloxBtPntjh6SXe+5cJD1nh8j5fiexMLdhBZMPY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iycrvCjfeHsldP8VtLnuthFfcq8tEGvF4wTe7kD0oWHopofqapc+ggQ8YCtRx4WIt8G1XUkP4v+xDdOrdqoHYhUHunUO71ssC6eo4J6V6V2u4n6ef7TJTZUZJuRjV4KuR4H2vfgQNlysLv66zV8F9MzNkGLQuoq/Q2/lWXPGU4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WShXoe8v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00EBCC4CECE
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Sep 2024 10:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727261441;
	bh=AMjAsloxBtPntjh6SXe+5cJD1nh8j5fiexMLdhBZMPY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=WShXoe8vlUjp8ipVsqPyneEPqtZzbcDUg/MaR3c4yL62sOUiX37uG2cDRmhjo5NJV
	 O7O5zK2NG+E5gM2nJSO/vNHnaMATlN8tBNWm+GvXPFPoPZHk3dpKmFNPQcwMZlEzSq
	 mnZK6c5wQPbOD6Y2j0snAG1MCNJE9jz8wD9ksftbX0w1r9VNnVkVXXzOLWtWOTMzVZ
	 drJaTWTdXw6OXjst7Nx67reODFnpqTnNpBOgr3XtLszLqEmgB6zyaAOQ92GdQfodvU
	 tKA7UAiS3VgV5UrPe5+ddS6e9juS3Pgsb1FwD7FZGxNccYHOGrLLfaoEWmKV+3C91R
	 OoZ4o++ZY8WGA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 8/8] btrfs: remove pointless initialization at btrfs_qgroup_trace_extent()
Date: Wed, 25 Sep 2024 11:50:30 +0100
Message-Id: <ca05508bba8d69fe79211f847f2e3ff7e7c955cb.1727261112.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1727261112.git.fdmanana@suse.com>
References: <cover.1727261112.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The qgroup record was allocated with kzalloc(), so it's pointless to set
its old_roots member to NULL. Remove the assignment.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/qgroup.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index ce7641fdc900..9e10c1190df9 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -2146,7 +2146,6 @@ int btrfs_qgroup_trace_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 	}
 
 	record->num_bytes = num_bytes;
-	record->old_roots = NULL;
 
 	ret = btrfs_qgroup_trace_extent_nolock(fs_info, delayed_refs, record, bytenr);
 	if (ret) {
-- 
2.43.0


