Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C6B7C6807
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Oct 2023 10:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235434AbjJLIb2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Oct 2023 04:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233712AbjJLIb1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Oct 2023 04:31:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B34290
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Oct 2023 01:31:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AF22821884
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Oct 2023 08:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1697099483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=s0zaTgrVEMa8EBOAfnwc0ZOXOSYXLFPfgrjGnSPkT0Y=;
        b=O8dsBmBnn3dc/AOqpJFWOkM54koV28raY+feMWGR/D1ckXoq+iVjIBunpsWE0h+vzkmW3x
        ZH2FCUFF/RCZapGmlVmk4ImeFWcy0jzZKRy9fJT40LkIE74I5SZoTlR9m37U2op/ojgkJz
        71XtOuVYVgJOmb4A1hNsNNfIWftBros=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CAA0F139F9
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Oct 2023 08:31:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nY6bINquJ2W2TgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Oct 2023 08:31:22 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: mkfs: do not enlarge the target block device
Date:   Thu, 12 Oct 2023 19:01:04 +1030
Message-ID: <8ce8ead459b46a5b6849077ee50cf526418263da.1697099461.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: 0.90
X-Spamd-Result: default: False [0.90 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         MIME_GOOD(-0.10)[text/plain];
         TO_DN_NONE(0.00)[];
         BROKEN_CONTENT_TYPE(1.50)[];
         PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
         RCPT_COUNT_ONE(0.00)[1];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         MID_CONTAINS_FROM(1.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When running mkfs.btrfs with --rootdir on a block device, and the source
directory contains a sparse file, whose size is larger than the block
size, then mkfs.btrfs would fail:

  # lsblk  /dev/test/test
  NAME      MAJ:MIN RM SIZE RO TYPE MOUNTPOINTS
  test-test 253:0    0  10G  0 lvm
  # mkdir -p /tmp/output
  # truncate -s 20G /tmp/output/file
  # mkfs.btrfs -f --rootdir /tmp/output /dev/test/test
  # sudo mkfs.btrfs  -f /dev/test/scratch1  --rootdir /tmp/output/
  btrfs-progs v6.3.3
  See https://btrfs.readthedocs.io for more information.

  ERROR: unable to zero the output file

[CAUSE]
Mkfs.btrfs would try to zero out the target file according to the total
size of the directory.

However the directory size is calculated using the file size, not the
real bytes taken by the file, thus for such sparse file with holes only,
it would still take 20G.

Then we would use that 20G size to zero out the target file, but if the
target file is a block device, we would fail as we can not enlarge a block
device.

[FIX]
When zeroing the file, we only enlarge it if the target is a regular
file.
Otherwise we warn about the size and continue.

Please note that, since "mkfs.btrfs --rootdir" doesn't handle sparse
file any differently from regular file, above case would still fail due
to ENOSPC, as will write zeros into the target file inside the fs.

Proper handling for sparse files would need a new series of patch to
address.

Issue: #653
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 mkfs/main.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index 5abf7605326c..7d0ffac309e8 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1567,8 +1567,12 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			block_count = device_get_partition_size_fd_stat(fd, &statbuf);
 		source_dir_size = btrfs_mkfs_size_dir(source_dir, sectorsize,
 				min_dev_size, metadata_profile, data_profile);
-		if (block_count < source_dir_size)
-			block_count = source_dir_size;
+		if (block_count < source_dir_size) {
+			if (S_ISREG(statbuf.st_mode))
+				block_count = source_dir_size;
+			else
+				warning("the target device is smaller than the source directory, mkfs may fail");
+		}
 		ret = zero_output_file(fd, block_count);
 		if (ret) {
 			error("unable to zero the output file");
-- 
2.42.0

