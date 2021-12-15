Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 082B34758B6
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 13:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242361AbhLOMUM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 07:20:12 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59410 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242338AbhLOMUL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 07:20:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9080B81EC5
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:20:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC57C34606
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639570809;
        bh=5kZ74goLr2y6lCCYGCbR01lCGh/6ko0LE82g6cTye0U=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=uUnMy52g5hzQdo1tAmdicoJ1JkAFzizDTfuPC2Jszs6W8UK+JJNHkfiIccuIJfMZV
         06qTx19ALwW+ajQtsluT5gSYEJjKeEp+qR+yb2ecUJiVKydHYDmgnKscn4Hh6U76mp
         TC1XgwiIJu7peHmdsEN6/Uz9QbvRvhVAg2GrfLtg9BLQsPSzhhV9lyHJA9zox0cCgU
         lMWwDsQGseOMvltrIJ1qgRIN3NVNWraT6JwErwnSro/kjTPCEwc+T/1t7o+TQfa0Zp
         uDsM4tOh2dpzQXtOBDcvefhgqT+lsIL4hFm1yXlNYIcIdsEI0Tzk5voRnTyAOX74qi
         4ndi/F0kWfQLw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/4] btrfs: stop trying to log subdirectories created in past transactions
Date:   Wed, 15 Dec 2021 12:20:01 +0000
Message-Id: <fa34b304b223a9b514d0141a9c7e42082f6dc952.1639568906.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1639568905.git.fdmanana@suse.com>
References: <cover.1639568905.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When logging a directory we are trying to log subdirectories that were
changed in the current transaction and created in a past transaction.
This type of behaviour was introduced by commit 2f2ff0ee5e4303 ("Btrfs:
fix metadata inconsistencies after directory fsync"), to fix some metadata
inconsistencies that in the meanwhile no longer need this behaviour due to
numerous other changes that happened throughout the years.

This behaviour, besides not needed anymore, it's also undesirable because:

1) It's not reliable because it's only triggered for the directories
   of dentries (dir items) that happen to be present on a leaf that
   was changed in the current transaction. If a dentry that points to
   a directory resides on a leaf that was not changed in the current
   transaction, then it's not logged, as at log_dir_items() and
   log_new_dir_dentries() we use btrfs_search_forward();

2) It's not required by posix or any standard, it's undefined territory.
   The only way to guarantee a subdirectory is logged, it to explicitly
   fsync it;

Making the behaviour guaranteed would require scanning all directory
items, check which point to a directory, and then fsync each subdirectory
which was modified in the current transaction. This could be very
expensive for large directories with many subdirectories and/or large
subdirectories.

So remove that obsolete logic.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 7c239fedf192..4b89ac769347 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -5970,8 +5970,7 @@ static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
 
 			di = btrfs_item_ptr(leaf, i, struct btrfs_dir_item);
 			type = btrfs_dir_type(leaf, di);
-			if (btrfs_dir_transid(leaf, di) < trans->transid &&
-			    type != BTRFS_FT_DIR)
+			if (btrfs_dir_transid(leaf, di) < trans->transid)
 				continue;
 			btrfs_dir_item_key_to_cpu(leaf, di, &di_key);
 			if (di_key.type == BTRFS_ROOT_ITEM_KEY)
-- 
2.33.0

