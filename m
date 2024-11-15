Return-Path: <linux-btrfs+bounces-9729-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8149CF0BB
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 16:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D2FB28B606
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 15:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100AA1D5AA7;
	Fri, 15 Nov 2024 15:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLupoSiP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B011D516F
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 15:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731685963; cv=none; b=aan9YB65T9Cvkq5qqJpQR+4aGAaHwAFMy/xHsjtO/sY0tE+iuehqtlKIgtRlHpXvTZwghCUltpa/6v83AAmw2WaHTcjhklZW4dswKapSVZpXFy1345y0pQL8UislBQ1kjw3UPbShEfNY1RtNEuL/NjN1LSDZc21Vb/99EqGNOHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731685963; c=relaxed/simple;
	bh=sevheC8pnOmSZBVl4QStrgjvKkTvWW9U7/z1M5Z52yk=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=DQ6rwPAeV5AJFuT3atkNmNPwqsoRe92Ks8DeF1ECvQVOsvE+f6qNE/k09XKL2axVDpI2NLi31qlk7PjF7F2SVfFbm7i46Qyiop3ljucNRmGDb8SiVx+/BZzTwW379266uP+MGhFHjAywdIVHp0866D6CJ2jJA1s5tBGlLxiwSWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vLupoSiP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B189FC4CEE6
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 15:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731685962;
	bh=sevheC8pnOmSZBVl4QStrgjvKkTvWW9U7/z1M5Z52yk=;
	h=From:To:Subject:Date:From;
	b=vLupoSiPHHwi8rUFDt0UqQ0II/FVTBM+DIehY5TnY8lFMtm6Am7DrL50qCe2WUnj1
	 xxARN0RqHOV6oruSSQCjiYRBc0+NN2AgWphkR6aOC2SohlVaNDvSM0N6AI7HUljPt1
	 XYLYwZmB/l+g7E9gzCnKBfvAA5QSBxskC+wAlWHOB9kSH/bk2Rena0jbwQxTtpH/WZ
	 BkBmEmOiiYO9GSejNxZqxuMIzhAG/OhwAbouKXStBDXZkwBGfoVXSBazuaRy8Thbc3
	 ShOG3EFw4XkiedrYb6Sy5nGC9q8QJ8ZZDWC9dsRsrJcGHViwRpL7frPs2jvF8q4tyn
	 8Q9ZmhHDauqFw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: dont loop for nowait writes when checking for cross references
Date: Fri, 15 Nov 2024 15:52:38 +0000
Message-Id: <82b293d9026f9ff3670a4c0ea4df9bf4afa8f4d2.1731685895.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

When checking for delayed refs when verifying if there are cross
references for a data extent, we stop if the path has nowait set and we
can't try lock the delayed ref head's mutex, returning -EAGAIN with the
goal of making a write fallback to a blocking context. However we ignore
the -EAGAIN at btrfs_cross_ref_exist() when check_delayed_ref() returns
it, and keep looping instead of immediately returning the -EGAIN to the
caller.

Fix this by not looping if we get -EAGAIN and we have a nowait path.

Fixes: 26ce91144631 ("btrfs: make can_nocow_extent nowait compatible")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 412e318e4a22..bd09dd3ad1a0 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2422,7 +2422,7 @@ int btrfs_cross_ref_exist(struct btrfs_root *root, u64 objectid, u64 offset,
 			goto out;
 
 		ret = check_delayed_ref(root, path, objectid, offset, bytenr);
-	} while (ret == -EAGAIN);
+	} while (ret == -EAGAIN && !path->nowait);
 
 out:
 	btrfs_release_path(path);
-- 
2.45.2


