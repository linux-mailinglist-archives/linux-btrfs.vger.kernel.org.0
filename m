Return-Path: <linux-btrfs+bounces-13699-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD96AAABD9
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 04:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4FF2189E8FF
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 01:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7B93B6B85;
	Mon,  5 May 2025 23:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FL+oWcAa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6942E3984DF;
	Mon,  5 May 2025 23:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486456; cv=none; b=sRjfhkGs3Ne6PowUZvPkpQhZ6JqLZ8C21EIFP7d9UmZq2dcLnm5KZPtEkBrmLXWA0G1+sSp2EXBUW7pwIT+ZPT0BCulawioHNeyx03vhViLC1RY3uB6TsUHT+UE0LsSK+5SB0nd5rEfJrlUMe3HZlmaM/AY9N0Iy15aW1/LQefU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486456; c=relaxed/simple;
	bh=idPMsXuAaURvKKk6NK1CLrejhMsIsGmNPtLU7OMiKrg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OoRvvcQtwc58PS1Anf9n3USU9eenzl2XrCs8JIAxJ6CJnjE/R89m12902uDCuCneKavzBrcB7rFXunrc4NGSkzECzPhejQni/8Wwc+IwfDNMIeV6uw8CgdwmK1lDqsEftflrFT6REdjdcWG33pvkfiecXd9S6vj24ELPyXXwFEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FL+oWcAa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D52C4CEEF;
	Mon,  5 May 2025 23:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486454;
	bh=idPMsXuAaURvKKk6NK1CLrejhMsIsGmNPtLU7OMiKrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FL+oWcAaASCk5j/JHn2NU6LrwXv5UO29A5Vkr7gODgyzWr7f7qd0teBaZ2PqODbwl
	 iJijLKkBtOuIVd98SxtakIDZbUdVXvSnza8cf21WqXIIVM0CPL5fxQxAuxxvLaJVUs
	 nKfpJOwtc/t0jSN8P2AHZqVdxcn/DiO03EBC7kwGBNAAuWvvwwy8S8UDRUMCgWoBwA
	 It55SFG1qZXQr/cGJE1yEFc06vdmNwi7OKppuzaproDHhwgsS/8P9paBRQMSQ2EPjo
	 QGJEKAriGjXQf/dWmCDTjhu77bXIfoAP1i40dZaxHQsF0062ONg+Qb2J5Hv1Lys+WX
	 gVQfXA/AhfHpg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 039/212] btrfs: send: return -ENAMETOOLONG when attempting a path that is too long
Date: Mon,  5 May 2025 19:03:31 -0400
Message-Id: <20250505230624.2692522-39-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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
index a2b95ccb4cf5c..0735decec99b1 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -431,10 +431,8 @@ static int fs_path_ensure_buf(struct fs_path *p, int len)
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


