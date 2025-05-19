Return-Path: <linux-btrfs+bounces-14117-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FCCABBB56
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 May 2025 12:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8DCC1896F71
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 May 2025 10:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C34274FFB;
	Mon, 19 May 2025 10:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXiUFORk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF9A27466A
	for <linux-btrfs@vger.kernel.org>; Mon, 19 May 2025 10:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747651330; cv=none; b=Zntvdjuaj5/QkF65BL89ADbxe3jx6n9mbQ2+bq49hbSuqiRqguyXjXiVk2G7LNIWWHozhHJWQjXuhQ9XlIw7PECJnonfCzcAiUA3tuuc2tjCWcd5lZqq1OA1a3Ho7FG3ic0ueh/IvdhhagX0jJg8vOCjhhCHmy1JT7cnNFZBxb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747651330; c=relaxed/simple;
	bh=uuvRDgntS2KCRtrriKvB40PXCuiuaZGCKG9EGa711CQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XYZgwIHMYv5ZIGAsQ33qsul6FKI3wvj0t4E1gPVzdjMpVvOamV5PdEkscXc2tfNA3/34XwxRIBoU1ApAsheSEz8nv7+K2TW171UcsutNACHX1S8FPedFPHiI4gVifcsEa2Nfin1v8gn2Y/96zJNi76Wn5jA6KHHAE7JghWZmUQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXiUFORk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD57C4CEE4
	for <linux-btrfs@vger.kernel.org>; Mon, 19 May 2025 10:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747651330;
	bh=uuvRDgntS2KCRtrriKvB40PXCuiuaZGCKG9EGa711CQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gXiUFORkBVV+ozbZ8avBZL+bPmodkWvfCs+e7FWJK2b3L2XIXOJTAiwUHY/c3u5YD
	 sEgPOO6UOiHPhtMTQTy3pflyqkVGi/JU/3ZHovq1jyE/WUR+KUa8a6C0Iu73YQAWbz
	 ZhzbDBxxg0Dc2fpuhMuxjuAxK9GQjArTDp70pxrHd2MhUfwvt9hFzTjWDWDWfcVk4r
	 52UFgBm80rKq5cTIPKXaykx0pMBbJ03/A/3WqmgP7Ke3NncqpLQT8RtonndklWve/N
	 pBh0ov4J35sJjDs/v1VEv/itmIFAzhLHQtMNfakq4+miUPA5AHptO7v/3vYUxOTjUd
	 w4a8L2jLKZwlQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: abort transaction on unexpected eb generation at btrfs_copy_root()
Date: Mon, 19 May 2025 11:42:05 +0100
Message-Id: <dcdf72739099f866948759b2171794db87fb0c09.1747649462.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1747649462.git.fdmanana@suse.com>
References: <cover.1747649462.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

If we find an unexpected generation for the extent buffer we are cloning
at btrfs_copy_root(), we just WARN_ON() and don't error out and abort the
transaction, meaning we allow to persist metadata with an unexpected
generation. Instead of warning only, abort the transaction and return
-EUCLEAN.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index ae6cd77282f5..a5ee6ce312cf 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -283,7 +283,14 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
 
 	write_extent_buffer_fsid(cow, fs_info->fs_devices->metadata_uuid);
 
-	WARN_ON(btrfs_header_generation(buf) > trans->transid);
+	if (unlikely(btrfs_header_generation(buf) > trans->transid)) {
+		btrfs_tree_unlock(cow);
+		free_extent_buffer(cow);
+		ret = -EUCLEAN;
+		btrfs_abort_transaction(trans, ret);
+		return ret;
+	}
+
 	if (new_root_objectid == BTRFS_TREE_RELOC_OBJECTID) {
 		ret = btrfs_inc_ref(trans, root, cow, 1);
 		if (ret)
-- 
2.47.2


