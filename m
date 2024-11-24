Return-Path: <linux-btrfs+bounces-9858-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 766319D6E7E
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Nov 2024 13:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC4D0161B6D
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Nov 2024 12:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FE1191F85;
	Sun, 24 Nov 2024 12:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CS+aJxYy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C14F1C2323;
	Sun, 24 Nov 2024 12:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452040; cv=none; b=ESHX34c6wSsj1RxwbcBHcd6AwYoiD3sDWpBszSOE6LUx9xOd6B6ClBoQRCJRdq/XUGcBEuiDYXaXDdSXDqnj47OqOqF/JXkP8jNx/TS802mMiRlhkN1Jl5qMrlgxtIewgvUwqN0Euq7yOTduuoGc9x6Xyg5W1/m++9oYxJhY37M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452040; c=relaxed/simple;
	bh=TByrYCJY4zVcFW57Bp+4AZO0aOyyeqaY43IAMlYBd40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R+BViXIWMiELgzJedphxT/jhsft/VkxM8/UtJ3bSTfFRb3XH7CxlH3GIQIRJP+skSDae4TvJy7WaoRLP10kIvyzEhUX1dkhJeOXkw46dYpIoK5cRLXo0jvJnQVGq+Oj49jDE53dmlLK3irSfC7sjabj4yH7nVza1KRN/M7hTHAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CS+aJxYy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6D1C4CECC;
	Sun, 24 Nov 2024 12:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452039;
	bh=TByrYCJY4zVcFW57Bp+4AZO0aOyyeqaY43IAMlYBd40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CS+aJxYyb3/e9rzhqLuyU9X0dCxu2k3FXcggl542HxLWJSWk/yW4TVibmdyiI9+Cy
	 LwHxE2UJB8grDQ/8B16S+sNsIzxHRufiHIK3yNQ+Mmuf299bttZN1Qgba6uOVb4GWL
	 DX0ts9QNaoP3jhu25J1G3LCQZDpRSxQeG47KJrkp7ycAxxRBfnHvQDk/ZTKTUYQorg
	 GuBZyDqf4L9T80wznoXwgYwKvwZ++KsMTSEUa9XabYAb7q0YwnwSIAk7a3WfYhtUOi
	 VsNDw5URIyu23mSTWNsQYMivd08K9NE7cBXjmlGKaQ+u6jvVOiLnd9Yd6XjUwYqa+L
	 5W2QbFl4iue7w==
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
Subject: [PATCH AUTOSEL 6.11 13/16] btrfs: fix warning on PTR_ERR() against NULL device at btrfs_control_ioctl()
Date: Sun, 24 Nov 2024 07:39:50 -0500
Message-ID: <20241124124009.3336072-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124124009.3336072-1-sashal@kernel.org>
References: <20241124124009.3336072-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
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
index c64d071341223..4505995eec342 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2256,7 +2256,10 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
 		device = btrfs_scan_one_device(vol->name, BLK_OPEN_READ, false);
 		if (IS_ERR_OR_NULL(device)) {
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


