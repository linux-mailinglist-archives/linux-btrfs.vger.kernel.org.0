Return-Path: <linux-btrfs+bounces-5065-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0A88C86FF
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2024 15:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 808011C209A0
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2024 13:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF065466E;
	Fri, 17 May 2024 13:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZnyDQrj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD1953E2C
	for <linux-btrfs@vger.kernel.org>; Fri, 17 May 2024 13:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715951611; cv=none; b=n3Q6mjPJxdKr1pitmPxYEx0NW7WQLlzZEWeju/1tTKHEFyyT1KNbds19nvJCLa6b7KNZ78kDU1DkUG/theh94Nn9Ohx9LOI7ulWjMSRUrfgW8xpG5ygFNdpHaqIrNjKDOmdLNGSts4F8a4M99uNfXD8UQcmkbPE5mXox+bf16ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715951611; c=relaxed/simple;
	bh=P8ndQF60J1B7xYc4v+y67BvctIwk7KMyGDVI+J9z/vc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ya4eKpAD8MAA0hc4NY/W/X4mGa1KkCU+zStgYo2FJlJiZ1l3Y1ZzmNkW44kh8r9nCuzc1Qx4zQ2JVtEyo9xGqhNJNgq9c/OdRg8YJqAmEwAcMHweChWi+w7aq/LNTz4QRYutYw0dIPQxPGX9cJMjIDdxrFbZctog5dXP8y/Zwg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZnyDQrj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB66C2BD10
	for <linux-btrfs@vger.kernel.org>; Fri, 17 May 2024 13:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715951611;
	bh=P8ndQF60J1B7xYc4v+y67BvctIwk7KMyGDVI+J9z/vc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=oZnyDQrjsjEfCRZFZezYdwl5T+jzk74kqFMgYFrOw4d0hmKntCDfWDnXmscZO/giD
	 K7cqfReP3gCCDp9OWR1cIcXbVz5qvZYCqFpMqDhuP5V2fWWnU3ZbGUNcpirgNPm+Xi
	 ZnblJBtOG9zzY5I+XDYUE0g2De2u4inSVl6p1h/FQQGg5EMvxhnYIbwA9wLn9N6swZ
	 t8+IDpQydtJJQLvQUJSRdnghIbCN/8ys4Hv/HVTzVkIIwSn/k5RBLS2NOYlVdRMcuf
	 0CvSVk57SkM13AkNHNmrR8esBd1L19SB6CssRBu0A/ccs9mH3ecCb3ijF7WaUfQP+l
	 jEFUIi5T7zx6Q==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: use READ_ONCE() when accessing delayed_node at btrfs_dirty_node()
Date: Fri, 17 May 2024 14:13:25 +0100
Message-Id: <68f8da7780333faba472e44689f977abd7222ffc.1715951291.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1715951291.git.fdmanana@suse.com>
References: <cover.1715951291.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

An inode's delayed_node is set while holding the root->delayed_nodes
xarray's lock, so accessing it without holding the lock at
btrfs_dirty_node() is racy and will likely trigger warnings from tools
like KCSAN.

Since we update the inode's delayed_node with WRITE_ONCE(), we can use
READ_ONCE() without taking the lock, as we do in several other places
at delayed-inode.c. So change btrfs_dirty_node() to use READ_ONCE().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 000809e16aba..11cad22d7b4c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6100,7 +6100,7 @@ static int btrfs_dirty_inode(struct btrfs_inode *inode)
 		ret = btrfs_update_inode(trans, inode);
 	}
 	btrfs_end_transaction(trans);
-	if (inode->delayed_node)
+	if (READ_ONCE(inode->delayed_node))
 		btrfs_balance_delayed_items(fs_info);
 
 	return ret;
-- 
2.43.0


