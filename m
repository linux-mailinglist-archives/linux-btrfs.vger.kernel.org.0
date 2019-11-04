Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72F3DEE9E6
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2019 21:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729707AbfKDUjK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Nov 2019 15:39:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:57776 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729194AbfKDUjJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 Nov 2019 15:39:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 51A18AE99;
        Mon,  4 Nov 2019 20:39:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B8C91DB6FC; Mon,  4 Nov 2019 21:39:15 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: un-deprecate ioctls START_SYNC and WAIT_SYNC
Date:   Mon,  4 Nov 2019 21:39:14 +0100
Message-Id: <20191104203914.15535-1-dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The two ioctls START_SYNC and WAIT_SYNC were mistakenly marked as
deprecated and scheduled for removal but we actualy do use them for
'btrfs subvolume delete -C/-c'. The deprecated thing in ebc87351e5fc
should have been just the async flag for subvolume creation.

The deprecation has been added in this development cycle, remove it
until it's time.

Fixes: ebc87351e5fc ("btrfs: Deprecate BTRFS_SUBVOL_CREATE_ASYNC flag")
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ioctl.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index b4ffa232479a..4cf255830bc5 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4193,9 +4193,6 @@ static noinline long btrfs_ioctl_start_sync(struct btrfs_root *root,
 	u64 transid;
 	int ret;
 
-	btrfs_warn(root->fs_info,
-	"START_SYNC ioctl is deprecated and will be removed in kernel 5.7");
-
 	trans = btrfs_attach_transaction_barrier(root);
 	if (IS_ERR(trans)) {
 		if (PTR_ERR(trans) != -ENOENT)
@@ -4223,9 +4220,6 @@ static noinline long btrfs_ioctl_wait_sync(struct btrfs_fs_info *fs_info,
 {
 	u64 transid;
 
-	btrfs_warn(fs_info,
-		"WAIT_SYNC ioctl is deprecated and will be removed in kernel 5.7");
-
 	if (argp) {
 		if (copy_from_user(&transid, argp, sizeof(transid)))
 			return -EFAULT;
-- 
2.23.0

