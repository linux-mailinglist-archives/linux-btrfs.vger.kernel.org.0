Return-Path: <linux-btrfs+bounces-13689-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E124AAA93D
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 03:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B77043BBFA6
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 01:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78058359626;
	Mon,  5 May 2025 22:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UN4ror8P"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0870527D795;
	Mon,  5 May 2025 22:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484924; cv=none; b=gAd3jzdsC4nb3goOzOZwVEo9AJbxbWs4OqCrZoRoBmIgnJ3Fa8xOwlyc5P0PzFQVPsOHWKUQ5FlDKelND4GObGyY4saOsu19rxTNU5nylmqBTzAZztvB80vcpRrnxvncbuUPQS61DUSv0R383uK+rSRtV097p/r1KqXtm9Uvwok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484924; c=relaxed/simple;
	bh=UUCnRpopfKDAiDjdI3Kod28pbXWm8cIO/K+X6MgCoVI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iV6l29ciE9m7q0FPBjCpSfDlL+dOkixIrFd0Lqc1btBCOuLbwZxkzGzFUuo0PQ1qI7HD8cSEgHafC/b9FKMBIMaoC613O7jKYOFrYfgwdIeXcM9uKnMdWCdV1Y5PCsXFCdcYRyGllfl2zUgkbl9i9vP5dEXV7T00D3zPw/ESW7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UN4ror8P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A8EC4CEEF;
	Mon,  5 May 2025 22:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484923;
	bh=UUCnRpopfKDAiDjdI3Kod28pbXWm8cIO/K+X6MgCoVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UN4ror8PjpjlQAlg5OYyk/JSIqMwqmkWepNpfhf+AyCKfyAw05+82xq4jEhSKV+ee
	 VS9o55i+6sFRa3z1tOTmLuku8ha25Gif36uM/jxkfu6z5BRLi4cxl1s30mPxja4OnZ
	 YTto96tHAxcZADHZuxj6XLS/zY4eGJpamZNC+dVmnKW4HIx9rCUyVKZCX+1QKfF6H2
	 bptxOyLyS8W0bu9Uq+3n6vnHGVdPC27IZkyfenB4B12/zSKJWuwkijR07b8JD4zjgS
	 eLsgagb/6jIR9RLmKB7vi+y1bkjyNIW5wZXNjROddX+iYD+YgSnOU7SlVrZ+iEjSlm
	 mTt/VjXOxE+aQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 079/486] btrfs: send: return -ENAMETOOLONG when attempting a path that is too long
Date: Mon,  5 May 2025 18:32:35 -0400
Message-Id: <20250505223922.2682012-79-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index b1015f383f75e..c843b4aefb8ac 100644
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


