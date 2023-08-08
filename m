Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7439B7746F4
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Aug 2023 21:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234387AbjHHTHt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Aug 2023 15:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjHHTHb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Aug 2023 15:07:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1116E2D1D6
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Aug 2023 09:29:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2ADEE2030C
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Aug 2023 05:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691473944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=TN1iAzD1c46swHcK3wbG5q+6/0YrH8TH9/ePZT6UiMo=;
        b=I5ofDbow/vfUWENnESJYIb7FlxwsJyavQ7asz4gIp+vBF0mmsQxhDyv251baBl5NiNIYwI
        vJssTFhFVREtZ59bPzMKTbVif2BYe3j1LneveMs4DCcfZ7RIjjv7HZujE7SdVuUjFnlM6J
        xno+TEJU1tvidVGfsH0veaB5ugQVIyU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8C46C13910
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Aug 2023 05:52:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8gCuFhfY0WS4NQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Aug 2023 05:52:23 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: tests/mkfs/005: use udevadm settle to avoid false alerts
Date:   Tue,  8 Aug 2023 13:52:06 +0800
Message-ID: <688da51813559124605fca0f67c178095baca8d2.1691473890.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
During my test runs of mkfs-tests, 005-long-device-name-for-ssd failed
with the following error messages:

  ====== RUN CHECK dmsetup remove btrfs-test-with-very-long-name-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQPGc
  device-mapper: remove ioctl on btrfs-test-with-very-long-name-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQPGc  failed: Device or resource busy
  Command failed.
  failed: dmsetup remove btrfs-test-with-very-long-name-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQPGc
  test failed for case 005-long-device-name-for-ssd

[CAUSE]
There seems to be a race between "btrfs inspect dump-super" and the
dmsetup removal.

[FIX]
Add a "udevadm settle" before removing the dm devices.

Also since we're here, use the same "udevadm settle" instead of the
manual sleep to wait for the new dm device to showup.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/mkfs-tests/005-long-device-name-for-ssd/test.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/mkfs-tests/005-long-device-name-for-ssd/test.sh b/tests/mkfs-tests/005-long-device-name-for-ssd/test.sh
index 208698dce243..c32eb3a42def 100755
--- a/tests/mkfs-tests/005-long-device-name-for-ssd/test.sh
+++ b/tests/mkfs-tests/005-long-device-name-for-ssd/test.sh
@@ -24,7 +24,7 @@ loopdev=`run_check_stdout $SUDO_HELPER losetup --find --show img`
 run_check $SUDO_HELPER dmsetup create "$dmname" --table "0 1048576 linear $loopdev 0"
 
 # Setting up the device may need some time to appear
-sleep 5
+run_check $SUDO_HELPER udevadm settle
 if ! [ -b "$dmdev" ]; then
 	_not_run "dm device created but not visible in /dev/mapper"
 fi
@@ -43,6 +43,8 @@ run_check_stdout $SUDO_HELPER "$TOP/mkfs.btrfs" -f "$@" "$dmdev" |
 	grep -q 'SSD detected:.*yes' || _fail 'SSD not detected'
 run_check $SUDO_HELPER "$TOP/btrfs" inspect-internal dump-super "$dmdev"
 
+run_check $SUDO_HELPER udevadm settle
+
 # cleanup
 run_check $SUDO_HELPER dmsetup remove "$dmname"
 run_mayfail $SUDO_HELPER losetup -d "$loopdev"
-- 
2.41.0

