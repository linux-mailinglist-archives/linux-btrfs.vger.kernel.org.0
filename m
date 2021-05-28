Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F8039410B
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 May 2021 12:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236473AbhE1KjM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 May 2021 06:39:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:59120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236436AbhE1KjK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 May 2021 06:39:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A251613B5
        for <linux-btrfs@vger.kernel.org>; Fri, 28 May 2021 10:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622198256;
        bh=Ffsh2KKWA1YHGS1V4ww/40+p0zR2l1PLOYXb0NQC4tk=;
        h=From:To:Subject:Date:From;
        b=Ivz6z/MuT3yBL+2bN7wSMSTyG18bqbzg36JN2tIQz9Cyx0cWJGl0sFGRICY0fIGSq
         Hw88wopkZa79lozBfustfbEY9lnTGlQYH7Ni0YzytrC6kLJKr/Vx967cChViaI3xhx
         z4/XLuXc+Pdwtyo5CQV/PAQsFNWOQFrlK8R/tS1/DWx3jF8eIOL5F5iqQJBxRw5NQH
         7wHEFFhkAX88/pgCTGLAtwZl5jByMGwI1nApJ1WjXJ00xt7I9EGjnGBykmZvs3CNzo
         uo+Fbu9qwKDOrefHEZ6eYZSFKNVUqOgC4D2trYmu0ERYkzqEM1T4NUjTA9ThLmb9qK
         eAJ+JD39iBJ6A==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: avoid unnecessary logging of xattrs during fast fsyncs
Date:   Fri, 28 May 2021 11:37:32 +0100
Message-Id: <712009b23575e0d7a82f86072fa6e9bf14ec4efa.1622197177.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When logging an inode we always log all its xattrs, so that we are able
to figure out which ones should be deleted during log replay. However this
is unnecessary when we are doing a fast fsync and no xattrs were added,
changed or deleted since the last time we logged the inode in the current
transaction.

So skip the logging of xattrs when the inode was previously logged in the
current transaction and no xattrs were added, changed or deleted. If any
changes to xattrs happened, than the inode has BTRFS_INODE_COPY_EVERYTHING
set in its runtime flags and the xattrs get logged. This saves time on
scanning for xattrs, allocating memory, COWing log tree extent buffers and
adding more lock contention on the extent buffers when there are multiple
tasks logging in parallel.

The use of xattrs is common when using ACLs, some applications, or when
using security modules like SELinux where every inode gets a security
xattr added to it.

The following test script, using fio, was used on a box with 12 cores, 64G
of RAM, a NVMe device and the default non-debug kernel config from Debian.
It uses 8 concurrent jobs each writing in blocks of 64K to its own 4G file,
each file with a single xattr of 50 bytes (about the same size for an ACL
or SELinux xattr), doing random buffered writes with an fsync after each
write.

   $ cat test.sh
   #!/bin/bash

   DEV=/dev/nvme0n1
   MNT=/mnt/test
   MOUNT_OPTIONS="-o ssd"
   MKFS_OPTIONS="-d single -m single"

   NUM_JOBS=8
   FILE_SIZE=4G

   cat <<EOF > /tmp/fio-job.ini
   [writers]
   rw=randwrite
   fsync=1
   fallocate=none
   group_reporting=1
   direct=0
   bs=64K
   ioengine=sync
   size=$FILE_SIZE
   directory=$MNT
   numjobs=$NUM_JOBS
   EOF

   echo "performance" | \
       tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

   mkfs.btrfs -f $MKFS_OPTIONS $DEV > /dev/null
   mount $MOUNT_OPTIONS $DEV $MNT

   echo "Creating files before fio runs, each with 1 xattr of 50 bytes"
   for ((i = 0; i < $NUM_JOBS; i++)); do
       path="$MNT/writers.$i.0"
       truncate -s $FILE_SIZE $path
       setfattr -n user.xa1 -v $(printf '%0.sX' $(seq 50)) $path
   done

   fio /tmp/fio-job.ini
   umount $MNT

fio output before this change:

WRITE: bw=120MiB/s (126MB/s), 120MiB/s-120MiB/s (126MB/s-126MB/s), io=32.0GiB (34.4GB), run=272145-272145msec

fio output after this change:

WRITE: bw=142MiB/s (149MB/s), 142MiB/s-142MiB/s (149MB/s-149MB/s), io=32.0GiB (34.4GB), run=230408-230408msec

+16.8% throughput, -16.6% runtime

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index c6d4aeede159..6234dd566eac 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -5467,13 +5467,23 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 	btrfs_release_path(dst_path);
 	if (need_log_inode_item) {
 		err = log_inode_item(trans, log, dst_path, inode);
-		if (!err && !xattrs_logged) {
+		if (err)
+			goto out_unlock;
+		/*
+		 * If we are doing a fast fsync and the inode was logged before
+		 * in this transaction, we don't need to log the xattrs because
+		 * they were logged before. If xattrs were added, changed or
+		 * deleted since the last time we logged the inode, then we have
+		 * already logged them because the inode had the runtime flag
+		 * BTRFS_INODE_COPY_EVERYTHING set.
+		 */
+		if (!xattrs_logged && inode->logged_trans < trans->transid) {
 			err = btrfs_log_all_xattrs(trans, root, inode, path,
 						   dst_path);
+			if (err)
+				goto out_unlock;
 			btrfs_release_path(path);
 		}
-		if (err)
-			goto out_unlock;
 	}
 	if (fast_search) {
 		ret = btrfs_log_changed_extents(trans, root, inode, dst_path,
-- 
2.28.0

