Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 272B111214F
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Dec 2019 03:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfLDCPV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Dec 2019 21:15:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:47506 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726162AbfLDCPU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Dec 2019 21:15:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EFE6BB174
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Dec 2019 02:15:18 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: restore: Do proper mirror iteration in copy_one_extent()
Date:   Wed,  4 Dec 2019 10:15:14 +0800
Message-Id: <20191204021514.19147-1-wqu@suse.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The old code of copy_one_extent() is a mess:
- The main loop is implemented using goto
- @mirror_num is reset to 1 for each loop
- @mirror num check against @num_copies is wrong for decompression error

This patch will fix this mess by:
- Use read_extent_data()
  read_extent_data() has all the good wrapping of btrfs_map_block()
  and length check.
  This removes a lot of complexity.

- Add extra file extent offset check
  To prevent underflow for memory allocation

- Do proper mirror_num check for decompression error

Issue: #221
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 cmds/restore.c | 87 ++++++++++++++++++++++----------------------------
 1 file changed, 38 insertions(+), 49 deletions(-)

diff --git a/cmds/restore.c b/cmds/restore.c
index c104b01aef69..ee5c42f1a542 100644
--- a/cmds/restore.c
+++ b/cmds/restore.c
@@ -346,8 +346,6 @@ static int copy_one_extent(struct btrfs_root *root, int fd,
 			   struct extent_buffer *leaf,
 			   struct btrfs_file_extent_item *fi, u64 pos)
 {
-	struct btrfs_multi_bio *multi = NULL;
-	struct btrfs_device *device;
 	char *inbuf, *outbuf = NULL;
 	ssize_t done, total = 0;
 	u64 bytenr;
@@ -356,12 +354,10 @@ static int copy_one_extent(struct btrfs_root *root, int fd,
 	u64 num_bytes;
 	u64 length;
 	u64 size_left;
-	u64 dev_bytenr;
 	u64 offset;
-	u64 count = 0;
+	u64 cur;
 	int compress;
 	int ret;
-	int dev_fd;
 	int mirror_num = 1;
 	int num_copies;
 
@@ -372,14 +368,26 @@ static int copy_one_extent(struct btrfs_root *root, int fd,
 	offset = btrfs_file_extent_offset(leaf, fi);
 	num_bytes = btrfs_file_extent_num_bytes(leaf, fi);
 	size_left = disk_size;
-	if (compress == BTRFS_COMPRESS_NONE)
+	/* Hole, early exit */
+	if (disk_size == 0)
+		return 0;
+
+	/* Invalid file extent */
+	if ((compress == BTRFS_COMPRESS_NONE && offset >= disk_size) ||
+	    offset > ram_size) {
+		error(
+	"invalid data extent offset, offset=%llu disk_size=%llu ram_size=%llu",
+		      offset, disk_size, ram_size);
+		return -EUCLEAN;
+	}
+
+	if (compress == BTRFS_COMPRESS_NONE && offset < disk_size) {
 		bytenr += offset;
+		size_left -= offset;
+	}
 
 	if (verbose && offset)
 		printf("offset is %Lu\n", offset);
-	/* we found a hole */
-	if (disk_size == 0)
-		return 0;
 
 	inbuf = malloc(size_left);
 	if (!inbuf) {
@@ -395,48 +403,29 @@ static int copy_one_extent(struct btrfs_root *root, int fd,
 			return -ENOMEM;
 		}
 	}
+
+	num_copies = btrfs_num_copies(root->fs_info, bytenr,
+				      disk_size - offset);
 again:
-	length = size_left;
-	ret = btrfs_map_block(root->fs_info, READ, bytenr, &length, &multi,
-			      mirror_num, NULL);
-	if (ret) {
-		error("cannot map block logical %llu length %llu: %d",
-				(unsigned long long)bytenr,
-				(unsigned long long)length, ret);
-		goto out;
-	}
-	device = multi->stripes[0].dev;
-	dev_fd = device->fd;
-	device->total_ios++;
-	dev_bytenr = multi->stripes[0].physical;
-	free(multi);
-
-	if (size_left < length)
-		length = size_left;
-
-	done = pread(dev_fd, inbuf+count, length, dev_bytenr);
-	/* Need both checks, or we miss negative values due to u64 conversion */
-	if (done < 0 || done < length) {
-		num_copies = btrfs_num_copies(root->fs_info, bytenr, length);
-		mirror_num++;
-		/* mirror_num is 1-indexed, so num_copies is a valid mirror. */
-		if (mirror_num > num_copies) {
-			ret = -1;
-			error("exhausted mirrors trying to read (%d > %d)",
+	cur = bytenr;
+	while (cur < bytenr + size_left) {
+		length = bytenr + size_left - cur;
+		ret = read_extent_data(root->fs_info, inbuf + cur - bytenr, cur,
+				       &length, mirror_num);
+		if (ret < 0) {
+			mirror_num++;
+			if (mirror_num > num_copies) {
+				ret = -1;
+				error("exhausted mirros trying to read (%d > %d)",
 					mirror_num, num_copies);
-			goto out;
+				goto out;
+			}
+			fprintf(stderr, "Trying another mirror\n");
+			continue;
 		}
-		fprintf(stderr, "Trying another mirror\n");
-		goto again;
+		cur += length;
 	}
 
-	mirror_num = 1;
-	size_left -= length;
-	count += length;
-	bytenr += length;
-	if (size_left)
-		goto again;
-
 	if (compress == BTRFS_COMPRESS_NONE) {
 		while (total < num_bytes) {
 			done = pwrite(fd, inbuf+total, num_bytes-total,
@@ -454,13 +443,13 @@ again:
 
 	ret = decompress(root, inbuf, outbuf, disk_size, &ram_size, compress);
 	if (ret) {
-		num_copies = btrfs_num_copies(root->fs_info, bytenr, length);
 		mirror_num++;
-		if (mirror_num >= num_copies) {
+		if (mirror_num > num_copies) {
 			ret = -1;
 			goto out;
 		}
-		fprintf(stderr, "Trying another mirror\n");
+		fprintf(stderr,
+			"Trying another mirror due to decompression error\n");
 		goto again;
 	}
 
-- 
2.24.0

