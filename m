Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E390A453383
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Nov 2021 15:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237024AbhKPOFa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Nov 2021 09:05:30 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:40082 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237052AbhKPOFH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Nov 2021 09:05:07 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C66571FD26;
        Tue, 16 Nov 2021 14:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637071327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=CuCIzIuGNRzzGoUqVHZSkCdsgKMNLnpFRPkYyppnPTs=;
        b=Uk2Nw2mYf1+3qrZlCxqi0CUIos14G+0m0Tuu6qRSRzsa4DF7s94BUI/jzv3iAp/d7A9bSt
        tUINt8N189+CcFRXMKRj2zW8f4Psa1Dhp+GK41t40I2GZIklGIQM0qjMvjgtD+Rh54cPC3
        /2C4Tzo2P9oaRT1YhO+QmzOCpbyRuNU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 87D6113C22;
        Tue, 16 Nov 2021 14:02:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EzyCHt+5k2E2DQAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 16 Nov 2021 14:02:07 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] Fix calculation of chunk size for RAID1/DUP profiles
Date:   Tue, 16 Nov 2021 16:02:06 +0200
Message-Id: <20211116140206.291252-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Current formula calculates the stripe size, however that's not what we want
in the case of RAID1/DUP profiles. In those cases since chunkc are mirrored
across devices we want the full size of the chunk. Without this patch the
'btrfs fi usage' output from an fs which is using RAID1 is:

	<snip>

	Data,RAID1: Size:2.00GiB, Used:1.00GiB (50.03%)
	   /dev/vdc	   1.00GiB
	   /dev/vdf	   1.00GiB

	Metadata,RAID1: Size:256.00MiB, Used:1.34MiB (0.52%)
	   /dev/vdc	 128.00MiB
	   /dev/vdf	 128.00MiB

	System,RAID1: Size:8.00MiB, Used:16.00KiB (0.20%)
	   /dev/vdc	   4.00MiB
	   /dev/vdf	   4.00MiB

	Unallocated:
	   /dev/vdc	   8.87GiB
	   /dev/vdf	   8.87GiB


So a 2 gigabyte RAID1 chunk actually will take up 4 gigabytes on the actual disks
2 each. In this case this is being miscalculated as taking up 1gb on each device.

This also leads to erroneously calculated unallocated space. The correct output
in this case is:

	<snip>

	Data,RAID1: Size:2.00GiB, Used:1.00GiB (50.03%)
	   /dev/vdc	   2.00GiB
	   /dev/vdf	   2.00GiB

	Metadata,RAID1: Size:256.00MiB, Used:1.34MiB (0.52%)
	   /dev/vdc	 256.00MiB
	   /dev/vdf	 256.00MiB

	System,RAID1: Size:8.00MiB, Used:16.00KiB (0.20%)
	   /dev/vdc	   8.00MiB
	   /dev/vdf	   8.00MiB

	Unallocated:
	   /dev/vdc	   7.74GiB
	   /dev/vdf	   7.74GiB


Fix it by only utilising the chunk formula for profiles which are not RAID1/DUP.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 cmds/filesystem-usage.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
index 6195f633da44..5f2289a9b40d 100644
--- a/cmds/filesystem-usage.c
+++ b/cmds/filesystem-usage.c
@@ -805,11 +805,17 @@ int load_chunk_and_device_info(int fd, struct chunk_info **chunkinfo,
  */
 static u64 calc_chunk_size(struct chunk_info *ci)
 {
-	u32 div;
+	u32 div = 1;

-	/* No parity + sub_stripes, so order of "-" and "/" does not matter */
-	div = (ci->num_stripes - btrfs_bg_type_to_nparity(ci->type)) /
-	      btrfs_bg_type_to_sub_stripes(ci->type);
+	/*
+	 * The formula doesn't work for RAID1/DUP types, we should just return the
+	 * chunk size
+	 */
+	if (!(ci->type & (BTRFS_BLOCK_GROUP_RAID1_MASK|BTRFS_BLOCK_GROUP_DUP))) {
+		/* No parity + sub_stripes, so order of "-" and "/" does not matter */
+		div = (ci->num_stripes - btrfs_bg_type_to_nparity(ci->type)) /
+			btrfs_bg_type_to_sub_stripes(ci->type);
+	}

 	return ci->size / div;
 }
--
2.17.1

