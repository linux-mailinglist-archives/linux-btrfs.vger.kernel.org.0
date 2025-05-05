Return-Path: <linux-btrfs+bounces-13687-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E97AAAA902
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 03:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ABD94A42DA
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 01:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D53A3589C3;
	Mon,  5 May 2025 22:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YoDW5HGJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6985B2989B9;
	Mon,  5 May 2025 22:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484925; cv=none; b=hgxtxONA8qHQ2X8yewfv9RTBKSKi1V3jLmRjVPd+1iFbTlXyiPecMmYm0uVhJ4ArmQHpS+mq/NnRamV9d9H97GWWXLWgmj2CD63BZDkWAiBwhZC4WpAKUF4gFLm0REKV0fN9L9fmm3/1JJb9ZRNrFFWel0ZCmT0S7qcihvIX2bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484925; c=relaxed/simple;
	bh=vwyJJuUHQHIUu8CW2ekQWNLRuX3fK4CBnipe7jy1lc4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C1VRPloR/Yslx2/lB5e70MW3HU4KER4/bv+lkTLaeDUF8/b+jKsxc1xy9B2fJSNf/yGzXn4AIyU8p+rglJA++lmUI71K2li+MttH5suatiuCQMixvnfwCd7SpxomoWsYCBBZqSLydW4J3xx06bZnL17MhoQIS1w/sWQ8yb4aMLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YoDW5HGJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D0C5C4CEEE;
	Mon,  5 May 2025 22:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484925;
	bh=vwyJJuUHQHIUu8CW2ekQWNLRuX3fK4CBnipe7jy1lc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YoDW5HGJHhWz9EXSbayOxWdFmnCe5ShXFaQBpq2cnvUpD9YMZYsxUCmuF7aFuyawy
	 ZbfIHjWwGwTRFvJdulceGOKKXszoGzbSZfrVxjI3B9H0jKRH085ycm9ickbgW/4M+H
	 hov4S2BpTNsT80RGpC1pdpLi1STvlPre23r3FU8lsDLxDBFJGJI8leQUWLJX+JE4XX
	 doJTxWY7dknsK3vQCfbqS6+7qjY5i8emo2lIqFdzeIRIsn/IEHGsYm/WBMEwHUvxfz
	 BeoRcLmnLAuPniRUei8c461TdsubrzLzB1uGi6suov0EI77WscwernPusaBWRiqj43
	 sHFUl8gFqlSsQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 080/486] btrfs: zoned: exit btrfs_can_activate_zone if BTRFS_FS_NEED_ZONE_FINISH is set
Date: Mon,  5 May 2025 18:32:36 -0400
Message-Id: <20250505223922.2682012-80-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

[ Upstream commit 26b38e28162ef4ceb1e0482299820fbbd7dbcd92 ]

If BTRFS_FS_NEED_ZONE_FINISH is already set for the whole filesystem, exit
early in btrfs_can_activate_zone(). There's no need to check if
BTRFS_FS_NEED_ZONE_FINISH needs to be set if it is already set.

Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/zoned.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 2603c9d60fd21..d1167aeb07354 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2326,6 +2326,9 @@ bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices, u64 flags)
 	if (!btrfs_is_zoned(fs_info))
 		return true;
 
+	if (test_bit(BTRFS_FS_NEED_ZONE_FINISH, &fs_info->flags))
+		return false;
+
 	/* Check if there is a device with active zones left */
 	mutex_lock(&fs_info->chunk_mutex);
 	spin_lock(&fs_info->zone_active_bgs_lock);
-- 
2.39.5


