Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B29614EFA
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 17:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbiKAQQK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 12:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiKAQQH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 12:16:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4478C1C90D
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 09:16:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D56A06118E
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 16:16:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC322C433C1
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 16:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667319363;
        bh=Qtx23bpKTz2je904upFct8NcI+N14XP9/xcmRzw/M08=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Tf/1mNqftqIHbxJ6R4ac+LV10hhrlZdJoYbJMUPJJG5yAbQXem+ds37gY+3dLnS5x
         dMufFZ/VMDw8cKD0Zb+8HoI0da/J+kpSM5TTKvoMC72EKJBFgT5XpDwG0QEqL34gEb
         J5xV+JiXYuAFEqlQPDd00q9HJB4+nUaxmNYmxUfZnrRfpxSorJwvQwF53Z1w/I6ZOm
         GTvyBAjzUMa+uBA8CxvT/eTF3etpMkxiCZ2MCj/NGq8va1r/xsw1/s5JbsO0DgjVXA
         Bmiz6K2ZxaYOQOaLsMiB5d/A16l/GQHL1XphWYaNglDVEp/pJJqdWRnhqAXeIkAvdK
         8qmlLnKu2iPhw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 06/18] btrfs: send: update comment at find_extent_clone()
Date:   Tue,  1 Nov 2022 16:15:42 +0000
Message-Id: <b8e7144cc32eb5547ba9a394430f3edd4357c761.1667315100.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1667315100.git.fdmanana@suse.com>
References: <cover.1667315100.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

We have this unclear comment at find_extent_clone() about extents starting
at a file offset greater than or equals to the i_size of the inode. It's
not really informative and it's misleading, since it mentions the author
found such extents with snapshots and large files.

Such extents are a result of fallocate with FALLOC_FL_KEEP_SIZE and there
is no relation to snapshots or large files (all write paths update the
i_size before inserting a new file extent item). So update the comment to
be precise about it and why we don't bother looking for clone sources in
that case.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 2226296ca691..63f2ac33e85b 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -1365,14 +1365,14 @@ static int find_extent_clone(struct send_ctx *sctx,
 	int compressed;
 	u32 i;
 
-	if (data_offset >= ino_size) {
-		/*
-		 * There may be extents that lie behind the file's size.
-		 * I at least had this in combination with snapshotting while
-		 * writing large files.
-		 */
+	/*
+	 * With fallocate we can get prealloc extents beyond the inode's i_size,
+	 * so we don't do anything here because clone operations can not clone
+	 * to a range beyond i_size without increasing the i_size of the
+	 * destination inode.
+	 */
+	if (data_offset >= ino_size)
 		return 0;
-	}
 
 	fi = btrfs_item_ptr(eb, path->slots[0], struct btrfs_file_extent_item);
 	extent_type = btrfs_file_extent_type(eb, fi);
-- 
2.35.1

