Return-Path: <linux-btrfs+bounces-8247-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0452987057
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 11:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49B86B27440
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 09:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1051AD406;
	Thu, 26 Sep 2024 09:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjjIhhYa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97AD1AD402
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Sep 2024 09:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727343212; cv=none; b=jZ9knRCaBdairVfXPiL0P+jYOXPuI5Tm2W1PSTHrXq7JXMBhYEaCFZ+o8BHv6ExysrtqtH//Rcx3Y2UCdJMtLS/llJwkqtOUMXumeyLIgsHCcLDr1JQpz6HvMdctgMPu4igRcyKz6dPa0FRts4TTEczLCx1oofpYE49gNQN40Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727343212; c=relaxed/simple;
	bh=3a+ScunoTmR1MC/PQB4DsstH/bqmcKQEc2I+1ZR71YY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uHhCHaG3jfIDcRcALiqSxPF305krPUFtrt+SZLdafUetkzNjzjyqr9zXVu5VvDkLYjquePPayhNixvBjzy3dOdA5yNi+bkf8BTrXZH6D0XNj1X87U7XL/mqcvcwdip/v0R64eojQzncJlo6OMmoIn4zdobzHkIMIbguXER92zPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjjIhhYa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F90C4CECD
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Sep 2024 09:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727343212;
	bh=3a+ScunoTmR1MC/PQB4DsstH/bqmcKQEc2I+1ZR71YY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=FjjIhhYa9IzUsEnZ/ThN8T8A6bc9Rgi5Srsi3OGdH6OVSb1/uP4rrBTIoY6vl721A
	 wId0ZFvoP21AbFryv2/YaWxAZr628XbQ7/zKKvVpN+nGczXUqHRxQuUFgoRAOYTNks
	 jacNW1W+Rx+OqdnN6SIGjZRw7JNZZHs+ksnlWPKPo7llHbovEjr4h2Tf5R5VUy453x
	 lpLeYW/JJNpTl5VyDWZSYTe17chIyDluaMOXYzaZp6IBGx7DWgGDtgKggAW3wmT/4k
	 aZjCaVt6cNWsTlM20870pkK40k4H2eunvXUxj/hF63koY4QnNPmbypIFwic+WvxA1O
	 l7j02jOzstGhg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 7/8] btrfs: always use delayed_refs local variable at btrfs_qgroup_trace_extent()
Date: Thu, 26 Sep 2024 10:33:21 +0100
Message-Id: <87fc06f72674c45c840878c382480d84e2020b54.1727342969.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1727342969.git.fdmanana@suse.com>
References: <cover.1727342969.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Instead of dereferecing the delayed refs from the transaction multiple
times, store it early in the local variable and then always use the
variable.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/qgroup.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 3574af6d25ef..6294f949417c 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -2140,7 +2140,7 @@ int btrfs_qgroup_trace_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_qgroup_extent_record *record;
-	struct btrfs_delayed_ref_root *delayed_refs;
+	struct btrfs_delayed_ref_root *delayed_refs = &trans->transaction->delayed_refs;
 	const unsigned long index = (bytenr >> fs_info->sectorsize_bits);
 	int ret;
 
@@ -2150,12 +2150,11 @@ int btrfs_qgroup_trace_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 	if (!record)
 		return -ENOMEM;
 
-	if (xa_reserve(&trans->transaction->delayed_refs.dirty_extents, index, GFP_NOFS)) {
+	if (xa_reserve(&delayed_refs->dirty_extents, index, GFP_NOFS)) {
 		kfree(record);
 		return -ENOMEM;
 	}
 
-	delayed_refs = &trans->transaction->delayed_refs;
 	record->num_bytes = num_bytes;
 	record->old_roots = NULL;
 
-- 
2.43.0


