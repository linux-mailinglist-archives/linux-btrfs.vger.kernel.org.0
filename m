Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC2F5E5EC6
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Sep 2022 11:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiIVJlr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Sep 2022 05:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiIVJlq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Sep 2022 05:41:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16892CF48A;
        Thu, 22 Sep 2022 02:41:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C2744219BF;
        Thu, 22 Sep 2022 09:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1663839703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=kCFTHf7Fe/qWuqQvgPCacPSJLPuKeb4UkBz9qexYCxo=;
        b=mhWZ5bthExsl2Q7ahlmJSFfT40xU89xgH4h4KVFv4JlM1WSHxESckpjECnbJPWLXMlt/C8
        rJuioFTpg2OZ+7NHvFvq8iW5/SqXfOFGDgS+1Xayc1bbe7H3zM8gbjShdEyb+dVPuCJUap
        pH6UQ2IQNvaANlZh9cgFfXYxcoDx894=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7AA1C1346B;
        Thu, 22 Sep 2022 09:41:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ovzBCtYtLGMSBwAAMHmgww
        (envelope-from <wqu@suse.com>); Thu, 22 Sep 2022 09:41:42 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH] btrfs/253: update the data chunk size to the correct one
Date:   Thu, 22 Sep 2022 17:41:23 +0800
Message-Id: <20220922094123.98330-1-wqu@suse.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
After kernel commit 5da431b71d4b ("btrfs: fix the max chunk size and
stripe length calculation") the test case btrfs/253 will always fail.

[CAUSE]
Btrfs calculates the to-be-allocated chunk size using both
chunk and stripe size limits.

By default data chunk is limited to 10G, while data stripe size limit
is only 1G.
Thus the real chunk size limit would be:

  min(num_data_devices * max_stripe_size, max_chunk_size)

For single disk case (the test case), the value would be:

  min(        1        *       1G       ,       10G) = 1G.

The test case can only pass during a small window:

- Commit f6fca3917b4d ("btrfs: store chunk size in space-info struct")

  This changed the max chunk size limit to 1G, which would cause way
  more chunks for profiles like RAID0/10/5/6, thus it is considered as
  a regression.

- Commit 5da431b71d4b ("btrfs: fix the max chunk size and stripe length calculation")

  This is the fix for above regression, which reverts the data chunk
  limit back to 10G.

[FIX]
Fix the failure by introducing a hardcoded expected data chunk size (1G).

Since the test case has fixed fs size (10G) and is only utilizing one
disk, that 1G size will work for all possible data profiles (SINGLE and
DUP).

The more elegant solution is to export stripe size limit through sysfs
interfaces, but that would take at least 2 kernel cycles.

For now, just use a hotfix to make the test case work again.

Since we are here, also remove the leading "t" in the error message.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/253 | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/tests/btrfs/253 b/tests/btrfs/253
index c746f41e..5fbce070 100755
--- a/tests/btrfs/253
+++ b/tests/btrfs/253
@@ -107,7 +107,21 @@ SCRATCH_BDEV=$(_real_dev $SCRATCH_DEV)
 
 # Get chunk sizes.
 echo "Capture default chunk sizes."
-FIRST_DATA_CHUNK_SIZE_B=$(_get_fs_sysfs_attr ${SCRATCH_BDEV} allocation/data/chunk_size)
+
+# The sysfs interface has only exported chunk_size (10G by default),
+# but no stripe_size (1G by default) exported.
+#
+# Btrfs calculate the real chunk to be allocated using both limits,
+# Thus the default 10G chunk size can only be fulfilled by something
+# like 10 disk RAID0
+#
+# The proper solution should be exporting the stripe_size limit too,
+# but that may take several cycles, here we just use hard coded 1G
+# as the expected chunk size.
+FIRST_DATA_CHUNK_SIZE_B=$((1024 * 1024 * 1024))
+
+# For metadata, we are safe to use the exported value, as the default
+# metadata chunk size limit is already smaller than its stripe size.
 FIRST_METADATA_CHUNK_SIZE_B=$(_get_fs_sysfs_attr ${SCRATCH_BDEV} allocation/metadata/chunk_size)
 
 echo "Orig Data chunk size    = ${FIRST_DATA_CHUNK_SIZE_B}"     >> ${seqres}.full
@@ -226,7 +240,7 @@ FIRST_METADATA_CHUNK_SIZE_MB=$(expr ${FIRST_METADATA_CHUNK_SIZE_B} / 1024 / 1024
 
 # if [[ $(expr ${FIRST_DATA_CHUNK_SIZE_MB} + ${DATA_SIZE_START_MB}) -ne $(expr ${FIRST_DATA_SIZE_MB}) ]]; then
 if [[ $(expr ${FIRST_DATA_CHUNK_SIZE_MB} + ${DATA_SIZE_START_MB}) -ne ${FIRST_DATA_SIZE_MB} ]]; then
-	echo "tInitial data allocation not correct."
+	echo "Initial data allocation not correct."
 fi
 
 if [[ $(expr ${FIRST_METADATA_CHUNK_SIZE_MB} + ${METADATA_SIZE_START_MB}) -ne ${FIRST_METADATA_SIZE_MB} ]]; then
-- 
2.37.2

