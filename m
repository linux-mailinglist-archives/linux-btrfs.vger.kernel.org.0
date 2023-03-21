Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591046C2FF5
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 12:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjCULOk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 07:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjCULOc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 07:14:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F94367D8
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 04:14:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D56A8B815B8
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 11:14:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E7F8C4339B
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 11:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679397247;
        bh=Qz4Nvb9iNHDAznpTD9/InGTGTZ371eFFpH8StlWErJ8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=WK+yq2g1l4g06MuXC7suaeQbrv4LQ9Rz/8W77c5sGCMDJJwngZ76/Du2mgmS2KDfh
         w7dypRrwxqyJ80NxHo6/i9xj8Uks4myCm6n5rgGXC6EbdF8C8f+PXbCmM4sdlDUuzr
         URr72erKUCPS9yedYaRFw5MHdfQW8PvvBsTguSegrIkDbjc+3Qt6KspNGAx9Ov5doY
         S20p2gUfIa0f8wjRMUYCd9j00XiN98yTRGpP+D7Sp6xRwTgHr+LQt6XMxlzouHsPZy
         3boYdu0x+5KapTPk7qOCPeVgSUPD3kpKoL3s58Ao7D552UVeKfMEwH9MbuoPgFudi0
         5/b9hH1EtgvrA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 03/24] btrfs: remove check for NULL block reserve at btrfs_block_rsv_check()
Date:   Tue, 21 Mar 2023 11:13:39 +0000
Message-Id: <8a7ecbeffe854a442aacb7c5c0c97b9f44528ebe.1679326430.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1679326426.git.fdmanana@suse.com>
References: <cover.1679326426.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The block reserve passed to btrfs_block_rsv_check() is never NULL, so
remove the check. In case it can ever become NULL in the future, then
we'll get a pretty obvious and clear NULL pointer dereference crash and
stack trace.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-rsv.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index 5367a14d44d2..364a3d11bf88 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -232,9 +232,6 @@ int btrfs_block_rsv_check(struct btrfs_block_rsv *block_rsv, int min_percent)
 	u64 num_bytes = 0;
 	int ret = -ENOSPC;
 
-	if (!block_rsv)
-		return 0;
-
 	spin_lock(&block_rsv->lock);
 	num_bytes = mult_perc(block_rsv->size, min_percent);
 	if (block_rsv->reserved >= num_bytes)
-- 
2.34.1

