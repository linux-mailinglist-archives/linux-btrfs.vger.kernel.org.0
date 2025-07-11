Return-Path: <linux-btrfs+bounces-15454-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D04B0161D
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 10:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4EAD5A62CF
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 08:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E490221D80;
	Fri, 11 Jul 2025 08:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byR929Dt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632A720B1F4
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Jul 2025 08:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752222612; cv=none; b=UJBw8Lj3T2jBIesmpt1jWGST6JF4y/7nxVrZrR6BzgkF6rKWaJlo9P6QWDneJ4AYin9dgvssdf6WvHzNF6aINhiDXv9X/uslROdI1PMfy6q6CHh3cjSL/0oicejL480yhRker53dTc4SQ9p8/w9tUGinCAXZxtEZVGj8LDsQ83Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752222612; c=relaxed/simple;
	bh=CzmL799Oji9xAxw4EikdeV7pqayDD//VlbkYhaBingE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=K7OMS51/3ih3bNVnRWSzpbK2a5mPcPnIlJIr5ansgQCp6i+cLySrOq5V7YYELhoUWUKR7e62N3GKVpBaE1KXOeI40Wric5x/XKI4jMQs6ADtUMSOak3psNXYu1qMGGAaB2KNwAL2w4CcBJSgT3T0un/vezkBzst1V0tUTPBhQqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byR929Dt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B23C4CEF8
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Jul 2025 08:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752222611;
	bh=CzmL799Oji9xAxw4EikdeV7pqayDD//VlbkYhaBingE=;
	h=From:To:Subject:Date:From;
	b=byR929DtW8GAMggXKXTCDAlUgFpDzUu4KXxD0AClSDnSFcyHLum6SVj25+g2SRyQJ
	 30RH0PiBw/YSI7rl7mi9h6+e0tT/UXkgl5mZXg5hA08MptU2Cgl0tsdPRGu5Aomezd
	 F4XgOB9eKYbBVUO0Bo8KeGU27Rr4a6Z+FiBiERU68vzJSkd2t62gVHaEWjrEufE1cx
	 7IufmCYZjYHb5r/cFqHE7bWG97rcnd/Ohn/NMfPzxnKXnqytpENnnuw89/UI0l3KKI
	 JCL0zaWQwjxMkMk832+wRmX0tY5kUBuES0yx01sTbfN8rNCtnd1Z07wdJECrle0beY
	 m3BqvSVlafmFA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: use cached state when falling back from NOCoW write to CoW write
Date: Fri, 11 Jul 2025 09:30:08 +0100
Message-ID: <db0dd3c800bc997511aa800e0b90616ca7b8b4b5.1752222571.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We have a cached extent state record from the previous extent locking so
we can use when setting the EXTENT_NORESERVE in the range, allowing the
operation to be faster if the extent io tree is relatively large.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6aa1e66448fa..6781956197c7 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1754,7 +1754,8 @@ static int fallback_to_cow(struct btrfs_inode *inode,
 		spin_unlock(&sinfo->lock);
 
 		if (count > 0)
-			btrfs_clear_extent_bits(io_tree, start, end, EXTENT_NORESERVE);
+			btrfs_clear_extent_bit(io_tree, start, end, EXTENT_NORESERVE,
+					       &cached_state);
 	}
 	btrfs_unlock_extent(io_tree, start, end, &cached_state);
 
-- 
2.47.2


