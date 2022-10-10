Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEE65F9CA5
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Oct 2022 12:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbiJJKWm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Oct 2022 06:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbiJJKWg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Oct 2022 06:22:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880CE6B652
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 03:22:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87CF960EE7
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 10:22:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E673C433C1
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 10:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665397349;
        bh=KZB5HiCiAzQDv4MD+fbkXTqvjvIwuYOQUoXd8iAgIfA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=djWfCHdIPbvghQDopPb9C1uL4fPJ8hUo82xEkryfUZuRveKV4btYD9O9aQa6YQEAL
         wpbG4wqYuFTRLhFfOJDdM3QWQhen2fHUcvw/b7b06y0zV0WU0MeqoAOT6N/n3zU4tD
         tP2TXAGc4q70ToKtf+Tf6ABolHyUAzMAJIW+oMvC2LwhYIY+BNXTarX8Z4a4DJyKNq
         h8g9fVn4WCGa52nEWBOBTPBa2uvpn4YC6WdApUDS+kxWmO1EeXHJ16fHK3tuwaXMNb
         B79DnlMLfsJreFUrlOpErMaOwMjpMwKih0nD3L7BWgAiOlPRcuuePDAQlcd+3UNTHG
         n9KT3Z5MArAQA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 06/18] btrfs: drop pointless memset when cloning extent buffer
Date:   Mon, 10 Oct 2022 11:22:08 +0100
Message-Id: <bc0998eb62c0cf79f7ec38abf4c758b7a6be2894.1665396437.git.fdmanana@suse.com>
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

At btrfs_clone_extent_buffer(), before allocating the pages array for the
new extent buffer we are calling memset() to zero out the pages array of
the extent buffer. This is pointless however, because the extent buffer
already has every element in its pages array pointing to NULL, as it was
allocated with kmem_cache_zalloc(). The memset() was introduced with
commit dd137dd1f2d719 ("btrfs: factor out allocating an array of pages"),
but even before that commit we already depended on the pages array being
initialized to NULL for the error paths that need to call
btrfs_release_extent_buffer().

So remove the memset(), it's useless and slightly increases the object
text size.

Before this change:

   $ size fs/btrfs/extent_io.o
      text	   data	    bss	    dec	    hex	filename
     70580	   5469	     40	  76089	  12939	fs/btrfs/extent_io.o

After this change:

   $ size fs/btrfs/extent_io.o
      text	   data	    bss	    dec	    hex	filename
     70564	   5469	     40	  76073	  12929	fs/btrfs/extent_io.o

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_io.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1eae68fbae21..c9a9f784d21c 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4302,7 +4302,6 @@ struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
 	 */
 	set_bit(EXTENT_BUFFER_UNMAPPED, &new->bflags);
 
-	memset(new->pages, 0, sizeof(*new->pages) * num_pages);
 	ret = btrfs_alloc_page_array(num_pages, new->pages);
 	if (ret) {
 		btrfs_release_extent_buffer(new);
-- 
2.35.1

