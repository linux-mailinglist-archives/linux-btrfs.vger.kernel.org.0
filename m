Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1785E4D9AF9
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Mar 2022 13:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348184AbiCOMUO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Mar 2022 08:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242292AbiCOMUN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Mar 2022 08:20:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE0E522CF
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 05:19:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F3036151A
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 12:19:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3290DC340E8
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 12:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647346739;
        bh=prLo2g90VxRuGXkHVFyxoTFtd9+a4i/uZs830m2R60w=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=I+kzbnWKPIDQu7WHgODpsQPnmEQQINMZNu+xe4jQBFRg2hk4Kh50TidDJ7YSE4BbZ
         ElDZkyaUTA+r0zKky3FG1Mg7FVfqM2JBaFIIQ2sxnqkKsymfOzf/NGuxyTxrXh7tdb
         Yi52PKoz5839WymOqeavQbblFo5L9ys2RqciFjHkixyqMvcUObfHzz08lloimxBpBd
         Elu3LA8LctkbgXhKcn7A69cCQCojOQkpZNvUM2iCp/YGJjw636aiQg+Bhnwd+x4pon
         m2GJKYoSEafjDFkfHJ/tXWXXMuucHTgRXPfPCElVA0dgt5E0NGegNxQjR9sLhVoPDC
         Bmqb+WmHTN3wA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/7] btrfs: remove useless dio wait call when doing fallocate zero range
Date:   Tue, 15 Mar 2022 12:18:49 +0000
Message-Id: <678ac3f09a739ed7797248043d1f1baf1b6f10fe.1647346287.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1647346287.git.fdmanana@suse.com>
References: <cover.1647346287.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When starting a fallocate zero range operation, before getting the first
extent map for the range, we make a call to inode_dio_wait().

This logic was needed in the past because direct IO writes within the
i_size boundary did not take the inode's VFS lock. This was because that
lock used to be a mutex, then some years ago it was switched to a rw
semaphore (by commit 9902af79c01a8e ("parallel lookups: actual switch to
rwsem")), and then btrfs was changed to take the VFS inode's lock in
shared mode for writes that don't cross the i_size boundary (done in
commit e9adabb9712ef9 ("btrfs: use shared lock for direct writes within
EOF")). The lockless direct IO writes could result in a race with the
zero range operation, resulting in the later getting a stale extent
map for the range.

So remove this no longer needed call to inode_dio_wait(), as fallocate
takes the inode's VFS lock in exclusive mode and direct IO writes within
i_size take that same lock in shared mode.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index b7c0db1000cd..2f57f7d9d9cb 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3237,8 +3237,6 @@ static int btrfs_zero_range(struct inode *inode,
 	u64 bytes_to_reserve = 0;
 	bool space_reserved = false;
 
-	inode_dio_wait(inode);
-
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, alloc_start,
 			      alloc_end - alloc_start);
 	if (IS_ERR(em)) {
-- 
2.33.0

