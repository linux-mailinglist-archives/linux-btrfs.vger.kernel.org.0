Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E839614EFB
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 17:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbiKAQQI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 12:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbiKAQQF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 12:16:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBD61C43C
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 09:16:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0DB761668
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 16:16:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B163AC433B5
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 16:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667319364;
        bh=3K3P9e8w5JnraVT1Fw84V2xWefAooN0iMB8CHdOJDYw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=uTjggoyS60PUZ5NjtCrZ2lAvWjBs5/sI98JX5QHOGaKNWGi2Ko+IswYQABF6rodCb
         WT3nfG8Y36k5ZCT+fFGcBJBtLC93LJHNW5vtgHvq3+wWgR0pv5llfQ0h4huZc+zOc9
         7t7lIkRSQEgMtkdiSypuB4qiEHSgZw2S51pjFfE6YqdILhEU/mQccw81MpUGSN+k62
         Pgh67Bt1HUUefO7kd2x3blcQ3QwbdZuNwSXmPWg0eFalDBbi3oCPxhQD8x3NKsXxdy
         6DsTMRcai3ITOUGmcMOAwSQ1nB9YvKVH+Yjbwh/L94SlHWah3EzmkfFALN8IvukVQm
         fIXEg/fq4cbCA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 07/18] btrfs: send: drop unnecessary backref context field initializations
Date:   Tue,  1 Nov 2022 16:15:43 +0000
Message-Id: <1f57dc1e48aa4b4fe4701e72963353d1ac4e4d52.1667315100.git.fdmanana@suse.com>
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

At find_extent_clone() we are initializing to zero the 'found_itself' and
'found' fields of the backref context before we use it but we have already
initialized the structure to zeroes when we declared it on stack, so it's
pointless to initialize those fields and they are unnecessarily increasing
the object text size with two "mov" instructions (x86_64).

Similarly make the 'extent_len' initialization more clear by using an if-
-then-else instead of a double assignment to it in case the extent's end
crosses the i_size boundary.

Before this change:

   $ size fs/btrfs/send.o
      text	   data	    bss	    dec	    hex	filename
     68694	   4252	     16	  72962	  11d02	fs/btrfs/send.o

After this change:

   $ size fs/btrfs/send.o
      text	   data	    bss	    dec	    hex	filename
     68678	   4252	     16	  72946	  11cf2	fs/btrfs/send.o

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 63f2ac33e85b..61496d3e1355 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -1432,11 +1432,8 @@ static int find_extent_clone(struct send_ctx *sctx,
 	}
 
 	backref_ctx.sctx = sctx;
-	backref_ctx.found = 0;
 	backref_ctx.cur_objectid = ino;
 	backref_ctx.cur_offset = data_offset;
-	backref_ctx.found_itself = 0;
-	backref_ctx.extent_len = num_bytes;
 
 	/*
 	 * The last extent of a file may be too large due to page alignment.
@@ -1445,6 +1442,8 @@ static int find_extent_clone(struct send_ctx *sctx,
 	 */
 	if (data_offset + num_bytes >= ino_size)
 		backref_ctx.extent_len = ino_size - data_offset;
+	else
+		backref_ctx.extent_len = num_bytes;
 
 	/*
 	 * Now collect all backrefs.
-- 
2.35.1

