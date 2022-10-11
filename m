Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14AB5FB23F
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Oct 2022 14:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiJKMR2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Oct 2022 08:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiJKMRW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Oct 2022 08:17:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8144D175
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 05:17:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68160B815B8
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 12:17:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DBD7C433D7
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 12:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665490638;
        bh=obDzy7qbrC5qdorPpxZ4XfK5vK/3XuFfiX+KdPQlbgs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=KEOS04fBgl8Jsd0phwSEv2wfpWP2E16ALDAuXs/PPdBQmNWSD5nXjp9CSMhYYzYWM
         2o6Rme2jR+z6oUyMpKfCKmaTDs/hD0/2rIGUKOZ9DJKkaLu4XoSGqxrQk+4ZHrIYUe
         cOAZT+7dxGak6ZNnARTQ8LGtYohwI44UAUdXzeeK0PTy/HmlQ4eh1t/0Q68dpOXo8n
         LHniPedrJTZBqtWP1ULpyXlimPuc0Ii6s3D44G0LL599A6PFy5ntBIlJHpGxAk9yJq
         h73CY2OxpdTMfMfSWi8nrGwqUmTaJAyyG6vr4Qx/dRGY06W3dZlVG5ui3Pp5Ow4rdt
         bX0IG5lLY6n7w==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 06/19] btrfs: skip unnecessary delalloc search during fiemap and lseek
Date:   Tue, 11 Oct 2022 13:16:56 +0100
Message-Id: <fc0a66561505693ce3974992e58c81ae672cddc1.1665490018.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1665490018.git.fdmanana@suse.com>
References: <cover.1665490018.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

During fiemap and lseek (hole and data seeking), there's no point in
iterating the inode's io tree to count delalloc bits if the inode's
delalloc bytes counter has a value of zero, as that counter is updated
whenever we set a range for delalloc or clear a range from delalloc.

So skip the counting and io tree iteration if the inode's delalloc bytes
counter has a value of zero. This helps save time when processing a file
range corresponding to a hole or prealloc (unwritten) extent.

This patch is part of a series comprised of the following patches:

  btrfs: get the next extent map during fiemap/lseek more efficiently
  btrfs: skip unnecessary extent map searches during fiemap and lseek
  btrfs: skip unnecessary delalloc search during fiemap and lseek

The following test was performed on a release kernel (Debian's default
kernel config) before and after applying those 3 patches.

   # Wrapper to call fiemap in extent count only mode.
   # (struct fiemap::fm_extent_count set to 0)
   $ cat fiemap.c
   #include <stdio.h>
   #include <unistd.h>
   #include <stdlib.h>
   #include <fcntl.h>
   #include <errno.h>
   #include <string.h>
   #include <sys/ioctl.h>
   #include <linux/fs.h>
   #include <linux/fiemap.h>

   int main(int argc, char **argv)
   {
            struct fiemap fiemap = { 0 };
            int fd;

            if (argc != 2) {
                    printf("usage: %s <path>\n", argv[0]);
                    return 1;
            }
            fd = open(argv[1], O_RDONLY);
            if (fd < 0) {
                    fprintf(stderr, "error opening file: %s\n",
                            strerror(errno));
                    return 1;
            }

            /* fiemap.fm_extent_count set to 0, to count extents only. */
            fiemap.fm_length = FIEMAP_MAX_OFFSET;
            if (ioctl(fd, FS_IOC_FIEMAP, &fiemap) < 0) {
                    fprintf(stderr, "fiemap error: %s\n",
                            strerror(errno));
                    return 1;
            }
            close(fd);
            printf("fm_mapped_extents = %d\n", fiemap.fm_mapped_extents);

            return 0;
   }

   $ gcc -o fiemap fiemap.c

And the wrapper shell script that creates a file with many holes and runs
fiemap against it:

   $ cat test.sh
   #!/bin/bash

   DEV=/dev/sdi
   MNT=/mnt/sdi

   mkfs.btrfs -f $DEV
   mount $DEV $MNT

   FILE_SIZE=$((1 * 1024 * 1024 * 1024))
   echo -n > $MNT/foobar
   for ((off = 0; off < $FILE_SIZE; off += 8192)); do
           xfs_io -c "pwrite -S 0xab $off 4K" $MNT/foobar > /dev/null
   done

   # flush all delalloc
   sync

   start=$(date +%s%N)
   ./fiemap $MNT/foobar
   end=$(date +%s%N)
   dur=$(( (end - start) / 1000000 ))
   echo "fiemap took $dur milliseconds"

   umount $MNT

Result before applying patchset:

   fm_mapped_extents = 131072
   fiemap took 63 milliseconds

Result after applying patchset:

   fm_mapped_extents = 131072
   fiemap took 39 milliseconds   (-38.1%)

Running the same test for a 512M file instead of a 1G file, gave the
following results.

Result before applying patchset:

   fm_mapped_extents = 65536
   fiemap took 29 milliseconds

Result after applying patchset:

   fm_mapped_extents = 65536
   fiemap took 20 milliseconds    (-31.0%)

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 36618ddadc5f..0d0c662007ab 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3518,15 +3518,27 @@ static bool find_delalloc_subrange(struct btrfs_inode *inode, u64 start, u64 end
 	struct extent_map *em;
 	u64 em_end;
 	u64 delalloc_len;
+	unsigned int outstanding_extents;
 
 	/*
 	 * Search the io tree first for EXTENT_DELALLOC. If we find any, it
 	 * means we have delalloc (dirty pages) for which writeback has not
 	 * started yet.
 	 */
-	*delalloc_start_ret = start;
-	delalloc_len = count_range_bits(&inode->io_tree, delalloc_start_ret, end,
-					len, EXTENT_DELALLOC, 1);
+	spin_lock(&inode->lock);
+	outstanding_extents = inode->outstanding_extents;
+
+	if (inode->delalloc_bytes > 0) {
+		spin_unlock(&inode->lock);
+		*delalloc_start_ret = start;
+		delalloc_len = count_range_bits(&inode->io_tree,
+						delalloc_start_ret, end,
+						len, EXTENT_DELALLOC, 1);
+	} else {
+		spin_unlock(&inode->lock);
+		delalloc_len = 0;
+	}
+
 	/*
 	 * If delalloc was found then *delalloc_start_ret has a sector size
 	 * aligned value (rounded down).
@@ -3534,17 +3546,12 @@ static bool find_delalloc_subrange(struct btrfs_inode *inode, u64 start, u64 end
 	if (delalloc_len > 0)
 		*delalloc_end_ret = *delalloc_start_ret + delalloc_len - 1;
 
-	spin_lock(&inode->lock);
-	if (inode->outstanding_extents == 0) {
-		/*
-		 * No outstanding extents means we don't have any delalloc that
-		 * is flushing, so return the unflushed range found in the io
-		 * tree (if any).
-		 */
-		spin_unlock(&inode->lock);
+	/*
+	 * No outstanding extents means we don't have any delalloc that is
+	 * flushing, so return the unflushed range found in the io tree (if any).
+	 */
+	if (outstanding_extents == 0)
 		return (delalloc_len > 0);
-	}
-	spin_unlock(&inode->lock);
 
 	/*
 	 * Now also check if there's any extent map in the range that does not
-- 
2.35.1

