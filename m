Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8055046F0
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 Apr 2022 09:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233557AbiDQHde (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 17 Apr 2022 03:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbiDQHdd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 17 Apr 2022 03:33:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2F319C05
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Apr 2022 00:30:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4C7771F38C
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Apr 2022 07:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650180658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZtFgdtzDrEDqF13+UZeeHesmDwYdeH0D4TroTjTp/2s=;
        b=duj7lttQtItsX7TSLboYuDsd55aZEaHMsquU/8BZRJS3laqnbm+k1sNcDAqcWkVSpqgqre
        Nr4KSfBiv18R8ogQf/I6tZrdkTrTr1tOjGk61XwUVES80K3AxNH8xZ78xnDS6LGs9p7XQ7
        XSElLwVGh1tR3dx9fd9vXRkR4nWmW5Q=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8B54F13ACB
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Apr 2022 07:30:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uHhhEzHCW2JvVAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Apr 2022 07:30:57 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs-progs: fsck-tests: check warning for seed and sprouted filesystems
Date:   Sun, 17 Apr 2022 15:30:36 +0800
Message-Id: <c1c97aca3ca89edfb23788858d186a50ed80d488.1650180472.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1650180472.git.wqu@suse.com>
References: <cover.1650180472.git.wqu@suse.com>
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

Previously we had a bug that btrfs check would report false warning for
a sprouted filesystem.

So this patch will add a new test case to make sure neither seed nor
and sprouted filesystem will cause such false warning.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 .../fsck-tests/057-seed-false-alerts/test.sh  | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100755 tests/fsck-tests/057-seed-false-alerts/test.sh

diff --git a/tests/fsck-tests/057-seed-false-alerts/test.sh b/tests/fsck-tests/057-seed-false-alerts/test.sh
new file mode 100755
index 000000000000..3a442c1202d0
--- /dev/null
+++ b/tests/fsck-tests/057-seed-false-alerts/test.sh
@@ -0,0 +1,51 @@
+#!/bin/bash
+#
+# Make sure "btrfs check" won't report false alerts on sprouted filesystems
+#
+
+source "$TEST_TOP/common"
+
+check_prereq btrfs
+check_prereq mkfs.btrfs
+check_prereq btrfstune
+check_global_prereq losetup
+
+setup_loopdevs 2
+prepare_loopdevs
+dev1=${loopdevs[1]}
+dev2=${loopdevs[2]}
+TEST_DEV=$dev1
+
+setup_root_helper
+
+run_check $SUDO_HELPERS "$TOP/mkfs.btrfs" -f $dev1
+run_check $SUDO_HELPERS "$TOP/btrfstune" -S1 $dev1
+run_check_mount_test_dev
+run_check $SUDO_HELPERS "$TOP/btrfs" device add -f $dev2 $TEST_MNT
+
+# Here we can not use umount helper, as it uses the seed device to do the
+# umount. We need to manually unmout using the mount point
+run_check $SUDO_HELPERS umount $TEST_MNT
+
+seed_output=$(_mktemp --tmpdir btrfs-progs-seed-check-stdout.XXXXXX)
+sprouted_output=$(_mktemp --tmpdir btrfs-progs-sprouted-check-stdout.XXXXXX)
+
+# The false alerts are just warnings, so we need to save and filter
+# the output
+run_check_stdout "$TOP/btrfs" check "$dev1" >> "$seed_output"
+run_check_stdout "$TOP/btrfs" check "$dev2" >> "$sprouted_output"
+
+# There should be no warning for both seed and sprouted fs
+if grep -q "WARNING" "$seed_output"; then
+	cleanup_loopdevs
+	rm -f -- "$seed_output" "$sprouted_output"
+	_fail "false alerts detected for seed fs"
+fi
+if grep -q "WARNING" "$sprouted_output"; then
+	cleanup_loopdevs
+	rm -f -- "$seed_output" "$sprouted_output"
+	_fail "false alerts detected for sprouted fs"
+fi
+
+cleanup_loopdevs
+rm -f -- "$seed_output" "$sprouted_output"
-- 
2.35.1

