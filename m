Return-Path: <linux-btrfs+bounces-9869-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE239D6EC1
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Nov 2024 13:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D312A280BE5
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Nov 2024 12:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1D81DFD81;
	Sun, 24 Nov 2024 12:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPYfBpXD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8AC1DF961;
	Sun, 24 Nov 2024 12:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452135; cv=none; b=udzAL6v7NYxFqrctIvSauqW2CClm8o+x8WHHfTb84r7rJn2kcY3oFnOHxgf0+2PSNLoSMeI4XDQcozmAJYWQLDG+s2Pn5YnR5mqvaqXUWZ5U7mPXHLUl3zprSQEkNX28QtzHvgOPMDHG5jnvJqSMw1f9sbAWgyimCmlDtI5bH7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452135; c=relaxed/simple;
	bh=wQ+vV9+r0GA04N4cnRt5JvKV8b5DK370VKu85jWBr6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BfpME5ov2IbFW2gRpbX7lX1Ic79XDRcNNqhOY70atd+4D0FA31uTIAmrvOBfzE0QFK60jrjmw6qTOcqbjf1hLvs8SXjAcMCVuqGMMhECMdJb/yBilQv9rahv1sE6++GZ/PTG1/er18iPhmoUOTYgAQ+/SL3WGVz35yxkNGU+c90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPYfBpXD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B254FC4CECC;
	Sun, 24 Nov 2024 12:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452135;
	bh=wQ+vV9+r0GA04N4cnRt5JvKV8b5DK370VKu85jWBr6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oPYfBpXDQEH3y5iAk6PoFS6eY49Ft3HCX4TmaHdEoudlT7tYkLaFta2YXX9ploh5a
	 zCkrMH0TI+7RtpoUjYfSFhE7LgJA/wr87zB4OXP97vf8MvW9cd/AgLWa5LXx/ZMCBZ
	 capJ3YYO96D3u3EAiSlwSI4EykOW/NjGqD6BYubLET6/tGgG2nYnCL54pz3pNrCyWY
	 82mH4nzP1jX2z5LSJRO2fqAvsMmJF9GuhJRU0R39hxA4VV08AawixdCVR1ZacwiHk0
	 J96N9z2UG5IZOfUWWJhbGSpMlv8ggVlLilt2/XwYNahxvkG7iZR4YOI4X+TT/V0pT6
	 08PX6WimMqGVg==
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
Subject: [PATCH AUTOSEL 5.10 3/5] btrfs: fix warning on PTR_ERR() against NULL device at btrfs_control_ioctl()
Date: Sun, 24 Nov 2024 07:42:02 -0500
Message-ID: <20241124124210.3337020-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124124210.3337020-1-sashal@kernel.org>
References: <20241124124210.3337020-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.230
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
index ea731fa8bd350..fc6ace10995c4 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2359,7 +2359,10 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
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


