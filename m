Return-Path: <linux-btrfs+bounces-11642-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A713A3D7B5
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 12:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26E4E17D854
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 11:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB3E1EBFE0;
	Thu, 20 Feb 2025 11:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adFM72Qk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20311F2382
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 11:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740049495; cv=none; b=t2MHD0U1A3mdPKqWalsYt/ZiV1ytMLRNWzeAS/piPJLCrUX2layBPOmvI6UspBn9JNrsxhMCZ/pwRnq1zZmOVIhCr35ifjtL1HOcm/bJfbBpH76UQMqVu5n9enN+RtpXyq1RdCTUhOIsa1VIegR/IhcD7aGiTd66ZSRCdZL8+vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740049495; c=relaxed/simple;
	bh=TU4XK2ZNfLY7/Ncb2aX2uSF786rE++vnCm1jmieZQ44=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yj/OlCH2wTtfsZS4dWnFsPLAQ9I72A2QZZteJRyyclb+mghJntlc4yuMQCg1N8CBsX1723Ej7RgnIP6+5gR0IKH7mB9veCghirDIY31UShiBZlmneiLeCYFhoq6XC7n0i9cDjIRdwlBy8ol2Qq+Qjabxau5se5FXWmrFdFkahwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adFM72Qk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D3E0C4CEDD
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 11:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740049494;
	bh=TU4XK2ZNfLY7/Ncb2aX2uSF786rE++vnCm1jmieZQ44=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=adFM72Qk1BR9hyN+RB8OOrpj77dztniRZeXif5HewcX6VzGJkjKRn9siSPSblbB7o
	 66Lj0V25GoADUd8kvZ7TlYtJPaA3vB8kspQg3lJNI7HYxTacGVfUEEiAuUD+n6bEaq
	 4TGbWpXboAp7r/MWUvrzu7OQpFmnOQ6vEDNptxwd6i6nLzIW62FpX5jv7iFvZl+X05
	 TF7AQIa+n4SWJsef4UCkgKWYZftrmQuzhk0VPGDADDXsyCqX4xhlj0I/6OaTNeT9El
	 vEn6QVJ/WY8C/mYksSE6Vc7Fns7nTXpXCO0u0tmRdD/pxAVodqEoYntYrFifgadKcY
	 mdTPSoBzNzSNw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 07/30] btrfs: send: simplify return logic from fs_path_add_from_extent_buffer()
Date: Thu, 20 Feb 2025 11:04:20 +0000
Message-Id: <5138a07e83870cb29bb09a340f7ec7abe7eb7d78.1740049233.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1740049233.git.fdmanana@suse.com>
References: <cover.1740049233.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There is no need to have an 'out' label and jump into it since there are
no resource cleanups to perform (release locks, free memory, etc), so
make this simpler by removing the label and goto and instead return
directly.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 7a75f1d963f9..b9de1ab94367 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -580,12 +580,11 @@ static int fs_path_add_from_extent_buffer(struct fs_path *p,
 
 	ret = fs_path_prepare_for_add(p, len, &prepared);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	read_extent_buffer(eb, prepared, off, len);
 
-out:
-	return ret;
+	return 0;
 }
 
 static int fs_path_copy(struct fs_path *p, struct fs_path *from)
-- 
2.45.2


