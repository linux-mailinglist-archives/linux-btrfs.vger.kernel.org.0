Return-Path: <linux-btrfs+bounces-9867-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B25CF9D6EB1
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Nov 2024 13:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64758281455
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Nov 2024 12:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDF11DDC38;
	Sun, 24 Nov 2024 12:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JlbUFGJC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0623B1DD55A;
	Sun, 24 Nov 2024 12:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452119; cv=none; b=MB7LFE70db7iMobujqZWjf3b0h8V1D+nCLrUDnGos5dBlNavvt8ytCo4opkMM5UzZ+f0TRUqWs57Kj+/Pz6bTWUGS+iH50Q4oLVZ5tN24SYjC8abjsyH5ZWIPDO3GlojG/VHoD9ixgQwLjBCY5Bybu72O2pmVPK/CDNEmFk1LTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452119; c=relaxed/simple;
	bh=dckKMj4lsXggRn9A4UzCXQHmC8RYb7/+0cA4yJOM3GQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UxckJjC/0VMUEt/Vqrw6OOXsQwjd5STcayklXq+qLKKsuH52Vf5JHAoT9DU8GaW8bqH9nojcdawGulvwQNDSNDS6aUF7MONcHdXMR2FmC/PieIGtJ5bU9vnP1D5SJskFv1yFaPEfiR3myoiU0qbjBQ7KCvP+k2sVf7oa33OAh08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JlbUFGJC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C24CC4CED6;
	Sun, 24 Nov 2024 12:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452118;
	bh=dckKMj4lsXggRn9A4UzCXQHmC8RYb7/+0cA4yJOM3GQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JlbUFGJC/Gnb/aKSMXnHCZiOkQ689v6JF42iigYPpaoGtq4EZj3zMc6Bt+IWNO4ll
	 m70PSoiQCXJUfwM6L9eUStVHnJeoJVDqm6OsUZZG+/AhcLGiP/t1pjrBoXpVqPFENn
	 r5+b0yaluWqWaILTAMk2C57fuU7pHVBHlPnjjKqIYkj/x0ljUbt4p0uwSVo9bSA07j
	 In5BS1lDR/79gmUEWFucQvF7WkH71a0w+7V/6MnLvsW6S6EsxW1Tlc7/CC4ju9WJ9J
	 KaYe0PKrfm0g8IvExJaudpV7y3NM1Pif42aDMXS6gpD8WetW4+NVCfaXBLRWBE4ERU
	 rLXdTuLnvP0ww==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 4/6] btrfs: fix warning on PTR_ERR() against NULL device at btrfs_control_ioctl()
Date: Sun, 24 Nov 2024 07:41:40 -0500
Message-ID: <20241124124149.3336868-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124124149.3336868-1-sashal@kernel.org>
References: <20241124124149.3336868-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.173
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 2342d6595b608eec94187a17dc112dd4c2a812fa ]

Smatch complains about calling PTR_ERR() against a NULL pointer:

  fs/btrfs/super.c:2272 btrfs_control_ioctl() warn: passing zero to 'PTR_ERR'

Fix this by calling PTR_ERR() against the device pointer only if it
contains an error.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/super.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 2fd0ee0e6e931..c3c50fecfde32 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2456,7 +2456,10 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
 					       &btrfs_root_fs_type);
 		if (IS_ERR(device)) {
 			mutex_unlock(&uuid_mutex);
-			ret = PTR_ERR(device);
+			if (IS_ERR(device))
+				ret = PTR_ERR(device);
+			else
+				ret = 0;
 			break;
 		}
 		ret = !(device->fs_devices->num_devices ==
-- 
2.43.0


