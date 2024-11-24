Return-Path: <linux-btrfs+bounces-9862-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A069D6E8F
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Nov 2024 13:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D32228165A
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Nov 2024 12:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A2E1D0E20;
	Sun, 24 Nov 2024 12:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbJc9ULe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DFD1D45F2;
	Sun, 24 Nov 2024 12:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452072; cv=none; b=K5BO5bPxAgGYotvEHYrePevDeScbYjVQhdYiHGYSGtUfg6C1VqBhgluBo5ys0EbIAyuG1/p6iNPslchCm+SRaGya4VAMBJRg5kB5ddamLxU5k3EuCnPwhxsO3TEkdXAu5S3y2TTEV87b5ctP5oY9mgpQg/7yNOuR27egJ1Vf68M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452072; c=relaxed/simple;
	bh=uok4ghp398S79+9MqyPXP44TJ3hnfkhHdbt0KqGPXyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bLLZM5POpncFG2U78aMlmebPTOI0qtAt3Ggqln+cCT+XQvzlOmed1OhjXrt3kXUEkdi6B1DkFvnA/gFhnWZNKd+srcrYkydF3DCgIoRAkasekfDyhaBj4P2Behzv27L2JI0/xsZnCdJCMjZ3w4+oARqmQPxY8s8XwBom9ICkijY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbJc9ULe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E633C4CED1;
	Sun, 24 Nov 2024 12:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452072;
	bh=uok4ghp398S79+9MqyPXP44TJ3hnfkhHdbt0KqGPXyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RbJc9ULe5sqnHUs4Sd4jp90bEOGRQaYwsNTPrNYurqWfje/4e7I7HP2/GwRc8Qein
	 VyZZNIFS02O7bnVKPKrvxZz8AJimXnyiNB7PDCf0FIfCTXJeAzKWPAftE+0i9KGdtA
	 0/7FGKa2d1IeeSn73C+2uoTLdLvZWN1VCTUtkwBhceYIrvwKYOK82wLEM6QgOrEIuB
	 t//fNvPvD/A38aHSjJJGwWUGygrzo1RG7b1TSPcpviOcO7Tsd2W0H9p0oRDp/ryrhf
	 uBEv/qiNzN5GBxzU5JEig/JeZc8c+ykCsOIu51hmSA479UGCeQ95XSdSVcdrfhRJHG
	 vA2yMRUZtHdQg==
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
Subject: [PATCH AUTOSEL 6.6 7/9] btrfs: fix warning on PTR_ERR() against NULL device at btrfs_control_ioctl()
Date: Sun, 24 Nov 2024 07:40:45 -0500
Message-ID: <20241124124057.3336453-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124124057.3336453-1-sashal@kernel.org>
References: <20241124124057.3336453-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
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
index e33587a814098..4c98eb5230184 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2216,7 +2216,10 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
 		device = btrfs_scan_one_device(vol->name, BLK_OPEN_READ);
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


