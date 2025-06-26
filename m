Return-Path: <linux-btrfs+bounces-15006-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98478AEA33F
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 18:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0600C565751
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 16:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C30A1FBCA1;
	Thu, 26 Jun 2025 16:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tKakplIz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706B91F5413
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Jun 2025 16:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750954156; cv=none; b=mCAHDchQYDtpif91LnxuwCbFsKdpyAdWW7FZ4XqtjrvfzKdHy4ZyUEun5Di1uRJypizfgvBl7R5OIXyEEzelWlupuX6zHhEoSKTWzCzrAuTtQc4w+9IMrrVkjeivsoG58K9FkLVHms3d5ijRjJjLLLarfQi/sPlBY++CmnhRdyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750954156; c=relaxed/simple;
	bh=vy2t/7DtRBlXES4OaDyo7xEL98ZpSDyRkjKiV2GYcT8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=fmvV0bRM6hBgj91dHkIaArDwsX9fTXU1XIKPBRbVtE0mjhAVbCezokNr5rr4wgHKPyIUrbDU7qQTTnCaF68hNWJvUXS0QNx4qvow0vxDeX4bknq1ZPoJWzzXzVcjYlnNPcRxDVKgYcp2X2gkx9F9gAP11XesnfeOh00qIXUOTWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tKakplIz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7746EC4CEEB
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Jun 2025 16:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750954156;
	bh=vy2t/7DtRBlXES4OaDyo7xEL98ZpSDyRkjKiV2GYcT8=;
	h=From:To:Subject:Date:From;
	b=tKakplIzZ653ZrAKO+pU2rxp2YNhSgIPKyLRUuyese3akNurMHv4kcJy8kfr//7Ql
	 6/15vK4+zvMlKzZy8upsqNiFB+edK7PcOq2wAe+7tILVYX40YHda8LHU3k1iMBYuD7
	 4bjwmUYhHfdS4JjoyquwmHKVcAQ/52Ch/QvrkhxtLgxAjTBibZ64rL0FaQisqZRQRf
	 fOUhmrndGzbphxuh/jiGlldUMxib983DlHp2uAewesEk9BPWLLAZPrIeyPs8ypAHcr
	 OglEQWiV6GQzuv/gJWtBVt/CRcvpxpVt8WJVnIZDNENX6V0J9ko8qqTGucqiymGFwJ
	 W/696R5zJRZHg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: qgroup: avoid memory allocation if qgroups are not enabled
Date: Thu, 26 Jun 2025 17:09:11 +0100
Message-ID: <b0e317f51f01fd88c32fd14f6bd8ea40b88943fb.1750954008.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

At btrfs_qgroup_inherit() we allocate a qgroup record even if qgroups are
not enabled, which is unnecessary overhead and can result in a transaction
abort for transactions that create snapshots if the allocation fails, as
btrfs_qgroup_inherit() is called in the critical section of a transaction
commit.

Improve on this by making btrfs_qgroup_inherit() check if qgroups are
enabled earlier and return if they are not, avoiding the unnecessary
memory allocation and taking some locks.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/qgroup.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index afc9a2707129..b83d9534adae 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3328,6 +3328,9 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 	u32 level_size = 0;
 	u64 nums;
 
+	if (!btrfs_qgroup_enabled(fs_info))
+		return 0;
+
 	prealloc = kzalloc(sizeof(*prealloc), GFP_NOFS);
 	if (!prealloc)
 		return -ENOMEM;
@@ -3351,8 +3354,6 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 
 	if (!committing)
 		mutex_lock(&fs_info->qgroup_ioctl_lock);
-	if (!btrfs_qgroup_enabled(fs_info))
-		goto out;
 
 	quota_root = fs_info->quota_root;
 	if (!quota_root) {
-- 
2.47.2


