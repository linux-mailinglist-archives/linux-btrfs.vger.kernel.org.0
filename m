Return-Path: <linux-btrfs+bounces-3257-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAF287AFF4
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Mar 2024 19:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DA4D1F2AF87
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Mar 2024 18:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D31D83CD8;
	Wed, 13 Mar 2024 17:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWdO8o/K"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0B883CD0
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Mar 2024 17:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710350907; cv=none; b=fN7Pi/XQv+mRTiD8K9kXHlvJIhkVjI12a1lye11q75izphwy6l+GpD55307OljSRH3YIjlyk5ZFSXrldONTxTWFiIyVtX84hr465zpZ5/iM6hXuLZz13EwP/WwsRMlsN2+fS8FoX99MEphEjss5mTxG/ao7FOC59ZIznY/sZNuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710350907; c=relaxed/simple;
	bh=QGx4x/dap8z34uSrgy9vLkFO9eETVAAiMwooC5u/gFY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n9Yp+5l2C56eJXfFm4YjXHuPFMuEbVWek8sYKKmnwXMdm8LmWRwYhPOtDuGe7ld+AsFyHlGnTxoez52exObc4BctobTgGVI6OPgBoc61MrNsh16Og2ovqk1/jmkMVE7JO7yeYlGLLCtuOyA9tj7RDMf8B77W1NVgwL9O4WDDvh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VWdO8o/K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B413C43394
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Mar 2024 17:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710350907;
	bh=QGx4x/dap8z34uSrgy9vLkFO9eETVAAiMwooC5u/gFY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=VWdO8o/KXD3Aua6WJgbn7fFqupLxI+FviGXCt5xwFkXGgLeCZ4bCcIcJMehlwa9up
	 Xn1PmBLi6O189PQDfHgjt+JU4oMLOUcA03rjXTYwBbnhj7PEwoTLgMh98lJaJeRKzi
	 7qtd8foy2B0ftHWx+7fQphL94/St/2t5lK3uTIYaRQ++ERYZUM+vfzhvdMSaohQaci
	 DejqUuEFsAxJT2YkEytbwx3vQ+78bVh8UNMqQnuhP/s/GEDKD2RI9RD8+Jcdv+YHNj
	 QxlselXlP2Ia0O7Tiba5P9wN0g3bbztYj3H7hIK0K3RsMdL5QZQWVTPhKaBwk5R4MN
	 lsZfoOhcPGLRA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/4] btrfs: fix extent map leak in unexpected scenario at unpin_extent_cache()
Date: Wed, 13 Mar 2024 17:28:19 +0000
Message-Id: <f3c7f68caa8f3568fbf2d561b35604823bb5985f.1710350741.git.fdmanana@suse.com>
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


