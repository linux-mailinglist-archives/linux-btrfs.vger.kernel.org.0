Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F0D763BCD
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jul 2023 17:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234985AbjGZP6F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jul 2023 11:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234559AbjGZP52 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jul 2023 11:57:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E73212A
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 08:57:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67F5561BA2
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 15:57:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C846C433C7
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 15:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690387046;
        bh=kT9HJpnHdK9dOE2RzMRjqhMzZnUlmWYYtlvy65yFcMo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=rfngJjgZoXfEh3bCVMwe/x7ThnNFfS3IySxsh8TbhWpddDqnPts3tUeHXkIdPUlAs
         eQ0lD0yYWo/1p4P8/a7Zkc/KMyD9h8QHrA4BGTgtJK8yC9keSvpxNLzlJlmQBAeL9f
         OlKM3E9kepvO8IUr15kjG7v0XODpV+UO83POaHXekrdjrg/nIje2X5Utalq8qoLrS9
         /qe+t2E11pea1rwGg6euv8vGRBv6PC1pSBZfbG/5nHgiNTL48vz+950XZpfg/pLuL/
         sj1LaCBL/e3oF6CuHB29V1VZoUrpzoflXwqBUbheJEo1vUq3s+RH1m48GnmPGiDZOE
         IcuLbKhL9cUJA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 10/17] btrfs: fail priority metadata ticket with real fs error
Date:   Wed, 26 Jul 2023 16:57:06 +0100
Message-Id: <b253ae26c37298d6ef6c130625101f92b9b07470.1690383587.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1690383587.git.fdmanana@suse.com>
References: <cover.1690383587.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

At priority_reclaim_metadata_space(), if we were not able to satisfy the
the ticket after going through the various flushing states and we notice
the fs went into an error state, likely due to a transaction abort during
the flushing, set the ticket's error to the error that caused the
transaction abort instead of an unconditional -EROFS.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/space-info.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 5b1b71e029ad..be5ce209b918 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1421,13 +1421,13 @@ static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
 	/*
 	 * Attempt to steal from the global rsv if we can, except if the fs was
 	 * turned into error mode due to a transaction abort when flushing space
-	 * above, in that case fail with -EROFS instead of returning success to
-	 * the caller if we can steal from the global rsv - this is just to have
-	 * caller fail immeditelly instead of later when trying to modify the
-	 * fs, making it easier to debug -ENOSPC problems.
+	 * above, in that case fail with the abort error instead of returning
+	 * success to the caller if we can steal from the global rsv - this is
+	 * just to have caller fail immeditelly instead of later when trying to
+	 * modify the fs, making it easier to debug -ENOSPC problems.
 	 */
 	if (BTRFS_FS_ERROR(fs_info)) {
-		ticket->error = -EROFS;
+		ticket->error = BTRFS_FS_ERROR(fs_info);
 		remove_ticket(space_info, ticket);
 	} else if (!steal_from_global_rsv(fs_info, space_info, ticket)) {
 		ticket->error = -ENOSPC;
-- 
2.34.1

