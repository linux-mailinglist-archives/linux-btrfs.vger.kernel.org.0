Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2565A5FB23D
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Oct 2022 14:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiJKMR3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Oct 2022 08:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiJKMRW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Oct 2022 08:17:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869B642E50
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 05:17:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 417B1B815B3
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 12:17:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 814D6C433C1
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 12:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665490639;
        bh=KZB5HiCiAzQDv4MD+fbkXTqvjvIwuYOQUoXd8iAgIfA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=XSFgQraLmbC9iibQdc8kbcAL0rJMaOeM94ah4fc36NIjXlIzB1kNzA6RbtNQMztIK
         Br38yIQo0gktYBpk0gQQpT7N0R5urb0um1cnBdwJ00Eg6yHiVYaE28LacXdhE8HDQ3
         JNsSaRR9hewHFqdl1P2pR/uowDWlPCkYxUc1iJDh7rH/85L8694q0L0QdwBxtLl0oq
         +fRW98SGqsNcJ4qsDLkpX7sH0iSXHE3o1ukEB4670OG0XR0irLTnqCa3UtiZA/jAw/
         IKkbqX13/5uRZ69/RQJb03TUqH3c+dEYH0BiAlxS5bWKOPQYjrwLrN03m0zyQdNDAp
         uWvHsm0g5GqwA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 07/19] btrfs: drop pointless memset when cloning extent buffer
Date:   Tue, 11 Oct 2022 13:16:57 +0100
Message-Id: <624ea4cace0e7dc7ec9fd3983159121a8311d8fc.1665490018.git.fdmanana@suse.com>
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

