Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BE94F45BA
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 00:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239736AbiDEPDp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Apr 2022 11:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392015AbiDENt3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Apr 2022 09:49:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7345910FCD
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 05:48:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 322AE1F7AD
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 12:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649162938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0KmXwuEewfG0oeTwclLT2n5ZxaTtpBCjb87b2DYrruA=;
        b=XAMVe2FGZHF70OtqdqL8BEq8K5c6cR0oDxcMJlc97VDXrqNJDJ/DHKHlLF3/UNn58HLw5R
        BL5Xi6Koi1pbN+XEGgEtKgk8raCgAwt3p0Cm2CEk2+Cxqa8DNdohaBUhcHC/ucmxE8yuzz
        aHxm6/v0BMguBSFuUMC+UZsZVR3577c=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 849DC13A04
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 12:48:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6J2YE7k6TGJLGgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Apr 2022 12:48:57 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 8/8] btrfs-progs: tests/fsck: add test case for data csum check on raid5
Date:   Tue,  5 Apr 2022 20:48:30 +0800
Message-Id: <33cdbaa1de3160605d0c552497bd02f9ee632f41.1649162174.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1649162174.git.wqu@suse.com>
References: <cover.1649162174.git.wqu@suse.com>
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

Previously 'btrfs check --check-data-csum' will report tons of false
alerts for RAID56.

Add a test case to make sure with the new RAID56 rebuild ability, there
should be no false alerts.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 .../056-raid56-false-alerts/test.sh           | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100755 tests/fsck-tests/056-raid56-false-alerts/test.sh

diff --git a/tests/fsck-tests/056-raid56-false-alerts/test.sh b/tests/fsck-tests/056-raid56-false-alerts/test.sh
new file mode 100755
index 000000000000..b82e999c7740
--- /dev/null
+++ b/tests/fsck-tests/056-raid56-false-alerts/test.sh
@@ -0,0 +1,31 @@
+#!/bin/bash
+#
+# Make sure "btrfs check --check-data-csum" won't report false alerts on RAID56
+# data.
+#
+
+source "$TEST_TOP/common"
+
+check_prereq btrfs
+check_prereq mkfs.btrfs
+check_global_prereq losetup
+
+setup_loopdevs 3
+prepare_loopdevs
+dev1=${loopdevs[1]}
+TEST_DEV=$dev1
+
+setup_root_helper
+
+run_check $SUDO_HELPERS "$TOP/mkfs.btrfs" -f -m raid1 -d raid5 ${loopdevs[@]}
+run_check_mount_test_dev
+
+run_check $SUDO_HELPER dd if=/dev/urandom of="$TEST_MNT/file" bs=16K count=1 \
+	status=noxfer > /dev/null 2>&1
+
+run_check_umount_test_dev
+
+# Check data csum should not report false alerts
+run_check "$TOP/btrfs" check --check-data-csum "$dev1"
+
+cleanup_loopdevs
-- 
2.35.1

