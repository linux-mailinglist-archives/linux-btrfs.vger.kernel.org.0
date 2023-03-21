Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9936C2FF0
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 12:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjCULOc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 07:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjCULO3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 07:14:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D725A3BC58
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 04:14:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C7B8B815BA
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 11:14:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 682F5C433EF
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 11:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679397245;
        bh=HmerRVofitzbkyUGKaYJAIFhEbkl+Vn7mWF/AtdFqBc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=nTVxTlulUvj7o0ToxSbcNdPztBFq8wmGezefNQcxv/NqKEXBNvRvHw9G4HNHcwo4n
         8GVazsPyX7NHXtSvFuU1LBA5NuIU6YxTHYT19QZQV6p4RJedLurW3TYS+IWRME8S11
         zNhPkmjRIXen5E2ZIfUZPGb6j3ozv7MlA94AsEdLORBSfD/hm8ikJsQLlQjB23YlIz
         q8CcFPQcKosEV/ymsQCDIJoWEWQjtYZs5akDVyq3nPHd6UilL32aRy7TI6vEMZ8X+N
         T6rB7108nbLyTarANjSXzPH8B1nkVn/D8OmT4ZaVJHe3NNFPnojCGTbRjvKUaxpH1q
         9rQrxfEG/DMEQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 01/24] btrfs: pass a bool to btrfs_block_rsv_migrate() at evict_refill_and_join()
Date:   Tue, 21 Mar 2023 11:13:37 +0000
Message-Id: <e0732832e3c238485454b0a46f0d6da983a5daa5.1679326429.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1679326426.git.fdmanana@suse.com>
References: <cover.1679326426.git.fdmanana@suse.com>
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

The last argument of btrfs_block_rsv_migrate() is a boolean, but we are
passing an integer, with a value of 1, to it at evict_refill_and_join().
While this is not a bug, due to type conversion, it's a lot more clear to
simply pass the boolean true value instead. So just do that.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 76d93b9e94a9..7bae75973a4d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5268,7 +5268,7 @@ static struct btrfs_trans_handle *evict_refill_and_join(struct btrfs_root *root,
 		trans->block_rsv = &fs_info->trans_block_rsv;
 		trans->bytes_reserved = delayed_refs_extra;
 		btrfs_block_rsv_migrate(rsv, trans->block_rsv,
-					delayed_refs_extra, 1);
+					delayed_refs_extra, true);
 	}
 	return trans;
 }
-- 
2.34.1

