Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B6C6C4265
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Mar 2023 06:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjCVFwd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Mar 2023 01:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjCVFwd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Mar 2023 01:52:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A04584BF;
        Tue, 21 Mar 2023 22:52:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 89BD7209D6;
        Wed, 22 Mar 2023 05:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679464349; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=jPZslnDwVjzNh6EtAsVCPs4v3VPh7pdfk1NItZ+w3Ik=;
        b=i+e04Do5kPMlGzWuaqhVXcjmlQSOQNYBFanot4wJAH64ZoZHOXZ0kmSpshDEYrQKQdO8dT
        dWAZ21wP3ZI5xyYZO4kMOEY1Uq6SYxVtm9oVGg7NYNJ52XRO4KQP786t8sTaq4FqtqvnxD
        wapT2PPu87g/JDSa/Lluyd4JmN8fxrc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7A66013582;
        Wed, 22 Mar 2023 05:52:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JziEEZyXGmQTBAAAMHmgww
        (envelope-from <wqu@suse.com>); Wed, 22 Mar 2023 05:52:28 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Cc:     Hector Martin <marcan@marcan.st>
Subject: [PATCH] btrfs/246: skip the test if the tested btrfs doesn't support inline extents creation
Date:   Wed, 22 Mar 2023 13:52:11 +0800
Message-Id: <dc3eb7e8a9286b2eab1fd1829e56428300d51a5a.1679464212.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[FALSE ALERT]
If test case btrfs/246 is executed with a 16K page sized system (like
some aarch64 SoCs) using 4K sector size (would be the new default), the
test case would fail with output mismatch:

  btrfs/246 1s ... - output mismatch (see ~/xfstests-dev/results//btrfs/246.out.bad)
      --- tests/btrfs/246.out	2022-11-24 19:53:53.158470844 +0800
      +++ ~/xfstests-dev/results//btrfs/246.out.bad	2023-03-22 13:27:34.975796048 +0800
      @@ -3,3 +3,5 @@
       0ca3bfdeda1ef5036bfa5dad078a9f15724e79cf296bd4388cf786bfaf4195d0  SCRATCH_MNT/foobar
       sha256sum after mount cycle
       0ca3bfdeda1ef5036bfa5dad078a9f15724e79cf296bd4388cf786bfaf4195d0  SCRATCH_MNT/foobar
      +no inline extent found
      +no compressed extent found
      ...
      (Run 'diff -u ~/xfstests-dev/tests/btrfs/246.out ~/xfstests-dev/results//btrfs/246.out.bad'  to see the entire diff)

[CAUSE]
For current btrfs subpage support, there are still some limitations:

- No compressed write if the range is not fully page aligned
- No inline extents creation
  Reading inline extents is still supported

Thus we won't create such inlined compressed extent at all.

[FIX]
Just skip the test case if we can not even create a regular inline
extent.

This is done by a new require helper,
_require_btrfs_inline_extent_creation(), which would detect if btrfs can
even create an uncompressed inlined extent.

Reported-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 common/btrfs    | 22 ++++++++++++++++++++++
 tests/btrfs/246 |  3 +++
 2 files changed, 25 insertions(+)

diff --git a/common/btrfs b/common/btrfs
index 7c32360376c2..344509ce300c 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -499,6 +499,28 @@ _require_btrfs_support_sectorsize()
 		_notrun "sectorsize $sectorsize is not supported"
 }
 
+_require_btrfs_inline_extents_creation()
+{
+	local ino
+
+	_require_xfs_io_command fiemap
+	_require_scratch
+
+	_scratch_mkfs &> /dev/null
+	_scratch_mount -o max_inline=2048,compress=none
+	_pwrite_byte 0x00 0 1024 $SCRATCH_MNT/inline &> /dev/null
+	sync
+	$XFS_IO_PROG -c "fiemap -v" $SCRATCH_MNT/inline | tail -n 1 > $tmp.fiemap
+	_scratch_unmount
+	# 0x200 means inlined, 0x100 means not block aligned, 0x1 means
+	# the last extent.
+	if ! grep -q "0x301" $tmp.fiemap; then
+		rm -f -- $tmp.fiemap
+		_notrun "No inline extent creation support, maybe subpage?"
+	fi
+	rm -f -- $tmp.fiemap
+}
+
 _btrfs_metadump()
 {
 	local device="$1"
diff --git a/tests/btrfs/246 b/tests/btrfs/246
index 0dcc7c0d1a43..2fe54f959048 100755
--- a/tests/btrfs/246
+++ b/tests/btrfs/246
@@ -23,6 +23,9 @@ _cleanup()
 _supported_fs btrfs
 _require_scratch
 
+# If it's subpage case, we don't support inline extents creation for now.
+_require_btrfs_inline_extents_creation
+
 _scratch_mkfs > /dev/null
 _scratch_mount -o compress,max_inline=2048
 
-- 
2.39.2

