Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8685C629EF5
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 17:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238601AbiKOQZf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 11:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238623AbiKOQZd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 11:25:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0231ED12D
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 08:25:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93D61618EC
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 16:25:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D6E0C433C1
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 16:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668529532;
        bh=QuYzOF/LvEOsxg+KC2PeeTy5K2jMNVYi04vj0qP8nk8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ItzUitMP8s7WNc95GBWM7taNo/JaV+YL04XT7OnpQPB7rcYl+9Sqin+9LeKDJsUJ0
         ZT26SNWJki7DpZGbjeYYkAG2OXjy9mV9e0IbIeJC4R81vtJpEb6ofY9/MIgcFK3vDZ
         S+MoE1K4RpBX4HTypY3d/+lXkzQ/xhyUmhkJCcdxH69k5WL6pzjX2XN4hfoi7WSfw5
         vVjuoZ1QLJ+Ju7A/0ZqSESoIHFeqrsPkQAy2RskDnw2UqJ7iCzitrO7N3avBxuP8YW
         qJ+EotmaxO3hyaKUSuM/YeV9XiEGSYbcgPcreABR8viAAkCCDX5y87DwAeL0Rsuu1G
         D8eEz94TzhhAA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs-progs: receive: fix silent data loss after fall back from encoded write
Date:   Tue, 15 Nov 2022 16:25:26 +0000
Message-Id: <59f1b932bfd1549f777d18b814feeaabef0860ee.1668529099.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1668529099.git.fdmanana@suse.com>
References: <cover.1668529099.git.fdmanana@suse.com>
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

When attempting an encoded write, if it fails for some specific reason
like -EINVAL (when an offset is not sector size aligned) or -ENOSPC, we
then fallback into decompressing the data and writing it using regular
buffered IO. This logic however is not correct, one of the reasons is
that it assumes the encoded offset is smaller than the unencoded file
length and that they can be compared, but one is an offset and the other
is a length, not an end offset, so they can't be compared to get correct
results. This bad logic will often result in not copying all data, or even
no data at all, resulting in a silent data loss. This is easily seen in
with the following reproducer:

   $ cat test.sh
   #!/bin/bash

   DEV=/dev/sdj
   MNT=/mnt/sdj

   umount $DEV &> /dev/null
   mkfs.btrfs -f $DEV > /dev/null
   mount -o compress $DEV $MNT

   # File foo has a size of 33K, not aligned to the sector size.
   xfs_io -f -c "pwrite -S 0xab 0 33K" $MNT/foo

   xfs_io -f -c "pwrite -S 0xcd 0 64K" $MNT/bar

   # Now clone the first 32K of file bar into foo at offset 0.
   xfs_io -c "reflink $MNT/bar 0 0 32K" $MNT/foo

   # Snapshot the default subvolume and create a full send stream (v2).
   btrfs subvolume snapshot -r $MNT $MNT/snap

   btrfs send --compressed-data -f /tmp/test.send $MNT/snap

   echo -e "\nFile bar in the original filesystem:"
   od -A d -t x1 $MNT/snap/bar

   umount $MNT
   mkfs.btrfs -f $DEV > /dev/null
   mount $DEV $MNT

   echo -e "\nReceiving stream in a new filesystem..."
   btrfs receive -f /tmp/test.send $MNT

   echo -e "\nFile bar in the new filesystem:"
   od -A d -t x1 $MNT/snap/bar

   umount $MNT

Running the test without this patch:

   $ ./test.sh
   (...)
   File bar in the original filesystem:
   0000000 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd
   *
   0065536

   Receiving stream in a new filesystem...
   At subvol snap

   File bar in the new filesystem:
   0000000 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd
   *
   0033792

We end up with file bar having less data, and a smaller size, than in the
original filesystem.

This happens because when processing file bar, send issues the following
commands:

   clone bar - source=foo source offset=0 offset=0 length=32768
   write bar - offset=32768 length=1024
   encoded_write bar - offset=33792, len=4096, unencoded_offset=33792, unencoded_file_len=31744, unencoded_len=65536, compression=1, encryption=0

The first 32K are cloned from file foo, as that file ranged is shared
between the files.

Then there's a regular write operation for the file range [32K, 33K[,
since file foo has different data from bar for that file range.

Finally for the remainder of file bar, the send side issues an encoded
write since the extent is compressed in the source filesystem, for the
file offset 33792 (33K), remaining 31K of data. The receiver will try the
encoded write, but that fails with -EINVAL since the offset 33K is not
sector size aligned, so it will fallback to decompressing the data and
writing it using regular buffered writes. However that results in doing
no writes at decompress_and_write() because 'pos' is initialized to the
value of 33K (unencoded_offset) and unencoded_file_len is 31K, so the
while loop has no iterations.

Another case where we can fallback to decompression plus regular buffered
writes is when the destination filesystem has a sector size larger then
the sector size of the source filesystem (for example when the source
filesystem is on x86_64 with a 4K sector size and the destination
filesystem is PowerPC with a 64K sector size). In that scenario encoded
write attempts wil fail with -EINVAL due to offsets not being aligned with
the sector size of the destination filesystem, and the receive will
attempt the fallback of decompressing the buffer and writing the
decompressed using regular buffered IO.

Fix this by tracking the number of written bytes instead, and increment
it, and the unencoded offset, after each write.

Fixes: d20e759fc917 ("btrfs-progs: receive: encoded_write fallback to explicit decode and write")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 cmds/receive.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/cmds/receive.c b/cmds/receive.c
index e6f1aeab..0db66ee5 100644
--- a/cmds/receive.c
+++ b/cmds/receive.c
@@ -1155,10 +1155,9 @@ static int decompress_and_write(struct btrfs_receive *rctx,
 				u32 compression)
 {
 	int ret = 0;
-	size_t pos;
-	ssize_t w;
 	char *unencoded_data;
 	int sector_shift = 0;
+	u64 written = 0;
 
 	unencoded_data = calloc(unencoded_len, 1);
 	if (!unencoded_data) {
@@ -1209,17 +1208,19 @@ static int decompress_and_write(struct btrfs_receive *rctx,
 		goto out;
 	}
 
-	pos = unencoded_offset;
-	while (pos < unencoded_file_len) {
-		w = pwrite(rctx->write_fd, unencoded_data + pos,
-			   unencoded_file_len - pos, offset);
+	while (written < unencoded_file_len) {
+		ssize_t w;
+
+		w = pwrite(rctx->write_fd, unencoded_data + unencoded_offset,
+			   unencoded_file_len - written, offset);
 		if (w < 0) {
 			ret = -errno;
 			error("writing unencoded data failed: %m");
 			goto out;
 		}
-		pos += w;
+		written += w;
 		offset += w;
+		unencoded_offset += w;
 	}
 out:
 	free(unencoded_data);
-- 
2.35.1

