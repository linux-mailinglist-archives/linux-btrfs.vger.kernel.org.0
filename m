Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D40F81AE00D
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Apr 2020 16:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbgDQOkQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Apr 2020 10:40:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:55858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgDQOkP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Apr 2020 10:40:15 -0400
Received: from debian7.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F403220936
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Apr 2020 14:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587134415;
        bh=zVi+xdcCjsdT+WdBA2EH6WzUCrqpN2iIm386h0Rf3qI=;
        h=From:To:Subject:Date:From;
        b=JbeKc7i9PknFep668JogDsuTNbrMWVJvrV/6YtBSexb+RrpBHUCTF+BRlv43Db41u
         60uGRAdrxBt0c/gSRgSBxumwTJEuyOz9WB6AbLYTNP0g5N96GrQzU3G3LvqJR8n5Pw
         UeuCKS1+qNkPtvD9EgBCMku5xheO9fzMptW2Lea4=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] Btrfs: fix memory leak of transaction when deleting unused block group
Date:   Fri, 17 Apr 2020 15:40:12 +0100
Message-Id: <20200417144012.9269-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When cleaning pinned extents right before deleting an unused block group,
we check if there's still a previous transaction running and if so we
increment its reference count before using it for cleaning pinned ranges
in its pinned extents iotree. However we ended up never decrementing the
reference count after using the transaction, resulting in a memory leak.

Fix it by decrementing the reference count.

Fixes: fe119a6eeb6705 ("btrfs: switch to per-transaction pinned extents")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 47f66c6a7d7f..93c180ffcb80 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1288,11 +1288,15 @@ static bool clean_pinned_extents(struct btrfs_trans_handle *trans,
 	if (ret)
 		goto err;
 	mutex_unlock(&fs_info->unused_bg_unpin_mutex);
+	if (prev_trans)
+		refcount_dec(&prev_trans->use_count);
 
 	return true;
 
 err:
 	mutex_unlock(&fs_info->unused_bg_unpin_mutex);
+	if (prev_trans)
+		refcount_dec(&prev_trans->use_count);
 	btrfs_dec_block_group_ro(bg);
 	return false;
 }
-- 
2.11.0

