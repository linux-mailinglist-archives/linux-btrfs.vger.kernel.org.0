Return-Path: <linux-btrfs+bounces-3258-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F92B87AFF5
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Mar 2024 19:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE42E28BC64
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Mar 2024 18:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE7184055;
	Wed, 13 Mar 2024 17:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XkjBhpsC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B00783CDB
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Mar 2024 17:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710350908; cv=none; b=BIYVs0jFxAWF6B2d5ktFBVcGCndG/EFhlOfOkv0/xZ86UhZ2aathihLtEExw4a5sx5PetOcJzdZaA4p6eGypsSH2hz0JbSyZ/xqfKWEkIG27MaobAGZ4r3vPThpnNZvQ0iLrHf0SUfAqB1rS5zmWKav+Y26cU6y+JSb9GNmgBoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710350908; c=relaxed/simple;
	bh=0qHg+kqnHcIbRamgUH5v7fnWmZdE08NLcXsJknoxAbc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ETCb9/n2BeeYRtypNEWyNtPBL5eFFV5xXjTMXbPDYSCK0y+zT+mX3sPzw0S5SD0l+rlO9+TQDIVVo3/YnxpZ3S005z/pr0iNU+9OMFzbnud7MKad6KZfCz9fS5QgUJMPnebv7dIn79bLQIGFElgSQeX3By8MYBLJ1mTCC9eiI7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XkjBhpsC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C2EC433C7
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Mar 2024 17:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710350907;
	bh=0qHg+kqnHcIbRamgUH5v7fnWmZdE08NLcXsJknoxAbc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=XkjBhpsCUyRi9Uvw2R7xQToAH9NvCsqq8ry3ScqliJKRpD2/tMdMsNOrQzpLq88/t
	 VxxsBkhJnl05UMUuLFSorVuKVnEeI4+swNzCTUSUzQk9cTwbf2WBp8fhjyOduP0PE/
	 1RbVsfFeq9ETwgQyT3Wi/w4Gxe/0EhOFftbIchAYrerTxZeNEKl6ri8gvb7vnXrllk
	 ISqNUAFuEqSfMnUJm13aM/l/d82L0NuvrZW+bun/TIdrXOOlmXngiXVaR4lRCL6SRh
	 Hm/bvf20nxrZlJtShYwmYIFBG8FG/pa4fwEghVL+/+gMqXdvpdsUk06DvXI/Nw6NHO
	 1w1RBqFnb8xPg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/4] btrfs: fix warning messages not printing interval at unpin_extent_range()
Date: Wed, 13 Mar 2024 17:28:20 +0000
Message-Id: <7039902fc65bb3ec188a461436d19afbc71da1c1.1710350741.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1710350741.git.fdmanana@suse.com>
References: <cover.1710350741.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

At unpin_extent_range() we print warning messages that are supposed to
print an interval in the form "[X, Y)", with the first element being an
inclusive start offset and the second element being the exclusive end
offset of a range. However we end up printing the range's length instead
of the range's exclusive end offset, so fix that to avoid having confusing
and non-sense messages in case we hit one of these unexpected scenarios.

Fixes: 00deaf04df35 ("btrfs: log messages at unpin_extent_range() during unexpected cases")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_map.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index e03953dbcd5e..2cfc6e8cf76f 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -309,7 +309,7 @@ int unpin_extent_cache(struct btrfs_inode *inode, u64 start, u64 len, u64 gen)
 		btrfs_warn(fs_info,
 "no extent map found for inode %llu (root %lld) when unpinning extent range [%llu, %llu), generation %llu",
 			   btrfs_ino(inode), btrfs_root_id(inode->root),
-			   start, len, gen);
+			   start, start + len, gen);
 		ret = -ENOENT;
 		goto out;
 	}
@@ -318,7 +318,7 @@ int unpin_extent_cache(struct btrfs_inode *inode, u64 start, u64 len, u64 gen)
 		btrfs_warn(fs_info,
 "found extent map for inode %llu (root %lld) with unexpected start offset %llu when unpinning extent range [%llu, %llu), generation %llu",
 			   btrfs_ino(inode), btrfs_root_id(inode->root),
-			   em->start, start, len, gen);
+			   em->start, start, start + len, gen);
 		ret = -EUCLEAN;
 		goto out;
 	}
-- 
2.43.0


