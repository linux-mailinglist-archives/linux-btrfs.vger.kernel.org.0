Return-Path: <linux-btrfs+bounces-5794-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DDA690D706
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2024 17:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA78C2841B2
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2024 15:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942CB3D0D5;
	Tue, 18 Jun 2024 15:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b994Nl/q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B5439AEC
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2024 15:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718723683; cv=none; b=iWSKLPUIzdiDQ15Z+9Sft/Jrna2H9p4gDjY8YJGrKeU2pCEb5MDCRl8NMXiHXa4hRP6a3LEgSr2z4r3Vt9BnSJv26aSP1fSv0jYyf1Y8QuXuwmPbMoJZerY+DUpmjEh0qZZSQGjoxxvRPANykkHxYTmF8h2HCMCSJY7Mwuz2hS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718723683; c=relaxed/simple;
	bh=EYQS0aS3FdVuFwhy3xw+vkGECb9lF8NVP2j9JsWVc9k=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gIYESsLXI8QmotAyUrUmRX/0iefqXVkUzkiD6nvV8LLA0nfEloVigvKKMmBxmfvmwHmeeM3dPhey0kbxDahXtTm8lRgx8L873OwwP9WVgcEueAyTi9d/BokaXlWhFZXgmNj7u+efoOJ64IWJKHmXxD0QhiMyrm2fiXNN7T9wkro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b994Nl/q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A354C4AF50
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2024 15:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718723683;
	bh=EYQS0aS3FdVuFwhy3xw+vkGECb9lF8NVP2j9JsWVc9k=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=b994Nl/qQGI6yAWvsCOjTQy//wFytokfj9iiQ0e5kWMyBk6MKA5qRI9AxQMZMo4Bh
	 dpmG5wiQRBLTzB/SRJjgw0P4KGSzJc72EGYH3u1YISk30aNCaMkcbAFB0PPY6pUqIE
	 0Yxku0XlkBF7Nff6MlrkSpkEcOzqFurQ96sivx1CkIqmZw62IWlxoFAbCEg8R1NfMr
	 c5bCfJdadEg/E3xa/4Ui82Y+szm3yqlxCk3kdrXmzYP1nuMkC6sNZQ7mLwdgi5tzaX
	 QdFOTf23KzMcJko1FtZN4mcPDSI5dHLCuRawNiT6weDC9Wy9mAgdo7tpCjSarpMsZD
	 hD2LkEDRg2LIQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: replace BUG_ON() with error handling at update_ref_for_cow()
Date: Tue, 18 Jun 2024 16:14:38 +0100
Message-Id: <0b85a09a22d9a36c6f1b0a93d84c7cc31e041adb.1718723053.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718723053.git.fdmanana@suse.com>
References: <cover.1718723053.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Instead of a BUG_ON() just return an error, log an error message and
abort the transaction in case we find an extent buffer belonging to the
relocation tree that doesn't have the full backref flag set. This is
unexpected and should never happen (save for bugs or a potential bad
memory).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 7b2f1de845e7..e33f9f5a228d 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -461,8 +461,16 @@ static noinline int update_ref_for_cow(struct btrfs_trans_handle *trans,
 	}
 
 	owner = btrfs_header_owner(buf);
-	BUG_ON(owner == BTRFS_TREE_RELOC_OBJECTID &&
-	       !(flags & BTRFS_BLOCK_FLAG_FULL_BACKREF));
+	if (unlikely(owner == BTRFS_TREE_RELOC_OBJECTID &&
+		     !(flags & BTRFS_BLOCK_FLAG_FULL_BACKREF))) {
+		btrfs_crit(fs_info,
+"found tree block at bytenr %llu level %d root %llu refs %llu flags %llx without full backref flag set",
+			   buf->start, btrfs_header_level(buf),
+			   btrfs_root_id(root), refs, flags);
+		ret = -EUCLEAN;
+		btrfs_abort_transaction(trans, ret);
+		return ret;
+	}
 
 	if (refs > 1) {
 		if ((owner == btrfs_root_id(root) ||
-- 
2.43.0


