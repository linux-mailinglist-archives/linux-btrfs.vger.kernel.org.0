Return-Path: <linux-btrfs+bounces-15007-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7525AEA37D
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 18:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9E204A22CC
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 16:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BAF2ED85C;
	Thu, 26 Jun 2025 16:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdGoEp7P"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5ED20E6F7
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Jun 2025 16:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750955378; cv=none; b=PYQDKuMYSG6UqoChbwjWgaGa+WWG3yIheYafLHo6a9/DHoWhTax6KAn9GisY8irW6bau8jFoFyhpKooQR9e9YlmzUoXVgYniETk6rpNl72yqmGxkkh3CHGtfOnHesl4YGmSTkAk9pMtHGeJWfBy2hZQhVlvNSet4QGqgvjPrZOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750955378; c=relaxed/simple;
	bh=IPHChg1Ve3JwMOc5Km7ntI957aUOLirjaa/qZQR581s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O3P7WCn3lP8bjBruwn7G9FDmmqO2WFwUtA6O+ik4WiB6xej0aYgify2W8g2Tned5aZysjINCYsU48/q/ILU1UCIf4QXSxELlda3btCoK0X2XkYDFx+UCWOaVJulogduEup/vINZgNFXUsAlAIPE+OoW/Go7QIpvgcJZY2AWHkOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdGoEp7P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58BE1C4CEEB
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Jun 2025 16:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750955377;
	bh=IPHChg1Ve3JwMOc5Km7ntI957aUOLirjaa/qZQR581s=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=JdGoEp7PDl5CI1XKtwrGNOx5i1QT9rnB00u5mxsC566rfLakoj/2zRO+skIAwYoHH
	 oCZIBvCkeEihgcgNJxpd92r8MLHSKc/TSvH8nDJOFCZTvAa8Prjv9aHUUrmPHWTF0I
	 fOlPhumAscU9GFPJpvNotZDo7U6f/3fuwIm4IQReBr7bIGPUfQTaJtnfeE89zuHClo
	 /qzQdita7ft+rt+AZZN8xGJ/iTIYZJ+FU433rd+KVb+qaR+16e/guxSA3aR/2hOrFv
	 qNtpGG/eO1K5NxLfk9EnBgoEKMzSAbUHXlzwkO/NpDpdY9tPTUqSkj+WFf2KWMYzUZ
	 RoFZb3EgYx51g==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: qgroup: avoid memory allocation if qgroups are not enabled
Date: Thu, 26 Jun 2025 17:29:34 +0100
Message-ID: <bd2bcda4d19bc931752ffa7b1730c5e5fa9d7b48.1750955238.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <b0e317f51f01fd88c32fd14f6bd8ea40b88943fb.1750954008.git.fdmanana@suse.com>
References: <b0e317f51f01fd88c32fd14f6bd8ea40b88943fb.1750954008.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

At btrfs_qgroup_inherit() we allocate a qgroup record even if qgroups are
not enabled, which is unnecessary overhead and can result in subvolume
and snapshot creation to fail with -ENOMEM, as create_subvol() calls this
function.

Improve on this by making btrfs_qgroup_inherit() check if qgroups are
enabled earlier and return if they are not, avoiding the unnecessary
memory allocation and taking some locks.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

V2: Update changelog, the problem is at the ioctl level and not at
    snapshot creation during transaction commits.

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


