Return-Path: <linux-btrfs+bounces-13705-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EC3AAB2FD
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 06:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6C573AAF1C
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 04:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AE13703CB;
	Tue,  6 May 2025 00:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7C//cyl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F76280A22;
	Mon,  5 May 2025 22:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485888; cv=none; b=SF+FGfbBU4GqZerWnJ3Lp1f9XS8W25rMfiwRBW387Jkt/U0bC3DFo3eQ9YSWd6Da+WNMDU/zcMRCzX3btUTNvhm353ElKrhKlWfe9d7IA0H4G1RnpDwx5goSl9rruw0/acj3JfHlKPO9jJVEeEtEN9jo+6aKNGYwp6QsAIZQafY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485888; c=relaxed/simple;
	bh=o6c5QcpxJdFwSOi4BUO2WlfrwA2X2QhZ89EvFtu3CGE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KAL92huoVbMV3wiZ55AechUSuKagaZkoEtkMIud587Y7TCI/ZRfiVajBu28hfLiVsOF3GaZ5CeD9pkVbz52+DFblvgNCw6GEaUyDnGrl51hXeBjISA9ATSmsQVcmbH+i+M2Pjnkg8UWxr6m72laY1Hc6qrBJP5VkOvmGjQskGpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7C//cyl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC4BFC4CEED;
	Mon,  5 May 2025 22:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485887;
	bh=o6c5QcpxJdFwSOi4BUO2WlfrwA2X2QhZ89EvFtu3CGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E7C//cylFwMI95T+Yh/+H8vubPbqiv7J4MWa/gJlj2awtWohU7VfCGamd1wSOGtKm
	 n1mxlaYF54kz5AipT8+1Dai4GATkUTA6rUd/cSt+tnMRxeuM228XlMlQv1SW08SJCN
	 Z5PIVZv8Dt7my7AN3TVY9R8TtGTmFRMrKHaV8w1DBoCYFlk+WznA6Esh2aH9AVmw8t
	 qYiVx03jO/EPE9EFbnLP4bG3DtmViw4gyDvwFr/0AYWpkdFHJo7vGXRGhdX7v5UwIa
	 DgAL9DE4UwnDlINcafg4WukxtRbHFRk/BL8NAXx/rJ5wl59ZPEJ6SmVwHtLylGNpu/
	 CJ3xJBK6sM5nQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 049/294] btrfs: send: return -ENAMETOOLONG when attempting a path that is too long
Date: Mon,  5 May 2025 18:52:29 -0400
Message-Id: <20250505225634.2688578-49-sashal@kernel.org>
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
index aa1e6d88a72c7..e2ead36e5be42 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -487,10 +487,8 @@ static int fs_path_ensure_buf(struct fs_path *p, int len)
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


