Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5600430589C
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 11:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235998AbhA0KiG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jan 2021 05:38:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:52528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235819AbhA0Kfr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jan 2021 05:35:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F2F12076D
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 10:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611743705;
        bh=EBREEiWaubx8WBQ4inHpm9ndeX/pRHzU4Hn4Va7JbSo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=UfnCaQSa1U8ZvVL9JViu9NhKolOEwkSP2iAS/9ME3fIjhTv5Fx9ywdSwB68ttfyON
         tf7Yhs1FhG5JVRgrUCsHfOSPd93QusLQKZ+6epcjJfbOpyqJGNrM0PU0cG2UtpJsFn
         Jr/8P2APb/vslXQcNRXdiIesOSqg/QnwcUq0meb90ZdreKOCYCrBbt8p1+4RqPzpRF
         Ao0ERNKo9xU0wpL64z812hkGMIMESWL7gZveal/gRQsdrhMVS5cSJNlk5l4/5+Cctv
         eZpo+Hwngc22RFn8bZp6xl4Y9gk+vBbDmRPbaxBZQVPkreqLYQLgdqWEuFFR5R9VA5
         nqIZF3/BXzcMQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/7] btrfs: stop setting nbytes when filling inode item for logging
Date:   Wed, 27 Jan 2021 10:34:55 +0000
Message-Id: <6410eae15fc6e5e4d2e8a1e308412c63acd421f6.1611742865.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1611742865.git.fdmanana@suse.com>
References: <cover.1611742865.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When we fill an inode item for logging we are setting its nbytes field
with the value returned by inode_get_bytes() (a VFS API), however we do
not need it because it is not used during log replay. In fact, for fast
fsyncs, when we call inode_get_bytes() we may even get an outdated value
for nbytes because the nbytes field of the inode is only updated when
ordered extents complete, and a fast fsync only waits for writeback to
complete, it does not wait for ordered extent completion.

So just remove the setup of nbytes and add an explicit comment mentioning
why we do not set it. This also avoids adding contention on the inode's
i_lock (VFS) with concurrent stat() calls, since that spinlock is used by
inode_get_bytes() which is also called by our stat callback
(btrfs_getattr()).

This patch is part of a patchset comprised of the following patches:

  btrfs: remove unnecessary directory inode item update when deleting dir entry
  btrfs: stop setting nbytes when filling inode item for logging
  btrfs: avoid logging new ancestor inodes when logging new inode
  btrfs: skip logging directories already logged when logging all parents
  btrfs: skip logging inodes already logged when logging new entries
  btrfs: remove unnecessary check_parent_dirs_for_sync()
  btrfs: make concurrent fsyncs wait less when waiting for a transaction commit

Performance results, after applying all patches, are mentioned in the
change log of the last patch.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 5d87afc6058a..be62759f0aac 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3858,7 +3858,14 @@ static void fill_inode_item(struct btrfs_trans_handle *trans,
 	btrfs_set_token_timespec_nsec(&token, &item->ctime,
 				      inode->i_ctime.tv_nsec);
 
-	btrfs_set_token_inode_nbytes(&token, item, inode_get_bytes(inode));
+	/*
+	 * We do not need to set the nbytes field, in fact during a fast fsync
+	 * its value may not even be correct, since a fast fsync does not wait
+	 * for ordered extent completion, which is where we update nbytes, it
+	 * only waits for writeback to complete. During log replay as we find
+	 * file extent items and replay them, we adjust the nbytes field of the
+	 * inode item in subvolume tree as needed (see overwrite_item()).
+	 */
 
 	btrfs_set_token_inode_sequence(&token, item, inode_peek_iversion(inode));
 	btrfs_set_token_inode_transid(&token, item, trans->transid);
-- 
2.28.0

