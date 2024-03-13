Return-Path: <linux-btrfs+bounces-3244-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFDB87A82E
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Mar 2024 14:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 430651F22E4C
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Mar 2024 13:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5017141232;
	Wed, 13 Mar 2024 13:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVFEicYl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7739140860
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Mar 2024 13:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710336052; cv=none; b=sAWhbpUvw2/0BUyaVvd/VNRpCStMnFHwzX27hIN6umOlVcr5BTFraP+oMG/krIXmH12vhNcVQrErAjU/4DToaHL1IBpiNlcVFzwjUKv5/X6SII5K+SUYBHOt2XL8tvN35IC9gbv09LvEjmgcbNKV/cjRis+hLuJbiBcome6o4tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710336052; c=relaxed/simple;
	bh=QGx4x/dap8z34uSrgy9vLkFO9eETVAAiMwooC5u/gFY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OsvsqtUNt+CCjC794uVii+hCSng1OCAx/TUTBKrHVpQPs2NNxXSzFzbEidQ0Z1INmsRY+t/wyBYz/iiAEwfCEbn1H7gyahW180oGSkePRe6osrvTfID/XTNLZTMH3fhLV7xRzpqBJL6hQqOlkiI8fCB6OfGxeQ0u1+67QlX5l68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVFEicYl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F32C433F1
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Mar 2024 13:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710336052;
	bh=QGx4x/dap8z34uSrgy9vLkFO9eETVAAiMwooC5u/gFY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=OVFEicYlEfkvlB1PUjoEQmlVrGDF2rNxAiQ9A23MGYeZ2wk2Z/nmO/3gV0Y/n/FG8
	 gG/mLSvxdiPdeXGp0Me2wAh8Ab0Ieo0vDPFXTK3Glb152dqg4VUS1U/7P7Y+eeGobR
	 AXPW3UGm7KudyxZFsVdqJXtdBo1phv4iOExW4OCk3T2r3qKsMf1neYQafTu3z8K1gu
	 4zAhgywNBnymUaIrWk6TmwO+ndJbhu9HSGUg/tdFZUp+9CwcaXz1sO8ZXEJbPuuIYa
	 4/0RfGN/FbDmQShiOx1Fu8qAhwFzNrvXhewd28sj2COcodHGFQRHHxAbtQjQFH50f8
	 yXdViY4Wb5JwA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: fix extent map leak in unexpected scenario at unpin_extent_cache()
Date: Wed, 13 Mar 2024 13:20:44 +0000
Message-Id: <f3c7f68caa8f3568fbf2d561b35604823bb5985f.1710335452.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1710335452.git.fdmanana@suse.com>
References: <cover.1710335452.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

At unpin_extent_cache() if we happen to find an extent map with an
unexpected start offset, we jump to the 'out' label and never release the
reference we added to the extent map through the call to
lookup_extent_mapping(), therefore resulting in a leak. So fix this by
moving the free_extent_map() under the 'out' label.

Fixes: c03c89f821e5 ("btrfs: handle errors returned from unpin_extent_cache()")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_map.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 347ca13d15a9..e03953dbcd5e 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -340,9 +340,9 @@ int unpin_extent_cache(struct btrfs_inode *inode, u64 start, u64 len, u64 gen)
 		em->mod_len = em->len;
 	}
 
-	free_extent_map(em);
 out:
 	write_unlock(&tree->lock);
+	free_extent_map(em);
 	return ret;
 
 }
-- 
2.43.0


