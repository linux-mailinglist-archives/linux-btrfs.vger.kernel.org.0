Return-Path: <linux-btrfs+bounces-14730-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F5BADD5CE
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 18:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF7154070E5
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 16:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852EB2F3622;
	Tue, 17 Jun 2025 16:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qyiifDXl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B472F2C7C
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 16:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176792; cv=none; b=dppO+ZMiYtM7NFfnSG7be3aofhcnVa4I1pF7sutbGOinWuyuVReI9QmZJdY2HnRO5mcQpmqkk8XeD8aA6G7Jry2XC67nFp2TTHkbxZaCzL4zIlgJI1kJBj0snGi8a1mF+ZAVwqJK/17/PJ3kkURjwzyZQVrXB9Xc073Zh7tXFOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176792; c=relaxed/simple;
	bh=klpTdWEc+1IAPogY9NkT8tXpNFCjZtvWZYTJvgyiThc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nNqMS/+CjgMEeOnOWnFrhCAXZEyeoK7AVw5QXw5fkOcjIDC90uY/yUcn5MYoXBUrrGPH/CYbTUehIF0c9NUAVeZXOjepqF8+5vva1i8B93KfVmrvVrCmsFTl+AKfwoLbuEvXKU6UKDwBK3TDDei7v9Uc/Fsm/HFf7UFCDoOqzjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qyiifDXl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24677C4CEF0
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 16:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750176792;
	bh=klpTdWEc+1IAPogY9NkT8tXpNFCjZtvWZYTJvgyiThc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qyiifDXlQncvhv3NEuTxqAqroJwz0L76olphVBjAoteH5v3uWV8OcRsy/7ZopmodI
	 AYnzw3D0eJwt3AlSNsDj1NGHuX5u7065UIjfReNsoEAARcqlt1SY5sSKoe+ed5AVDj
	 j3V+bMU/sFiSgqawyLYPz9SaF4eyBuyetTC1J5MKvy/NvKxUCtT+y6D3h73rGg4Oyk
	 yRLS9EMbQlsdgBYE5Afnmu2WUqIO7JCd9Mtw8wg1pj11nDWRlD/BwyqaVuiZhxajTw
	 +erdZd8CibfB7nCGXb2xpSWPGTBa92XDhXjTwVgoYSJMc8MqhsUCpEfAAaNUQ1cofT
	 hXeJIlAcfYPXQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 01/16] btrfs: remove pointless out label from add_new_free_space_info()
Date: Tue, 17 Jun 2025 17:12:56 +0100
Message-ID: <a2dc4ed370031af31f096db6927d104e87b2a882.1750075579.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1750075579.git.fdmanana@suse.com>
References: <cover.1750075579.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We can just return directly if btrfs_insert_empty_item() fails, there is
no need to release the path before returning, as all callers (or upper
in the call chain) will free the path if they get an error from the call
to add_new_free_space_info(), which is also a common pattern everywhere
in btrfs. Finally there's no need to set 'ret' to 0 if the call to
btrfs_insert_empty_item() didn't fail, since 'ret' is already 0.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/free-space-tree.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index f03f3610b713..6418b3b5d16a 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -82,18 +82,15 @@ static int add_new_free_space_info(struct btrfs_trans_handle *trans,
 
 	ret = btrfs_insert_empty_item(trans, root, path, &key, sizeof(*info));
 	if (ret)
-		goto out;
+		return ret;
 
 	leaf = path->nodes[0];
 	info = btrfs_item_ptr(leaf, path->slots[0],
 			      struct btrfs_free_space_info);
 	btrfs_set_free_space_extent_count(leaf, info, 0);
 	btrfs_set_free_space_flags(leaf, info, 0);
-
-	ret = 0;
-out:
 	btrfs_release_path(path);
-	return ret;
+	return 0;
 }
 
 EXPORT_FOR_TESTS
-- 
2.47.2


