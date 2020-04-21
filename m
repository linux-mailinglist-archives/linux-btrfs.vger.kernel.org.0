Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9061B23B2
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Apr 2020 12:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgDUKZf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Apr 2020 06:25:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:58706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbgDUKZe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Apr 2020 06:25:34 -0400
Received: from debian6.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B806C2064A
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Apr 2020 10:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587464734;
        bh=R9rOPjTHKjACZWwQa0YeTZnA/IV0bIMHrr6kTKd+Lzc=;
        h=From:To:Subject:Date:From;
        b=0x7JJ3DMPQM8daD8Ln7DqUfaIgY9rGJNKZSd9sQ39oc6nZBug2IfO/SxKiwKO45QF
         6mDQFbS3D2ZefnVMD+/p/h7rqfxJrS/pmgBV8GaLfWbCMwl+BBYxr5Z1D79bdKZhWz
         VRPV/kuP3jOWiciGbKk8Ky/bexQZck0qx9YSS3pw=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] Btrfs: remove useless check for copy_items() return value
Date:   Tue, 21 Apr 2020 11:25:31 +0100
Message-Id: <20200421102531.14736-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

At btrfs_log_prealloc_extents() we are checking if copy_items() returns a
value greater than 0. That used to happen in the past to signal the caller
that the path given to it was released and reused for other searches, but
as of commit 0e56315ca147b3 ("Btrfs: fix missing hole after hole punching
and fsync when using NO_HOLES"), the copy_items() function does not have
that behaviour anymore and always returns 0 or a negative value. So just
remove that check at btrfs_log_prealloc_extents(), which the previously
mentioned commit forgot to remove.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 9761e6d538fb..0352ba62ec2b 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4336,12 +4336,9 @@ static int btrfs_log_prealloc_extents(struct btrfs_trans_handle *trans,
 			}
 		}
 	}
-	if (ins_nr > 0) {
+	if (ins_nr > 0)
 		ret = copy_items(trans, inode, dst_path, path,
 				 start_slot, ins_nr, 1, 0);
-		if (ret > 0)
-			ret = 0;
-	}
 out:
 	btrfs_release_path(path);
 	btrfs_free_path(dst_path);
-- 
2.11.0

