Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A31CE406887
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Sep 2021 10:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbhIJIe6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Sep 2021 04:34:58 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57146 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbhIJIe5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Sep 2021 04:34:57 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5B59920209;
        Fri, 10 Sep 2021 08:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631262826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JwPDu4/Qr8DhYSdJSEQVs0TiF/mkzw6366sMYc9l0iA=;
        b=MYDF6dXmeT7wRV67M9zjdv9gabzYVoozXkd2JnfUShFm0JShgcyExp2e4FF43B8TL0sYp2
        d/yFIBJmjMTfqS1HBSpZnQmQmZab80AW7x5fT/n4qkroe5nxYDDpO5ylZL9rOfH0D2jdLW
        SxxbPu71SA7PyjgrCam13Lc8EfL5wwY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2BBF313D15;
        Fri, 10 Sep 2021 08:33:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aM2kB2oYO2EBVAAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 10 Sep 2021 08:33:46 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 2/2] btrfs-progs: tests: Add test for fi show
Date:   Fri, 10 Sep 2021 11:33:44 +0300
Message-Id: <20210910083344.1876661-2-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210910083344.1876661-1-nborisov@suse.com>
References: <20210910083344.1876661-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add a test to ensure that 'btrfs fi show' on a mounted filesyste, which
has a missing device will explicitly print which device is missing.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
V2:
 * Adjust output to detect

 tests/cli-tests/016-fi-show-missing/test.sh | 35 +++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100755 tests/cli-tests/016-fi-show-missing/test.sh

diff --git a/tests/cli-tests/016-fi-show-missing/test.sh b/tests/cli-tests/016-fi-show-missing/test.sh
new file mode 100755
index 000000000000..e24a85d05410
--- /dev/null
+++ b/tests/cli-tests/016-fi-show-missing/test.sh
@@ -0,0 +1,35 @@
+#!/bin/bash
+#
+# Test that if a device is missing for a mounted filesystem, btrfs fi show will
+# show which device exactly is missing.
+
+source "$TEST_TOP/common"
+
+check_prereq mkfs.btrfs
+check_prereq btrfs
+
+setup_root_helper
+setup_loopdevs 2
+prepare_loopdevs
+
+dev1=${loopdevs[1]}
+dev2=${loopdevs[2]}
+
+run_check $SUDO_HELPER "$TOP"/mkfs.btrfs -f -draid1 $dev1 $dev2
+# move the device, changing its path, simulating the device being missing
+mv $dev2 /dev/loop-non-existent
+
+run_check $SUDO_HELPER mount -o degraded $dev1 $TEST_MNT
+
+if ! run_check_stdout $SUDO_HELPER "$TOP"/btrfs fi show $TEST_MNT | \
+	grep -q "$dev2 MISSING"; then
+
+	_fail "Didn't find exact missing device"
+fi
+
+mv /dev/loop-non-existent $dev2
+
+run_check $SUDO_HELPER umount $TEST_MNT
+
+cleanup_loopdevs
+
--
2.17.1

