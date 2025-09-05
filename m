Return-Path: <linux-btrfs+bounces-16664-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16881B45D98
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 18:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA471A4643E
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 16:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21561313267;
	Fri,  5 Sep 2025 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0OSAvh2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6639D30B53C
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 16:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757088657; cv=none; b=m/6TxXOKkaLvENF+C3loBAug4JCbkIWEWY+IH0gVVPY9caVEe/QS7yjmsmNN/bEUM72xlKnzE1hqrRSjpRD5l7hv0oUmA9BKbDjkMNFkH/BVsExBQRwaLQThnMYs3ewpPE8gc758K/Q6fBdlBhx5VjbP9RK3kcl5r6/wCg5HGs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757088657; c=relaxed/simple;
	bh=eOkPsc1D+qNHb6MJHVRKfswGGW7slzmCr3iHMgH/6+8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g7/RgaYKQ1uzI/JNDf5Nz6/3NvlPz29khEqzoyj7Nst4GKaTVzzQIy1v0kOT/f5Fo9d1GJ3UxDql5So8gp0OGeiH3A1c1z+9gumNCuBd5H+Mpz5bIAxKki1otxcRzIv/xrlVpi+FYG9qCvLJNDfjCeUhtpApb692eloTfv2kN14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0OSAvh2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79715C4CEF1
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 16:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757088657;
	bh=eOkPsc1D+qNHb6MJHVRKfswGGW7slzmCr3iHMgH/6+8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=W0OSAvh2Ar3G0wA1r/BPwPBwPNCIMKV4g5yaeHtLFoety4zcF1ErKcycYBaAqAOx0
	 uqx0tpFHKxeKtrIPLJnugw4AXiaA5VEOqXg73LBGC1HErYF59DCzBQ7tREvJnKE2mG
	 uwhnSFTRxObglfhrpeUZQd+OoZZf8vimxB+Wkhf7zD9J3JpqqqTUxHoFLAvV8Kuec2
	 XouBG5ugxMf+G/bLsa+pAt50aZw+dnQB6+rdJrRRKOq+XJyL6iejztWKJiIrKNvjH3
	 A2/JdvAk7ydZ+nVFBpHBUqnDA5byZe1yQBUf7q+t593XdY2A+yGuD0UTK/zpu3Pfgk
	 PoHxIg8K9TD7Q==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 20/33] btrfs: use level argument in log tree walk callback replay_one_buffer()
Date: Fri,  5 Sep 2025 17:10:08 +0100
Message-ID: <efed6eddf1a41378d0a517e8c713ec04fae7d0cf.1757075118.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1757075118.git.fdmanana@suse.com>
References: <cover.1757075118.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We already have the extent buffer's level in an argument, there's no need
to first ensure the extent buffer's data is loaded (by calling
btrfs_read_extent_buffer()) and then call btrfs_header_level() to check
the level. So use the level argument and do the check before calling
btrfs_read_extent_buffer().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 166ceb003a1e..88e813bb28d8 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2591,17 +2591,15 @@ static int replay_one_buffer(struct extent_buffer *eb,
 	int i;
 	int ret;
 
+	if (level != 0)
+		return 0;
+
 	ret = btrfs_read_extent_buffer(eb, &check);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
 		return ret;
 	}
 
-	level = btrfs_header_level(eb);
-
-	if (level != 0)
-		return 0;
-
 	path = btrfs_alloc_path();
 	if (!path) {
 		btrfs_abort_transaction(trans, -ENOMEM);
-- 
2.47.2


