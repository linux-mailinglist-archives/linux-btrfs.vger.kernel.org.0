Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854A85A5C1E
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Aug 2022 08:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbiH3GuL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Aug 2022 02:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbiH3GuH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Aug 2022 02:50:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B339E2B275
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Aug 2022 23:50:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6EE4C1F8B8
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Aug 2022 06:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1661842205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AH5n0CZ9vb+WY3PNW8kp+8VRmgB5XT0mogjo1tUSNIY=;
        b=YX7MBMbwPYWVeYu9x5qFKs/rEpTkpd+gu/GjYYTTK2q5G2xliTpbFaNnqEzVWPOxKWNqkR
        sJH++IhmlMH1lRpvP2/ZOLjAQrxU5oxodDPiFEUh7oD87GPvUVGrFNS/t0IViGPtP3FfpC
        ehku7csRWZHRVGxQ+wm5eeJJhWBpsBk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 82F2913ACF
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Aug 2022 06:50:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mMVcExyzDWO7JgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Aug 2022 06:50:04 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs-progs: fsck-tests: add test case for shrunk device
Date:   Tue, 30 Aug 2022 14:49:43 +0800
Message-Id: <2c8864cea4c8f3685967f31b6fee124f56c7ec93.1661841983.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1661841983.git.wqu@suse.com>
References: <cover.1661841983.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The test case just create a btrfs on a file backed loop block device,
then shrink the file (and its loop block device), then make sure btrfs
check can detect such shrunk device.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/fsck-tests/059-shrinked-device/test.sh | 32 ++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100755 tests/fsck-tests/059-shrinked-device/test.sh

diff --git a/tests/fsck-tests/059-shrinked-device/test.sh b/tests/fsck-tests/059-shrinked-device/test.sh
new file mode 100755
index 000000000000..672219f9c3f3
--- /dev/null
+++ b/tests/fsck-tests/059-shrinked-device/test.sh
@@ -0,0 +1,32 @@
+#!/bin/bash
+#
+# Make sure "btrfs check" can detect device smaller than its total_bytes
+# in device item
+#
+
+source "$TEST_TOP/common"
+
+setup_root_helper
+
+file="img"
+# Allocate an initial 1G file for testing.
+truncate -s0 "$file"
+truncate -s1g "$file"
+
+dev=$(run_check_stdout $SUDO_HELPER losetup --find --show "$file")
+
+run_check "$TOP/mkfs.btrfs" -f "$dev"
+
+
+# The original device size from prepare_loopdevs is 2G.
+# Since the fs is empty, shrinking it to 996m will not cause any
+# lose of metadata.
+run_check $SUDO_HELPER losetup -d "$dev"
+truncate -s 996m "$file"
+dev=$(run_check_stdout $SUDO_HELPER losetup --find --show "$file")
+
+run_mustfail "btrfs check should detect errors in device size" \
+	"$TOP/btrfs" check "$dev"
+
+losetup -d "$dev"
+rm -- "$file"
-- 
2.37.2

