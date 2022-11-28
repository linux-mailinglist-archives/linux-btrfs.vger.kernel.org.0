Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5468663ABF0
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Nov 2022 16:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbiK1PHy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Nov 2022 10:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbiK1PHi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Nov 2022 10:07:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EF86444
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Nov 2022 07:07:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1FFA4B80DE3
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Nov 2022 15:07:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A7BC433C1
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Nov 2022 15:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669648053;
        bh=4EXByzpGA3PHcMfO1pdKXYK9sWCnYpOgFwh4HRo6AXQ=;
        h=From:To:Subject:Date:From;
        b=fbv3uOCbx20R65KQGENHNHuDee4ivCjEfTPRjJNu+z+t0dac7ZdEb5GYEI+jwmo+M
         2aFb7di/eKZ0eB9rF1AuBrwzcUpFExlPnJ8RizcEqOar2lw+JNdbjXlKOJ/XuzUz+8
         QK/dlnS88aQDtod4pXVKt+0QCnBDiF6Q3V6wUTu2xHVexxmiw0xc9bN5nV4xtU304K
         lyulmDRnBwRgYvrvnO0o8IHq2J/yg94cXNNn45QwkvaNbmuTOYr4zo4iJdEoFankL/
         6v1uNl6EFCWbAr8CstUciin1WhP0r8JTSQs0UB1pAvQfJlZVnSdw77diLNgMdiMbtR
         siyieRnNZt7TA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: do not BUG_ON() on ENOMEM when dropping extent items for a range
Date:   Mon, 28 Nov 2022 15:07:30 +0000
Message-Id: <59ccc7b41be79e5c3b0f39ad5da6591554927af7.1669647978.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
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

If we get -ENOMEM while dropping file extent items in a given range, at
btrfs_drop_extents(), due to failure to allocate memory when attempting to
increment the reference count for an extent or drop the reference count,
we handle it with a BUG_ON(). This is excessive, instead we can simply
abort the transaction and return the error to the caller. In fact most
callers of btrfs_drop_extents(), directly or indirectly, already abort
the transaction if btrfs_drop_extents() returns any error.

Also, we already have error paths at btrfs_drop_extents() that may return
-ENOMEM and in those cases we abort the transaction, like for example
anything that changes the b+tree may return -ENOMEM due to a failure to
allocate a new extent buffer when COWing an existing extent buffer, such
as a call to btrfs_duplicate_item() for example.

So replace the BUG_ON() calls with proper logic to abort the transaction
and return the error.

Reported-by: syzbot+0b1fb6b0108c27419f9f@syzkaller.appspotmail.com
Link: https://lore.kernel.org/linux-btrfs/00000000000089773e05ee4b9cb4@google.com/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 448b143a5cb2..91b00eb2440e 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -380,7 +380,10 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 						args->start - extent_offset,
 						0, false);
 				ret = btrfs_inc_extent_ref(trans, &ref);
-				BUG_ON(ret); /* -ENOMEM */
+				if (ret) {
+					btrfs_abort_transaction(trans, ret);
+					break;
+				}
 			}
 			key.offset = args->start;
 		}
@@ -467,7 +470,10 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 						key.offset - extent_offset, 0,
 						false);
 				ret = btrfs_free_extent(trans, &ref);
-				BUG_ON(ret); /* -ENOMEM */
+				if (ret) {
+					btrfs_abort_transaction(trans, ret);
+					break;
+				}
 				args->bytes_found += extent_end - key.offset;
 			}
 
-- 
2.35.1

