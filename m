Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884FB4FF9EE
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Apr 2022 17:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236425AbiDMPXO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Apr 2022 11:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236422AbiDMPXN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Apr 2022 11:23:13 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E9322524
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Apr 2022 08:20:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 585BACE21D3
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Apr 2022 15:20:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40195C385A4
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Apr 2022 15:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649863247;
        bh=YUqtFQblmDBlKp2S37N17KpAJETp28xhR8UPqKi+h1c=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=WrJBnYxz4fum6vBLrABHK9uFzXgz+bh82NAjZMsHgFzjiHkUgbADLAPm05Tysf2gl
         cEk/5eMOekt4JTHBZ4kBjuNVYJnEYlq9QC9JUWUHWWXMcHt95j1B24hsKsq9ie+3C2
         eHuvMqKE5LhK9EL8GhGPPIR2+BzofDCCkKW3/OirDp/5Uxu+lYMYGz9i7Noh5txZY/
         Z7MMaQVS3fnEEoRNXaj3BGg9B/GWdkg9w6ACQmU1M+h/UCSu/38J1T74LsxWsM+KW1
         ELbr8f1bMMhe4yh4fR+euVHH5AM42XMptIm4RoeLIOB9gavOGiJWc9zJEtlk8AKRBG
         9LGYwAzIXjHHA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/5] btrfs: remove search start argument from first_logical_byte()
Date:   Wed, 13 Apr 2022 16:20:39 +0100
Message-Id: <f422c0efabbf097771c2e7d6ea713d6ddfa9adb3.1649862853.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1649862853.git.fdmanana@suse.com>
References: <cover.1649862853.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The search start argument passed to first_logical_byte() is always 0, as
we always want to get the logical start address of the block group with
the lowest logical start address. So remove it, as not only it is not
necessary, it also makes the following patches that change the lock that
protects the red black tree of block groups from a spin lock to a
read/write lock.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-tree.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index fc5b9be06ec8..2a718727541c 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2492,7 +2492,7 @@ static u64 get_alloc_profile_by_root(struct btrfs_root *root, int data)
 	return ret;
 }
 
-static u64 first_logical_byte(struct btrfs_fs_info *fs_info, u64 search_start)
+static u64 first_logical_byte(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_block_group *cache;
 	u64 bytenr;
@@ -2504,7 +2504,8 @@ static u64 first_logical_byte(struct btrfs_fs_info *fs_info, u64 search_start)
 	if (bytenr < (u64)-1)
 		return bytenr;
 
-	cache = btrfs_lookup_first_block_group(fs_info, search_start);
+	/* Get the block group with the lowest logical start address. */
+	cache = btrfs_lookup_first_block_group(fs_info, 0);
 	if (!cache)
 		return 0;
 
@@ -4267,7 +4268,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
 		return ret;
 
 	ffe_ctl->search_start = max(ffe_ctl->search_start,
-				    first_logical_byte(fs_info, 0));
+				    first_logical_byte(fs_info));
 	ffe_ctl->search_start = max(ffe_ctl->search_start, ffe_ctl->hint_byte);
 	if (ffe_ctl->search_start == ffe_ctl->hint_byte) {
 		block_group = btrfs_lookup_block_group(fs_info,
-- 
2.35.1

