Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4424635F47B
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Apr 2021 15:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351077AbhDNNF5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Apr 2021 09:05:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:43746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233073AbhDNNFw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Apr 2021 09:05:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7537961176
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Apr 2021 13:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618405528;
        bh=7ANJr2qMCBWJMk4vl8ZlMp1ftjxzuzawZN3k8XXF87Y=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=qKK9/mvUQ94mDg83ZiIpzbh+3ymhJxREQ8XuKZkC34AWifszcQq29Fh+F4yF4hhIb
         CYWTZN6wRaKUQ6Da0lXVAWF56unCymqY7TCQpDPJPELiUWPwuPC2Zb12KBghAoZfh0
         TBTWGejuNPadV504wu+f/FxxXtobpUg1eeTK7sYxTraQWhc3gUitAlI4w4ZF98oRcA
         ulnOKRMANEROpIBcMTgR8rPHfJBuOdL3dT6FotI7JKMV77jvN8gPc7J+vK7rxd9wQv
         H9P3TnhjJv/8dWHwt6Jj19pm6muGsTb367WznPHPKB0D1XzScuajoDKXHlU0f3kw1p
         lI6Z/ktJnzwuA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: zoned: fix unpaired block group unfreeze during device replace
Date:   Wed, 14 Apr 2021 14:05:26 +0100
Message-Id: <c42ce5b381e7b6cb8148b422acb21895c316f253.1618405401.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <a76c376dfb6b391b96986c03664ecb657a24b012.1618402032.git.fdmanana@suse.com>
References: <a76c376dfb6b391b96986c03664ecb657a24b012.1618402032.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When doing a device replace on a zoned filesystem, if we find a block
group with ->to_copy == 0, we jump to the label 'done', which will result
in later calling btrfs_unfreeze_block_group(), even though at this point
we never called btrfs_freeze_block_group().

Since at this point we have neither turned the block group to RO mode nor
made any progress, we don't need to jump to the label 'done'. So fix this
by jumping instead to the label 'skip' and dropping our reference on the
block group before the jump.

Fixes: 78ce9fc269af6e ("btrfs: zoned: mark block groups to copy for device-replace")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

V2: Removed label 'done' since it became unused after the fix.

 fs/btrfs/scrub.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 17e49caad1f9..485cda3eb8d7 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3674,8 +3674,8 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 			spin_lock(&cache->lock);
 			if (!cache->to_copy) {
 				spin_unlock(&cache->lock);
-				ro_set = 0;
-				goto done;
+				btrfs_put_block_group(cache);
+				goto skip;
 			}
 			spin_unlock(&cache->lock);
 		}
@@ -3833,7 +3833,6 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 						      cache, found_key.offset))
 			ro_set = 0;
 
-done:
 		down_write(&dev_replace->rwsem);
 		dev_replace->cursor_left = dev_replace->cursor_right;
 		dev_replace->item_needs_writeback = 1;
-- 
2.28.0

