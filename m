Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A27F5FB23E
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Oct 2022 14:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiJKMR0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Oct 2022 08:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiJKMRV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Oct 2022 08:17:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D779650193
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 05:17:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7322A60AF5
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 12:17:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640AAC43470
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 12:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665490639;
        bh=Ydd7XrNtQanncJc+agHB/7DLxRHL6YAvBmgB+GRihYM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=uRmSDlGFzIz0J+/4JU7X0CZG4dUfPvNT8kxWtuyqlaY3XafkxlLXS0QgHvTtN1P+V
         yw5PNyRUDLRaiuQEIPLYTUCcwqPzYCqw9nIJhSf0kq8L6aijJVfXU9jjE8GElSCEj/
         AQZ9DfjT89/sbHAnMvg7/eYX230VBLkkFxWMzHULfK7IefRyvQVjTa0OgIoD8uJLRM
         h5GW+UcHlav6TD9BI1PRZ9hNu+D1V3hGeRIjw3nhxclNHbTtuw57zXPTJtSgnV9Xph
         rUnsISbKdHpzg/jM9T7sdNGhv4jXMo8tx4HHO7huFUg5f/4XA9ZCu12kGMbCmOwMLK
         JDKijxfjxyO+A==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 08/19] btrfs: drop redundant bflags initialization when allocating extent buffer
Date:   Tue, 11 Oct 2022 13:16:58 +0100
Message-Id: <a5ead132db92d437f5a18a7d8e8c855a18f3e012.1665490018.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1665490018.git.fdmanana@suse.com>
References: <cover.1665490018.git.fdmanana@suse.com>
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

