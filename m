Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA6C798B6F
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 19:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245427AbjIHRVG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 13:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjIHRVF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 13:21:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F54CE6
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 10:21:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D2DC433C9
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 17:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694193661;
        bh=OVeCedQ8YLMYiu2q+p/D/EBzjoqooSwoLr+efHiEdLU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=OM6SwbGw61f3cXmRxAbTXrpPH2VyHn7P/QNa3bqHpank9B+OcoAxFiNIe9GjPY+nX
         3kHI9uKKXBOmX5fuBsu06qBtBhHuvZys0oSqw63GJm3OWM0S2Jt0jH8v7IBZPWb4ZL
         GJS3/eUpaGy99y8cwNRPaoQBqkJvBe83JYFJfdT2+P/NhAyEfobZWWpXOwp7GXC6Rq
         WwxMtT6SdPlwetcyHRnx2qO50GC/jO5fgzuavZ0xYkRAyVx5FSRErgZ5tz3HJBoBXz
         Eo2H51NWp8PfyQxjyEl2MmIRCPvx8Da0XBvpQXpwpQEJsoFPj5BpObHCXJ9NEvT2/B
         aaMxacAr3Avig==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 19/21] btrfs: remove pointless initialization at btrfs_delayed_refs_rsv_release()
Date:   Fri,  8 Sep 2023 18:20:36 +0100
Message-Id: <6c4681f572a1ff834b241f8d8e4b148724ad5611.1694192469.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694192469.git.fdmanana@suse.com>
References: <cover.1694192469.git.fdmanana@suse.com>
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

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
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

