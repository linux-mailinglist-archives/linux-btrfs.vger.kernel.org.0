Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87797DB95A
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Oct 2023 12:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbjJ3Lya (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Oct 2023 07:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJ3Lya (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Oct 2023 07:54:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597F5C6
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Oct 2023 04:54:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 711E6C433C7
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Oct 2023 11:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698666868;
        bh=YwzH92maRTV4R0mivxBIuFx/EnM69qbK8ozXrkMC8K0=;
        h=From:To:Subject:Date:From;
        b=ZBZmP5lVK5FldG1jiUZagwt/RugB8lij1xnBW7vY/goiVlG/gCkh+O9w7yURZa/WD
         vT+mTxD5bCB4DD28KXsrQtRqqg2erefUXdH/bheoG4bmN630ZbbS+mbuelsdFJR8XM
         5D1dQrezX1hZzh4/2+aW06Tj/GhqvskyyVd6qVDKpNaNUOH6XjyzVUgYLu/PgDQd9U
         zmST2apZs+al1RLr/v8EyTKw+ooy7X6Orho7tt9RoNvvhSn8/r8ywezRFTU2DJ3wB1
         wum70RkB7dU/mg7tuZJaTnGN3nAd4Y5vjQQFKr/rS6IJSHDUjZj5JuabhAmPlx30Hs
         cVq4ElP3Hlq/A==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix error pointer dereference after failure to allocate fs devices
Date:   Mon, 30 Oct 2023 11:54:23 +0000
Message-Id: <86c522f5e01e438b4a9cc16a0bda87a207d744e6.1698666319.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

At device_list_add() we allocate a btrfs_fs_devices structure and then
before checking if the allocation failed (pointer is ERR_PTR(-ENOMEM)),
we dereference the error pointer in a memcpy() argument if the feature
BTRFS_FEATURE_INCOMPAT_METADATA_UUID is enabled.
Fix this by checking for an allocation error before trying the memcpy().

Fixes: f7361d8c3fc3 ("btrfs: sipmlify uuid parameters of alloc_fs_devices()")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/volumes.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 1fdfa9153e30..dd279241f78c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -746,13 +746,13 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 
 	if (!fs_devices) {
 		fs_devices = alloc_fs_devices(disk_super->fsid);
+		if (IS_ERR(fs_devices))
+			return ERR_CAST(fs_devices);
+
 		if (has_metadata_uuid)
 			memcpy(fs_devices->metadata_uuid,
 			       disk_super->metadata_uuid, BTRFS_FSID_SIZE);
 
-		if (IS_ERR(fs_devices))
-			return ERR_CAST(fs_devices);
-
 		if (same_fsid_diff_dev) {
 			generate_random_uuid(fs_devices->fsid);
 			fs_devices->temp_fsid = true;
-- 
2.40.1

