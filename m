Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD72477A73E
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Aug 2023 17:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjHMPDc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Aug 2023 11:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbjHMPDb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Aug 2023 11:03:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2C391
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Aug 2023 08:03:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5623E61BC4
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Aug 2023 15:03:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D41AC433C7
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Aug 2023 15:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691939012;
        bh=NhJ7gZROiMa3fX9UDC3QreNo8aCUlQlcoS3fwAqyl7s=;
        h=From:To:Subject:Date:From;
        b=mx4ieJk6w9IZCXIxO4uE8OBhjYDGpA2fNKamHK5XfNFTkw36sPJ8++ECCxLp80WB2
         Vc1+Kv5aYtNiNdIAEfRVVZGcqxLBcCuKylj9RAP8txQFAbzv3QOnoedAVaWq6pEcbm
         FVxGAw1cdwa9DAy+vkmGd/D3zvUUvZ8U4Ij7PIVGzCN8+jDg/663jjaNirW7dx3yo0
         d9ohWjrsqaxE4RC5utdt5lCb6kwwKiTxTbqgJO2Shf0InM6bzFbvJZvJz3vSdjFwyu
         c1XSwCCT1m1ceSIWZM6guw2UTGfQXSpuVlHjN4gnLKmqZdiNqclqmvRccjwg0ezHuk
         ARi6v7fGE/AAA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove pointless empty list check when reading delayed dir indexes
Date:   Sun, 13 Aug 2023 16:03:28 +0100
Message-Id: <935cc2c19db41bde25d1ebb2e7d759737678ad51.1691938868.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
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

At btrfs_readdir_delayed_dir_index(), called when reading a directory, we
have this check for an empty list to return immediately, but it's not
needed since list_for_each_entry_safe(), called immediately after, is
prepared to deal with an empty list, it simply does nothing. So remove
the empty list check.

Besides shorter source code, it also slightly reduces the binary text
size:

  Before this change:

    $ size fs/btrfs/btrfs.ko
       text	   data	    bss	    dec	    hex	filename
    1609408	 167269	  16864	1793541	 1b5e05	fs/btrfs/btrfs.ko

  After this change:

    $ size fs/btrfs/btrfs.ko
       text	   data	    bss	    dec	    hex	filename
    1609392	 167269	  16864	1793525	 1b5df5	fs/btrfs/btrfs.ko

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-inode.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 6d51db066503..85dcf0024137 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1736,9 +1736,6 @@ int btrfs_readdir_delayed_dir_index(struct dir_context *ctx,
 	int over = 0;
 	unsigned char d_type;
 
-	if (list_empty(ins_list))
-		return 0;
-
 	/*
 	 * Changing the data of the delayed item is impossible. So
 	 * we needn't lock them. And we have held i_mutex of the
-- 
2.34.1

