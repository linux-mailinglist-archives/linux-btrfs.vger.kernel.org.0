Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC49017E06F
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Mar 2020 13:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgCIMlO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Mar 2020 08:41:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:53976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbgCIMlN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Mar 2020 08:41:13 -0400
Received: from debian6.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9604320828;
        Mon,  9 Mar 2020 12:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583757673;
        bh=MQrOIROON+07u3xZbz9UplMynesdIwhDz4YTpXJy1WQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fuub8GOR0uXL0qu3dzUY4EW9Wn2I5OWZTU0zOuKRhkCFNQoCFuT45esYcK8mmSPHz
         a8gK8J/5QfQXXngDPQU/FI+Dbcu1Hen9rXlhV1VR0qoDuqqgD5OTt2jYiQRTSG5kKG
         B0xbYT+ZCEqy88d6tBrnhsk47NH9sLMwPN6Gcs4M=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com
Subject: [PATCH v3 1/4] Btrfs: fix missing file extent item for hole after ranged fsync
Date:   Mon,  9 Mar 2020 12:41:05 +0000
Message-Id: <20200309124108.18952-2-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200309124108.18952-1-fdmanana@kernel.org>
References: <20200309124108.18952-1-fdmanana@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When doing a fast fsync for a range that starts at an offset greater than
zero, we can end up with a log that when replayed causes the respective
inode miss a file extent item representing a hole if we are not using the
NO_HOLES feature. This is because for fast fsyncs we don't log any extents
that cover a range different from the one requested in the fsync.

Example scenario to trigger it:

  $ mkfs.btrfs -O ^no-holes -f /dev/sdd
  $ mount /dev/sdd /mnt

  # Create a file with a single 256K and fsync it to clear to full sync
  # bit in the inode - we want the msync below to trigger a fast fsync.
  $ xfs_io -f -c "pwrite -S 0xab 0 256K" -c "fsync" /mnt/foo

  # Force a transaction commit and wipe out the log tree.
  $ sync

  # Dirty 768K of data, increasing the file size to 1Mb, and flush only
  # the range from 256K to 512K without updating the log tree
  # (sync_file_range() does not trigger fsync, it only starts writeback
  # and waits for it to finish).

  $ xfs_io -c "pwrite -S 0xcd 256K 768K" /mnt/foo
  $ xfs_io -c "sync_range -abw 256K 256K" /mnt/foo

  # Now dirty the range from 768K to 1M again and sync that range.
  $ xfs_io -c "mmap -w 768K 256K"        \
           -c "mwrite -S 0xef 768K 256K" \
           -c "msync -s 768K 256K"       \
           -c "munmap"                   \
           /mnt/foo

  <power fail>

  # Mount to replay the log.
  $ mount /dev/sdd /mnt
  $ umount /mnt

  $ btrfs check /dev/sdd
  Opening filesystem to check...
  Checking filesystem on /dev/sdd
  UUID: 482fb574-b288-478e-a190-a9c44a78fca6
  [1/7] checking root items
  [2/7] checking extents
  [3/7] checking free space cache
  [4/7] checking fs roots
  root 5 inode 257 errors 100, file extent discount
  Found file extent holes:
       start: 262144, len: 524288
  ERROR: errors found in fs roots
  found 720896 bytes used, error(s) found
  total csum bytes: 512
  total tree bytes: 131072
  total fs tree bytes: 32768
  total extent tree bytes: 16384
  btree space waste bytes: 123514
  file data blocks allocated: 589824
    referenced 589824

Fix this issue by setting the range to full (0 to LLONG_MAX) when the
NO_HOLES feature is not enabled. This results in extra work being done
but it gives the guarantee we don't end up with missing holes after
replaying the log.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 31c72371a164..4a536387e992 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2072,6 +2072,16 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	btrfs_init_log_ctx(&ctx, inode);
 
 	/*
+	 * Set the range to full if the NO_HOLES feature is not enabled.
+	 * This is to avoid missing file extent items representing holes after
+	 * replaying the log.
+	 */
+	if (!btrfs_fs_incompat(fs_info, NO_HOLES)) {
+		start = 0;
+		end = LLONG_MAX;
+	}
+
+	/*
 	 * We write the dirty pages in the range and wait until they complete
 	 * out of the ->i_mutex. If so, we can flush the dirty pages by
 	 * multi-task, and make the performance up.  See
-- 
2.11.0

