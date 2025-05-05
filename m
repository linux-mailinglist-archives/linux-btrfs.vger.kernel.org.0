Return-Path: <linux-btrfs+bounces-13700-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C96AAAC92
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 04:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B28C3BAEA7
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 02:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310CB39B0BD;
	Mon,  5 May 2025 23:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FObGaSly"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A39E38CEA2;
	Mon,  5 May 2025 23:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486856; cv=none; b=eqpoYu1WXw3r0iEVReFH6s6HulECtlUhi9TUCv/Bzkbd+3utdAmlhvZPeGw1X2+qUIecbanHbea7iu2bu2frR6Vlg/0ZiF5xRPhyN5cEeYb9kQttDCbifA/0h8qvj/6kep4uTx9fZCjcOmEmS2+U6r5hsY59QtZ7zS8DwIXX57c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486856; c=relaxed/simple;
	bh=iDwZBmRUijuu02xhBE00GufwrHvCF4PQRV+QDblSfrU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CL58ZJIjmL/EoUzWdciNiMj3wkXduN424T9/ctRrlPYK1vi6EZc1U7qFeghFs4kX1Gq2yKOcXKtBLa4UibrU0XBDbszXeDb8J4n16QxnLhjWWcgwHkHCJNmCTKwbqAdaZJ6U/JlkowjHp6hcnQ/2XeuxtdTV1dNGh7UZDqiw3KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FObGaSly; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4F9C4CEEF;
	Mon,  5 May 2025 23:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486856;
	bh=iDwZBmRUijuu02xhBE00GufwrHvCF4PQRV+QDblSfrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FObGaSlyfSwmld9ppuboJIVrE5DRLZ9o495RZIKxXTn9bTmZOlBTYS5w5hVhSrl3m
	 oulopy/OnwhocPo3boD5kfXI3O+Ht7d1fSzE4WZWHbhTzwY8VpSY8sxIiU3ZM/vk5u
	 Q97RZhSsSOHMML7uu6peyVV3WIJmHTa1FcY8KTRgC+Z7c0foySW4e4fv+T19NyNGiW
	 DDROEM4QFKxyc+Aoh/z68AkNGT68utM9ADsQ/LkZ+oHUej9qhp9S/u8YJGpQfWXQQa
	 +vstnj0ZZxP5p/Ui/C7WtuAZo1O33IOqC4cA7empvFLhbP3vLC7g7XZt09lQvtN8hD
	 B4pFZpvjhv9hA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 027/153] btrfs: send: return -ENAMETOOLONG when attempting a path that is too long
Date: Mon,  5 May 2025 19:11:14 -0400
Message-Id: <20250505231320.2695319-27-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
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
index 577980b33aeb7..a46076788bd7e 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -400,10 +400,8 @@ static int fs_path_ensure_buf(struct fs_path *p, int len)
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


