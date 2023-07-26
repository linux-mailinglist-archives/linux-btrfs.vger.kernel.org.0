Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB66E763BC3
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jul 2023 17:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234535AbjGZP50 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jul 2023 11:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234407AbjGZP5Z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jul 2023 11:57:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9C51FDA
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 08:57:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 844D461A21
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 15:57:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E931C433C8
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 15:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690387043;
        bh=P0A6zHjndstN7VnTAsaMIunGeVFJPx6EV03Ww7GywhU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Df8TSx3DWsCSmEjswF1jrojYWxWDRXjB5Lrquy/GAL7RXvZUQjk71Y6Mc9LjVH81Q
         Glk2xTxIagszlniSGnjvEfQRV1Oa+SVAhWIcmkypGQYnrYYOGM/Ux9Wszc9NElWqqf
         Fmnsae7pliHcYCUquTw/UxqLkUdfmTuhVtqcOTZeq3xNtP+0kZRE6dl7R0Cvv1f9s5
         Ixr4CxTJK4ZI9lja/sRluMbxvDZC/7fROnUNvgSIdydYk5ZzaTddkyo/OnM8gOd7eG
         da7orN9M8jAjJ+NB3UmjSZoBK/snq24HiUuut8VAR3CQeiFn62IVEuGZrkka8a8ZaX
         6/4mV/z6/texw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 07/17] btrfs: don't steal space from global rsv after a transaction abort
Date:   Wed, 26 Jul 2023 16:57:03 +0100
Message-Id: <891cb10fe149b32e87a7297f9c45424f681b95d5.1690383587.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1690383587.git.fdmanana@suse.com>
References: <cover.1690383587.git.fdmanana@suse.com>
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

When doing a priority metadata space reclaim, while we are going through
the flush states and running their respective operations, it's possible
that a transaction abort happened, for example when running delayed refs
we hit -ENOSPC or in the critical section of transaction commit we failed
with -ENOSPC or some other error. In these cases a transaction was aborted
and the fs turned into error state. If that happened, then it makes no
sense to steal from the global block reserve and return success to the
caller if the stealing was successful - the caller will later get an
error when attempting to modify the fs. Instead make the ticket fail if
we have the fs in error state and don't attempt to steal from the global
rsv, as it's not only it's pointless, it also simplifies debugging some
-ENOSPC problems.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/space-info.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index de0044283e29..5b1b71e029ad 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1418,8 +1418,18 @@ static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
 		}
 	}
 
-	/* Attempt to steal from the global rsv if we can. */
-	if (!steal_from_global_rsv(fs_info, space_info, ticket)) {
+	/*
+	 * Attempt to steal from the global rsv if we can, except if the fs was
+	 * turned into error mode due to a transaction abort when flushing space
+	 * above, in that case fail with -EROFS instead of returning success to
+	 * the caller if we can steal from the global rsv - this is just to have
+	 * caller fail immeditelly instead of later when trying to modify the
+	 * fs, making it easier to debug -ENOSPC problems.
+	 */
+	if (BTRFS_FS_ERROR(fs_info)) {
+		ticket->error = -EROFS;
+		remove_ticket(space_info, ticket);
+	} else if (!steal_from_global_rsv(fs_info, space_info, ticket)) {
 		ticket->error = -ENOSPC;
 		remove_ticket(space_info, ticket);
 	}
-- 
2.34.1

