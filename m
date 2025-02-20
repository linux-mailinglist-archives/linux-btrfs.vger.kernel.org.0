Return-Path: <linux-btrfs+bounces-11643-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1079AA3D7AF
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 12:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD45C3B5289
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 11:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BFA1F2388;
	Thu, 20 Feb 2025 11:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2qUcMG4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AB81F2382
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 11:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740049496; cv=none; b=HWWHh3p/NOvR+MX003dCtZMK1LVJ29GiLG0Ic6Dc9ph/K1pkeASSGn9r72VJ0a6EEhYhJKuMrW/nd68EG5Inr4zF5esjvh/9v15IF4rY/fZuZ+kaIXWSKnIlVy8RtGz10iTRgpnUqD8tGitW5UN75uOVsv7Xdo/E2b0prRMA5/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740049496; c=relaxed/simple;
	bh=jyxzL+aBLpb/hFzx7tyDyKjp6IkA5CQDpEEkFLuAiaw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MWWAR0bYJhYmJFSfyIp5q2ybTwpXSdkzaHQM5w04atvgasIyiiM1qYT0AHiXPeB0h6zINZI71Mdx/1L8sUZtOvZGseMVnXWZhzLkJuSBkmQ447qEHdC40boZ5sLLBCtqwwmlJu/f2zV9PaTZN4AGqw5MTPknBcWyOd4CfTjFtyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2qUcMG4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44916C4CEDD
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 11:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740049495;
	bh=jyxzL+aBLpb/hFzx7tyDyKjp6IkA5CQDpEEkFLuAiaw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=G2qUcMG4Rpy3HbXOld58ySMgpAyEbAoV8ELgomAht8lnQ8cYTCa7xw/H/1hTXC0Fm
	 WFqAR+zf41Iahjxml2bESUYy1PZb9MIN+Oxde56Qt7jW/+RZBWroqHjnWT5P6oK8yp
	 3bLgY9r0DNC1Mdg6HS4pg5XxX5T+IbumTN/6om4ovSu2HP+VgQHjTzkGZxkHLeOxrA
	 gJi54bfaMpFlgdBjjS6AUfS03VUFSQgzyOoVaCF6KpW3MRA/23yqON3CM8hkXsT/fA
	 ATrBR8WSQKdeK+cIbmZ+V9wCFSGaQ6xfpIvQ61MvJG0/rLLv9a/oc0ooz+7TYfZtZh
	 rEfNU40nvF8RQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 08/30] btrfs: send: return -ENAMETOOLONG when attempting a path that is too long
Date: Thu, 20 Feb 2025 11:04:21 +0000
Message-Id: <fabc811ebc87ae9b258bbabebf5879642940203d.1740049233.git.fdmanana@suse.com>
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

When attempting to build a too long path we are currently returning
-ENOMEM, which is very odd and misleading. So update fs_path_ensure_buf()
to return -ENAMETOOLONG instead. Also, while at it, move the WARN_ON()
into the if statement's expression, as it makes it clear what is being
tested and also has the effect of adding 'unlikely' to the statement,
which allows the compiler to generate better code as this condition is
never expected to happen.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index b9de1ab94367..dcc1cf7d1dbd 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -484,10 +484,8 @@ static int fs_path_ensure_buf(struct fs_path *p, int len)
 	if (p->buf_len >= len)
 		return 0;
 
-	if (len > PATH_MAX) {
-		WARN_ON(1);
-		return -ENOMEM;
-	}
+	if (WARN_ON(len > PATH_MAX))
+		return -ENAMETOOLONG;
 
 	path_len = fs_path_len(p);
 	old_buf_len = p->buf_len;
-- 
2.45.2


