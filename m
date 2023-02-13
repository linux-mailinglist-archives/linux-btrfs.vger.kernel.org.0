Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCD3693DEC
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Feb 2023 06:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjBMFrr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Feb 2023 00:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjBMFrq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Feb 2023 00:47:46 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39621E04D
        for <linux-btrfs@vger.kernel.org>; Sun, 12 Feb 2023 21:47:44 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E6670205FF
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Feb 2023 05:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676267262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=gKw4L0350f+SpG6vUFkFOOy0DzFtD6/3ky2ygeUEX5Q=;
        b=OVKyCNSMZAOC9jKj7w+3qRr3zfx9lNNoJGUv1ebkH3MbMAVH0XlBvpUvGnMMsiZ24iEwsI
        eCBQFS+MZQskdw4prjZYIVd/a9LJpp9uhuxAswsPRCjqN9l3yidx4rVfnbZuU0PinhSsmA
        nVMl7LfR4K5bYdfegxV6xVbYJqiOVmA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 33CDC13A1F
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Feb 2023 05:47:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id izgTOv3O6WPWdAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Feb 2023 05:47:41 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: tests: misc: fix failure on misc/034
Date:   Mon, 13 Feb 2023 13:47:24 +0800
Message-Id: <20230213054724.35714-1-wqu@suse.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
Test case misc/034 can fail like this:

  ====== RUN CHECK mount /dev/loop16 /home/adam/btrfs-progs/tests/mnt
  mount: /home/adam/btrfs-progs/tests/mnt: wrong fs type, bad option, bad superblock on /dev/loop16, missing codepage or helper program, or other error.
         dmesg(1) may have more information after failed mount system call.
  failed: mount /dev/loop16 /home/adam/btrfs-progs/tests/mnt

And the dmesg looks like this:

  loop16: detected capacity change from 0 to 1024000
  loop17: detected capacity change from 0 to 1024000
  BTRFS: device fsid 593e23af-a7e6-4360-b16a-229f415de697 devid 1 transid 6 /dev/loop16 scanned by mount (79348)
  BTRFS info (device loop16): using crc32c (crc32c-intel) checksum algorithm
  BTRFS info (device loop16): found metadata UUID change in progress flag, clearing
  BTRFS info (device loop16): disk space caching is enabled
  BTRFS error (device loop16): devid 2 uuid cde07de6-db7e-4b34-909e-d3db6e7c0b06 is missing
  BTRFS error (device loop16): failed to read the system array: -2
  BTRFS error (device loop16): open_ctree failed

[CAUSE]
From the dmesg, it shows that although both loopback devices are
properly registered, only one is properly scanned by mount.

Thus the other device is missing, and without "-o degraded" the
filesystem failed to be mounted.

[FIX]
Before we mount the filesystem, also scan them in their passed in order
to properly assemble the device list for mount.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/misc-tests/034-metadata-uuid/test.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/misc-tests/034-metadata-uuid/test.sh b/tests/misc-tests/034-metadata-uuid/test.sh
index b7cb546b..b62cdc10 100755
--- a/tests/misc-tests/034-metadata-uuid/test.sh
+++ b/tests/misc-tests/034-metadata-uuid/test.sh
@@ -191,6 +191,10 @@ failure_recovery() {
 
 	run_check $SUDO_HELPER udevadm settle
 
+	# Scan to make sure btrfs detects both devices before trying to mount
+	run_check $SUDO_HELPER "$TOP/btrfs" device scan $loop1
+	run_check $SUDO_HELPER "$TOP/btrfs" device scan $loop2
+
 	# Mount and unmount, on trans commit all disks should be consistent
 	run_check $SUDO_HELPER mount "$loop1" "$TEST_MNT"
 	run_check $SUDO_HELPER umount "$TEST_MNT"
-- 
2.39.0

