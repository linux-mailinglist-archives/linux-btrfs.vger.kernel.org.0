Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2115F9CA9
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Oct 2022 12:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbiJJKWu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Oct 2022 06:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbiJJKWj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Oct 2022 06:22:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0B06B8CA
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 03:22:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 238C3B80D99
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 10:22:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63AE9C433D6
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 10:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665397349;
        bh=Ydd7XrNtQanncJc+agHB/7DLxRHL6YAvBmgB+GRihYM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=mHcU3bot6rS6RRjnDz4fF0PoP99jK5fm6CUzp51eJ5kkvzwFph8MxCwEmt1nj7Peo
         wTMGaNWNKmo+Ixr9LWbVr8cChHq+kGgCCZYahEPyLM8FJSAqWBHCPuW7PsUR3uhipc
         0S1vu+VDTgTrjl6bF5vIRilWdHe0PXH85je8WQRqCYmO8pSMOgCgINzSHof59m2Sel
         6ESloV/DRyqXpjXJ6Ju1R3kv4wZXd1idIHcD90fjI9ZkLK1MiA3XgSlnFxWNn7CbhC
         aH+yU6S3Vaq+2t9SyMArdkDpi3ZbqJ1tYK+ql1e/I97chB+sl+bnoKr1spZGlp/pgm
         Fc3g60Su441uA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 07/18] btrfs: drop redundant bflags initialization when allocating extent buffer
Date:   Mon, 10 Oct 2022 11:22:09 +0100
Message-Id: <ada1ba1d03ae7263d64ffb649d55328869a3417a.1665396437.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1665396437.git.fdmanana@suse.com>
References: <cover.1665396437.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When allocating an extent buffer, at __alloc_extent_buffer(), there's no
point in explicitly assigning zero to the bflags field of the new extent
buffer because we allocated it with kmem_cache_zalloc().

So just remove the redundant initialization, it saves one mov instruction
in the generated assembly code for x86_64 ("movq $0x0,0x10(%rax)").

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_io.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c9a9f784d21c..ca67f041e43e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4269,7 +4269,6 @@ __alloc_extent_buffer(struct btrfs_fs_info *fs_info, u64 start,
 	eb->start = start;
 	eb->len = len;
 	eb->fs_info = fs_info;
-	eb->bflags = 0;
 	init_rwsem(&eb->lock);
 
 	btrfs_leak_debug_add_eb(eb);
-- 
2.35.1

