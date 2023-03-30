Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1714A6D0874
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Mar 2023 16:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbjC3OjS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Mar 2023 10:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbjC3OjR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Mar 2023 10:39:17 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCBCDE
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Mar 2023 07:39:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 90D1CCE29B7
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Mar 2023 14:39:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B87C4339B
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Mar 2023 14:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680187152;
        bh=dyRTCfE4RMHbJfWXQTHRgCfg5o0IuUaRLYq06l5iiOY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=kUwGbS3siJJdRpGRDu0puFFIQuc/cZogVtOog9iAc1TWLYR7vdWfV0K/U/q1I7ict
         4XhXitiAzm/0xiArUycwHtim9kgZJgmAknTdoRIxhjVwUz82VFLPhAgk5Pr6R6KlB7
         gGwnAshMI+eA45cuNHZCMc3L8YJ5eIeL29ipd11eVVo9rElb8LgszHhxdp62CPnAFK
         l4NA+W8H4wPmRijLJw0AfBAUlI3L2ky+LFjtwv61B0yjdf5jkquwQcj4WHu3PXrFeB
         4VGCmAe4YCuXGtoUnDps6HwymC4q3nzCgTsWKaZ+4iiU80Cz3KzVHmrFqkVvgAU7Oq
         dNhxHx5zELWvg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: make btrfs_block_rsv_full() check more boolean when starting transaction
Date:   Thu, 30 Mar 2023 15:39:02 +0100
Message-Id: <01834d0e8f0143d09a29ec0541e9ccff63249e1c.1680185833.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1680185833.git.fdmanana@suse.com>
References: <cover.1680185833.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When starting a transaction we are comparing the result of a call to
btrfs_block_rsv_full() with 0, but the function returns a boolean. While
in practice it is not incorrect, as 0 is equivalent to false, it makes it
a bit odd and less readable. So update the check to not compare against 0
and instead use the logical not (!) operator.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/transaction.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index c57d4408e7f1..a54a5c5a5db3 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -607,7 +607,7 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 		 */
 		num_bytes = btrfs_calc_insert_metadata_size(fs_info, num_items);
 		if (flush == BTRFS_RESERVE_FLUSH_ALL &&
-		    btrfs_block_rsv_full(delayed_refs_rsv) == 0) {
+		    !btrfs_block_rsv_full(delayed_refs_rsv)) {
 			delayed_refs_bytes = num_bytes;
 			num_bytes <<= 1;
 		}
-- 
2.34.1

