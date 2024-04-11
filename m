Return-Path: <linux-btrfs+bounces-4146-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6E98A1D78
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 20:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECB46B31339
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 17:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630B7181BB2;
	Thu, 11 Apr 2024 16:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOjfhVN4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8351802C5
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Apr 2024 16:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712852359; cv=none; b=I9Ooj9FJ8U1HRka098Pjz5Xq7dL1N2jGAN4JuxHYprERfPAiTERV62KcCmHcZJHYFT1IvNreABiWNsUgsT8wtxD5cinfsboN5jjrSPgvd43/RMDOzFjVmEPvqSTRId/m4/HmIZS0GKgjyXcJygyTXJf6IDwWI5h7K9r1J54h0k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712852359; c=relaxed/simple;
	bh=focZnBDtmmUYi/Uho+3AOABt2zAcbR+hASsQDbTj3KA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OMlFWsr7aLMzFfhmJ9T7Zu7pKxiZsAQ39pQUnUmkiE+uwnrn23/GToGLkamF0GsvIP1DO9F85FY721DfI4O+Pz9HuFSfpPpomz1ojlW/nmAO0ZGyQtK8Y3p8vdfpGoUq43cST0nK1Ui3ScDIOf430DDuDSQ7GoiKKAdYSyyDZmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOjfhVN4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D53AC113CE
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Apr 2024 16:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712852358;
	bh=focZnBDtmmUYi/Uho+3AOABt2zAcbR+hASsQDbTj3KA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=iOjfhVN4OwHcKJC01mz70oJbtPh+v+Atf2Kl5EEh9RofouBa8VkVXOQ6Edzw/4zCn
	 RjHbKWKx3Ps0Pi8en6fsCdk2wsQUmsp6VL/5WDPpwsUSnoMwsCWAHbKhevwcpeHhr4
	 8Cw223XKtJUG06JRuAFGSehnXL1EP/gCnpN8wfA7ROJx1/51v2rW+pOY9eV0VbS/nh
	 jb39XqVC7F6ffMP1BYXeSV7m+Qo8HiOsnx7MmTnX2K1bXRotcDiV/jr1niWfA46P8w
	 MXPTChzUUlppbFikvCFRTesmeGr9XMuRD1o/MVH/BEyk+FeQziCWy2S8vWGbVOmwlV
	 h1DxAR5F+nkgw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 03/15] btrfs: simplify add_extent_mapping() by removing pointless label
Date: Thu, 11 Apr 2024 17:18:57 +0100
Message-Id: <c47dbae206acd4371c61758c9093911c81e96385.1712837044.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1712837044.git.fdmanana@suse.com>
References: <cover.1712837044.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The add_extent_mapping() function is short and trivial, there's no need to
have a label for a quick exit in case of an error, even because there's no
error handling needed, we just need to return the error. So remove that
label and return directly.

Also while at it remove the redundant initialization of 'ret', as that may
help avoid some warnings with clang tools such as the one reported/fixed
by commit 966de47ff0c9 ("btrfs: remove redundant initialization of
variables in log_new_ancestors").

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_map.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 840be23d2c0a..d125d5ab9b1d 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -370,17 +370,17 @@ static inline void setup_extent_mapping(struct extent_map_tree *tree,
 static int add_extent_mapping(struct extent_map_tree *tree,
 			      struct extent_map *em, int modified)
 {
-	int ret = 0;
+	int ret;
 
 	lockdep_assert_held_write(&tree->lock);
 
 	ret = tree_insert(&tree->map, em);
 	if (ret)
-		goto out;
+		return ret;
 
 	setup_extent_mapping(tree, em, modified);
-out:
-	return ret;
+
+	return 0;
 }
 
 static struct extent_map *
-- 
2.43.0


