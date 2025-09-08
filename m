Return-Path: <linux-btrfs+bounces-16726-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B70B48932
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 11:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5CEA1884279
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 09:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793682FE563;
	Mon,  8 Sep 2025 09:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjTFnYiM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE442FE065
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 09:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325239; cv=none; b=DY3Flby42v+BkqXFqcq1rBbeKfTLfQeeeCNGNqBwOrFult2y4IBGF4TZCBaVngqTzqnVU/maKhwTwG+d1cxR3eMWWB2nef+EZ9wnGBGQrxn4TR6mBOczUTgRxynEwQgRgwLYqgvOoMd7laoCJveD2Qwx93Q8/jv58aJsvuggct4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325239; c=relaxed/simple;
	bh=d/MwSPBEFIvMAMkdova/Hbd1ubKniFSXKHm5MVJOc9I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a+jBSL5xN5drJ5EjonZu2WacQAfsi5MD677AWftZjOIJm2Ii43CTNUDCrxOrpBmsj/8NVocSdev+SxIJsKtePkLdCiGZ6tA0QlGLzbTxdNH74XR3sqlspv0ABLeYAMwFhHKCvWxh0QwvW2G/2FQZds1+T0Dw3zj9k4O01PYESAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjTFnYiM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DFFFC4CEF8
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 09:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757325239;
	bh=d/MwSPBEFIvMAMkdova/Hbd1ubKniFSXKHm5MVJOc9I=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=RjTFnYiMeklD7FpF+yfxfNk/m9eqcm5W42o0J9rpEC0hV1/aSZolmXRF7K4HxAh7f
	 5nQHk+zjhJ3z0OMF3ZL3gXCXOsYKoLAI2KApH57+GpMBsXPdtycAuh2eMH6c9GtIV+
	 5ExngbGNe2NAQXJQZBQmUQvjxBKXjXurPxr8AdDa4n1vBvvhPq+P7zz02OVMi0AnpI
	 VQpVEO45AgD6SOCu7mJJX6ZCMm44NSOLm9Hu9JxHUXiNrZLpCoKqWsvUVT8mKfyUEn
	 CrwNuUkdLwQ2R2n5ou7t/VWq9fXUePkI1DzhTlPdsSyXJ9DUkWtNsdswKkj3++FBZt
	 OTA5238WxPbhg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 31/33] btrfs: abort transaction if we fail to find dir item during log replay
Date: Mon,  8 Sep 2025 10:53:25 +0100
Message-ID: <5b95287cfd26d56e33bb0d1ebd42a17de2c8c217.1757271913.git.fdmanana@suse.com>
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

At __add_inode_ref() if we get an error when trying to lookup a dir item
we don't abort the transaction and propagate the error up the call chain,
so that somewhere else up in the call chain the transaction is aborted.
This however makes it hard to know that the failure comes from looking up
a dir item, so add a transaction abort in case we fail there, so that we
immediately pinpoint where the problem comes from during log replay.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 86c595ef57f4..7b91248b38dc 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -1281,7 +1281,9 @@ static inline int __add_inode_ref(struct walk_control *wc,
 	/* look for a conflicting name */
 	di = btrfs_lookup_dir_item(trans, root, wc->subvol_path, btrfs_ino(dir), name, 0);
 	if (IS_ERR(di)) {
-		return PTR_ERR(di);
+		ret = PTR_ERR(di);
+		btrfs_abort_transaction(trans, ret);
+		return ret;
 	} else if (di) {
 		ret = drop_one_dir_item(wc, dir, di);
 		if (ret)
-- 
2.47.2


