Return-Path: <linux-btrfs+bounces-13711-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0998BAAB5C1
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 07:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E727E7B4D1D
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 05:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE614ABD2B;
	Tue,  6 May 2025 00:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJGYPYmY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125CA28B7ED;
	Mon,  5 May 2025 23:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487339; cv=none; b=azj5CWt9C1k/j0sS4Q6UZ/2MfBvVH86DAILfNx8tFKObmefWDgsMKqQ3nGhBLRn1Xv8WzcG7pVtYEb0dxQsRg8ZIQRGXF5SOk/ll5Lb5p2rU/VXOxAuYXRwOIXljv1AdNuIQigwYneB0Lu0mWQ3UiO+eEeJNFVVvzSKdxv0pU34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487339; c=relaxed/simple;
	bh=UUwk0fwNUMK4vYKeCf76foxPIDzIqqMebaWL0aejZsI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fb/IULQtkaphyYQCqZ7BMUvLcxkDO6sFeHUOBEunZ1h15p4Q0JZjvSMqFVpNJ8H940zmbh40eAG9ht25hQN9lukm8q5udY8+sUKlsFMOBkI2c50pJJi7T+3ZTCbi+MVab0D3+1cFuWyyzrBWo4i9txsPh200OxwE97xfLobWrmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJGYPYmY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CDB2C4CEEE;
	Mon,  5 May 2025 23:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487337;
	bh=UUwk0fwNUMK4vYKeCf76foxPIDzIqqMebaWL0aejZsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GJGYPYmYZpKfK/aWgjk5HmibFxEz/+VXnz85uwZxm2VTVZj/seZdt1gDMI5+dIpEm
	 CZ7Umyrit/JVWD5RR442zoDX/uHEaJp/2fDWSw41YUEdaU+pOV5UZQTL2QF731ywW8
	 /Y2yy+0Zyr6B1qSbIRd1VwV5bVY2ZnxT79/0+KsVbqqvGR6FJd1kfNCFUhSbQo5Is/
	 AEvHZEFp07iyBfxJuuW1WOtKf4dtFw7fi0HE2m+AU8Ux8u6zNqjTHlStf0NUS0X/yC
	 ycBNjRyVaJIjSANhvedTrrKx4MWRajEZJCF7k7iOw02Zt+5p7J1zqdbM8S1W0AzPlG
	 HtYtPbEgF2Wxg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 15/79] btrfs: send: return -ENAMETOOLONG when attempting a path that is too long
Date: Mon,  5 May 2025 19:20:47 -0400
Message-Id: <20250505232151.2698893-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505232151.2698893-1-sashal@kernel.org>
References: <20250505232151.2698893-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.293
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit a77749b3e21813566cea050bbb3414ae74562eba ]

When attempting to build a too long path we are currently returning
-ENOMEM, which is very odd and misleading. So update fs_path_ensure_buf()
to return -ENAMETOOLONG instead. Also, while at it, move the WARN_ON()
into the if statement's expression, as it makes it clear what is being
tested and also has the effect of adding 'unlikely' to the statement,
which allows the compiler to generate better code as this condition is
never expected to happen.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/send.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index e1063ef3dece5..b0933d9525939 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -397,10 +397,8 @@ static int fs_path_ensure_buf(struct fs_path *p, int len)
 	if (p->buf_len >= len)
 		return 0;
 
-	if (len > PATH_MAX) {
-		WARN_ON(1);
-		return -ENOMEM;
-	}
+	if (WARN_ON(len > PATH_MAX))
+		return -ENAMETOOLONG;
 
 	path_len = p->end - p->start;
 	old_buf_len = p->buf_len;
-- 
2.39.5


