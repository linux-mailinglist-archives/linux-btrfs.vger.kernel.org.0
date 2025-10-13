Return-Path: <linux-btrfs+bounces-17731-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB49BD58AC
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 19:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 369E618A5D40
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 17:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD5F308F1E;
	Mon, 13 Oct 2025 17:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tTuTPn3l"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FF4309DAF
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 17:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760377108; cv=none; b=uVYSrGHg5PMjgj/xsOw61f88eDfrlxd25sjftn5iFTAo+wNUBIoeu8BTa8ky3vulpFc8LGJ/TRLetVNfqeaPF03thYR0OJjKZgP134i+dzUt7zHJMMZ0H7M2gCIil0INEqRggajS8ZqmYySo0AhlwFKBV65GG1T++06Ww8qmsRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760377108; c=relaxed/simple;
	bh=GvtBiGz+4YRFKxIzOPjShmFZCkcP/I2AX380j3NKlT4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rClvoMTr3KOkzm6U5xFQNwLxL5QM0I9JxgLQwNyK0XlthjGiYiaJU+AyMRvuGMxI8Rds4GX1kTjqYI2Z7E6SyUCZVqbaOCV7XTByi76P60Lb8qfFwocX+kfcxtS6mOEHRAcgeVDwuAGGIMWc6WTHKRBXsFXnMWgwyzDJKlRZt1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tTuTPn3l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86386C4CEFE
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 17:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760377108;
	bh=GvtBiGz+4YRFKxIzOPjShmFZCkcP/I2AX380j3NKlT4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=tTuTPn3l4ofppso5Dylcd53jwIJAVOkmmpc+6ldcHQRkPMC9pS4qgI6pYFyrLA+n2
	 U42EcNcxAJ7lnSX5iMX9+7q4ItLqzQkyo1hFhsoL8uVHnJwcsNtV1E2OahzLH5xE2e
	 O2RAY3AVBxOifRLfMkBB4jfyXayOrPCOJcIqzPM+OZCczWyxzzuNTr99OyXeDWd+Sv
	 qK2Q0B92GpRAdJaM5bRmiADxNIx6Pmy+ewW5hiZhK2pMbdlxpiqqULSSgYzPTvFj7E
	 DhjMlvRi5bUI0nx6AofJ0LiMy36i6khCY4DSPKzye7NpQ1mo8GBNW2FeITY/QbkN04
	 sAH2xeDoA3gjQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 14/16] btrfs: fix parameter documentation for btrfs_reserve_data_bytes()
Date: Mon, 13 Oct 2025 18:38:09 +0100
Message-ID: <b167886398f26907b7a49aaf1b18285ab204f2a9.1760376569.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1760376569.git.fdmanana@suse.com>
References: <cover.1760376569.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We don't have a fs_info argument anymore since commit 5d39fda880be
("btrfs: pass btrfs_space_info to btrfs_reserve_data_bytes()"), it
was replaced by a space_info argument. So update the documentation.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/space-info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 7e4e185fdcf5..39eba78ed422 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1882,7 +1882,7 @@ int btrfs_reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
 /*
  * Try to reserve data bytes for an allocation.
  *
- * @fs_info: the filesystem
+ * @space_info: the space_info we're allocating for
  * @bytes:   number of bytes we need
  * @flush:   how we are allowed to flush
  *
-- 
2.47.2


