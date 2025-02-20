Return-Path: <linux-btrfs+bounces-11645-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 769D0A3D7B2
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 12:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72BF119C1071
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 11:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122831F3BA4;
	Thu, 20 Feb 2025 11:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oszeNFIW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0681F3B8B
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 11:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740049498; cv=none; b=jABMFdpF1VHTBEwa6ugcUFHe0lXS7Cvd5wkWtzOO9kHtq7x1gC+Q+7hPJ9hlaA4u3sKrYv23/A+DuWT3/NmpF7gxQizCCK5PuLc4892Vn5GSHt14YxfjMmQNKHzQjqKQ9eGKh8N36iWdAvS+zVFiHrL6ecdc4uB6/AZu6Vsam7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740049498; c=relaxed/simple;
	bh=wU+8lAGav3ycWmUOUtxDG0zPsFe5lhgvAzLDXJIHe+M=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nXIyympa/IKk1D42iNCEJ4NJckUMp0H4akx7NANYZhbMfk/17K67JZWhZkpkTEet9+LcIE7HVTI4FkqhDWoLT1mNprOi4pbH0X6wFAirSoj687UO6rxWdDkEmdc08UGMeEjipZDZJBEWKTrhCMOdJKBW1Gb3gPOP2Jsmwg923AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oszeNFIW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52106C4CEDD
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 11:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740049497;
	bh=wU+8lAGav3ycWmUOUtxDG0zPsFe5lhgvAzLDXJIHe+M=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=oszeNFIW71BEITh3ORgHq8d07csxtqAje4CyVB2B6yK9E0jYdKsinXo7AKTGGqc3O
	 38wrRdxkmMS81KQ2pPBU03Y3h3gAGz+k5SULz6fxnrPg3ju1Y8nTgspX+Ic5vzcA2q
	 mVWVC968r2hU7i1MUZ2JpwaHVVKmjNnU8tNVU7wsuPNSlikq8yqcZa8WZlBtOtfonw
	 A1YktXSUPcOHldIAe5YsglVrQV1UM3WzpocICijyis2T+xrgXN7mKQDvdm2wtg/XLf
	 yhv6axGqx4xDvAyCs7FaQnjHBqibLMf3D0EkmlzfJtTQCxW03TXMvBuLxLTN0Bo1ep
	 Eaxnhilc9s8zQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 10/30] btrfs: send: simplify return logic from is_inode_existent()
Date: Thu, 20 Feb 2025 11:04:23 +0000
Message-Id: <099b202330b07fa00ede7d0ec1437b5c86a4b40e.1740049233.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1740049233.git.fdmanana@suse.com>
References: <cover.1740049233.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There is no need to have an 'out' label and jump into it since there are
no resource cleanups to perform (release locks, free memory, etc), so
make this simpler by removing the label and goto and instead return
directly.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 393c9ca5de90..0a908e1066a6 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -1950,17 +1950,14 @@ static int is_inode_existent(struct send_ctx *sctx, u64 ino, u64 gen,
 
 	ret = get_cur_inode_state(sctx, ino, gen, send_gen, parent_gen);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	if (ret == inode_state_no_change ||
 	    ret == inode_state_did_create ||
 	    ret == inode_state_will_delete)
-		ret = 1;
-	else
-		ret = 0;
+		return 1;
 
-out:
-	return ret;
+	return 0;
 }
 
 /*
-- 
2.45.2


