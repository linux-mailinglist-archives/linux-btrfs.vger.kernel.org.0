Return-Path: <linux-btrfs+bounces-15549-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9820B0A949
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jul 2025 19:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7465CA42ECF
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jul 2025 17:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C506F2DCF4A;
	Fri, 18 Jul 2025 17:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwB2xd/t"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172F61C7017
	for <linux-btrfs@vger.kernel.org>; Fri, 18 Jul 2025 17:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752859212; cv=none; b=SXIkPKwq8v0rvH7+NJLfH2hiZFtGzImqMNp8T+TI42NP54/dCUBpylwPiaMUyia2JOHDRSQsmjS9s1xQCMiZa3iU5DdtVa2NWfxj3y2GFMiopkytM+5Db/YNbCP5zRVtiSBlvRIMfRtiRUdmfPpn+IVqenXUGQ/2NBrjN4fuBGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752859212; c=relaxed/simple;
	bh=heGoyTA0CH53726W/tLvZ68j8DmKXm64pxmwF6zS/1Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=bP7d5Rr6tCoSpcVRhMSiVFBbW8BtGHSSxXZEhwtkDC0n0wDEjAHlkJUimK/fqX/m098QdRu49IqR8MzRY2dhW3AcyLVAKfqqO833YghwrWpIL6niM2UCiTpkZUIfQD/rU+UniQNwaZZxCTwp1Qn5+7eVCzqwpcTq/2Ag6af/AnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwB2xd/t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24983C4CEEB
	for <linux-btrfs@vger.kernel.org>; Fri, 18 Jul 2025 17:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752859211;
	bh=heGoyTA0CH53726W/tLvZ68j8DmKXm64pxmwF6zS/1Q=;
	h=From:To:Subject:Date:From;
	b=KwB2xd/tN781jfXnhAdW4QOUo2JvcmNjbP8U4686t4oqXCCC+mh/CGIAzXGjtkfTX
	 bdIbdLL84t0VfgyiOpxYa//hJxc8NXJOM7qgRMLAvbkeS0gXCBuUvl+4FRxD579hjk
	 bkSEqUbdJQrrOQ+FaqDSA1J8gvSMkS+/LkIhAnoHGzEjJNP6izP+wHC4e6bEkOZOy6
	 oaDx5Yb8wkPPyGoe/jn5E2l0Zq58Ccmpsps15tDyvsqZpw/9q5cSdQD3NsBpQAPuzZ
	 e2RA1nRsiNVz8/Uyu9caCQjjQOe/t2OCyBzCYW90mwoHZmh4MBwnCf2ZPwnYy5F7Kz
	 11lGJGsfAOCgg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: unfold transaction aborts when writing dirty block groups
Date: Fri, 18 Jul 2025 18:20:08 +0100
Message-ID: <2289bf86333cbe87cd607891d8021abff43187a5.1752859064.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We have a single transaction abort call that can be due to an error from
one of two calls to update_block_group_item(). Unfold the transaction
abort calls so that if they happen we know which update_block_group_item()
call failed.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 47c6d040176c..9bf282d2453c 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3644,9 +3644,11 @@ int btrfs_write_dirty_block_groups(struct btrfs_trans_handle *trans)
 				wait_event(cur_trans->writer_wait,
 				   atomic_read(&cur_trans->num_writers) == 1);
 				ret = update_block_group_item(trans, path, cache);
-			}
-			if (ret)
+				if (ret)
+					btrfs_abort_transaction(trans, ret);
+			} else if (ret) {
 				btrfs_abort_transaction(trans, ret);
+			}
 		}
 
 		/* If its not on the io list, we need to put the block group */
-- 
2.47.2


