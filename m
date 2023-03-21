Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0EF6C2FF2
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 12:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjCULOg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 07:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjCULOb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 07:14:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A79B47801
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 04:14:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 530DE61AE3
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 11:14:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B119C433A0
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 11:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679397246;
        bh=sI7tID6Ne5nolfPec0TphsiyAVsBUeCUq9w7RbmRWxo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=B2S0JkchIIYzW+Xotmcr/kBZHPN7T/Jj+OyC/Ykvsvm5izUwrYoEXx0wTNeKg1OFG
         owlrF6NzBi+dcAx/tj4syIiUpRD3w6AbNr9M/mvO6kWPOaUZr/bXQI07zDzZfgSueQ
         UWUPsvTwYgGQhKs6tclGJrZjyPImqN57qSFaFCembIx8vYRgcM8ExEzfje3XkEUHEq
         IoPcy9Mqk7V6+NLc/gnj0UeNrmjteFm8xep+Sub7bVEbhx/IrIFGQhLXCeB+bPrkhl
         QFSE0/x9OHCUML1UuNFIqjxfgRRb4IcGnSUji26axFbghMw4jffh/iQpmdtxczsxB2
         n+SGG1T2HxVjw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 02/24] btrfs: pass a bool size update argument to btrfs_block_rsv_add_bytes()
Date:   Tue, 21 Mar 2023 11:13:38 +0000
Message-Id: <4e7abf7599f8d809dbdd5f9f25f376fcd1ed83f2.1679326429.git.fdmanana@suse.com>
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

At btrfs_delayed_refs_rsv_refill(), we are passing a value of 0 to the
'update_size' argument of btrfs_block_rsv_add_bytes(), which is defined
as a boolean. Functionally this is fine because a 0 is, implicitly,
converted to a boolean false value. However it's easier to read an
explicit 'false' value, so just pass 'false' instead of 0.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-ref.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 886ffb232eac..83e1e1d0ec6a 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -217,7 +217,7 @@ int btrfs_delayed_refs_rsv_refill(struct btrfs_fs_info *fs_info,
 	ret = btrfs_reserve_metadata_bytes(fs_info, block_rsv, num_bytes, flush);
 	if (ret)
 		return ret;
-	btrfs_block_rsv_add_bytes(block_rsv, num_bytes, 0);
+	btrfs_block_rsv_add_bytes(block_rsv, num_bytes, false);
 	trace_btrfs_space_reservation(fs_info, "delayed_refs_rsv",
 				      0, num_bytes, 1);
 	return 0;
-- 
2.34.1

