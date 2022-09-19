Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710255BCE02
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Sep 2022 16:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiISOG5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Sep 2022 10:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiISOGy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Sep 2022 10:06:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF32B2A96B
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Sep 2022 07:06:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 755BCB81BFB
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Sep 2022 14:06:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B806BC433D6
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Sep 2022 14:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663596411;
        bh=WJEpBJfhykFovmLVrPLj9NNfdkY+wsWDqY0EqXMeNMI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ANzGqtumzzyqMnzvlgIZg/umGV/gluPuYpxjXmrcwqAX/4yxmdLsO5MKiCgBjyLui
         V5wgtDp4q1VzIlsvAC3M/YEhEluApxuKNTZMwZhXzpeu4ZLplU4exOiItLyhhJ4wf+
         CuNvqXHyRMnKauohn/sKeoESZQmFrCkAjQjVC4ZBe3CwWgFOmMU53Y02FDj95crDDX
         ddX5FXSWfdGQznCki/9l5FFsTGwhJATplrRTHVYVxKChA7REs/paClo1R1Ha5ZgwoW
         9Jf1LEPNiwDYUUgpigPTorFuJggHxc+8xLR5ejddHJnwMuKG8phID2KAuZFmZ3WIag
         9f7MiH0w5rYqQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 08/13] btrfs: remove unnecessary extent map initializations
Date:   Mon, 19 Sep 2022 15:06:35 +0100
Message-Id: <8132be7f2f8e6d32e070f722cd162d1b4989b02f.1663594828.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1663594828.git.fdmanana@suse.com>
References: <cover.1663594828.git.fdmanana@suse.com>
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

When allocating an extent map, we use kmem_cache_zalloc() which guarantees
the returned memory is initialized to zeroes, therefore it's pointless
to initialize the generation and flags of the extent map to zero again.

Remove those initializations, as they are pointless and slightly increase
the object text size.

Before removing them:

   $ size fs/btrfs/extent_map.o
      text	   data	    bss	    dec	    hex	filename
      9241	    274	     24	   9539	   2543	fs/btrfs/extent_map.o

After removing them:

   $ size fs/btrfs/extent_map.o
      text	   data	    bss	    dec	    hex	filename
      9209	    274	     24	   9507	   2523	fs/btrfs/extent_map.o

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_map.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 2e6dc5a772f4..6b7eee92d981 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -55,9 +55,7 @@ struct extent_map *alloc_extent_map(void)
 	if (!em)
 		return NULL;
 	RB_CLEAR_NODE(&em->rb_node);
-	em->flags = 0;
 	em->compress_type = BTRFS_COMPRESS_NONE;
-	em->generation = 0;
 	refcount_set(&em->refs, 1);
 	INIT_LIST_HEAD(&em->list);
 	return em;
-- 
2.35.1

