Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3204D9E92
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Mar 2022 16:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235160AbiCOPYB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Mar 2022 11:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbiCOPYA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Mar 2022 11:24:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8E02F3
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 08:22:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B2E161031
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 15:22:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F712C340E8
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 15:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647357766;
        bh=prLo2g90VxRuGXkHVFyxoTFtd9+a4i/uZs830m2R60w=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Qvn6iYKeL1QfEqaqWITKtOUljLpo3R/oADcpTycaB90Tzw8/63mhF8Gud9rTTAu7z
         15BvV4sKvNwPavYcRmFIdtHJq83410LF39a4YQByw7XmdMYGeUQP9DJFTxAp4UVBoy
         ezQ0I0FrJo+Cbs22MSZao9EOCy2dDMcKbHaxZOQR+xc3VzG5JeFJc7qIuND9iRpmnH
         PHTJGK5zIdj8h3jEIYQJEGs0i7jx1l9izXyH7lXnh5+FtJKhqBUam04f7kr2xLy2Sl
         wDtuYamcxj4xFMSFfHqEWWdTsPR2ZgiAxrFN/lTFBNIIeespRqVI8USbvsglOWnuEp
         utr9DKCmVqHqw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 2/7] btrfs: remove useless dio wait call when doing fallocate zero range
Date:   Tue, 15 Mar 2022 15:22:36 +0000
Message-Id: <24b528bd19fa4dfd2539db3b5a61c25ae45ec278.1647357395.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1647357395.git.fdmanana@suse.com>
References: <cover.1647357395.git.fdmanana@suse.com>
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

