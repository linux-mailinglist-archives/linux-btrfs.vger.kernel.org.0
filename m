Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D891575BE7
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Jul 2022 08:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbiGOG6P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Jul 2022 02:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiGOG6M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Jul 2022 02:58:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67240545F3
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Jul 2022 23:58:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9E3A41FB94
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jul 2022 06:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657868289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yGYo5RyEv9Hu+xBoSA7E/cHVtUrZya6mrbv99+0yty0=;
        b=ECX3Z3UGM1FZswa2f4vQ5HB8bqPdsrOUgsCACZEejk9M8f1/EpkUwi7/akoWlJu2w3C+vY
        MH5v2b7uPLTq73WGXuXhc7XdRA+oJINjNRIUEDoOwx20ORaa/WOX4wnOW2k7avpFzDjK9A
        LQgH1QRk9gcpxcvoK2k9w8HqFYkG2kk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E626813754
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jul 2022 06:58:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WIx3KwAQ0WKtfQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jul 2022 06:58:08 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/4] btrfs: make DUMP_BLOCK_RSV() to have better output
Date:   Fri, 15 Jul 2022 14:57:46 +0800
Message-Id: <d0096ee10270e00362471c7a842aeefed20806c5.1657867842.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <cover.1657867842.git.wqu@suse.com>
References: <cover.1657867842.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This involves the following change:

- Remove "_block_rsv" suffix

- Better alignment for the numbers

- Better naming distinguish for delayed refs and delayed inode

- Skip "size" and "reserved" output
  Just output the numbers directly

Before:

  BTRFS info (device dm-1: state A): global_block_rsv: size 3670016 reserved 3653632
  BTRFS info (device dm-1: state A): trans_block_rsv: size 0 reserved 0
  BTRFS info (device dm-1: state A): chunk_block_rsv: size 0 reserved 0
  BTRFS info (device dm-1: state A): delayed_block_rsv: size 0 reserved 0
  BTRFS info (device dm-1: state A): delayed_refs_rsv: size 524288 reserved 360448

After:

 BTRFS info (device dm-1: state A): global:          (3670016/3670016)
 BTRFS info (device dm-1: state A): trans:           (0/0)
 BTRFS info (device dm-1: state A): chunk:           (0/0)
 BTRFS info (device dm-1: state A): delayed_inode:   (0/0)
 BTRFS info (device dm-1: state A): delayed_refs:    (524288/524288)

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/space-info.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 623fa0488545..6bbf95e8e4f7 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -441,12 +441,12 @@ void btrfs_try_granting_tickets(struct btrfs_fs_info *fs_info,
 	}
 }
 
-#define DUMP_BLOCK_RSV(fs_info, rsv_name)				\
+#define DUMP_BLOCK_RSV(fs_info, member, name)				\
 do {									\
-	struct btrfs_block_rsv *__rsv = &(fs_info)->rsv_name;		\
+	struct btrfs_block_rsv *__rsv = &(fs_info)->member;		\
 	spin_lock(&__rsv->lock);					\
-	btrfs_info(fs_info, #rsv_name ": size %llu reserved %llu",	\
-		   __rsv->size, __rsv->reserved);			\
+	btrfs_info(fs_info, "%-16s (%llu/%llu)",			\
+		   name, __rsv->reserved, __rsv->size);			\
 	spin_unlock(&__rsv->lock);					\
 } while (0)
 
@@ -485,12 +485,11 @@ static void __btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
 		btrfs_info(fs_info,
 			    "  zone_unusable: %llu", info->bytes_zone_unusable);
 
-	DUMP_BLOCK_RSV(fs_info, global_block_rsv);
-	DUMP_BLOCK_RSV(fs_info, trans_block_rsv);
-	DUMP_BLOCK_RSV(fs_info, chunk_block_rsv);
-	DUMP_BLOCK_RSV(fs_info, delayed_block_rsv);
-	DUMP_BLOCK_RSV(fs_info, delayed_refs_rsv);
-
+	DUMP_BLOCK_RSV(fs_info, global_block_rsv, "global:");
+	DUMP_BLOCK_RSV(fs_info, trans_block_rsv, "trans:");
+	DUMP_BLOCK_RSV(fs_info, chunk_block_rsv, "chunk:");
+	DUMP_BLOCK_RSV(fs_info, delayed_block_rsv, "delayed_inode:");
+	DUMP_BLOCK_RSV(fs_info, delayed_refs_rsv, "delayed_refs:");
 }
 
 void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
-- 
2.37.0

