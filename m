Return-Path: <linux-btrfs+bounces-9870-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 835A89D6ED0
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Nov 2024 13:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FEB3281705
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Nov 2024 12:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F7D1E04A2;
	Sun, 24 Nov 2024 12:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJdUuOMU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEEE1E00B1;
	Sun, 24 Nov 2024 12:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452148; cv=none; b=XDfG7e4Z8Q6aL55ilQHaqXurSmqQ9Q0apE3XgYkdv4eUFraLopv+PfF1W82uiMbscVsifmSG+AkB3YOB3Hne+HnrG0Biak9Y1mHYmT5kUCT0toR5MDgsxRX/0Y7IEBXKDOAgX3BZYRM6X1jEpGW95LYSVDataaaa/Mns1NWxfEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452148; c=relaxed/simple;
	bh=/l6mhQhX9t/HGmElU6gDa5zC79V9Pz8SJDT1b04P/nM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GwVLg+ckE50zKlZXydPqIlHqG/dKcPUqRPGkN970rmTPhy0Ak0iDa1PR+oJ6vf+4EhuOMZnicf6wbdVU5pEhVoXPhxCNRiWfb6ybgqZ4TRsSt1NNawtirWGZR6TxJWGBjp9q/O/DREsHo4H+m0Sl68T7wuvHdud/acOEbyaAVms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJdUuOMU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8337EC4CECC;
	Sun, 24 Nov 2024 12:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452148;
	bh=/l6mhQhX9t/HGmElU6gDa5zC79V9Pz8SJDT1b04P/nM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tJdUuOMUyJUPhshRe131ZijV9qiUyWolGbmmk7IC9gq9/y3bdZradxBd2jKwsfupA
	 aDjkvs79Sk+RInqY3G9OropkYe2abbrUx8odnQgxnCfbCzvz4W8FwFq/d57YtBEmeo
	 0JdDjQlFc4P2YPZPrnBptOS2HgH1xGIB0KlX4N/j6y+6rIOcri73rc4TMBuB9+bzh0
	 6AimilDXgYoSmHa1Dga97UsZXmAr5e8U6W644fuXiFXgPng7PtqWmER6wMiUDvI7P/
	 R3WDMDFx9YsvgWKFXrN8lRXC8ywMsEmiAWT3DnEsqSCRFMylCNil6Smv9BNt5W6LKo
	 xrAUsyJvhjcRw==
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
Subject: [PATCH AUTOSEL 5.4 2/2] btrfs: fix warning on PTR_ERR() against NULL device at btrfs_control_ioctl()
Date: Sun, 24 Nov 2024 07:42:21 -0500
Message-ID: <20241124124224.3337144-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124124224.3337144-1-sashal@kernel.org>
References: <20241124124224.3337144-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.286
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
index ea8b5b2d859d7..c80bc69ad6a82 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2227,7 +2227,10 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
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


