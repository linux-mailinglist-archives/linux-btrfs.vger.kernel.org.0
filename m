Return-Path: <linux-btrfs+bounces-16727-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26063B4893B
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 11:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC2687ACCEB
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 09:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AEA2FE594;
	Mon,  8 Sep 2025 09:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/mJN32k"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168112FE573
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 09:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325241; cv=none; b=EYW/vEpGzUEuKPhe2pC0Y3z3SdQKBlDxvF4tWDo945zPDeAc981LfcTGrVgyiPRp1rZGN63jaa6Q5Ji42zGfSkB8pWdVcsgC0aMVGFKzXjIvvgptTUIhDUGNS0RSB6goIodeV2aXJqOFw57TsZEbRQa4T4jzhWllzrU2+g4rs8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325241; c=relaxed/simple;
	bh=z1Wm5/NS3NW7g9LMvShAz/oMhfgugdrmSuz9zwLv4PQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n9HILcy696Bd0y5tqQMtp8/j4IeRWrFByThZLiUWxuCLE4ohRbobrwNSrGcnL13R7IWIZN5UwGAFjv3036o4Ebx/+84jg74VemlEMXl0K+VkDi/BR4VpQZxENEXODhQ47BRWQoCXMfLoNTQui89nZF8XldUuZA4clyZw0o48qx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/mJN32k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D4DC4CEF1
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 09:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757325240;
	bh=z1Wm5/NS3NW7g9LMvShAz/oMhfgugdrmSuz9zwLv4PQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=A/mJN32kBBGXwJIqblR92BcG22PewuCuhnB4pCri6KMna10GoisMTVGc7MFACOXIa
	 fLEfkHf/YNpY7yPBd1HXo4S/4m7tu0LGDTgTj+7qaNHldahzFHYv9JtQ3YVAFexGH6
	 U0k6+6PzgbeqHNBIAC15pxIFMfPvs8Zz7+imrGWNOV9FDhCaduHCsh7IR6uOWENkEn
	 xoiylQa7pVfHQJhu7zrQrDgPtTWBKLBLNx49HRM0yfv9WZhK+08ZXv5gxLCAbfX0Iw
	 iac7sw6Hl8KL9jyfpCSN9TZd7s2cwFV3fQQJ4pfz8DeaQiMb4b2nAErYeQb7goRTsN
	 +B7lvWAkiTBvA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 32/33] btrfs: abort transaction if we fail to update inode in log replay dir fixup
Date: Mon,  8 Sep 2025 10:53:26 +0100
Message-ID: <74e37216da159889f8b89bad32230ca9b3d5b2ff.1757271913.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1757271913.git.fdmanana@suse.com>
References: <cover.1757271913.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

If we fail to update the inode at link_to_fixup_dir(), we don't abort the
transaction and propagate the error up the call chain, which makes it hard
to pinpoint the error to the inode update. So abort the transaction if the
inode update call fails, so that if it happens we known immediately.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 7b91248b38dc..83b79023baae 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -1849,6 +1849,8 @@ static noinline int link_to_fixup_dir(struct walk_control *wc, u64 objectid)
 		else
 			inc_nlink(vfs_inode);
 		ret = btrfs_update_inode(trans, inode);
+		if (ret)
+			btrfs_abort_transaction(trans, ret);
 	} else if (ret == -EEXIST) {
 		ret = 0;
 	} else {
-- 
2.47.2


