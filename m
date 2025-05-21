Return-Path: <linux-btrfs+bounces-14177-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8813CABFC7B
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 19:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 449B44E4CCF
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 17:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A8828A71C;
	Wed, 21 May 2025 17:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6QZ8ehW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2597F289837
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 17:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747849459; cv=none; b=HwxQlZ9uleCS/9lR5K5tAkDuiyp1r39WTS83fp30dtqrk1fUg98rBiOVFK2lW+nsEdviNPnetgCdxnszfKI5mFbhs9kNyrIHIXyt4MLz5d1jTOugOdAeWuuBUOPItOUWSDv4+njDUxVWuu6GucCMbMAoi79zoMdlzLYNMrV+7C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747849459; c=relaxed/simple;
	bh=1ESsmDvE0BI89Cgk/fVhYGpKyt93Kz0ks6nVF6k+Yjw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mNFUPnO6lfVOJadt6oQJy7MJhqBBM24uqr4GG0M4qZwRdLz5AwVLOJxQDVstn2JpG64jqkctoOWvIcdNo51WBwInXKPdBjLZHbtzABJqjzqcQZHO1/5VIRemHGtKH2lJcMwcBfMudU9ED0QBLwh+CEF7EIfN1lhi5g8/4EoOPtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6QZ8ehW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D3E2C4CEED
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 17:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747849456;
	bh=1ESsmDvE0BI89Cgk/fVhYGpKyt93Kz0ks6nVF6k+Yjw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=c6QZ8ehWixD+Q+mFIFEhyphsvcug5F6Bo/CEC5j+3WfIwe9X4uvyD2P0ef0r8xMOA
	 eTPsf6WDDWdLrG2bVwdoxgIq9Rm1Az/bLKw23bSQROuk/ErTp1v1u0BtE+gEstKKZY
	 Va2tcBqd4Iwi3kpOy3AzLrmEXzvYjnEHBvneB2k01SndtEhhFtVRUZXXymOb3HrBKx
	 NvMDKa5YG7hdu5LcZpyCjG7awV+0JR+u5E6Rw+J1hTX4L1c8nPQTkt97JXn04jbWhq
	 r+5SypCk3N42nCJv8mPu/5P+lqoANfKiz1wk8LFrVKAZuXYP0xbuY/FbvcnmUNRJJB
	 nb7RzNEiCqKwQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/4] btrfs: abort transaction during log replay if walk_log_tree() failed
Date: Wed, 21 May 2025 18:44:09 +0100
Message-Id: <c3523628b8e3bf81370697c78594f3d69422abc9.1747848779.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1747848778.git.fdmanana@suse.com>
References: <cover.1747848778.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

If we failed walking a log tree during replay, we have a missing
transaction abort to prevent committing a transaction where we didn't
fully replay all the changes from a log tree and therefore can leave the
respective subvolume tree in some incosistent state. So add the missing
transaction abort.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index c1c4b8327229..730d67dba58c 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -7283,11 +7283,14 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 
 		wc.replay_dest->log_root = log;
 		ret = btrfs_record_root_in_trans(trans, wc.replay_dest);
-		if (ret)
+		if (ret) {
 			/* The loop needs to continue due to the root refs */
 			btrfs_abort_transaction(trans, ret);
-		else
+		} else {
 			ret = walk_log_tree(trans, log, &wc);
+			if (ret)
+				btrfs_abort_transaction(trans, ret);
+		}
 
 		if (!ret && wc.stage == LOG_WALK_REPLAY_ALL) {
 			ret = fixup_inode_link_counts(trans, wc.replay_dest,
-- 
2.47.2


