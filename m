Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15EE148DA8E
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jan 2022 16:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236024AbiAMPQV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jan 2022 10:16:21 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:42976 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiAMPQU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jan 2022 10:16:20 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8D5931F3A8;
        Thu, 13 Jan 2022 15:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642086979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=FpcGP6lPvmzb6nITcd3nakm3XI/9qrAcRVehC2FGYmA=;
        b=AAYM2l7UyxZsH4PSDbUgVmgJbPrBEGXuegy05fDC6IPX/0PP5+7yb2ryK4Wt/s1+3RaEU/
        umv/fO1qq54N1b9UjxsF5IaB34alSt/dd9LTBF5wJvDCM9nAR7SWPYIxRmn7rKGPpz3ivr
        uNb1VPLkIuknnC2raxwbAPIM5/4dV9w=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5476913DD1;
        Thu, 13 Jan 2022 15:16:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6G95EUNC4GG/EgAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 13 Jan 2022 15:16:19 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: move QUOTA_ENABLED check to rescan_should_stop from btrfs_qgroup_rescan_worker
Date:   Thu, 13 Jan 2022 17:16:18 +0200
Message-Id: <20220113151618.2149736-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Instead of having 2 places that short circuit the qgroup leaf scan have
everything in the qgroup_rescan_leaf function. In addition to that, also
ensure that the inconsistent qgroup flag is set when rescan_should_stop
returns true. This both retains the old behavior when -EINTR was set
in the body of the loop and at the same time also extends this behavior when
scanning is interrupted due to remount or unmount operations.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/qgroup.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 83d38d68f8e2..59e19e646f6e 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3253,7 +3253,8 @@ static int qgroup_rescan_leaf(struct btrfs_trans_handle *trans,
 static bool rescan_should_stop(struct btrfs_fs_info *fs_info)
 {
 	return btrfs_fs_closing(fs_info) ||
-		test_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state);
+		test_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state) ||
+		!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags);
 }

 static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
@@ -3283,11 +3284,9 @@ static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
 			err = PTR_ERR(trans);
 			break;
 		}
-		if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags)) {
-			err = -EINTR;
-		} else {
-			err = qgroup_rescan_leaf(trans, path);
-		}
+
+		err = qgroup_rescan_leaf(trans, path);
+
 		if (err > 0)
 			btrfs_commit_transaction(trans);
 		else
@@ -3301,7 +3300,7 @@ static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
 	if (err > 0 &&
 	    fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT) {
 		fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
-	} else if (err < 0) {
+	} else if (err < 0 || stopped) {
 		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
 	}
 	mutex_unlock(&fs_info->qgroup_rescan_lock);
--
2.25.1

