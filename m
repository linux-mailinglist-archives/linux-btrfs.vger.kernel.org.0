Return-Path: <linux-btrfs+bounces-13857-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A94BAB1B3E
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 May 2025 19:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 548C2A05DD5
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 May 2025 17:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F9023816F;
	Fri,  9 May 2025 17:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7UJbpnS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C3323498E
	for <linux-btrfs@vger.kernel.org>; Fri,  9 May 2025 17:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746810313; cv=none; b=Xvas0b1SyYXcRGuyxPOkrirEkqniWQP3eNQWQMntwLSzTq181ujLk1LEBOkGt5Z2IrL21dZqGobPX8OhfJl+2d36E0SuGBn0rczjiKX/bB/lwGIap7TR2lKMuIV5/Wpc9qQ7yGsyumy7yBApBx7VcuTr5tlNjttXSR2fHZ8NEOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746810313; c=relaxed/simple;
	bh=mmrjAlJoMIRei0AEz77HyaY3C5PxPxL/no9rZZt3s5s=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=bpg2KwvG66J0+pu5Bu5lsn429cs++BpQBLl92jhcrLynKvibj6n2IT680spov7VzXQKDFPXmhRaVLjLC8CmH2NHUY/JsRGUOFafc7ErcSBnbjebZseAyNyamHMN9GW8Q03268hhboLZPIyqiycSfXr/L7Ctry+7qqQ6dz/Gcgnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7UJbpnS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09370C4CEE4
	for <linux-btrfs@vger.kernel.org>; Fri,  9 May 2025 17:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746810313;
	bh=mmrjAlJoMIRei0AEz77HyaY3C5PxPxL/no9rZZt3s5s=;
	h=From:To:Subject:Date:From;
	b=M7UJbpnSwD5Lhqj5xFRD1uEOyx4ao2vLF4nQC6uXF+BuX0KdS9mlK7QgLh7U8NjEA
	 4sHOXd16D5u9Ab1zUr7xx88Qd53ka1TVzYbLSMWwvZ2hI0Bl7J64ipELuO2O79KWmv
	 fMwM/EqSllS9FTrubxqTPWE2NVYXP9GBBkMLMAX64TyfOdwsW/i/TcMWejvSBcRraU
	 rAHuKzw3Ph1ThjQWgyIHA3l6FBA7kj5Hc3nUrNFvfjtgHQww2UUzINXZycLhHcq6uP
	 SXz3aFSs0JP/ZG+UGK40HPB443gUXiI+OstdP/Vxt4xPDJBciYsWfuLp/lj5sIjbUa
	 ANMbQlSqhw+bg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove superfluous return value check at btrfs_dio_iomap_begin()
Date: Fri,  9 May 2025 18:05:09 +0100
Message-Id: <77971c6472d403679457a3d241e4c70df45eff4c.1746808801.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

In the if statement that checks the return value from
btrfs_check_data_free_space(), there's no point to check if 'ret' is not
zero in the else branch, since the main if branch checked that it's zero,
so in the else branch it necessarily has a non-zero value.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/direct-io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
index 546410c8fac0..fe9a4bd7e6e6 100644
--- a/fs/btrfs/direct-io.c
+++ b/fs/btrfs/direct-io.c
@@ -439,8 +439,8 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 						  start, data_alloc_len, false);
 		if (!ret)
 			dio_data->data_space_reserved = true;
-		else if (ret && !(BTRFS_I(inode)->flags &
-				  (BTRFS_INODE_NODATACOW | BTRFS_INODE_PREALLOC)))
+		else if (!(BTRFS_I(inode)->flags &
+			   (BTRFS_INODE_NODATACOW | BTRFS_INODE_PREALLOC)))
 			goto err;
 	}
 
-- 
2.47.2


