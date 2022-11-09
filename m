Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32DE6223F3
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Nov 2022 07:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiKIGW5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Nov 2022 01:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKIGW5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Nov 2022 01:22:57 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CD51A05C;
        Tue,  8 Nov 2022 22:22:56 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C08C322472;
        Wed,  9 Nov 2022 06:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667974974; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=0UxyrcqisZIWT/otuLY9YhgqoPwkHuNsP0dtl/NM5BA=;
        b=C7i8geieuCyQPjCqcp0QRIyHA+zZZMdEFxKLmyBJAwDZRe/Zz22MbeQ8WAJrcKUaGXdXHf
        79A+08dMI/gKLLINJ4rruUzv3Zp2cckreGgstb1HVkVhgMvXxF8tLfgDWQANO5ZDrmS0WK
        C8tFabAcbW35kHPu0eYVTreN9b21z6s=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DD39F1331F;
        Wed,  9 Nov 2022 06:22:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id s9MxKT1Ha2OFEgAAMHmgww
        (envelope-from <wqu@suse.com>); Wed, 09 Nov 2022 06:22:53 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH] fstests: filter.btrfs: handle detailed missing device report better
Date:   Wed,  9 Nov 2022 14:22:36 +0800
Message-Id: <20221109062236.42253-1-wqu@suse.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[FAILURES]
The following btrfs test cases failed with newer btrfs-progs:

- btrfs/197
- btrfs/198
- btrfs/254

They all fail due to output mismatch like the following:

     Label: none  uuid: <UUID>
     	Total devices <NUM> FS bytes used <SIZE>
     	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
    -	*** Some devices missing
    +	devid <DEVID> size 0 used 0 path  MISSING

[CAUSE]
Since btrfs-progs commit 957a79c9b016 ("btrfs-progs: fi show: print
missing device for a mounted file system"), we output the detailed info
of a missing device if "btrfs filesystem show" is executed using
"-m <mnt>" option.

Such detailed output no longer follows the old format, thus causing the
output mismatch.

[FIX]
Update _filter_btrfs_filesystem_show() to handle detailed missing
device by:

- Buffer the output first

- Output the first two lines
  Which is always label/uuid and the total device accounting.

- Replace the detailed missing device line with old output

- Sort (in reverse order) and uniq the device list

By this we can handle both old and new output correctly.
Although this means we lacks the ability to detect mutltiple missing
devices, thankfully the involved test cases are not checking this yet.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 common/filter.btrfs | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/common/filter.btrfs b/common/filter.btrfs
index d4169cc6..c570d366 100644
--- a/common/filter.btrfs
+++ b/common/filter.btrfs
@@ -35,7 +35,17 @@ _filter_btrfs_filesystem_show()
 	_filter_size | _filter_btrfs_version | _filter_devid | \
 	_filter_zero_size | \
 	sed -e "s/\(Total devices\) $NUMDEVS/\1 $NUM_SUBST/g" | \
-	uniq
+	uniq > $tmp.btrfs_filesystem_show
+
+	# The first two lines are Label/UUID and total devices
+	head -n 2 $tmp.btrfs_filesystem_show
+
+	# The remaining is the device list, first filter out the detailed
+	# missing device to the generic one.
+	# Then sort and uniq the result
+	tail -n +3 $tmp.btrfs_filesystem_show | \
+	sed -e "s/devid <DEVID> size 0 used 0 path  MISSING/*** Some devices missing/" | \
+	sort -r | uniq
 }
 
 # This eliminates all numbers, and shows only unique lines,
-- 
2.38.0

