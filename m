Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 055AAD729B
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2019 11:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfJOJyo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Oct 2019 05:54:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:35614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727080AbfJOJyo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Oct 2019 05:54:44 -0400
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5722720659
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Oct 2019 09:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571133283;
        bh=1BYQWQSaTL7RO3sMheEQ030qwfbqK0b147n0SbY/vlk=;
        h=From:To:Subject:Date:From;
        b=QFaAakGuv74SMVo2D9Dqq3DAnCesHiuKm5m5IZJrD5jeU4Zv+N54EPdWlJ90+VDwJ
         GBZz6OdvQ+BgiCyCprpQYyz3enuv3ezU8P0dZim4A4UsVzEaZPA2a1jPqKioMwUiLv
         QhAZLa5RAQ6UtdYzM9uFXKMQijgVxsndDEcn884A=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] Btrfs: fix qgroup double free after failure to reserve metadata for delalloc
Date:   Tue, 15 Oct 2019 10:54:39 +0100
Message-Id: <20191015095439.6511-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

If we fail to reserve metadata for delalloc operations we end up releasing
the previously reserved qgroup amount twice, once explicitly under the
'out_qgroup' label by calling btrfs_qgroup_free_meta_prealloc() and once
again, under label 'out_fail', by calling btrfs_inode_rsv_release() with a
value of 'true' for its 'qgroup_free' argument, which results in
btrfs_qgroup_free_meta_prealloc() being called again, so we end up having
a double free.

Also if we fail to reserve the necessary qgroup amount, we jump to the
label 'out_fail', which calls btrfs_inode_rsv_release() and that in turns
calls btrfs_qgroup_free_meta_prealloc(), even though we weren't able to
reserve any qgroup amount. So we freed some amount we never reserved.

So fix this by removing the call to btrfs_inode_rsv_release() in the
failure path, since it's not necessary at all as we haven't changed the
inode's block reserve in any way at this point.

Fixes: c8eaeac7b73434 ("btrfs: reserve delalloc metadata differently")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delalloc-space.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index d949d7d2abed..fe68d0e078bd 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -381,7 +381,6 @@ int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes)
 out_qgroup:
 	btrfs_qgroup_free_meta_prealloc(root, qgroup_reserve);
 out_fail:
-	btrfs_inode_rsv_release(inode, true);
 	if (delalloc_lock)
 		mutex_unlock(&inode->delalloc_mutex);
 	return ret;
-- 
2.11.0

