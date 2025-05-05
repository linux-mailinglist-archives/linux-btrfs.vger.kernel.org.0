Return-Path: <linux-btrfs+bounces-13698-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 292A8AAAF75
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 05:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D93853BA709
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 03:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6923B6B83;
	Mon,  5 May 2025 23:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLyo3myL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681E73984DE;
	Mon,  5 May 2025 23:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486456; cv=none; b=D0tJuXd0pG482k9G1bBeRkW/ntUG+04Z+Sfdyp3IFybiMJrvOtwiiktjzhWDDY8i4f5fxxzLg4L5X8DA8AzmSjwhuSIJ6XYH8RDjBhFl+8tMmbU8yo6HewYiSczwoRI5q8IsUFw97IlxQA2nEGwO/0i8d65hNihTdoLaVW+Yhk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486456; c=relaxed/simple;
	bh=qnmeNuCJKTcdMgGFnm6k5CzPcF93PA5+z9Xy+/E98ks=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XDUcBoa1ilcY8/LvcVCybjP/uF5bHme11rei60v9sXIodVFF14w74kEbIjfq5M5HRYOgLVlvzPrvDt/N/5yWD6hRCH4pbezszNDAHUbmXBTkF9jAHKGD4RoMKSaZySxuCK0rmMKKIjUOzYHjM5uW8Oydwlley9IC+IoGVPFpeDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLyo3myL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 476CCC4CEEE;
	Mon,  5 May 2025 23:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486456;
	bh=qnmeNuCJKTcdMgGFnm6k5CzPcF93PA5+z9Xy+/E98ks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nLyo3myL7nN7TjVJEERHFnKLTqOKl9Np41ztz/jyIaGL0Z7tvWRnEyAIMDL9Z+xaN
	 3OXG9/iF1QWE50LxeThRqumOmfXOq2aaxYzOaEp6YZx37mB8RrjFuiQw6Lu/kvMVCE
	 Z/Pht8gvA1enig0PnuiLHezZXm60h0HF4ml79fSV8kXno488p3u2oV7gKNjDMQW0kG
	 i186+9KjxWAG70U2VfoaW5WHTFj6hrl8p9besed25Ut418UCzOSpVp8E7poMxRpdqv
	 cWstM+4M3zjOUIuUmwsLODMTohb56N/rf2R4LY3f699gHj9orLo7QWM2mwtUWCk23t
	 li3xCEYOXjCQQ==
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
Subject: [PATCH AUTOSEL 6.1 040/212] btrfs: zoned: exit btrfs_can_activate_zone if BTRFS_FS_NEED_ZONE_FINISH is set
Date: Mon,  5 May 2025 19:03:32 -0400
Message-Id: <20250505230624.2692522-40-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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
index 1dff64e62047e..bfd76a7dcfa02 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2105,6 +2105,9 @@ bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices, u64 flags)
 	if (!btrfs_is_zoned(fs_info))
 		return true;
 
+	if (test_bit(BTRFS_FS_NEED_ZONE_FINISH, &fs_info->flags))
+		return false;
+
 	/* Check if there is a device with active zones left */
 	mutex_lock(&fs_info->chunk_mutex);
 	list_for_each_entry(device, &fs_devices->alloc_list, dev_alloc_list) {
-- 
2.39.5


