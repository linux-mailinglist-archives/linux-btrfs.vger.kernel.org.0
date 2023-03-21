Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678216C2FFA
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 12:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjCULOr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 07:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjCULOq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 07:14:46 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEF92701
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 04:14:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 02CBFCE17B2
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 11:14:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2857C4339B
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 11:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679397258;
        bh=rxU3HpTfMBFi7GxSr/HKgF47MsthKMH3nTFHOGwBZsk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=llKlg7+VLNEGhuSqE2UWaFIlOkMD3SNd2UN1DyaENuCfdUjcb4N6cVRlnBAaKcaG7
         XTC4mlQZ4VXgFFdey2isiu1npgkj1RGcTqCkvU0jJjOCZF+imOHcx3h5Rmo16Rx0wL
         FBxSSDxRwrd6uNVLWSwMqiqUgkV8ZGuuidHT8YK5FSfdEsLbKNn5LyQyV4iNTU/VtA
         /Zzl1N1ikIk/u/iBzJMPQ7+mfjNEhO7YvINNJwyBPnZLvkUUxyRLCWvDAZuoUnhrsk
         aYzqv07FTjMZUfbXl/8/UpVLmXe+AKMxjxrcmmUjcSCOcsmrp/X/RZMTfVQ4tbXFQt
         v+xlViwc7+AUA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 15/24] btrfs: calculate the right space for a single delayed ref when refilling
Date:   Tue, 21 Mar 2023 11:13:51 +0000
Message-Id: <c473b878432c49031d20dd0fa9e62bc855ab698f.1679326433.git.fdmanana@suse.com>
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

When refilling the delayed block reserve we are incorrectly computing the
amount of bytes for a single delayed reference if the free space tree is
being used. In that case we should double the calculated amount.
Everywhere else we compute the correct amount, like when updating the
delayed block reserve, at btrfs_update_delayed_refs_rsv(), or when
releasing space from the delayed block reserve, at
btrfs_delayed_refs_rsv_release().

So fix btrfs_delayed_refs_rsv_refill() to multiply the amount of bytes for
a single delayed reference by two in case the free space tree is used.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-ref.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index bf2ce51e5086..b58a7e30d37c 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -186,6 +186,17 @@ int btrfs_delayed_refs_rsv_refill(struct btrfs_fs_info *fs_info,
 	u64 num_bytes = 0;
 	int ret = -ENOSPC;
 
+	/*
+	 * We have to check the mount option here because we could be enabling
+	 * the free space tree for the first time and don't have the compat_ro
+	 * option set yet.
+	 *
+	 * We need extra reservations if we have the free space tree because
+	 * we'll have to modify that tree as well.
+	 */
+	if (btrfs_test_opt(fs_info, FREE_SPACE_TREE))
+		limit *= 2;
+
 	spin_lock(&block_rsv->lock);
 	if (block_rsv->reserved < block_rsv->size) {
 		num_bytes = block_rsv->size - block_rsv->reserved;
-- 
2.34.1

