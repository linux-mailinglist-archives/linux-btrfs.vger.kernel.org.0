Return-Path: <linux-btrfs+bounces-9865-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D74379D6EB0
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Nov 2024 13:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9A851624AF
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Nov 2024 12:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803AC1D63D8;
	Sun, 24 Nov 2024 12:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llS4tDYj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3A51D61B7;
	Sun, 24 Nov 2024 12:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452096; cv=none; b=TLA0qDQYRGhDs5yzG1WX16OtFRlPndEnI9WPPXTuRoeGTFpilMCkcCQviQHOwWLO6URYUWfLadZpiBSVgNGJcVm6j/LJdeonwHrWMURjnyjUZBvGOPBOUXby3NqPMRA1AbSkwZBlxhP1UZRsV7j4acJDbws8VdzG/yw9hf59pqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452096; c=relaxed/simple;
	bh=Vl5qJv5RtSd0ilWgbhpqW+1mLUQwkPVgVCNLk0CTNcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UD4KCV50GZeQFSfwBWsJCNs3kl4yZhOfnLzi+JhcZzfEOU1z1zIoE2UwbpoHsDO7cQ3E+sRRu5DCAUYk4RhSigxe6WSrvhZ/wbYnKde7Qcow5vw/z0/8S98E4aW7BmBKmtSHc0H/3OpxrfEBdlI17qfWn/z6GqmBxO2wPaqyjTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llS4tDYj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FDDAC4CED1;
	Sun, 24 Nov 2024 12:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452096;
	bh=Vl5qJv5RtSd0ilWgbhpqW+1mLUQwkPVgVCNLk0CTNcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=llS4tDYjyc/Bkw8qTndtdQdZysj8jhxg2iThGnX77rDVSK9BJKWE7N8BGdt49qnZT
	 ZBE/R06TPZSFOvsEnbRMVrbMqnS4ib0y0TQJR30tlQhWAwmsbtczW1IYGFCvowJEoC
	 QmddfuZ+9nKtoTwyDM6tKujcNWPRq4/Ks396JJu7BDDkkBKARa+tnkEnc8Y1sVsPym
	 0zDNxYPCzpvDOlmQQOll290wgphQ3fG3WBQat2QjwwE0EJEfWGkxTMFvCgwSel/Q0y
	 X/YBFc2eNrn5QAdxlOc5U5vo7s5KTUs69Xn3ffqQpB/HN1/E5iGF72/MNgonMPuLCP
	 gjBZ79A8UhW/w==
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
Subject: [PATCH AUTOSEL 6.1 5/7] btrfs: fix warning on PTR_ERR() against NULL device at btrfs_control_ioctl()
Date: Sun, 24 Nov 2024 07:41:16 -0500
Message-ID: <20241124124126.3336691-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124124126.3336691-1-sashal@kernel.org>
References: <20241124124126.3336691-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.119
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
index d063379a031dc..3695c694dc0de 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2520,7 +2520,10 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
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


