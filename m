Return-Path: <linux-btrfs+bounces-18205-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5351DC0248F
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 18:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B23291AA2678
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 16:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2D126ED2A;
	Thu, 23 Oct 2025 16:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLTlU0tv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46FE292B54
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 16:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235222; cv=none; b=N7i4Fe/wrmq1anNNncmXzjVwJ7eB9EB7gF2/ICW/tz2gV5H3Kvx84+gJ80tU04XTkmzJi8Sqq3l81xh/GaUQA8PI97YO/Joyw2EiWW6FuAkIvx1RLeeXrhoEBDAvmEvFcUDGIXmjJw5Woi4fffUgC2u5Q/If2nEEPd2myGKNi78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235222; c=relaxed/simple;
	bh=H0j7UlDXOzdAkZPv66kL4N0+c6/oAqpz+50R1Ra9FZ8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e2iHzoUhG5TzuMspxCf1rFZ6pgXQgzHoqyO6595jm3HBF8SNxDIrOYxdB1LhLti6kiN5ZHOmatoYB43ei66LozEtFPw1HXzbnn9onLLT1dNcuwu4jzbSUo1Ec/GfEOoVewE1O8J78cKsIzTlePbZYim9y0ON+h9N3DqY1e+Jn7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLTlU0tv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D71AC4CEE7
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 16:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761235222;
	bh=H0j7UlDXOzdAkZPv66kL4N0+c6/oAqpz+50R1Ra9FZ8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QLTlU0tvdL/8ssKJxFClcuguHjVVjeaMSDgJM9OPwjFi8hKshG4o0UhMotroYu3MZ
	 4tdhMkwTe4Yj+/9vDZCQCjo4dRgVe9W5rw3//J20Kfjht3qvLfr2CoP6iF76G3ydeo
	 99hjFMUN1kJGsMt6nqrZI98Q0OiRCRxZinKFOvepOwo8HDUtSH6mqwn6ClwYUNjJue
	 xLBRjL7fx6R+IFXeawQymVXA6Aqm30cUpdWGSfQMsfZf1epLSFltRKflDfCKGwOLgI
	 +yD7UasQItRGJoAkw/XpUfweh4GXtPTkzmgTYWkRTa9cjhJHdY9EsgOkGFtY+kQCO2
	 ewc/NQ7HAGZEQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 18/28] btrfs: reduce block group critical section in do_trimming()
Date: Thu, 23 Oct 2025 16:59:51 +0100
Message-ID: <1a4d2fa8f7da7b88e3b6b3aeabdcee25245b51ea.1761234581.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1761234580.git.fdmanana@suse.com>
References: <cover.1761234580.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's no need to update the bytes_reserved and bytes_readonly fields of
the space_info while holding the block group's spinlock. We are only
making the critical section longer than necessary. So move the space_info
updates outside of the block group's critical section.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/free-space-cache.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index ab873bd67192..6ccb492eae8e 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -3656,7 +3656,7 @@ static int do_trimming(struct btrfs_block_group *block_group,
 	struct btrfs_fs_info *fs_info = block_group->fs_info;
 	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
 	int ret;
-	int update = 0;
+	bool bg_ro;
 	const u64 end = start + bytes;
 	const u64 reserved_end = reserved_start + reserved_bytes;
 	enum btrfs_trim_state trim_state = BTRFS_TRIM_STATE_UNTRIMMED;
@@ -3664,12 +3664,14 @@ static int do_trimming(struct btrfs_block_group *block_group,
 
 	spin_lock(&space_info->lock);
 	spin_lock(&block_group->lock);
-	if (!block_group->ro) {
+	bg_ro = block_group->ro;
+	if (!bg_ro) {
 		block_group->reserved += reserved_bytes;
+		spin_unlock(&block_group->lock);
 		space_info->bytes_reserved += reserved_bytes;
-		update = 1;
+	} else {
+		spin_unlock(&block_group->lock);
 	}
-	spin_unlock(&block_group->lock);
 	spin_unlock(&space_info->lock);
 
 	ret = btrfs_discard_extent(fs_info, start, bytes, &trimmed);
@@ -3690,14 +3692,16 @@ static int do_trimming(struct btrfs_block_group *block_group,
 	list_del(&trim_entry->list);
 	mutex_unlock(&ctl->cache_writeout_mutex);
 
-	if (update) {
+	if (!bg_ro) {
 		spin_lock(&space_info->lock);
 		spin_lock(&block_group->lock);
-		if (block_group->ro)
-			space_info->bytes_readonly += reserved_bytes;
+		bg_ro = block_group->ro;
 		block_group->reserved -= reserved_bytes;
-		space_info->bytes_reserved -= reserved_bytes;
 		spin_unlock(&block_group->lock);
+
+		space_info->bytes_reserved -= reserved_bytes;
+		if (bg_ro)
+			space_info->bytes_readonly += reserved_bytes;
 		spin_unlock(&space_info->lock);
 	}
 
-- 
2.47.2


