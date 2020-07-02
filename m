Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B61212258
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 13:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbgGBLcd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 07:32:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:51396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728257AbgGBLcd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jul 2020 07:32:33 -0400
Received: from debian8.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E829020780
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jul 2020 11:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593689553;
        bh=VOCc8nBkGVUT24q9HY7RDL8gKPfLW27nfAhM5xMnE60=;
        h=From:To:Subject:Date:From;
        b=NecWGJzKzXXi+B/4fGgquJKy42m9ylur9+QWNavOxFjbPMnfOSz4wY4iRGXjHdxrT
         9u8yjNA8ZMWveUemAEBur5aXvILeiU+dU9W9Pw4P0g8RHHE15yK329zzw1UVv+NT5d
         +U5BZ/pqMnqa14I7SZcKj33F/2krow5p3KYFZPCQ=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/4] btrfs: stop incremening log_batch for the log root tree when syncing log
Date:   Thu,  2 Jul 2020 12:32:31 +0100
Message-Id: <20200702113231.168052-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

We are incrementing the log_batch atomic counter of the root log tree but
we never use that counter, it's used only for the log trees of subvolume
roots. We started doing it when we moved the log_batch and log_write
counters from the global, per fs, btrfs_fs_info structure, into the
btrfs_root structure in commit 7237f1833601dc ("Btrfs: fix tree logs
parallel sync").

So just stop doing it for the log root tree and add a comment over the
field declaration so inform it's used only for log trees of subvolume
roots.

This patch is part of a series that has the following patches:

1/4 btrfs: only commit the delayed inode when doing a full fsync
2/4 btrfs: only commit delayed items at fsync if we are logging a directory
3/4 btrfs: stop incremening log_batch for the log root tree when syncing log
4/4 btrfs: remove no longer needed use of log_writers for the log root tree

After the entire patchset applied I saw about 12% decrease on max latency
reported by dbench. The test was done on a qemu vm, with 8 cores, 16Gb of
ram, using kvm and using a raw NVMe device directly (no intermediary fs on
the host). The test was invoked like the following:

  mkfs.btrfs -f /dev/sdk
  mount -o ssd -o nospace_cache /dev/sdk /mnt/sdk
  dbench -D /mnt/sdk -t 300 8
  umount /mnt/dsk

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.h    | 1 +
 fs/btrfs/tree-log.c | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 4dd478b4fe3a..a79e8164b26b 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1062,6 +1062,7 @@ struct btrfs_root {
 	struct list_head log_ctxs[2];
 	atomic_t log_writers;
 	atomic_t log_commit[2];
+	/* Used only for log trees of subvolumes, not for the log root tree. */
 	atomic_t log_batch;
 	int log_transid;
 	/* No matter the commit succeeds or not*/
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 7c325451d47f..ccc6b59f6729 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3116,7 +3116,6 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
 	btrfs_init_log_ctx(&root_log_ctx, NULL);
 
 	mutex_lock(&log_root_tree->log_mutex);
-	atomic_inc(&log_root_tree->log_batch);
 	atomic_inc(&log_root_tree->log_writers);
 
 	index2 = log_root_tree->log_transid % 2;
-- 
2.26.2

