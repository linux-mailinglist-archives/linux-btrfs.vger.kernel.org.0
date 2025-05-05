Return-Path: <linux-btrfs+bounces-13692-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DE3AAAEB2
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 05:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2F063A11DF
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 02:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472102DFA49;
	Mon,  5 May 2025 23:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdTK8FJb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4523A3703A0;
	Mon,  5 May 2025 22:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485890; cv=none; b=U4tq/dIf48BItqD6ewz8reFKMslpyE+9j8KQzi1Y+Z0e/xv2yBz1lxht57coARd2hLzT7l2Mg8k8WnBzxeJQ3IhF0qQeBb8CRuDpIfSoWGhlTNbtfNqiVygbsM0IEYArCL4ZQLRbM7lUZrzpBfGs9Lg9vDZcafPTFzPIvtdw4xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485890; c=relaxed/simple;
	bh=+hco7Qcf1J/3svnGBWPdKcaMwe7xh4FuI0NwgsNYfiA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AVz9cEe8n9JQ2wXwzs9KjLZhIantl4GStarT8koKpKpHY8b3NrnAuCbMSq99j8B/FecoYpxeHPMaSpf4AueHg1/AT51ypAYI72SQWb3xpwO7QhiuAys93gQCJLxwgBwXpLcV8f1wspF0z+KVQLCv3NA9hbJ2Uy3H8q8aFwqUfUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CdTK8FJb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23AB9C4CEF5;
	Mon,  5 May 2025 22:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485889;
	bh=+hco7Qcf1J/3svnGBWPdKcaMwe7xh4FuI0NwgsNYfiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CdTK8FJbfA1I95V9DVicYmUm0NXW6Z15dw4tCDLJgnzRBriudedjZCUlqzuZOAf9A
	 tRJxPG7SkYNuQT17nT9XPA3nC6NZRsi4lleqHEGhhNacJ2HksmAq1KLZR738jmgOjV
	 DQx4Dp2emWQNCvejbenR+1B7CqdZDXqZVWmY+Ba7LXOVkgdcyOofuuiWQV6lIVZxk3
	 zPQlrtyg9QpJd1RzXeARv0+UKDZdzzy5D1bO2mUVCNie1Ek1KJsXAgZCnr+sLg46rf
	 CagNhjh2cyGqfz65Flurstwj42MWkeKwf1hi24h7ii63bbwFE5f3MOycnoxGzf5ui1
	 WkA9aed+0ABYQ==
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
Subject: [PATCH AUTOSEL 6.6 050/294] btrfs: zoned: exit btrfs_can_activate_zone if BTRFS_FS_NEED_ZONE_FINISH is set
Date: Mon,  5 May 2025 18:52:30 -0400
Message-Id: <20250505225634.2688578-50-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index 197dfafbf4013..6ef0b47facbf3 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2220,6 +2220,9 @@ bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices, u64 flags)
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


