Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FD96A8BB4
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 23:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjCBWZP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 17:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjCBWZN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 17:25:13 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F2D1E5E9
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 14:25:12 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 65A6420069;
        Thu,  2 Mar 2023 22:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1677795911; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BayLPTvrNoPyBevDitXVYno3Aihm310TthDjjBwYREw=;
        b=tet7P5DkPABvJSLU8xL+yFbF/r8F20JFEaqc2Wm6kN7EyRVLrIHq1gXVSsN5oU8aUlQCKc
        GbyUB7iG5FF8s4SkX18Amig8Wt9pIUlZ4owPQBNGF2TDIXWwmWXEOOitKkQk6pO9NobiKS
        1v5FxIMaciIL1fKOVpvZgPLrDfGok00=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1677795911;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BayLPTvrNoPyBevDitXVYno3Aihm310TthDjjBwYREw=;
        b=p0JKifAKpE2B+xiim42Nzz26Nr5QQSdBxMhPLqpGMRq2wmEAvARNCyjtsKNwe9Vrg3ptSh
        J0XYjfYjhXl7mDAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A1A913349;
        Thu,  2 Mar 2023 22:25:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xGR4OkYiAWSbSQAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Thu, 02 Mar 2023 22:25:10 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 04/21] btrfs: make btrfs_qgroup_flush() non-static
Date:   Thu,  2 Mar 2023 16:24:49 -0600
Message-Id: <08b4b39eca92493c341831a6cb06836aac7a4967.1677793433.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1677793433.git.rgoldwyn@suse.com>
References: <cover.1677793433.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

btrfs_qgroup_flush() is used to flush data when a qgroup reservation
is unsuccessfull. This causes a writeback which takes extent locks.
If we have to make reservations under locks, we call reservation
function with nowait true, so it does not call btrfs_qgroup_flush().

btrfs_qgroup_flush() call becomes the responsibility of the function
performing reservations under locks. They must call the reservation
function with nowait=true.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/qgroup.c | 6 +++---
 fs/btrfs/qgroup.h | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 52a7d2fa2284..235bc78a8418 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3709,7 +3709,7 @@ static int qgroup_unreserve_range(struct btrfs_inode *inode,
  *   In theory this shouldn't provide much space, but any more qgroup space
  *   is needed.
  */
-static int try_flush_qgroup(struct btrfs_root *root)
+int btrfs_qgroup_flush(struct btrfs_root *root)
 {
 	struct btrfs_trans_handle *trans;
 	int ret;
@@ -3821,7 +3821,7 @@ int btrfs_qgroup_reserve_data(struct btrfs_inode *inode,
 	if (ret <= 0 && ret != -EDQUOT)
 		return ret;
 
-	ret = try_flush_qgroup(inode->root);
+	ret = btrfs_qgroup_flush(inode->root);
 	if (ret < 0)
 		return ret;
 	return qgroup_reserve_data(inode, reserved_ret, start, len);
@@ -4032,7 +4032,7 @@ int __btrfs_qgroup_reserve_meta(struct btrfs_root *root, int num_bytes,
 	if ((ret <= 0 && ret != -EDQUOT) || noflush)
 		return ret;
 
-	ret = try_flush_qgroup(root);
+	ret = btrfs_qgroup_flush(root);
 	if (ret < 0)
 		return ret;
 	return btrfs_qgroup_reserve_meta(root, num_bytes, type, enforce);
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index 7bffa10589d6..232bc5ad3dca 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -439,5 +439,6 @@ int btrfs_qgroup_trace_subtree_after_cow(struct btrfs_trans_handle *trans,
 		struct btrfs_root *root, struct extent_buffer *eb);
 void btrfs_qgroup_destroy_extent_records(struct btrfs_transaction *trans);
 bool btrfs_check_quota_leak(struct btrfs_fs_info *fs_info);
+int btrfs_qgroup_flush(struct btrfs_root *root);
 
 #endif
-- 
2.39.2

