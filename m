Return-Path: <linux-btrfs+bounces-9852-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 704E59D6E41
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Nov 2024 13:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2E53B229FE
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Nov 2024 12:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D5A1AA7AB;
	Sun, 24 Nov 2024 12:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jcx+2nm8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABB11AD3E0;
	Sun, 24 Nov 2024 12:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732451984; cv=none; b=nboQHtj8Zd1thFojKPjy+VHQ2keTkUJCm3ct5wil9l6z7gJpwa44arxw3oVEFHUKh0uo360V0VNeT/30DWX9dGar/h4JePurLiF/uM1PBdmwz8GDFtN9ZkRs/vW2rIYLQOGSrGz8JAuqKlMwxUOhUnRheU8M0ukcHT0lKII6Ybk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732451984; c=relaxed/simple;
	bh=TByrYCJY4zVcFW57Bp+4AZO0aOyyeqaY43IAMlYBd40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zw23Yq8tGkGDKctgl4x1QNnMATvecrvLC/dCSbhoDZhZMOnl5l512ftaqVYEi6xrQJXT66NR8lKY9nsCmxk7wDf16jlOT2XK2SHgi70ge6hPgw1Ta+ObLotv+WiJ25n7j5itpVzYq6Ck4Sowb4iciI37MMWGzOjutn37qwopk/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jcx+2nm8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63333C4CED3;
	Sun, 24 Nov 2024 12:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732451984;
	bh=TByrYCJY4zVcFW57Bp+4AZO0aOyyeqaY43IAMlYBd40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jcx+2nm8Zx8hNDQ8KORebPlyieapp+OwwzUpBJGyjWLnWQShQrjrNWXTdbGPqwuN2
	 HCmlFXTNR5dikZWHejs2ILIfBDo570db2fqFIaWFmD5+Jd+jQxWcK4XgEowiBNgxvt
	 F1VEiDbvfI9zu7ZSDOTDKP2/e1GkP9SJV8RhmdNAfYw1D1JGC50WnxT33b6HV+1qX7
	 Vy9q4f40hvNdiEej9/py+r+LisTqihV0M76rJ/0/VrljTpSLC7Q5opMT8/PwFkJU4H
	 YFQNo6XYy8Bk91jWr2XwPTuj5Rm/yq0jTSW3jIKGdMsytOUp1gDsqQcGMCKkc74lqR
	 bILX61S46LeIw==
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
Subject: [PATCH AUTOSEL 6.12 15/19] btrfs: fix warning on PTR_ERR() against NULL device at btrfs_control_ioctl()
Date: Sun, 24 Nov 2024 07:38:50 -0500
Message-ID: <20241124123912.3335344-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124123912.3335344-1-sashal@kernel.org>
References: <20241124123912.3335344-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
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


