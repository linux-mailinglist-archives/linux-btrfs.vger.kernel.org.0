Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44F84EA942
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Mar 2022 10:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbiC2Ica (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Mar 2022 04:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbiC2Ic3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Mar 2022 04:32:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80AC47058
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Mar 2022 01:30:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 412581FD50;
        Tue, 29 Mar 2022 08:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1648542644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S3GGRTLERp7dw/MNrn1+gZP8VxEP4EY1Kzfoa/hTdmI=;
        b=Ka7vw9i9kwv0wnxlnFYvTIFACM1wquEVdx45HZXVqBgdcdw+lyIY7lChx19VDRnwAJ59tf
        Mj+17Y13E8vOQOiuy3LZGyK8V4XrCCwyD8lf5ORecxKx2iIu+agqKUynfdS9Kdw3DOdzro
        erlLoabXLxh1Bj86XBD1VLwKAC38Xnc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EDCF513AB1;
        Tue, 29 Mar 2022 08:30:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OCceN7PDQmLbLAAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 29 Mar 2022 08:30:43 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 2/2] btrfs-progs: tests: Add test for fi show
Date:   Tue, 29 Mar 2022 11:30:42 +0300
Message-Id: <20220329083042.1248264-2-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220329083042.1248264-1-nborisov@suse.com>
References: <20220329083042.1248264-1-nborisov@suse.com>
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

Add a test to ensure that 'btrfs fi show' on a mounted filesyste, which
has a missing device will explicitly print which device is missing.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
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

