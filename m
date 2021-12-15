Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2C44758B2
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 13:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240817AbhLOMUI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 07:20:08 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:55404 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237182AbhLOMUH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 07:20:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E9A4618A0
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:20:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 331BCC34606
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639570806;
        bh=ZDMT6CCNG4ys31udZJmk8N/Ool2wMuebz82Nnx3MQqY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=R2xrte6+8/vQMuzP4J4iK5TQTckiSKlLxLtnCOmhX8sOPL5sesBkHH/GMgTHf1fkg
         Zlah8u9qg/Ub8VqIkgX4skJ7DE+z6AN6c6fNXmPksfO9iZaNJZbIm4lVCuF3LpnuiZ
         UXwbFw9bUPMebFAukPZmJci1EmbPRDQjJF5xua9aC5VYiR+BdFoy4xTEnRqOtkPlU3
         JoqG6YdNQYoIDveYVjD6e4wEu3ZKZG2vD7vDiegc7vMJRh4yqGVoaWcpDZANqQwTTd
         eiRDoHx6ZoB8WHGncmcvPuc5OMYj3QEybax0GO5bzFAqoxpjnSaTblbBxnq60kWECQ
         wYmzxzD6Xtd2Q==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/4] btrfs: don't log unnecessary boundary keys when logging directory
Date:   Wed, 15 Dec 2021 12:19:58 +0000
Message-Id: <ca245c0459ed742acbf0fa48b7f4f298fe1fb0b5.1639568905.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1639568905.git.fdmanana@suse.com>
References: <cover.1639568905.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Before we start to log dir index keys from a leaf, we check if there is a
previous index key, which normally is at the end of a leaf that was not
changed in the current transaction. Then we log that key and set the start
of logged range (item of type BTRFS_DIR_LOG_INDEX_KEY) to the offset of
that key. This is to ensure that if there were deleted index keys between
that key and the first key we are going to log, those deletions are
replayed in case we need to replay to the log after a power failure.
However we really don't need to log that previous key, we can just set the
start of the logged range to that key's offset plus 1. This achieves the
same and avoids logging one dir index key.

The same logic is performed when we finish logging the index keys of a
leaf and we find that the next leaf has index keys and was not changed in
the current transaction. We are logging the first key of that next leaf
and use its offset as the end of range we log. This is just to ensure that
if there were deleted index keys between the last index key we logged and
the first key of that next leaf, those index keys are deleted if we end
up replaying the log. However that is not necessary, we can avoid logging
that first index key of the next leaf and instead set the end of the
logged range to match the offset of that index key minus 1.

So avoid logging those index keys at the boundaries and adjust the start
and end offsets of the logged ranges as described above.

This patch is part of a patchset comprised of the following patches:

  1/4 btrfs: don't log unnecessary boundary keys when logging directory
  2/4 btrfs: put initial index value of a directory in a constant
  3/4 btrfs: stop copying old dir items when logging a directory
  4/4 btrfs: stop trying to log subdirectories created in past transactions

Performance test results are listed in the changelog of patch 3/4.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index c1ddbe800897..a80f14df5b81 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3883,17 +3883,18 @@ static noinline int log_dir_items(struct btrfs_trans_handle *trans,
 	ret = btrfs_previous_item(root, path, ino, BTRFS_DIR_INDEX_KEY);
 	if (ret == 0) {
 		struct btrfs_key tmp;
+
 		btrfs_item_key_to_cpu(path->nodes[0], &tmp, path->slots[0]);
-		if (tmp.type == BTRFS_DIR_INDEX_KEY) {
-			first_offset = tmp.offset;
-			ret = overwrite_item(trans, log, dst_path,
-					     path->nodes[0], path->slots[0],
-					     &tmp);
-			if (ret) {
-				err = ret;
-				goto done;
-			}
-		}
+		/*
+		 * The dir index key before the first one we found that needs to
+		 * be logged might be in a previous leaf, and there might be a
+		 * gap between these keys, meaning that we had deletions that
+		 * happened. So the key range item we log (key type
+		 * BTRFS_DIR_LOG_INDEX_KEY) must cover a range that starts at the
+		 * previous key's offset plus 1, so that those deletes are replayed.
+		 */
+		if (tmp.type == BTRFS_DIR_INDEX_KEY)
+			first_offset = tmp.offset + 1;
 	}
 	btrfs_release_path(path);
 
@@ -3941,14 +3942,16 @@ static noinline int log_dir_items(struct btrfs_trans_handle *trans,
 			goto done;
 		}
 		if (btrfs_header_generation(path->nodes[0]) != trans->transid) {
-			ctx->last_dir_item_offset = min_key.offset;
-			ret = overwrite_item(trans, log, dst_path,
-					     path->nodes[0], path->slots[0],
-					     &min_key);
-			if (ret)
-				err = ret;
-			else
-				last_offset = min_key.offset;
+			/*
+			 * The next leaf was not changed in the current transaction
+			 * and has at least one dir index key.
+			 * We check for the next key because there might have been
+			 * one or more deletions between the last key we logged and
+			 * that next key. So the key range item we log (key type
+			 * BTRFS_DIR_LOG_INDEX_KEY) must end at the next key's
+			 * offset minus 1, so that those deletes are replayed.
+			 */
+			last_offset = min_key.offset - 1;
 			goto done;
 		}
 		if (need_resched()) {
-- 
2.33.0

