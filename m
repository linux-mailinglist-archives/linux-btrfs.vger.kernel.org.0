Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE32C774E73
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Aug 2023 00:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjHHWlA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Aug 2023 18:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjHHWlA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Aug 2023 18:41:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8238AFE
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Aug 2023 15:40:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3BC4A220F4
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Aug 2023 22:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691534458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TN1iAzD1c46swHcK3wbG5q+6/0YrH8TH9/ePZT6UiMo=;
        b=axuxxvATvJtqA/fx6RGYZur171A6/8nngSojmn6tuVJTJvUcVRzwvVcIlvVGssyrhRyxVl
        Gg4aAKWEYihk3c188VzW6idZyvWbm3+o6PA992VRCn7g/C4XbTQXcjhcggVNWQbT4/Joxu
        ItspVWWEBT7ThucQqteBRd8n1RcKvYg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 91470139D1
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Aug 2023 22:40:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0OgMF3nE0mQICgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Aug 2023 22:40:57 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/4] btrfs-progs: tests/mkfs/005: use udevadm settle to avoid false alerts
Date:   Wed,  9 Aug 2023 06:40:41 +0800
Message-ID: <688da51813559124605fca0f67c178095baca8d2.1691533896.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691533896.git.wqu@suse.com>
References: <cover.1691533896.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

