Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E207A2B0DC5
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 20:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgKLTVI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 14:21:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:33696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbgKLTVI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 14:21:08 -0500
Received: from debian8.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1DD620B80
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 19:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605208868;
        bh=hc8nB7TLXazIJ5se0s96h/0ebwA/UwQLTxIBXZrPXhM=;
        h=From:To:Subject:Date:From;
        b=R6CombdT1yYVaIQtCG0c2tX5D4SDLkNFO+4IdM3PY4kUZ88FmyyeadX0gUWZhhAZj
         htOvnYxDxiCh+ziUUtIFziXPkGGraEljfSHzoaMUDt165gw4Fo4LB+E1o1zS5vpVRu
         1pwSQRGnenBn2yTuVrYvoN5bHkQA02nMTymek1pU=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: correctly deal with error updating inode when inserting inline extent
Date:   Thu, 12 Nov 2020 19:21:04 +0000
Message-Id: <d3a62f4e2c8877427d5b80a454f89577b45726b4.1605208477.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When adding an inline extent, if the we failed to update the inode we must
abort the transaction if the failure reason is not -ENOSPC, since we are
now in an inconsistent state if that is the case. If the failure reason is
-ENOSPC, we should not abort the transaction and we should set the return
value to 1, so that we fallback to the normal writeback path, where we try
to create a non-inline extent.

This used to be the case before my recent patch that has the subject:

  "btrfs: update the number of bytes used by an inode atomically"

But it clearly missed that error handling detail. So just fix that up so
that the previous, and correct, behaviour is preserved.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

David, can you please fold this into the original patch?
Thanks.

 fs/btrfs/inode.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ba61340b8fc3..84a75cf86d88 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -383,8 +383,14 @@ static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 start,
 
 	btrfs_update_inode_bytes(inode, inline_len, drop_args.bytes_found);
 	ret = btrfs_update_inode(trans, root, &inode->vfs_inode);
-	if (ret)
+	if (ret && ret != -ENOSPC) {
+		btrfs_abort_transaction(trans, ret);
+		goto out;
+	} else if (ret == -ENOSPC) {
+		ret = 1;
 		goto out;
+	}
+
 	set_bit(BTRFS_INODE_NEEDS_FULL_SYNC, &inode->runtime_flags);
 	btrfs_drop_extent_cache(inode, start, aligned_end - 1, 0);
 out:
-- 
2.28.0

