Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7633467E6
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Mar 2021 19:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbhCWSkM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Mar 2021 14:40:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:50664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232345AbhCWSjw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Mar 2021 14:39:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 39A95619A3
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Mar 2021 18:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616524792;
        bh=ApY9n/wZ2DIQy9uiJ3mIumS6oyLuV54Ke4b/1kejqjI=;
        h=From:To:Subject:Date:From;
        b=grmm2Z5VJXO+otBeR8orVm71lyusrwsU04VX25QKDAiBM8Gfc4oGvncIQiUk3NNgV
         Lo1ld4qYezMlwUkkOM6mgWtAUzNa83OHGSACk+5Dg1NZeAv5RPNRt1YrUCuwm4zXGO
         r8NfcFf09xS5ArqQ2zNHx4bJvLuE84sXl+yZ83Gv4q+wKVQkXOJ6JGqsgVLQS+85sg
         pOULkuDo1Jq/sAUN8Si1hFpDbHIpUriPb0X+9UezKXiDKsxgLqg5tJ3wC6jIeabXuK
         K07VEQPNeoSVUXw78QrwyPaK/9UpgeJek6thAUfJsK5eHYigszSkkvsdxa7JS6NDn1
         pL9JQfomUMBSg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: make reflinks respect O_SYNC O_DSYNC and S_SYNC flags
Date:   Tue, 23 Mar 2021 18:39:49 +0000
Message-Id: <dd702a279373c3b6babdf0d7a69c929e9924bb33.1616523672.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

If we reflink to or from a file opened with O_SYNC/O_DSYNC or to/from a
file that has the S_SYNC attribute set, we totally ignore that and do not
durably persist the reflink changes. Since a reflink can change the data
readable from a file (and mtime/ctime, or a file size), it makes sense to
durably persist (fsync) the source and destination files/ranges.

This was previously discussed at:

https://lore.kernel.org/linux-btrfs/20200903035225.GJ6090@magnolia/

The recently introduced test case generic/628, from fstests, exercises
these scenarios and currently fails without this change.

So make sure we fsync the source and destination files/ranges when either
of them was opened with O_SYNC/O_DSYNC or has the S_SYNC attribute set,
just like XFS already does.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/reflink.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 6746460fd219..598105574d05 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -834,6 +834,16 @@ static int btrfs_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 					    len, remap_flags);
 }
 
+static bool file_sync_write(struct file *file)
+{
+	if (file->f_flags & (__O_SYNC | O_DSYNC))
+		return true;
+	if (IS_SYNC(file_inode(file)))
+		return true;
+
+	return false;
+}
+
 loff_t btrfs_remap_file_range(struct file *src_file, loff_t off,
 		struct file *dst_file, loff_t destoff, loff_t len,
 		unsigned int remap_flags)
@@ -871,5 +881,19 @@ loff_t btrfs_remap_file_range(struct file *src_file, loff_t off,
 		unlock_two_nondirectories(src_inode, dst_inode);
 	}
 
+	/*
+	 * If either the source or the destination file was opened with O_SYNC,
+	 * O_DSYNC or has the S_SYNC attribute, fsync both the destination and
+	 * source files/ranges, so that after a successful return (0) followed
+	 * by a power failure results in the reflinked data to be readable from
+	 * both files/ranges.
+	 */
+	if (ret == 0 && (file_sync_write(src_file) || file_sync_write(dst_file))) {
+		ret = btrfs_sync_file(src_file, off, off + len - 1, 0);
+		if (ret == 0)
+			ret = btrfs_sync_file(dst_file, destoff,
+					      destoff + len - 1, 0);
+	}
+
 	return ret < 0 ? ret : len;
 }
-- 
2.28.0

