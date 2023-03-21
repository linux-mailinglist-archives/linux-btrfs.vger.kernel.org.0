Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC306C2FF4
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 12:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjCULOi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 07:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjCULOb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 07:14:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E02C47828
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 04:14:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F00B761ADB
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 11:14:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A8BC4339C
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 11:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679397249;
        bh=GxkFgYLUkN9hiqnChOMtjYmd77c/DWBPTB5t0tWvTS0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=CTQk/2hWJFwK4cf0yWEDU4ndpgxG8XvwsH2Qp5ea0a4l87YHD0idhITB/vLJi9nVt
         OcVJ5dHbxHZJ6EIi6J13EKtIf0Vc3W1AuERujKBx7rVVz4hzjE4NmpPnyXrylSvMQv
         VZDQGpirFQ9WRh4kLHVftvvvgP7LSfwl979kAHnyxYYq9NCfyqIqd/bL2AYT7R5HgY
         FSL3+cstwgQFaplWPqq3QAEEmPzDeyZJjmRgGwaVmYh7iar80ymLhCRxUig9u6Q3rb
         U8+rj/2S3pr1Jq679iIirptnZk7epIRu8VbBJ+9BvspfS7Zs9TF3uqUIHrIOzYYPem
         LnEiex3l5+ePQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 05/24] btrfs: update flush method assertion when reserving space
Date:   Tue, 21 Mar 2023 11:13:41 +0000
Message-Id: <d15da757fef2ccec42fd1f7252d8a33b625d042f.1679326430.git.fdmanana@suse.com>
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

When reserving space, at space-info.c:__reserve_bytes(), we assert that
either the current task is not holding a transacion handle, or, if it is,
that the flush method is not BTRFS_RESERVE_FLUSH_ALL. This is because that
flush method can trigger transaction commits, and therefore could lead to
a deadlock.

However there are other 2 flush methods that can trigger transaction
commits:

1) BTRFS_RESERVE_FLUSH_ALL_STEAL
2) BTRFS_RESERVE_FLUSH_EVICT

So update the assertion to check the flush method is also not one those
two methods if the current task is holding a transaction handle.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/space-info.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 3eecce86f63f..379a0e778dfb 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1603,7 +1603,18 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 	bool pending_tickets;
 
 	ASSERT(orig_bytes);
-	ASSERT(!current->journal_info || flush != BTRFS_RESERVE_FLUSH_ALL);
+	/*
+	 * If have a transaction handle (current->journal_info != NULL), then
+	 * the flush method can not be neither BTRFS_RESERVE_FLUSH_ALL* nor
+	 * BTRFS_RESERVE_FLUSH_EVICT, as we could deadlock because those
+	 * flushing methods can trigger transaction commits.
+	 */
+	if (current->journal_info) {
+		/* One assert per line for easier debugging. */
+		ASSERT(flush != BTRFS_RESERVE_FLUSH_ALL);
+		ASSERT(flush != BTRFS_RESERVE_FLUSH_ALL_STEAL);
+		ASSERT(flush != BTRFS_RESERVE_FLUSH_EVICT);
+	}
 
 	if (flush == BTRFS_RESERVE_FLUSH_DATA)
 		async_work = &fs_info->async_data_reclaim_work;
-- 
2.34.1

