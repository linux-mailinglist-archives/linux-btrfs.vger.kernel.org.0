Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3437E35F327
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Apr 2021 14:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350667AbhDNMIv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Apr 2021 08:08:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:54418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233651AbhDNMIq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Apr 2021 08:08:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F85A60200
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Apr 2021 12:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618402104;
        bh=Y24bp2BgYW3YgLECIR0ZgkP3hjFBaHy5B0LDAXQLA6g=;
        h=From:To:Subject:Date:From;
        b=Wh5PWl5xD2+0G6garmc/OnzxbNknypw0EwA62hFviTemVbED3f1PauAWApP6K1eup
         dcCkLn4F3Q+qXTKkb81vSMVwathXcQbBodU62StdA4Hzu4l6xr0CJJVLYls2B2oDyk
         c58576SX0bYeuANIwytOrrT1wvx5L9i8d7VTuPlLvZuWSJ/iDyroxqywXBukYeQ9HY
         YENVNYrS65guhODGTpizfsGR7lULJpptTZSzCWkc6aCjSPilXCohtMrqE7EQIyIQxw
         CVJGZQdQ9MGUVRW2/3wuskxLo2s9ViGrV18r8slv0CweUSQ9Oyhc59sKfcHVA9smu+
         93d//y1W6stnw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: zoned: fix unpaired block group unfreeze during device replace
Date:   Wed, 14 Apr 2021 13:08:21 +0100
Message-Id: <a76c376dfb6b391b96986c03664ecb657a24b012.1618402032.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
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
 fs/btrfs/scrub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 17e49caad1f9..e0d54ed9acee 100644
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
-- 
2.28.0

