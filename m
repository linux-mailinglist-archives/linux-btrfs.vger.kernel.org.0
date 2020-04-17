Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD1DC1AE147
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Apr 2020 17:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbgDQPgS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Apr 2020 11:36:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:53740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728956AbgDQPgS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Apr 2020 11:36:18 -0400
Received: from debian7.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87A5820776
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Apr 2020 15:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587137778;
        bh=B3pkrIA5dZ68hPeqXsUjRMoNzibxzZpcV1uZE0ZNOFY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=rzaZawIK9qblPkGugvtzH2klVseX1WzfSqGUMQMVaWbaSjT3wQfJdqSr7wPnhKhp2
         E7t8dlBQU3Vf8EJzapMOqBHUPSCguFgx6lMflXixiW1eX2ubfDSEdm0A0CIOL5Cnmo
         ls0ZfL04ifFfIlrP+uviZdKxR3tGNwSmSTX68qHY=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/2] Btrfs: fix memory leak of transaction when deleting unused block group
Date:   Fri, 17 Apr 2020 16:36:15 +0100
Message-Id: <20200417153615.23832-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200417144012.9269-1-fdmanana@kernel.org>
References: <20200417144012.9269-1-fdmanana@kernel.org>
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

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

V2: Use btrfs_put_transaction() and not refcount_dec(), otherwise we are
    not really releasing the memory used by the transaction in case its
    refcount is 1. Stupid mistake.

 fs/btrfs/block-group.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 47f66c6a7d7f..af9e9a008724 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1288,11 +1288,15 @@ static bool clean_pinned_extents(struct btrfs_trans_handle *trans,
 	if (ret)
 		goto err;
 	mutex_unlock(&fs_info->unused_bg_unpin_mutex);
+	if (prev_trans)
+		btrfs_put_transaction(prev_trans);
 
 	return true;
 
 err:
 	mutex_unlock(&fs_info->unused_bg_unpin_mutex);
+	if (prev_trans)
+		btrfs_put_transaction(prev_trans);
 	btrfs_dec_block_group_ro(bg);
 	return false;
 }
-- 
2.11.0

