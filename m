Return-Path: <linux-btrfs+bounces-5793-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01ACA90D704
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2024 17:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 029F31C24AFB
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2024 15:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094BB46522;
	Tue, 18 Jun 2024 15:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNEjepbg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330513F8E4
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2024 15:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718723683; cv=none; b=hnLx+CA/J6N+fTzG/VKmDVY9jzjU20Wpe4NIPHIxD9v9zP3U+SvlM8Uu09I/j88TmpvMgkSN2oLbYeht4dpbJYR0dUu+Wv0FEJ8ynGcwk7nG/Q44j4Iklw9ggSFyU2pDgpBgqIT8MI0CgzINyQkd4jd3IwgteeEaxwQFpC6hpO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718723683; c=relaxed/simple;
	bh=WVP7STDYye0caFOln2uX+hBhFY9537nvKzmB0srZRF8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WIIPEGz6T0DgM4ckgGd4aqmGFu7m+NKFWMsoI/jwxgMzma96FIQr9Z4f5IyJzy4E4hCRy8a/eqf3hHzfITscKRUBL6QWUrbA1/W8KXeq/2pb+D01D7NWewx30PCj5itKwXKyfvhqD+OsTv9irACj00iLcYJCvnlNOmG8xd0Wd+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNEjepbg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B2FFC4AF1D
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2024 15:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718723682;
	bh=WVP7STDYye0caFOln2uX+hBhFY9537nvKzmB0srZRF8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=GNEjepbgW/8TqjKTiUtvvcNP674Uwewrck9PxmPdA4+Bp7UZmysscYcOlRG2DRU/k
	 QfDDKAWSdTgfnFNB1VvH/MU1IN8ck6MgDCT/J2ammo9gi5rlQfxZcgKFDgajj0ReL/
	 EOi795Ci+nO+eNQibXK0o9zfy/t+XpyJKO9NVfGP8EK3hSP8mJOFGaRYLy1gvi6pg/
	 xxGgahv+NQ0jpXe1a2CW3WtghFyRlGlf+NJj7ZgO/rOxuyzhP7TcWSjMAWjcbJLGP2
	 kwF6f0Jb4fItigqPAPGPYY+0j2bDrubv5B/4yRbZqoQBU2rqis2lGdHME5TiQPSFcj
	 B/0NRorKA4C+A==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: simplify setting the full backref flag at update_ref_for_cow()
Date: Tue, 18 Jun 2024 16:14:37 +0100
Message-Id: <989cfd93dc17f4b3d6348c6ff13393b67d2d3b83.1718723053.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718723053.git.fdmanana@suse.com>
References: <cover.1718723053.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We keep a "new_flags" variable only to keep track if we need to update the
metadata extent's flags, and when we set BTRFS_BLOCK_FLAG_FULL_BACKREF in
the variable, we do it in an inner scope. Then check in an outer scope
if the variable is not 0 and if so call btrfs_set_disk_extent_flags().
The variable isn't used for anything else. This is somewhat confusing, so
to make it more straightforward update the extent's flags where we are
currently updating "new_flags" and remove the variable.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 763b9a1da428..7b2f1de845e7 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -417,7 +417,6 @@ static noinline int update_ref_for_cow(struct btrfs_trans_handle *trans,
 	u64 refs;
 	u64 owner;
 	u64 flags;
-	u64 new_flags = 0;
 	int ret;
 
 	/*
@@ -481,7 +480,10 @@ static noinline int update_ref_for_cow(struct btrfs_trans_handle *trans,
 				if (ret)
 					return ret;
 			}
-			new_flags |= BTRFS_BLOCK_FLAG_FULL_BACKREF;
+			ret = btrfs_set_disk_extent_flags(trans, buf,
+						  BTRFS_BLOCK_FLAG_FULL_BACKREF);
+			if (ret)
+				return ret;
 		} else {
 
 			if (btrfs_root_id(root) == BTRFS_TREE_RELOC_OBJECTID)
@@ -491,11 +493,6 @@ static noinline int update_ref_for_cow(struct btrfs_trans_handle *trans,
 			if (ret)
 				return ret;
 		}
-		if (new_flags != 0) {
-			ret = btrfs_set_disk_extent_flags(trans, buf, new_flags);
-			if (ret)
-				return ret;
-		}
 	} else {
 		if (flags & BTRFS_BLOCK_FLAG_FULL_BACKREF) {
 			if (btrfs_root_id(root) == BTRFS_TREE_RELOC_OBJECTID)
-- 
2.43.0


