Return-Path: <linux-btrfs+bounces-9366-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1326B9BEE7F
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Nov 2024 14:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DFA1B21DCA
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Nov 2024 13:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7C71E22E2;
	Wed,  6 Nov 2024 13:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BW+gJIOW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EED1DFE13
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Nov 2024 13:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730899062; cv=none; b=ZomMAwtmR1n74PCDQNsIRICfMn3C+ynzDrlwkoBrHvUIvPcLbf1+6YimO601Kwp8KhDtvpb/7nLpMH2p4JNbM3pvCWKc1kPkaSFTQ+1AC3WD/0T20jjhIEIJduHUOPybRXQgQd20DtLiybOa6gSEf2xU/rTr6NgD71E0zY4fuAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730899062; c=relaxed/simple;
	bh=qsJhK9rMDD1lS1AwcEbYwhGE7FfFebwrmo8ch1yPqEo=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=NeceC9c46ApnANatcF9sXzkuGDlMl/mydCuWNY422o3U5/kGB0V7wraecWVEvUY9r7IBkleQ9WMr0CB1EeSGbdYcgymMu3R42RVZyzhQsU5qqadF6VNVe7j2AbxTOxNdivcxt29D+w2NOEW6jx0OgD4JohJNkncEPGePvrxNIaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BW+gJIOW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8FDC4CED6
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Nov 2024 13:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730899062;
	bh=qsJhK9rMDD1lS1AwcEbYwhGE7FfFebwrmo8ch1yPqEo=;
	h=From:To:Subject:Date:From;
	b=BW+gJIOWfBXWoUqmkbbeF76Spd4g/RLr4V5Bi6GPew5KzqiWiqG/vASUn/eliS1/e
	 UUgC3zc8qknW27q6kiq2Usn7amsHYH+fjq4YhjxuVPWTLj/3qrmU5PHWEVYugVPrTC
	 g1Y/nRHxYMORRWm23wTvT8V4bCR6pI7bDDMREAYjLkmoV520RTQ3qtQuWaX+Paw7i0
	 csw5YRxWwz9etByZNFvI52fuHUy2ZxjzCN4Bf6GhuGnH0u6gpUR+WGA8RyrA4mQiG4
	 qI+kwHjLr7VF36WzjaGk7w0gBpinFv3dhvkVidjyc6k24Ki3k+hPKAc5407b8K5YG7
	 K/1tpf8p7XP3A==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix warning on PTR_ERR() against NULL device at btrfs_control_ioctl()
Date: Wed,  6 Nov 2024 13:17:39 +0000
Message-Id: <5bbe65395fcb54fd561cc17a705ce6d50d0cc5c0.1730898948.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Smatch complains about calling PTR_ERR() against a NULL pointer:

  fs/btrfs/super.c:2272 btrfs_control_ioctl() warn: passing zero to 'PTR_ERR'

Fix this by calling PTR_ERR() against the device pointer only if it
contains an error.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/super.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 6cc9291c4552..9a09a1251057 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2269,7 +2269,10 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
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
2.45.2


