Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65CD2745ABD
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jul 2023 13:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjGCLD1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jul 2023 07:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGCLD0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Jul 2023 07:03:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5906DC
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 04:03:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79E2160EAA
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 11:03:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 621C2C433C8
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 11:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688382204;
        bh=pLHqJ2gRvGo2zBrwT3tByx1nejUalrC5VXwt1COERRc=;
        h=From:To:Subject:Date:From;
        b=pTxvktVHjOpHPgxL3Rzbi7P4Iaw6muat944+tU8SD74FVAMvYd9W42BcVx9NaB51i
         EMIOJnx5ZQG0fFCa4Kg+zZqQolk4xf9cxFBiN17VrdfPPHHePtxkj4r0do2lzDvn0g
         CBXwtTSu90OSQ1obYf6f+deUQ5prtkBA0mThQOMN9/VFSy8sctIF2YmLCq//SlsJNy
         8/EJwJdvmSaG5XVvQ4IbTuTMHjJaJk1cvPum5CEqw5UdcJgiCgs0hjAm7UwU0q6tJt
         SvPQOLvgi3VvpfWug/4Q0ZUyYaNsD0aBK2bapWOyyWjgtZ7y6YNfCR4aZX13OOY04A
         Njx62EQARLJMg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix leak after finding block group with super blocks on zoned fs
Date:   Mon,  3 Jul 2023 12:03:21 +0100
Message-Id: <92dbe59fdd79544067340f09449e6fdda0902ff5.1688382073.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
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

At exclude_super_stripes(), if we happen to find a block group that has
super blocks mapped to it and we are on a zoned filesystem, we error out
as this is not supposed to happen, indicating either a bug or maybe some
memory corruption for example. However we are exiting the function without
freeing the memory allocated for the logical address of the super blocks.
Fix this by freeing the logical address.

Fixes: 12659251ca5d ("btrfs: implement log-structured superblock for ZONED mode")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index f53297726238..b7da14848686 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2088,6 +2088,7 @@ static int exclude_super_stripes(struct btrfs_block_group *cache)
 
 		/* Shouldn't have super stripes in sequential zones */
 		if (zoned && nr) {
+			kfree(logical);
 			btrfs_err(fs_info,
 			"zoned: block group %llu must not contain super block",
 				  cache->start);
-- 
2.34.1

