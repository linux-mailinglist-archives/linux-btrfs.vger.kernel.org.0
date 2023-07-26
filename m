Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C235763BBC
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jul 2023 17:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234332AbjGZP5X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jul 2023 11:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234010AbjGZP5W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jul 2023 11:57:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7E5212B
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 08:57:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7E3561B9C
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 15:57:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A765C433C9
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 15:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690387040;
        bh=sinHIe0/aPeYxie4Z8WqvVnTpKpRzTGkYjoZZii1p88=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ScA1GYlTsQUi/VpMVZPJhJ4XIX0d2o0NNgA7NuId3HjCvZTYLKo8f7ZfjZmWorhzw
         PBcUTWz+YBuuMSPJaVRcaK2QMdtzbUFVYP1BbWvou/6d3i4jipEp53S7e5qixQDN8U
         4Elxbz8iq5oHA9yZRW+XdxmIqLudEHPsyc+PaXCDeJB5zY1QTAcRIX2s/znTN0mvKQ
         XwFGG550gvphikNkpX3s+ciiedDqw1ZyhY5rgLtSS2g/X0Io0Df5Iv16o40WzFuxXc
         L+e+YFghRT9Fto9G6vroeCJxsbK6ZkR/cmqSNkALqtObQ8GqGX21lYkBUU77zHUa1D
         R4zsTLw6XsP5Q==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 03/17] btrfs: print target number of bytes when dumping free space
Date:   Wed, 26 Jul 2023 16:56:59 +0100
Message-Id: <b5a197b244f0f91b15bbf4b6cd9ffbf199e3fd28.1690383587.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1690383587.git.fdmanana@suse.com>
References: <cover.1690383587.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When dumping free space, with btrfs_dump_free_space(), we pass a bytes
argument in order to count how many free space entries in the block group
have a size greater than or equal to that number of bytes. We then print
how many suitable entries we found, but we don't print the target number
of bytes, we just say "bytes". Change the message to actually print the
number of bytes, which makes debugging -ENOSPC issues a bit easier.

Also sligthly change the odd grammar and terminology: the sentence is
ending with 'is', which doesn't make sense, and the term 'blocks' is
confusing as we are referring to free space entries within the block
group's free space cache.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/free-space-cache.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index bfc01352351c..cd5bfda2c259 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2943,7 +2943,8 @@ void btrfs_dump_free_space(struct btrfs_block_group *block_group,
 	btrfs_info(fs_info, "block group has cluster?: %s",
 	       list_empty(&block_group->cluster_list) ? "no" : "yes");
 	btrfs_info(fs_info,
-		   "%d blocks of free space at or bigger than bytes is", count);
+		   "%d free space entries at or bigger than %llu bytes",
+		   count, bytes);
 }
 
 void btrfs_init_free_space_ctl(struct btrfs_block_group *block_group,
-- 
2.34.1

