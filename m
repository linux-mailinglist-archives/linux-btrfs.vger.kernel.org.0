Return-Path: <linux-btrfs+bounces-8519-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4668898F822
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 22:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E75571F23111
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 20:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5831AD41F;
	Thu,  3 Oct 2024 20:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="RnXfk+Bi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E8B224D1;
	Thu,  3 Oct 2024 20:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727987615; cv=none; b=OwJDnpbx8rr+9rCs4YeIkZ9E5wbvk22HQbzMe6+0ALuJZ96em08cvJxiYOazLsi7XUu/tlsqMxTTiNRjGa9Pz5E6AXgTVPPlTLVWboQ2HFJ94DFqq9x9qkWFZz0mH2fi6kQ4SCEBdzbYFU25ByWqPuXVvKePbcwXsk1MjGOzXpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727987615; c=relaxed/simple;
	bh=guJ0DKXtJMljW6Vi2PpqjLwdFH3mRPlgCGWX10iFbNw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I2he0EW2Vwr5Sx4xxAmFqWbAuFFfbODIBSuaozc9yGZVbAxnucn68mehWJpZRrIOogMujHd5up4L4aJQiihsp5tIR/HZR9pgiaHA6iffLk4z8MYbkhl/FE7x9JoyOOueQpArEWNkWr95fjTYfRtVDHu/oR5JPhVultLOnPtG6XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=RnXfk+Bi; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=5nOYUj1xEjS9p3A0yBmjvisdymM8qBIM9VncwhDdLiI=; b=RnXfk+BicI2Pwn0a
	0VBUOZZbv2+FWICAay56GYHVRiI1NukOGlgyo0v/85ZulDsQ3CJ5Etwm0yj8xiVZ5jSbKU+LzZoED
	ZdFig6MsPEVyvvT2IFL4jMmGsh5GpgP7TaGMIYM0ZEEANlLM8NqiLmEyy+amHz67ZzayR1Aw7spLJ
	dDsyaNmgivLqD27fpkKryp/5AkrmzjzZtY13NJWuPXSShqbIcEaQAI8/+MJVHaHEW7xjbRRKTDm9V
	XXcVQwrMPf8w6/USz0rZZbc9d94nvvXkIMzU8eZY1hIbbKkgIP3gvDGRuo1Gf44Amb810HibB+v7s
	ye5UUBxc+v4XQaA+Ng==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1swSVk-008jXQ-2B;
	Thu, 03 Oct 2024 20:33:20 +0000
From: linux@treblig.org
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	boris@bur.io
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] btrfs: Remove unused btrfs_free_squota_rsv
Date: Thu,  3 Oct 2024 21:33:19 +0100
Message-ID: <20241003203319.241687-1-linux@treblig.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

btrfs_free_squota_rsv() was added in commit
e85a0adacf17 ("btrfs: ensure releasing squota reserve on head refs")

but has remained unused.

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 fs/btrfs/qgroup.c | 11 -----------
 fs/btrfs/qgroup.h |  1 -
 2 files changed, 12 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index c297909f1506..52f0cf7621d6 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -4883,17 +4883,6 @@ void btrfs_qgroup_destroy_extent_records(struct btrfs_transaction *trans)
 	xa_destroy(&trans->delayed_refs.dirty_extents);
 }
 
-void btrfs_free_squota_rsv(struct btrfs_fs_info *fs_info, u64 root, u64 rsv_bytes)
-{
-	if (btrfs_qgroup_mode(fs_info) != BTRFS_QGROUP_MODE_SIMPLE)
-		return;
-
-	if (!is_fstree(root))
-		return;
-
-	btrfs_qgroup_free_refroot(fs_info, root, rsv_bytes, BTRFS_QGROUP_RSV_DATA);
-}
-
 int btrfs_record_squota_delta(struct btrfs_fs_info *fs_info,
 			      const struct btrfs_squota_delta *delta)
 {
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index 98adf4ec7b01..d72e09de2d64 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -440,7 +440,6 @@ int btrfs_qgroup_trace_subtree_after_cow(struct btrfs_trans_handle *trans,
 		struct btrfs_root *root, struct extent_buffer *eb);
 void btrfs_qgroup_destroy_extent_records(struct btrfs_transaction *trans);
 bool btrfs_check_quota_leak(const struct btrfs_fs_info *fs_info);
-void btrfs_free_squota_rsv(struct btrfs_fs_info *fs_info, u64 root, u64 rsv_bytes);
 int btrfs_record_squota_delta(struct btrfs_fs_info *fs_info,
 			      const struct btrfs_squota_delta *delta);
 
-- 
2.46.2


