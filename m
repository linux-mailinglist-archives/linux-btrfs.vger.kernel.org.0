Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A87F3FEBDB
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Sep 2021 12:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbhIBKHp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Sep 2021 06:07:45 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56746 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbhIBKHo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Sep 2021 06:07:44 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7FA962032D;
        Thu,  2 Sep 2021 10:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630577205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E7EFweSKwSeuIqNHM/4vRMALDQCPv5XjNPBTa6l/sDw=;
        b=PLLmKVKnWKNwatFlc8zeNx2u5yzirim9FJkIEm5D28ORjuuBnwa2qFFTWSbqLZxen1kHW9
        a+s5f4jhZISBhh18HUFdx5poRNf7P6HMU+8SbgCZpxWGRGMzsGdO3FbIsmuPEuckNpA+Vl
        7DF9yPgJxNoe/OAkz2CHynN/Y9E49Pk=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 527011371C;
        Thu,  2 Sep 2021 10:06:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id YPWnETWiMGHGYQAAGKfGzw
        (envelope-from <nborisov@suse.com>); Thu, 02 Sep 2021 10:06:45 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 2/2] btrfs-progs: tests: Add test for fi show
Date:   Thu,  2 Sep 2021 13:06:43 +0300
Message-Id: <20210902100643.1075385-2-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210902100643.1075385-1-nborisov@suse.com>
References: <20210902100643.1075385-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add a test to ensure that 'btrfs fi show' on a mounted filesyste, which
has a missing device will explicitly print which device is missing.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 tests/cli-tests/016-fi-show-missing/test.sh | 35 +++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100755 tests/cli-tests/016-fi-show-missing/test.sh

diff --git a/tests/cli-tests/016-fi-show-missing/test.sh b/tests/cli-tests/016-fi-show-missing/test.sh
new file mode 100755
index 000000000000..9df7afd5af94
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
+	grep -q "$dev2 \*\*\*MISSING\*\*\*"; then
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

