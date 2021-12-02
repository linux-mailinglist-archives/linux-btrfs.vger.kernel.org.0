Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A12A7466178
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Dec 2021 11:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356994AbhLBKeO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Dec 2021 05:34:14 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:50518 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356986AbhLBKeM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Dec 2021 05:34:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 59FC7CE2131
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Dec 2021 10:30:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB28C53FCB
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Dec 2021 10:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638441048;
        bh=a6114suPyocTPMf1t9V0aVxrusR6FaURfkzzrIje8l0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Ln9V0BFVcjnkPKO2rfGuTIb6SZ1na1+xCm80KI7A4G7KikNc+15bRBzCaglUnaiHA
         l6rMt33kfwYEGXbrdiOaGlkS/oowhmIJNDq49GRTtQicKDtoW0d9hoExbPKEyZTNlZ
         AX4If1eo+GenGlAERXm5il2RXdNluHTWfA+95abkg3/Dt8o/JXi1KxlQu7UmiaO1ZD
         IWMNfL+BlQbyZRZuk1/GZnQ/c5BxVbGLsJf5MK9+BYOW5I0u62B6072adq1YDC9gbv
         mNppbNV/oH3cJluLGX9xkt82zEmQz/agqJ1uGzhVPO1fNLa1pLjG3B7LSjF6Pkyhz+
         0TLZnnHGiIpvw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 6/6] btrfs: remove stale comment about locking at btrfs_search_slot()
Date:   Thu,  2 Dec 2021 10:30:40 +0000
Message-Id: <a2a4e75a7ec612acb6223b408e4722d62dd0cd22.1638440535.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1638440535.git.fdmanana@suse.com>
References: <cover.1638440535.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The comment refers to the old extent buffer locking code, where we used to
have custom locks that had blocking and spinning behaviour modes. That is
not the case anymore, since we have transitioned to rw semaphores, so the
comment does not offer any value anymore. Remove it.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index bcf99c787d68..fdd286ab1259 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1963,10 +1963,6 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		}
 cow_done:
 		p->nodes[level] = b;
-		/*
-		 * Leave path with blocking locks to avoid massive
-		 * lock context switch, this is made on purpose.
-		 */
 
 		/*
 		 * we have a lock on b and as long as we aren't changing
-- 
2.33.0

