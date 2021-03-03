Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E581F32C534
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Mar 2021 01:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446671AbhCDATm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Mar 2021 19:19:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:41128 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349181AbhCCLfS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Mar 2021 06:35:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614768116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=AYoEmFrxssQ8KjalDlaFR/uuFo8Og7bOQmoq4RMfw+o=;
        b=dFvY6ssOrjhopG0bakHjc+4zkBDhk+1hi7p0Z23KwpkRZkuNGDct9D1r+mBXjQ/CgBrAW2
        4D3gaNZYSD/55IhiSlUMSa60xb0zrzc1UmqaFpz6nhR7YncW2L2Ay5Okxi1+5q+Tfsicow
        /dpwxHa3eoilCAEign8SBW07ZVtSK34=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3988CAE85
        for <linux-btrfs@vger.kernel.org>; Wed,  3 Mar 2021 10:41:56 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/2] btrfs: use a dedicated variable for qgroup released data rsv for insert_prealloc_file_extent()
Date:   Wed,  3 Mar 2021 18:41:51 +0800
Message-Id: <20210303104152.105877-1-wqu@suse.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a piece of weird code in insert_prealloc_file_extent(), which
looks like:

	ret = btrfs_qgroup_release_data(inode, file_offset, len);
	if (ret < 0)
		return ERR_PTR(ret);
	if (trans) {
		ret = insert_reserved_file_extent(trans, inode,
						  file_offset, &stack_fi,
						  true, ret);
	...
	}
	extent_info.is_new_extent = true;
	extent_info.qgroup_reserved = ret;
	...

Note how the variable @ret is abused here, and if anyone is adding code
just after btrfs_qgroup_release_data() call, it's super easy to
overwrite the @ret and cause tons of qgroup related bugs.

Fix such abuse by introducing new variable @qgroup_released, so that we
won't reuse the existing variable @ret.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- None
---
 fs/btrfs/inode.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 4f2f1e932751..4e9717c29451 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9873,6 +9873,7 @@ static struct btrfs_trans_handle *insert_prealloc_file_extent(
 	struct btrfs_path *path;
 	u64 start = ins->objectid;
 	u64 len = ins->offset;
+	int qgroup_released;
 	int ret;
 
 	memset(&stack_fi, 0, sizeof(stack_fi));
@@ -9885,14 +9886,14 @@ static struct btrfs_trans_handle *insert_prealloc_file_extent(
 	btrfs_set_stack_file_extent_compression(&stack_fi, BTRFS_COMPRESS_NONE);
 	/* Encryption and other encoding is reserved and all 0 */
 
-	ret = btrfs_qgroup_release_data(inode, file_offset, len);
-	if (ret < 0)
-		return ERR_PTR(ret);
+	qgroup_released = btrfs_qgroup_release_data(inode, file_offset, len);
+	if (qgroup_released < 0)
+		return ERR_PTR(qgroup_released);
 
 	if (trans) {
 		ret = insert_reserved_file_extent(trans, inode,
 						  file_offset, &stack_fi,
-						  true, ret);
+						  true, qgroup_released);
 		if (ret)
 			return ERR_PTR(ret);
 		return trans;
@@ -9905,7 +9906,7 @@ static struct btrfs_trans_handle *insert_prealloc_file_extent(
 	extent_info.file_offset = file_offset;
 	extent_info.extent_buf = (char *)&stack_fi;
 	extent_info.is_new_extent = true;
-	extent_info.qgroup_reserved = ret;
+	extent_info.qgroup_reserved = qgroup_released;
 	extent_info.insertions = 0;
 
 	path = btrfs_alloc_path();
-- 
2.30.1

