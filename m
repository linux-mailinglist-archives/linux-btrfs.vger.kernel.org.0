Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF7D7986D4
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 14:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243212AbjIHMJu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 08:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjIHMJt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 08:09:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AF41BEA
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 05:09:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3862EC433CB
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 12:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694174985;
        bh=kGTOrT81v+EufuQQqL2sqgfSVKt+gt6S2LZqpG1f3SE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=uStRo6ar2HqfDopi2fQAAAbbzu2HPdKL4ARSvdxHU7pRLY7fG/Lc6/wF8s4VchU1v
         PWqukQo+1Ky9HMUUGfweNWkFTMfsZ8b4gXucdyNjesodYrS+9saPXmouUP7ODaX5Fj
         YlGrAmdhTl24cIsqV5a0tH3XMq7eBFYqKFH932iLY4YIbfjKVO3u67TXkIbf4OYh4k
         qfbP4zBk9OrJTSgNH7D+Dk0uynt+eILT8UHzXqy+VlE5gpaf/pnMmQztLQPluxqCEa
         5Dvs64PIO+rDLragn1ZP+Pu96T165RhdqZslV+EsKYE8Bc92we+Z9shQlMzpC3SHKI
         CU8qadd/63toQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 19/21] btrfs: remove pointless initialization at btrfs_delayed_refs_rsv_release()
Date:   Fri,  8 Sep 2023 13:09:21 +0100
Message-Id: <b644560da59723f2d1400dca83675c427556f95a.1694174371.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694174371.git.fdmanana@suse.com>
References: <cover.1694174371.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

There's no point in initializing to 0 the local variable 'released' as
we don't use it before the next assignment to it. So remove the
initialization. This may help avoid some warnings with clang tools such
as the one reported/fixed by commit 966de47ff0c9 ("btrfs: remove redundant
initialization of variables in log_new_ancestors").

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-ref.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 067176ac5a2b..19dd74b236c6 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -66,7 +66,7 @@ void btrfs_delayed_refs_rsv_release(struct btrfs_fs_info *fs_info, int nr)
 {
 	struct btrfs_block_rsv *block_rsv = &fs_info->delayed_refs_rsv;
 	const u64 num_bytes = btrfs_calc_delayed_ref_bytes(fs_info, nr);
-	u64 released = 0;
+	u64 released;
 
 	released = btrfs_block_rsv_release(fs_info, block_rsv, num_bytes, NULL);
 	if (released)
-- 
2.40.1

