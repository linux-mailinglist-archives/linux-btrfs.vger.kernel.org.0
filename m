Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C5B688397
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Feb 2023 17:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbjBBQAt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Feb 2023 11:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbjBBQAf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Feb 2023 11:00:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB05C6BBFC
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Feb 2023 07:59:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7856061BF2
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Feb 2023 15:59:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44603C433D2;
        Thu,  2 Feb 2023 15:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675353547;
        bh=V2oMGG6lwA1TAU7VB2C3esw2h8EnsEZ/FwUyV4ssYTo=;
        h=From:To:Cc:Subject:Date:From;
        b=NkAS1Ei09qtzoe3qBsDXnBHDPtmIXtrLF9YVTCjir9nFCAG4hT0Kp0SYosZh41v9R
         Pxp4DlyylVGaFPBjgoSKiX/xyqdgBIHoLh/6/B2HbNNDtUXDWll2Q2sof+StkQ+MQ+
         lx7din6IY1NeHSTmUccYqRUJDvn3GWlzn42G2qIWJ99mOE7rHd2kEVbzecN/+o0ztM
         1wALzE0jOifBpacJQyo6abm9cUEs8+f9vULgk3J9p0fZ7ODtafk3H/TA33O0EG5UJ3
         7nxkpuzkzs/9y5oLo+hQTbDWvswVX3pNunGg5lLoXzOxgRzkWnkphRH2XFxt5hgW9R
         O3ATWNPfuTzbQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs-progs: receive: fix a corruption when decompressing zstd extents
Date:   Thu,  2 Feb 2023 15:59:01 +0000
Message-Id: <556529ebcca0b5404ef0ce284d5ecccd2e2ae660.1675353238.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Before decompressing, we zero out the content of the entire output buffer,
so that we don't get any garbage after the last byte of data. We do this
for all compression algorithms. However zstd, at least with libzstd 1.5.2
on Debian (version 1.5.2+dfsg-1), the decompression routine can end up
touching the content of the output buffer beyond the last valid byte of
decompressed data, resulting in a corruption.

Example reproducer:

   $ cat test.sh
   #!/bin/bash

   DEV=/dev/sdj
   MNT=/mnt/sdj

   rm -f /tmp/send.stream

   umount $DEV &> /dev/null
   mkfs.btrfs -f $DEV &> /dev/null || echo "MKFS failed!"
   mount -o compress=zstd $DEV $MNT

   # File foo is not sector size aligned, 127K.
   xfs_io -f -c "pwrite -S 0xab 0 3" \
             -c "pwrite -S 0xcd 3 130042" \
             -c "pwrite -S 0xef 130045 3" $MNT/foo

   # Now do an fallocate that increases the size of foo from 127K to 128K.
   xfs_io -c "falloc 0 128K " $MNT/foo

   btrfs subvolume snapshot -r $MNT $MNT/snap

   btrfs send --compressed-data -f /tmp/send.stream $MNT/snap

   echo -e "\nFile data in the original filesystem:\n"
   od -A d -t x1 $MNT/snap/foo

   umount $MNT
   mkfs.btrfs -f $DEV &> /dev/null || echo "MKFS failed!"
   mount $DEV $MNT

   btrfs receive --force-decompress -f /tmp/send.stream $MNT

   echo -e "\nFile data in the new filesystem:\n"
   od -A d -t x1 $MNT/snap/foo

   umount $MNT

Running the reproducer gives:

   $ ./test.sh
   (...)
   File data in the original filesystem:

   0000000 ab ab ab cd cd cd cd cd cd cd cd cd cd cd cd cd
   0000016 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd
   *
   0130032 cd cd cd cd cd cd cd cd cd cd cd cd cd ef ef ef
   0130048 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   *
   0131072
   At subvol snap

   File data in the new filesystem:

   0000000 ab ab ab cd cd cd cd cd cd cd cd cd cd cd cd cd
   0000016 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd
   *
   0130032 cd cd cd cd cd cd cd cd cd cd cd cd cd ef ef ef
   0130048 cd cd cd cd 00 00 00 00 00 00 00 00 00 00 00 00
   0130064 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   *
   0131072

The are 4 bytes with a value of 0xcd instead of 0x00, at file offset
127K (130048).

Fix this by explicitly zeroing out the part of the output buffer that was
not used after decompressing with zstd.

The decompression of compressed extents, sent when using the send v2
stream, happens in the following cases:

1) By explicitly passing --force-decompress to the receive command, as in
   the reproducer above;

2) Calling the BTRFS_IOC_ENCODED_WRITE ioctl failed with -ENOTTY, meaning
   the kernel on the receiving side is old and does not implement that
   ioctl;

3) Calling the BTRFS_IOC_ENCODED_WRITE ioctl failed with -ENOSPC;

4) Calling the BTRFS_IOC_ENCODED_WRITE ioctl failed with -EINVAL.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 cmds/receive.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/cmds/receive.c b/cmds/receive.c
index a016fe4e..1d623ae3 100644
--- a/cmds/receive.c
+++ b/cmds/receive.c
@@ -1080,6 +1080,15 @@ static int decompress_zstd(struct btrfs_receive *rctx, const char *encoded_buf,
 			return -EIO;
 		}
 	}
+
+	/*
+	 * Zero out the unused part of the output buffer.
+	 * At least with zstd 1.5.2, the decompression can leave some garbage
+	 * at/beyond the offset out_buf.pos.
+	 */
+	if (out_buf.pos < out_buf.size)
+		memset(unencoded_buf + out_buf.pos, 0, out_buf.size - out_buf.pos);
+
 	return 0;
 }
 #endif
-- 
2.35.1

