Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFAE13CFDBD
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jul 2021 17:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242070AbhGTO7Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Jul 2021 10:59:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:60370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238604AbhGTOXJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Jul 2021 10:23:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A3EC761221
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jul 2021 15:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626793428;
        bh=GCWSgJv0O5b/TTmkNc/TM2xTovX2nsBhft6rNioGj0Y=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=krcXC5DYtt21onZm/2GkNOFkpZzklnZuNYBAGZ3ua+qcRLhy/saDAGrblwtDBC9X5
         pKQpY1RmRO+WF7VjzZThECLtqJo9g5qLMhMVX7IsF6Q53QGLO1rLxFRWTb+InumMNP
         damMQd4CeYFL6oE/8GXDuFtPJaZq9c8T9oguVdA/KAD8BiamMANosI3YUifUMLeNGn
         2EowSdTZaucGAU0wVwIZLBw7e54/I56mzNklIIFfMriSVMTH/UJAEgjuZKLwqteWCh
         E189xKiDfAQbc6CV2SS9+Bsons9kBiPKKW1ipYN9Bpawn7xsBurvMBdkWZ/9uJuScK
         TQM8XMm/jV8Ew==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/4] btrfs: remove unnecessary list head initialization when syncing log
Date:   Tue, 20 Jul 2021 16:03:42 +0100
Message-Id: <589f5a66b472b93df01e5e798acd5123b5582769.1626791500.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1626791500.git.fdmanana@suse.com>
References: <cover.1626791500.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

One of the last steps of syncing the log is to remove all log contextes
from the root's list of contextes, done at btrfs_remove_all_log_ctxs().
There we iterate over all the contextes in the list and delete each one
from the list, and after that we call INIT_LIST_HEAD() on the list. That
is unnecessary since at that point the list is empty.

So just remove the INIT_LIST_HEAD() call. It's not needed, increases code
size (bloat-o-meter reported a delta of -122 for btrfs_sync_log() after
this change) and increases two critical sections delimited by log mutexes.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 90fb5a2fc60b..63f48715135c 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3039,8 +3039,6 @@ static inline void btrfs_remove_all_log_ctxs(struct btrfs_root *root,
 		list_del_init(&ctx->list);
 		ctx->log_ret = error;
 	}
-
-	INIT_LIST_HEAD(&root->log_ctxs[index]);
 }
 
 /*
-- 
2.30.2

