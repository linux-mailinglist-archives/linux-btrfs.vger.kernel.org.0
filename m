Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74FC06FBC0E
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 May 2023 02:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjEIAnq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 May 2023 20:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjEIAnp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 May 2023 20:43:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6385FD2
        for <linux-btrfs@vger.kernel.org>; Mon,  8 May 2023 17:43:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 74D0221D61
        for <linux-btrfs@vger.kernel.org>; Tue,  9 May 2023 00:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683593015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eE7JDLlyfDV3d847zACgXkj8fDFKUK18UcwDc6ugll8=;
        b=JnsaulJmXIovRZfKhkxvKP88684ZxhfOS4G0oXyvs67Z5+tjQK+fOag+fNP0o21C9x4Gh9
        l62ywAJCdha3ETFGimG1i2OgyLBbcRDu9KAOVPBgegKf5ZTP+ai1MX5YDt2ClTdr3Hw6B9
        pc2GuGLqwPQyIezl0OLzZow2tLgItTk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BD326134B2
        for <linux-btrfs@vger.kernel.org>; Tue,  9 May 2023 00:43:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IDiRIDaXWWScDgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 09 May 2023 00:43:34 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs-progs: convert: fix bad csum for migrated range.
Date:   Tue,  9 May 2023 08:43:14 +0800
Message-Id: <e311a44285872ad0903feeb1b69bdcab6f50a731.1683592875.git.wqu@suse.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1683592875.git.wqu@suse.com>
References: <cover.1683592875.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
There is a report that btrfs-convert leads to bad csum for the image
file.

The reproducer looks like this:
(note the 64K block size, it's used to force a certain chunk layout)

 # touch test.img
 # truncate -s 10G test.img
 # mkfs.ext4 -b 64K test.img
 # btrfs-convert -N 64K test.img
 # btrfs check --check-data-csum test.img
 Opening filesystem to check...
 Checking filesystem on /home/adam/test.img
 UUID: 39d49537-a9f5-47f1-b6ab-7857707b9133
 [1/7] checking root items
 [2/7] checking extents
 [3/7] checking free space cache
 [4/7] checking fs roots
 [5/7] checking csums against data
 mirror 1 bytenr 4563140608 csum 0x3f1fa0ef expected csum 0xa4c4c072
 mirror 1 bytenr 4563206144 csum 0x55dcf0d3 expected csum 0xa4c4c072
 mirror 1 bytenr 4563271680 csum 0x4491b00a expected csum 0xa4c4c072
 mirror 1 bytenr 4563337216 csum 0x655d1f61 expected csum 0xa4c4c072
 mirror 1 bytenr 4563402752 csum 0xd37114d3 expected csum 0xa4c4c072
 mirror 1 bytenr 4563468288 csum 0x4c2dab30 expected csum 0xa4c4c072
 mirror 1 bytenr 4563533824 csum 0xa80fceed expected csum 0xa4c4c072
 mirror 1 bytenr 4563599360 csum 0xaf610db8 expected csum 0xa4c4c072
 mirror 1 bytenr 4563795968 csum 0x67b3c8a0 expected csum 0xa4c4c072
 ERROR: errors found in csum tree
 [6/7] checking root refs
 ...

[CAUSE]
Above initial failure is for logical bytenr of 4563140608, which is
inside the relocated range of the image file offset [0, 1M).

During convert, we migrate the original image file ranges which would
later be covered by super and other reserved ranges.

The migration happens
- Read out the original data
- Reserve a new file extent
- Write the data back to the file extent
  Note that, the new file extent can be inside some new data chunks,
  thus it's no longer 1:1 mapped.
- Generate the new csum for the new file extent

The problem happens at the last stage. We should read out the data from
the new file extent, but we call read_disk_extent() using the logical
bytenr, however read_disk_extent() is not doing logical -> physical
mapping.

Thus we will read some garbage, not the newly written data, and use
those garbage to generate csum. And caused the above problem.

[FIX]
Instead of read_disk_extent(), call read_data_from_disk(), which would
do the proper logical -> physical mapping, thus would fix the bug.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 convert/main.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/convert/main.c b/convert/main.c
index 941b5ce3244d..46c6dfc571ff 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -191,10 +191,18 @@ static int csum_disk_extent(struct btrfs_trans_handle *trans,
 	if (!buffer)
 		return -ENOMEM;
 	for (offset = 0; offset < num_bytes; offset += blocksize) {
-		ret = read_disk_extent(root, disk_bytenr + offset,
-					blocksize, buffer);
+		u64 read_len = blocksize;
+
+		ret = read_data_from_disk(root->fs_info, buffer,
+					  disk_bytenr + offset, &read_len, 0);
 		if (ret)
 			break;
+		if (read_len == 0) {
+			error("failed to read logical bytenr %llu",
+			      disk_bytenr + offset);
+			ret = -EIO;
+			break;
+		}
 		ret = btrfs_csum_file_block(trans,
 					    disk_bytenr + num_bytes,
 					    disk_bytenr + offset,
-- 
2.40.1

